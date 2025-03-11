public with sharing class GetAccountsControllerST {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(){
        return [SELECT Id, Name, Rating, Industry, AnnualRevenue FROM Account WHERE AnnualRevenue > 5000000 LIMIT 5];
    }

    @AuraEnabled(cacheable=true)
    public static Account getAccById(String accId){
        return [SELECT Id, Name, Rating, Industry, AnnualRevenue, Phone FROM Account
        WHERE Id =: accId];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String department){
        System.debug('department' +  department);
        return [SELECT Id, FirstName, LastName, Phone, Department FROM Contact WHERE Department =: department];
    }
}