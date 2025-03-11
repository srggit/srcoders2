public with sharing class JSONParser_Ex1 {
    public String jsonString   {get;set;}
    public Map<String, Object> resMap {get;set;}

    public JSONParser_Ex1() {

        // Create JSON Data
        System.JSONGenerator jg = JSON.createGenerator(true);

        jg.writeStartObject();
            jg.writeStringField('Name', 'Satish');
            jg.writeNumberField('Age', 30);
            jg.writeDateField('DOJ', System.today());
            jg.writeFieldName('Marks');
                jg.writeStartArray();
                    jg.writeNumber(10);
                    jg.writeNumber(20);
                    jg.writeNumber(30);
                jg.writeEndArray();
        jg.writeEndObject();    

        jsonString = jg.getAsString();
    }

    // Ex: Break all the tokens in number of Segments
    public void getData(){
        resMap = new Map<String, Object>();

        System.JSONParser jp = JSON.createParser(jsonString);
        while (jp.nextToken() != null) {
            resMap.put(jp.getText(), jp.getCurrentToken());
        }

        for(String key : resMap.keySet()){
            system.debug(key  + ' ------- ' + resMap.get(key));
        }
    }

    // Ex: Get the value of the 'access_token' from the given JSON string
    public void getAccessToken(){

        String jsonResponse = '{ "access_token":"MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3", "token_type":"Bearer", "expires_in":3600,"refresh_token":"IwOGYzYTlmM2YxOTQ5MGE3YmNmMDFkNTVk","scope":"create"}';
        String at;

        System.JSONParser jp = JSON.createParser(jsonResponse);

        while (jp.nextToken() != null) {
            if(jp.getText() == 'access_token'){
                jp.nextToken();
                at = jp.getText();
            }
        }
        System.debug('Access Token at : ' + at);
    }


    // Ex: Get all the Integer Values from the given JSON String
    public void getIntegerTokens(){

        String jsonString = '{ "Name":"Kiran", "Age":30, "Salary":10000, "RNo":1231, "Marks":[10,20,30]}';
        List<Integer> intTokens = new List<Integer>();

        System.JSONParser jp = JSon.createParser(jsonString);

        while(jp.nextToken() != null){
            if(jp.getCurrentToken() == System.JSONToken.VALUE_NUMBER_INT){
                Integer i = (Integer) jp.getIntegerValue();
                intTokens.add(i);
            }
        }

        System.debug('intTokens : ' + intTokens);
    }                   
    // o/p: intTokens : (30, 10000, 1231, 10, 20, 30)

    // Ex: Read the value of an Object from JSONString

    public void getObject(){

        String jsonString = '{ "Name":"Kiran", "Age":30, "acc":{"Name":"Wipro", "Rating":"Hot", "Industry":"IT", "Phone":"90090-78884"}}';
        Account acc = new Account();

        System.JSONParser jp = JSON.createParser(jsonString);

        while (jp.nextToken() != null) {
            if(jp.getText() == 'acc'){
                jp.nextToken();
                acc = (Account) jp.readValueAs(Account.class);
            }
        }
        System.debug('Account acc : ' + acc);
    }
    // o/p: Account acc : Account:{Industry=IT, Phone=90090-78884, Rating=Hot, Name=Wipro}
	
    // Ex: Get Array data from JSON string.
    public void getArray(){

        String jsonString = '{"Name":"Satish", "Age":30, "Cities":["Hyd", "Chen", "Bang"]}';
        List<String> citiesList = new List<String>();

        System.JSONParser jp = JSON.createParser(jsonString);

        while (jp.nextToken() != null) {
            if(jp.getCurrentToken() == System.JSONToken.FIELD_NAME && jp.getText() == 'Cities'){
                jp.nextToken();
                citiesList = (List<String>) jp.readValueAs(List<String>.class);     // Array / List / Map / Set is a class
            }
        }
        System.debug('citiesList : ' + citiesList);
    }



}