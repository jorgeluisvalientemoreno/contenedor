set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/
declare
  nuLAstNum number;
  NUdATO NUMBER;
BEGIN

SELECT COUNT(1) INTO NUdATO
FROM LDC_GRUPVIFA;

IF NUdATO = 0 THEN
    Insert into LDC_GRUPVIFA (GRUPCODI,GRUPDESC) values (13,'CREDITO BRILLA');
    Insert into LDC_GRUPVIFA (GRUPCODI,GRUPDESC) values (14,'REPARACIONES POR REVISION PERIODICA');
    Insert into LDC_GRUPVIFA (GRUPCODI,GRUPDESC) values (15,'REVISION PERIODICA');
    Insert into LDC_GRUPVIFA (GRUPCODI,GRUPDESC) values (16,'TRABAJOS POR SERVICIOS ADICIONALES');
    Insert into LDC_GRUPVIFA (GRUPCODI,GRUPDESC) values (17,'REPARACIONES POR MANTENIMIENTO');
    Insert into LDC_GRUPVIFA (GRUPCODI,GRUPDESC) values (18,'INSTALACION DEL SERVICIO');
    COMMIT;
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,24);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,41);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,42);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,43);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,47);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,48);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,49);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,50);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,51);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,52);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,53);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,54);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,56);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,57);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,58);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,60);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,62);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,63);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,64);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,65);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,67);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,69);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,70);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,71);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,72);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,73);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,74);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,75);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,77);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,80);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,81);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,131);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,305);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,309);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,311);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,314);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,474);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,712);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,750);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,816);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,817);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,818);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,16);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,133);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,135);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,282);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (13,283);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (14,193);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (14,203);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (14,757);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (15,867);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (15,739);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (15,742);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (15,743);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (15,755);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (18,19);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (18,30);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (18,291);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (18,674);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (18,754);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (18,758);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (18,866);
    Insert into LDC_CONCGRVF (GRUPCODI,COGRCODI) values (18,869);
    COMMIT;
    
    SELECT LAST_NUMBER INTO nuLAstNum
    FROM SYS.DBA_SEQUENCES
    WHERE SEQUENCE_NAME = 'SEQ_GRUPVIFA';
    
    FOR reg in nuLAstNum..18 LOOP
      select SEQ_GRUPVIFA.nextval into NUdATO
      FROM DUAL;
    END LOOP;

END IF;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/