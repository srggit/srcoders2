global class Batch_Apex_Ex1 implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('==============Batch_Apex_Ex1=================');
        // Fetch all the Accounts
        // Dynamic Query
        String query = 'SELECT Id, Name, Ownership, type FROM Account WHERE Ownership=\'\' OR Ownership = Null ';
        System.debug('Query Result : ' + query);
        
        List<Account> lstAccounts = Database.query(query);
        System.debug(lstAccounts);
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> accList){
        
        // Update the values of Ownership and 
        for(Account acc : accList){
            acc.Ownership = 'Private';
        }
        update accList;
        
    }
    
    global void finish(Database.BatchableContext bc){
        
        AsyncApexJob jobDetails = [SELECT Id, JobType, TotalJobItems, JobItemsProcessed, NumberOfErrors
                                  FROM AsyncApexJob
                                  WHERE Id =: bc.getJobId()];
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new List<String>{'saurabh4sfdc@gmail.com'});
        email.setSenderDisplayName('Batch Apex');
        email.setInReplyTo('srcoders01@gmail.com');
        email.setSubject('Batch Status.');
        
        String body = 'Dear Admin, <br/>';
        body += 'Batch Operation with JobId : <b>' + jobDetails.Id + '</b> processed Successfully. <br/>';
        body += 'Total JobItems : ' + jobDetails.TotalJobItems + '<br/> ';
        body += 'Number of Errors : ' + jobDetails.NumberOfErrors + '<br/>';
        
        email.setHtmlBody(body);
        
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});
    }
}