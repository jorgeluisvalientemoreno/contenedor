CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_GC_DEBT_NEGOT_PROD_BU
 BEFORE UPDATE ON GC_DEBT_NEGOT_PROD FOR EACH ROW

DECLARE
  NUVLRDESCUENTO NUMBER :=0;
  sbPrograOSF VARCHAR2(200) := pkErrors.fsbGetApplication;

  cursor cuTmp (nunuse servsusc.sesunuse%type) is
    select sum(n.valor)
    from   ldc_tempnego n
    where  producto = nunuse;

BEGIN
  if  fblaplicaentregaxcaso('0000620') then --Valida Entrega.
    --DBMS_LOCK.sleep(1);
    --LDC_BCCREG_B.pro_grabalog(3380,'TRG_GC_DEBT_NEGOT_PROD_BU',2020,10,SYSDATE,1,1,'sbPrograOSF ' || sbPrograOSF);

    if sbPrograOSF not in ('CUSTOMER') then
      return;
    end if;

    OPEN CUTMP (:NEW.SESUNUSE);
    FETCH CUTMP INTO NUVLRDESCUENTO;
    IF CUTMP%NOTFOUND THEN
      NUVLRDESCUENTO := 0;
    END IF;
    CLOSE CUTMP;

    IF NVL(NUVLRDESCUENTO,0) > 0 then
      :NEW.PENDING_BALANCE := :NEW.PENDING_BALANCE - NVL(NUVLRDESCUENTO,0);
    END IF;
  End If; --Finaliza Valida Entrega.
EXCEPTION
  WHEN  EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
END TRG_GC_DEBT_NEGOT_PROD_BU;
/
