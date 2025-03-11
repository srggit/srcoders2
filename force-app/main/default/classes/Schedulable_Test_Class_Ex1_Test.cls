@isTest
public with sharing class Schedulable_Test_Class_Ex1_Test {
    
    @isTest
    static void test_Schedulable_Test_Class_Ex1(){
      
        Test_Data_Factory.createTestAccountsData();

        String cron = '0 0 3 1 3 ?';
        Test.startTest();
            Schedulable_Test_Class_Ex1 schObj = new Schedulable_Test_Class_Ex1();
            Id jobId = System.schedule('Schedule Test Class', cron, schObj);
        Test.stopTest();

        Integer count = [SELECT COUNT() FROM Account WHERE CreatedDate = TODAY];
        System.assertEquals(0, count);

        CronTrigger ct = [SELECT Id, CronExpression FROM CronTrigger WHERE Id =: jobId];
        System.assertEquals(cron, ct.CronExpression);
    }
}