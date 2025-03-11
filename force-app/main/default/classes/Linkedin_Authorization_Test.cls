public with sharing class Linkedin_Authorization_Test {

    public String clientId { get; set; }
    public String clientSecret { get; set; }
    public String callbackUrl { get; set; }
    public String state { get; set; }
    public String accessToken { get; set; }
    public String authorizationCode { get; set; }

    public Linkedin_Authorization_Test() {
        // Set your LinkedIn Client ID, Client Secret, and Callback URL here
        clientId = '77h764llrdyahd'; // Replace with your actual Client ID
        clientSecret = 'WPL_AP1.vXnsA2sSLoHXnsZF.wixnYw=='; // Replace with your actual Client Secret
        callbackUrl = 'https://dns000003ebxg2as-dev-ed--c.develop.vf.force.com/apex/Linkedin_Response_Page'; // Replace with your actual Callback URL
        state = 'dfdf'; // Use a unique state parameter for security
    }

    public void requestAuthorizationCode() {
        // Build the authorization URL
        String url = 'https://www.linkedin.com/oauth/v2/authorization?';
        url += 'response_type=code';
        url += '&client_id=' + EncodingUtil.urlEncode(clientId, 'UTF-8');
        url += '&redirect_uri=' + EncodingUtil.urlEncode(callbackUrl, 'UTF-8');
        url += '&scope=' + EncodingUtil.urlEncode('profile', 'UTF-8'); // Adjust scopes as needed
        url += '&state=' + EncodingUtil.urlEncode(state, 'UTF-8');

        // Output the URL to the debug log
        System.debug('Authorization URL: ' + url);
        
        // You can now manually copy this URL into your browser to request the code
    }

    public void exchangeAuthorizationCode(String code) {
        // Store the received code
        authorizationCode = code;

        // Build the token endpoint URL
        String tokenUrl = 'https://www.linkedin.com/oauth/v2/accessToken';

        // Prepare the HTTP request
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(tokenUrl);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        // Set the body of the request
        String body = 'grant_type=authorization_code';
        body += '&code=' + EncodingUtil.urlEncode(authorizationCode, 'UTF-8');
        body += '&redirect_uri=' + EncodingUtil.urlEncode(callbackUrl, 'UTF-8');
        body += '&client_id=' + EncodingUtil.urlEncode(clientId, 'UTF-8');
        body += '&client_secret=' + EncodingUtil.urlEncode(clientSecret, 'UTF-8');
        request.setBody(body);

        // Send the request and capture the response
        HttpResponse response = http.send(request);

        // Parse the response
        if (response.getStatusCode() == 200) {
            // If successful, get the access token
            String jsonString = response.getBody();
            System.debug('Response: ' + jsonString);

            // Parse the JSON response to get the access token
            Map<String, Object> tokenResponse = (Map<String, Object>) JSON.deserializeUntyped(jsonString);
            accessToken = (String) tokenResponse.get('access_token');

            // Print the access token to the debug log
            System.debug('Access Token: ' + accessToken);
        } else {
            // Log the error response
            System.debug('Error: ' + response.getStatus());
            System.debug('Error Response: ' + response.getBody());
        }
    }
        
}