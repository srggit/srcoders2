public with sharing class Interview {
    public static void checkPhone(List<Contact> lstContacts) {
        // Step 1: Collect Account IDs from Contacts
        Set<Id> accIds = new Set<Id>();
        for (Contact con : lstContacts) {
            if (con.AccountId != null) {
                accIds.add(con.AccountId);
            }
        }

        // Step 2: Query Accounts related to the Contacts
        Map<Id, Account> mapAccounts = new Map<Id, Account>([
            SELECT Id, Phone 
            FROM Account 
            WHERE Id IN :accIds AND Phone != null
        ]);

        // Step 3: Check if Contact's phone matches its Account's phone
        for (Contact con : lstContacts) {
            if (con.AccountId != null && con.Phone != null) {
                Account relatedAccount = mapAccounts.get(con.AccountId);
                if (relatedAccount != null && con.Phone == relatedAccount.Phone) {
                    con.addError('Trigger: A Contact\'s phone number cannot match its related Account\'s phone number.');
                }
            }
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Id, Name, AnnualRevenue, Rating, Industry, Website FROM Account WHERE Id = '001NS00000Zb3hOYAR'];
    }
}
