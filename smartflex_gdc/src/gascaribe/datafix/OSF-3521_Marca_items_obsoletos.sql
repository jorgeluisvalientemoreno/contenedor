column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    CURSOR cuInfoItems
    IS
    SELECT  * 
    FROM  ge_items
    WHERE items_id IN (
          10000011,
      10000012,
      10000014,
      10000015,
      10000113,
      10000114,
      10000119,
      10000393,
      10000697,
      10000973,
      10001150,
      10001179,
      10001258,
      10001381,
      10001853,
      10001855,
      10003353,
      10003604,
      10004176,
      10004177,
      10004178,
      10004179,
      10004228,
      10004233,
      10004334,
      10004381,
      10004558,
      10004697,
      10004841,
      10004912,
      10004918,
      10004970,
      10005488,
      10005651,
      10006513,
      10006517,
      10006552,
      10006561,
      10006650,
      10006996,
      10007136,
      10007311,
      10007705,
      10007993,
      10007994,
      10007995,
      10007996,
      10007998,
      10007999,
      10008000,
      10008001,
      10008002,
      10008003,
      10008004,
      10008005,
      10008006,
      10008007,
      10008008,
      10008009,
      10008206,
      10008532,
      10008854,
      10008958,
      10009134,
      10009149,
      10009152,
      10009897,
      10010834,
      10010835,
      10010836,
      10011060,
      10011337,
      10011502,
      10000414,
      10000415,
      10000814,
      10000815,
      10001224,
      10003204,
      10003939,
      10003980
          ) ;
BEGIN
  dbms_output.put_line('Inicia OSF-3521 !');
  FOR reg IN  cuInfoItems LOOP
    dbms_output.put_line('Se actializa item '||reg.items_id);
    UPDATE ge_items
    SET obsoleto = 'S',
        init_inv_status_id = 15
    WHERE items_id = reg.items_id;

    COMMIT;

  END LOOP;
  
  dbms_output.put_line('Fin OSF-3521 !');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/