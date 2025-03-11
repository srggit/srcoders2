// Documentation Link : https://learn.microsoft.com/en-us/linkedin/shared/authentication/authorization-code-flow?context=linkedin%2Fcontext&tabs=HTTPS1

public with sharing class Linkedin_Code_Authentication {

    public String clientId      {get;set;}
    public String clientSecret  {get;set;}
    public String callbackUrl   {get;set;}
    public String state         {get;set;}
    public String code          {get;set;}
    
    public String authorizationCodeEndpoint {get;set;}
    
    public String accessTokenEndpoint {get;set;}
    public String accessToken   {get;set;}



    public Linkedin_Code_Authentication() {
        clientId = '77h764llrdyahd';
        clientSecret = 'WPL_AP1.MmwgmTbjTOULmiKf.5En2zw==';
        callbackUrl = 'https://dns000003ebxg2as-dev-ed--c.develop.vf.force.com/apex/Linkedin_Response_Page';
        state = 'dasda'; // You can use a random string or a UUID for security

        authorizationCodeEndpoint = 'https://www.linkedin.com/oauth/v2/authorization';
        accessTokenEndpoint = 'https://www.linkedin.com/oauth/v2/accessToken?';
    }
    /*
        endpoint = url
        response_type = code (fixed)
        client_id = which we will receive from Linkedin Connected App
        redirect_uri = Url of the VF Page on which we want to get the Code from Linkedin as Result through which we can get access_token
        scope = profile / openid / w_member_social / email
        state = any random string for more security
    */


    // PageReference is also like GET Method
    public PageReference requestCode(){
        String url = authorizationCodeEndpoint + '?';    // Endpoint to get Authorization Code
        url = url + 'response_type=code&';
        url = url + 'client_id=' + clientId + '&';
        url = url + 'redirect_uri=' + callbackUrl + '&';
        url = url + 'scope=profile&';  // You can add more scopes as needed, separated by a space
        url = url + 'state=' + state;

        /*
        String url = 'https://www.linkedin.com/oauth/v2/authorization?';
        url = url + 'response_type=code&';
        url = url + 'client_id=' + EncodingUtil.urlEncode('77h764llrdyahd', 'UTF-8') + '&';
        url = url + 'redirect_uri=' + EncodingUtil.urlEncode(callbackUrl, 'UTF-8') + '&';
        url = url + 'scope=profile&';  // You can add more scopes as needed, separated by a space
        url = url + 'state=' + EncodingUtil.urlEncode(state, 'UTF-8');
        */

        PageReference p = new PageReference(url);
        p.setRedirect(true);  // Ensures the redirection happens
        return p;
    }

    public void readCode(){
        code = ApexPages.currentPage().getParameters().get('code');
        System.debug('Authorization Code: ' + code);

        if (code != null) {
            // Here you would typically call a method to exchange the code for an access token
            // exchangeAuthorizationCode(code);
        } else {
            System.debug('No code received from LinkedIn');
        }
    }

    public void requestAccessToken() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.linkedin.com/oauth/v2/accessToken?');
        request.setMethod('POST');
    
        // Set the content type
        //request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        System.debug('authorization code : ' + code);

        // Construct the body
        String body = 'grant_type=authorization_code';
        body += '&code=' + code; // Ensure 'code' is correctly set
        body += '&client_id=' + clientId; // Ensure 'clientId' is correctly set
        body += '&client_secret=' + clientSecret; // Ensure 'clientSecret' is correctly set
        body += '&redirect_uri=' + callbackUrl; // Ensure 'callbackUrl' is correctly set
        

        request.setBody(body);
        
        // Log the request body for debugging
        System.debug('Request Body: ' + body);
    
        HttpResponse response = http.send(request);
        
        // Log the response for debugging
        String jsonString = response.getBody();
        System.debug('Response: ' + jsonString);
    
        System.JSONParser jp = JSON.createParser(jsonString);
    
        while (jp.nextToken() != null) {
            if (jp.getText() == 'access_token') {
                jp.nextToken();
                accessToken = jp.getText(); 
            }
        }
    
        System.debug('Access Token: ' + accessToken);
    }
    
}

//https://www.linkedin.com/oauth/v2/accessToken?grant_type=authorization_code&code=AQQGJiu3w4ME5qibAFJ66-UA9xJeBVD38I8tjHQmARbL5Pdo_SuNiH7zLvmk63pY79FbYlip4RsL8NW0YBl1NBnsAeT5Hvl3P0WNMXHrHaDVTRI7wUKIcNSwp3s1jgnJGReDQtx0Szwfts5piVyLzAivo0fvszBJQQh9RHEaSb4ksa0sAZo9vehrtvMc3CqiXWMzmazJsEt0RjKn2vg&client_id=77h764llrdyahd&client_secret=WPL_AP1.MmwgmTbjTOULmiKf.5En2zw==&redirect_uri=https://dns000003ebxg2as-dev-ed--c.develop.vf.force.com/apex/Linkedin_Response_Page