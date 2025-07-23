column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    CURSOR cuContrato
    IS
    SELECT  *
    FROM    ge_contrato
    WHERE   id_contrato IN  (6361);
BEGIN
    dbms_output.put_line('Inicia OSF-4499!');

    FOR rgContrato IN cuContrato LOOP

        dbms_output.put_line('Inicia actualización contrato : '||rgContrato.id_contrato);
        dbms_output.put_line('Valor no Liquidado : '||rgContrato.valor_no_liquidado);

        UPDATE  ge_contrato
        SET     valor_no_liquidado = 0
        WHERE   id_contrato = rgContrato.id_contrato;
      
    END LOOP;

    dbms_output.put_line('Fin OSF-4499!');
    commit;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/