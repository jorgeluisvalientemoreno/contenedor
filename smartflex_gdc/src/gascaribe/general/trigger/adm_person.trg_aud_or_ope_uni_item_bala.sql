CREATE OR REPLACE TRIGGER ADM_PERSON.trg_aud_OR_ope_uni_item_bala
    AFTER UPDATE OF TRANSIT_IN ON OR_ope_uni_item_bala
    REFERENCING old AS old new AS new for each row
    WHEN (nvl(new.transit_in,0) < nvl(old.transit_in,0) AND abs(nvl(old.transit_in,0) - nvl(new.transit_in,0)) > 1)
DECLARE

    application     varchar(20);
    sbUser          varchar(50);
    sbTerminal      varchar(50);
    sbflag          varchar2(1);
    dtTime          date;

BEGIN

    SELECT decode((SELECT unique 'X' FROM ge_items_seriado WHERE items_id = :old.items_id),null,'N','Y')
    INTO sbflag
    FROM dual;

    if sbflag = 'Y' then

        application := pkerrors.fsbgetapplication;

        sbUser := ut_session.getuser;

        sbTerminal := ut_session.getmachineofcurrentuser;

        dtTime := sysdate;

        pkGeneralServices.SetTraceDataOn('DB', 'SAO392855_['||:old.operating_unit_id||']');
        pkGeneralServices.TraceData('Aplicación: ['||application||'] at '||dtTime);
        pkGeneralServices.TraceData('Usuario: ['||sbUser||'] at '||dtTime);
        pkGeneralServices.TraceData('Terminal: ['||sbTerminal||'] at '||dtTime);
        pkGeneralServices.TraceData('OperUnid: ITEM['||:old.items_id||'] BAL['||:old.balance||'] old.TRAN_IN['||:old.transit_in||'] new.TRAN_IN['||:new.transit_in||'] at '||dtTime);
        pkGeneralServices.TraceData(DBMS_UTILITY.FORMAT_CALL_STACK);
        pkGeneralServices.SetTraceDataOff;

    END if;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;
    when OTHERS then
        Errors.seterror;
        raise ex.CONTROLLED_ERROR;
END;
/
