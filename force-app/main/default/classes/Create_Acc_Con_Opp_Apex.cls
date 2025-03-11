public with sharing class Create_Acc_Con_Opp_Apex {
    
    @AuraEnabled
    public static string createAccConOpp(String accString, String conString, String oppString){
        
        System.debug('oppString : ' + oppString);

        AccountWrapper accWrapper       = (AccountWrapper)      JSON.deserialize(accString, AccountWrapper.class);
        ContactWrapper conWrapper       = (ContactWrapper)      JSON.deserialize(conString, ContactWrapper.class);
        OpportunityWrapper oppWrapper   = (OpportunityWrapper)  JSON.deserialize(oppString, OpportunityWrapper.class);

        System.debug('oppWrapper : ' + oppWrapper);

        try{
            Account acc = new Account();

            if(accWrapper != null){
                acc.Name = accWrapper.name;
                acc.Rating = accWrapper.rating;
                acc.Industry = accWrapper.industry;
                acc.AnnualRevenue = accWrapper.annualRevenue;
                acc.Ownership = accWrapper.ownership;
                acc.Website = accWrapper.website;
                acc.Description = accWrapper.description;

                insert acc;
            }

            Contact con = new Contact();
            if(conWrapper != null){
                con.AccountId = acc.Id;
                con.FirstName = conWrapper.firstName;
                con.LastName = conWrapper.lastName;
                con.Phone = conWrapper.phone;
                con.Email = conWrapper.email;
                con.Title = conWrapper.title;
                con.Department = conWrapper.department;
                con.Fax = conWrapper.fax;

                insert con;
            }

            Opportunity opp = new Opportunity();
            if(oppWrapper != null){
                opp.AccountId = acc.Id;
                opp.Name = oppWrapper.name;
                opp.Type = oppWrapper.type;
                opp.Amount = oppWrapper.amount;
                opp.StageName = oppWrapper.stageName;
                opp.LeadSource = oppWrapper.leadSource;
                opp.CloseDate = oppWrapper.closeDate;
                opp.Description = oppWrapper.description;

                insert opp;
            }   

            return acc.Id;
        }  
        catch(Exception e){
            System.debug('Error : ' + e.getMessage());
            throw new AuraHandledException('Error from Apex : ' + e.getMessage());
        }
    }

    public class AccountWrapper{
        public String  name;
        public String  rating;
        public String  industry;
        public Decimal annualRevenue;
        public String  ownership;
        public String  website;
        public String  description;
    }

    public class ContactWrapper{
        public String firstName;
        public String lastName;
        public String phone;
        public String email;
        public String title;
        public String department;
        public String fax;
    }

    public class OpportunityWrapper{
        public String  name;
        public String  type;
        public Decimal amount;
        public String  stageName;
        public String  leadSource;
        public Date    closeDate;
        public String  description;
    }
}