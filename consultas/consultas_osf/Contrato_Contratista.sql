select a.*, rowid
  from open.ge_contrato a
 where a.status = 'AB'
   AND A.FECHA_CIERRE IS NULL
      --AND A.FECHA_FINAL > SYSDATE
   AND a.id_contratista in
       (select oou.contractor_id
          from open.or_operating_unit oou
         where oou.operating_unit_id = 3623)
