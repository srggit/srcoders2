public with sharing class GetAllAccountsLWC {

    @AuraEnabled(cacheable=true)
    public static List<Account> showAcc(){
        try {
            List<Account> lstAccs = [SELECT Id, Name, Rating, Industry, Phone, AnnualRevenue
                                     FROM Account LIMIT 5];
            system.debug('Acc List Size : ' + lstAccs.size());
            return lstAccs;
        } 
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}