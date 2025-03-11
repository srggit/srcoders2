@isTest
private with sharing class Test_Apex_Ex1_Test {

    // Method 1: To define the Test Class Method
    @isTest
    private static void TestCallMe() {
        Test_Apex_Ex1 obj = new Test_Apex_Ex1();
        obj.callMe();

        System.assertEquals('Satish', obj.name);
        System.assertEquals('Hyd', obj.city);
    }

    @isTest
    private static void TestCallMe2(){
        Test_Apex_Ex1 obj = new Test_Apex_Ex1();
        obj.callMe2();

        System.assertEquals('Banking', obj.industry);
        System.assertEquals('Hot', obj.rating);
        System.assertEquals('Public', obj.ownership);
    }

    @isTest
    private static void TestCallMe3(){
        Test_Apex_Ex1 obj = new Test_Apex_Ex1();
        
        obj.industry = 'Communication';
        obj.callMe3();

        System.assertEquals('Warm', obj.rating);
        System.assertEquals(50000, obj.amount);

        obj.industry = 'Banking';
        obj.callMe3();

        System.assertEquals('Hot', obj.rating);
        System.assertEquals(10000, obj.amount);
    }

    // Method 2: To define Test Class Method: Older Method
    testmethod static void TestShow(){
        Test_Apex_Ex1 obj = new Test_Apex_Ex1();

        obj.leadSource = 'Web';

        obj.show();
        System.assertEquals('Myla', obj.lastName);
        System.assertEquals('Satish', obj.firstName);
        
        obj.leadSource = 'Phone';
        obj.show();
        System.assertEquals('KL', obj.lastName);
        System.assertEquals('Praveen', obj.firstName);
    }

    @isTest
    static void TestCreateContact(){
        
        Test_Apex_Ex1 obj = new Test_Apex_Ex1();
        obj.lastName = 'Test Class';
        obj.firstName = 'Contact';
        obj.phone = '92934829038';

        obj.createContact();

        System.assertEquals('Test Class', obj.lastName);

        Integer count = [SELECT COUNT() FROM Contact
                        WHERE FirstName =: obj.firstName AND
                        LastName =: obj.lastName];
        
        System.assertEquals(1, count);
    }

    @isTest
    static void TestCreateOpportunity(){
        Test_Apex_Ex1 obj = new Test_Apex_Ex1();

        obj.createOpportunity();

        Opportunity op = [SELECT Id, Name, StageName, CloseDate FROM Opportunity WHERE Name = 'Testing' LIMIT 1];
        System.assertEquals('Testing', op.Name);
        System.assertEquals('Prospecting', op.StageName);
        System.assertEquals(System.today() + 15, op.CloseDate);

        /*
        List<Opportunity> op = [SELECT Id, Name, StageName, CloseDate FROM Opportunity];

        System.debug('op : ' + op.size() );
        System.debug('op : ' + op);
        */
    }
    
    @TestSetup
    static void makeData(){
        
        // We have Trigger on Account for WebService call.
        // Error : Methods defined as TestMethod do not support Web service callouts 
        // Here we have implemented sample WebService call.
        // Before inserting the Accounts we have to make a Mock WebService call as we have Web Service Trigger on Account after Insert

        MockHttpResponseGenerator httpObj = new MockHttpResponseGenerator();
        Test.setMock(HttpCalloutMock.class, httpObj);

        Account acc1 = new Account();
        acc1.Name = 'Test Acc 1';
        acc1.Rating = 'Hot';
        acc1.Industry = 'Energy';
        insert acc1;

        User u = [SELECT Id FROM User WHERE alias = 'SG'];

        Opportunity opp = new Opportunity();
        opp.Name = 'BOB';
        opp.StageName = 'Closed Won';
        opp.CloseDate = System.today() + 10;
        opp.OwnerId = u.Id;

        insert opp;
    }


    @isTest
    static void TestUpdateAccounts(){

        Test_Apex_Ex1 obj = new Test_Apex_Ex1();       
        obj.updateAccounts();

        //System.assertEquals('Hot', obj.Rating);
    }

    @isTest
    static void TestDeleteAccounts(){

        Test_Apex_Ex1 obj = new Test_Apex_Ex1();
        obj.deleteAccounts();

        // We insert 1 Account with Industry = Energy
        // It is deleted in Apex Class
        // After Deletion we have no Account with Industry = Energy
        // That's why we are expecting 0 as result

        Integer count = [SELECT COUNT() FROM Account WHERE Industry = 'Energy'];
        System.assertEquals(0, count);
    }

    @isTest
    static void TestUpdateOpportunity(){

        Test_Apex_Ex1 obj = new Test_Apex_Ex1();
        obj.updateOpportunity();
        
        List<Opportunity> oppList = [SELECT Id, StageName, CloseDate FROM Opportunity];

        for(Opportunity opp : oppList){
            System.assertEquals('Closed Won', opp.StageName);
            System.assertEquals(System.today(), opp.CloseDate);
        }
    }

    @isTest
    static void TestDeleteOpportunity(){

        Test_Apex_Ex1 obj = new Test_Apex_Ex1();
        obj.deleteOpportunity();

        Integer count = [SELECT COUNT() FROM Opportunity];

        System.assertEquals(0, count);
    }

    @isTest
    static void TestUpdateUserOpp(){

        Test_Apex_Ex1 obj = new Test_Apex_Ex1();
        obj.updateUserOpp();

        List<Opportunity> oppList = [SELECT Id, StageName, CloseDate FROM Opportunity];
        for(Opportunity opp : oppList){
            System.assertEquals('Closed Won', opp.StageName);
            System.assertEquals(System.today(), opp.CloseDate);
        }
    }

    @isTest
    static void TestDeleteUserOpp(){

        User u = [SELECT Id FROM User WHERE alias = 'SG'];

        Test_Apex_Ex1 obj = new Test_Apex_Ex1();
        obj.deleteUserOpp();

        Integer count = [SELECT COUNT() FROM Opportunity WHERE OwnerId =: u.Id];

        System.assertEquals(0, count);
    }
}