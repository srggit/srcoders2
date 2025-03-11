trigger AccountTrigger2 on Account (after update) {
    System.debug('⚡ AccountTrigger2 Trigger Fired');

    if (Trigger.isAfter && Trigger.isUpdate) {
        System.debug('✅ Account Trigger is fired !!');
        List<Account_Event__e> accountPlatformEventsList = new List<Account_Event__e>();

        for (Account acc : Trigger.new) {
            System.debug('📌 Creating Platform Event for Account ID: ' + acc.Id);
            
            Account_Event__e event = new Account_Event__e(
                RecordId__c = acc.Id
            );
            accountPlatformEventsList.add(event);
        }

        if (!accountPlatformEventsList.isEmpty()) {
            System.debug('🚀 Publishing Platform Event...');
            EventBus.publish(accountPlatformEventsList);
        } else {
            System.debug('⚠️ No events to publish.');
        }
    }
}
