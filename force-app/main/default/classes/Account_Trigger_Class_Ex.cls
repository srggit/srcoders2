public with sharing class Account_Trigger_Class_Ex {

    public static void invoke(List<Account> lstAccounts){

        for(Account acc : lstAccounts){
            acc.Rating = 'Hot';
            acc.Industry = 'Banking';
            acc.Ownership = 'Private';
        }
    }
}