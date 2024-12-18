set serveroutput on;
column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
BEGIN
    dbms_output.put_line('Actualizar registro en master_personalizaciones');
    UPDATE  master_personalizaciones 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
    'LDC_TELEFONOS_SUBSC',	
    'LDC_VALIDASOLIVENTAFNBMERE',	
    'LDC_VALIDATITRSECERT',	
    'MIC_FUN_SERV_GETPHONESCLIENT',	
    'PRFECHAANTERIORPERI',	
    'SPLIT_CLOB',	
    'FBLEXISSOLXDIRTIPOXESTADO',	
    'FNUGETCONSPROMFACT',	
    'FNUGETORACLEEDITION',	
    'FSBGETFNBINFO',	
    'LDC_FNCRECUPERADEUDASVAL',	
    'LDC_FNCRETORNALOCACLIENTE',	
    'LDC_FNCRETORNALOCACONTRATO',	
    'LDC_FNCRETORNAPROCEJECIERR2',	
    'LDC_FNUGETCANTACTXPROD');

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro en master_personalizaciones, '||sqlerrm);
END;
/
SELECT TO_CHAR(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin
  FROM dual; 
/