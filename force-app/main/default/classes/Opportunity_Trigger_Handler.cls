public class Opportunity_Trigger_Handler {
    
    // Only 5 opportunities can be created for an Object
    public static void beforeInsert(List<Opportunity> oppList){
        
        Set<Id> accIds = new Set<Id>();
        
        for(Opportunity opp : oppList){
            if(opp.AccountId != null)
                accIds.add(opp.AccountId);
        }
        
        Map<Id, Integer> accOppCount = new Map<Id, Integer>();
        
        if(! accIds.isEmpty()){
            List<AggregateResult> result = [SELECT AccountId, COUNT(Id) oppCount
                                            FROM Opportunity
                                            WHERE AccountID IN : accIds
                                            GROUP BY AccountId];
            
            for(AggregateResult r : result){
                Id accId = (Id) r.get('AccountId');
                Integer totalOpp = (Integer) r.get('oppCount');
                system.debug('Total Opportunities : ' + totalOpp);
                
                accOppCount.put(accId, totalOpp);
            }
            
            for(Opportunity opp : oppList){
                Id parentId = opp.AccountId;
                
                if(parentId != null){
                    if(accOppCount.get(opp.AccountId) >= 5){
                        opp.addError('More than 5 Opportunities cannot be created for an Account');
                    }
                }
            }
        }
    }
    
    // Whenever the Opportunity Stage is Closed Won, Share the record with Manager.
    public static void afterInsertShare(List<Opportunity> oppList){
        List<OpportunityShare> shareList = new List<OpportunityShare>();
        
        for(Opportunity opp : oppList){
            if(opp.stageName == 'Closed Won'){
                OpportunityShare os = new OpportunityShare();
                os.OpportunityId = opp.Id;
                os.UserOrGroupId = opp.Manager__c;
                os.OpportunityAccessLevel = 'Read';
                os.RowCause = 'Manual';
                
                shareList.add(os);
            }
        }
        
        if(shareList.size() > 0) {
            try {
                insert shareList;
                System.debug('Records shared successfully.');
            } catch(Exception e) {
                System.debug('Error during sharing: ' + e.getMessage());
            }
        }
    }
    
    // Logic to check whether the StageName is changed or not
    public static void beforeUpdateCheckStage(Map<Id, Opportunity> oldOppMap, Map<Id, Opportunity> newOppMap){
        
        // Get the Ids of all Updated Opportunities Records
        Set<Id> oppIdSet = oldOppMap.keySet();
        
        for(Id oppId : oppIdSet){
            /*
Opportunity oldValue = oldOppMap.get(oppId);
Opportunity newValue = newOppMap.get(oppId);

if(oldValue.get('StageName') != newValue.get('StageName')){
system.debug('Stage value is Changed');
}
*/
            
            /*
if(oldOppMap.get(oppId).get('StageName') != newOppMap.get(oppId).get('StageName')){
system.debug('Stage value is Changed 2.');
}
*/ 
            if(oldOppMap.get(oppId).StageName != newOppMap.get(oppId).StageName){
                system.debug('Stage value is Changed 3.');
            }
            
        }
    }
    
    //Trigger to share the record with Current Owners Manager whenever the StageName is Changed to 'Closed Won'.
    public static void afterUpdateShareRecord(Map<Id, Opportunity> oldOppMap, Map<Id, Opportunity> newOppMap){
        system.debug('Method Name : afterUpdateShareRecord');
        
        Set<Id> oppIdSet = newOppMap.keySet();
        List<OpportunityShare> oppShareList = new List<OpportunityShare>();
        
        Map<Id, Id> oppIdManager = new Map<Id, Id>();	// Map<OppId, Opp_User_Manager_Id>
        
        Map<Id, Opportunity> oppUserMap = new Map<Id, Opportunity>([
            SELECT Id, Name, OwnerId, Owner.UserRoleId, Owner.ManagerId FROM Opportunity WHERE Id IN : oppIdSet
        ]);
        
        for(Opportunity opp : oppUserMap.values()){
			oppIdManager.put(opp.Id, opp.Owner.ManagerId);
        }
        system.debug('oppIdManager : ' + oppIdManager);
        
        for(Id oppId : oppIdSet){
            system.debug('Inside For : ' + newOppMap.get(oppId).StageName);
            system.debug('Manager Id : ' + oppIdManager.get(oppId));
            
            // oldOppMap.get(oppId).StageName != newOppMap.get(oppId).StageName && 
            if(newOppMap.get(oppId).StageName == 'Closed Won' && oldOppMap.get(oppId).StageName != 'Closed Won'){
                
                system.debug('StageName is Changed to Closed Won');
                
                OpportunityShare os = new OpportunityShare();
                os.OpportunityId = oppId;
                os.OpportunityAccessLevel = 'Read';
                os.RowCause = 'Manual';
                os.UserOrGroupId = oppIdManager.get(oppId);
                
                oppShareList.add(os);
                system.debug('Opportunity Share List Created.');
            }
        }
        
        try{
            if(! oppShareList.isEmpty()){
                insert oppShareList;
                system.debug('Opportunity shared with the Owners Manager.');
            }
        }
        catch(Exception ex){
            system.debug('=========== ERROR ===========');
            system.debug(ex.getLineNumber() + '---' + ex.getMessage());
        }
    }
    
    
    // Satish Code..
	public static void afterUpdateShareRecordSatish(Map<Id, Opportunity> oldOppMap, Map<Id, Opportunity> newOppMap){
        
        system.debug('-------- afterUpdateShareRecordSatish --------');
        
        Set<Id> ownerIdSet = new Set<Id>();
        
        List<Opportunity> oppList = newOppMap.values();
        for(Opportunity opp : oppList){
            ownerIdSet.add(opp.OwnerId);
        }
        
        List<User> users = [SELECT Id, Name, ManagerId FROM User WHERE Id IN : ownerIdSet];
        
        Map<Id, Id> oppUserManagerMap = new Map<Id, Id>();
        for(User u : users){
            oppUserManagerMap.put(u.Id, u.ManagerId);
        }
        
        List<OpportunityShare> oppShareList = new List<OpportunityShare>();
        
        Set<Id> oldOppIdSet = oldOppMap.keySet();
        
        for(Id key : oldOppIdSet){
            Opportunity oldOpp = oldOppMap.get(key);
            Opportunity newOpp = newOppMap.get(key);
            
            if(oldOpp.StageName != 'Closed Won' && newOpp.StageName == 'Closed Won'){
                OpportunityShare os = new OpportunityShare();
                os.OpportunityAccessLevel = 'Read';
                os.OpportunityId = key;
                os.RowCause = 'Manual';
                os.UserOrGroupId = oppUserManagerMap.get(newOpp.OwnerId);
                
                oppShareList.add(os);
            }
        }
        
        try{
            if(! oppShareList.isEmpty()){
                insert oppShareList;
                system.debug('Opportunity shared with the Owners Manager.');
            }
        }
        catch(Exception ex){
            system.debug('=========== ERROR ===========');
            system.debug(ex.getLineNumber() + '---' + ex.getMessage());
        }
    }
    
    // Whenever the Owner of Opportunity is modified Create Old Owner as Opp Team Member.
    public static void afterUpdateCreateTeamMember(Map<Id, Opportunity> oldMap, Map<Id, Opportunity> newMap){
		
        system.debug('============ afterUpdateCreateTeamMember ============');      

		Set<Id> oppIdSet = newMap.keySet();
        List<OpportunityTeamMember> otmList = new List<OpportunityTeamMember>();
        
        for(Id oppId : oppIdSet){
            system.debug('------- Inside For -------');
            system.debug('Old Owner : ' + oldMap.get(oppId).OwnerId);
            system.debug('New Owner : ' + newMap.get(oppId).OwnerId);
            
            Opportunity newOpp = newMap.get(oppId);
            Opportunity oldOpp = oldMap.get(oppId);
            
            if(oldMap.get(oppId).OwnerId != newMap.get(oppId).OwnerId){
                system.debug('------ Inside If Condition -------');
                OpportunityTeamMember otm = new OpportunityTeamMember();
                otm.OpportunityId = oppId;
                otm.OpportunityAccessLevel = 'Read';
                otm.TeamMemberRole = 'Account Manager';
                otm.UserId = oldMap.get(oppId).OwnerId;
                
                otmList.add(otm);
                system.debug('otmList : ' + otmList);
            }
        }
        
        if(! otmList.isEmpty()){
            try{
                insert otmList;
            	system.debug('OTM created Successfully');
            }
            catch(Exception ex){
				system.debug('======== ERROR =======');
                system.debug(ex.getLineNumber() + ' --- ' + ex.getMessage());
            }             
        }
        
    }
}