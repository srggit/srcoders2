// Class : 13 Child Parent SOQL
public class Child_Parent_SOQL {
    public static void childParentSOQL(){
        
        // If Relation Field is Standard Field
        // --------------------------------------
        // Get Cases with corresponding Account Records.
        List<Case> lstCases = [SELECT Id, Status, Subject, Priority,
                              Account.Name, Account.Rating, Account.Industry
                              FROM Case];
        
        // If Relation Field is Custom Field
        // --------------------------------------
        // Get all Payments with corresponding Customer Records.
        List<Payment__c> lstPayments = [SELECT Id, Name, City__c, Loan__c, Amount__c,
                                       Customer__r.Name, Customer__r.City__c, Customer__r.Age__c, Customer__r.Email__c
                                       FROM Payment__c];
        
        // Get all Loans with corresponding Customer Records
        List<Loan__c> lstLoans1 = [SELECT Id, Name, Type_Of_Loan__c, No_of_EMI_s__c, Security__c,
                                 Customer__r.Name, Customer__r.City__c, Customer__r.Age__c, Customer__r.Email__c // Custom Relation with Customer
                                 FROM Loan__c];
        
        
        // Get all Loans with correspsonding Customer Records and User Data
        // If we have 2-3 Relation Field, we can refer to multiple Parents at a time. 
        List<Loan__c> lstLoans2 = [SELECT Id, Name, Type_Of_Loan__c, No_of_EMI_s__c, Security__c,
                                 Customer__r.Name, Customer__r.City__c, Customer__r.Age__c, Customer__r.Email__c, // Custom Relation with Customer
                                 CreatedBy.Name, LastModifiedBy.Name // Standard Relation With User
                                 FROM Loan__c];
        
    }
}