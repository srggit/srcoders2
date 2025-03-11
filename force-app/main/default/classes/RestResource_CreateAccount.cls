/*
 * This RestResource is used to create Account by Third Party Systems
 */

@RestResource(urlmapping='/createAcc/*')       // createAcc is the name of the service: endpoint for 3rd party system
global class RestResource_CreateAccount {
    
    @HttpGet  // In the Get Method we get data in URL   // This is Get Method and data is passed in URL, that's why we have to get data from Url
    global static String createCustomerUsingGet(){              // If the data is passed as Body, then it has been passed as parameters in createCustomer()
        
        System.debug('createAcc RestResource Triggered');

        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        String name = request.params.get('name');
        String rating = request.params.get('rating');

        System.JSONGenerator jg = JSON.createGenerator(true);
        jg.writeStartObject();  // {
        jg.writeFieldName('Status');

        try{
            Account acc = new Account();
            acc.Name    =   name;
            acc.Rating  =   rating;

            insert acc; // If Record Inserted Successfully, set status as "Success".
            System.debug('Account Created');

            jg.writeString('SUCCESS');
            jg.writeIdField('AccId', acc.Id);
        }
        catch(Exception e){
            System.debug('ERROR Occured');
            jg.writeString('ERROR');
            jg.writeStringField('Error Message', e.getMessage());
        }

        jg.writeEndObject();

        String result = jg.getAsString();
        return result;
    }

    @HttpPost   // This is POST Method, that's why we are directly receiving the data as method parameters
    global static String createCustomerUsingPost(String name, String rating, String industry){  

        System.JSONGenerator jg = JSON.createGenerator(true);
        jg.writeStartObject();
        jg.writeFieldName('Status');

        try{
            Account acc = new Account();
            acc.Name        =   name;
            acc.Rating      =   rating;
            acc.Industry    =   industry;

            insert acc;

            jg.writeString('SUCCESS');
            jg.writeIdField('AccId', acc.Id);
        }
        catch(Exception e){
            jg.writeString('ERROR');
            jg.writeStringField('Error Message', e.getMessage());
        }
        jg.writeEndObject();

        String result = jg.getAsString();
        return result;
    }

    @HttpDelete   // This is DELETE method, the data will be passed in url like GET Method
    global static String deleteCustomerUsingDelete(){

        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        String accIdToDelete = request.params.get('id');

        System.JSONGenerator jg = JSON.createGenerator(true);
        jg.writeStartObject();
        jg.writeFieldName('Status');
        
        try{
            List<Account> accList = [SELECT Id FROM Account WHERE Id  =: accIdToDelete];

            if(accList.size() > 0){
                delete accList;
            }

            jg.writeString('SUCCESS');
            jg.writeStringField('Success Message', 'Account Record Deleted Successfully !');
        }
        catch(Exception e){
            jg.writeString('ERROR');
            jg.writeStringField('Error Message', e.getMessage());
        }

        jg.writeEndObject();
        
        String result = jg.getAsString();
        
        return result;
    }
}

/*
Testing Mechanism:
1. Go to workbench --> Utilities ---> Rest Explorer
2. Select Method : GET /POST
3. Create the URL as shown: /services/apexrest/createAcc?name=RestTest&rating=Hot
*/