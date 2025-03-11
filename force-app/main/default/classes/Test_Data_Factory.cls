@isTest
public with sharing class Test_Data_Factory {
    
    public static void createTestAccountsData(){

        MockHttpResponseGenerator httpCall = new MockHttpResponseGenerator();
        Test.setMock(HttpCalloutMock.class, httpCall);
        
        Account acc = new Account();
        acc.Name = 'BMW Automotive';
        acc.Rating = 'Hot';
        acc.Industry = 'Automobile';

        insert acc;
    }
}