trigger BatchExpireCouponTrigger on Batch_Expire_Coupon_Instance__c (after insert) {
    for(Batch_Expire_Coupon_Instance__c Batch_Expire_Coupon_Instance:Trigger.New) {
        BatchExpireCouponInstance expire = new BatchExpireCouponInstance();
		Id batchId = Database.executeBatch(expire);
		system.debug('batchId '+batchId);
    }
}