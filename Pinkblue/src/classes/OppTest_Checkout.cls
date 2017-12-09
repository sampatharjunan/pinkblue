@isTest
public class OppTest_Checkout {
    
    static testMethod void testCheckout(){
        
      
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
       User u = new User(Alias = 'stan', Email='standarduser@testorg00000.com', 
            EmailEncodingKey='UTF-8', LastName='Testing333333', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser0000000@testorg.com',PB_Check_In_Id__c='111gggg1');

       // insert u;
      

       u = [SELECT id, PB_Check_In_Id__c ,PB_Check_In_Name__c,Entity_Name__c, Phone FROM User WHERE Id = : UserInfo.getUserId() limit 1]; 
        Account ac= new Account();
        Opportunity op= new Opportunity();
        op.Name = 'Raju';
        //op.PB_Email_Id__c = 'raju@gmail.com';
        op.StageName='Quotation';
        op.Check_In_Id__c='';
        op.AccountId=ac.Id;
        op.CloseDate= Date.newInstance(2016, 12, 9);
        op.OwnerId = u.Id;
        insert op; 
        
       
       ApexPages.currentPage().getParameters().put('id',op.Id);
       ApexPages.StandardController controller = new ApexPages.StandardController(op);
       opp_checkout c = new opp_checkout(); 
      Check_In_Check_Out__c ch = new Check_In_Check_Out__c();
      ch.Opportunity_Name__c=op.Id; 
      ch.PB_Check_Out__c = true;
      ch.PB_Check_In_Location__Latitude__s =12.8995716667; 
      ch.PB_Check_In_Location__Longitude__s =77.6019733333;  
      insert ch;
      c.OppCheckoutlocation();
      //c.Checkoutlocation();
      //c.checkinid = ch.Id;
      //c.oppid = op.Id;
      
     /* try
        {
                    
                    if(Test.isRunningTest())
                         integer intTest =1/0;  
        } catch(exception qe)// exception handling
            {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.error, qe.getMessage());
                
            }*/
        
    
        
    }


}