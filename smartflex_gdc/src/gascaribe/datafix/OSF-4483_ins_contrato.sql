column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

    CURSOR cuContSinEmpr
    IS
    select empresa,susccodi 
    from open.suscripc
    left join multiempresa.contrato on contrato=susccodi
    where exists ( select null from open.pr_product where subscription_id = susccodi and product_type_id != 3 ) 
    and empresa is null;

begin

    FOR rgContSinEmpr IN cuContSinEmpr LOOP
    
        INSERT INTO contrato
        (
            contrato,
            empresa
        )
        VALUES
        (
            rgContSinEmpr.susccodi,
            'GDCA'
        );
    
    END LOOP;
    
    COMMIT;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/