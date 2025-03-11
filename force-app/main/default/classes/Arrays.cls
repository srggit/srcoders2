public class Arrays {
    
    public static void arrayMethod(){
        Integer[] ages = new Integer[4];
        ages[0] = 10;
        ages[1] = 20;
        ages[2] = 30;
        ages[3] = 40;
        
        system.debug('ages : ' + ages);	
        system.debug('ages[0] : ' + ages[0]);
        system.debug('ages[1] : ' + ages[1]);
        system.debug('ages[2] : ' + ages[2]);
        system.debug('ages[3] : ' + ages[3]);
        
        for(Integer i=0; i < ages.size(); i++){
            system.debug('ages['+i+'] : ' + ages[i]);
        }        
        
        Integer[] salary = new Integer[]{10000, 15000, 20000, 25000};
        system.debug('Salary : ' + salary);
        
        String[] cities = new String[]{'Hyd', 'Ban', 'Ngp', 'Che', 'Mum'};
        
        for(Integer i=0; i < cities.size(); i++){
        	system.debug('Index: ' + i);
            system.debug('City : ' + cities[i]);
        }
        
        // Create an array of Integers values and find the minimum value from elements.
        
        Integer[] data = new Integer[]{30, 20, 40, 10, 90};
        Integer min = data[0];
        
        /*
          0    1    2   3    4
        -------------------------
		| 30 | 20| 40 | 10 | 90 |
        -------------------------
		*/
        
        for(Integer i=1; i<data.size(); i++){
            if(data[i] < min){
                min = data[i];
            }
        }
        system.debug('Minimum Number : ' + min);
        
        Integer max = data[0];
        for(Integer i=1; i<data.size(); i++){
            if(data[i] > max){
                max = data[i];
            }
        }
        system.debug('Maximum Number : ' + max);
        
        // Create an array to store salaries and print their Sum.
         
        Integer[] salaries = new Integer[]{12000, 34000, 56000, 67000};
        Integer sum = 0;
        
        for(Integer i=0; i<salaries.size(); i++){
   			sum = sum + salaries[i];
        }
        system.debug('Salaries Total : ' + sum);
        
        // Print the Odd Number
        
        for(Integer i=1; i<=100; i++){
            if(Math.mod(i, 2) != 0){
                //system.debug('Odd NUmber : ' + i);
            }
        }
        
        // Create a Wrapper Class Student with Name, Age, City
        // Create an Array to store group of students
        
        Student[] stdArray = new Student[2];
        
        Student std1 = new Student();
        std1.Name = 'Sam';
        std1.Age = 30;
        std1.City = 'Hyd'; 
        stdArray[0] = std1;
        
        Student std2 = new Student();
        std2.Name = 'Ram';
        std2.Age = 34;
        std2.City = 'Ban';
        stdArray[1] = std2;
        
        //Student[] stdArray = new Student[]{std1, std2};
        system.debug('Student 1 Info :  ' + stdArray[0]);
        system.debug('Student 2 Info :  ' + stdArray[1]);

        for(Integer i=0; i<stdArray.size(); i++){
            system.debug('Std. Name : ' + stdArray[i].Name);
            system.debug('Std Age : ' + stdArray[i].Age);
            system.debug('Std City : ' + stdArray[i].City);
        }
        
        system.debug('----------------------------------');
        for(Student s : stdArray){
            system.debug('Name : ' + s.Name);
            system.debug('Age : ' + s.Age);
            system.debug('City : ' + s.City);
        }
        
        
        
        Employee emp1 = new Employee();
        emp1.LastName = 'Myla';
        emp1.FirstName = 'Satish';
        emp1.Phone = '283-234';
        
        Employee emp2 = new Employee();
        emp2.LastName = 'K';
        emp2.FirstName = 'Kiran';
        emp2.Phone = '345-645';
        
        Employee emp3 = new Employee();
        emp3.LastName = 'P';
        emp3.FirstName = 'Hari';
        emp3.Phone = '123-434';
        
        /*
        Employee[] employees = new Employee[3];
        
        employees[0] = emp1;
       	employees[1] = emp2;
        employees[2] = emp3;
        */
        
        Employee[] employees = new Employee[]{emp1, emp2, emp3};
            
        Employee emp4 = new Employee();
        emp4.LastName = 'Rathi';
        emp4.FirstName = 'Sarjeet';
        emp4.Phone = '789-588';
        
        employees.add(emp4);
		
		system.debug('Employees Size : ' + employees.size());
        
        for(Employee e : employees){
            system.debug(e);
        }
        
        // Create an Instance of Account
        Account acc = new Account();
        acc.Name = 'Wipro';
        acc.Rating = 'Hot';
        acc.Ownership = 'Private';
        acc.AnnualRevenue = 120000;
        acc.Phone = '2342342342';
        acc.Active__c = 'Yes';
        
        // Create an Array of Account and Insert the data
        Account acc1 = new Account();
        acc1.Name = 'BlueDart';
        acc1.Rating = 'Hot';
        acc1.Phone = '234234234';
        acc1.Website = 'bluedart.com';
        acc1.AnnualRevenue = 23748723;
        
        Account acc2 = new Account();
        acc2.Name = 'TCS';
        acc2.Rating = 'Hot';
        acc2.Phone = '1231234';
        acc2.Website = 'tcs.com';
        acc2.AnnualRevenue = 679784;
        
        Account[] accArray = new Account[]{acc1, acc2};
        insert accArray;
        
        Account acc3 = new Account();
        acc3.Name = 'HAL';
        acc3.Rating = 'Hot';
        acc3.Phone = '465767879';
        acc3.Website = 'hal.com';
        acc3.AnnualRevenue = 6797844;
        insert acc3;
        system.debug('acc3 Id : ' + acc3.Id);
        
    }
    
    public Class Student{
        public String name;
        public Integer age;
        public String city;
    }
    
    public Class Employee{
        public String LastName;
        public String FirstName;
        public String Phone;
    }
}