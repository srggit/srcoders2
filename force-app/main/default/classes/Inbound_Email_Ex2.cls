// Whenever email is received Create the Contact from its data
public class Inbound_Email_Ex2 implements Messaging.InboundEmailHandler{
	
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope env){
        
        Messaging.InboundEmailResult  result = new Messaging.InboundEmailResult();
        
        try{
            String lastName = email.fromName;
            String fromAdd = email.fromAddress;
            String subject = email.subject;
            String body    = email.plainTextBody;
            
            Contact con = new Contact();
            con.LastName = lastName;
            con.Email = fromAdd;
            con.Description = body;
            
            insert con;
            system.debug('Contact Created with Id : ' + con.Id);
            result.success = true;
        }
        catch(Exception ex){
            result.success = false;
            system.debug('Error : ' + ex.getLineNumber() + ' ------ ' + ex.getMessage());
        }
        
        return result;
    }
}