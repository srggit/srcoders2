public class Wrapper_Class2 {
	
    public static void method2(){
        Customer cust = new Customer();  // null
        Customer c1 = cust;   // null
        
        /*
        -------------------------- ==> cust
        firstName;
   		lastName;
        city;
        phone;
		age;
		-------------------------- ==> c1
		*/
        
        Customer abc = new Customer(); // null
        Customer c2 = abc; // null
        /*
        -------------------------- ==> abc
		firstName;
   		lastName;
        city;
        phone;
		age;
		-------------------------- ==> c2
		*/
        
        c1.lastName = 'Myla';
        cust.firstName = 'Satish';
        c1.age = 33;
        cust.city = 'Bangalore';
        c1.Phone = '12344';
        /*
        -------------------------- ==> cust
        firstName = 'Satish';
   		lastName = 'Myla'
        city = 'Bangalore'
        phone = '12344'
		age = 33
		-------------------------- ==> c1
		*/
        
        system.debug('----------------- cust values ----------------');
        system.debug('cust.lastName : ' + cust.lastName);
        system.debug('cust.firstName : ' + cust.firstName);
        system.debug('cust.Phone : ' + cust.Phone);
        system.debug('cust.city : ' + cust.city);
        system.debug('cust.age : ' + cust.age);
        
        system.debug('----------------- c1 values ----------------');
        system.debug('c1.lastName : ' + c1.lastName);
        system.debug('c1.firstName : ' + c1.firstName);
        system.debug('c1.Phone : ' + c1.Phone);
        system.debug('c1.city : ' + c1.city);
        system.debug('c1.age : ' + c1.age);
        
        abc = c1;
        //c2 = abc;
        
        /*
        -------------------------- ==> cust
        firstName = 'Satish';
   		lastName = 'Myla'
        city = 'Bangalore'		   ==> abc
        phone = '12344'
		age = 33
		-------------------------- ==> c1
        */
        
        /*
        -------------------------- ==> 
		firstName;
   		lastName;
        city;
        phone;
		age;
		-------------------------- ==> c2 == null
		*/
        
        system.debug('----------------- abc values ----------------');
        system.debug('abc.lastName : ' + abc.lastName);
        system.debug('abc.firstName : ' + abc.firstName);
        system.debug('abc.Phone : ' + abc.Phone);
        system.debug('abc.city : ' + abc.city);
        system.debug('abc.age : ' + abc.age);
        
        
        
        system.debug('----------------- c2 values ----------------');
        system.debug('c2.lastName : ' + c2.lastName);
        system.debug('c2.firstName : ' + c2.firstName);
        system.debug('c2.Phone : ' + c2.Phone);
        system.debug('c2.city : ' + c2.city);
        system.debug('c2.age : ' + c2.age);
    }
    
    
    public class Customer{
        public String firstName;
        public String lastName;
        public String city;
        public String phone;
        public Integer age;
    }
}