public class Schedulable_SendEmailToLead implements Schedulable{
    
    public void execute(SchedulableContext sc){
        System.debug('---------- Schedulable_SendEmailToLead Class -----------');
        
        List<Lead> leadList = [SELECT Id, FirstName, LastName, Email, Phone
                              FROM Lead
                              WHERE CreatedDate = LAST_N_DAYS:7
                              AND Email = 'saurabh4sfdc@gmail.com'];
        System.debug('leadList : ' + leadList);
        
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
        for(Lead l : leadList){
        	Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{l.Email});
            email.setSenderDisplayName('Lead Schedular Apex');
            email.setInReplyTo('saurabh4sfdc@gmail.com');
            email.setSubject('Lead Acknowledgement From Schedular Apex');
            
            String body = 'Dear ' + l.FirstName + ' ' + l.LastName + ', <br/> <br/>';
            body += 'Update your Contact Details : <br/> <br/>';
            body += 'Thanks, <br/>';
            body += '<b>Sales Team</b>';
            
            email.setHtmlBody(body);
            
            emailList.add(email);
            
            List<Messaging.Email> lst = new List<Messaging.Email>();
        }
        Messaging.sendEmail(emailList);
    }
}