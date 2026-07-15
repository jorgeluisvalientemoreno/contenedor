SELECT  rowid,RECORD_ROWID, to_char(previous_text), to_char(current_text),  au.current_date
 FROM OPEN.AU_AUDIT_POLICY_LOG au
   where AUDIT_LOG_ID IN (407)
     AND RECORD_ROWID in ('AADqQfAErAAI5bmAAX','AADqQfAEsAAI1IhAAk');
     
     
SELECT  rowid,RECORD_ROWID, to_char(previous_text), to_char(current_text),  au.current_date
 FROM OPEN.AU_AUDIT_POLICY_LOG au
   where AUDIT_LOG_ID IN (409)
     AND RECORD_ROWID in ('AADqOTAJYAADonKAAU');
     
     SELECT * FROM or_order  AS OF TIMESTAMP
   TO_TIMESTAMP('2023-02-23 06:30:00', 'YYYY-MM-DD HH24:MI:SS')
   WHERE order_id=263586217; 
   
   SELECT * FROM or_order_activity AS OF TIMESTAMP
   TO_TIMESTAMP('2023-02-23 06:30:00', 'YYYY-MM-DD HH24:MI:SS')
   WHERE order_id=263586217 ; 
   
   
