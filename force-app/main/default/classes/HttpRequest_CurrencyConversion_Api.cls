public with sharing class HttpRequest_CurrencyConversion_Api {
    
    public String response      {get;set;}

    public void invoke(){

        // Fetch the ApiKey from the Custom Settings
        Map<String, ApiKeys__c> mapKeys = ApiKeys__c.getAll();
        ApiKeys__c apiK = mapKeys.get('Currency');
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

        // De-Serialize the jsonString
        System.JSONParser jp = JSON.createParser(jsonString);

        Decimal usdValue = 0;

        while(jp.nextToken() != null){
            if(jp.getText() == 'USDINR'){
                jp.nextToken();
                usdValue = jp.getDecimalValue();
            }
        }

        System.debug('usdValue : ' + usdValue);
    }
}