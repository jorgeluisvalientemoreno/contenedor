CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_GC_DEBT_NEGOT_CHARGE_AI
  AFTER INSERT ON GC_DEBT_NEGOT_CHARGE

DECLARE
  nudebtnegprod GC_DEBT_NEGOT_PROD.DEBT_NEGOT_PROD_ID%type;
  nuprod servsusc.sesunuse%type;
  nuvlrdesc diferido.difevatd%type;
  nucantprod number;
  nucantnego number;
  NUDEL NUMBER;
  sbPrograOSF VARCHAR2(200) := pkErrors.fsbGetApplication;

  cursor cuNego is
    SELECT P.PACKAGE_ID, T.DEBT_NEGOT_PROD_ID, T.SESUNUSE, NC.DEBT_NEGOT_CHARGE_ID, G.DIFERIDO
    FROM OPEN.GC_DEBT_NEGOT_CHARGE nc, OPEN.GC_DEBT_NEGOT_PROD T, OPEN.GC_DEBT_NEGOTIATION N, OPEN.MO_PACKAGES P, ldc_tempnego G
    WHERE t.debt_negot_prod_id = NC.DEBT_NEGOT_PROD_ID
    AND T.DEBT_NEGOTIATION_ID = N.DEBT_NEGOTIATION_ID
    AND N.PACKAGE_ID = P.PACKAGE_ID
    AND T.SESUNUSE = G.PRODUCTO
    AND NC.SUPPORT_DOCUMENT = 'DF-'||G.DIFERIDO
    AND P.PACKAGE_TYPE_ID = 328
    --AND NC.DOCUMENT_CONSECUTIVE = -1
    AND P.MOTIVE_STATUS_ID = 13
	 and NC.CUCOCODI = -1;

BEGIN
  if  fblaplicaentregaxcaso('0000620') then --Valida Aplica Entrega.
    --DBMS_LOCK.sleep(1);
    --LDC_BCCREG_B.pro_grabalog(3380,'TRG_GC_DEBT_NEGOT_CHARGE_AI',2020,10,SYSDATE,1,1,'sbPrograOSF ' || sbPrograOSF);

    if sbPrograOSF not in ('CUSTOMER') then
      return;
    end if;


    FOR rg in cuNego LOOP
      nuprod := rg.SESUNUSE;
      nudebtnegprod :=  rg.debt_negot_prod_id;
      DELETE GC_DEBT_NEGOT_CHARGE NH
       WHERE NH.DEBT_NEGOT_CHARGE_ID = RG.DEBT_NEGOT_CHARGE_ID;

      -- LDC_BCCREG_B.pro_grabalog(3380,'TRGNEG',2020,10,SYSDATE,1,1,'DELETE Producto ' || '|' || rg.SESUNUSE ||  '|' || 'DF-'||RG.DIFERIDO ||  '|' || RG.DEBT_NEGOT_CHARGE_ID);

    END LOOP;
  End If; --Finaliza Aplica Entrega.
EXCEPTION
  WHEN  EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
END TRG_GC_DEBT_NEGOT_CHARGE_AI;
/
