// Class 17: Outbound Email Service
public class Outbound_Email_Ex1 {
	
    String[] toAdd = new String[]{'saurabhgirhe4@gmail.com'};
    String[] ccAdd = new String[]{'saurabhgirhe4@gmail,com'};
    String[] bccAdd = new String[]{'saurabhgirhe4@gmail.com'};
    
    // Example 1
    public void outboundEmailService(){
        try{
            Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
            email1.setToAddresses(toAdd);    // 150 emails we can mention
            //email1.setCcAddresses(ccAdd);
            //email1.setBccAddresses(bccAdd);
            email1.setSubject('Subject : Test Outbound Email 1');      
            email1.setPlainTextBody('This is the Test Outbound Email from an Apex Class');
            
            Messaging.SingleEmailMessage email2 = new Messaging.SingleEmailMessage();
            email2.setToAddresses(toAdd);
            //email2.setCcAddresses(ccAdd);
            //email2.setBccAddresses(bccAdd);
            email2.setSubject('Subject : Test Outbound Email 2');
            
            String body = 'Your request is received with following details <br/> <br/>';
            body += 'Name : <b> Sami Gotra </b> <br/>';
            body += 'Phone : <b> 28374-34243 </b> <br/> <br/>';
            body += 'Thanks & Regards, <br/>';
            body += 'Sales Team <br/> <br/>';
            email2.setHTMLBody(body);
            
            email2.setSenderDisplayName('Sender\'s Name');
            email2.setInReplyTo('saurabhgirhe4@gmail.com');
            
            Messaging.Email[] emails = new Messaging.Email[]{email1, email2};
                
            Messaging.sendEmail(emails);
            
            system.debug('Email Sent Successfully');
            
        }
        catch(Exception ex){
            system.debug('Error : '  + ex);
        }
    }
    
    // Example 2: Send Email to all Leads
    public void sendEmailToLeads(){
        
        try{
            List<Lead> lstLeads = [SELECT Id, FirstName, LastName, Email, Phone
                                  FROM Lead
                                  WHERE CreatedDate = TODAY];
            
            List<Messaging.Email> emails = new List<Messaging.Email>();
            
            for(Lead l : lstLeads){
                Messaging.SingleEmailMessage email3 = new Messaging.SingleEmailMessage();
                
                email3.setToAddresses(new List<String>{l.Email});    // 150 emails we can mention
                email3.setSubject('Lead Service Request');
                
                String body = 'Your service request is received with following details <br/> <br/>';
                body += 'First Name : ' + l.FirstName + '<br/>';
                body += 'Last Name : ' + l.LastName + '<br/>';
                body += 'Phone : ' + l.Phone + '<br/>';
                body += 'Email : ' + l.Email + '<br/> <br/>';
                body += 'Thanks & Regards, <br/>';
                body += 'Sales Team';
                
                email3.setHtmlBody(body);
                email3.setSenderDisplayName('Support Team');
                
                emails.add(email3);
            }
            
            Messaging.sendEmail(emails);
        }
        catch(Exception ex){
            system.debug('ERROR : ' + ex.getMessage());
            system.debug('ERROR : ' + ex);
        }
    }
    
    // Example 3: Using Email Template as Body in Outbound Email Service.
    // Note: We can send Email Template to Lead, Contact and User.
    
    public void EmailTemplateInOutboundEmail(){
        try{
            EmailTemplate et = [SELECT Id, Name
                                FROM EmailTemplate
                                WHERE Name = 'Account Confirmation'];
            
            Contact con = [SELECT Id, FirstName, LastName, Email, Phone, AccountId
                           FROM Contact
                           WHERE Phone = '9009009009'];
            system.debug('Matching Contact Found');
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            mail.setToAddresses(new List<String>{con.Email});    // // 150 emails we can mention
            
            mail.setTemplateId(et.Id);
            
            // If it is SingleEmailMessage we can mention only Single TargetObjectId.
            // If it is MassEmailMessage we can mention 250 TargetObjectId's.
            mail.setTargetObjectId(con.Id);	// We can mention Id of Lead, Contact or User to whom we want to send Email
            // Mention Id to whom we want to send the Emai.
            
            mail.setWhatId(con.AccountId);  // In case if you pass the contact as targetObjectId then we need
            // to pass the Id of the record whose data is used in template.
            
            // Note: If we mention targetObjectId as Contact, then only we need to mention WhatId.        
            
            Messaging.Email[] emails = new Messaging.Email[]{mail};
                
            Messaging.sendEmail(emails);
        }
        catch(Exception ex){
            system.debug('ERROR');
            system.debug(ex.getLineNumber() + ' --- ' + ex.getMessage());
            
        }
        
    }
    
