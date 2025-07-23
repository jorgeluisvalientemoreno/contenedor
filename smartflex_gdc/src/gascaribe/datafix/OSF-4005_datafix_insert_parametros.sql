SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-4005"
prompt "-----------------"

BEGIN
    dbms_output.put_line('Inserta registro en parametros');
    
    MERGE INTO OPEN.PARAMETROS A USING
    (SELECT
    '|MED_REC_ENVIO_RESPUESTA_ELECTRONICA|' as CODIGO,
    'Medios de Recepción con envió de Respuesta electrónica' as DESCRIPCION,
    NULL as VALOR_NUMERICO,
    '|23||24||25||26||28||29||30||31|' as VALOR_CADENA,
    NULL as VALOR_FECHA,
    20 as PROCESO, 
    'A' as ESTADO,
    'N' as OBLIGATORIO,
    SYSDATE as FECHA_CREACION,
    SYSDATE as FECHA_ACTUALIZACION,
    'OPEN' as USUARIO,
    'NO TERMINAL' as TERMINAL
    FROM DUAL) B
    ON (A.CODIGO = B.CODIGO)
    WHEN NOT MATCHED THEN 
    INSERT (
    CODIGO, DESCRIPCION, VALOR_NUMERICO, VALOR_CADENA, VALOR_FECHA, 
    PROCESO, ESTADO, OBLIGATORIO, FECHA_CREACION, FECHA_ACTUALIZACION, 
    USUARIO, TERMINAL)
    VALUES (
    B.CODIGO, B.DESCRIPCION, B.VALOR_NUMERICO, B.VALOR_CADENA, B.VALOR_FECHA, 
    B.PROCESO, B.ESTADO, B.OBLIGATORIO, B.FECHA_CREACION, B.FECHA_ACTUALIZACION, 
    B.USUARIO, B.TERMINAL)
    WHEN MATCHED THEN
    UPDATE SET 
    A.DESCRIPCION = B.DESCRIPCION,
    A.VALOR_NUMERICO = B.VALOR_NUMERICO,
    A.VALOR_CADENA = B.VALOR_CADENA,
    A.VALOR_FECHA = B.VALOR_FECHA,
    A.PROCESO = B.PROCESO,
    A.ESTADO = B.ESTADO,
    A.OBLIGATORIO = B.OBLIGATORIO,
    A.FECHA_CREACION = B.FECHA_CREACION,
    A.FECHA_ACTUALIZACION = B.FECHA_ACTUALIZACION,
    A.USUARIO = B.USUARIO,
    A.TERMINAL = B.TERMINAL;
    
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo insertar registro en parametros, '||sqlerrm);
END;
/
prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4005-----"
prompt "-----------------------"
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
prompt Fin Proceso!!
set serveroutput off
quit
/