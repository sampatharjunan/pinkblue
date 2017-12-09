/*********************************************************
Class Name         :  ctr_feedbackform
Purpose            :  To get the feedback from guest.
Created By         :  VenerateSolutions
Created Date       :  19th May 2017
Last Modified Date :  18th June 2017
***********************************************************/

public with sharing class ctr_feedbackform {

    public PageReference submit() {
        return null;
    }


    public ctr_feedbackform() {

    }


    public String userLangString { get; set; }
    public string langu{get;set;}
    Public Feedback__c feedback {get; set;}
    Public String email {get; set;}
    Public ID casenum {get; set;}


    public ctr_feedbackform(ApexPages.StandardController controller) {
        
        email = ApexPages.currentPage().getParameters().get('email');
        casenum = ApexPages.currentPage().getParameters().get('casenum');
        if(UserInfo.getUserType() == 'Guest' && ApexPages.currentPage().getCookies().get('lang') != null){ // lang is a custom cookie defined.
        Cookie userLang = ApexPages.currentPage().getCookies().get('lang');
        string userLangString = userLang.getValue();
        }
        if(UserInfo.getUserType() != 'Guest'){
            String userlang = [select LanguageLocaleKey from User where Id=:UserInfo.getUserId()].LanguageLocaleKey;
        }
        feedback = new feedback__c();
    }
    
   
    //Set Language into cookies
    @testVisible private void languageCookiValue(string lan){
        Cookie cook = new cookie('language',lan,null,-1,false);
        List<Cookie> cookies = new List<Cookie>();
        cookies.add(cook);
        ApexPages.currentPage().setCookies(cookies);   
    }
    //Fetch cookie's language
    @testVisible private string fetchLanguageCook(){
        string data='';
        Cookie cook = ApexPages.currentPage().getCookies().get('language');
        if(cook != null){
            data = cook.getvalue();
        }
        return data;
    }
    public PageReference refreshPage(){
        Cookie c = new Cookie('lang', userLangString,null,-1,true);
        ApexPages.currentPage().setCookies(new Cookie[]{c});
        PageReference p = ApexPages.currentPage();
        p.setRedirect(true);
        return p;
    }

    public List<SelectOption> getTypes(){
        Schema.sObjectType sobject_type = Feedback__c.getSObjectType();
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe();
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap();
        List<Schema.PicklistEntry> pick_list_values = field_map.get('PB_Survey_Result__c').getDescribe().getPickListValues();
        List<selectOption> types = new List<selectOption>();
        for (Schema.PicklistEntry a : pick_list_values) {
                  types.add(new selectOption(a.getLabel(), a.getValue()));
        }
        return types;
    }
  
    public PageReference save() {
       try{ 
       
           //feedback.
          email = ApexPages.currentPage().getParameters().get('email');
          casenum = ApexPages.currentPage().getParameters().get('casenum');
          feedback.Email__c= email;
          feedback.Case_Number__c = casenum;
          feedback.PB_Survey_Result__c = feedback.PB_Survey_Result__c;
          insert feedback;
          PageReference pr= Page.thankyou;
          pr.setRedirect(true);
          return pr;         
        }
        Catch(exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,''+e));
        return null;
        }           
            
       return null;
    }
    
    public PageReference Cancel() {
         PageReference pr= Page.feedback;
         pr.setRedirect(true);
         return pr;

    }


}