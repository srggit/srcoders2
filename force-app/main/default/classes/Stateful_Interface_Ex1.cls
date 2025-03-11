global class Stateful_Interface_Ex1 implements Database.Batchable<sObject>, Database.Stateful {

    public Integer count = 0; 	// This variable will contain the data between execute transactions.
    public static Integer size = 0;
    
    global Database.QueryLocator start(Database.BatchableContext bc){
    	
        String query = 'SELECT Id, Name FROM Account';
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> lstAccs){
        for(Account acc : lstAccs){
            count = count + 1;
            size = size + 1;
        }
        System.debug('Count : ' + count + ' Size : ' + size);
    }
    
    global void finish(Database.BatchableContext bc){
        Account acc = new Account();
        acc.Name = 'Batch Count ' + count + ' - Batch Size : ' + size;
        acc.Rating = 'Warm';
        acc.Industry = 'Banking';
        insert acc;
	}
}

/*
Stateful_Interface_Ex1 si = new Stateful_Interface_Ex1();

Database.executeBatch(si, 20);
*/