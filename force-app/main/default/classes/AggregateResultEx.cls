// Class 13: Child Parent SOQL Query
// 00:28:00

public class AggregateResultEx {
    public AggregateResultEx(){
        AggregateResult result = [SELECT 
                                 COUNT(StageName) totalCount,
                                 SUM(Amount) totalAmount,
                                 MAX(Amount) maxAmount,
                                 MIN(Amount) minAmount,
                                 AVG(Amount) avgAmount
                                 FROM Opportunity];
        
        Integer stageCount = (Integer) result.get('totalCount');
        system.debug('StageCount : ' + stageCount);
        
		Decimal totalAmt = (Decimal) result.get('totalAmount');
        Decimal maxAmt   = (Decimal) result.get('maxAmount');
        Decimal minAmt   = (Decimal) result.get('minAmount');
        Decimal avgAmt   = (Decimal) result.get('avgAmount');
        
        system.debug('totalAmt : ' + totalAmt);
        system.debug('maxAmt : ' + maxAmt);
        system.debug('minAmt : ' + minAmt);
        system.debug('avgAmt : ' + avgAmt);
        
        // GROUP BY Clause
        List<AggregateResult> aggregateList = [SELECT StageName,
                                              Count(Id) totalRecords,
                                              SUM(Amount) totalAmount,
                                              MAX(Amount) maxAmount,
                                              MIN(Amount) minAmount,
                                              AVG(Amount) avgAmount
                                              FROM Opportunity
                                              GROUP BY StageName];
        system.debug(aggregateList);
        
        for(AggregateResult res : aggregateList){
            system.debug('StageName : ' + res.get('StageName'));
            
            Integer totalRec1 = (Integer) res.get('totalRecords');
            Decimal totalAmt1 = (Decimal) res.get('totalAmount');
            Decimal maxAmt1   = (Decimal) res.get('maxAmount');
            Decimal minAmt1   = (Decimal) res.get('minAmount');
            Decimal avgAmt1   = (Decimal) res.get('avgAmount');
            
            system.debug('totalRecords ' + totalRec1);
            system.debug('totalAmt : ' + totalAmt1);
            system.debug('maxAmt : ' + maxAmt1);
            system.debug('minAmt : ' + minAmt1);
            system.debug('avgAmt : ' + avgAmt1);
            system.debug('\n');
        }
        
        // Write SOQL Query to fetch SUM of Opportunity Amount whose StageName is 'Closed Won'.
  		
        AggregateResult aggResult = [SELECT SUM(Amount) totalAmt
                                    FROM Opportunity
                                    WHERE StageName = 'Closed Won'];
        
        Decimal closedWonAmt = (Decimal) aggResult.get('totalAmt');
        system.debug('closedWonAmt : ' + closedWonAmt);
        
        
    }
}