DECLARE

  nuError   NUMBER;
  sbError   VARCHAR2(4000);
  nuActa    NUMBER := 255391;
  sbComm    VARCHAR2(200) := 'CASO OSF-5191';
  sbfactura ge_acta.extern_invoice_num%type;

  -- Cursor para validar si el acta fue cancelada
  Cursor Cu_Actas(nuacta_id ge_acta.id_acta%type) is
    select a.extern_invoice_num -- nro de factura
      from open.ge_Acta a
     where a.id_acta = nuacta_id;

BEGIN

  --Inicio Apertura de ACTA
  sbfactura := NULL;
  --
  open cu_Actas(nuActa);
  fetch cu_Actas
    into sbfactura;
  close cu_Actas;

  execute immediate 'alter trigger TRG_GE_CONTRATO_AU_SAO604282 disable';

  If sbfactura is NULL then



    ldc_prAbrirActaCerrada(nuActa, sbComm, nuError, sbError, 'S');

    IF nuError = 0 THEN

      COMMIT;
      DBMS_OUTPUT.PUT_LINE('Acta ' || nuActa || ' abrieta Ok.');

    ELSE
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('ERROR ACTA ' || nuActa ||
                           ' AL INTENTAR ABRIR Error: ' || sbError);
    END IF;

  Else
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('ERROR ACTA ' || nuActa ||
                         ' Con Nro de factura, ' || sbfactura ||
                         ', no se puede abrir, valide con contabilidad.');
  End If; --Fin Apertura de ACTA

  execute immediate 'alter trigger TRG_GE_CONTRATO_AU_SAO604282  enable';

exception
    when others then
      rollback;
      execute immediate 'alter trigger TRG_GE_CONTRATO_AU_SAO604282 enable';

END;
/
