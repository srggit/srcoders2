// Trigger to not allow downgrading of stageName in Opportunity.

trigger StageDowngradingNotAllowed on Opportunity (after insert, before update) {
	
    // Rollup Amount to Account without AggregarteResult
    if(Trigger.isAfter && Trigger.isInsert){
        
        Map<Id, List<Opportunity>> accOppMap = new Map<Id, List<Opportunity>>();
        for(Opportunity opp : Trigger.new){
            
            if(accOppMap.containsKey(opp.AccountId)){
                List<Opportunity> oppList2 = accOppMap.get(opp.AccountId);
                oppList2.add(opp);
                accOppMap.put(opp.AccountId, oppList2);
            }
            else{
                List<Opportunity> oppList1 = new List<Opportunity>();
                oppList1.add(opp);
                accOppMap.put(opp.AccountId, oppList1);
            }
        }
        
        Map<Id, Decimal> accAmountMap = new Map<Id, Decimal>();
        for(Id key : accOppMap.keySet()){
            Decimal amt = 0;
            for(Opportunity opp : accOppMap.get(key)){
                if(opp.Amount != null){
                    amt = amt = opp.Amount;
                }
            }
            accAmountMap.put(key, amt);
            System.debug('accAmountMap : ' + accAmountMap);
        }      
        
        List<Account> accListToUpdate = [SELECT Id, Total_Amount__c FROM Account WHERE Id IN : accAmountMap.keySet()];
        System.debug('accListToUpdate : ' + accListToUpdate);
        
        if(! accListToUpdate.isEmpty()){
            for(Account acc : accListToUpdate){
                System.debug('acc.Total_Amount__c : ' + acc.Total_Amount__c);	
                
                if(acc.Total_Amount__c == null){
                    acc.Total_Amount__c = 0;
                } 
                acc.Total_Amount__c = acc.Total_Amount__c + accAmountMap.get(acc.Id);
            }
        }
        if(! accListToUpdate.isEmpty()){
            update accListToUpdate;
        }
    }
    
    
    
    if(Trigger.isBefore && Trigger.isUpdate){
        
        Map<String, Integer> stageOrder = new Map<String, Integer>();
        stageOrder.put('Prospecting', 1);
        stageOrder.put('Qualification', 2);
        stageOrder.put('Needs Analysis', 3);
        stageOrder.put('Value Proposition', 4);
        stageOrder.put('Id. Decision Makers', 5);
        stageOrder.put('Perception Analysis', 6);
        stageOrder.put('Proposal/Price Quote', 7);
        stageOrder.put('Negotiation/Review', 8);
        stageOrder.put('Closed Won', 9);
        stageOrder.put('Closed Lost', 10);
        
        /*
        // Define stage order using a Map
        Map<String, Integer> stageOrder = new Map<String, Integer>{
            'Prospecting' => 1,
            'Qualification' => 2,
            'Proposal/Price Quote' => 3,
            'Negotiation/Review' => 4,
            'Closed Won' => 5,
            'Closed Lost' => 6
            };
        */             
        System.debug(stageOrder);
        
        for(Opportunity opp : Trigger.new){
            Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
			System.debug('oldOpp StageName : ' + oldOpp.StageName);
            System.debug('opp StageName : ' + opp.StageName);
            
            if(oldOpp.StageName != null && stageOrder.containsKey(oldOpp.StageName) && stageOrder.containsKey(opp.StageName)){
                
                Integer oldStageRank = stageOrder.get(oldOpp.StageName);		// Need Analysis 			2 
           		Integer newStageRank = stageOrder.get(opp.StageName);           // Prospecting  			1	    		 
                System.debug('oldStageRank : ' + oldStageRank);
                System.debug('newStageRank : ' + newStageRank);
                
                if(oldStageRank > newStageRank)
                    opp.addError('You cannot downgrade the Stage For Opportunity !! ');
            }
        }
    }
}