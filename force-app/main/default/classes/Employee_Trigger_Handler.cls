// Employee is Parent of Payments and if Parent has Child we cannot delete Parent checkbox is Checked.
// Before deleting the Parent we have to check that if any child exists, if exists delete those child first then delete parent

public class Employee_Trigger_Handler {
	
    // Satish Logic
    public static void beforeDeleteCheckChild1(Map<Id, Employee__c> mapEmp){
        system.debug('----- beforeDeleteCheckChild1 -----');
        system.debug('mapEmp : ' + mapEmp);
        
        Set<Id> empIds = mapEmp.keySet();
        system.debug('empIds : ' + empIds);
        
        List<Payment__c> lstPayments = [SELECT Id, Name 
                                       FROM Payment__c 
                                       WHERE Employee__c IN : empIds];
        
        system.debug('lstPayments : ' + lstPayments);
        
        if(! lstPayments.isEmpty()){
            delete lstPayments;
        }
    }
    
    // My Logic: Lengthy
    public static void beforeDeleteCheckChild(List<Employee__c> empList){
        
        system.debug('======== beforeDeleteCheckChild Trigger =========');
        
        Set<Id> empIdSet = new Set<Id>();
        for(Employee__c emp : empList){
            empIdSet.add(emp.Id);
        }
       
        Map<Id, Integer> mapChildCount = new Map<Id, Integer>(); // Map<OppId, OppChildCount>()
        Map<Id, List<Payment__c>> mapEmpPay = new Map<Id, List<Payment__c>>();
        
        List<Employee__c> lstEmp = [SELECT Id, Name,
                                    (SELECT Id, Name FROM Payments__r WHERE Employee__c IN : empIdSet)
                                   FROM Employee__c];
    	system.debug('lstEmp : ' + lstEmp);
        
        for(Employee__c emp : lstEmp){
            mapChildCount.put(emp.Id, emp.Payments__r.size());
            mapEmpPay.put(emp.Id, emp.Payments__r);
        }
        system.debug('mapEmpPay : ' + mapEmpPay);
        
        Set<Id> paymentIdsToDelete = new Set<Id>();
        List<Payment__c> lstPayToDelete = new List<Payment__c>();
        
        for(Employee__c emp : empList){
            List<Payment__c> payList = mapEmpPay.get(emp.Id);
            
            if(payList.size() > 0){
                lstPayToDelete.addAll(payList);
            }
        }
        system.debug('lstPayToDelete : ' + lstPayToDelete);
        
        if(! lstPayToDelete.isEmpty()){
            try{
                delete lstPayToDelete;
                system.debug('Employee Child (Payments) deleted Successfully !!');
            }
            catch(Exception ex){
                system.debug('========== ERROR ==========');
                system.debug(ex.getLineNumber() + '  ----  ' + ex.getMessage());
            }
        }
    }
    
    
}