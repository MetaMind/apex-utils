#VisualForce Page example
```
public class VisionController {

    public List<Vision.Prediction> getCallVisionUrl() {
        return Vision.predictUrl('https://upload.wikimedia.org/wikipedia/commons/d/d2/Siberian_Husky_with_Blue_Eyes.jpg',<ACCESS_TOKEN>,'GeneralImageClassifier');
    }

    public List<Vision.Prediction> getCallVisionContent() {
        ContentVersion content = [SELECT Title,VersionData FROM ContentVersion where Id = '06841000000LkfCAAS' LIMIT 1];
        return Vision.predictBlob(content.VersionData, <ACCESS_TOKEN>, 'GeneralImageClassifier');
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
