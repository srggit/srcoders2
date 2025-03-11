// Class 18: Inbound Email Messaging

// Whenever the Email is received, Search for the Contact for that particular email address and Create Case for the contact.
public class Inbound_Email_Ex1 implements Messaging.InboundEmailHandler{
	
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope env){
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        
        try{
        	String fromAdd = email.fromAddress;
            String subject = email.subject;
            String body = email.plainTextBody;
            
            Contact con = [SELECT Id, Email 
                          FROM Contact
                          WHERE Email =: fromAdd
                          LIMIT 1];
            
            system.debug('Contact Found : ' + con);
            
            //Create Case
            Case c = new Case();
            c.Subject = subject;
            c.Priority = 'High';
            c.Status = 'New';
            c.Origin = 'Email';
            c.Description = body;
            c.ContactId = con.Id;
            insert c;
            
            result.success = true;
        }
        catch(Exception ex){
            result.success = false;
        }
        return result;
    }
}