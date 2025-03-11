// Sort the Array in Ascending Order
public class ArraySort {
    
    public static void sorting(){
        Integer[] numbers = new Integer[]{30, 40, 50, 80, 10};
		Integer counter = 0;
        
        system.debug('========== My Logic ==========');
        for(Integer i=0; i<numbers.size(); i++){
            for(Integer j=0; j<numbers.size(); j++){
                if(numbers[i] < numbers[j]){
                    Integer temp = numbers[i]; // 30
                    numbers[i] = numbers[j]; // 10
                    numbers[j] = temp; // 30
                    counter++;
                    system.debug(numbers);
                }
            }
        }
        
        system.debug(numbers);
        system.debug(counter);
        
        
        // Implementing bubble sort for ascending order
        for(Integer i=0; i<numbers.size() - 1; i++){
            for(Integer j=0; j<numbers.size() - 1 - i; j++){
                if(numbers[j] > numbers[j + 1]){
                    Integer temp = numbers[j];
                    numbers[j] = numbers[j + 1];
                    numbers[j + 1] = temp;
                    counter++;
                }
            }
        }
        system.debug(numbers);
        system.debug(counter);

/*
  0     1   2    3    4
--------------------------     
| 30 | 40 | 50 | 80 | 10 |
--------------------------

i=0
  0     1   2    3    4
--------------------------     
| 30 | 40 | 50 | 10 | 80 |
--------------------------

i=1
  0     1   2    3    4
--------------------------     
| 30 | 40 | 10 | 50 | 80 |
--------------------------

i=2
  0     1   2    3    4
--------------------------     
| 30 | 10 | 40 | 50 | 80 |
--------------------------

i=3
  0     1   2    3    4
--------------------------     
| 10 | 30 | 40 | 50 | 80 |
--------------------------
*/
        
        // Implementing bubble sort for descending order
        for (Integer i = 0; i < numbers.size() - 1; i++) {
            for (Integer j = 0; j < numbers.size() - 1 - i; j++) {
                if (numbers[j] < numbers[j + 1]) {
                    // Swap elements
                    Integer temp = numbers[j];
                    numbers[j] = numbers[j + 1];
                    numbers[j + 1] = temp;
                }
            }
        }
        system.debug(numbers);
        system.debug(counter);
    }
}