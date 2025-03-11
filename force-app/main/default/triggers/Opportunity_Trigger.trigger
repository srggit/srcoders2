trigger Opportunity_Trigger on Opportunity (before insert, after insert, before update, after update) {
    
    // Only 5 opportunities can be created for an Object
    if(Trigger.isBefore && Trigger.isInsert)
        Opportunity_Trigger_Handler.beforeInsert(Trigger.new);
    
    // Whenever the Opportunity Stage is Closed Won, Share the record with Manager.
    if(Trigger.isAfter && Trigger.isInsert)    
        Opportunity_Trigger_Handler.afterInsertShare(Trigger.new);
    
    // Logic to check whether the StageName is changed or not
    if(Trigger.isBefore && Trigger.isUpdate)
        Opportunity_Trigger_Handler.beforeUpdateCheckStage(Trigger.oldMap, Trigger.newMap);
    
    //Trigger to share the record with Current Owners Manager whenever the StageName is Changed to 'Closed Won'.
    if(Trigger.isAfter && Trigger.isUpdate){
        // Opportunity_Trigger_Handler.afterUpdateShareRecord(Trigger.oldMap, Trigger.newMap);
        
        //Satish Code
        Opportunity_Trigger_Handler.afterUpdateShareRecordSatish(Trigger.oldMap, Trigger.newMap);
    
        // Whenever the Owner of Opportunity is modified Create Old Owner as Opp Team Member.
        Opportunity_Trigger_Handler.afterUpdateCreateTeamMember(Trigger.oldMap, Trigger.newMap);
    }
       
}