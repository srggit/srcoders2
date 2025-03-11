trigger Customer_Trigger on Customer__c (after insert) {
    
    if(Trigger.isAfter && Trigger.isInsert)
        Customer_Trigger_Handler.afterInsertShare(Trigger.new);
}