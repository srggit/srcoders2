/*
Contact 1 Mobile : 8888888888
Contact 2 Phone  : 8888888888
*/

trigger CheckDuplicatePhoneMobileNumbers on Contact (before insert, before update) {
    
    Set<String> incomingNumbers = new Set<String>();
    for(Contact con : Trigger.new){
        if(con.Phone != null){
            incomingNumbers.add(con.Phone);
        }
        if(con.MobilePhone != null){
            incomingNumbers.add(con.MobilePhone);
        }
    }
    
    List<Contact> existingContacts = [SELECT Id, Name, Phone, MobilePhone FROM Contact
                                      WHERE Phone IN : incomingNumbers OR MobilePhone IN : incomingNumbers];
    
    // Sol 1:
    for(Contact newCon : Trigger.new){
        for(Contact existingCon : existingContacts){
            if( (newCon.Phone != null && newCon.Phone == existingCon.MobilePhone) || 
                (newCon.MobilePhone != null && newCon.MobilePhone == existingCon.Phone)
              ){
                 newCon.addError('Same number exists in the database. Duplicate number can’t be entered in the system.');
            }
        }
    }
    
    // Sol 2:
    /*
    for (Contact newCon : Trigger.new) {
        for (Contact existingCon : existingContacts) {
            // Check for duplicates across Phone and MobilePhone fields
            if ( (newCon.Phone != null && (newCon.Phone == existingCon.Phone || newCon.Phone == existingCon.MobilePhone)) || 
                 (newCon.MobilePhone != null && (newCon.MobilePhone == existingCon.Phone || newCon.MobilePhone == existingCon.MobilePhone))
               ) {
                newCon.addError('Same number exists in the database. Duplicate number can’t be entered in the system.');
            }
        }
    }
    */
    
    
    
}