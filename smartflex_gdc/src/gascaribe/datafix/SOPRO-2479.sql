column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO Reversa Prepago');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    nuContrato  suscripc.susccodi%TYPE;
    nuPlanNormal  servsusc.sesuplfa%TYPE;
    nuProduct           servsusc.sesunuse%type;
    cnuPERI_GRAC_PREP          CONSTANT cc_grace_period.grace_period_id%TYPE := 45;
   CURSOR CUPROD (nuContrato IN servsusc.sesususc%TYPE)
    IS
    SELECT sesunuse
      FROM servsusc
     WHERE sesususc =  nuContrato
       AND sesuserv = 7014;

    CURSOR cuDiferidosContingencia
    (
        inuContrato diferido.difesusc%TYPE
    )
    IS
    WITH pldicont AS
    (
        SELECT plficoco plan_id
        FROM LDC_CONFIG_CONTINGENC
        UNION
        SELECT plficont plan_id
        FROM LDC_CONFIG_CONTINGENC
    )
    SELECT df.difecodi,pg.Grace_Peri_Defe_Id
    FROM diferido df, pldicont ,cc_grace_peri_defe pg
    WHERE df.difesusc = inuContrato
    AND NVL( df.difesape,0 ) > 0
    AND df.difepldi = pldicont.plan_id
    AND pg.deferred_id = df.difecodi
    AND pg.grace_period_id = cnuPERI_GRAC_PREP
    AND SYSDATE between pg.INITIAL_DATE AND pg.END_DATE
    ORDER BY difecodi;

BEGIN

    nuContrato := 1168955;
    nuPlanNormal:=4;
    nuProduct := 0;
    OPEN cuProd(nuContrato);
    FETCH cuProd INTO nuProduct;
    CLOSE cuProd;
    IF (nuProduct > 0 OR nuProduct IS not null) THEN
        pktblServsusc.UPDSESUPLFA(nuProduct, nuPlanNormal);
        DAPR_product.UPDCOMMERCIAL_PLAN_ID(nuProduct, nuPlanNormal);
    END IF;
    FOR rcCC_Grace_Peri_Defe IN cuDiferidosContingencia(nuContrato) LOOP
        DACC_Grace_Peri_Defe.UPDEND_DATE( rcCC_Grace_Peri_Defe.Grace_Peri_Defe_Id, SYSDATE );
    END LOOP;
    COMMIT;
    dbms_output.put_line('SALIDA onuErrorCode: '||nuErrorCode);
    dbms_output.put_line('SALIDA osbErrorMess: '||sbErrorMessage);


EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/