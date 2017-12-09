/**************************************
Class Name      : ctr_OrderInfo 
Purpose         : to get the Order from Magento.
Created Date    : 3rd December 2017
Created By      : Veneratesolution
Last modified By : 3rd December 2017
**************************************/
public with sharing class ctr_OrderInfo {

    private static final String ORDER_URL = 'https://pinkblue.in/rest/V1/orders?fields=search_criteria,total_count,items[customer_id,customer_email,customer_group_id,increment_id,created_at,total_item_count,grand_total,subtotal,subtotal_incl_tax,tax_amount,discount_amount,discount_percent,shipping_amount,shipping_description,coupon_code,status,total_paid,items[sku,name,original_price,price,price_incl_tax,product_type,qty_ordered,qty_invoiced,qty_shipped,qty_canceled,qty_refunded],billing_address[firstname,lastname,postcode],payment[method],status_histories,extension_attributes[shipping_assignments[shipping[method,address[firstname,lastname,postcode,telephone],total[shipping_amount]],items[sku,name,qty_ordered]]]]&searchCriteria[filter_groups][0][filters][0][field]=customer_email&searchCriteria[filter_groups][0][filters][0][value]=rajsuresh85@gmail.com&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[filter_groups][1][filters][0][field]=created_at&searchCriteria[filter_groups][1][filters][0][value]=2017-01-01 00:00:00&searchCriteria[filter_groups][1][filters][0][condition_type]=gteq';
    @future(callout=true)
    public static void runOrderSync(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pinkblue.in/rest/V1/orders?fields=search_criteria,total_count,items[customer_id,customer_email,customer_group_id,increment_id,created_at,total_item_count,grand_total,subtotal,subtotal_incl_tax,tax_amount,discount_amount,discount_percent,shipping_amount,shipping_description,coupon_code,status,total_paid,items[sku,name,original_price,price,price_incl_tax,product_type,qty_ordered,qty_invoiced,qty_shipped,qty_canceled,qty_refunded],billing_address[firstname,lastname,postcode],payment[method],status_histories,extension_attributes[shipping_assignments[shipping[method,address[firstname,lastname,postcode,telephone],total[shipping_amount]],items[sku,name,qty_ordered]]]]&searchCriteria[filter_groups][0][filters][0][field]=customer_email&searchCriteria[filter_groups][0][filters][0][value]=rajsuresh85@gmail.com&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[filter_groups][1][filters][0][field]=created_at&searchCriteria[filter_groups][1][filters][0][value]=2017-01-01 00:00:00&searchCriteria[filter_groups][1][filters][0][condition_type]=gteq');
        request.setMethod('GET');
        request.setHeader('Authorization','Bearer ivke21u568km4x6u5t07al1q2vjr7gt1');
        request.setHeader('Charset', 'UTF-8');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
           
            List<Object> Contacts = (List<Object>) JSON.deserializeUntyped(response.getBody());
            List<Orders__c> Orders = new List<Orders__c>();
            for(Object o :  Contacts){
                Map<String, Object> mapOrder = (Map<String, Object>)o;
                Orders__c order = new Orders__c();
                order.Name = (String)mapOrder.get('name');
                order.Time_Stamp__c = (DateTime)mapOrder.get('created_at');
                order.Email__c = (String)mapOrder.get('customer_email');
                orders.add(order);
            }
            if(orders.size() > 0){
                System.debug(orders);
                upsert orders;
            }
        }
    }

}