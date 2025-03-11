public class Account_Extension_Controller {
	
    public Account acc 	{get;set;}
    
    public Account_Extension_Controller(ApexPages.StandardController controller){
        // ApexPages.StandardController will refer to 1 record.
        // ApexPages.StandardController will have the data in the form on sObject.
        // Because we don't know in which form the data is going to come.    
    	acc = (Account) controller.getRecord();
    }
    
    public PageReference save(){
        PageReference p;
        
        Integer count = [SELECT COUNT() 
                        FROM Account
                        WHERE Name =: acc.Name];
        
        if(count > 0){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error, 'Duplicate Record Found !!');
        	ApexPages.addMessage(msg);
        }
        else{
            insert acc;
            
            p = new PageReference('/' + acc.Id);
        }
        return p;
    }
}