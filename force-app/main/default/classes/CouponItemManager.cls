@RestResource(urlMapping='/cpinstance/*')
global with sharing class CouponItemManager {
    @HttpPost
    //@RestResource(urlMapping='/enquiry')
    global static Coupon_Instance__c enquiry(String cp_instance_id) {
        Coupon_Instance__c thiscpInstance = [
            SELECT Name,
            Coupon_Item__c,
            Coupon_Item_Name__c,
            Customer_ID__c,
            Expiry_Date__c,
            RecordTypeId,
            Status__c,
            Valid_From__c,
            Valid_To__c
            FROM Coupon_Instance__c
            WHERE (Name=:cp_instance_id)
        ];
        
        return thiscpInstance;
    }
    
    @HttpPatch
    //@RestResource(urlMapping='/transact')
    global static Coupon_Instance__c transact(String cp_instance_id) {
        Coupon_Instance__c thiscpInstance = [
            SELECT Name,
            Status__c
            FROM Coupon_Instance__c
            WHERE (Name=:cp_instance_id)
        ];
        
        thiscpInstance.Status__c = 'REDEEMED';
        
        update thiscpInstance; 
        
        return thiscpInstance;
    }
}