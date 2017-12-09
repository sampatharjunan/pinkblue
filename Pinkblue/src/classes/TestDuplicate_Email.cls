@isTest
public class TestDuplicate_Email {
    
    static testMethod void duplicateemailTest(){
        
        Lead l = new Lead();
        l.Company = 'VS';
        l.Email = 'subbusfdc5@gmail.com';
        l.Status = 'Open';
        l.LastName ='Raj';
        l.MobilePhone ='8885151145';
        l.PB_Alternative_Mobile_Number__c = '8885151145';
        insert l;
        
    }

}