select DOCU.*, 
         REQU.*
    from open.GE_ITEMS_DOCUMENTO DOCU, open.GE_ITEMS_REQUEST REQU
   where DOCU.ID_ITEMS_DOCUMENTO = REQU.ID_ITEMS_DOCUMENTO
     and DOCU.ID_ITEMS_DOCUMENTO=105052 
SELECT * --DECODE(mmitnatu,'+',1,'-',-1, 0)*DMITCOUN*DMITVAUN
FROM OPEN.LDCI_INTEMMIT, OPEN.LDCI_DMITMMIT
WHERE MMITNUDO IS NOT NULL
  AND MMITESTA=1
  AND MMITCODI=DMITMMIT
  AND MMITNUDO NOT IN ('VD67351');
  
select *
from open.or_order_items oi, open.ge_items i
where i.items_id=i.items_id
  and to_char(i.items_id)!=i.code
  and oi.legal_item_amount>1
