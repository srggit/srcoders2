public with sharing class Http_SalesforceIntegration {

        public String endPoint          {get;set;}
        public String userName          {get;set;}
        public String password          {get;set;}
        public String clientId          {get;set;}
        public String clientSecret      {get;set;}
        public String accessToken       {get;set;}
        public String responseJson      {get;set;}
        public String instanceUrl       {get;set;}
        
        public List<SObject_Wrapper_For_Integration> lstSObjects {get;set;}
        public List<SObject_Wrapper_For_Integration> customObjects {get;set;}
        
        public Http_SalesforceIntegration() {
            // Write a Query to fetch the Credentials from the sObject

            Credentials__c cred = [SELECT Id, Name, Callback_Url__c, Consumer_Key__c, Consumer_Secret__c, Password__c,
            Username__c, Security_Token__c
            FROM Credentials__c
            WHERE Name = 'Integration UserName'];

            System.debug('credentials : ' + cred);

            endPoint = 'https://login.salesforce.com/services/oauth2/token';
            userName = cred.Username__c;
            password = cred.Password__c + '' + cred.Security_Token__c;
            clientId = cred.Consumer_Key__c;
            clientSecret = cred.Consumer_Secret__c;
        }

        // This method is used to request access token by providing required data
        public void requestAccessToken(){

            Http http = new Http();

            HttpRequest request = new HttpRequest();
            request.setEndpoint(endpoint);
            request.setMethod('POST');
            
            String body = 'grant_type=password&';
            body += 'client_id=' + clientId + '&';
            body += 'client_secret=' + clientSecret + '&';
            body += 'username=' + userName + '&';
            body += 'password=' + password;

            request.setBody(body);

            HttpResponse response = http.send(request);

            String jsonString = response.getBody();
            System.debug('jsonString : ' + jsonString);

            responseJson = jsonString;

            System.JSONParser jp = JSON.createParser(jsonString);

            while (jp.nextToken() != null) {
                if(jp.getText() == 'access_token'){
                    jp.nextToken();
                    accessToken = jp.getText();
                }

                if(jp.getText() == 'instance_url'){
                    jp.nextToken();
                    instanceUrl = jp.getText();
                }
            }

            System.debug('accessToken : ' + accessToken);   // Access Token will not get printed on Developer console.
            System.debug('instenceUrl : ' + instanceUrl);
            
            //getSObjectsData(accessToken);
        }

        // This method is used to get the SObjects data by providing the access token
        // public void getSObjectsData(String at){
        public void getSObjectsData(){

            //String endpoint = 'https://AP61.salesforce.com/services/data/v58.0/sobjects';
            //String endpoint = 'https://erpforceindia-f-dev-ed.my.salesforce.com/services/data/v58.0/sobjects';
            String endpoint = instanceUrl + '/services/data/v58.0/sobjects';

            Http http = new Http();

            HttpRequest request = new HttpRequest();
            request.setEndpoint(endpoint);
            request.setMethod('GET');
            //request.setHeader('Authorization', 'OAuth ' + accessToken); // at
            request.setHeader('Authorization', 'Bearer ' + accessToken);  // token_type:Bearer can be fetched from access_token response

            HttpResponse response = http.send(request);
            String jsonString = response.getBody();

            System.debug('jsonString : ' + jsonString);

            System.JSONParser jp = JSON.createParser(jsonString);

            lstSObjects = new List<SObject_Wrapper_For_Integration>();
            customObjects = new List<SObject_Wrapper_For_Integration>();

            while (jp.nextToken() != null) {
                if(jp.getText() == 'sobjects'){ // sobjects is a List, that's why we need to store the data in List in Apex
                    jp.nextToken();

                    lstSObjects = (List<SObject_Wrapper_For_Integration>) jp.readValueAs(List<SObject_Wrapper_For_Integration>.class);
                }
            }

            System.debug('lstSObjects size : ' + lstSObjects.size()); // 1132 : only 1000 can be stored in the list

            for(SObject_Wrapper_For_Integration obj : lstSObjects){
                if(obj.custom == true){
                    customObjects.add(obj);
                }
            }

            System.debug('customObjects size : ' + customObjects.size());
        }
    }