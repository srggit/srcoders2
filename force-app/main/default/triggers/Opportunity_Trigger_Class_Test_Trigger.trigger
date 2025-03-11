trigger Opportunity_Trigger_Class_Test_Trigger on Opportunity (before update) {

    Opportunity_Trigger_Class_Test_Ex.invoke(Trigger.oldMap, Trigger.newMap);
}