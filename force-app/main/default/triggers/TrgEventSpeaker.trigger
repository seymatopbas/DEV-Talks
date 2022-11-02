trigger TrgEventSpeaker on Event_Speaker__c (before insert, before update) {

    if(Trigger.isBefore){
        if(trigger.isBefore || Trigger.isUpdate){
            HndlEventSpeaker.validateEventSpeaker(Trigger.new);
        }

    }

}