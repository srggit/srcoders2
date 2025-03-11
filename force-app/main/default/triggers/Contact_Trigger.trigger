trigger Contact_Trigger on Contact (before insert, after delete) {
    
    // Account can have only 2 Contacts
    if(Trigger.isBefore && Trigger.isInsert){
        Contact_Trigger_Handler.beforeInsert(Trigger.new);
    }

    // Whenever we delete the contact delete the Account
    // Delete Parent When Child record is Deleted
    if(Trigger.isAfter && Trigger.isDelete){
        Contact_Trigger_Handler.beforeDelete_DeleteAccounts(Trigger.old);
    }
}