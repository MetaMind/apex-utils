#Predicting with an URL
```
Vision.predictUrl('https://upload.wikimedia.org/wikipedia/commons/d/d2/Siberian_Husky_with_Blue_Eyes.jpg',<ACCESS_TOKEN>,'GeneralImageClassifier');
```
#VisualForce Page example
```
public class VisionController {
    public List<Vision.Prediction> getCallVision() {
        return Vision.predictUrl('https://upload.wikimedia.org/wikipedia/commons/d/d2/Siberian_Husky_with_Blue_Eyes.jpg','9o7ifanb0tgiltbb4g3pdg5vm4hchstsokh1n5l7dmtlp3j56evn7hgg0mkac3ih','GeneralImageClassifier');
    }
}
```

```
<apex:page Controller="VisionController">
  <h1>Congratulations</h1>
  This is your new Page
  <apex:form >
  <apex:pageBlock >
      <apex:repeat value="{!callVision}" var="prediction">
          <apex:outputText value="{!prediction.label}" />:<apex:outputText value="{!prediction.probability}" /><br/>
    </apex:repeat>
  </apex:pageBlock>
  </apex:form>
</apex:page>
```