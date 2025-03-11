trigger Payment_Trigger on Payment__c (before insert, after insert, after delete, after update, after unDelete) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        Payment_Trigger_Handler.employeeIdIsMust(Trigger.new);
    }
        
    if(Trigger.isAfter && Trigger.isInsert){
        Payment_Trigger_Handler.rollupPayments(Trigger.newMap);
    }
    
    if(Trigger.isAfter && Trigger.isDelete){
        Payment_Trigger_Handler.rollupPaymentsAfterDelete(Trigger.oldMap);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        Payment_Trigger_Handler.rollupPaymentsAfterUpdate(Trigger.newMap, Trigger.oldMap);
    }
    
    if(Trigger.isAfter && Trigger.isUnDelete){
        Payment_Trigger_Handler.rollupPayments(Trigger.newMap);
    }  
}