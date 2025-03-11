// Create 1 Account with Multiple Related Contacts..
public class DML_Ex3 {
    public Account acc		{get;set;}
    public List<Contact> conList {get;set;}
    
    public DML_Ex3(){
        acc = new Account();
        conList = new List<Contact>();
        addContact();
    }
    
    public void addContact(){
        Contact con = new Contact();
        conList.add(con);
    }
    
    public PageReference createRecords(){
        insert acc;
        
        for(Contact con : conList){
            con.AccountId = acc.Id;
        }
        insert conList;
        
        PageReference p = new PageReference('/' + acc.Id);
        return p;
    }
}