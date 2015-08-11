public class MerchandiseDetails {
    public Line_Item__c merch { get; set; }
    
    public MerchandiseDetails() {
        this.merch = getMerchandise();
    }
    public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Line_Item__c.FieldSets.Test_field_Set.getFields();
    }
    private Line_Item__c getMerchandise() {
            String query = 'SELECT ';
            for(Schema.FieldSetMember f : this.getFields()) {
                query += f.getFieldPath() + ', ';
            }
            query += 'ID FROM Line_Item__c LIMIT 1';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'FINAL QUERY WITH FIELD SET:' + query ));
            return Database.query(query);
    }
}