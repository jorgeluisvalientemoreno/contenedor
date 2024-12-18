CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGCHANGEADDRESS
BEFORE INSERT
ON or_related_order
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
DECLARE

     CURSOR cuAddressOrder( nuOrder_id or_order.order_id%type)
     IS
            select external_address_id
            from OPEN.or_order a
            where order_id = nuOrder_id;

     Cursor cuAddressOrActivity(nuOrder_id or_order.order_id%type)
     is
            select address_id
            from OPEN.or_order_activity a
            where order_id = nuOrder_id;

     nuDirOrder     or_order.external_address_id%type;
     nuDirOrderAct  or_order_activity.address_id%type;
BEGIN

    IF :new.rela_order_type_id = 15 THEN

        OPEN cuAddressOrder(:new.order_id);
        FETCH cuAddressOrder INTO nuDirOrder;
        CLOSE cuAddressOrder;

        OPEN cuAddressOrActivity(:new.order_id);
        FETCH cuAddressOrActivity INTO nuDirOrderAct;
        CLOSE cuAddressOrActivity;

        IF nuDirOrder IS NOT NULL THEN
            UPDATE or_order
            SET    external_address_id = nuDirOrder
            WHERE  order_id = :new.related_order_id;
        END IF;

        IF nuDirOrderAct IS NOT NULL THEN
            UPDATE or_order_activity
            SET    address_id = nuDirOrderAct
            WHERE  order_id = :new.related_order_id;
        END IF;
    END IF;
EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END LDC_TRGCHANGEADDRESS;
/
