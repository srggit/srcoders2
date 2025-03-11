public class SchedularApex_Ex implements Schedulable{
	
    public void execute(SchedulableContext sc){
        List<Opportunity> oppList = [SELECT Id, CloseDate, StageName
                                    FROM Opportunity
                                    WHERE CreatedDate = TODAY];
        
        for(Opportunity opp : oppList){
            opp.CloseDate = System.today() + 15;
            opp.StageName = 'Prospecting';
        }
        update oppList;
    }
}