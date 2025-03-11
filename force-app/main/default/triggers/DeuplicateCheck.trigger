trigger DeuplicateCheck on Contact (before insert, before update, after insert) {

    // Simple Duplicate Check Before Insert based on Email
    if(Trigger.isBefore && Trigger.isInsert){
        
        Set<String> emailsSet = new Set<String>();
        for(Contact con : Trigger.new){
            emailsSet.add(con.Email);
        }
        
        List<Contact> existingContacts = [SELECT Id, Email FROM Contact WHERE Email IN : emailsSet];
        
        Set<String> existingEmails = new Set<String>();
        for(Contact con : existingContacts){
            existingEmails.add(con.Email);
        }
        
        if(! existingEmails.isEmpty()){
            for(Contact con : Trigger.new){
                if(con.Email != null && con.Email != '' && existingEmails.contains(con.Email)){
                    con.addError('Duplicate Email Found !!');
                }
            }    
        }
    }
    
    if(Trigger.isBefore && Trigger.isUpdate){	// Existing(Id: 001, Email: s@gmail.com/s1@gmail.com)        
        Set<String> emailSet = new Set<String>();
        for(Contact con : Trigger.new){
            if(con.Email != null && con.Email != Trigger.oldMap.get(con.Id).Email)
            	emailSet.add(con.Email); // s1@gmail.com
        }
        
        // Cont 3: (Id: 003, Email: s1@gmail.com)
        List<Contact> lstContacts = [SELECT Id, Email FROM Contact 
                                     WHERE Email IN : emailSet AND Id NOT IN : Trigger.newMap.keySet()];
        
        Set<String> existingEmails = new Set<String>();
        for(Contact con : lstContacts){
            if(con.Email != null)
                existingEmails.add(con.Email);
        }
        
        if(! existingEmails.isEmpty()){
            for(Contact con : Trigger.new){
                if(con.Email != null && con.Email != '' && existingEmails.contains(con.Email))
                    con.addError('Duplicate Found - After Update !!');
            }
        }
    }
    
    // Copy all related contacts to its parent Account
    if(Trigger.isAfter && Trigger.isInsert){
        
        Set<Id> accIds = new Set<Id>();
        for(Contact con : Trigger.new){
            if(con.Description != null)
                accIds.add(con.AccountId);
        }
        
        List<Account> lstAccount = [SELECT Id, Description, 
                                   (SELECT Id, Description FROM Contacts WHERE Id IN : Trigger.newMap.keySet())
                                   FROM Account WHERE Id IN : accIds];
        
        if(! lstAccount.isEmpty()){
            for(Account acc : lstAccount){
                String updatedDesc = acc.Description != null ? acc.Description : '';
                
                for(Contact con : acc.Contacts){
                    updatedDesc = updatedDesc + (updatedDesc == '' ? '' : ', ') + con.Description;
                }
                acc.Description = updatedDesc;
            }
        }
        
        update lstAccount;
        
    }
}