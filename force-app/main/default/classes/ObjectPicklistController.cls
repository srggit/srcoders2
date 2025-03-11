    public with sharing class ObjectPicklistController {

        @AuraEnabled(cacheable = true)

        //public static String getRecords(String objectName, String queryData ) {
        public static List<Account> getRecords() {
            try{
                System.debug('==================getRecords=================');
                String objectName = 'Account';
                String queryData = 'Id, Name, Rating';

                String query = 'SELECT ' + queryData + ' FROM ' + objectName + ' LIMIT 5'; 
                System.debug(query);

                List<Account> result = Database.query(query);
                System.debug(result.size());
                System.debug(result);

                return result;
            }
            catch(Exception ex){
                //return 'Error: ' + ex.getMessage();
                throw new AuraHandledException      ('Error');
            }
        }

        @AuraEnabled(cacheable = true)
        public static String getRecords2() {
            try{
                System.debug('------------ getRecords2 ------------------');

                String objectName = 'Account';
                String queryData = 'Id, Name, Rating';

                String query = 'SELECT ' + queryData + ' FROM ' + objectName + ' LIMIT 5'; 
                System.debug(query);

                List<sobject> result = Database.query(query);
                System.debug(result.size());
                System.debug(result);

                return JSON.serialize(result);
            }
            catch(Exception ex){
                //return 'Error: ' + ex.getMessage();
                throw new AuraHandledException      ('Error');
            }
            
        }

        @AuraEnabled(cacheable = true)
        public static List<sobject> getRecords3() {
            try{
                System.debug('------------ getRecords2 ------------------');

                String objectName = 'Account';
                String queryData = 'Id, Name, Rating';

                String query = 'SELECT ' + queryData + ' FROM ' + objectName + ' LIMIT 5'; 
                System.debug(query);

                List<sobject> result = Database.query(query);
                System.debug(result.size());
                System.debug(result);

                return result;

            }
            catch(Exception ex){
                //return 'Error: ' + ex.getMessage();
                throw new AuraHandledException('Error');
            }
            
        }
    }           