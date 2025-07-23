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
  FROM OPEN.factura, OPEN.servsusc
  WHERE factsusc = sesususc
     AND factprog = 6
     AND sesuserv = 7057
     AND TRUNC(factfege) =TO_DATE('07/01/2025')
     AND  EXISTS ( SELECT *
                   FROM OPEN.factura_electronica
                   WHERE factura = factcodi
                     AND estado = 4);
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