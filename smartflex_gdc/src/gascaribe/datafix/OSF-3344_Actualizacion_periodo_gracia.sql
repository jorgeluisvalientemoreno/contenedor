column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    CURSOR cuData
    IS
    with UnaCuota as(
    select *
    from open.diferido
    where difenucu = 1
    and   difecupa = 0
    ),
    FechaUltimaFacturacion as (
    select difenuse, max(difefumo) Fecha_Ultima_Fact, SUM(DIFESAPE) Cartera_Corriente
    from open.diferido
    where difenucu = 12
    and   difecupa > 2
    group by difenuse
    )
    select a.DIFECODI, d.GRACE_PERI_DEFE_ID
    from open.diferido a
    inner join open.cc_grace_peri_defe d on a.difecodi = d.deferred_id
    inner join UnaCuota b on a.difenuse = b.difenuse
    inner join FechaUltimaFacturacion ff on ff.difenuse = a.difenuse
    where a.difecodi in (select deferred_policy_id
                      from open.ld_policy
                      where product_line_id in (65,71)
                      and   state_policy = 1
                      and   dtcreate_policy >= '15/07/2023')
    and   a.difenucu = 12
    and   a.difecupa = 0;
BEGIN
    dbms_output.put_line('Inicia Datafix OSF-3344');

    FOR rec IN cuData LOOP        
        DBMS_OUTPUT.PUT_LINE('Inicia Diferido ' || rec.difecodi || ', Periodo Gracia: ' || rec.grace_peri_defe_id);

        UPDATE  cc_grace_peri_defe 
        SET     end_date = TO_DATE('10/10/2024 11:59:59 pm', 'DD/MM/YYYY HH:MI:SS AM')
        WHERE   grace_peri_defe_id =  rec.grace_peri_defe_id;

        DBMS_OUTPUT.PUT_LINE('Fin Diferido ' || rec.difecodi || ', Periodo Gracia: ' || rec.grace_peri_defe_id);
        COMMIT;
    END LOOP;

    dbms_output.put_line('Fin Datafix OSF-3344');
    
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/