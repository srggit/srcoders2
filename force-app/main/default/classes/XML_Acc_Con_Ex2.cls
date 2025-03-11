public with sharing class XML_Acc_Con_Ex2 {

    public String searchText    {get;set;}
    public String xmlResult        {get;set;}

    public void searchRecords() {

        Account acc = [SELECT Id, Name, Rating, Industry, Phone,
                        (SELECT Id, FirstName, LastName, Phone FROM Contacts)
                      FROM Account
                      WHERE Name =: searchText];
        
        // Convert Account to XML
        DOM.Document doc = new DOM.Document();

        // Root Element
        DOM.XmlNode root = doc.createRootElement('Company', null, null);
        root.setAttribute('Name', acc.Name);
        root.setAttribute('Rating', acc.Rating);
        root.setAttribute('Industry', acc.Industry);
        root.setAttribute('Phone', acc.Phone);

        // Child Element
        DOM.XmlNode header = root.addChildElement('Header', null, null);
        header.addTextNode('Success');

        DOM.XmlNode conSize = root.addChildElement('ContactsSize', null, null);
        conSize.addTextNode(''+ acc.Contacts.size()); // string.valueOf(acc.Contacts.size()

        if(acc.Contacts.size() > 0){
            for(Contact con : acc.Contacts){
                
                DOM.XmlNode firstName = root.addChildElement('FirstName', null, null);
                firstName.addTextNode(con.FirstName);

                DOM.XmlNode lastName = root.addChildElement('LastName', null, null);
                lastName.addTextNode(con.LastName);

                DOM.XmlNode phone = root.addChildElement('Phone', null, null);
                phone.addTextNode(con.Phone);   
            }
        }

        xmlResult = doc.toXmlString();
    }
}

/*
o/p:
-----
<?xml version="1.0" encoding="UTF-8"?>
<Company Name="Burlington Textiles Corp of America" Rating="Warm" Industry="Apparel" Phone="(336) 222-7000">
    <Header>Success</Header>
    <ContactsSize>2</ContactsSize>
    <FirstName>Samuel</FirstName>
    <LastName>Day</LastName>
    <Phone>(336) 222-7000</Phone>
    <FirstName>Jack</FirstName>
    <LastName>Rogers</LastName>
    <Phone>(336) 222-7000</Phone>
</Company>
*/