public with sharing class JSONGenerator_Ex2 {

    public String name      {get;set;}
    public String rating    {get;set;}
    public String industry  {get;set;}
    public String result    {get;set;}

    public void createAccount(){

        System.JSONGenerator jsonGen = JSON.createGenerator(true);

        jsonGen.writeStartObject();     // {

        try{
            Account acc = new Account();
            acc.Name = name;
            acc.Rating = rating;
            acc.Industry = industry;

            insert acc;

            jsonGen.writeStringField('Status', 'Success !!');
            jsonGen.writeStringField('AccId', acc.Id);
        }
        catch(Exception ex){
            jsonGen.writeStringField('Status', 'Failed');
            jsonGen.writeStringField('Error', ex.getMessage());
        }

        jsonGen.writeEndObject();        // }
        result = jsonGen.getAsString();
    }
}