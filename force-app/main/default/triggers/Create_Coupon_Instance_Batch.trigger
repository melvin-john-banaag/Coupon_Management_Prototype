trigger Create_Coupon_Instance_Batch on Batch_Coupon_Instance__c (after insert) {
    System.debug('Inside Trigger');
    List<Coupon_Instance__c> insert_list = new List <Coupon_Instance__c>();
    
    for(Batch_Coupon_Instance__c Batch_Coupon_Instance:Trigger.New) {
        
        if(Batch_Coupon_Instance.Quantity__c > 0) {
            for(Integer i=0; i<Batch_Coupon_Instance.Quantity__c; i++) {
                Coupon_Instance__c cp_instance = new Coupon_Instance__c(
                    Coupon_Item__c = Batch_Coupon_Instance.Coupon_Item__c
                );
                System.debug('Passed create coupon single');
                insert_list.add(cp_instance);
            }
        }
    }
    try{
        insert insert_list;
    } catch(System.DmlException e) {
        System.debug(e);
    }
}