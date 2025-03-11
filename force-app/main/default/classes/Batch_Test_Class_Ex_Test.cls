@isTest
public with sharing class Batch_Test_Class_Ex_Test {
    
    @TestSetup
    static void makeData() {
        Lead l1 = new Lead(
            FirstName = 'Lead',
            LastName = '1',
            LeadSource = 'Phone Inquiry',
            Company = 'Reliance',
            Status = 'Open - Not Contacted',
            Phone = '9838945783',
            Email = 'lead1@gmail.com'
        );
        
        Lead l2 = new Lead(
            FirstName = 'Lead',
            LastName = '2',
            LeadSource = 'Phone Inquiry',
            Company = 'Adani Green',
            Status = 'Open - Not Contacted',
            Phone = '8347583745',
            Email = 'lead2@gmail.com'
        );
        
        insert l1;
        insert l2;
    }

    @isTest
    static void test_Batch_Test_Class_Ex() {
        // Enclose batch execution in startTest/stopTest to simulate async processing.
        Test.startTest();
            Batch_Test_Class_Ex bt = new Batch_Test_Class_Ex();
            Id jobId = Database.executeBatch(bt, 5);
        Test.stopTest(); // This waits for the batch to complete in a test context.

        // Query the Leads again after the batch job completes
        List<Lead> lstLead = [SELECT Id, LeadSource FROM Lead];
        System.debug('lstLead Size : ' + lstLead.size());

        // Check that each Lead record's LeadSource was updated by the batch
        for (Lead l : lstLead) {
            System.assertEquals('Web', l.LeadSource);
        }
    }
}