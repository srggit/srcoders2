// Governing Limits
public class Governing_Limits {
	
    //System.LimitException: Too many SOQL queries: 101
    public void soqlLimit(){
        for(Integer i=0; i<=101; i++){
            List<Account> lstAcc = [SELECT Id FROM Account];
        }
    }
    
    //System.LimitException: Too many DML statements: 151
    public void dmlLimit(){
        for(Integer i=0; i<=151; i++){
            Account acc = new Account(
                Name = 'Asus',
                Rating = 'Hot',
                Industry = 'Manufacturing',
                AnnualRevenue = 900000
            );
            insert acc;
        }
    }
    
    //System.LimitException: Too many DML rows: 10001
    public void dmlRowsLimit(){
        List<Account> accList = new List<Account>();
        for(Integer i=0; i<=10001; i++){
            Account acc = new Account(
                Name = 'Asus',
                Rating = 'Hot',
                Industry = 'Manufacturing',
                AnnualRevenue = 900000
            );
        
        	accList.add(acc);
        }
        insert accList;
        
    }
}