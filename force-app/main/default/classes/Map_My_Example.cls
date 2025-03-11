public class Map_My_Example {
    
    // Get the Count of Related Contacts for Every Account and Store in Map.
    public static void trial(){
        List<Account> lstAccounts = [SELECT Id, Name, Rating, Industry,
                                    (SELECT Id, FirstName FROM Contacts)
            						FROM Account];
        
        Map<String, Integer> mapConSize = new Map<String, Integer>();
        
        Integer counter = 0;
        for(Account acc : lstAccounts){
            if(acc.Contacts.size() > 0){
                for(Contact c : acc.Contacts){
                    counter += 1;
                }
                mapConSize.put(acc.Name, counter);
                counter = 0;
            }
        }
        
        system.debug('mapConSize : ' + mapConSize);
        
        for(Account acc : lstAccounts){
            if(acc.Contacts.size() > 0){
                mapConSize.put(acc.Name, acc.Contacts.size());
            }
        }
        system.debug('mapConSize : ' + mapConSize);
    }
}