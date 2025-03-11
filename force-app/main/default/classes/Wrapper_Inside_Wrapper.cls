public with sharing class Wrapper_Inside_Wrapper {
    
    public void printStudentDetail(){

        List<StudentDetails> lstStudentDetails = new List<StudentDetails>();

        StudentDetails std1 = new StudentDetails();
        std1.stdFirstName = 'Suraj';
        std1.stdLastName = 'Shah';
        std1.stdAge = 30;

        std1.stdAddress = new StudentAddress();
        std1.stdAddress.city = 'Bangalore';
        std1.stdAddress.state = 'Telengana';
        std1.stdAddress.postalCode = 344556;
        std1.stdAddress.landmark = 'Sk Nagar';

        lstStudentDetails.add(std1);

        StudentDetails std2 = new StudentDetails();
        std2.stdFirstName = 'Satish';
        std2.stdLastName = 'Pal';
        std2.stdAge = 56;

        std2.stdAddress = new StudentAddress();
        std2.stdAddress.city = 'Nagpur';
        std2.stdAddress.state = 'Maharashtra';
        std2.stdAddress.landmark = 'Dharampeth';
        std2.stdAddress.postalCode = 090908;

        lstStudentDetails.add(std2);

        System.debug('lstStudentDetails : ' + lstStudentDetails);

        for(StudentDetails sd : lstStudentDetails){
            System.debug('First Name : ' + sd.stdFirstName);
            System.debug('Last Name : ' + sd.stdLastName);
            System.debug('First Name : ' + sd.stdAge);

            System.debug('City : ' + sd.stdAddress.city);
            System.debug('Last Name : ' + sd.stdAddress.state);
            System.debug('Last Name : ' + sd.stdAddress.landmark);
            System.debug('Last Name : ' + sd.stdAddress.postalCode);

            System.debug('===================================================');
        }
    }

    // Defining Wrapper Classes
    public class StudentDetails{

        public String stdFirstName;
        public String stdLastName;
        public Integer stdAge;

        public StudentAddress stdAddress;
    }

    public class StudentAddress{
        public String city;
        public String state;
        public String landmark;
        public Integer postalCode;
    }
}