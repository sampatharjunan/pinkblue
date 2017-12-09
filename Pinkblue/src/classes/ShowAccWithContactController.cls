public class ShowAccWithContactController {
    public boolean enable{get;set;}
        public boolean conenable{get;set;}
    public boolean disable{get;set;}
    public list<account> accounts{get;set;}
    public String accountId {get; set;}
    public String contactId {get; set;}
    public list<Contact> contacts{get;set;}
 public ShowAccWithContactController()
    {
        string acc='select id,name,shippingcity from account limit 20';
        accounts=database.query(acc);
     //   system.assert(false,'Acc::::'+accounts);
    enable=true;
        conenable=false;
        disable=false;
    }
    
    public PageReference showContacts() {
        conenable=true;
        enable=true;
        disable=false;
        contacts = [Select id, name from Contact where AccountId = :accountId];
        //system.assert(false,'Acc::::'+accountId); 
        return null;
    }
    public void createopp()
    { 
        opportunity opp=new opportunity(name='AccOpp',stagename='Prospecting', closedate=date.today(),accountid=accountId);
        insert opp;
        opportunitycontactrole ocrole=new opportunitycontactrole(opportunityid=opp.id,contactid=contactId,isprimary=true);
        insert ocrole;
    enable=false;
        disable=true;
      //  sendmail(opp);
    }
    }