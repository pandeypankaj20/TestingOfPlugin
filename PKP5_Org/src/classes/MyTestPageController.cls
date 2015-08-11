public class MyTestPageController {
    
    Merchandise__c merc;
    
    public  Merchandise__c  getMerc(){
     return merc;
    }
    
    public void setMerc(Merchandise__c value){
     this.merc = value;
    }
  
    public List<Merchandise__c> lstMerc {set;get;}
    /*
     sadfasdf
    */
    public String searchText {set;get;}
    
    public PageReference save(){ 
      System.debug('*****************' + searchText );
      lstMerc = [select Id,Name from Merchandise__c where name like : '%' + searchText + '%'];
      
      return null;
    }
    
    public PageReference cancel(){ 
      PageReference pg = new PageReference('/a09/o');
     return pg;
    
    }
    

}