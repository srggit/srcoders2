public class Account_Trigger_Handler {
    
    public static Boolean flag = true;
    // Recursive Trigger Example
    public static void handleRecuriveTrigger(){
        if(flag == true){
            flag = false;
            
       		Account acc = new Account();
            acc.Name = 'Recursive Trigger';
            acc.Rating = 'Warm';
            acc.Industry = 'Education';
            acc.Active__c = 'Yes';
            acc.AnnualRevenue = 34344;
            insert acc;     
        }        
    }
    
    // If Account Rating = Hot, Create an Opportunity	
    public static void afterInsert(List<Account> lstAccounts){
        
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Account acc : lstAccounts){
            if(acc.Rating == 'Hot'){
                Opportunity opp = new Opportunity();
                opp.Name = acc.Name;
                opp.StageName = 'Prospecting';
                opp.CloseDate = System.today() + 15; // System.today().addDays(15);
                opp.AccountId = acc.Id;
                
                oppList.add(opp);
            }
        }
        insert oppList;
    }
    
    public static void createTeamMember(List<Account> lstAccounts){
        
        User u = [SELECT Id, Name
                 FROM User
                 WHERE Name = 'Wil Yuth'];
        
        List<AccountTeamMember> teamMembers = new List<AccountTeamMember>();
        
        for(Account acc : lstAccounts){
            AccountTeamMember atm = new AccountTeamMember();
            atm.AccountId = acc.Id;
            atm.TeamMemberRole = 'Account Manager';
            atm.UserId = u.Id;
            atm.AccountAccessLevel = 'Read';
            
            teamMembers.add(atm);
        }
        
        if(! teamMembers.isEmpty()){
            try{
                insert teamMembers;
                system.debug('Team Member Created Successfully !!');
            }
            catch(Exception ex){
                system.debug('=========== ERROR ===========');
                system.debug(ex.getMessage());
            }
        }
    }
    
    // Custom Settings Example.
    public static void customSettingsExample(List<Account> lstAcc){
        
        DirectAccessData__c dad = DirectAccessData__c.getInstance(userInfo.getUserId());
        
        if(dad.Active__c == true){
            // do nothing
        }
    }
}