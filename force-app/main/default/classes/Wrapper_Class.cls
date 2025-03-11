public class Wrapper_Class {
	
    public static void method1() {
        //DataType varName
        Student std = new Student();
        
        std.Name = 'Ravi';
        std.Phone = '010-1111';
        std.age = 50;
    
        // s1 and s2 referring to same location of std
        Student s1 = std;
        Student s2 = s1;
        
        /*
        ----------------------------
        Name = Ravi                     ===> std
        Phone = 010-1111                ===> s1
        Age = 50                        ===> s2
        ----------------------------
        */
                
        s1.Name = 'Kiran';
        s2.Phone = '22222';

        /*
        ----------------------------
        Name = Kiran                     ===> std
        Phone = 22222                    ===> s1
        Age = 50                         ===> s2
        ----------------------------
        */
                
        std.Name = 'Praveen';
        s1.Age = 90;
        
        /*
        ----------------------------
        Name = Praveen                   ===> std
        Phone = 22222                    ===> s1
        Age = 90                         ===> s2
        ----------------------------
        */
                
        s2.Age = 100;

        /*
        ----------------------------
        Name = Praveen                     ===> std
        Phone = 22222                      ===> s1
        Age = 100                          ===> s2
        ----------------------------
        */
        
        // Here std, s1 and s2 are referring to same location, if the value is changed by any of the variable the location value is changed for every object.
        system.debug(std.Name);      // Praveen
        system.debug(s1.Name);       // Praveen
        system.debug(s2.Name);       // Praveen
        
        system.debug(std.Phone);      // 22222
        system.debug(s1.Phone);       // 22222
        system.debug(s2.Phone);       // 22222
        
        system.debug(std.Age);      // 100
        system.debug(s1.Age);       // 100
        system.debug(s2.Age);       // 100
    }
    
    public class Student {
        public String name;
        public String phone;
        public Integer age;
    }
}