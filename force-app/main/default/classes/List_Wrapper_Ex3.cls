public class List_Wrapper_Ex3 {
    // Access_Modifier DataType VarName
    public AccConWrapper accConObj				{get;set;}
    public List<AccConWrapper> accConObjList	{get;set;}
    
    public List_Wrapper_Ex3(){
        accConObj = new AccConWrapper();
        accConObjList = new List<AccConWrapper>();
        
        /*
        // Initialize/Allocate the Memory, it is a reference variable
        // Before us, we have to assign memory
        accConObj.acc = new Account();
        accConObj.con = new Contact();
		*/
    }
    
    public void addRecord(){
        accConObjList.add(accConObj);
        accConObj = new AccConWrapper();
    }
    
    public void clearTable(){
        accConObjList.clear();
    }
    
    
    public class AccConWrapper{
        public Account acc	{get;set;}
        public Contact con 	{get;set;}
        
        public AccConWrapper(){
            acc = new Account();
            con = new Contact();
        }
    }
}