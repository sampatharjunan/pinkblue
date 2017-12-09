Public class MassDelete{

    


    public List<Opportunity> records{get;set;}
    public string returnUrl{get;set;}
    
    
    public MassDelete(ApexPages.StandardsetController controller)
    {
        //returnUrl=ApexPages.currentPage().getParameters().get('retUrl');
        
        records=(List<Opportunity>)controller.getSelected();
        
        ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.Info, 'List Of Objects'+records));
    
    }

    public PageReference DeleteRecord()
    {
    
        delete records;
        //returnUrl=ApexPages.currentPage().getParameters().get('retUrl');
        
        PageReference pageRef=new PageReference('https://pinkblue--pinkblue.lightning.force.com/one/one.app#/sObject/Opportunity/list?filterName=00B7F000006JuOoUAK');
        //pageRef.setRedirect(true);
        return pageRef;
        
         
    
    }




}