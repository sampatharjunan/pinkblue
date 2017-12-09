@isTest
public class DeleteWithCheckboxControllerTest {
    static testMethod void testDeleteCheckBox(){
        
        Account a = new Account();
        a.Name = 'subbu';
        insert a;
        opportunity op = new opportunity();
        op.AccountId = a.Id;
        op.Name = a.Name;
        op.StageName ='Closed Won';
        op.CloseDate = system.today();
        insert op;
       List<string> l = new List<string>();
        string l1 = 'Test';
        string l2 = 'Test1';
        l.add(l1);
        l.add(l2);

        string d =op.Id;
        
       // DeleteWithCheckboxController dc = new DeleteWithCheckboxController(a);
        DeleteWithCheckboxController.fetchContact();
        DeleteWithCheckboxController.getListViews();
      DeleteWithCheckboxController.deleteRecords(l);
        


        }

}