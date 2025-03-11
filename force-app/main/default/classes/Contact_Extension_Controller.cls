public class Contact_Extension_Controller {
	
    public Account acc {get;set;}
    public List<Contact> lstContacts {get;set;}
    
    public Contact_Extension_Controller(ApexPages.StandardController controller){
        
        system.debug('controller : ' + controller);
        
        /* Controller will return only Id of the record, if we want any another fields other than ID
         * we need to add those fields to controller. (But not needed here)
        String[] fields = new String[]{'Name', 'Phone', 'Rating', 'Indsutry', 'Type', 'Website'};
       	controller.addFields(fields);
        */
        
        acc = (Account) controller.getRecord();
        system.debug('acc : ' + acc);
        
        lstContacts = [SELECT Id, FirstName, LastName, Email, Phone, AccountId
                      FROM Contact
                      WHERE AccountId =: acc.Id];
        system.debug('lstContacts : ' + lstContacts);
        
    }
    
    public PageReference sendEmail(){
        PageReference p;
        
        try{
			List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
            
            for(Contact c : lstContacts){
                Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
                msg.setToAddresses(new List<String>{c.Email});
                msg.setSubject('Update Contact Details');
                
                String body = 'Dear, ' + c.FirstName + '<br/> <br/>';
                body += 'Update your Contacts Details <br/>';
                body += 'Email : ' + c.Email + '<br/>';
                body += 'Phone : ' + c.Phone + '<br/> <br/>';
                body += 'Thanks  <br/>';
                body += 'Sales Team';
                
                msg.setHtmlBody(body);
                
                emailList.add(msg);
            }
            Messaging.sendEmail(emailList);
            system.debug('Email Sent Successfully !!');
            
            p = new PageReference('/' + acc.Id);
        }
        catch(Exception ex){
            system.debug('=========== ERROR ============');
            system.debug(ex.getLineNumber() + ' ' + ex.getMessage());
        }
        
        return p;
    }
}