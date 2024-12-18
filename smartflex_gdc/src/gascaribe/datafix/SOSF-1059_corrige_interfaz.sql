column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;


DECLARE
  cursor cuSeriales is
  WITH BASE AS(
SELECT ROWID, SERINUME, SERIESTR, LENGTH(SERIESTR) TAM, D.SERIMARC, D.SERIANO, D.SERIREMA, D.SERITIEN
FROM OPEN.LDCI_SERIDMIT D
WHERE SERIMMIT=91074
)
SELECT BASE.*, 
       SUBSTR(SERIESTR, 3, TAM-8) SERIAL,
       DECODE(SUBSTR(SERIESTR, TAM-1,2),'01','I','D') TIPO_ENT, 
       SUBSTR(SERIESTR,TAM-3,2) REFE, 
       SUBSTR(SERIESTR,TAM-5,2) ANO, 
       SUBSTR(SERIESTR,1,2) MARCA,
       (SELECT M.MARCLEMA FROM OPEN.LDCI_MARCA M WHERE M.MARCCODI=TO_NUMBER(SUBSTR(SERIESTR,1,2))) LETRA
FROM BASE;
begin

  FOR REG IN cuSeriales loop
    UPDATE LDCI_SERIDMIT 
      SET SERINUME=REG.LETRA||'-'||REG.SERIAL||'-'||REG.ANO,
          SERIANO=REG.ANO,
          SERIMARC=REG.MARCA,
          SERITIEN=REG.TIPO_ENT,
          SERIREMA=REG.REFE
    WHERE ROWID=REG.ROWID;
  END LOOP;
  
  UPDATE LDCI_INTEMMIT
     SET MMITINTE=0
    WHERE MMITCODI=91074;

    COMMIT;
exception
  when OTHERS then
    ROLLBACK;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/