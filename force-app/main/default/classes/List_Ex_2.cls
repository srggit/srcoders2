// Show the List of Customer Records on vf page

public class List_Ex_2 {
    public Customer__c cust					{get;set;}
    public List<Customer__c> customers 		{get;set;}
    
    public List_Ex_2(){
        cust = new Customer__c();	// Memory Allocation
        customers = new List<Customer__c>();
    }
    
    public void addMe(){
        customers.add(cust);
        cust = new Customer__c();	// New Memory Allocation
    }
    
    public void clearData(){
        customers.clear();
    }
    

}