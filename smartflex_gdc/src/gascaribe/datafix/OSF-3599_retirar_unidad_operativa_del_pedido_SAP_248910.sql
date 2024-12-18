column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

    dbms_output.put_line('Incia cambio de promoción OSF-3599');
    update OPEN.LDCI_TRANSOMA a
    set a.trsmunop = null
    where a.trsmcodi = 248910;

    COMMIT;
    dbms_output.put_line('Se retira unidad operativa del pedido 248910. Ok.');
    dbms_output.put_line('Fin cambio de promoción OSF-3599');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo retira unidad operativa del pedido 248910, '||sqlerrm);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/