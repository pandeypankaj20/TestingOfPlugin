public class OAuthRequestLinkedIn{

  
  public void  OAuthRequest(){
    HttpRequest req = new HttpRequest();
    req.setEndpoint('http://www.yahoo.com');
    req.setMethod('GET');
    
    Http http = new Http();
    HTTPResponse res = http.send(req);
    
    System.debug('Pankaj:' + res.getBody());
  
  }


}