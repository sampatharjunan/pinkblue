trigger UpdateContact on Contact (before insert,before update) {
    
    Set<Id> ids=new Set<Id>();
    if(Trigger.isInsert || Trigger.isUpdate)
    {
        for(Contact con : Trigger.new)
        {
        
        ids.add(con.AccountId);
        for(Account acc : [select id,Primary_Contact__c from Account where id in: ids])
        {
            
        
                if(con.LastName!=NULL && con.Email!=NULL && con.MobilePhone!=NULL && con.PB_Contact_Type__c=='Primary')
                {
        
                    acc.Primary_Contact__c= con.Salutation+''+''+con.FirstName +''+''+ con.LastName;
                    acc.Primary_Contact_Email__c=con.Email;
                    acc.Primary_Contact_Mobile__c=con.MobilePhone;
        
                }
                
                /*else if(con.Email!=NULL && con.PB_Contact_Type__c=='Primary')
                {
                
                    acc.Primary_Contact_Email__c=con.Email;
                    
                }
                else if(con.MobilePhone!=NULL && con.PB_Contact_Type__c=='Primary')
                {
                
                    acc.Primary_Contact_Mobile__c=con.Contact_Number__c;
                    
                }
                
                
                
                else if(wos.Work_Order_Stages__c=='Technician Reached')
                {
                
                    opp.Stage__c='';
                    
                }
                else if(wos.Work_Order_Stages__c=='Under Installation')
                {
                
                    opp.Stage__c='Installation Work In Progress';
                    
                }
                else if(wos.Work_Order_Stages__c=='Installed')
                {
                
                    opp.Stage__c='Installation Completed';
                    
                }*/
            update acc;
        }
        }
    
    
  }

}