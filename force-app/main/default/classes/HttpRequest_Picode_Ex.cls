public with sharing class HttpRequest_Picode_Ex {

    public Account acc      {get;set;}
    public String url       {get;set;}

    public HttpRequest_Picode_Ex() {
        acc = new Account();
        url = 'https://api.postalpincode.in/pincode/';
    }
    
    public PageReference invoke(){
        /*
        Account acc = new Account();
        String url = 'https://api.postalpincode.in/pincode/';
        acc.Name = 'Http Test';
        acc.Rating = 'Hot';
        acc.Industry = 'Banking';
        acc.Pincode__c = '440013';
        */

        url = url + acc.Pincode__c;

        Http http = new Http();

        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        System.debug('response : ' + response);

        String jsonString = response.getBody();
        System.debug('jsonString : ' + jsonString);

        System.JSONParser jp = JSON.createParser(jsonString);
        String places = '';

        while(jp.nextToken() != null){
            if(jp.getText() == 'Name'){
                jp.nextToken();
                places = places + jp.getText() + ',';
            }
        }

        acc.Places__c = places;
        insert acc;
        PageReference p = new PageReference('/' + acc.Id);
        return p;
    }
}