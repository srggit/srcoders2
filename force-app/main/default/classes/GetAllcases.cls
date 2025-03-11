public with sharing class GetAllcases {

    @AuraEnabled (cacheable = true)
    public static List<Case> fetchAllCases(){
        try {
            return [SELECT Id, CaseNumber, Priority, Type, AccountId, ContactId, Reason, Origin, ContactEmail
            FROM Case];

        } catch (Exception e) {
            System.debug('ERROR : ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}