public with sharing class opp_checkin{

    


   
    Public Decimal  lat {get; set;}
    Public Decimal lon {get; set;}
    //Public Id lid {get; set;}
    Public Id checkinid {get; set;}
    Public String lename {get; set;}
    //Public Id did {get; set;} 
    
    //Public Id acc {get; set;}
    Public Id oppid {get; set;}
    Public Id Userid {get; set;}
   Public Boolean displaylatlon {get; set;}
    
   Public opp_checkin(){
            displaylatlon = false;   
            oppid = ApexPages.currentPage().getParameters().get('id'); 
            
            
            Opportunity l = [Select id,Name,Check_In_Id__c from Opportunity where id=:oppid limit 1];
           
            User Usr = new User();
            Usr = [SELECT id,PB_Check_In_Id__c ,PB_Check_In_Name__c,Entity_Name__c, Phone FROM User WHERE Id = : UserInfo.getUserId() limit 1]; 
            
            if(l.Check_In_Id__c!='' && l.Check_In_Id__c!=null)
            {
                displaylatlon = false;
                if(oppid==usr.PB_Check_In_Id__c) 
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'You already checked-In for this Opportunity, Please use the Check-out button'));
                else
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'You already checked-In for this entity -'+ usr.Entity_Name__c + '- '+ usr.PB_Check_In_Name__c +',Please Check-Out first to Check-IN again'));
            }
            else
            {
                 
                   
                 if(usr.PB_Check_In_Id__c!='' && usr.PB_Check_In_Id__c!=null)
                 {
                     displaylatlon = false; 
                     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'You already checked-In for this entity -'+ usr.Entity_Name__c +'- '+ usr.PB_Check_In_Name__c +',Please Check-Out first to Check-IN again'));
                 }
                 else
                 {
                    displaylatlon = true; 
                 }   
                
         }              
               
                 
     }
         
    
    
    public PageReference OppUpdatelocation(){
         oppid = ApexPages.currentPage().getParameters().get('id');
         lename = ApexPages.currentPage().getParameters().get('lname');
         Userid = UserInfo.getUserId();
         try{
             Check_In_Check_Out__c chk = new Check_In_Check_Out__c();
             chk.PB_Check_In__c= true;
             //chk.Name='Checked In';
             chk.Opportunity_Name__c=oppid;
             system.debug('***lon'+lon);
             system.debug('***lat'+lat);
             chk.PB_Check_In_Location__Longitude__s=lon;
             chk.PB_Check_In_Location__Latitude__s=lat;
             //chk.Check_In__c = TRUE;
             //chk.Check_In_Check_Out_Purpose__c = 'Lead Visit';
             chk.PB_Check_In_Date_Time__c = system.now();
             insert chk;
             Opportunity le = new Opportunity();
             Le.id = oppid;
             Le.Check_In_Id__c= chk.id;
             update le;
             User u = new User();
             u.id=Userid;
             u.PB_Check_In_Id__c = oppid;
             u.PB_Check_In_Name__c =lename;
             u.Entity_Name__c = 'Opportunity';
             update u;
         }
         catch(Exception e){
          
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,e.getmessage()));
           return null;
         }
         
        return new PageReference('/'+oppid);
        
        }
      }