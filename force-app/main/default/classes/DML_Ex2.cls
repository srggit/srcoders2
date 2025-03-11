// Program to Insert Account and its Related Contact and Opportunity.
public class DML_Ex2 {
    public Account acc 	{get;set;}
    public Contact con	{get;set;}
    public Opportunity opp {get;set;}
    
    public DML_Ex2(){
        acc = new Account();
        con = new Contact();
        opp = new Opportunity();
    }
    
    public PageReference saveRecords(){
        insert acc;
        
        con.AccountId = acc.Id;
        insert con;
        
        opp.AccountId = acc.Id;
        insert opp;
        
        PageReference p = new PageReference('/' + acc.Id);
        return p;
    }
    
    public void cancel(){
        acc = new Account();
        con = new Contact();
        opp = new Opportunity();
    }
}