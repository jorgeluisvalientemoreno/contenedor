column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    CURSOR cuDatos
    IS
    SELECT  distinct cosssesu,cosspecs,cossdico
    FROM    conssesu  
    WHERE   cosssesu IN(1000984	,
    50069994	,
    50693184	,
    50094767	,
    50094760	,
    50094769	,
    50061804	,
    50081405	,
    50045049	,
    1704814	,
    2000057	)
    AND cosspecs IN (108268	,
    114868	,
    111310	,
    107457	,
    105290	,
    108434	
    ) and cossdico = 999;
BEGIN
  dbms_output.put_line('Inicia OSF-4211 !');
  
  FOR rcDatos in cuDatos LOOP
      dbms_output.put_line('Cambiando Producto = '||rcDatos.cosssesu );
      UPDATE conssesu
      SET   cossdico = 30
      WHERE cosssesu = rcDatos.cosssesu
      AND   cosspecs = rcDatos.cosspecs
      AND   cossdico = rcDatos.cossdico;
  END LOOP;

  dbms_output.put_line('Fin OSF-4211 !');
  commit;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/