    // -------------- SAMPLE CODE FOR MASS EMAIL ------------------------- 
    // MassEmailMessage: If using Email Template, we can send email to 250 records at a time.
    public void sendMassEmail(){
        EmailTemplate et = [SELECT Id, Name
                                FROM EmailTemplate
                                WHERE Name = 'Account Confirmation'];
        
        // Salesforce allows you to directly pass the result of a SOQL query to the Map constructor. 
        // This automatically creates a Map where the Id of each Lead becomes the key, and the Lead record becomes the value. 
        Map<Id, Lead> mapLeads = new Map<Id, Lead>([SELECT Id, FirstName, LastName FROM Lead WHERE CreatedDate = TODAY]);
        List<Id> leadIds = new List<Id>(mapLeads.keySet());
		
        Messaging.MassEmailMessage msg = new Messaging.MassEmailMessage();
        msg.setTemplateId(et.Id);
        msg.setTargetObjectIds(leadIds);		// 250 Ids/Emails we can mention
    	
        // We no need to mention WhatId, if targetObjectId is Contact then only we have to mention What Id as AccountId
        
        Messaging.Email[] emails = new Messaging.Email[]{msg};
            
        Messaging.sendEmail(emailS);
    }
    
    // --------------- Sending Email with Attachments ----------------------
    public void sendingAttachemnts(){
        
        try{
            // Fetch the document and create emailFileAttachment
            Document d = [SELECT Id, Name, Body, ContentType
                         FROM Document
                         WHERE Name = 'Doc1'];
            
            Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
            efa1.setBody(d.Body);
            efa1.setFileName(d.Name);
            efa1.setContentType(d.ContentType);
            
            // Currently Instead of Document we are using ContentVersion
            // Query the latest version of the file from the ContentVersion object
            ContentVersion cv = [SELECT Id, Title, VersionData, ContentDocumentId, FileType 
                                 FROM ContentVersion 
                                 WHERE Title = 'Recruitment Logo'  // Replace 'Doc1' with your file name
                                 AND IsLatest = TRUE 
                                 LIMIT 1];
			
            // Create an EmailFileAttachment object
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setBody(cv.VersionData); // Fetch the file content (binary data)
            efa.setFileName(cv.Title);   // Set the file name
            
            // Map the FileType to MIME type
            String mimeType;
            if (cv.FileType == 'PNG') {
                mimeType = 'image/png';
            } else if (cv.FileType == 'PDF') {
                mimeType = 'application/pdf';
            } else if (cv.FileType == 'JPG' || cv.FileType == 'JPEG') {
                mimeType = 'image/jpeg';
            } else {
                mimeType = 'application/octet-stream'; // Default for unknown file types
            }
            
            efa.setContentType(mimeType); // Set the MIME type (e.g., 'application/pdf')
            
            
            // Convert the VF page as PDF and create emailFileAttachment
            PageReference p = Page.VF_Page_As_Pdf;
            Blob b = p.getContentAsPDF();
            
            Messaging.EmailFileAttachment efa2 = new Messaging.EmailFileAttachment();
            efa2.setFileName('VF_Page_As_Pdf.pdf');
            efa2.setBody(b);
            
            // 2 Attachment Created
            Messaging.EmailFileAttachment[] allFiles = new Messaging.EmailFileAttachment[]{efa1, efa, efa2};
            
            // Creating SingleEmailMessage
            EmailTemplate et = [SELECT Id, Name
                               FROM EmailTemplate
                               WHERE Name = 'Account Confirmation'];
            
            
            Contact con = [SELECT Id, FirstName, LastName, Email, Phone, AccountId
                               FROM Contact
                               WHERE Phone = '9009009009']; 
            
            Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
            msg.setToAddresses(new List<String>{con.Email});
            msg.setTemplateId(et.Id);
            msg.setTargetObjectId(con.Id);
            msg.setWhatId(con.AccountId);
            msg.setFileAttachments(allFiles);
            
            //List<Messaging.Email> emails = new List<Messaging.Email>{msg};
            
            Messaging.Email[] emails = new Messaging.Email[]{msg};
            
            Messaging.sendEmail(emails);
        }
        catch(Exception ex){
            system.debug('---------------- ERROR -------------');
            system.debug(ex.getLineNumber() + ' ----- ' + ex.getMessage());
        }
    }
}