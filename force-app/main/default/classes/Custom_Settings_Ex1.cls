public class Custom_Settings_Ex1 {
    
    public Custom_Settings_Ex1(){
        // Get all the records from Custom Object Settings in the form of Map.

        Map<String, LiveData__c> allRecords = LiveData__c.getAll();
        system.debug('All Records : ' + allRecords);
        system.debug('All Keys : ' + allRecords.keySet());
        system.debug('All Values : ' + allRecords.values());
        
        for(String key : allRecords.keySet()){
            LiveData__c ldRecord = allRecords.get(key);
            system.debug(ldRecord.Name);
            system.debug(ldRecord.Amount__c);
            system.debug(ldRecord.Email__c);
        }
    }

}