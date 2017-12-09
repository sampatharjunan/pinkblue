/*********************************************************
Class Name         :  ctr_feedbackformTest 
Purpose            :  To test the ctr_feedbackform controller.
Created By         :  VenerateSolutions
Created Date       :  19th May 2017
Last Modified Date :  18th June 2017
***********************************************************/


@isTest
public class ctr_feedbackformTest {
    @isTest
    
    static void feedbackTest(){
        System.currentPageReference().getParameters().put('email','pujac823@gmail.com');
        System.currentPageReference().getParameters().put('casenum','5005D000000rdYKQAY');
        System.currentPageReference().getParameters().put('lang','en');

        case c = new case();
        c.Origin ='phone';
        c.Status ='Closed';
        c.Subject= 'Test';
        insert c;
        Feedback__c fb = new Feedback__c();
        fb.Email__c ='Test@test.com';
        fb.Case_Number__c =c.Id;
        //fb.Case_Number__c ='5005D000000rdYKQAY';
        fb.PB_Survey_Result__c ='Awesome';
        insert fb;
    Apexpages.StandardController standard =new Apexpages.StandardController(c); 
        //Apexpages.currentPage().getparameters().put('id',c.id);
    ctr_feedbackform fbf = new ctr_feedbackform(standard);
        fbf.getTypes();
        fbf.Cancel();
        fbf.refreshPage();
        fbf.save();
        fbf.fetchLanguageCook();
        fbf.languageCookiValue('en');
        fbf.langu ='lang';
        
        
        
        
    }

}