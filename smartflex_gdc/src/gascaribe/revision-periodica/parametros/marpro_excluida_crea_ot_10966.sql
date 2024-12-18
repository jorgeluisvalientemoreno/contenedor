DECLARE

  nuTab1 number := 0;

BEGIN
  select count(1)
    into nuTab1
    from ld_parameter
   where parameter_ID = 'MARPRO_EXCLUIDA_CREA_OT_10966';

  IF (nuTab1 = 0) THEN
  
    begin
      INSERT INTO LD_PARAMETER
      VALUES
        ('MARPRO_EXCLUIDA_CREA_OT_10966',
         NULL,
         '101,102,103,104',
         'MARCA DE PRODUCTOS EXCLUIDOS PARA GENERAR DE ORDEN SUSPENSION CM RP SERVICIO YA SUSPENDIDO PARA EL PLUGIN LDC_PROCREASOLISUSPADMI');
      dbms_output.put_line('Insert del Parametro MARPRO_EXCLUIDA_CREA_OT_10966');
      commit;
    exception
      when others then
        rollback;
        dbms_output.put_line('Error al registrar el Parametro MARPRO_EXCLUIDA_CREA_OT_10966 - ' ||
                             sqlerrm);
    end;
  ELSE
    dbms_output.put_line('Existe el Parametro MARPRO_EXCLUIDA_CREA_OT_10966');
  END IF;
  -----------------------------------------------------------------------------------------------------

END;
/
