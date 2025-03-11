trigger Lead_Trigger on Lead (after insert) {
	
    // For every Lead Create Contact, after Lead Insertion
    Lead_Trigger_Handler.afterInsert(Trigger.new);
    
    // Whenever a new Lead is created, send email to Lead
    Lead_Trigger_Handler.afterInsertSendEmail(Trigger.new);
}