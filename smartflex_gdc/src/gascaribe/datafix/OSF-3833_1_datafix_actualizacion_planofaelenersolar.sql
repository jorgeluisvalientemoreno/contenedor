column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  onuError     NUMBER;
  osbError    VARCHAR2(4000);
  
  CURSOR cuGetFacturas IS
  SELECT factura.factcodi, factura.factsusc, factura.factnufi
  FROM OPEN.factura
  WHERE factura.factcodi IN ( 2144199252,
                        2144199250,
                        2144199229,
                        2144199246,
                        2144199239,
                        2144199235,
                        2144199232,
                        2144199245,
                        2144199221,
                        2144199254,
                        2144199253,
                        2144199223);

BEGIN
  
  FOR reg IN cuGetFacturas LOOP
    onuError := 0;
    pkg_bofactelectronica.prGeneraXMl( reg.factcodi,
                                       reg.factsusc,
                                       SYSDATE,
                                       'A',
                                       onuError,
                                       osbError);
    IF onuError = 0 THEN
       UPDATE factura SET factfege = SYSDATE WHERE factcodi = reg.factcodi;
       UPDATE factura_electronica SET FECHA_ENVIO = NULL,
                                      FECHA_RESPUESTA = NULL, 
                                      XML_RESPUESTA =NULL,
                                      MENSAJE_RESPUESTA = NULL
        WHERE FACTURA = reg.factcodi;
       COMMIT;
    ELSE
      dbms_output.put_line('Error en factura '|| reg.factcodi||' '||osbError);
      ROLLBACK;
    END IF;
  END LOOP;
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/