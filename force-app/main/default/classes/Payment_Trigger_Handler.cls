public class Payment_Trigger_Handler {
    
    // Whenever a New Payment is created without EmployeeId throw Error
    // Before Insert : Check whether the Employee Id is Mentined while creating Payments or not.
    public static void employeeIdIsMust(List<Payment__c> lstPayments){
        system.debug('------ employeeIdIsMust Method ------');
        
        for(Payment__c p : lstPayments){
            if(p.Employee__c == null){
                p.Employee__c.addError('Trigger: Choose the Employee !!');
            }
        }
    }
    
    // After Insert : Create a Rollup Summary on Employee and Get the Total Payment in Employee Object.
    public static void rollupPayments(Map<Id, Payment__c> mapPayments){
        system.debug('------ rollupPayments Trigger ------');
		
        Set<Id> paymentIdSet = mapPayments.keySet();
        Map<Id, List<Payment__c>> mapEmpPay = new Map<Id, List<Payment__c>>(); // Empty
        
        // Group Records as Parent and its related Childs
        for(Payment__c p : mapPayments.values()){
            
            Id empId = p.Employee__c;
            
            // If the employee already has a list of payments, add to the list
            if(mapEmpPay.containsKey(empId)){
                List<Payment__c> pList = mapEmpPay.get(empId);
                pList.add(p);
                mapEmpPay.put(empId, pList);
            }
            else{
                // Initialize a new list for the employee and add the first payment
                List<Payment__c> pList = new List<Payment__C>();
                pList.add(p);
                mapEmpPay.put(empId, pList);
            }
        }
        
        // Calculate total for all Child Records as per the Parent
        Map<Id, Decimal> empTotalMapToUpdate = new Map<Id, Decimal>(); // Map<EmpId, Total>()
        for(Id empId : mapEmpPay.keySet()){
            Decimal totalPay = 0;
            
            for(Payment__c p : mapEmpPay.get(empId)){
                totalPay += p.Amount__c;
            }
            empTotalMapToUpdate.put(empId, totalPay);
        }
        
        // Update the Parent with Rollup Values
        List<Employee__c> empListToUpdate = [SELECT Id, Name, Total__c
                                            FROM Employee__c
                                            WHERE Id IN : empTotalMapToUpdate.keySet()];
        
        for(Employee__c emp : empListToUpdate){
            emp.Total__c = emp.Total__c + empTotalMapToUpdate.get(emp.Id);
        }
        
        if(! empListToUpdate.isEmpty()){
            try{
                update empListToUpdate;
                system.debug('Employee Total Field Updated Successfully !!');
            }
            catch(Exception ex){
                system.debug('======== ERROR ========');
                system.debug(ex.getLineNumber() + ' ---- ' + ex.getMessage());
            }
        }
    }
    
    // After Delete : Create a Rollup Summary on Employee and Get the Total Payment in Employee Object.
    public static void rollupPaymentsAfterDelete(Map<Id, Payment__c> mapPayments){
        system.debug('------ rollupPaymentsAfterDelete Method ------');
		
        Set<Id> paymentIdSet = mapPayments.keySet();
        system.debug('paymentIdSet : ' + paymentIdSet);
        
        Map<Id, List<Payment__c>> mapEmpPay = new Map<Id, List<Payment__c>>(); // Empty
        
        // Group Records as Parent and its related Childs
        for(Payment__c p : mapPayments.values()){
            
            Id empId = p.Employee__c;
            
            // If the employee already has a list of payments, add to the list
            if(mapEmpPay.containsKey(empId)){
                List<Payment__c> pList = mapEmpPay.get(empId);
                pList.add(p);
                mapEmpPay.put(empId, pList);
            }
            else{
                // Initialize a new list for the employee and add the first payment
                List<Payment__c> pList = new List<Payment__C>();
                pList.add(p);
                mapEmpPay.put(empId, pList);
            }
        }
        
        // Calculate total for all Child Records as per the Parent
        Map<Id, Decimal> empTotalMapToUpdate = new Map<Id, Decimal>(); // Map<EmpId, Total>()
        for(Id empId : mapEmpPay.keySet()){
            Decimal totalPay = 0;
            
            for(Payment__c p : mapEmpPay.get(empId)){
                totalPay += p.Amount__c;
            }
            empTotalMapToUpdate.put(empId, totalPay);
        }
        
        // Update the Parent with Rollup Values
        List<Employee__c> empListToUpdate = [SELECT Id, Name, Total__c
                                            FROM Employee__c
                                            WHERE Id IN : empTotalMapToUpdate.keySet()];
        
        for(Employee__c emp : empListToUpdate){
            emp.Total__c = emp.Total__c - empTotalMapToUpdate.get(emp.Id);
        }
        
        if(! empListToUpdate.isEmpty()){
            try{
                update empListToUpdate;
                system.debug('Employee Total Field Updated Successfully !!');
            }
            catch(Exception ex){
                system.debug('======== ERROR ========');
                system.debug(ex.getLineNumber() + ' ---- ' + ex.getMessage());
            }
        }
    }
    
    // After Update : Create a Rollup Summary on Employee and Get the Total Payment in Employee Object.
    public static void rollupPaymentsAfterUpdate(Map<Id, Payment__c> newPayMap, Map<Id, Payment__c> oldPayMap){
        system.debug('------ rollupPaymentsAfterUpdate Method ------');
		
        // WE WANT TO GET ALL THE PAYMENT RECORDS OF THE EMPLOYEE TO GET THE TOTAL OF ALL THE PAYMENT AMOUNTS
        Set<Id> paymentIdSet = newPayMap.keySet();
        system.debug('paymentIdSet : ' + paymentIdSet);
        
        // We are getting all the payment records and not just updated ones
        Set<Id> empIds = new Set<Id>(); // Employee Id Set
        for(Payment__c p : newPayMap.values()){
            empIds.add(p.Employee__c);
        } 	
        system.debug('empIds : ' + empIds);
        
        List<Payment__c> allRelatedPayments = [SELECT Id, Name, Employee__c, Amount__c
                                               FROM Payment__c
                                               WHERE Employee__c IN : empIds];
        
        Map<Id, List<Payment__c>> empIdAndPayMap = new Map<Id, List<Payment__c>>();
        
        // Group Records as Employee and its related Payments
        for(Payment__c p : allRelatedPayments){
            system.debug('Inside For');
            Id empId = p.Employee__c;
            
            if(empIdAndPayMap.containskey(empId)){
                List<Payment__c> payList = empIdAndPayMap.get(empId);
                payList.add(p);
                empIdAndPayMap.put(empId, payList);
            }
            else{
                List<Payment__c> payList = new List<Payment__c>();
                payList.add(p);
                empIdAndPayMap.put(empId, payList);
            }
        }
        
        // Calculate total for all payments grouped by employee
        Map<Id, Decimal> empTotalMapToUpdate = new Map<Id, Decimal>();
        
        for(Id empId : empIdAndPayMap.keySet()){
            Decimal totalPay = 0;
            
            for(Payment__c p : empIdAndPayMap.get(empId)){
                totalPay += p.Amount__c;
            }
            empTotalMapToUpdate.put(empId, totalPay);
        }
        
        // Fetch the Employee records and update their total payment field
        List<Employee__c> empToUpdateList = [SELECT Id, Name, Total__c
                                        FROM Employee__c
                                        WHERE Id IN : empTotalMapToUpdate.keySet()];
        
        for(Employee__c emp : empToUpdateList){
            emp.Total__c = empTotalMapToUpdate.get(emp.Id);
        }
        
        if(! empToUpdateList.isEmpty()){
            try{
                update empToUpdateList;
                system.debug('Employees Total Field Updated Successfully !!');
            }
            catch(Exception ex){
            	system.debug('=========== ERROR ============');
                system.debug(ex.getLineNumber() + '----' + ex.getMessage());
            }
        }
    }
    
    // After unDelete : We are calling the After Insert Method.
	
}