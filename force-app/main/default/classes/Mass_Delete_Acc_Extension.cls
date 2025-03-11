// Class 19: 00:48:00
// ApexPages.StandardSetController: Used to process mass Operation on records.

public class Mass_Delete_Acc_Extension {
    public List<Account> lstAccounts {get;set;}
    
    public Mass_Delete_Acc_Extension(ApexPages.StandardSetController controller){
        // ApexPages.StandardSetController will refer to Multiple Records.
        // ApexPages.StandardSetController will have the data in the form on sObject.
        // Because we don't know in which form the data is going to come.
        // Controller will return only Id of the records, if we want any another fields other than ID
        // we need to add those fields to controller.
        String[] fields = new String[]{'Name', 'Rating', 'Industry', 'Phone', 'AnnualRevenue'};
        controller.addFields(fields);
        
        lstAccounts = (List<Account>) controller.getSelected();
    }
    
    public PageReference deleteRecords(){
        PageReference p;
        
        try{
            Database.delete(lstAccounts, false); // If deletion failed, skip that record and delete remaining records.
            
            p = new PageReference('/001/o');
        }
        catch(Exception ex){
            system.debug('=========== ERROR =============');
            system.debug(ex.getLineNumber() + '----- ' + ex.getMessage());
        }
        
        return p;
    }
}