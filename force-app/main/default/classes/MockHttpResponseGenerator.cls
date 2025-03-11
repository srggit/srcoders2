// Sample Web Service Call
@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock{

    global HttpResponse respond(HttpRequest request){

        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setBody('{ "status" : "success", "message" : "Mock Response"}');
        return response;
    }
}