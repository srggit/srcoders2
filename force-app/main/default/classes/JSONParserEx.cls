public with sharing class JSONParserEx {
    public JSONParserEx() {
        System.JSONGenerator jg = JSON.createGenerator(true);

        jg.writeStartObject();
            jg.writeStringField('Name', 'Apex');
            jg.writeNumberField('Score', 99);
        jg.writeEndObject();

        String result = jg.getAsString();

        System.debug('result : ' + result);

        Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(result);


        System.debug('mapData : ' + mapData);

        System.debug('===================== XML:Serialization =============================');

        DOM.Document doc = new DOM.Document();

        DOM.xmlNode root = doc.createRootElement('StdDetails', null, null);
            
            DOM.xmlNode firstName = root.addChildElement('FirstName', null, null);
            firstName.addTextNode('Satish');

            DOM.XmlNode lastName = root.addChildElement('LastName', null, null);
            lastName.addTextNode('Myla');

            DOM.XmlNode salary = root.addChildElement('Salary', null, null);
            salary.addTextNode('3400000');

            DOM.XmlNode address = root.addChildElement('Address', null, null);
                DOM.xmlNode city = address.addChildElement('City', null, null);
                city.addTextNode('Hyderabad');

                DOM.XmlNode state = address.addChildElement('State', null, null);
                state.addTextNode('Telengana');

                DOM.XmlNode pincode = address.addChildElement('Pincode', null, null);
                pincode.addTextNode('389488');

        String xmlResult = doc.toXmlString();
        System.debug('result : ' + xmlResult);


        System.debug('===================== XML:De-Serialization =============================');


/*
<StdDetails>
    <FirstName>Satish</FirstName>
    <LastName>Myla</LastName>
    <Salary>3400000</Salary>
    <Address>
        <City>Hyderabad</City>
        <State>Telengana</State>
        <Pincode>389488</Pincode>
    </Address>
</StdDetails>
*/

        String xmlString = '<?xml version="1.0" encoding="UTF-8"?><StdDetails><FirstName>Satish</FirstName><LastName>Myla</LastName><Salary>3400000</Salary><Address><City>Hyderabad</City><State>Telengana</State><Pincode>389488</Pincode></Address></StdDetails>';
        
        DOM.Document docu = new DOM.Document();
        docu.load(xmlString);

        DOM.XmlNode rootElement = docu.getRootElement();

        String output = traverseNodes(rootElement);      
        
        System.debug('output :  \n ' + output);
    }

    private String traverseNodes(DOM.XMLNode root){

        String output = '';

        output = output + root.getName() + ( root.getText() != null ? ' : ' + root.getText() : '') + '\n';

        List<DOM.XmlNode> childs = root.getChildElements();
        for(DOM.XmlNode ch : childs){
            output += traverseNodes(ch);
        }
        return output;
    }


    
}