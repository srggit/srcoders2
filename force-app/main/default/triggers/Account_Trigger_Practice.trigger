trigger Account_Trigger_Practice on Opportunity (after insert, after update, after delete) {
    

    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        Set<Id> accIdSet = new Set<Id>();

        for(Opportunity opp : Trigger.newMap.values()){
            accIdSet.add(opp.AccountId);
        }
        System.debug('accIdSet : ' + accIdSet);
    
        List<AggregateResult> result = [SELECT AccountId, SUM(Amount) totalAmt FROM Opportunity WHERE AccountId IN : accIdSet GROUP BY AccountId];
        System.debug('result : ' + result.size());
    
        Map<Id, Decimal> oppAmount = new Map<Id, Decimal>();
    
        for(AggregateResult r : result){
            oppAmount.put( (Id) r.get('AccountId'), (Decimal) r.get('totalAmt'));
        }
    
        List<Account> accList = [SELECT Id, Total_Amount__c FROM Account WHERE Id IN : accIdSet];
    
        for(Account acc : accList){
            acc.Total_Amount__c = oppAmount.get(acc.Id);
        }
    
        update accList;
    }
    


    if(Trigger.isAfter && Trigger.isDelete){
        Set<Id> accIdSet = new Set<Id>();

        for(Opportunity opp : Trigger.oldMap.values()){
            accIdSet.add(opp.AccountId);
        }
        System.debug('accIdSet : ' + accIdSet);

        List<AggregateResult> result = [SELECT AccountId, SUM(Amount) totalAmt FROM Opportunity WHERE AccountId IN : accIdSet GROUP BY AccountId];
        System.debug('result : ' + result.size());

        Map<Id, Decimal> oppAmount = new Map<Id, Decimal>();

        for(AggregateResult r : result){
            oppAmount.put( (Id) r.get('AccountId'), (Decimal) r.get('totalAmt'));
        }

        List<Account> accList = [SELECT Id, Total_Amount__c FROM Account WHERE Id IN : accIdSet];

        for(Account acc : accList){
            acc.Total_Amount__c = oppAmount.get(acc.Id);
        }

        update accList;
    }

    
}


/*
    Set<Id> accIdSet = new Set<Id>();

    for(Opportunity opp : Trigger.new){
        accIdSet.add(opp.AccountId);
    }

    List<AggregateResult> result = [SELECT AccountId, COUNT(Id) oppSize FROM Opportunity WHERE AccountId IN : accIdSet GROUP BY AccountId];

    Map<Id, Integer> oppSizeMap = new Map<Id, Integer>();

    for(AggregateResult r : result){
        Id accId = (Id) r.get('AccountId');
        Integer size = (Integer) r.get('oppSize');
        oppSizeMap.put(accId, size);
    }

    List<Account> lstAccounts = [SELECT Id, Total_Opportunities__c FROM Account WHERE Id IN : accIdSet];

    for(Account acc : lstAccounts){
        acc.Total_Opportunities__c = oppSizeMap.get(acc.Id);
    }

    update lstAccounts;
*/

    // --------------------------------------------------------------------- //

    /*
    // Rollup Opportunity Count To Account - AFTER INSERT
    
    Set<Id> accIdSet = new Set<Id>();

    for(Opportunity opp : Trigger.newMap.values()){
        accIdSet.add(opp.AccountId);
    }
    System.debug('accIdSet : ' + accIdSet);

    List<Account> lstAccs = [SELECT Id, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Id IN : accIdSet];
    System.debug('lstAccs : ' + lstAccs);

    Map<Id, Integer> mapOppCount = new Map<Id, Integer>();

    for(Account acc : lstAccs){
        mapOppCount.put(acc.Id, acc.Opportunities.size());
    }    
    System.debug('mapOppCount : '  + mapOppCount);

    for(Account acc : lstAccs){
        acc.Total_Opportunities__c = mapOppCount.get(acc.Id);
    }

    update lstAccs;
    */

    

    /*
    // Rollup Opportunity Amount in Account

        Map<Id, List<Opportunity>> accIdOppMap = new Map<Id, List<Opportunity>>();

    for(Opportunity opp : Trigger.newMap.values()){

        if(accIdOppMap.containsKey(opp.AccountId)){
            List<Opportunity> lstOpp = accIdOppMap.get(opp.AccountId);
            lstOpp.add(opp);
            accIdOppMap.put(opp.AccountId, lstOpp);
        }
        else{
            List<Opportunity> lstOpp = new List<Opportunity>();
            lstopp.add(opp);
            accIdOppMap.put(opp.AccountId, lstOpp);
        }
    }

    System.debug('accIdOppMap : ' + accIdOppMap);

    Map<Id, Decimal> accToUpdate = new Map<Id, Decimal>();

    for(Id accId : accIdOppMap.keySet()){
        Decimal total = 0;

        for(Opportunity opp : accIdOppMap.get(accId)){
            total = total + opp.Amount;
        }
        accToUpdate.put(accId, total);
    }

    List<Account> lstAccounts = [SELECT Id, Total_Amount__c FROM Account WHERE Id IN : accToUpdate.keySet()];

    for(Account acc : lstAccounts){
        acc.Total_Amount__c = acc.Total_Amount__c + accToUpdate.get(acc.Id);
    }

    if(! lstAccounts.isEmpty()){
        update lstAccounts;
    }

    
    */