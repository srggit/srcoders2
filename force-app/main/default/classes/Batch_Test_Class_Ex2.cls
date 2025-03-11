global with sharing class Batch_Test_Class_Ex2 implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext bc){

        String query = 'SELECT Id, Name, Industry, Rating FROM Account';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Account> lstAccounts){
        
        User u = [SELECT Id, Name, Alias FROM User WHERE alias = 'SG'];

        for(Account acc : lstAccounts){
            acc.OwnerId = u.Id;
        }
        update lstAccounts;
    }

    global void finish(Database.BatchableContext bc){

    }

}