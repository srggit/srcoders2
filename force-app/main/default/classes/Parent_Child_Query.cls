// Class: 12 Parent Child
public class Parent_Child_Query {
    public List<Account> lstAccounts 	{get;set;}
    
    public Parent_Child_Query(){
    	lstAccounts = [SELECT Id, Name, Rating, Industry,
                      (SELECT Id, FirstName, LastName, Phone FROM Contacts),
                      (SELECT Id, Name, Amount, StageName FROM Opportunities)
                      FROM Account];
    }
    
    public static void queryPractice(){
        // Write a SOQL Query to fetch all the accounts with corresponding Contact records.
    	// Fetch all the Contacts an put them in New List.
    	List<Account> allAcc = [SELECT Id, Name, Rating, Industry,
                               (SELECT Id, FirstName, LastName,LeadSource FROM Contacts)
                               FROM Account];
        
        // addAll():
        List<Contact> lstContacts1 = new List<Contact>();
        for(Account acc : allAcc){
            lstContacts1.addAll(acc.Contacts);
        }
        system.debug('lstContacts1 Size : ' + lstContacts1.size());
        
        // Without addAll():
        List<Contact> lstContacts2 = new List<Contact>();
        for (Account acc : allAcc) {
            // Check if the account has any contacts
            if (acc.Contacts != null && !acc.Contacts.isEmpty()) {
                // Iterate through each contact in the account's contacts
                for (Contact con : acc.Contacts) {
                    lstContacts2.add(con); // Add each contact to the list
                }
            }
		}	
        system.debug('lstContacts2 Size : ' + lstContacts2.size());
        
        // Write a SOQL Query to fetch all the accounts with corresponding Opportunity records.
    	// Fetch all the Amount an put them in New List.
        List<Account> allAcc1 = [SELECT Id, Name, Rating, Industry,
                                (SELECT Id, Name, StageName, Amount From Opportunities)
                                FROM Account];
        
        List<Decimal> allAmount = new List<Decimal>();
        Decimal totalAmount = 0;
        for(Account acc : allAcc1){
            if(acc.Opportunities.size() > 0){
                for(Opportunity opp : acc.Opportunities){
                    allAmount.add(opp.Amount);
                    totalAmount += opp.Amount;
                }
            }
        }
        system.debug('Amount : ' + allAmount);
        system.debug('Total Amount : ' + totalAmount);
        
        // Write a SOQL Query to fetch all Accounts with correspsonding Contacts
        // Get all those Contacts whose LeadSource is Web and put them in seperate list.
        
        List<Contact> webContacts = new List<Contact>();
        
        for(Account acc : allAcc){
            if(acc.Contacts.size() > 0){
                for(Contact con : acc.Contacts){
                    if(con.LeadSource == 'Web'){
                        webContacts.add(con);
                    }
                }
            }
        }
        system.debug('webContacts size : ' + webContacts.size());
        
        // Write a SOQL Query to fetch all Accounts with correspsonding Opportunities.
        // If Opp CloseDate is Today then put their amount in a seperate list.
        
        List<Account> lstAcc1 = [SELECT Id, Name, Rating, Industry,
                                (SELECT Id, Name, CloseDate, Amount FROM Opportunities)
                                FROM Account];
        
        List<Decimal> amountList = new List<Decimal>();
        for(Account acc : lstAcc1){
            if(acc.Opportunities.size() > 0){
                for(Opportunity opp : acc.Opportunities){
                    if(opp.CloseDate == System.today()){
                        amountList.add(opp.Amount);
                    }
                }
            }
        }
        system.debug('Amount List : ' + amountList);
        
        List<Account> allAcc2 = new List<Account>();
        allAcc2 = [SELECT Id, Name, Rating, Industry,
                  (SELECT Id, FirstName, LastName, Phone FROM Contacts),
                  (SELECT Id, Name, Amount, StageName FROM Opportunities)
                  FROM Account];
        
        WrapperClass obj = new WrapperClass();
        obj.accountList = new List<Account>();	// Initializing Here instead of Map.
        obj.contactList = new List<Contact>();
        obj.opportunityList = new List<Opportunity>();
        
        List<Account> aList = new List<Account>();	// aList will contains pure Account Data.
        
        obj.accountList.addAll(allAcc2);	// accountList will contain Account and its related Contacts and Opportunities data also.
        
        for(Account acc : allAcc2){
            aList.add(acc);
            obj.contactList.addAll(acc.Contacts);            
            obj.opportunityList.addAll(acc.Opportunities);
        }
        system.debug('aList : ' + aList.size());
        system.debug('accountList : ' + obj.accountList.size());
        system.debug('contactList : ' + obj.contactList.size());
        system.debug('opportunityList : ' + obj.opportunityList.size());   
    }
    
     public Class WrapperClass{
        public List<Account> accountList;
        public List<Contact> contactList;
        public List<Opportunity> opportunityList;
    }
   
}