global with sharing class Batch_Test_Class_Ex implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, FirstName, LastName, LeadSource FROM Lead';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Lead> leads) {
        for (Lead l : leads) {
            l.LeadSource = 'Web';
        }
        update leads;  // Save changes to Lead records
    }

    global void finish(Database.BatchableContext bc) {
        // Optional: Final steps after batch completion
    }
}