// Class 2 JSON Deserialization

public class JSON_DeSerialize_Ex2 {
    public Integer age;
    public Account acc;
    public StudentWrapperClass std;
    public StudentWrapperClass stdStrict;
    public StudentWrapperClass stdStrict1;
    public Map<String, Object> jsonMap;
    
    public JSON_DeSerialize_Ex2(){
        age = (Integer) JSON.deserialize('10', Integer.class);	// Type cast to original format
        System.debug('age : ' + age);
        
        String accString = '{ "Name":"Wipro", "Industry":"IT", "Rating":"Hot" }';
        
        acc = (Account) JSON.deserialize(accString, Account.class);
        System.debug('acc : ' + acc);
        System.debug('acc Name : ' + acc.Name);
        
        String stdString = '{ "Name":"Sagar", "City":"Bang", "Phone":"90900-89676", "Place":"SR Nagar" }';
        String stdString1 = '{ "Name":"Sagar", "City":"Bang", "Phone":"90900-89676" }';
        
        std = (StudentWrapperClass) JSON.deserialize(stdString, StudentWrapperClass.class);
        System.debug('std : ' + std);
        System.debug('std Name : ' + std.Name);
        
        // deserializeStrict() : Each and Every Key Element in JSON String, should be available in the class in which we are converting our JSON String.
        stdStrict1 = (StudentWrapperClass) JSON.deserializeStrict(stdString1, StudentWrapperClass.class);
        System.debug('stdStrict1 : ' + stdStrict1);
        
        try{
            stdStrict = (StudentWrapperClass) JSON.deserializeStrict(stdString, StudentWrapperClass.class);
            System.debug('stdStrict : ' + stdStrict);
        }
        catch(Exception ex){
            System.debug('ERROR : ' + ex.getMessage());
        }
		
        // deserializeUnTyped() : If we don't have equivalent ApexType for the JSONString we are receiving, at that time we go with deserializeUnTyped().
    	
        jsonMap = (Map<String, Object>) JSON.deserializeUntyped(stdString);
    	System.debug('jsonMap : ' + jsonMap);
        
        for(String key : jsonMap.keySet()){
            System.debug(key + ' : ' + jsonMap.get(key));
        }
    }
}