select *
  from OPEN.LDC_CANT_ASIG_OFER_CART t
 where t.unidad_operatva_cart = 3654
   and t.nuano = 2023
   and t.numes in ( /*1,2,3,4,5,6,7,8,*/ 9)
--   and t.nro_acta = -1
;
SELECT *
  FROM open.ldc_const_liqtarran bv
 WHERE bv.unidad_operativa = 3654
/*   --AND bv.zona_ofertados = -1
AND trunc(SYSDATE) BETWEEN trunc(bv.fecha_ini_vigen) AND
    trunc(bv.fecha_fin_vige);*/
;

begin
  update OPEN.LDC_CANT_ASIG_OFER_CART t
  --select * from OPEN.LDC_CANT_ASIG_OFER_CART t    
     set t.zona_ofertados = -1
   where t.unidad_operatva_cart = 3654
     and t.nuano = 2023
     and t.numes = 9
     and t.nro_acta = 207710;
  commit;
  dbms_output.put_line('Actualizacion de zona de ofertadoss en -1 al registro de Ordenes del acta 207710');
exception
  when others then
    rollback;
    dbms_output.put_line('No se actualizacion de zona de ofertadoss en -1 al registro de Ordenes del acta 207710 - ' ||
                         sqlerror);
end;
