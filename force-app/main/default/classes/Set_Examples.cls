public class Set_Examples {

    public static void setPractice(){
        // add(element) Examples
        
        // Create a Set to store city names Hyd, Ban, Che, Pune
        Set<String> cities = new Set<String>{'Hyd', 'Ban', 'Che', 'Pune'};
        system.debug(cities);
        cities.add('Ngp');
        
        // Create a set to store courses
        Set<String> courses = new Set<String>{'Java', 'C', 'Swift', 'C++', 'Python', 'Apex'};
        courses.add('Lightning');
        system.debug(courses);
        
        // Create a Set to store salaries
        Set<Decimal> salaries = new Set<Decimal>{12313.45, 234566.45, 34636.66};
        salaries.add(83784.89);
        system.debug(salaries);
            
        // addAll(list/set) Examples
        List<Integer> agesList = new List<Integer>{10, 20, 40, 50};
        
        Set<Integer> agesSet = new Set<Integer>();
        
        agesSet.addAll(agesList);
        
        // clear()
        agesSet.clear();
        system.debug('After Clear : ' + agesSet);
        
        // remove(element):
        system.debug('Courses : ' + courses);
        courses.remove('Python');
        system.debug('Courses : ' + courses);
        
        // removeAll()
        List<String> coursesToDelete = new List<String>{'Java', 'C++'};
        courses.removeAll(coursesToDelete);
        system.debug('After removeAll() : ' + courses);
        
        // contains(element)
        system.debug('contains Java : ' + courses.contains('Java'));
        system.debug('contains java : ' + courses.contains('java'));
        system.debug('contains Swift : ' + courses.contains('Swift'));
        
        // containsAll(List/Set)
        Set<Integer> numbers = new Set<Integer>{10, 20, 30, 40, 50, 60, 70};
        List<Integer> even = new List<Integer>{20, 40, 60};
        Set<Integer> odd = new Set<Integer>{10, 30, 90};
        
		system.debug('Contains All Even : ' + numbers.containsAll(even));
        system.debug('Contains All Odd : ' + numbers.containsAll(odd));
        
        // size()
        system.debug('Size of numbers Set : ' + numbers.size());
        
        // Create Set of Opportunity
        Opportunity opp1 = new Opportunity();
        opp1.Name = 'Ajmera';
        opp1.CloseDate = system.today();
        
        Opportunity opp2 = new Opportunity();
        opp2.Name = 'Bajaj';
        opp2.CloseDate = system.today().addDays(2);
        
        Set<Opportunity> oppSet = new Set<Opportunity>{opp1, opp2};
        
        // Test Same Account Data in Account
        
        Account acc1 = new Account();
        acc1.Name = 'TCS';
        acc1.Rating = 'Hot';
        acc1.Industry = 'IT';
        
        Account acc2 = new Account();
        acc2.Name = 'TCS';
        acc2.Rating = 'Hot';
        acc2.Industry = 'IT';
        
        List<Account> accList = new List<Account>{acc1, acc2}; // accList : (Account:{Name=TCS, Rating=Hot, Industry=IT}, Account:{Name=TCS, Rating=Hot, Industry=IT})
        system.debug('accList : ' + accList);
        
        Set<Account> accSet = new Set<Account>{acc1, acc2}; // accSet : {Account:{Name=TCS, Rating=Hot, Industry=IT}}
        system.debug('accSet : ' + accSet);
        
        
    }
}