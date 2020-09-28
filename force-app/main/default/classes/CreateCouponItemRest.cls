@RestResource(urlMapping='/createcpinstance/*')
global with sharing class CreateCouponItemRest {
    @HttpPost
    global static Coupon_Instance__c create(
        String offer_code,
        String customer_id
    ) {
        Coupon_Item__c cpitem = [
            Select Name, 
            Id
            From Coupon_Item__c
            Where (Offer_Code__c=:offer_code)
        ];
        
        Coupon_Instance__c newcpInstance = new Coupon_Instance__c(
            Coupon_Item__c = cpitem.Id,
            Customer_ID__c = customer_id
        );
        
        insert newcpInstance;
        
        Coupon_Instance__c result = [
            Select Name 
            from Coupon_Instance__c Where Id=:newcpInstance.Id
        ];
        
        return result;
    }
}