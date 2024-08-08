select 
a.*, rowid
/*
a.items_id,
       a.operating_unit_id,
       a.balance,
       a.total_costs,
       (SELECT COUNT(1)
          FROM OPEN.GE_ITEMS_SERIADO i
         WHERE i.ITEMS_ID = a.items_id
           AND i.OPERATING_UNIT_ID = a.operating_unit_id
           AND i.ID_ITEMS_ESTADO_INV in (1, 12, 16)) total_real*/
  from OPEN.OR_OPE_UNI_ITEM_BALA a
--SET BALANCE = ((SELECT COUNT(1) FROM OPEN.GE_ITEMS_SERIADO i WHERE i.ITEMS_ID = 10004070 AND i.OPERATING_UNIT_ID = 3557 AND i.ID_ITEMS_ESTADO_INV = 1 ))
 WHERE 
 --ITEMS_ID = 10004070
   --AND 
   a.OPERATING_UNIT_ID = 3615;
