// Class 16: Non-Atomic Operations
public class Non_Atomic_Operations {
	
    public Non_Atomic_Operations(){
        Account acc1 = new Account();
        acc1.Name = 'Pizza Hut';
        acc1.Phone = '2825-234243';
        acc1.Rating = 'Hot';
        acc1.Industry = 'Manufacturing';
        
        Account acc2 = new Account();
        //acc2.Name = 'Dominos';
        acc2.Phone = '23900-23423';
        acc2.Rating = 'Warm';
        acc2.Industry = 'Manufacturing';
        
        List<Account> lstAccounts = new List<Account>{acc1, acc2};
            
        List<Database.SaveResult> result = Database.insert(lstAccounts, false);	// Non-Atomic
        
        for(Database.SaveResult sr : result){
            if(sr.isSuccess()){
                system.debug('Id :  ' + sr.getId());
            }
            else{
                for(Database.Error err : sr.getErrors()){
                    system.debug('-------------- ERRORS --------------');
                    system.debug('Error Field : ' + err.getFields());
                    system.debug('Error Message : ' + err.getMessage());
                }
            }
        }
    }
}