trigger HandleProductPriceChange on Merchandise__c (after update) {
        
        List<Line_Item__c> openLineItems =[SELECT Unit_Price__c, Merchandise__r.Price__c
                                        FROM Line_Item__c 
                                        WHERE Invoice_Statement__r.Status__c = 'Negotiating'
                                        AND Merchandise__r.id IN :Trigger.new];
                                        
                                              
       for (Line_Item__c li: openLineItems) {
         if ( li.Merchandise__r.Price__c < li.Unit_Price__c ){
            li.Unit_Price__c = li.Merchandise__r.Price__c;
         }
       }
       
       update openLineItems;
                                        
}