public with sharing class StarPattern {
    public StarPattern() {

        for(Integer i=1; i<=5; i++){
            for(Integer j=1; j<=i; j++){
                System.debug('*');
            }
            System.debug('\n');
        }
    }
}