public with sharing class DeleteWithCheckboxController {
 
 @AuraEnabled
 public static list < Opportunity > fetchContact() {
  list < Opportunity > returnConList = new List < Opportunity > ();
 
  List < Opportunity > lstCon = [SELECT Name, StageName,AccountId,CloseDate,OwnerId From Opportunity LIMIT 50];
  // play for loop on lstCon and add each contact to returnConList List.
  for (Opportunity c: lstCon) {
   returnConList.add(c);
  }
 // return the List of contacts
  return returnConList;
 }
    
 @AuraEnabled
public static List<ListView> getListViews() {
    List<ListView> listviews = [SELECT Id, Name FROM ListView WHERE SobjectType = 'Opportunity'];

    // Perform isAccessible() check here
    return listviews;
}
 
 
 @AuraEnabled
 public static List < String > deleteRecords(List < String > lstRecordId) {
  // for store Error Messages  
  List < String > oErrorMsg = new List < String > ();
  // Query Records for delete where id in lstRecordId [which is pass from client side controller] 
  List < Opportunity > lstDeleteRec = [select Id from Opportunity where id IN: lstRecordId];
  
 
  Database.DeleteResult[] DR_Dels = Database.delete(lstDeleteRec, false);
  // Iterate through each returned result
  for (Database.DeleteResult dr: DR_Dels) {
   if (dr.isSuccess()) {
      system.debug('successful delete contact');
     // Operation was successful
   } else {
    // Operation failed, so get all errors   
    oErrorMsg.add('');
    for (Database.Error err: dr.getErrors()) {
     // add Error message to oErrorMsg list and return the list
     oErrorMsg.add(err.getStatusCode() + ': ' + err.getMessage());
    }
   }
  }
  return oErrorMsg;
 
 }
}