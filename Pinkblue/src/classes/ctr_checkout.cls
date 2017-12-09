public with sharing class ctr_checkout{

   
   
    Public Decimal  lat {get; set;}
    Public Decimal lon {get; set;}
    Public Id lid {get; set;}
    Public String lename {get; set;}
    Public Id checkinid {get; set;}
    //Public Id did {get; set;} 
    
    //Public Id acc {get; set;}
    //Public Id oppid {get; set;}
    Public Id Userid {get; set;}
   Public Boolean displaylatlon {get; set;}
    
   Public ctr_checkout(){
            displaylatlon = false;   
            lid = ApexPages.currentPage().getParameters().get('id'); 
            
            
            Lead l = [Select id, Name,PB_Check_In_Id__c from Lead where id=:lid limit 1];
           
            User Usr = new User();
            Usr = [SELECT id, PB_Check_In_Id__c ,PB_Check_In_Name__c,Entity_Name__c, Phone FROM User WHERE Id = : UserInfo.getUserId() limit 1]; 
            
            if(l.PB_Check_In_Id__c!='' && l.PB_Check_In_Id__c!=null)
            {
                displaylatlon = true; 
               
            }
            else
            {
                 displaylatlon = false; 
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'You didnot checked-In for this Lead, Please use the Check-in button'));
                
                
         }              
               
                 
     }
     
     
        
    
    
 /*   public PageReference Updatelocation(){
         lid = ApexPages.currentPage().getParameters().get('id');
         lename = ApexPages.currentPage().getParameters().get('lname');
         Userid = UserInfo.getUserId();
         try{
             Check_In_Check_Out__c chk = new Check_In_Check_Out__c();
             chk.PB_Check_In__c= true;
             //chk.Name='Checked In';
             chk.PB_Lead_Name__c=lid;
             system.debug('***lon'+lon);
             system.debug('***lat'+lat);
             chk.PB_Check_In_Location__Longitude__s=lon;
             chk.PB_Check_In_Location__Latitude__s=lat;
             //chk.CheckIn__c = TRUE;
             chk.PB_Check_In_Date_Time__c = system.now();
             insert chk;
             Lead le = new Lead();
             Le.id = lid;
             Le.PB_Check_In_Id__c= chk.id;
             update le;
             User u = new User();
             u.id=Userid;
             u.PB_Check_In_Id__c = lid;
             u.PB_Check_In_Name__c =lename;
             u.Entity_Name__c = 'Lead';
             update u;
         }
         catch(Exception e){
          
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,e.getmessage()));
           return null;
         }
         
        return new PageReference('/'+lid);
        
        }*/
        
    
    public PageReference Checkoutlocation(){
         lid = ApexPages.currentPage().getParameters().get('id');
         lename = ApexPages.currentPage().getParameters().get('lname');
         checkinid = ApexPages.currentPage().getParameters().get('checkinid');
         Userid = UserInfo.getUserId();
         try{
         Check_In_Check_Out__c chk = new Check_In_Check_Out__c();
         chk.id=checkinid;
         chk.PB_Check_Out__c = true;
         //chk.Check_In_Check_Out_Purpose__c= 'Lead Visit';
         chk.PB_Check_Out_Date_Time__c= system.now();
         //chk.Name='Checked Out';
         chk.PB_Lead_Name__c=lid;
         system.debug('***lon'+lon);
         system.debug('***lat'+lat);
         chk.PB_Check_Out_Location__Longitude__s=lon;
         chk.PB_Check_Out_Location__Latitude__s=lat;
         system.debug('&&&'+chk);
         update chk;
         Lead le = new Lead();
         Le.id = lid;
         Le.PB_Check_In_Id__c='';
         update le;
         User u = new User();
         u.id=Userid;
         u.PB_Check_In_Id__c ='';
         u.PB_Check_In_Name__c ='';
         u.Entity_Name__c = '';
         update u;
         }
         catch(Exception e){
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,e.getmessage()));
           return null;
         }
        return new PageReference('/'+lid);
        
    }
    
  }