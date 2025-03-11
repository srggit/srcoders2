public with sharing class XML_DeSerialization_Ex3 {
    public XML_DeSerialization_Ex3() {

        String xmlString = '<library> <book> <author>Joe Smith</author> <title>Chatty</title> <isbn>2837482</isbn> </book> <book> <author>Carol Yang</author> <title>Animal Shelter</title> <isbn>28373442</isbn> </book> </library>';
        String result = '';

        Dom.Document doc = new Dom.Document();
        doc.load(xmlString);

        Dom.XmlNode root = doc.getRootElement();    // <library>
        result = root.getName();

        List<Dom.XmlNode> libChildBook = root.getChildElements();  // <book>

        for(Dom.XmlNode lcb : libChildBook){    // for every Book childs (author/title/isbn)
            result = result + '\n' + lcb.getName();

            List<Dom.XmlNode> bookChilds = lcb.getChildElements();

            for(Dom.XmlNode bc : bookChilds){
                result = result + '\n' + bc.getName() + ' : ' + bc.getText();
            }
        }

        System.debug('result : ' + result);

        // We can also format the data in List<Map<String, String>>

        List<Map<String, String>> listMap = new List<Map<String, String>>();

        List<Dom.XmlNode> book = root.getChildElements();
        for(Dom.XmlNode b : book){
            Map<String, String> mapBC = new Map<String, String>();

            List<Dom.XmlNode> bookChild = b.getChildElements();

            for(Dom.XmlNode bc : bookChild){
                mapBC.put(bc.getName(), bc.getText());
            }

            listMap.add(mapBC);
        }
        System.debug('listMap : ' + listMap);
        // o/p: listMap : ({author=Joe Smith, isbn=2837482, title=Chatty}, {author=Carol Yang, isbn=28373442, title=Animal Shelter})
    }
}

/*
XMl String:
------------
<library>
    <book>
        <author>Joe Smith</author>
        <title>Chatty</title>
        <isbn>2837482</isbn>
    </book>
            
    <book>
        <author>Carol Yang</author>
        <title>Animal Shelter</title>
        <isbn>28373442</isbn>
    </book>
</library>

o/p:
------
result : library
book
author : Joe Smith
title : Chatty
isbn : 2837482
book
author : Carol Yang
title : Animal Shelter
isbn : 28373442

*/