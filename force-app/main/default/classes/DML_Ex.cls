// Class 14: DML Operations
public class DML_Ex {
	
    public String accName {get;set;}
    public String accPhone {get;set;}
    public String accRating {get;set;} 
    public String accIndustry {get;set;}
    
    public PageReference create(){
        Integer count = [SELECT count() 
                         FROM Account
                         WHERE Name =: accName];
        system.debug('Count : ' + count);
        
        PageReference p; // No memory assigned, If Duplicate found come to same page.
        // If count > 0, Duplicate Records Found
        if(count > 0){
            system.debug('Count > 0');
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error, 'Duplicate Records Found');
            ApexPages.addMessage(msg);
        }
        else{
            Account acc = new Account();
            acc.Name = accName;
            acc.Phone = accPhone;
            acc.Rating = accRating;
            acc.Industry = accIndustry;
            insert acc;
            
            system.debug('Account Inserted Successfully : ' + acc.Id);
            
            p = new PageReference('/' + acc.Id); // If Record Inserted, navigate to Acc Detail Page.
        }
        return p;
    }
    
    public void cancel(){
        accName = null;
        accPhone = null;
        accRating = null;
        accIndustry = null;
    }
    
}