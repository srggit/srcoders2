public with sharing class searchContactsUsingKeyword {

    @AuraEnabled (cacheable=true)
    public static List<Contact> searchContacts(String searchKey){
        try {
            System.debug('searchContactsUsingKeyword : searchContacts');

            String searchText = '%' + searchKey + '%';
            List<Contact> lstContacts = [SELECT Id, FirstName, LastName,
            Phone, Email, Account.Name
            FROM Contact
            WHERE FirstName LIKE : searchText];

            System.debug('lstContacts Size : ' + lstContacts.size());

            return lstContacts;
        } 
        catch (Exception e) {
            System.debug('Error :  ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}