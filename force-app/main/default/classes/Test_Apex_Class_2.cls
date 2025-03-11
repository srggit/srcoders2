@isTest
public with sharing class Test_Apex_Class_2 {
    
    @TestSetup
    static void makeData(){

        MockHttpResponseGenerator httpObj = new MockHttpResponseGenerator();
        Test.setMock(HttpCalloutMock.class, httpObj);

        Account acc = new Account();
        acc.Name = 'Birla Sun Life';
        acc.Rating = 'Cold';
        acc.Industry = 'Communication';
        acc.Ownership = 'Public';
        insert acc;

        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.CloseDate = System.today() + 15;
        opp.StageName = 'Prospecting';
        opp.Amount = 120000;
        opp.Account = acc;
        insert opp;
    }

    @isTest
    static void Test_Account_Trigger_Class_Ex(){

        // We have Trigger on Account for WebService call.
        // Error : Methods defined as TestMethod do not support Web service callouts 
        // Here we have implemented sample WebService call.
        // Before inserting the Accounts we have to make a Mock WebService call as we have Web Service Trigger on Account after Insert
        MockHttpResponseGenerator httpObj = new MockHttpResponseGenerator();
        Test.setMock(HttpCalloutMock.class, httpObj);

        Account acc = new Account();
        acc.Name = 'Tata Sun Life';
        acc.Rating = 'Cold';
        acc.Industry = 'Communication';
        acc.Ownership = 'Public';
        insert acc;

        Account account1 = [SELECT Id, Name, Rating, Industry, Ownership FROM 
        Account WHERE Id =: acc.Id];

        System.assertEquals('Hot', account1.Rating);
        System.assertEquals('Banking', account1.Industry);
        System.assertEquals('Private', account1.Ownership);
    }

    @isTest
    static void Test_Opportunity_Trigger_Class_Test_Ex(){

        Account account1 = [SELECT Id, Name, Rating, Industry, Ownership FROM Account WHERE Name =: 'Birla Sun Life' LIMIT 1];

        Opportunity opp = [SELECT Id, Name, CloseDate FROM Opportunity WHERE Name = 'Test Opportunity' LIMIT 1]; 

        opp.StageName = 'Closed Won';
        update opp;

        Opportunity newOpp = [SELECT Id, CloseDate FROM Opportunity WHERE Name =: 'Test Opportunity'];
        System.assertEquals(System.today(), newOpp.CloseDate);

        // This code will not work
        // After Triggers/Workflows: Triggers, workflows, or any automation might modify fields like CloseDate after the update operation.
        // Re-Query Required: The opp variable does not automatically reflect changes made by triggers. You need to re-query the record to capture any updates made by the automation. 
        // System.assertEquals(System.today(), opp.CloseDate);
        
    }
}