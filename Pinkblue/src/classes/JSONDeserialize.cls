public class JSONDeserialize {
    public InvoiceWrapper wrapper {
        get;
        set;
    }

    public void deserialize() {
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('https://retail.recosenselabs.com/#/recommendation');
        request.setHeader('Content-type', 'application/json');
        request.setMethod('GET');

        HttpResponse response = h.send(request);

        wrapper = (InvoiceWrapper) JSON.deserializeStrict(response.getBody(), InvoiceWrapper.class);
    }
}