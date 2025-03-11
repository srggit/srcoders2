// Class 4: XML Serialization and De-Serialization(01:04:00)

public with sharing class XML_DeSerialization_Ex1 {

    public String xmlString     {get;set;}
    public String result        {get;set;} 

    public void convertXMLToObject() {

        DOM.Document doc = new DOM.Document();

        // Load the XML String
        doc.load(xmlString);

        // Get Root Element
        DOM.XmlNode root = doc.getRootElement();

        // Get Root Element Name
        result = root.getName();

        // Get Child Elements
        List<DOM.XmlNode> childs = root.getChildElements();

        // Loop through every child elements and create Object
        for(DOM.XmlNode c : childs){
            result = result + '\n' + c.getName() + ' : ' + c.getText();
        }
    }
}