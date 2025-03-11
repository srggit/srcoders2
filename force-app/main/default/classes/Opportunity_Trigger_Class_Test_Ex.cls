public with sharing class Opportunity_Trigger_Class_Test_Ex {
    
    public static void invoke(Map<Id, Opportunity> oldMap, Map<Id, Opportunity> newMap){

        Set<Id> keys = oldMap.keySet();

        for(Id k : keys){

            Opportunity oldOpp = oldMap.get(k);
            Opportunity newOpp = newMap.get(k);

            if(oldOpp.StageName != newOpp.StageName && newOpp.StageName == 'Closed Won'){
                newOpp.CloseDate = System.today();
            }
        }
    }
}