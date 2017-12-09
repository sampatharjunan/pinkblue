public with sharing class ctr_Recommendation {
    Public List< Object> mainitems {get; set;}
    Public Map < String, Object > mapitems {get; set;}
    Public List<Map < String, Object >> listmapitems {get; set;}
    public ctr_Recommendation() {

    }


    public PageReference webservcie(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://retail.recosenselabs.com/v1/recommendation/?client_id=pinkblue&item_id=3ME01_057&rails=similar_product&page_number=0&page_size=12');
        //request.setHeader('Content-type', 'application/json');
        request.setMethod('GET');
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
            
        }
        return null;
    }
   
}