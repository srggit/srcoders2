// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);



AggregateResult result = [SELECT SUM(Total_Amount__c) amtTotal FROM Account];
System.debug('===================' + (Decimal) result.get('amtTotal'));

Integer totalAccs = [SELECT COUNT() FROM Account];
System.debug('=================== totalAccs : ' + totalAccs);

AggregateResult totalRatings = [SELECT COUNT(Rating) ratings FROM Account];
System.debug('================= totalRatings : ' + totalRatings.get('ratings'));    



        public Class AnonymousWindow{

            public void apexRevision(){
            // Group By Clause
                List<AggregateResult> groupByIndustry = [SELECT COUNT(Id) FROM Account GROUP BY Industry];
                System.debug('================= groupByIndustry : ' + groupByIndustry);

                for(AggregateResult result : groupByIndustry){
                    System.debug('------');
                    System.debug(result);
                }
            }
        }

        AnonymousWindow object = new AnonymousWindow();
        object.apexRevision();