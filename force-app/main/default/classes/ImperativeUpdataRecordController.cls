public with sharing class ImperativeUpdataRecordController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        try {
            Set<Id> accIdSet = new Set<Id>();
            accIdSet.add('001NS00000YKFfHYAX');
            accIdSet.add('001NS00000qQetWYAS');
            accIdSet.add('001NS00000Zb3hOYAR');

            return [SELECT Id, Name, Rating, Industry FROM Account WHERE Id IN :accIdSet];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static void updateRecords(List<Account> recordsToUpdate){
        if(! recordsToUpdate.isEmpty()){
            update recordsToUpdate;
        }
    }
}