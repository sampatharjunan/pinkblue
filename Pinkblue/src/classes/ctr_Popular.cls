public with sharing class ctr_Popular {
    Public List< Object> mainitems {get; set;}
    Public Map < String, Object > mapitems {get; set;}
    Public List<Map < String, Object >> listmapitems {get; set;}
    public ctr_Popular() {

    }


    public PageReference webservcie(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://retail.recosenselabs.com/v1/popular?client_id=pinkblue&rails=bestsellers');
        //request.setHeader('Content-type', 'application/json');
        request.setMethod('GET');
        
        string autho = 'Bearer '+userInfo.getSessionId();
        request.setHeader('Authorization', autho);
        
        HttpResponse response = http.send(request);
        String jsonBody = response.getBody();
        List < Object > items = (List < Object > ) JSON.deserializeUntyped(jsonBody);
        system.debug('****' + items);
        for (Object o: items) {
            Map < String, Object > maprec = (Map < String, Object > ) o;
            String pgnu = (String) maprec.get('rail_name');
            system.debug('&&&&pgnu' + pgnu);
            mainitems = (List < Object > ) maprec.get('items');
            system.debug('&&&&items' + mainitems);
        }
        for (Object m: mainitems) {
            mapitems = (Map < String, Object > ) m;
            String strbrand= (String) mapitems.get('brand');
            system.debug('##&&items' + strbrand);
        }
        return null;
    }
   
}