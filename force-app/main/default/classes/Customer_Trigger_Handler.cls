public class Customer_Trigger_Handler {
	
    public static void afterInsertShare(List<Customer__c> custList){
        
        system.debug('custList : ' + custList);
        
        List<Customer__Share> custShareList = new List<Customer__Share>();
        
        User u = [SELECT Id, Name
               FROM User
               WHERE Name = 'Wil Yuth'];
        system.debug('User : ' + u.Name);
        
        for(Customer__c cust : custList){
            if(cust.Customer_Type__c == 'Personal'){
                Customer__Share cs = new Customer__Share();
                cs.ParentId = cust.Id;
                cs.AccessLevel = 'Read';
                cs.RowCause = 'Manual';
                cs.UserOrGroupId = u.Id;
                custShareList.add(cs);
            }
        }
        system.debug('custShareList size : ' + custShareList.size());
        
        if(! custShareList.isEmpty()){
            try{
                insert custShareList;
                system.debug('Records Shared Successfully !!');
            }
            catch(Exception ex){
                system.debug('============ ERROR =============');
                system.debug(ex.getMessage());
            }
        }
    }
}