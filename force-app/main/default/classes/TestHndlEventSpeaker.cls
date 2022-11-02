@isTest
private class TestHndlEventSpeaker{

        @testSetup
        static void prepareData(){
            
            Event_Organizer__c organizer = new Event_Organizer__c (	Name = 'Test Organizer',
                                                                    Email__c = 'testemail@test.com',
                                                                    Phone__c ='5757686786'
                                                                    );
            insert organizer;

            Event__c event = new Event__c(  Event_Organizer__c = organizer.Id,
                                            Name__c = 'Test Event CD',
                                            Start_Date_Time__c = Datetime.now().addDays(1),
                                            Max_Seats__c = 10, 
                                            Live__c = true
                                            );
            insert event;

            Speaker__c speaker = new Speaker__c(Name = 'Test Speaker',
                                                Email__c = 'testspeaker@test.com',
                                                Phone__c = '989787877'
                                                );
            insert speaker;

            Event_Speaker__c eventSpeaker = new Event_Speaker__c( Event__c = event.Id,
                                                                  Speaker__c =  speaker.Id
                                                                );
            insert eventSpeaker;
            
        }

        @isTest
        static void testPositive(){
            Event_Speaker__c systemRecord = [SELECT Event__c, Speaker__c FROM Event_Speaker__c LIMIT 1];

            Test.startTest();

            try {
                
                insert new Event_Speaker__c (Event__c = systemRecord.Event__c,
                                             Speaker__c = systemRecord.Speaker__c
                                            );

            } catch (Exception exc) {
                
            }
            
            test.stopTest();
            
            Integer systemCount = [SELECT COUNT() FROM Event_Speaker__c];
            System.assertEquals(1, systemCount);
            
        }

        @isTest        
        static void testNegative(){
            delete[SELECT Id FROM Event_Speaker__c];
            
            Event__c event = [SELECT Id FROM Event__c LIMIT 1];
            Speaker__c speaker = [SELECT Id FROM Speaker__c LIMIT 1];

            Test.startTest();
            insert new Event_Speaker__c(Event__c = event.Id,
                                        Speaker__c = speaker.Id            
                                        );
            Test.stopTest();
            Integer systemCount = [SELECT COUNT() FROM Event_Speaker__c];
            System.assertEquals(1, systemCount);            
        }
}