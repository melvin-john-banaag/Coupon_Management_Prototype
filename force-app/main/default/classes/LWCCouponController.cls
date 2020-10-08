public inherited sharing class LWCCouponController {
    @AuraEnabled
    public static list<Coupon_Instance__c> readCSVFile(Id idContentDocument){
        list<Coupon_Instance__c> lstCouponInstanceToInsert = new list<Coupon_Instance__c>();
        if(idContentDocument != null) {
            
            // getting File Data based on document id 
            ContentVersion objVersion = [SELECT Id, VersionData FROM ContentVersion 
            WHERE ContentDocumentId =:idContentDocument];
            // split the file data
            list<String> lstCSVLines = objVersion.VersionData.toString().split('\n');

            for(Integer i = 1; i < lstCSVLines.size(); i++){
                Coupon_Instance__c objCpInstance = new Coupon_Instance__c();
                list<String> csvRowData = lstCSVLines[i].split(',');
                System.debug('csvRowData====> '+csvRowData);
                objCpInstance.Coupon_Item__c = csvRowData[0]; 
                objCpInstance.HK_Id__c = csvRowData[1];
                lstCouponInstanceToInsert.add(objCpInstance);
            }

            try{    
                if(!lstCouponInstanceToInsert.isEmpty()) {
                    insert lstCouponInstanceToInsert;
                }
            }
            catch (Exception ex) {
                throw new AuraHandledException(ex.getMessage());
            } 
        }
        return lstCouponInstanceToInsert;    
    }
}
