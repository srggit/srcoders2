// De-Serialization: If we receive data in XML File format, then how to convert into Object in Apex

public with sharing class XML_DeSerialization_XML_File_Ex2 {

    public Blob xmlFile { get; set; }
    public String result { get; set; }

    public void convert() {
        // Step 1: Upload the xml file form Vf page

        // Step 2: Convert the XML File to XML String
        String xmlString = xmlFile.toString();

        // Step 3: De-Serialize
        Dom.Document doc = new Dom.Document();
        doc.load(xmlString);

        Dom.XmlNode root = doc.getRootElement();
        result = root.getName();

        List<Dom.XmlNode> childs = root.getChildElements();

        for (Dom.XmlNode c : childs) {
            result += '\n' + c.getName() + ' : ' + c.getText();
        }
    }
}