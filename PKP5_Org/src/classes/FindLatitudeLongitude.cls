global class FindLatitudeLongitude {
  webservice static String[] getLatitudeLongitude(String AccId){
     Account myAccount = [select Name,BillingCity,BillingState,BillingCountry  from Account where id=:AccId]; 
    String url = 'http://maps.google.com/maps/geo?';
      url += 'q=' +EncodingUtil.urlEncode(myAccount.BillingCity  != null ? myAccount.BillingCity : '','UTF-8');
      url += ',' + EncodingUtil.urlEncode(myAccount.BillingState != null ? myAccount.BillingState : '','UTF-8');
      url += ',' + EncodingUtil.urlEncode(myAccount.BillingCountry != null ? myAccount.BillingCountry : '','UTF-8');
      url += '&output=csv&key=ABQIAAAAmv1gQxxD9zri7212lJpFzRSiPqC6cYP_G4uopfVOWWQjDCoUiBSxTiP45RUPtqEdJ_l3YNqXR5kADA';
      Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setHeader('Content-type', 'application/x-www-form-urlencoded');
      req.setHeader('Content-length', '0');
      req.setEndpoint(url);
      req.setMethod('POST');
      HttpResponse res = h.send(req);
      String responseBody =  res.getBody();
      String[] cor = responseBody.split(',',0);
      return cor;
  }
  webservice static String[] getLatitudeLongitudeOfAddress(String Country,String State,String City,String Street,String PostalCode){
    String url = 'http://maps.google.com/maps/geo?';
      url += 'q=' + EncodingUtil.urlEncode(Street != null ? Street : '','UTF-8');
      url += ',' + EncodingUtil.urlEncode(City  != null ? City : '','UTF-8');
      url +=  ',' + EncodingUtil.urlEncode(State  != null ? State : '', 'UTF-8');
      url +=  ',' + EncodingUtil.urlEncode(Country  != null ? Country : '', 'UTF-8');
      url +=  ',' + EncodingUtil.urlEncode(PostalCode  != null ? PostalCode : '', 'UTF-8');
      url += '&output=csv&key=ABQIAAAAmv1gQxxD9zri7212lJpFzRSiPqC6cYP_G4uopfVOWWQjDCoUiBSxTiP45RUPtqEdJ_l3YNqXR5kADA';
      Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setHeader('Content-type', 'application/x-www-form-urlencoded');
      req.setHeader('Content-length', '0');
      req.setEndpoint(url);
      req.setMethod('POST');
      HttpResponse res = h.send(req);
      String responseBody =  res.getBody();
      String[] cor = responseBody.split(',',0);
      return cor;
  }
}