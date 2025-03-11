public with sharing class GetContactsLWC {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        try {
            List<Contact> lstContacts = [SELECT Id, FirstName, LastName, Phone, Email, AccountId, Account.Name
            FROM Contact LIMIT 5];
            return lstContacts;
        } 
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}