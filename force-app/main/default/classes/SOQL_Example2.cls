public class SOQL_Example2 {
	
    public String accName			{get;set;}
    public String accIndustry		{get;set;}
    public List<Account> accounts	{get;set;}
    
    public void search(){
        /*
        accounts = [SELECT Id, Name, Rating, Industry, Phone, Website
                   FROM Account
                   WHERE Name =: accName
                   OR Industry =: accIndustry];
        */
		String query = 'SELECT Id, Name, Rating, Industry, Phone, Website FROM Account';
        // If Both Fields are not Empty
        if(accName != '' && accIndustry != ''){
            //query = query + ' WHERE Name = \'' + accName + '\' AND Industry =  \'' + accIndustry + '\'';
            query = query + ' WHERE Name =: accName AND Industry =: accIndustry';
        }
        // If AccName is Not Blank and Industry is Blank
        else if(accName != ''){
            //query = query + ' WHERE Name = \'' + accName + '\'';
        	query = query + ' WHERE Name =: accName';

        }
        // If Industry is Not Blank and AccName is Blank
        else if(accIndustry != ''){
            //query = query + ' WHERE Industry = \'' + accIndustry + '\'';
            query = query + ' WHERE Industry =: accIndustry';
        }
        
        accounts = Database.query(query);
        
        String leadPhone = '2834827834';
        String leadEmail = 'lead@gmail.com';
        String leadQuery = 'SELECT Id, FirstName, LastName, Phone, Email FROM Lead';
        leadQuery = leadQuery + ' WHERE Phone = \'' + leadPhone + '\'';
        leadQuery = leadQuery + ' AND Email = \'' + leadEmail + '\'';
		
    }
    
    /*
    public static void test(){
        system.debug('  \'Prasad  ');
        system.debug('  \'Prasad\'Kiran\'   ');
        system.debug('  \'Praveen\'\'\'Kiran\'   ');
        
        // Dynamic Query 1
        String name = 'Ravi';
        String query1 = '  WHERE name = \'  ' + name +  ' \'    ';
        
        // Dynamic Query 2
        String field = 'Banking';
        String Industry = field;
		
        String query2 = ' WHERE Industry = \' ' + field + ' \'     ';
 		system.debug('query 2 : ' + query2);
		
        // Dynamic Query 3
        String accName = 'Wipro';
        String accIndustry = 'Banking';
        //String name='Wipro' and Industry='Banking'
        
        String query3 = 'WHERE Name = \' ' + accName + '\' AND Industry = ' + '\'' + accIndustry + '\'  ';
        system.debug('query3 : ' + query3);
        
    }
	*/
}