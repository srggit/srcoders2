public class Inbound_Email_Attachments implements Messaging.InboundEmailHandler {
	
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope env){
        
            Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        
        try{
            // Create Case 
            Case c = new Case();
            c.Subject = email.subject;
            c.Priority = 'High';
            c.Status = 'New';
            c.Origin = 'Email';
            c.Description = email.plainTextBody;
           	
            insert c;
            system.debug('Case Created Succcessfully with Id : ' + c.Id);
            
            // Create Attachment
            Messaging.InboundEmail.binaryAttachment[] files = email.binaryAttachments;
            List<Attachment> attachments = new List<Attachment>();
            
            for(Messaging.InboundEmail.binaryAttachment b : files){
                Attachment attach = new Attachment();
                attach.ParentId = c.Id;		// Mention the record Id in which Attachment should be attached
                attach.Body = b.Body;
                attach.Name = b.FileName;
                
                attachments.add(attach);
            }
            insert attachments;
            system.debug('Attachments added Successfully !');
            
            result.success = true;
        }
        catch(Exception ex){
            system.debug('ERROR : ' + ex.getLineNumber() + ' --- ' + ex.getMessage());
            result.success = false;
        }
        return result;
    }
}