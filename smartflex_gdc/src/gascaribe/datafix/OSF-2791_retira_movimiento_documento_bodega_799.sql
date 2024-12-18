SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;

begin
  execute immediate 'alter trigger TRG_VALIDABODEGA  disable';
  execute immediate 'alter trigger LDCTRGBUDI_OR_UIBM  disable';
  ------------------------------------------------------------------

  update open.ge_items_documento d
     set d.estado     = 'C',
         d.comentario = 'SE CAMBIA ESTADO INICIAL (A) AL NUEVO ESTADO (C) POR CASO OSF-2791'
   where d.id_items_documento in (1378953, 1339611)
     and d.estado = 'A';

  update or_uni_item_bala_mov m
     set m.support_document = '0'
   where m.id_items_documento in (1378953, 1339611)
     and m.movement_type = 'N'
     and m.id_items_seriado in (2506005, 2405295);

  ------------------------------------------------------------------   

  commit;

  dbms_output.put_line('Se actualiza estado de documento 1378953, 1339611 a estado C y documento soporte en 0');

  execute immediate 'alter trigger TRG_VALIDABODEGA  enable';
  execute immediate 'alter trigger LDCTRGBUDI_OR_UIBM  enable';
exception
  when others then
    rollback;
    execute immediate 'alter trigger TRG_VALIDABODEGA  enable';
    execute immediate 'alter trigger LDCTRGBUDI_OR_UIBM  enable';
    dbms_output.put_line(sqlerrm);
  
end;
/


SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin
  FROM dual;
/