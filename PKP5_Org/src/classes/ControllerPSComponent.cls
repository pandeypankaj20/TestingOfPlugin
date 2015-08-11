public class ControllerPSComponent {

    /* List will contains the complete list of standard and custom objects*/
    public List<String> gblObjects {set;get;}
    public String selectedObject {set;get;} /* contains the selected object from the dropdown */
    
    public String[] selFieldOfSelObject  {set;get;}
    public List<SelectOption> fieldOfSelObject {set;get;}
    public List<ObjectFieldsDetails> fieldsOfSelObject {set;get;}
    
    
    Map<String,Schema.sObjectType> mapSObjects;
    Map<String, Schema.SObjectField> allFields;
    Map<String,String> labelAPINameMap; 
    
    public List<Sobject> lstSearchResult {set;get;}
    
    public ControllerPSComponent(){
      /* 
         Returns a map of all sObject names (keys) to sObject tokens (values) for the standard and
         custom objects defined in your organization. 
      */
      mapSObjects = Schema.getGlobalDescribe();
      gblObjects = new List<String>();
      //gblObjects = mapSObjects.keySet();
      for(Schema.sObjectType  so:mapSObjects.values()){
         Schema.DescribeSObjectResult ds = so.getDescribe(); //Returns the describe field result for this field.
         if(ds.getKeyPrefix() != NULL){
            gblObjects.add(ds.getLocalName());
            //sObjectMap.put(ds.getLocalName(),ds);
         }   
      }
      gblObjects.sort();
      initialization();
     }
    
    /* create a selectoption list of all objects*/ 
    public List<SelectOption> allSobjectList{
      get{
          if(allSobjectList == NULL){
           allSobjectList = new List<SelectOption>();
           for(String str:gblObjects)
             allSobjectList.add(new selectoption(str,str));
          }
          return allSobjectList;
      
      }set;
    }
    /* fetch all fields of selected object */
    public void findAllFields(){
         initialization();
         /* Get the instance of selected object */
         Schema.DescribeSObjectResult mapFields = mapSObjects.get(selectedObject).getDescribe();
         allFields = mapFields.fields.getMap();
         for(Schema.SObjectField fields:allFields.values()){
             /* created a select option of selected list */
             fieldsOfSelObject.add(new ObjectFieldsDetails(fields.getDescribe().getName(),fields.getDescribe().getLabel()));
         }
    }
    
    /* public class*/
    public class ObjectFieldsDetails{
      public Boolean isSelected {set;get;}
      public String fieldName  {set;get;}
      public String fieldLabel {set;get;}
      public ObjectFieldsDetails(string fieldName,String fieldLabel){
         this.isSelected = false;
         this.fieldName = fieldName;
         this.fieldLabel = fieldLabel;
      }
    }
    
    void initialization(){
        headerRow = new List<Row>();
        fieldOfSelObject = new List<SelectOption>();
        fieldsOfSelObject = new List<ObjectFieldsDetails>();
        selFieldOfSelObject = new String[]{};
        labelAPINameMap = new Map<String,String>();
        resultRows = new List<Row>();
        columnsWidth = 50;
    }
    
    public List<Row> headerRow {set;get;}
    public List<Row> resultRows {set;get;}
    public Integer columnsWidth {set;get;}
    
    public void createQuery(){
      if(fieldsOfSelObject.isEmpty()) return;
      
      Boolean isAnyFieldSelected = false;
      headerRow = new List<Row>();
      Row hRow = new Row();
      hRow.columns = new List<Col>(); 
      String sQuery = 'Select ' ; 
      String fields ='';
      
      for(Integer index =0; index < fieldsOfSelObject.size()-1;index++){
           if(fieldsOfSelObject[index].isSelected){ 
             isAnyFieldSelected = true;
             fields += fieldsOfSelObject[index].fieldName +',';
             hRow.columns.add(new Col(fieldsOfSelObject[index].fieldLabel));
           }
      }
      fields = fields.substring(0,fields.length() - 1);
      sQuery += fields;
    
      /* if there is no field selected then no need to do anything*/
      if(!isAnyFieldSelected) return;         
      sQuery += ' FROM ' + selectedObject;
      columnsWidth = 100 / hRow.columns.size();
      headerRow.add(hRow);
      
      System.debug('**************QUERY*************: ' + sQuery );
      System.debug('**************headerRow*************: ' + headerRow );
      
      lstSearchResult =  Database.query(sQuery);
      resultRows = new List<Row>();
      for(SObject obj:lstSearchResult){
         Row rsRow = new Row();
         rsRow.columns = new List<Col>(); 
         
         for(Integer index =0; index < fieldsOfSelObject.size()-1;index++){
           if(fieldsOfSelObject[index].isSelected ){ 
             rsRow.columns.add(new Col(obj.get(fieldsOfSelObject[index].fieldName)));
           }
         }
         resultRows.add(rsRow);
      }
    } 
    
    public class Row{
     public List<Col> columns {set;get;}
    }
    public class Col{
      public Object colValue {set;get;}
      public Col(Object value){
        this.colValue = String.valueOf(value); 
      }
    }
    
    
    
    
    public string sName {set;get;}
    public string meal {set;get;}
    public string color {set;get;}
    public integer age {set;get;}
    public void save(){}
    public Boolean showGreeting{
      get{
          if(showGreeting == NULL)
            showGreeting = false;
          return showGreeting;  
      }set;
    }
    
    /*
      so.getDescribe(); RESULT
    Schema.DescribeSObjectResult[getKeyPrefix=005;
        getLabel=User;getLabelPlural=Users;getLocalName=User;getName=User;
        getSObjectType=User;isAccessible=true;isCreateable=true;isCustom=false;
        isCustomSetting=false;isDeletable=false;isDeprecatedAndHidden=false;
        isFeedEnabled=false;isMergeable=false;isQueryable=true;
        isSearchable=true;isUndeletable=false;
        isUpdateable=true;]
    */
    
    /*
       fields.getDescribe() RESULT
       
        Schema.DescribeFieldResult[getByteLength=30;getCalculatedFormula=null;
        getController=null;getDefaultValue=null;getDefaultValueFormula=null;
        getDigits=0;getInlineHelpText=null;getLabel=SLA Serial Number;getLength=10;
        getLocalName=SLASerialNumber__c;getName=SLASerialNumber__c;
        getPrecision=0;getRelationshipName=null;getRelationshipOrder=null;
        getScale=0;getSoapType=STRING;getSobjectField=SLASerialNumber__c;getType=STRING;
        isAccessible=true;isAutoNumber=false;isCalculated=false;isCaseSensitive=false;isCreateable=true;
        isCustom=true;isDefaultedOnCreate=false;isDependentPicklist=false;isDeprecatedAndHidden=false;
        isExternalId=false;isFilterable=true;isGroupable=true;isHtmlFormatted=false;isIdLookup=false;
        isNameField=false;isNamePointing=false;isNillable=true;isSortable=true;isUnique=false;
        isUpdateable=true;isWriteRequiresMasterRead=false;
        ]
    */

}