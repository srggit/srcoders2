public with sharing class Http_SMS_Ex {
    
    public void send(){
        String url = 'https://api.txtlocal.com/send/';
        String body = 'sender=TXTLCL&';
        body = body + 'message=TESTMessage&';
        body = body + 'apikey=NzQzMjRhNzM0ZTM1MzI0YzRhMzM2ZjM1NzE0YTQyN2E&';
        body = body + 'username=saurabh4sfdc@gmail.com&';
        body = body + 'password=Textlocal@54321&';
        body = body + 'hash=2f25cad4dd3768008bd28374c75f33324e1c83c35f05a3c2d6db27ecbcdb3c2a&';
        body = body + 'numbers=9579377280';
        
        Http http = new Http();

        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('POST');
        request.setBody(body);

        HttpResponse response = http.send(request);
        String result = response.getBody();
        String status = response.getStatus();

        System.debug('result : ' + result);
        System.debug('status : ' + status);
    }
}