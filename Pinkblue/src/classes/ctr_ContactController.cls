/**************************************
Class Name      : ctr_ContactController
Purpose         : to create a contact in salesforce CRM.
Created Date    : 24th November 2017
Created By      : Veneratesolution
Last modified By : 24th November 2017
**************************************/
@RestResource(urlMapping='/createcontacts/*')
global class ctr_ContactController {

    @HttpPost 
    global static string createcontact(String FirstName,String LastName, String Email,String MobilePhone) {
        Contact c = new Contact();
        String message ='';
        try{
            if(Email!=''){
                List<Contact> listcon = [select id, FirstName,LastName,Email from Contact where email=:Email limit 1];
                if(listcon.size() > 0){
                     c.FirstName= FirstName;
                     c.LastName= LastName;
                     c.Email= Email;
                     c.MobilePhone=MobilePhone;
                     c.id = listcon[0].id;
                     update c;
                     message = 'Contact Updated sucessfully.Unique Id of the contact is:'+c.id;
                }
                else{
                    c.FirstName= FirstName;
                    c.LastName= LastName;
                    c.Email= Email;
                    c.MobilePhone=MobilePhone;
                    insert c;
                    message = 'Contact Created sucessfully.Unique Id of the contact is:'+c.id;
               }
            }
        }
        catch(Exception ex){ 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getmessage())); 
            return null; 
       }
        
       
       return message;
   }

   
}