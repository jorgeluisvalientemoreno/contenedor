select ott.*, rowid
  from open.or_task_type ott
 where ott.task_type_id = 11358;
 --upper(ott.description) like '%SUSPEN%PNO%';
 select oou.* from open.or_operating_unit oou where oou.operating_unit_id =4209; 
select gc.*,rowid from open. ge_contrato gc where gc.id_contratista=( select oou.contractor_id from open.or_operating_unit oou where oou.operating_unit_id =4209) and gc.status = 'AB'
