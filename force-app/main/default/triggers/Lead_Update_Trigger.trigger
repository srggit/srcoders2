trigger Lead_Update_Trigger on Lead (before insert) {
	
    List<Lead> leadList = Trigger.new;
    
    // Validation 
    // If LeadSource is 'Web' and Email is blank then throw error.
    
    for(Lead ld : leadList){
        if(ld.LeadSource == 'Web' && (ld.Email == '' || ld.Email == null)){
            ld.addError('Trigger: Email cannot be Blank if LeadSource is Web');
        }
    }
}