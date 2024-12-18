column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  DECLARE

      nuError    NUMBER;
      sbError    VARCHAR2(4000);
      nuActa     NUMBER := 214931;
      sbComm     VARCHAR2(200) :='CASO OSF-2685';
      sbfactura  ge_acta.extern_invoice_num%type;

  -- Cursor para validar si el acta fue cancelada
  Cursor cu_Actas
  IS
  SELECT *-- nro de factura
  FROM ge_Acta a
  WHERE a.id_acta in (222870,222871);

  BEGIN

      FOR rcActa IN cu_Actas LOOP

        dbms_output.put_line('Procesando Acta: '||rcActa.id_acta);

        IF rcActa.extern_invoice_num is NULL then

          ldc_prAbrirActaCerrada(rcActa.id_acta, 
                                sbComm, 
                                nuError,
                                sbError);

          IF nuError = 0 THEN
              COMMIT;
              DBMS_OUTPUT.PUT_LINE('ACTA '||rcActa.id_acta||' REVERSADA OK ');
          ELSE
              ROLLBACK;
              DBMS_OUTPUT.PUT_LINE('ERROR ACTA '||rcActa.id_acta||' '||sbError);
          END IF;
          
        Else
              ROLLBACK;
              DBMS_OUTPUT.PUT_LINE('ERROR ACTA '||rcActa.id_acta|| ' Con Nro de factura, ' || rcActa.extern_invoice_num || ', no se puede abrir, valide con contabilidad.');
        End If;
      END LOOP;

          
  END;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/