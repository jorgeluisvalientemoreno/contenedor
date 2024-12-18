CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_CC_TMP_BAL_BY_CONC_BI
 BEFORE INSERT ON CC_TMP_BAL_BY_CONC

DECLARE
  cursor cuFlag is
    select procesado
    from ldc_tempnego2;

  sblastobj varchar2(2000) :=  pkErrors.Fsblastobject;
  sbPrograOSF VARCHAR2(200) := pkErrors.fsbGetApplication;

BEGIN
  if  fblaplicaentregaxcaso('0000620') then -- Valida Aplica entrega.
    --DBMS_LOCK.sleep(1);
    --LDC_BCCREG_B.pro_grabalog(3380,'TRG BI',2020,10,SYSDATE,1,1,' sbPrograOSF ' || sbPrograOSF || ' sblastobj ' || sblastobj);

    if sbPrograOSF not in ('GCNED','FINAN') then
      return;
    end if;

    if sblastobj in ('pkTransDefToCurrDebtMgr.FindInterestToCreate','pkGeneralServices.ExecDynamicFunction') then
      --DBMS_LOCK.sleep(1);
      --LDC_BCCREG_B.pro_grabalog(3380,'TRG BI',2020,10,SYSDATE,1,1,'CAMBIO FLAG A NO EN BEFORE');
      ldc_pkExcDifeFina.prDeleteTmp;
      ldc_pkExcDifeFina.prCambiaFlag('N');
    elsif sblastobj in ('----------','FA_BOBillingNotes.DetailRegister') then
      ldc_pkExcDifeFina.prCambiaFlag('S');
      --DBMS_LOCK.sleep(1);
      --LDC_BCCREG_B.pro_grabalog(3380,'TRG BI',2020,10,SYSDATE,1,1,'CAMBIO FLAG A SI EN BEFORE');
    end if;
  End If; --Finaliza Aplica Entrega.
EXCEPTION
  WHEN  EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
END TRG_CC_TMP_BAL_BY_CONC_BI;
/
