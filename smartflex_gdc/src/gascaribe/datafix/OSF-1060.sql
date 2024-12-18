column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  nuCommentType      NUMBER := 1277;
  isbOrderComme      varchar2(4000) := 'Se cambia estado a anulado por caso OSF-1060';
  onuErrorCode       NUMBER;
  osbErrorMessage    VARCHAR2(2000);
  blOrdenAnulada     BOOLEAN;

  -- Poblacion DataFix
  CURSOR cuPoblacion IS
  WITH tbl_ordenes AS (
  SELECT  oo.order_id,
          oo.order_status_id,
          oo.task_type_id,
          oa.ACTIVITY_ID
  FROM    OPEN.OR_ORDER oo
          JOIN open.or_order_activity oa ON oo.order_id = oa.order_id
  WHERE   oo.ORDER_ID IN ( 144082607, 158693552, 162848028, 281466094, 279075368,
                          281704387, 227302562, 259750756, 269261091, 179588590,
                          185544012, 187169832, 246419449, 253321271, 268186506 )
  )
  SELECT  tbl_ordenes.order_id            AS ORDEN,
          tbl_ordenes.task_type_id        AS TIPO_TRABAJO,
          tbl_ordenes.activity_id         AS ACTIVIDAD,
          tbl_ordenes.order_status_id     AS ESTADO_OT,
          NVL(pno.possible_ntl_id, -11)   AS PROYECTO_FMCAP,
          pno.status                      AS ESTADO_PROYECTO
  FROM    OPEN.FM_POSSIBLE_NTL pno
          RIGHT OUTER JOIN tbl_ordenes ON pno.order_id = tbl_ordenes.order_id
  order by pno.status;

BEGIN
  dbms_output.put_line('-------------------  Inicio OSF-1060 ------------------- ');

  FOR reg IN cuPoblacion
  LOOP
      onuErrorCode    := NULL;
      osbErrorMessage := NULL;
      blOrdenAnulada  := false;
      BEGIN
          dbms_output.put_line('--> Inicio orden: '||reg.ORDEN);

          or_boanullorder.anullorderwithoutval(reg.ORDEN, SYSDATE);

          OS_ADDORDERCOMMENT(reg.ORDEN,
                            nuCommentType,
                            isbOrderComme,
                            onuErrorCode,
                            osbErrorMessage);

          dbms_output.put_line('nuErrorCode: '||onuErrorCode );
          dbms_output.put_line('sbErrorMesse: '||osbErrorMessage );

          IF (NVL(onuErrorCode,0) = 0) THEN
              COMMIT;
              blOrdenAnulada  := true;
              dbms_output.put_line('-> OK se anula la orden');
          ELSE
              rollback;
              blOrdenAnulada  := false;
              dbms_output.put_line('-> Error Anulando la orden');
          END IF;

          dbms_output.put_line('--> Fin orden: '||reg.ORDEN);
      EXCEPTION
        WHEN OTHERS THEN
          rollback;
          DBMS_OUTPUT.PUT_LINE('Error Anulando la ORDEN --> '||sqlerrm);
      END;

      IF ( (blOrdenAnulada) AND (reg.ESTADO_PROYECTO = 'R')) THEN
          dbms_output.put_line('--> Inicio Proyecto FMCAP: '||reg.PROYECTO_FMCAP);
          BEGIN
              UPDATE  OPEN.FM_POSSIBLE_NTL pno
              SET     pno.status = 'E'
              WHERE   pno.possible_ntl_id = reg.PROYECTO_FMCAP;
              COMMIT;
              dbms_output.put_line('-> OK cambio proyecto FMCAP');
          EXCEPTION
              WHEN OTHERS THEN
                  rollback;
                  DBMS_OUTPUT.PUT_LINE('Error Cambiando estado del proyecto FCMAP --> '||sqlerrm);
          END;
          dbms_output.put_line('--> Fin Proyecto FMCAP: '||reg.PROYECTO_FMCAP);
      END IF;
  END LOOP;

  COMMIT;

  dbms_output.put_line('------------------- Fin OSF-1060 ------------------- ');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-1060 ----');
    DBMS_OUTPUT.PUT_LINE('OSF-1060-Error General: --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/