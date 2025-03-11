@isTest
public with sharing class Batch_Test_Class_Ex2_Test {
    
    @TestSetup
    static void makeData(){

        MockHttpResponseGenerator httpCall = new MockHttpResponseGenerator();
        Test.setMock(HttpCalloutMock.class, httpCall);

        Account acc = new Account(
            Name = 'SBI',
            Rating = 'Hot',
            Industry = 'Banking',
            AnnualRevenue = 1900000
        );
        insert acc;
    }

    @isTest
        static void test_Batch_Test_Class_Ex2(){

        Test.startTest();
            Batch_Test_Class_Ex2 bch = new Batch_Test_Class_Ex2();
            Id jobId = Database.executeBatch(bch, 5);
        Test.stopTest();

        Account acc = [SELECT Id, OwnerId, Owner.Name, Owner.Alias FROM Account LIMIT 1];

        System.assertEquals('Saurabh G', acc.Owner.Name);
        System.assertEquals('SG', acc.Owner.Alias);
    }

    // Batch Class Test Using Test Data Factory:
    // ------------------------------------------

    @isTest
    static void test_Batch_Test_Class_Ex2_2(){

        Test_Data_Factory.createTestAccountsData();

        Test.startTest();
            Batch_Test_Class_Ex2 bch = new Batch_Test_Class_Ex2();
            Id jobId = Database.executeBatch(bch, 5);
        Test.stopTest();

        User u = [SELECT Id, Name, Alias FROM User WHERE Alias =: 'SG'];
        Account acc = [SELECT Id, OwnerId, Owner.Name, Owner.Alias FROM Account WHERE Name =: 'BMW Automotive'];

        System.assertEquals(u.Alias, acc.Owner.Alias);
        System.assertEquals(u.Name, acc.Owner.Name);
    }
}