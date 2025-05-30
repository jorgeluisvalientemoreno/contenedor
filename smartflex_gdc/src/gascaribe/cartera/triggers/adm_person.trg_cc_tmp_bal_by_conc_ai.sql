CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_CC_TMP_BAL_BY_CONC_AI
 AFTER INSERT  ON CC_TMP_BAL_BY_CONC
DECLARE
  nutmp_bal_by_concept_id CC_TMP_BAL_BY_CONC.tmp_bal_by_concept_id%type;
  nuconcept_id            CC_TMP_BAL_BY_CONC.Concept_Id%type;
  nupending_balance       CC_TMP_BAL_BY_CONC.pending_balance%type;
  nufinancing_balance     CC_TMP_BAL_BY_CONC.financing_balance%type;
  nuorig_pending_balance  CC_TMP_BAL_BY_CONC.orig_pending_balance%type;
  NUSALDO NUMBER;
  sbPlansCOVID  ld_parameter.value_chain%type  := dald_parameter.fsbGetValue_Chain('PLANES_DIFERIDOS_COVID',0);
  sbPrograOSF VARCHAR2(200) := pkErrors.fsbGetApplication;

  cursor cuDiferidos (nusesu diferido.difenuse%type) is
    select difecodi
    from diferido D
    where difenuse=nusesu
    and difesape>0;

  -- tabla de diferidos
  TYPE rcDife IS RECORD(
     is_selected       varchar2(1));

  TYPE tbDife IS TABLE OF rcDife INDEX BY binary_integer;
  tDife tbDife;
  nuIndDife binary_integer;


  cursor cuTmp is
    select *
    from ldc_tempnego n;


  cursor cuTmp2 is
  SELECT producto,
       concepto,
       sum(valor) valor
  FROM ldc_tempnego
  GROUP BY producto, concepto;

  cursor cuNego1 (nuprod ldc_tempnego.producto%type, nuconc ldc_tempnego.concepto%type, nuvalor CC_TMP_BAL_BY_CONC.Pending_Balance%type)  is
    select c.tmp_bal_by_concept_id, C.CONCEPT_ID, c.pending_balance, c.financing_balance, c.orig_pending_balance
    from CC_TMP_BAL_BY_CONC c
    where c.product_id = nuprod
    and c.account_number = -1
    and c.pending_balance = nuvalor
    and c.concept_id = nuconc;

  cursor cuNego2 (nuprod ldc_tempnego.producto%type, nuconc ldc_tempnego.concepto%type)  is
    select c.tmp_bal_by_concept_id, C.CONCEPT_ID, c.pending_balance, c.financing_balance, c.orig_pending_balance
    from CC_TMP_BAL_BY_CONC c
    where c.product_id = nuprod
    and c.account_number = -1
   -- and c.pending_balance = nuvalor
    and c.concept_id = nuconc;

   regNego2 cuNego2%rowtype;

  cursor cuFlag is
    select procesado
    from ldc_tempnego2;

  NUPRODUCTO     NUMBER;
  IOTBDEFERRED   MO_TYTBDEFERRED;
  i              number := 0;
  j              number := 0;
  OSBDIFERIDOS   varchar2(4000) := null;
  NUINDEXDEF     NUMBER;
  NUDIFESELEC    NUMBER;
  NUI            NUMBER;
  sbflag VARCHAR2(1);
  sbflag2 VARCHAR2(1);

  NUINDEXDEF2     NUMBER;
  NUDIFESELEC2    NUMBER;
  IOTBDEFERRED2   MO_TYTBDEFERRED;

  sblastobj varchar2(2000) :=  pkErrors.Fsblastobject;

