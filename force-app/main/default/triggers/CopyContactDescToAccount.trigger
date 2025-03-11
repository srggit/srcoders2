/*
 * Copy Related Contacts Description in its Parent Account
*/
trigger CopyContactDescToAccount on Contact (after insert, after update, after delete, after undelete) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        Set<String> accIds = new Set<String>();
        for(Contact con : Trigger.new){
            if(con.AccountId != null)
                accIds.add(con.AccountId);
        }
        System.debug('accIds : ' + accIds);
        
        List<Account> accountsToUpdate = [SELECT Id, Name, Description, 
                                          (SELECT Id, Description FROM Contacts WHERE Id IN :Trigger.newMap.keySet() ORDER BY CreatedDate ASC)
                                          FROM Account WHERE Id IN : accIds];
        
        for (Account acc : accountsToUpdate) {
            String combinedDescription = acc.Description != null ? acc.Description : '';
            
            for (Contact con : acc.Contacts) {
                if (con.Description != null) {
                    combinedDescription = combinedDescription + (combinedDescription == '' ? '' : ', ') + con.Description;
                }
            }
            
            acc.Description = combinedDescription;
        }
        
        // Step 4: Update the Accounts in the database
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }   
    
    if(Trigger.isAfter && Trigger.isUpdate) {
        // Step 1: Collect Account IDs from updated Contacts
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : Trigger.new){
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }
        // Step 2: Query the related Accounts and their Contacts
        List<Account> accountsToUpdate = [
            SELECT Id, Description, 
            (SELECT Id, Description FROM Contacts)
            FROM Account 
            WHERE Id IN :accountIds
        ];
        
        // Step 3: Update Account Descriptions based on updated Contacts
        for (Account acc : accountsToUpdate) {
            String updatedDescription = '';
            
            // Iterate through each contact to collect descriptions
            for (Contact con : acc.Contacts) {
                if (con.Description != null) {
                    updatedDescription = updatedDescription + (updatedDescription == '' ? '' : ', ') + con.Description;
                }
            }
            
            // Update the Account Description
            acc.Description = updatedDescription;
        }
        
        // Step 4: Update the Accounts in the database
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
    
    if(Trigger.isAfter && Trigger.isDelete) {
        // Step 1: Collect Account IDs from updated Contacts
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : Trigger.old){
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }
        // Step 2: Query the related Accounts and their Contacts
        List<Account> accountsToUpdate = [
            SELECT Id, Description, 
            (SELECT Id, Description FROM Contacts)
            FROM Account 
            WHERE Id IN :accountIds
        ];
        
        // Step 3: Update Account Descriptions based on updated Contacts
        for (Account acc : accountsToUpdate) {
            String updatedDescription = '';
            
            // Iterate through each contact to collect descriptions
            for (Contact con : acc.Contacts) {
                if (con.Description != null) {
                    updatedDescription = updatedDescription + (updatedDescription == '' ? '' : ', ') + con.Description;
                }
            }
            
            // Update the Account Description
            acc.Description = updatedDescription;
        }
        
        // Step 4: Update the Accounts in the database
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
    
    if(Trigger.isAfter && Trigger.isUndelete) {
        // Step 1: Collect Account IDs from updated Contacts
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : Trigger.new){
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }
        // Step 2: Query the related Accounts and their Contacts
        List<Account> accountsToUpdate = [
            SELECT Id, Description, 
            (SELECT Id, Description FROM Contacts)
            FROM Account 
            WHERE Id IN :accountIds
        ];
        
        // Step 3: Update Account Descriptions based on updated Contacts
        for (Account acc : accountsToUpdate) {
            String updatedDescription = '';
            
            // Iterate through each contact to collect descriptions
            for (Contact con : acc.Contacts) {
                if (con.Description != null) {
                    updatedDescription = updatedDescription + (updatedDescription == '' ? '' : ', ') + con.Description;
                }
            }
            
            // Update the Account Description
            acc.Description = updatedDescription;
        }
        
        // Step 4: Update the Accounts in the database
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
    
    
}