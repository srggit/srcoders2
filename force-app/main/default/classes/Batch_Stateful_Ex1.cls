global class Batch_Stateful_Ex1 implements Database.Batchable<sObject>, Database.Stateful {

    public Map<Id, List<String>> ownerIdAccMap;
    
    global Batch_Stateful_Ex1(){
        System.debug('---------------------Batch_Stateful_Ex1-----------------------');
        ownerIdAccMap = new Map<Id, List<String>>();
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('--------------------- Executing start() -----------------------');
        String query = 'SELECT Id, Name, OwnerId FROM Account';
        System.debug(Database.query(query).size());
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> accList){
		System.debug('-------- Executing execute() ---------');
        System.debug('Account List Size : ' + accList.size());
        
        for(Account acc : accList){
            if(ownerIdAccMap.containsKey(acc.OwnerId)){
                List<String> accNameList = ownerIdAccMap.get(acc.OwnerId);
                accNameList.add(acc.Name);
                ownerIdAccMap.put(acc.OwnerId, accNameList); 
            }
            else{
                List<String> accNameList = new List<String>();
                accNameList.add(acc.Name);
                ownerIdAccMap.put(acc.OwnerId, accNameList); 
            }
        }
        System.debug('ownerIdAccMap : ' + ownerIdAccMap);
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('---------- Executing finish() -----------');
        
        // Get Users and their Email Ids
        Set<Id> userIds = ownerIdAccMap.keySet();
        List<User> userList = [SELECT Id, Name, Email FROM User WHERE Id IN : userIds];
        
        Map<Id, String> mapUserIdEmail = new Map<Id, String>();
        for(User u : userList){
            mapUserIdEmail.put(u.Id, u.Email);
        }
        
        // Prepare Mails
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
        for(Id uId : userIds){
            // Check email limits before sending emails
            System.debug('Limits.getLimitEmailInvocations() : ' + Limits.getLimitEmailInvocations());
            System.debug('Limits.getEmailInvocations() : ' + Limits.getEmailInvocations());
            
            Integer remainingEmails = Limits.getLimitEmailInvocations() - Limits.getEmailInvocations();
            if (remainingEmails == 0) {
                System.debug('Email limit reached, stopping email sends.');
                break;
            }else{
                System.debug('Email limit not reached.');
            }
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        	
            String toEmail = mapUserIdEmail.get(uId);   // We will get Owner email address
            email.setToAddresses(new List<String>{toEmail});
            email.setSenderDisplayName('Batch Stateful Apex.');
            email.setInReplyTo('srcoders01@gmail.com');
            email.setSubject('Your Accounts');
            
            String body = 'All Account of Owner with Email : ' + mapUserIdEmail.get(uId) + '<br/> <br/>';
            
            List<String> accNames = ownerIdAccMap.get(uId);		// We will get all the Account Names
            System.debug('accNames :  ' + accNames);
            
            for(String name : accNames){
                body = body + name + ' <br/> ';  
            }
            email.setHtmlBody(body);
            
            emailList.add(email);
        }
        // Only send emails if within limits
        if (emailList.size() > 0) {
            Messaging.sendEmail(emailList);
            System.debug('Emails Sent');
        } 
        else {
            System.debug('No emails sent, exceeded limit.');
        }

    }
}