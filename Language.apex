public class Language {

    public static String LANGUAGE_API = 'https://api.einstein.ai/v2/language';
    public static String SENTIMENT = LANGUAGE_API + '/sentiment';
    public static String INTENT = LANGUAGE_API + '/intent';
    
    public static List<Prediction> sentiment(String document, String access_token, String model) {
        return apiCall(SENTIMENT, document, access_token, model);
    }

    public static List<Prediction> intent(String document, String access_token, String model) {
        return apiCall(INTENT, document, access_token, model);
    }
    
    private static List<Prediction> apiCall(String endpoint, String document, String access_token, String model) {
        string contentType = HttpFormBuilder.GetContentType();

        //  Compose the form
        string form64 = '';
        form64 += HttpFormBuilder.WriteBoundary();
        form64 += HttpFormBuilder.WriteBodyParameter('modelId', EncodingUtil.urlEncode(model, 'UTF-8'));
        form64 += HttpFormBuilder.WriteBoundary();
        form64 += HttpFormBuilder.WriteBodyParameter('document', document);
        form64 += HttpFormBuilder.WriteBoundary(null);
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
        httpRequest.setHeader('Authorization','Bearer ' + access_token);
        httpRequest.setEndpoint(endpoint);

        Http http = new Http();
        List<Prediction> predictions = new List<Prediction>();
        try {
              HTTPResponse res = http.send(httpRequest);
              if (res.getStatusCode() == 200) {
                  System.JSONParser parser = System.JSON.createParser(res.getBody());
                  while (parser.nextToken() != null) {
                      if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'probabilities')) {
                          parser.nextToken();
                            if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                                while (parser.nextToken() != null) {
                                    // Advance to the start object marker to
                                    //  find next probability object.
                                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                                        // Read entire probability object
                                        Prediction probability = (Prediction)parser.readValueAs(Prediction.class);
                                        predictions.add(probability);
                                    }
                                }
                            }
                      break;
                      }
                  }
              }
              System.debug(predictions);
              //System.debug(res.toString());
              //System.debug('STATUS:'+res.getStatus());
              //System.debug('STATUS_CODE:'+res.getStatusCode());
         } catch(System.CalloutException e) {
                System.debug('ERROR:' + e);
         }
         return(predictions);
    }

    public class Prediction {
        public String label {get;set;}
        public Double probability {get;set;}
    }
}

