column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    inuUnidadOperativa  OR_OPE_UNI_ITEM_BALA.operating_unit_id%TYPE := 3119;
    inuItem             OR_OPE_UNI_ITEM_BALA.items_id%TYPE := 10010630;

    CURSOR cuBodega
    (
        inuUnidad IN OR_OPE_UNI_ITEM_BALA.operating_unit_id%TYPE,
        inuItem   IN OR_OPE_UNI_ITEM_BALA.items_id%TYPE
    )
    IS
    SELECT  *
    FROM    OR_OPE_UNI_ITEM_BALA
    WHERE operating_unit_id = inuUnidad 
    AND items_id =inuItem;

    rcDatosBodega   cuBodega%ROWTYPE;
BEGIN

    OPEN cuBodega(inuUnidadOperativa,inuItem);
    FETCH cuBodega INTO rcDatosBodega;
    CLOSE cuBodega;

    UPDATE  ldc_act_ouib
    SET     balance = 0,
            total_costs = 0,
            transit_out = 0
    WHERE   operating_unit_id = inuUnidadOperativa 
    AND     items_id =inuItem;

    UPDATE  ldc_inv_ouib
    SET     balance = rcDatosBodega.balance,
            total_costs = rcDatosBodega.total_costs
    WHERE   operating_unit_id = inuUnidadOperativa 
    AND     items_id =inuItem;
  
    commit;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/