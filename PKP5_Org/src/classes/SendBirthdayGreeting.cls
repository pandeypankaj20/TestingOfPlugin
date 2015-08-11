global class SendBirthdayGreeting implements System.Schedulable {
   global void execute(SchedulableContext SC) {
      List<Event__c> events = [select Id from Event__c where Event_Type__c='Birthday' and Event_Next_date__c=: Date.today()];
      
      for(Event__c ev : events)
          ev.send_email__c = true;
      
      update events;
   }
}