public class IframeUpdateTestController {
 public String pageValue {set;get;}
 
 public IframeUpdateTestController(){
  PageReference pg = new PageReference('/001900000091azi');
  pageValue = pg.getContent().toString(); 
 }
 

}