trigger ContactStatusTrigger on Contact (after update) {

    System.debug('ContactStatusTrigger Fired');

    List<Contact_Status_Update__e> contactPlatformEvents = new List<Contact_Status_Update__e>();

    for(Contact con: Trigger.new){
        Contact oldCon = Trigger.oldMap.get(con.Id);

        if(con.Status__c != null && (con.Status__c != oldCon.Status__c)){
            System.debug('Status Updated');
            Contact_Status_Update__e event = new Contact_Status_Update__e(
                ContactId__c = con.Id,
                Status__c = con.Status__c
            );
            
            contactPlatformEvents.add(event);
        }
    }

    if(! contactPlatformEvents.isEmpty()){
        EventBus.publish(contactPlatformEvents);
    }
}