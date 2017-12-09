@RestResource(urlMapping='/RecommendationCreation/*')
global class Recommendation {
  @HttpGet
    global static List<Recommedations__c> doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        //String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
         List<Recommedations__c>	result = [SELECT Id, Name, Item_Id__c  FROM Recommedations__c];
        return result;
    }


}