trigger Account_Rating_Update on Account (before insert) {
    
    List<Account> accList = Trigger.new;
    
    for(Account acc : accList){
        acc.Rating = 'Hot';
    }
}