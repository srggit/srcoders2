global class Batch_Apex_Ex2 implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc){
        
        String query = 'SELECT Id, Name, StageName, CreatedDate FROM Opportunity WHERE CreatedDate = LAST_WEEK';
        
        System.debug(Database.query(query));
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Opportunity> oppList){
        for(Opportunity opp : oppList){
            opp.StageName = 'Closed Won';
            opp.CloseDate = System.today();
        }
        update oppList;
    }
    
    global void finish(Database.BatchableContext bc){
        // Send Email
        AsyncApexJob jobDetails = [SELECT Id, JobType, TotalJobItems, JobItemsProcessed, NumberOfErrors
                                  FROM AsyncApexJob
                                  WHERE Id =: bc.getJobId()];
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new List<String>{'saurabh4sfdc@gmail.com'});
        email.setInReplyTo('srcoders01@gmail.com');
        email.setSenderDisplayName('Batch Apex');
        email.setSubject('Batch Status.');
        
        String body = 'Dear Admin, <br/> <br/>';
        body += 'Batch Operation with JobId : <b>' + jobDetails.Id + '</b> processed Successfully. <br/>';
        body += 'Total JobItems : ' + jobDetails.TotalJobItems + '<br/> ';
        body += 'Number of Errors : ' + jobDetails.NumberOfErrors + '<br/>';
        
        email.setHtmlBody(body);
        
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});
        
    }
}