BEGIN
  if  fblaplicaentregaxcaso('0000620') then
    --DBMS_LOCK.sleep(1);
   -- LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'ENTRO AL AFTER INSERT');

    --DBMS_LOCK.sleep(1);
   --LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,' sbPrograOSF ' || sbPrograOSF || ' sblastobj ' || sblastobj||' programa seteado '||ldc_pkExcDifeFina.fsbGetPrograma);

    if sbPrograOSF not in ('GCNED','FINAN') then
      return;
    end if;

    open cuFlag;
    fetch cuflag into sbflag;
    if cuflag%notfound then
      sbflag := 'N';
    end if;
    close cuflag;

    --DBMS_LOCK.sleep(1);
   -- LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'SBFLAG ' || sbflag);

    if NVL(sbflag,'N') = 'N' then
      ldc_pkExcDifeFina.prSetFlag; -- N
    end if;

    /* if nvl(sbflag,'N') = 'S' then
       DBMS_LOCK.sleep(1);
       LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'SBFLAG EN S ... NO CONTINUARA');
       return;
     end if;
    */
    ldc_pkExcDifeFina.prCambiaFlag('S');

  ldc_pkExcDifeFina.prSetPrograma(sbPrograOSF);

    --DBMS_LOCK.sleep(1);
    --LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'SBFLAG EN N ... SI CONTINUARA PERO YA MARCO COMO S');

    tDife.delete;

    if IOTBDEFERRED is null then
      IOTBDEFERRED := MO_TYTBDEFERRED();
    else
      IOTBDEFERRED.delete;
    end if;
      --LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'va a consultar diferidos');
      begin
        CC_BOFinancing.GETDEFERREDSCOLLECTION(IOTBDEFERRED);
        NUDIFESELEC := IOTBDEFERRED.COUNT;
      exception
        when others then
          return;
      end;
     -- LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'va a consultar diferidos');
      --DBMS_LOCK.sleep(1);
     -- LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'COUNT DIFE ' || NUDIFESELEC);

      IF NVL(NUDIFESELEC,0) > 0 THEN
        NUINDEXDEF:=  IOTBDEFERRED.FIRST;
        NUI := 1;
        LOOP
          EXIT WHEN NUINDEXDEF IS NULL;
          IF NUI = 1 THEN
            NUPRODUCTO := IOTBDEFERRED(NUINDEXDEF).product_id;
            FOR RG IN CUDIFERIDOS(NUPRODUCTO) LOOP
              if not tDife.exists(rg.difecodi) then
                tDife(rg.difecodi).is_Selected := 'N';
              end if;
            END LOOP;
          END IF;
          NUI := NUI + 1;

          if tDife.exists(IOTBDEFERRED(NUINDEXDEF).DEFERRED_ID ) then
            if  IOTBDEFERRED(NUINDEXDEF).selected_deferred = 'Y' then
              if instr('|'||sbPlansCOVID||'|', '|'||IOTBDEFERRED(NUINDEXDEF).deferred_plan_id||'|') = 0 then
                tDife(IOTBDEFERRED(NUINDEXDEF).DEFERRED_ID).is_Selected := 'Y';
              else
                ldc_pkExcDifeFina.prInsertTmp (IOTBDEFERRED(NUINDEXDEF).product_id, IOTBDEFERRED(NUINDEXDEF).DEFERRED_ID, IOTBDEFERRED(NUINDEXDEF).CONCEPT_ID, IOTBDEFERRED(NUINDEXDEF).pending_balance);
              end if;
            end if;
          end if;
          NUINDEXDEF:=  IOTBDEFERRED.NEXT(NUINDEXDEF);
        END LOOP;
      END IF;

      FOR RG IN CUDIFERIDOS (NUPRODUCTO) LOOP
        i := i + 1;
        if tDife.exists(rg.difecodi) then
          if tDife(rg.difecodi).is_Selected = 'Y' then
            j := j + 1;
            osbDiferidos := OSBDIFERIDOS || i || '|';
          end if;
        end if;
      END LOOP;

      --DBMS_LOCK.sleep(1);
     -- LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'J ' || J);
      --DBMS_LOCK.sleep(1);
     -- LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'OSBDIFERIDOS ' || osbDiferidos);

      --IF NVL(J,0) > 0 THEN
      if nvl(NUDIFESELEC,0) > 0 THEN
        --DBMS_LOCK.sleep(1);
        --LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'HARA SETSELECTEDDEFERRED CON OSBDIFERIDOS ' || OSBDIFERIDOS);
        CC_BOFinancing.SETSELECTEDDEFERRED(OSBDIFERIDOS);

        ---------------
        CC_BOFinancing.GETDEFERREDSCOLLECTION(IOTBDEFERRED2);
        NUDIFESELEC2 := IOTBDEFERRED2.COUNT;
        IF NVL(NUDIFESELEC2,0) > 0 THEN
          NUINDEXDEF2:=  IOTBDEFERRED2.FIRST;
          LOOP
            EXIT WHEN NUINDEXDEF2 IS NULL;
            --DBMS_LOCK.sleep(1);
            --LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,IOTBDEFERRED2(NUINDEXDEF2).DEFERRED_ID || '    ' || IOTBDEFERRED2(NUINDEXDEF2).deferred_plan_id || '   ' || IOTBDEFERRED2(NUINDEXDEF2).selected_deferred);
            NUINDEXDEF2:=  IOTBDEFERRED2.NEXT(NUINDEXDEF2);
          END LOOP;
        END IF;
        --------------
      END IF;

      /*   END IF;*/
      --IF NVL(J,0) > 0 THEN
      IF sbPrograOSF = 'GCNED' THEN
        FOR rg in cuTmp LOOP
          open cuNego1 (rg.producto, rg.concepto, rg.valor);
          fetch cuNego1 into nutmp_bal_by_concept_id, nuconcept_id, nupending_balance, nufinancing_balance, nuorig_pending_balance;
          if cuNego1%notfound then
            nutmp_bal_by_concept_id := 0;
          end if;
          close cuNego1;

          --DBMS_LOCK.sleep(1);
          --LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'cutmp GCNED nutmp_bal_by_concept_id ' || nutmp_bal_by_concept_id || ' Concepto ' || nuconcept_id || ' RG.VALOR ' || RG.VALOR || ' saldo ' || nupending_balance);

          if nutmp_bal_by_concept_id > 0 then
            if rg.valor >= nupending_balance then
              DELETE CC_TMP_BAL_BY_CONC T
              WHERE T.ACCOUNT_NUMBER = -1
              AND T.TMP_BAL_BY_CONCEPT_ID = nutmp_bal_by_concept_id;

              --DBMS_LOCK.sleep(1);
            -- LDC_BCCREG_B.pro_grabalog(3380,'TRGTMP',2020,10,SYSDATE,1,1,'GCNED DELETE Producto ' || '|' || rg.producto ||  '|' || nuconcept_id || '|' || nupending_balance);
            else
              UPDATE CC_TMP_BAL_BY_CONC T
                 SET T.PENDING_BALANCE = PENDING_BALANCE - RG.VALOR,
                     T.FINANCING_BALANCE = T.FINANCING_BALANCE - RG.VALOR,
                     T.ORIG_PENDING_BALANCE = T.ORIG_PENDING_BALANCE - RG.VALOR
               WHERE T.ACCOUNT_NUMBER = -1
                 AND T.TMP_BAL_BY_CONCEPT_ID = nutmp_bal_by_concept_id;
              --DBMS_LOCK.sleep(1);
          --   LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'cutmp GCNED UPDATE nutmp_bal_by_concept_id ' || nutmp_bal_by_concept_id || ' Concepto ' || nuconcept_id || 'saldo ' || nupending_balance);
            end if;
          end if;
        END LOOP;
    /*  ELSE -- FINAN
        FOR rg in cuTmp2 LOOP

        open cuNego2 (rg.producto, rg.concepto);
        fetch cuNego2 into nutmp_bal_by_concept_id, nuconcept_id, nupending_balance, nufinancing_balance, nuorig_pending_balance;
        if cuNego2%notfound then
          nutmp_bal_by_concept_id := 0;
        end if;
        close cuNego2;

        --DBMS_LOCK.sleep(1);
        --LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'cutmp FINAN nutmp_bal_by_concept_id ' || nutmp_bal_by_concept_id || ' Concepto ' || nuconcept_id || ' RG.VALOR ' || RG.VALOR || ' saldo ' || nupending_balance);

        if nutmp_bal_by_concept_id > 0 then
          if rg.valor >= nupending_balance then
            DELETE CC_TMP_BAL_BY_CONC T
             WHERE T.ACCOUNT_NUMBER = -1
               AND T.TMP_BAL_BY_CONCEPT_ID = nutmp_bal_by_concept_id;

            --DBMS_LOCK.sleep(1);
           --LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'cutmp FINAN DELETE nutmp_bal_by_concept_id ' || nutmp_bal_by_concept_id || ' Concepto ' || nuconcept_id || 'saldo ' || nupending_balance);
          else
            UPDATE CC_TMP_BAL_BY_CONC T
               SET T.PENDING_BALANCE = PENDING_BALANCE - RG.VALOR,
                   T.FINANCING_BALANCE = T.FINANCING_BALANCE - RG.VALOR,
                   T.ORIG_PENDING_BALANCE = T.ORIG_PENDING_BALANCE - RG.VALOR
             WHERE T.ACCOUNT_NUMBER = -1
               AND T.TMP_BAL_BY_CONCEPT_ID = nutmp_bal_by_concept_id;

            --DBMS_LOCK.sleep(1);
          --  LDC_BCCREG_B.pro_grabalog(3380,'TRG AI',2020,10,SYSDATE,1,1,'cutmp FINAN UPDATE nutmp_bal_by_concept_id ' || nutmp_bal_by_concept_id || ' Concepto ' || nuconcept_id || 'saldo ' || nupending_balance);
          end if;
        end if;
        --end loop;
      END LOOP;*/
    END IF;
    --END IF;
  End If; -- Finaliza Aplica Entrega.
EXCEPTION
  WHEN  EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
END TRG_CC_TMP_BAL_BY_CONC_AI;
/
