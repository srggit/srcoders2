// Class 16: 00:20:00
public class SavePoint_Rollback {
    
    //Wrapper Class
    public class AccWrapper{
        public String company		{get;set;}
        public String lastName		{get;set;}
        public String firstName		{get;set;}
        public String phone			{get;set;}
        public String industry		{get;set;}
        public String rating		{get;set;}
    }
    
    public AccWrapper accWrap	{get;set;}
    
    public SavePoint_Rollback(){
        accWrap = new AccWrapper();
    }
    
    public PageReference saveRecords(){
        
        PageReference p;
        SavePoint sp = Database.setSavePoint();
        
        try{
            Account acc = new Account();
            acc.Name = accWrap.company;
            acc.Rating = accWrap.rating;
            acc.Industry = accWrap.industry;
            acc.Phone = accWrap.phone;
            
            insert acc;
            
            Contact con = new Contact();
            con.FirstName = accWrap.firstName;
            con.LastName = accWrap.lastName;
            con.AccountId = acc.Id;
            
            insert con;
            
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name + '_';
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today().addDays(5);
            opp.AccountId = acc.Id;
            
            insert opp;
            
            p = new PageReference('/'+ acc.Id);
        }
        catch(Exception ex){
            Database.rollback(sp);
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error, ex.getMessage());
        }
        return p;
    }
}