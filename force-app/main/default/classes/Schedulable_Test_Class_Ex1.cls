public with sharing class Schedulable_Test_Class_Ex1 implements Schedulable {

    public void execute(SchedulableContext sc){

        List<Account> lstAccounts = [SELECT Id FROM Account WHERE CreatedDate = TODAY];
        delete lstAccounts;
    }
}