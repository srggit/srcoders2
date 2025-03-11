/*
    Return all the Accounts Data with Acc Name and Phone
*/

@RestResource(urlmapping='/getAllAccounts/*')
global with sharing class RestResource_GetAllAccounts {
    
    @HttpGet
    global static String getAllAccs(){

        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        
        System.JSONGenerator jg = JSON.createGenerator(true);

        try{
            List<Account> lstAccounts = [SELECT Id, Name, Industry, Rating, Phone 
                                    FROM Account
                                    LIMIT 0];
            
            jg.writeStartObject();                              // {
           
            if(lstAccounts.size() > 0){
                
                jg.writeStringField('Status', 'SUCCESS');           // Status : SUCCESS 
                jg.writeNumberField('Count', lstAccounts.size());   // Count : 1
                
                jg.writeFieldName('Accounts');                      // Accounts : 
                jg.writeStartArray();                               // [
                for(Account acc : lstAccounts){
                    jg.writeStartObject();                          // {
                        jg.writeStringField('AccId', acc.Id != null ? acc.Id : '');     // Handle Null values check, else Error : null argument for JSONGenerator.writeStringField()
                        jg.writeStringField('Name', acc.Name != null ? acc.Name : '');
                        jg.writeStringField('Rating', acc.Rating != null ? acc.Rating : '');
                        jg.writeStringField('Industry', acc.Industry != null ? acc.Industry : '');
                        jg.writeStringField('Phone', acc.Phone != null ? acc.Phone : '');
                    jg.writeEndObject();                            // }
                }
                jg.writeEndArray();                                 // ]
            }
            else{
                jg.writeStringField('Status', 'SUCCESS - No Records Found');           // Status : SUCCESS 
                jg.writeNumberField('Count', lstAccounts.size());   // Count : 0
            }
        }
        catch(Exception e){

            jg.writeStringField('Status', 'ERROR');
            jg.writeStringField('Error Message', e.getMessage());
        }

        jg.writeEndObject();                                    // }

        String result = jg.getAsString();

        return result;     
    }
}

/*
@RestResource(urlmapping='/getAllAccounts/*')
global with sharing class RestResource_GetAllAccounts {
    
    @HttpGet
    global static String getAllAccs(){

        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        System.JSONGenerator jg = JSON.createGenerator(true);
        jg.writeStartObject();
        jg.writeFieldName('Status');

        try{
            List<Account> lstAccounts = [SELECT Id, Name, Industry, Rating, Phone 
                                    FROM Account
                                    LIMIT 1];
        
            String serializeResult = JSON.serialize(lstAccounts);

            jg.writeString('SUCCESS');
            jg.writeStringField('Accounts', serializeResult);
            jg.writeNumberField('Count', lstAccounts.size());
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
*/