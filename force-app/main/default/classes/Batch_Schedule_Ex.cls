global class Batch_Schedule_Ex implements Database.Batchable<sObject>, Schedulable{
	
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT Id, Name FROM Account WHERE CreatedDate = LAST_WEEK LIMIT 1';
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> accList){
        Database.delete(accList, false);
    }
    
    global void finish(Database.BatchableContext bc){
        // Nothing here to execute..
    }
    
    public void execute(SchedulableContext sc){
        // Schedule the Batch Apex
        Batch_Schedule_Ex bs = new Batch_Schedule_Ex();
        Id jobId = Database.executeBatch(bs);
    }
}

/* It will call execute() of schedule apex.
Batch_Schedule_Ex bse = new Batch_Schedule_Ex();
String cron = '0 07 14 08 10 ?';
System.schedule('Batch Schedule', cron, bse);
*/