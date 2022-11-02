public with sharing class ErrorLogHelper {
     
    public static void createErrorLog(String processName, String logDetails){

        insert new Error_Log__c( Log_Date_Time__c = Datetime.now(),
                                 Process_Name__c = processName,
                                 Log_Details__c = logDetails
                                ); 

    }
}

/*

try{
    insert new Account(); 
    
}catch(Exception exc){
    System.debug('EXC:' + exc.getMessage());
    insert new Error_Log__c( Log_Date_Time__c = Datetime.now(),
                             Process_Name__c = 'Account.Create',
                             Log_Details__c = exc.getMessage() + ' (line: ' + exc.getLineNumber() + ')'
    						);
}

*/


