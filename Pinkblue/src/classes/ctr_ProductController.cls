/**************************************
Class Name      : ctr_ProductController 
Purpose         : to create a prodcut in salesforce CRM.
Created Date    : 30th November 2017
Created By      : Veneratesolution
Last modified By : 30th November 2017
**************************************/
@RestResource(urlMapping='/createproducts/*')
global class ctr_ProductController {
    @HttpPost 
    global static List<responseWrapper> createproduct() {

        RestRequest req = RestContext.request;
        responseWrapper responseJSON = new responseWrapper();
        List<responseWrapper> responseJSONlist = new List<responseWrapper>();
    
        Map < String, Object > resbody = new Map < String, Object > ();
        Map < String, Object > body = new Map < String, Object > ();
        List < Object > pitems = new list < Object > ();
        String pitem_id = '';
        String ptitle = '';
        Map < String, Object > pprimary_category = new Map < String, Object > ();
        Map < String, Object > pprimary_category_tree = new Map < String, Object > ();
        String pprimary_category_tree_string = '';
        String pproduct_url = '';
        Integer pprice = 0;
        String plong_description = '';
        String pshort_description = '';
        Map < String, Object > pimages = new Map < String, Object > ();
        Integer pin_stock = 0;
        Boolean pvisible_in_catalog = false;
        Map < String, Object > pother_details = new Map < String, Object > ();
    
        String jsonBody = req.requestBody.toString();
        //String jsonBody = '{"title":"SS White The Masters Kit","item_id":"1001","other_details":"Testing","primary_category":"","primary_category_tree":"","long_description":"","short_description":"","visible_in_catalog":"","in_stock":"","Price":50.30,"product_url":"","images":""}'; 
    
        if (!String.isBlank(jsonBody)) {
            resbody = (Map < String, Object > ) JSON.deserializeUntyped(jsonBody);
            pitems = (List < Object > ) resbody.get('items');
    
            for (integer i = 0; i < pitems.size(); i++) {
                body = (Map < String, Object > ) pitems[i];
                pitem_id = (String) body.get('item_id');
                ptitle = (String) body.get('title');
                pproduct_url = (String) body.get('product_url');
                pprice = (Integer) body.get('price');
                plong_description = (String) body.get('long_description ');
                pshort_description = (String) body.get('short_description');
                pin_stock = (Integer) body.get('in_stock');
                pvisible_in_catalog = (Boolean) body.get('visible_in_catalog');
    
                Product2 p = new Product2();
                if (pitem_id != '') {
                    List < Product2 > listprod = [SELECT IsActive, Base_Image__c, Family, Customer_Name__c, Category_Tree__c, Package_Content__c, Price__c, Description, Id, Product_Type__c, ProductCode, Name, Stock_Status__c, SystemModstamp, URL_Key__c, Visibility__c FROM Product2 where ProductCode = : pitem_id limit 1];
                    if (listprod.size() > 0) {
                        p.id = listprod[0].id;
                        p.IsActive = true;
                        p.Name = ptitle;
                        p.ProductCode = pitem_id;
                        // p.Product_Type__c= other_details;
                        // p.Category__c=primary_category;
                        p.Category_Tree__c = pprimary_category_tree_string;
                        p.Description = plong_description;
                        p.Package_Content__c = pshort_description;
                        p.Visibility__c = string.valueof(pvisible_in_catalog);
                        p.Stock_Status__c = pin_stock;
                        p.Price__c = pprice;
                        p.URL_Key__c = pproduct_url;
                        // p.Base_Image__c = images;
                        Database.SaveResult updateproduct = Database.update(p);
                        if (!updateproduct.isSuccess()) {
                            List < Database.Error > errors = updateproduct.getErrors();
                            responseJSON.status = 'failure';
                            responseJSON.message = errors[0].getMessage();
                        } else {
                            responseJSON.productid = p.id;
                        }
    
                    } else {
                        p.IsActive = true;
                        p.Name = ptitle;
                        p.ProductCode = pitem_id;
                        // p.Product_Type__c= other_details;
                        // p.Category__c=primary_category;
                        // p.Category_Tree__c = primary_category_tree; 
                        p.Description = plong_description;
                        p.Package_Content__c = pshort_description;
                        p.Visibility__c = String.Valueof(pvisible_in_catalog);
                        p.Stock_Status__c = pin_stock;
                        p.Price__c = pprice;
                        p.URL_Key__c = pproduct_url;
                        // p.Base_Image__c = images;
    
                        Database.SaveResult insertproduct = Database.insert(p);
                        if (!insertproduct.isSuccess()) {
                            List < Database.Error > errors = insertproduct.getErrors();
                            responseJSON.status = 'failure';
                            responseJSON.message = errors[0].getMessage();
                        } else {
                            responseJSON.productid = p.id;
                        }
    
                    }
                }
                responseJSONlist.add(responseJSON);
    
            }
    
        }
        return responseJSONlist;
    }
    
    global class responseWrapper {
        global String status {get;set;} 
        global String productid {get;set;} 
        global String message {get;set;} 
        global responseWrapper() {
            this.status = 'success';
            this.productid= '';
            this.message = '';
        }
    }

}