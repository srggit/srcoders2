public with sharing class Test_Apex_Ex1 {
    
    public String name;
    public String city;

    public String industry;
    public String rating;
    public String ownership;

    public Decimal amount;

    public String lastName;
    public String firstName;
    public String leadSource;

    public String phone;

    public void callMe(){
        name = 'Satish';
        city = 'Hyd';
    }

    public void callMe2(){
        industry = 'Banking';
        rating = 'Hot';
        ownership = 'Public';
    }

    // Ex 3: Condition Wise Testing
    public void callMe3(){
        if(industry == 'Banking'){
            rating = 'Hot';
            amount = 10000;
        }
        else{
            rating = 'Warm';
            amount = 50000;
        }
    }

    public void show(){
        if(leadSource == 'Web'){
            lastName = 'Myla';
            firstName = 'Satish';
        }
        else{
            lastName = 'KL';
            firstName = 'Praveen';
        }
    }

    // Ex 4: DML Operations
    public void createContact(){

        Contact con = new Contact();
        con.LastName = lastName;
        con.FirstName = firstName;
        con.Phone = phone;

        insert con;
    }

    public void createOpportunity(){
        Opportunity opp = new Opportunity();
        opp.Name = 'Testing';
        opp.StageName = 'Prospecting';
        opp.CloseDate = System.today() + 15;

        insert opp;
    }

    public void updateAccounts(){

        List<Account> lstAcc = [SELECT Id, Rating FROM Account LIMIT 10];
        
        for(Account acc : lstAcc){
            acc.Rating = 'Warm';
        }

        update lstAcc;
    }

    public void deleteAccounts(){
        List<Account> lstAcc = [SELECT Id, Rating FROM Account
        WHERE Industry = 'Energy'];

        delete lstAcc;
    }

    public void updateOpportunity(){

        List<Opportunity> opptyList = [SELECT Id, Name, StageName FROM Opportunity];

        for(Opportunity opp : opptyList){
            opp.StageName = 'Closed Won';
            opp.CloseDate = System.today();
        }
        update opptyList;
    }

    public void deleteOpportunity(){
        
        List<Opportunity> opptyList = [SELECT Id FROM Opportunity];

        delete opptyList;
    }

    public void updateUserOpp(){

        User u = [SELECT Id FROM User WHERE alias = 'SG'];

        List<Opportunity> oppList = [SELECT Id, StageName
        FROM Opportunity WHERE OwnerId =: u.Id];

        for(Opportunity opp : oppList){
            opp.StageName = 'Closed Won';
            opp.CloseDate = System.today();
        }
        update oppList;
    }

    public void deleteUserOpp(){

        User u = [SELECT Id FROM User WHERE alias = 'SG'];

        List<Opportunity> oppList = [SELECT Id, StageName
        FROM Opportunity WHERE OwnerId =: u.Id];
        
        delete  oppList;
    }


}