public class Future_Method_Ex1 {
	
    @future
    public static void callMe(){
        system.debug('Call Me 1');
        system.debug('Call Me 2');
        system.debug('Call Me 3');
    }
    
    @future
    public static void invoke(){
        system.debug('Invoke 1');
        system.debug('Invoke 2');
        system.debug('Invoke 3');
    }
    
    public void show(){
        system.debug('Show 1');
        system.debug('Show 2');
        callMe();
        system.debug('Show 3');
        system.debug('Show 4');
        invoke();
        system.debug('Show 5');
        system.debug('Show 6');
    }
}