global class BatchExpireCouponInstance implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query='SELECT Name, Valid_To__c from Coupon_Instance__c';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Coupon_Instance__c> cpInstanceLIst) {
        for(Coupon_Instance__c Coupon_Instance:cpInstanceLIst) {
            if(Coupon_Instance.Valid_To__c < Date.today()) {
                Coupon_Instance.Status__c = 'EXPIRED';
            }
        }
        try{
            update cpInstanceLIst;
        } catch(Exception e) {
            System.debug(e);
        }
        
    }
    global void finish(Database.BatchableContext BC) {

    }
}