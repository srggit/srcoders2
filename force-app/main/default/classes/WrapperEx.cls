public class WrapperEx {
	
    public static void WrapperUse(){
        AccountInfoWrapper aiw = new AccountInfoWrapper();
        aiw.acc.Name = 'TCS';
        aiw.acc.Rating = 'Hot';
        aiw.acc.Industry = 'IT';
        aiw.acc.AnnualRevenue = 232344;
        
        aiw.flag = true;
        
        system.debug(aiw);
        
        ContactDataWrapper cdw = new ContactDataWrapper();
        // We can initialize/assign memory here
        // or
        // We can initialize/assign memory where we are using the Object.
        cdw.con = new Contact();
        
        cdw.con.FirstName = 'Satish';
        cdw.con.LastName = 'Myla';
        cdw.con.Phone = '323423455';
        cdw.con.Email = 'smyla@gmail.com';
        
        cdw.age = 45;
        cdw.email = 'mylasatish@gmail.com';
        
        system.debug(cdw);
    }
}