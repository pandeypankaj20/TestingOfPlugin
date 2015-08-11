public class oppChartController {

    public Map<String,OppRevenue> mapYearAmt {set;get;}
    public list<OppRevenue> lstOppDtl {set;get;}
    
    public void oppChartController(){
        lstOppDtl = new list<OppRevenue>();
        mapYearAmt = new Map<String,OppRevenue>();
    }
    
    public void fetchOppData(){
       lstOppDtl = new list<OppRevenue>();
       mapYearAmt = new Map<String,OppRevenue>();
       for(Opportunity opp:[select Id,Name,closeDate,Amount,ExpectedRevenue,StageName from Opportunity where closeDate !=NULL]){
             String strYear = String.valueOf(opp.closeDate.year());
             if(mapYearAmt.containsKey(strYear)){
                 //OppRevenue amt = new OppRevenue();
                 //amt = mapYearAmt.get(strYear);
                 //amt.amount += opp.Amount;
                 //amt.expAmt += opp.ExpectedRevenue;
                 //mapYearAmt.put(strYear,amt);
              }else{
                 mapYearAmt.put(strYear,new OppRevenue(strYear,opp.Amount,opp.ExpectedRevenue,opp.StageName));
              }
        }
        lstOppDtl = mapYearAmt.values();
    }
    
    public class OppRevenue{
        public Decimal amount {set;get;}
        public Decimal expAmt {set;get;}
        public String oppYear {set;get;}
        public String oppStage {set;get;}
        public OppRevenue(){}
        public oppRevenue(string year,Decimal amt,Decimal expAmt,string stage){
          this.oppYear = year;
          this.expAmt = expAmt;
          this.amount = amt;
          this.oppStage = stage;
        }
    }
    
    
}