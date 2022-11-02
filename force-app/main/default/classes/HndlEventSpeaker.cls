public with sharing class HndlEventSpeaker {

    public static void validateEventSpeaker(List<Event_Speaker__c> eventSpeakers){
        Set<Id> speakerIds = new Set<Id>();
        Set<Id> eventIds = new Set<Id>();
        Map<String, Event_Speaker__c> eventSpeakerMap = new Map<String, Event_Speaker__c>();
        
        for (Event_Speaker__c es : eventSpeakers){
            speakerIds.add(es.Speaker__c);
            eventIds.add(es.Event__c);

            String myKey = String.valueOf(es.Speaker__c) + String.valueOf(es.Event__c);
            eventSpeakerMap.put(myKey, es);

        }

        System.debug('speakerIds:' + speakerIds);
        System.debug('eventIds:' + eventIds);

        for(Event_Speaker__c es: [SELECT Id, Speaker__c, Event__c
                                  FROM Event_Speaker__c
                                  WHERE Speaker__c IN: speakerIds
                                  AND Event__c IN: eventIds
                                  ])
        {
            String systemKey = String.valueOf(es.Speaker__c) + String.valueOf(es.Event__c);
            Event_Speaker__c toBeFailed = eventSpeakerMap.get (systemKey);

            if(toBeFailed !=null) {
                toBeFailed.addError('This is a dublicate record.  ' + String.valueOf(es.Id));
            }

        }

    }   

}
