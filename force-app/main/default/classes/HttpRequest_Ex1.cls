public with sharing class HttpRequest_Ex1 {

    public HttpRequest_Ex1() {

        Http http = new Http();
        
        // Create the HttpRequest 
        HttpRequest request = new HttpRequest();
        
        // Set the Endpoint Url
        request.setEndpoint(URL.getOrgDomainUrl().toExternalForm() + '/services/data');

        // Set Method Type
        request.setMethod('GET');

        // Send the Request and Get the Response
        HttpResponse response = http.send(request);

        String result = response.getBody();
        
        System.debug('Result Status : ' + response.getStatus());
        System.debug('Result :  ' + result);

        // Received the response in JSON Format, De-Serialize it
        // [{"label":"Summer '14","url":"/services/data/v31.0","version":"31.0"},{"label":"Winter '15","url":"/services/data/v32.0","version":"32.0"},{"label":"Spring '15","url":"/services/data/v33.0","version":"33.0"},{"label":"Summer '15","url":"/services/data/v34.0&qu
    
        List<Object> jsonList = new List<Object>();

        String jsonString = '[{"label":"Summer \'14","url":"/services/data/v31.0","version":"31.0"},{"label":"Winter \'15","url":"/services/data/v32.0","version":"32.0"},{"label":"Spring \'15","url":"/services/data/v33.0","version":"33.0"},{"label":"Summer \'15","url":"/services/data/v34.0","version":"34.0"}]';

        jsonList = (List<Object>) JSON.deserializeUntyped(jsonString);

        for(Object obj : jsonList){
            Map<String, Object> itemMap = (Map<String, Object>) obj;
            System.debug('Label : ' +  itemMap.get('label'));
        }

        /*
        List<Map<String, Object>> allItemsMap = new List<Map<String, Object>>();

        for(Object item : jsonList){
            Map<String, Object> itemMap = (Map<String, Object>) item;
            allItemsMap.add(itemMap);
        }

        System.debug('allItemsMap : ' + allItemsMap);

    
        // Step 1: Define the JSON string
        String jsonString = '[{"label":"Summer \'14","url":"/services/data/v31.0","version":"31.0"},{"label":"Winter \'15","url":"/services/data/v32.0","version":"32.0"},{"label":"Spring \'15","url":"/services/data/v33.0","version":"33.0"},{"label":"Summer \'15","url":"/services/data/v34.0","version":"34.0"}]';

        // Step 2: Create the JSON parser
        System.JSONParser jp = JSON.createParser(jsonString);

        // Step 3: Create a list to hold the results
        List<Map<String, String>> citiesList = new List<Map<String, String>>();

        // Step 4: Parse through the JSON
        while (jp.nextToken() != null) {
            // Check if the current token is the start of an object
            if (jp.getCurrentToken() == System.JSONToken.START_OBJECT) {
                // Read the entire object as a map
                Map<String, String> cityMap = (Map<String, String>) jp.readValueAs(Map<String, String>.class);
                citiesList.add(cityMap); // Add the map to the list
            }
        }

        // Step 5: Debug the results
        System.debug('Cities List: ' + citiesList);
        */
        
    }
}