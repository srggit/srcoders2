// Result in VF Page: XML_Ex1_VF

public with sharing class XML_Ex1 {
    public String result1 {get;set;}
    public String result2 {get;set;}

    public XML_Ex1() {

        Dom.Document doc = new Dom.Document();  

        Dom.XmlNode root = doc.createRootElement('Student', 'http://www.capitalinfo.com', 'cap');
        
        Dom.XmlNode firstName = root.addChildElement('First Name', 'http://www.capitalinfo.com', 'cap');
        firstName.addTextNode('Samir');

        Dom.XmlNode lastName = root.addChildElement('Last Name', null, null);
        lastName.addTextNode('Saha');

        Dom.XmlNode roll = root.addChildElement('RollNo', null, null);
        roll.addTextNode('901');

        result1 = doc.toXmlString();

    }
    /*
    O/p:
    ----
    <?xml version="1.0" encoding="UTF-8"?> 
    <cap:Student xmlns:cap="http://www.capitalinfo.com"> 
        <cap:First Name>Samir</cap:First Name>
        <Last Name>Saha</Last Name> 
        <RollNo>901</RollNo> 
    </cap:Student>
    */    
    
    public void Example2(){

        DOM.Document doc = new Dom.Document();

        Dom.XmlNode root = doc.createRootElement('College', null, null);
        root.setAttribute('Code', '89311');
        root.setAttribute('University', 'OF');
        
            Dom.XmlNode name = root.addChildElement('Name', null, null);
            name.addTextNode('CBIT');

            Dom.XmlNode phone = root.addChildElement('Phone', null, null);
            phone.addTextNode('99438-34747');

            Dom.XmlNode address = root.addChildElement('Address', null, null);
                Dom.XmlNode city = address.addChildElement('City', null, null);
                city.addTextNode('Hyd');

                Dom.XmlNode state = address.addChildElement('State', null, null);
                state.addTextNode('TG');

            result2 = doc.toXmlString();       
            
        System.debug('result2 : ' + result2);                           
    }
}