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
      sbComm     VARCHAR2(200) :='CASO OSF-2243';
      sbfactura  ge_acta.extern_invoice_num%type;

  -- Cursor para validar si el acta fue cancelada
  Cursor Cu_Actas(nuacta_id ge_acta.id_acta%type) is
    select a.extern_invoice_num -- nro de factura
      from open.ge_Acta a
     where a.id_acta = nuacta_id;

  BEGIN
      --
      sbfactura := NULL;
      --
      open cu_Actas(nuActa);
      fetch cu_Actas into sbfactura;
      close cu_Actas;

      If sbfactura is NULL then

        ldc_prAbrirActaCerrada(nuActa, 
                               sbComm, 
                               nuError,
                               sbError);

        IF nuError = 0 THEN
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('ACTA '||nuActa||' REVERSADA OK ');
        ELSE
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR ACTA '||nuActa||' '||sbError);
        END IF;
        
      Else
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR ACTA '||nuActa|| ' Con Nro de factura, ' || sbfactura || ', no se puede abrir, valide con contabilidad.');
      End If;
          
  END;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/