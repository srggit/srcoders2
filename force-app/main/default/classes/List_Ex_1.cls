// Show the List of Records on vf page.

public class List_Ex_1 {
    // Access Modifiers DataType VarName
    public Account acc				{get;set;}
    public List<Account> accounts   {get;set;}
    
    public List_Ex_1(){
        acc = new Account();
        accounts = new List<Account>();
    }    
    
    public void addMe(){
        accounts.add(acc);
        acc = new Account();
    }
    
    public void clear(){
        accounts.clear();
    }

        
}