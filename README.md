#Install JWT Apex classes
```
Install JWT.apex and JWTBearer.apex from https://github.com/salesforceidentity/jwt
Install Vision.apex and HttpFormBuilder.apex
```

#Visualforce Page example
```
public class VisionController {

    public String getAccessToken() {
        JWT jwt = new JWT('RS256');
        jwt.cert = 'Metamind';
        jwt.iss = 'developer.force.com';
        jwt.sub = 'kedar@metamind.io';
        jwt.aud = 'https://api.metamind.io/v1/oauth2/token';
        jwt.exp = '3600';
        String access_token = JWTBearerFlow.getAccessToken('https://api.metamind.io/v1/oauth2/token', jwt);
        return access_token;    
    }

    public List<Vision.Prediction> getCallVisionUrl() {
        // Get a new token
        JWT jwt = new JWT('RS256');
        jwt.cert = 'JWTCert';
        jwt.iss = 'developer.force.com';
        jwt.sub = 'yourname@example.com';
        jwt.aud = 'https://api.metamind.io/v1/oauth2/token';
        jwt.exp = '3600';
        String access_token = JWTBearerFlow.getAccessToken('https://api.metamind.io/v1/oauth2/token', jwt);                
    
        // Make a prediction using URL to a file
        return Vision.predictUrl('http://metamind.io/images/generalimage.jpg',access_token,'GeneralImageClassifier');
    }

    public List<Vision.Prediction> getCallVisionContent() {
        // Get a new token
        JWT jwt = new JWT('RS256');
        jwt.cert = 'JWTCert';
        jwt.iss = 'developer.force.com';
        jwt.sub = 'yourname@example.com';
        jwt.aud = 'https://api.metamind.io/v1/oauth2/token';
        jwt.exp = '3600';
        String access_token = JWTBearerFlow.getAccessToken('https://api.metamind.io/v1/oauth2/token', jwt);

        // Make a prediction for an image stored in Salesforce
        // by passing the file as blob which is then converted to base64 string
        ContentVersion content = [SELECT Title,VersionData FROM ContentVersion where Id = '06841000000LkfCAAS' LIMIT 1];
        return Vision.predictBlob(content.VersionData, access_token, 'GeneralImageClassifier');
    }
}
```

```
<apex:page Controller="VisionController">
  <apex:form >
  <apex:pageBlock >
      <apex:image url="http://metamind.io/images/generalimage.jpg">
      </apex:image>
      <br/>
    <apex:pageBlock >
      <apex:repeat value="{!AccessToken}" var="accessToken">
          Access Token:<apex:outputText value="{!accessToken}" /><br/>
    </apex:repeat>
    <br/>
  </apex:pageBlock>
      <apex:repeat value="{!callVisionUrl}" var="prediction">
          <apex:outputText value="{!prediction.label}" />:<apex:outputText value="{!prediction.probability}" /><br/>
      </apex:repeat>
  </apex:pageBlock>
<!--  <apex:pageBlock > -->
<!--      <apex:repeat value="{!callVisionContent}" var="prediction"> -->
<!--          <apex:outputText value="{!prediction.label}" />:<apex:outputText value="{!prediction.probability}" /><br/> -->
<!--    </apex:repeat> -->
<!--  </apex:pageBlock> -->
  </apex:form>
</apex:page>
```
