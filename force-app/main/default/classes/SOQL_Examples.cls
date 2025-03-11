// Class 9: SOQL
public class SOQL_Examples {
	
    public static void SOQL_Practice(){
        List<Account> lstAccounts = [SELECT Id, Name, Rating, Industry, AnnualRevenue
                                    FROM Account]; // Query returns List<Account> which we are assigning to other list.
        
        system.debug('lstAccounts : ' + lstAccounts);
        system.debug('lstAccounts Size : ' + lstAccounts.size());
        
        /* Explaination of above code..
        List<Account> lAccounts = new List<Account>();
        List<Account> accList = lAccounts;
		*/	
        
        List<Account> bankingAcc = [SELECT Id, Name, Rating, Industry
                                   FROM Account
                                   WHERE Industry = 'Banking'];
        system.debug('Banking Accounts : ' + bankingAcc.size());
        
        // ALL ROWS : Fetches the Records which are in Table as well as in Recycle Bin
        List<Contact> allContacts = [SELECT Id, FirstName, LastName, Email, Phone
                                    FROM Contact ALL ROWS];
        system.debug('All Contacts : ' + allContacts.size());
        
        // LIMIT :
        List<Contact> limitedCon = [SELECT Id, FirstName, LastName, Email, Phone
                                   FROM Contact LIMIT 6];
        system.debug('Limited Contacts : ' + limitedCon.size());
        
        // Setting the limit dynamically
        Integer count = 5;
        List<Opportunity> limitedOpps = [SELECT Id, Name, Amount, CloseDate
                                        FROM Opportunity
                                        LIMIT : count];
        
        // OFFSET : This will specify from which position records should be returned
        List<Account> offSetAcc = [SELECT Id, Name, Rating, Industry
                                   FROM Account
                                   OFFSET 5];
        
        // LIMIT should be followed by OFFSET
        // SOQL Query to fetch 10 Opportunities from 5th Position
        List<Account> accList = [SELECT Id, Name, Rating, Industry
                                 FROM Account
                                 LIMIT 10
                                 OFFSET 5];
        
        // ORDER BY ASC:
        List<Account> ascOrderAcc = [SELECT Id, Name, Rating, Industry
                                    FROM Account
                                    ORDER BY Name ASC];
        system.debug('Ascending Order : ' + ascOrderAcc);
        
        // ORDER BY DESC:
        List<Account> descOrderAcc = [SELECT Id, Name, Rating, Industry
                                    FROM Account
                                    ORDER BY Name DESC];
        system.debug('Descending Order : ' + descOrderAcc);
        
        // Sort Data Based on Multiple Fields
        List<Account> accList2 = [SELECT Id, Name, Rating, Industry
                                    FROM Account
                                    ORDER BY Name ASC, Industry ASC
                                 ];
        system.debug('Order By Multiple Fields : ' + accList2);
        
        // SOQL Query to fetch last 10 Accounts records created.
        List<Account> accList3 = [SELECT Id, Name, Rating, Industry
                                 FROM Account
                                 ORDER BY CreatedDate DESC
                                 LIMIT 10];
        system.debug('CreatedDate : ' + accList.size());
        system.debug('CreatedDate : ' + accList3);
        
        // SOQL Query to fetch last 10 Accounts records Modified.
        List<Account> accList4 = [SELECT Id, Name, Rating, Industry
                                 FROM Account
                                 ORDER BY LastModifiedDate DESC
                                 LIMIT 10];
        system.debug('Modified Date : ' + accList.size());
        system.debug('Modified Date : ' + accList4);

        // SOQL Query to fetch last 10 Accounts records last Viewed.
        List<Account> accList5 = [SELECT Id, Name, Rating, Industry
                                 FROM Account
                                 ORDER BY LastViewedDate DESC
                                 LIMIT 10];
        system.debug('Last Viewed Date : ' + accList.size());
        system.debug('Last Viewed Date : ' + accList5);
        
        // Write SOQL Query to fetch all the account records
        // Put all the account names in a New List
        
        List<Account> accList6 = [SELECT Id, Name, Rating, Industry, AnnualRevenue, Website
                                 FROM Account];
        List<String> accList6Names = new List<String>();
        
        for(Account acc : accList6){
            accList6Names.add(acc.Name);
        }
        system.debug('Account Names List : ' + accList6Names);
       	
		// Write SOQL Query to fetch all the account records
        // Put all the account whose rating is Hot in a new List
        
        List<Account> accList7 = [SELECT Id, Name, Rating, Industry, AnnualRevenue, Website
                                 FROM Account];
        List<Account> hotAccounts = new List<Account>();
        
        for(Account acc : accList7){
            if(acc.Rating == 'Hot'){
                hotAccounts.add(acc);
            }
        }
        system.debug('Hot Account List : ' + hotAccounts.size());
        
        // Fetch all Opportunities
        // Fetch all amounts of those opportunities whose stage is Closed Won
        
        List<Opportunity> lstOppty = [SELECT Id, Name, StageName, Amount
                                     FROM Opportunity];
        
        List<Decimal> amounts = new List<Decimal>();
        Decimal totalAmt = 0;
        for(Opportunity opp : lstOppty){
            if(opp.StageName == 'Closed Won'){
                amounts.add(opp.Amount);
                totalAmt += opp.Amount;
            }
        }
        system.debug('Total Closed Won Amount : ' + totalAmt);
        
        // --------------------------- WHERE Clause ------------------------- //
        // Class 10: SOQL 2
        
        // Account whose Industry is Banking
        List<Account> lstAcc1 = [SELECT Id, Name, Rating, Industry
                                FROM Account
                                WHERE Industry = 'Banking'];
        
        // Account whose Rating is Not Hot
        List<Account> lstAcc2 = [SELECT Id, Name, Rating, Industry
                                FROM Account
                                WHERE Rating != 'Hot'];
        
        // Opportunities whose amount is greater than 50k
        List<Opportunity> lstOppty1 = [SELECT Id, Name, Amount, StageName
                                     FROM Opportunity
                                     WHERE Amount > 50000];
        
        // Lead whose LeadSource is Web
        List<Lead> lstLeads = [SELECT Id, Name, LeadSource
                              FROM Lead
                              WHERE LeadSource = 'Web'];
        
        // ---------------- Multiple Conditions -------------------- //
        // Syntax: 
        	// WHERE <FieldName> [Operator] <Value> [AND | OR ] <FieldName> [Operator] <Value>
    
    	// Accounts whose Industry is Banking and Rating is Hot
    	List<Account> lstAcc3 = [SELECT Id, Name, Rating, Industry
                                FROM Account
                                WHERE Industry = 'Banking' AND Rating = 'Hot'];
        
        // Accounts whose Industry is Energy or Ownership is Private
        List<Account> lstAcc4 = [SELECT Id, Name, Rating, Industry, Ownership
                                FROM Account
                                WHERE Industry = 'Energy' OR Ownership = 'Private'];
       	
        // Opportunities whose Stagename is Close Won or Close Lost
        List<Opportunity> lstOppty2 = [SELECT Id, Name, StageName, Amount
                                      FROM Opportunity
                                      WHERE StageName = 'Closed Won' OR StageName = 'Closed Lost'];
        
    	// Opprtunities whose StageName is Propecting and Amount greater than 50k
    	List<Opportunity> lstOppty3 = [SELECT Id, Name, StageName, Amount
                                      FROM Opportunity
                                      WHERE StageName = 'Prospecting' OR Amount > 50000];
   
    }
}