global with sharing class HttpRequest_CurrencyConversion_BatchApex implements Database.Batchable<sObject>, Database.AllowsCallouts {
    
    global Database.QueryLocator start(Database.BatchableContext bc){

        String query = 'SELECT Id, Name, Amount, INRValue_APi__c FROM Opportunity';

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Opportunity> oppList){

        Decimal usdValue;

        Map<String, APIKeys__c> mapKeys = APIKeys__c.getAll();
        APIKeys__c apiK = mapKeys.get('Currency');
        String key = apiK.Key__c;

        String url = 'http://apilayer.net/api/live?access_key=' + key;
        url += '&currencies=INR';
        url += '&source=USD';
        url += '&format=1';

        Http http = new Http();

        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        String jsonString = response.getBody();

        System.JSONParser jp = JSON.createParser(jsonString);

        while(jp.nextToken() != null){
            if(jp.getText() == 'USDINR'){
                jp.nextToken();
                usdValue = jp.getDecimalValue();
            }
        }

        System.debug('usdValue : ' + usdValue);
        
        for(Opportunity opp : oppList){
            if(opp.Amount != null){
                opp.INRValue_APi__c = 'Rs.' + opp.Amount * usdValue;
            }
        }

        update oppList;
    }

    global void finish(Database.BatchableContext bc){
        Id jobId = bc.getJobId();
        AsyncApexJob job = [SELECT Id, Status FROM AsyncApexJob WHERE Id =: jobId];

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new List<String>{'saurabh4sfdc@gmail.com'});
        email.setSubject('Batch Acknowledgement');

        String body = 'Batch Job : ' + job.Id + 'Completed with Status : ' + job.Status;
        email.setPlainTextBody(body);

        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email}); 
    }
}