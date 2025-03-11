public with sharing class refreshApexControllerST {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(){
        try {
            System.debug('-----getContactList-----');
            return [SELECT Id, FirstName, LastName, Phone, Email FROM Contact LIMIT 5];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}