declare

  i number;
begin

  ------------------------------------------------------------------
  update open.ge_items_documento d
     set d.estado     = 'C',
         d.comentario = 'SE CAMBIA ESTADO DE A C POR CASO OSF-2713'
   where d.id_items_documento in (1378953, 1339611)
     and d.estado = 'A';
  update or_uni_item_bala_mov m
     set m.support_document = ' '
   where m.id_items_documento in (1378953, 1339611)
     and m.movement_type = 'N'
     and m.id_items_seriado in (2506005, 2405295);
  ------------------------------------------------------------------

  commit;
exception
  when others then
    rollback;
    execute immediate 'alter trigger TRG_VALIDABODEGA  enable';
    execute immediate 'alter trigger LDCTRGBUDI_OR_UIBM  enable';
    dbms_output.put_line(sqlerrm);
  
end;
/
