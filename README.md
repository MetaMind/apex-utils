#Install JWT Apex classes
```
https://github.com/salesforceidentity/jwt
```

#VisualForce Page example
```
public class VisionController {

    public List<Vision.Prediction> getCallVisionUrl() {    
        JWT jwt = new JWT('RS256');
        jwt.cert = 'JWTCert';
        jwt.iss = 'developer.force.com';
        jwt.sub = 'john@doe.com';
        jwt.aud = 'https://api.metamind.io/v1/oauth2/token';
        jwt.exp = '3600';
        String access_token = JWTBearerFlow.getAccessToken('https://api.metamind.io/v1/oauth2/token', jwt);                
    
        return Vision.predictUrl('https://upload.wikimedia.org/wikipedia/commons/d/d2/Siberian_Husky_with_Blue_Eyes.jpg',access_token,'GeneralImageClassifier');
    }

    public List<Vision.Prediction> getCallVisionContent() {
        JWT jwt = new JWT('RS256');
        jwt.cert = 'JWTCert';
        jwt.iss = 'developer.force.com';
        jwt.sub = 'john@doe.com';
        jwt.aud = 'https://api.metamind.io/v1/oauth2/token';
        jwt.exp = '3600';
        String access_token = JWTBearerFlow.getAccessToken('https://api.metamind.io/v1/oauth2/token', jwt);

        ContentVersion content = [SELECT Title,VersionData FROM ContentVersion where Id = '06841000000LkfCAAS' LIMIT 1];
        return Vision.predictBlob(content.VersionData, access_token, 'GeneralImageClassifier');
    }
}
```

```
<apex:page Controller="VisionController">
  <apex:form >
  <apex:pageBlock >
      <apex:repeat value="{!callVisionUrl}" var="prediction">
          <apex:outputText value="{!prediction.label}" />:<apex:outputText value="{!prediction.probability}" /><br/>
    </apex:repeat>
  </apex:pageBlock>
  <apex:pageBlock >
      <apex:repeat value="{!callVisionContent}" var="prediction">
          <apex:outputText value="{!prediction.label}" />:<apex:outputText value="{!prediction.probability}" /><br/>
    </apex:repeat>
  </apex:pageBlock>
  </apex:form>
</apex:page>
```
