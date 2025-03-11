public class AccountInfoWrapper {
    
    // Fields for WrapperEx.apxc
    public Account acc		{get;set;}
    public Boolean flag		{get;set;}
    
    // Fields for List_Of_List_Examples
    public String Name;
    public String Phone;
    public String Rating;
    
    
    public AccountInfoWrapper(){
        acc = new Account();
    }
}