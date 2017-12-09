trigger Duplicate_Email on Lead (before insert) {
    
    final String errMsg = 'The email id already exists';
  Set< String > emailSet = new Set< String >();
  for( Lead l : Trigger.new ) emailSet.add( l.Email );

  Map< String, Id > duplicateLeadMap = new Map< String, Id >();

  for( Lead l : [select Id, Email from Lead where Email = :emailSet] )
    duplicateLeadMap.put( l.Email, l.Id );

  for( Lead l : Trigger.new ){
    Id duplicateLeadId = duplicateLeadMap.get( l.Email );
    if( duplicateLeadId != null )
      l.addError( errMsg );
  }

}