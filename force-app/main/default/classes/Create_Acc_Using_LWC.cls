public with sharing class Create_Acc_Using_LWC {
    
    @AuraEnabled
    public static String createAccount(String accString){

        Account acc = (Account) JSON.deserialize(accString, Account.class);
        System.debug('acc : ' + acc);

        insert acc;

        return acc.Id;
        /*
        try{
            insert acc;
            return 'Account Created Successfully : ' + acc.Id;
        }
        catch(Exception e){
            return 'Account Creation Failed : ' + e.getMessage();
        }
        */
    }
}