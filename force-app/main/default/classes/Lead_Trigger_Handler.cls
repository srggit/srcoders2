// There is a Duplicate Detection Rule for Contact, in which Lead Fields != Contact Fields, Currently De-Activated.

public class Lead_Trigger_Handler {
	
    // For every Lead Create Contact, after Lead Insertion
    public static void afterInsert(List<Lead> leadList){
        
        List<Contact> conList = new List<Contact>();
        
        for(Lead l : leadList){
            Contact con = new Contact();
            con.FirstName = l.FirstName;
            con.LastName = l.LastName;
            con.Email = l.Email;
            con.Phone = l.Phone;
            
            conList.add(con);
        }
        try{
            insert conList;
        }
        catch(Exception ex){
            system.debug('=========== ERROR ============');
            system.debug(ex.getMessage());
        }
        
    }
    
    // Whenever a new Lead is created, send email to Lead
    public static void afterInsertSendEmail(List<Lead> leadList){
        
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
        for(Lead l : LeadList){
        	Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{l.Email});
            email.setSubject('Welcome Mail For Your Enquiry.');
            
            String body = 'Dear Customer, <br/> <br/>';
            body += 'We have received your enquiry with following details. <br/> <br/>';
            body += 'FirstName : ' + l.FirstName + '<br/>';
            body += 'LastName : ' + l.LastName + '<br/>';
            body += 'Phone : ' + l.Phone + '<br/>';
            body += 'Email : ' + l.Email + '<br/> <br/>';
            body += 'Thanks, <br/>';
            body += 'Sales Team';
            
            email.setHtmlBody(body);
            email.setInreplyTo('saurabh4sfdc@gmail.com');
            email.setSenderDisplayName('Fallen Company');
            
            emailList.add(email);
         }
        
        if(! emailList.isEmpty()){
            Messaging.sendEmail(emailList);
        }else{
            system.debug('Email Sending Failed');
        }
    }
}