public class Vision {

    public String VISION_API='https://api.metamind.io';
    public STRING PREDICT=VISION_API + '/predict';

    public static String predictUrl(String url, String access_token, String model) {
        return predictInternal(url, access_token, model);
    }

    private static String predictInternal(String url, String access_token, String model) {
        string contentType = HttpFormBuilder.GetContentType();
        //  Compose the form
        string form64 = '';

        form64 += HttpFormBuilder.WriteBoundary();
        form64 += HttpFormBuilder.WriteBodyParameter('sampleType', EncodingUtil.urlEncode('image', 'UTF-8'));
        form64 += HttpFormBuilder.WriteBoundary();
        form64 += HttpFormBuilder.WriteBodyParameter('sampleTypeVersion', EncodingUtil.urlEncode('1', 'UTF-8'));
        form64 += HttpFormBuilder.WriteBoundary();
        form64 += HttpFormBuilder.WriteBodyParameter('modelId', EncodingUtil.urlEncode(model, 'UTF-8'));
        form64 += HttpFormBuilder.WriteBoundary();
        form64 += HttpFormBuilder.WriteBodyParameter('sampleLocation', url);
        form64 += HttpFormBuilder.WriteBoundary(HttpFormBuilder.EndingType.CrLf); 
 
        blob formBlob = EncodingUtil.base64Decode(form64);
        string contentLength = string.valueOf(formBlob.size());
        //  Compose the http request
        HttpRequest httpRequest = new HttpRequest();

        httpRequest.setBodyAsBlob(formBlob);
        httpRequest.setHeader('Connection', 'keep-alive');
        httpRequest.setHeader('Content-Length', contentLength);
        httpRequest.setHeader('Content-Type', contentType);
        httpRequest.setMethod('POST');
        httpRequest.setTimeout(120000);
        httpRequest.setHeader('Authorization','APIKEY apikey=' + access_token);
        httpRequest.setEndpoint('https://api.metamind.io/predict');
        
        Http http = new Http();

        try {
              HTTPResponse res = http.send(httpRequest);   
              //System.debug(res.toString());
              //System.debug('STATUS:'+res.getStatus());
              //System.debug('STATUS_CODE:'+res.getStatusCode());
              return(res.getBody());
         } catch(System.CalloutException e) {
                return e.getStackTraceString();
         }  
    }
}