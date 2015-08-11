public class ContrllerFBaccessToken2 {
   public String accessToken {set;get;}
   public Pagereference findAccessToken(){
    String URL = 'https://graph.facebook.com/oauth/access_token?client_id=47e0d44b1ac3b90e128dc24e34e73278&client_secret=2fa24ea2667b7c79a6e213d47782ebac&grant_type=client_credentials ';
      HttpRequest req = new HttpRequest();
      req.setEndpoint(URL);
      req.setMethod('GET');
      Http http = new Http();
      HTTPResponse res = http.send(req);
      accessToken = res.getBody();
      accessToken = accessToken.substring(accessToken.indexOf('=')+1);
      return null;
   }
   
}