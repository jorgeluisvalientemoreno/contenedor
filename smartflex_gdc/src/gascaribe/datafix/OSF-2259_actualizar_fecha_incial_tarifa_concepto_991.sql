column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

BEGIN

  BEGIN
    Dbms_Output.put_line('Inicio actualizacion fecha inicio de la configuacion TARIFA POR CONCEPTO 991');
  
    update open.ta_conftaco tc
       set tc.cotcfein = to_date('01/01/2010', 'DD/MM/YYYY')
     where tc.cotcconc = 991;
    dbms_output.put_line('Fecha inicial 01/01/2021 actualizada por la fecha 01/01/2010 Ok.');
    Dbms_Output.put_line('Fin actualizacion fecha inicio de la configuacion TARIFA POR CONCEPTO 991');
    COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      rollback;
      Dbms_Output.put_line('Error al modificar fecha inicio de la configuacion TARIFA POR CONCEPTO 991 - Error: ' ||
                           sqlerrm);
  END;

  BEGIN
    Dbms_Output.put_line('Inicio actualizacion fecha inicio de VIGENCIA TARIFA del concepto 991');
  
    update open.ta_vigetaco tv
       set tv.vitcfein = to_date('01/01/2010', 'DD/MM/YYYY')
     where tv.vitctaco in (4130, 4131);
  
    dbms_output.put_line('Fecha inicial 01/01/2021 actualizada por la fecha 01/01/2010 Ok.');
    Dbms_Output.put_line('Fin actualizacion fecha inicio de VIGENCIA TARIFA del concepto 991');
  
    COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      rollback;
      Dbms_Output.put_line('Error al modificar fecha inicio de la configuacion TARIFA POR CONCEPTO 991 - Error: ' ||
                           sqlerrm);
  END;

  BEGIN
    Dbms_Output.put_line('Inicio actualizacion fecha inicio de VIGENCIAS DE TARIFA CONCEPTO POR PROYECTO del concepto 991');
  
    update open.TA_VIGETACP tvt
       set tvt.vitpfein = to_date('01/01/2010', 'DD/MM/YYYY')
     where tvt.vitpcons in (408288, 408289, 408290, 408291);
  
    dbms_output.put_line('Fecha inicial 01/01/2021 actualizada por la fecha 01/01/2010 Ok.');
    Dbms_Output.put_line('Fin actualizacion fecha inicio de VIGENCIAS DE TARIFA CONCEPTO POR PROYECTO del concepto 991');
  
    COMMIT;
  
  EXCEPTION
    WHEN OTHERS THEN
      rollback;
      Dbms_Output.put_line('Error al modificar fecha inicio de la configuacion VIGENCIAS DE TARIFA CONCEPTO POR PROYECTO del concepto 991 - Error: ' ||
                           sqlerrm);
  END;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/