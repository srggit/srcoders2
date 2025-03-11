public with sharing class JSONGenerator_Ex1 {
    public JSONGenerator_Ex1() {

        System.JSONGenerator gen = JSON.createGenerator(true);

        gen.writeStartObject(); // {

        gen.writeFieldName('EmpName');
        gen.writeString('Satish Myla'); 

        gen.writeFieldName('Age');
        gen.writeNumber(30);

        gen.writeStringField('Position', 'SF Developer');

        gen.writeNumberField('EmpNo', 2003);

        gen.writeDateField('DOJ', System.today());

        String myFile = '2394892sdffd';
        Blob blobData = Blob.valueOf(myFile);
        gen.writeBlobField('Resume', blobData);

        gen.writeEndObject();   // }

        String jsonString = gen.getAsString();

        System.debug('JSONGenerator String : ' + jsonString);
    }
}