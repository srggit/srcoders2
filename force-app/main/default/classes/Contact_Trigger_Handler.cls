public class Contact_Trigger_Handler {
    
    public static void beforeInsert(List<Contact> lstContacts){
        
        Set<Id> accIdSet = new Set<Id>();
        
        for(Contact con : lstContacts){
            accIdSet.add(con.AccountId);    
        }
        
        List<Account> lstAccounts = new List<Account>();
        if(! accIdSet.isEmpty()){
            lstAccounts = [SELECT Id, Name, Rating,
                           (SELECT Id, FirstName FROM Contacts)
                           FROM Account
                           WHERE Id IN : accIdSet];
        }
        Map<Id, Integer> conCountMap = new Map<Id, Integer>();
        
        for(Account acc : lstAccounts){
            //List<Contact> conList = acc.Contacts;
            //conCountMap.put(acc.Id, acc.conList.size());
            conCountMap.put(acc.Id, acc.Contacts.size());
        }
        
        for(Contact c : lstContacts){
            Id parentId = c.AccountId;
            
            if(parentId != null){
                Integer conCount = conCountMap.get(c.AccountId); // We will get value(Contacts count for a Account Id)
                
                if(conCount >= 2){
                    c.addError('Trigger: Cannot create more than 2 Contacts for an Account');
                }
            }
        }
    }
    
    // Delete Parent When Child record is Deleted
    // Whenever we delete the contact delete the Account
    public static void beforeDelete_DeleteAccounts(List<Contact> lstContacts){
        system.debug('Trigger: Contact_Trigger_Handler : beforeDelete_DeleteAccounts');
        
        Set<Id> accIds = new Set<Id>();
        for(Contact con : lstContacts){
            if(con.AccountId != null)
                accIds.add(con.AccountId);
        }
        
        List<Account> lstAccounts = [SELECT Id, Name 
                                    FROM Account
                                    WHERE Id IN : accIds];
        
        if(! lstAccounts.isEmpty())
	        delete lstAccounts;
        else
            system.debug('Accounts Deletion Failed');
    }
}