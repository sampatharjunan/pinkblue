public class InvoiceWrapper {
        public void getLineItemTotal(List<Recommedations__c> item) {
            this.item =item;
        }
    public class recommendation{
        public string itemname {get; set;}
        public String productName {get; set;}
 	
    }
        public List<Recommedations__c> item {get;set;}

}