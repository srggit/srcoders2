public class List_Of_List_Examples {
	
    public static void Practice(){
        
        List<List<Integer>> stuMarks = new List<List<Integer>>();
        
        List<Integer> stu1 = new List<Integer>{10, 20, 30, 40};
        List<Integer> stu2 = new List<Integer>{34, 54, 67, 67};
        List<Integer> stu3 = new List<Integer>{89, 34, 45, 89};
        
        stuMarks.add(stu1);
        stuMarks.add(stu2);
        stuMarks.add(stu3);
        
        
        List<String> carBrands = new List<String>{'BMW', 'Mercedes', 'Volvo', 'Tata', 'Audi'};
        List<String> bikeBrands = new List<String>{'Honda', 'Yamaha', 'Ducati', 'Bajaj'};
        List<String> clothBrands = new List<String>{'H&M', 'Celvin Kelvin', 'Raymond'};
        
        List<List<String>> allBrands = new List<List<String>>{carBrands, bikeBrands, clothBrands};


        // Get all the List values
        System.debug('========= Get All Brands List ===========');
        for(List<String> l : allBrands){
            List<String> getList = l;
            
            System.debug('brands : ' + getList);
        }

        // Get the Brands which are at Index 1 and display all the values.
        system.debug('Index 1 Brands : ' + allBrands[1]);
        
        List<String> brands = allBrands.get(1);
        for(String s : brands){
            system.debug(s);
        }
        
        // Get the Brand which is at Index 1 and in that get the brand which is at index 0.
        system.debug('Index 1 Brands : ' + allBrands[1][0]);
        
        // Create List<List<Account>>
        
        // Static Allocation
        List<Account> itAcc = new List<Account>{
            new Account (Name='Wipro', Rating='Hot', Industry='IT', AnnualRevenue=232344),
            new Account (Name='TCS', Rating='Hot', Industry='IT', AnnualRevenue=234234)
        };
        
        List<Account> bankingAcc = new List<Account>{
            new Account (Name='SBI', Rating='Cold', Industry='Banking', AnnualRevenue=7869798),
            new Account (Name='Axis', Rating='Warm', Industry='Banking', AnnualRevenue=645645)
        };
            
        List<Account> automobileAcc = new List<Account>{
            new Account (Name='Honda', Rating='Cold', Industry='Manufacturing', AnnualRevenue=678678),
            new Account (Name='TATA', Rating='Hot', Industry='Manufacturing', AnnualRevenue=8978990)
        };
            
        List<List<Account>> allAcc = new List<List<Account>>{itAcc, bankingAcc, automobileAcc};
            
        // Get the accounts at index 1 and display values
        system.debug('Accounts at index 1 : ' + allAcc[1]);
        
        List<Account> accounts1 = allAcc.get(1);
        for(Account a : accounts1){
            system.debug('Name : ' + a.Name);
            system.debug('Rating : ' + a.Rating);
            system.debug('Industry : ' + a.Industry);
            system.debug('Annual Revenue : ' + a.AnnualRevenue);
        }
        
        // Create a Wrapper Class AccountInfo with Name, Phone, Rating as DataMembers
        // Create a List<AccountInfo> and create some data.
        // Take one by one AccountInfoWrapper Records and convert into Account Records.
        
        AccountInfoWrapper acw1 = new AccountInfoWrapper();
        acw1.Name = 'Honda';
        acw1.Phone = '23425255';
        acw1.Rating = 'Hot';
        
        AccountInfoWrapper acw2 = new AccountInfoWrapper();
        acw2.Name = 'Suzuki';
        acw2.Phone = '2342424';
        acw2.Rating = 'Hot';
        
        AccountInfoWrapper acw3 = new AccountInfoWrapper();
        acw3.Name = 'Bajaj';
        acw3.Phone = '8977809';
        acw3.Rating = 'Hot';
        
        List<AccountInfoWrapper> acwList = new List<AccountInfoWrapper>{acw1, acw2, acw3};        
        
        List<Account> lstAccounts = new List<Account>();
        
        for(AccountInfoWrapper ai : acwList){
        	Account acc = new Account();
            acc.Name = ai.Name;
            acc.Phone = ai.Phone;
            acc.Rating = ai.Rating;
            
            lstAccounts.add(acc);
        }
        system.debug('Account List Size : ' + lstAccounts.size());
        
        
    	// Create a Wrapper Class ContactInfo with FirstName, LastName, PersonAge, Salary
    	// Create a List of ContactInfo and Insert the data
    	
        ContactDataWrapper cdw1 = new ContactDataWrapper();
        cdw1.FirstName='Satish';
        cdw1.LastName='Myla';
        cdw1.PersonAge=23;
        cdw1.Salary=23445.70;
        
        ContactDataWrapper cdw2 = new ContactDataWrapper();
        cdw2.FirstName='Satish';
        cdw2.LastName='Myla';
        cdw2.PersonAge=23;
        cdw2.Salary=23445.70;
        
        ContactDataWrapper cdw3 = new ContactDataWrapper();
        cdw3.FirstName='Satish';
        cdw3.LastName='Myla';
        cdw3.PersonAge=23;
        cdw3.Salary=23445.70;	
        
        List<ContactDataWrapper> cdwList = new List<ContactDataWrapper>{cdw1, cdw2, cdw3};
        
        // Write a for loop to refer to all contacts one by one and Convert into Contact.
        List<Contact> contactList = new List<Contact>();
        
        for(ContactDataWrapper c : cdwList){
            Contact con = new Contact();
            con.FirstName = c.FirstName;
            con.LastName = c.LastName;
            contactList.add(con);
        }
        
        // Create a Wrapper Class AccDetails with Name, Industry, LastName, FirstName
        // Create few Data
        // Create an Account and Contact Records from the present data.
        
        AccountDetails acc1 = new AccountDetails();
        acc1.Name = 'Wipro';
        acc1.Industry = 'IT';
        acc1.FirstName = 'Satish';
        acc1.LastName = 'Myla';
        
        AccountDetails acc2 = new AccountDetails();
        acc2.Name = 'TCS';
        acc2.Industry = 'IT';
        acc2.FirstName = 'Gopal';
        acc2.LastName = 'K';
        
        AccountDetails acc3 = new AccountDetails();
        acc3.Name = 'TATA';
        acc3.Industry = 'Manufacturing';
        acc3.FirstName = 'Hari';
        acc3.LastName = 'B';
        
        List<AccountDetails> accDetailsList = new List<AccountDetails>{acc1, acc2, acc3};
        
        List<Account> lstAccounts1 = new List<Account>();
        List<Contact> lstContacts1 = new List<Contact>();
        
        for(AccountDetails ac : accDetailsList){
            Account acc = new Account();
            acc.Name = ac.Name;
            acc.Industry = ac.Industry;
            lstAccounts1.add(acc);
            
            Contact con = new Contact();
            con.FirstName = ac.FirstName;
            con.LastName = ac.LastName;
            lstContacts1.add(con);
        }
        
    }// Method Ends Here..
    
    
    
    
    
    
    
}