public with sharing class paginationClass {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        try {
            // Note: If fields are Null and we are using on component it will give wrong pagination
            List<Contact> lstContacts = [SELECT Id, FirstName, LastName FROM Contact];
            return lstContacts;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}