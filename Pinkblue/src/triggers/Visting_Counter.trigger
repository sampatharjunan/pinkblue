trigger Visting_Counter on Check_In_Check_Out__c (after insert) {
    set<Id> lids = new set<Id>();   
    for(Check_In_Check_Out__c c:Trigger.New){
        lids.add(c.PB_Lead_Name__c);
        
    }
    List<Lead> lds = [select No_Of_Visits__c from Lead where id=:lids];
    
    for(Lead l:lds){
        if(l.No_Of_Visits__c==null || l.No_Of_Visits__c==0){
           l.No_Of_Visits__c=1;            
        } else{
          l.No_Of_Visits__c= l.No_Of_Visits__c+1;  
        }
        
    } update lds;
    
    
    
    for(Check_In_Check_Out__c c:Trigger.New){
        lids.add(c.Opportunity_Name__c);
        
    }
    List<Opportunity> opds = [select No_Of_Visit__c from Opportunity where id=:lids];
    
    for(Opportunity op:opds){
        if(op.No_Of_Visit__c==null || op.No_Of_Visit__c==0){
           op.No_Of_Visit__c=1;            
        } else{
          op.No_Of_Visit__c= op.No_Of_Visit__c+1;  
        }
        
    } update opds;
}