global class RemoteJSDemo {
    public Account account {
    get{
        if(account == null)
          account = new Account(Id='00190000003oQ1H',Name='Burlington Textiles Corp of America');
        return account;
    }set;
    
    }
    public RemoteJSDemo(ControllerFB_Dream controller) {

    }
    @RemoteAction
    global static String justHello(String str){
     return 'Hello.... ' + str;
    } 
    
    @RemoteAction
    global static List<Account> findAccount(String str){
     if(str != null && str != ''){
        return database.query('SELECT Name ' +
                              ' FROM Account ' +
                              ' WHERE Name like \'' + str + '%\''
                              );
     }
     return null;
    }

}