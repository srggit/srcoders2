trigger Account_Trigger_Test_Class_Ex on Account (before insert) {

    Account_Trigger_Class_Ex.invoke(Trigger.new);
}