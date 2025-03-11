public with sharing class GetCurrentAccST {

    @AuraEnabled
    public static Account getCurrentAccount(String accId){
        try {
            System.debug('accId : ' + accId);

            return [SELECT Id, Name, Rating, Industry FROM Account  Where Id =: accId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}