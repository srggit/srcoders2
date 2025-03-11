public with sharing class AccountContactForTreeGrid {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountsAndContacts(){
        try {
            return [SELECT Id, Name, Industry, Rating, Phone, Type, AnnualRevenue, Ownership, Website,
             (SELECT Id, Name, Phone, Email, Account.Name FROM Contacts) 
            FROM Account];
        } 
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }   
}