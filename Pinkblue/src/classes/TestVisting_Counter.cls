@isTest
public class TestVisting_Counter {
    static testMethod void visitCounter(){
        
        Lead l= new Lead();
        l.LastName = 'subbu';
        l.Email = 'subbusfdc08@gmail.com';
        l.MobilePhone='8885151145';
        l.PB_Alternative_Mobile_Number__c='8885151145';
        l.Status ='Open';
        l.Company ='VS';
        l.No_Of_Visits__c =null;  
        insert l; 
    
    }

}