// Called from Account Trigger

public with sharing class Account_Pincode_Webservice {
    
    @future(callout=true)
    public static void getPlacesUsingPincode(Set<Id> accIds){

        List<Account> accList = [SELECT Id, Name, Rating, Industry, Pincode__c
                                FROM Account
                                WHERE Id IN : accIds];

        for(Account acc : accList){

            String url = 'https://api.postalpincode.in/pincode/' + acc.Pincode__c;
            Http http = new Http();

            HttpRequest request = new HttpRequest();
            request.setEndpoint(url);
            request.setMethod('GET');

            HttpResponse response = http.send(request);
            String jsonString = response.getBody();

            String places = '';

            System.JSONParser jp = JSON.createParser(jsonString);

            while (jp.nextToken() != null) {
                if(jp.getText() == 'Name'){
                    jp.nextToken();
                    places += jp.getText() + ',';
                }
            }
            acc.Places__c = places;
        }
        update accList;
    }
}