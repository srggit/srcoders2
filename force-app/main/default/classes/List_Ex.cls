public class List_Ex {
	
    public static void listOperations(){
        // DataType varName
		List<Account> acc;
        system.debug('acc value before initializing : ' + acc);  // null
        
        acc = new List<Account>();
        system.debug('acc value after initializing : ' + acc);  // Empty List
    
    	// Static Initialization
        List<String> companies = new List<String>{'TCS', 'IBM', 'Wipro'};
    
        List<Account> lstAccounts = new List<Account>{
            new Account(Name='TCS', Rating='Hot', Industry='IT'),
            new Account(Name='HAL', Rating='Hot', Industry='Defence')
        };
        
        // add(element)
        List<Integer> ages = new List<Integer>{10, 30, 50, 60};
        ages.add(70);
        system.debug('ages : ' + ages);
        
        // add(index, element)
        ages.add(1, 20);
        system.debug('ages : ' + ages);
        
        // get(index)
        system.debug('3rd Index Element : ' + ages.get(3));
        
        // remove(index)
        ages.remove(4);
        system.debug('After remove() : ' + ages);
        
        // clear()
        ages.clear();
        system.debug('Clear All : ' + ages);
        
        // isEmpty();
        Boolean result = ages.isEmpty();
        system.debug('Result : ' + result);
        
        // size():
        ages.add(90);
        ages.add(30);
        ages.add(48);
        system.debug('List Size : ' + ages.size());
        
        // sort():
        ages.sort();
        system.debug('Sort in Ascending Order : ' + ages);
        
        // addAll(list):
        List<Integer> numbers = new List<Integer>{90, 30, 90};
        numbers.addAll(ages);
        system.debug('numbers : ' + numbers);
        
        // addAll(Set):
        Set<Integer> rolls = new Set<Integer>{10, 20,30};
        numbers.addAll(rolls);
        system.debug('numbers : ' + numbers);
        
        // ------------------------------------------------------------- //
        Student std1 = new Student();
        std1.Name = 'Sam';
        std1.Phone = '8495-3485';
        std1.Age = 56;
        
        Student std2 = new Student();
        std2.Name = 'Kram';
        std2.Phone = '2344-8799';
        std2.Age = 79;
        
        Student std3 = new Student();
        std3.Name = 'Pram';
        std3.Phone = '5345-3455';
        std3.Age = 54;
        
        List<Student> stdList = new List<Student>{std1, std2, std3};
        
 	}
    
    public class Student{
        public String Name;
        public String Phone;
        public Integer Age;
    }
}