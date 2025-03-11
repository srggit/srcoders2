public with sharing class ChangeAccountOwner_Class {
    
    @AuraEnabled
    public static string getAllUsers(){
        try {
            List<User> lstUsers = [SELECT Id, Name FROM User];
            System.debug('lstUsers : ' + lstUsers);

            return JSON.serialize(lstUsers);
        } 
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string changeOwner(Boolean openOpps, Boolean allOpps, Boolean allConts, Boolean allAccs, String userId){
        try {
            System.debug('openOpps : '  + openOpps);
            System.debug('allOpps  : '  + allOpps);
            System.debug('allConts : '  + allConts);
            System.debug('allAccs  : '  + allAccs);
            System.debug('userId   : '  + userId);

            List<Opportunity> lstOpenOpps       = new List<Opportunity>();
            List<Opportunity> lstAllOpps    = new List<Opportunity>();
            List<Contact> lstConts          = new List<Contact>();
            List<Account> lstAccs           = new List<Account>();

            if(openOpps){
                lstOpenOpps = [SELECT Id, OwnerId FROM Opportunity
                                                WHERE StageName != 'Closed Won' AND StageName != 'Closed Lost'];
                
                if(lstOpenOpps.size() > 0){
                    for(Opportunity opp : lstOpenOpps){
                        opp.OwnerId = userId;
                    }
                }                
            }

            if(allOpps){
                lstAllOpps = [SELECT Id, OwnerId FROM Opportunity];

                if(lstAllOpps.size() > 0){
                    for(Opportunity opp : lstAllOpps){
                        opp.ownerId = userId;
                    }
                }
            }
            
            if(allConts){
                lstConts = [SELECT Id, OwnerId FROM Contact];

                if(lstConts.size() > 0){
                    for(Contact con : lstConts){
                        con.OwnerId = userId;
                    }
                }
            }

            if(allAccs){
                lstAccs = [SELECT Id, OwnerId FROM Account];

                if(lstAccs.size() > 0){
                    for(Account acc : lstAccs){
                        acc.OwnerId = userId;
                    }
                }
            }

            update lstOpenOpps;
            update lstAllOpps;
            update lstConts;
            update lstAccs;

            return 'Owner Changed Successfully !!';
        } 
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}