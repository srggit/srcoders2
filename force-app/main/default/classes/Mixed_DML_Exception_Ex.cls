// Whenever we make a DML on Setup and Non-Setup object at a time in a single method, the exception occurs which is knows as 'Mixed DML Operation'.

public class Mixed_DML_Exception_Ex {
	
    // Non-Setup Object
    @future
    public static void createAccount(){
        Account acc = new Account();
        acc.Name = 'AgriPlast Industries';
        acc.Rating = 'Hot';
        acc.Industry = 'Manufacturing';
        acc.AnnualRevenue = 4500000;
        acc.Active__c = 'Yes';
        acc.Ownership = 'Private';
        
        insert acc;
    }
    
    // Setup Object
    public void createUser(){
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Test'];
        UserRole ur = [SELECT Id FROM UserRole WHERE Name = 'Recruiting Manager'];
        
        User u = new User();
        u.FirstName = 'Test';
        u.LastName = 'User';
        u.Alias = 'tuser56';
        u.Email = 'srcoders01@gmail.com';
        u.EmailEncodingKey = 'UTF-8';
        u.LanguageLocaleKey = 'en_US';
        u.LocaleSidKey = 'en_US';
        u.TimeZoneSidKey = 'America/Los_Angeles';
        u.ProfileId = p.Id;
        u.UserRoleId = ur.Id;
        u.Username = 'tuser56@gmail.com';
        
        insert u;
        
        createAccount();
    }
}