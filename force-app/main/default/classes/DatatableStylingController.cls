public with sharing class DatatableStylingController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAllAccounts(){
        try {   
            return [SELECT Id, Name, Industry, Rating, Phone, Type,  AnnualRevenue, Ownership, Website FROM Account];
        } 
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}