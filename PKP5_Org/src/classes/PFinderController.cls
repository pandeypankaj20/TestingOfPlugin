public class PFinderController {
    public String selectedAccName {set;get;}
    public String selectedZip {set;get;}
    public String qry {set;get;}
    public List<innerCls> lstAcc {set;get;}
    static Integer globalCounter;
    
    public PFinderController(){
        lstAcc = new List<innerCls>();
        globalCounter = 0; 
    } 
     
    public void searchAcc(){
        globalCounter = 1;
        lstAcc = new List<innerCls>(); 
        String qry = ' SELECT Id,Name,BillingStreet, BillingState,Longitude__c,Latitude__c, BillingPostalCode, ' ; 
                  qry += ' BillingCountry, BillingCity From Account WHERE Longitude__c!=NULL AND Latitude__c != NULL ';
                 
            if(selectedAccName != NULL && selectedAccName != ''){
                 qry += ' AND Name like \''+ selectedAccName + '%\'';
            }
            if(selectedZip != NULL && selectedZip != ''){
                qry += ' AND BillingPostalCode like \''+ selectedZip + '%\'';
            }
            qry += ' LIMIT 1000 ';
             
        System.debug('****************QUERY************' + qry);
        for(Account acc:Database.query(qry))
                lstAcc.add(new innerCls(acc)); 
    }
    public class innerCls{
        public Integer count{set;get;}
        public Account acc {set;get;}
        public innerCls(Account acc){
                this.count = globalCounter++;
                this.acc = acc;
        }
    }
}