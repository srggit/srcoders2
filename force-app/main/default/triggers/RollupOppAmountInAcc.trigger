trigger RollupOppAmountInAcc on Opportunity (after insert, before insert) {
    
    
    // Rollup All Opportunities Amount to Related Account Using AggregateResult
    if(Trigger.isAfter && Trigger.isInsert){
        Set<Id> accIds = new Set<Id>();
        for(Opportunity opp : Trigger.new){
            accIds.add(opp.AccountId);
        }
        
        List<AggregateResult> result = [SELECT AccountId, SUM(Amount) totalAmt 
                                        FROM Opportunity WHERE AccountId IN : accIds
                                        GROUP BY AccountId];
        
        Map<Id, Decimal> amountMap = new Map<Id, Decimal>();
        
        for(AggregateResult r : result){
            amountMap.put( (Id) r.get('AccountId'), (Decimal) r.get('totalAmt'));   
        }
        
        List<Account> accListToUpdate = new List<Account>();
        for(Id key : accIds){
            Account acc = new Account(Id = key);
            acc.Total_Amount__c = amountMap.get(key) == null ? 0 : amountMap.get(key);
            
            accListToUpdate.add(acc);
        }
        
        if(! accListToUpdate.isEmpty()){
            update accListToUpdate;
        }
        
        /*
        List<Account> accountsToUpdate = [SELECT Id, Total_Amount__c FROM Account WHERE Id IN : accIds];
        for(Account acc : accountsToUpdate){
            if(amountMap.containsKey(acc.Id))
                acc.Total_Amount__c = amountMap.get(acc.Id) == null ? 0 : amountMap.get(acc.Id);
        }
        
        if(! accountsToUpdate.isEmpty()){
            update accountsToUpdate;
        }
        */
    }
	
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
        
        // Note: Without quering we cannot update values.
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
    
    // Rollup Total Opportunities Count to Related Account
    if(Trigger.isAfter && Trigger.isInsert){
        
        Set<Id> accIds = new Set<Id>();
        for(Opportunity opp : Trigger.new){
            accIds.add(opp.AccountId);
        }
        
        List<Account> lstAccounts = [SELECT Id, (SELECT Id FROM Opportunities) 
                                     FROM Account WHERE Id IN : accIds];
        
        Map<Id, Integer> mapOppSize = new Map<Id, Integer>();
        for(Account acc : lstAccounts){
            mapOppSize.put(acc.Id, acc.Opportunities.size());
        }
        
        for(Account acc : lstAccounts){
            acc.Total_Opportunities__c = mapOppSize.get(acc.Id) == null ? 0 : mapOppSize.get(acc.Id);
        }
        
        if(! lstAccounts.isEmpty()){
            update lstAccounts;
        }
    }
    
    
}