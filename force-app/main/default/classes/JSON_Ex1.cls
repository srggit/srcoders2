public class JSON_Ex1 {
	
    public String integerValue		{get;set;}
    public String decimalValue		{get;set;}
    public String accountValue		{get;set;}
    public String studentValue		{get;set;}
    
    public String integerPretty		{get;set;}
    public String decimalPretty		{get;set;}
    public String accountPretty		{get;set;}
    public String studentPretty		{get;set;}
    
    public String studentWithoutSuppress {get;set;}
    public String studentWithSuppress	 {get;set;}
    
    public JSON_Ex1(){
        integerValue = JSON.serialize(10);	// Static Method
        decimalValue = JSON.serialize(23009.89);
        
        Account acc = new Account(Name='Wipro', Industry='Banking', Rating='Hot');
        accountValue = JSON.serialize(acc);
        
        StudentWrapperClass sWrapper = new StudentWrapperClass('Sagar', 'Hyd', '89999-90909');
        studentValue = JSON.serialize(sWrapper);
        
        integerPretty = JSON.serializePretty(10);
        decimalPretty = JSON.serializePretty(23009.89);
        accountPretty = JSON.serializePretty(acc);
        studentPretty = JSON.serializePretty(sWrapper);
        
        StudentWrapperClass std1 = new StudentWrapperClass();
        std1.name = 'Rajiv';
        std1.city = 'Hyd';
        
        studentWithoutSuppress = JSON.serialize(std1);
        studentWithSuppress = JSON.serialize(std1, true);
        
        
    }
}