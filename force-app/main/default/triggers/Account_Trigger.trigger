// Whenever an Account is created with Rating as Hot, Create an Opportunity.
trigger Account_Trigger on Account (after insert, after update) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        //Account_Trigger_Handler.afterInsert(Trigger.new);
        //Account_Trigger_Handler.createTeamMember(Trigger.new);
        
        // Recursive Trigger Example Class 24: 00:04:00
        // Trigger to Create Account whenever the New Account is Inserted, this is Recursive Trigger.
        // After 1st Account is inserted, this trigger will again fire to create new record.
        // Whenever Recursive Trigger is Identified by Salesforce, it throws an Error, CANNOT_INSERT_UPDATE_ACTIVATE_ENTITY, Account_Trigger: maximum trigger depth exceeded.
        //Account_Trigger_Handler.handleRecuriveTrigger();    
    
        // Webservice Call (Get the Postal Address based on Pincode)
        System.debug('After Insert Trigger Fired in Account');
        Map<Id, Account> accMap = Trigger.newMap;
        Set<Id> accIdSet = accMap.keySet();
        Account_Pincode_Webservice.getPlacesUsingPincode(accIdSet);
    }

    if(Trigger.isAfter && Trigger.isUpdate){

        System.debug('Account_Trigger is fired !!');
        List<Account_Event__e> accountPlatformEventsList = new List<Account_Event__e>();

        for(Account acc : Trigger.new){
            Account_Event__e event = new Account_Event__e(
                RecordId__c = acc.Id
            );
        }

        if(! accountPlatformEventsList.isEmpty()){
            System.debug('Account triggered published');
            EventBus.publish(accountPlatformEventsList);
        }       
    }

}