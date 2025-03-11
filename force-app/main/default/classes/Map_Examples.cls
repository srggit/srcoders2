public class Map_Examples {
	
    public static void MapPractice(){	
        // Create a Map with City Name as key and Phone as values
        Map<String, String> cityMap;
        
        // Create a Map with Student Roll Mo. as Key and Names as Values
        Map<Integer, String> studMap;
        
        // Create a Map with Account Name as key and Annual Revenue as Value
        Map<String, Decimal> accMap;
        
        // Create a Map with Contact LastName as key and Email as value
        Map<String, String> conMap;
        
        // Create a Map with AccountId as a key and Account as value
        Map<String, Account> accIdMap;
        
        // Initializing the Map
        Map<String, String> studentMap = new Map<String, String>();
        Map<Integer, String> stdMap = new Map<Integer, String>();
        
        // put(key, element)
        // Create a map with student name as key and fee as value.
        Map<String, Decimal> studFeesMap = new Map<String, Decimal>();
        studFeesMap.put('Sam', 12000);
        studFeesMap.put('Kiran', 10000);
        studFeesMap.put('Pankaj', 10000);
        system.debug('studFeesMap : ' + studFeesMap);
        
        // Create a map with employee no. as key and employee name as value
        Map<Integer, String> empMap = new Map<Integer, String>();
        empMap.put(001, 'Sam');
        empMap.put(002, 'Kiran');
        
        // get(key):
        system.debug(studFeesMap.get('Kiran'));
        
        Decimal value = studFeesMap.get('Pankaj');
        system.debug(value);
        
        // keySet():
        Set<String> keys = studFeesMap.keySet();
        system.debug('keyset :  ' + keys);		// keyset :  {Kiran, Pankaj, Sam}
    
    	// values():
    	List<Decimal> values = studFeesMap.values();
        system.debug('values : ' + values);
    	
        // containsKey():
        Boolean result = studFeesMap.containsKey('Kiran');
        system.debug('contains key : ' + result);
        
    	// size():
    	system.debug('empMap Size : ' + empMap.size());
        
        // clear():
        empMap.clear();
        system.debug('empMap after clear : ' + empMap.size());
        
        // UseCase 1:
        // Create Wrapper Class Student with FirstName and LastName.
        // Create List of Students and insert some data
        // Create a Map with LastName as key and FirstName as value.
        // Fetch all the LastNames and FirstName from the map.
        
        Student stu1 = new Student();
        stu1.FirstName = 'Kiran';
        stu1.LastName = 'M';
        
        Student stu2 = new Student();
        stu2.FirstName = 'Praveen';
        stu2.LastName = 'P';
        
        Student stu3 = new Student();
        stu3.FirstName = 'Sam';
        stu3.LastName = 'B';
        
        List<Student> lstStudents = new List<Student>{stu1, stu2, stu3};
		Map<String, String> mapStudents = new Map<String, String>();
        
		for(Student s : lstStudents){
			mapStudents.put(s.LastName, s.FirstName);
        }
        system.debug('mapStudents : ' + mapStudents);
        
        Set<String> lastNames = mapStudents.keySet();
        system.debug('All LastNames : ' + lastNames);
        
        List<String> firstNames = mapStudents.values();
        system.debug('All FirstNames : ' + firstNames);
        
        // UseCase 2:
        // Create Employee Wrapper Class with EmpNo, Salary and Exp as DataMembers
        // Create List of Employees
        // Create a Map with EmpNo as Key and Employee as Value
        // Get all Employee No's
        // Get all Employyes
        // Get all those Employees whose Exp is 3 years.
        
        Employee emp1 = new Employee();
        emp1.EmpNo = 0001;
        emp1.Salary = 200000.00;
        emp1.Exp = 9;
        
        Employee emp2 = new Employee();
        emp2.EmpNo = 0002;
        emp2.Salary = 100000.00;
        emp2.Exp = 3;
        
        Employee emp3 = new Employee();
        emp3.EmpNo = 0003;
        emp3.Salary = 150000.00;
        emp3.Exp = 3;
        
        List<Employee> lstEmployees = new List<Employee>{emp1, emp2, emp3};
        Map<Integer, Employee> mapEmployees = new Map<Integer, Employee>();
        
        for(Employee emp : lstEmployees){
            mapEmployees.put(emp.EmpNo, emp);
        }
        
        system.debug('mapEmployees : ' + mapEmployees);
        
        system.debug('All Keys : ' + mapEmployees.keySet());
        system.debug('All Employyes : ' + mapEmployees.values());
		
		List<Employee> empWith3YearExpList = new List<Employee>(); 

        for(Employee emp : mapEmployees.values()){
            if(emp.Exp == 3){
                empWith3YearExpList.add(emp);
            }
        }
        system.debug('Emp With 3 Year of Experience : ' + empWith3YearExpList);
        
        // UseCase 3:
        // Create a Map with cityName as key and List of Places as Values.
        // Get All the city names
        // Get All the city Places
        
        List<String> hydPlaces = new List<String>{'SRNagar', 'LBNagar', 'KPHB'};
        List<String> banPlaces = new List<String>{'Marthali', 'ECity', 'WhiteField'};
        List<String> chePlaces = new List<String>{'Thambram', 'Chromepet', 'TNagar'};
            
        Map<String, List<String>> mapCityPlaces = new Map<String, List<String>>();
        
        mapCityPlaces.put('Hyd', hydPlaces);
        mapCityPlaces.put('Ban', banplaces);
        mapCityPlaces.put('Che', chePlaces);
        
        system.debug('All City Names : ' + mapCityPlaces.keySet());
        
        /*
        Class 8: 01:21:00
        
        > In Map, if we have Values as String, Integer or Account we get List<String/Integer/Account> as Return when we use values() on map.
        
        > Values() always return the List as output.
        
        > So, if we have value as list type we will get List<List<DataType>> as output.
        
        
        Type        ReturnTYpe
        -------------------------------
        String          :   List<String>
        Account         :   List<Account>
        List<String>    :   List<List<String>>
        
        Ex.
        List<String> firstNames = mapStudents.values();
        system.debug('All FirstNames : ' + firstNames);
        */
        List<List<String>> allPlaces = mapCityPlaces.values(); // values() return List as output, if we already have list as output then we have to take list<list<datatype>>
        system.debug('All Places : ' + mapCityPlaces.values());
        
     } 
    
    public class Student{
        public String FirstName; 
        public String LastName;
    }
    
    public class Employee{
        public Integer EmpNo;
        public Decimal Salary;
        public Integer Exp;
    }
    
    public class CityPlaces{
        public String CityName;
        public List<String> Places;
        
        public CityPlaces(){
            Places = new List<String>();
        }
    }
}