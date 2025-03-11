// Employee is Parent of Payments and if Parent has Child we cannot delete Parent checkbox is Checked.
// Before deleting the Parent we have to check that if any child exists, if exists delete those child first then delete parent

trigger Employee_Trigger on Employee__c (before delete) {
	
    if(Trigger.isBefore && Trigger.isDelete)
        // Satish Code
        Employee_Trigger_Handler.beforeDeleteCheckChild1(Trigger.oldMap);
        // My Logic
        // Employee_Trigger_Handler.beforeDeleteCheckChild(Trigger.old);
        
        
}