public class QueueableApex_Ex implements Queueable {

    public void execute(QueueableContext qc){
        List<Account> lstAcc = [SELECT Id 
                               FROM Account
                               WHERE CreatedDate = TODAY 
                               LIMIT 1];
        
        if(! lstAcc.isEmpty()){
            delete lstAcc;
        }
        
        List<Opportunity> lstOpps = [SELECT Id, StageName
                                    FROM Opportunity
                                    WHERE CreatedDate = LAST_WEEK 
                                    LIMIT 1];
        
        for(Opportunity opp : lstOpps){
            opp.StageName = 'Closed Won';
        }
        
        update lstOpps;
    }
}