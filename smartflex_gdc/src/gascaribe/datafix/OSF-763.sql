column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    nuErrorCode 	NUMBER;
    sbErrorMessage 	VARCHAR2(4000);
BEGIN

DELETE 
FROM OPEN.LDC_PEFAGEPTT
WHERE PEGPPERI in (103054,103055);

delete 
from open.procejec
where PREJCOPE in (103054,103055) and  PREJFECH > '19/12/2022 09:19:17';


UPDATE  OPEN.SUSCRIPC SET SUSCNUPR = 2
WHERE SUSCCICL IN (7714,7717)
 AND NOT EXISTS (SELECT 1 FROM OPEN.FACTURA WHERE FACTSUSC = SUSCCODI AND FACTPEFA IN (103054,103055) AND FACTPROG = 6 );

delete 
from open.incofact
where INFAPEFA in (103054,103055);


delete 
from OPEN.ESTAPROG
where esprpefa in ( 103054,103055) and ESPRFEIN > TO_DATE('19/12/2022 11:56:49','DD/MM/YYYY HH24:MI:SS');

insert into open.procejec(PREJCOPE, PREJPROG, PREJFECH, PREJUSUA, PREJTERM, PREJINAD, PREJESPR, PREJSEEJ, PREJPRID, PREJIDPR, PREJPRPR)
            values (103054, 'FGFC' , TO_DATE('19/12/2022 09:20:00','DD/MM/YYYY HH24:MI:SS'), 'JOHBAY', 'NO TERMINAL', -1, 'T', NULL,  NULL, -266031, NULL);

insert into open.procejec(PREJCOPE, PREJPROG, PREJFECH, PREJUSUA, PREJTERM, PREJINAD, PREJESPR, PREJSEEJ, PREJPRID, PREJIDPR, PREJPRPR)
            values (103055, 'FGFC' , TO_DATE('19/12/2022 09:20:00','DD/MM/YYYY HH24:MI:SS'), 'JOHBAY', 'NO TERMINAL', -1, 'T', NULL,  NULL, -266076, NULL);

commit;

EXCEPTION
    WHEN ex.CONTROLLED_ERROR  THEN
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
    WHEN OTHERS THEN
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