column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-988');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  nuCommentType   number;
  isbOrderComme   varchar2(4000);
  nuErrorCode     number;
  sbErrorMesse    varchar2(4000);

  -- Poblacion a la que aplica el Datafix
  CURSOR cuPoblacion IS
  select order_id, max_date_to_legalize from or_order where order_id in (257319400,244938956);

begin
  dbms_output.put_line('---- Inicio OSF-988 ----');

  FOR reg in cuPoblacion
  LOOP

    IF(reg.ORDER_ID = 257319400)THEN
      UPDATE or_order SET max_date_to_legalize = '31/01/2023' WHERE order_id =257319400;
      dbms_output.put_line('Se actualiza la orden ['||reg.ORDER_ID||'] Fecha Maxima actual [31/01/2023] - Fecha Maxima Anterior [' ||reg.max_date_to_legalize||']');

      nuCommentType := 1277;

      isbOrderComme  := 'La orden ['||reg.ORDER_ID||'] Se Actualizo con Fecha Maxima de legalización 31/01/2023 y la Fecha MAxima Anterior era [' ||reg.max_date_to_legalize||'] por el Caso OSF-988';

      -- Adiciona comentario en la orden
      OS_ADDORDERCOMMENT( inuOrderId       => reg.ORDER_ID,
                          inuCommentTypeId => nuCommentType,
                          isbComment       => isbOrderComme,
                          onuErrorCode     => nuErrorCode,
                          osbErrorMessage  => sbErrorMesse);
      IF (nuErrorCode <> 0) THEN
        dbms_output.put_line('No se logro crear el comentario de La orden ['||reg.ORDER_ID||']');
      END IF;
      dbms_output.put_line('[OR_ORDER_COMMENT] - ['||isbOrderComme||']');
    END IF;

    IF(reg.ORDER_ID = 244938956)THEN
      UPDATE or_order SET max_date_to_legalize = '15/02/2023' WHERE order_id =244938956;
      dbms_output.put_line('Se actualiza la orden ['||reg.ORDER_ID||'] Fecha Maxima actual [15/02/2023] - Fecha Maxima Anterior [' ||reg.max_date_to_legalize||']');

      nuCommentType := 1277;

      isbOrderComme  := 'La orden ['||reg.ORDER_ID||'] Se Actualizo con Fecha Maxima de legalización 15/02/2023 y la Fecha MAxima Anterior era [' ||reg.max_date_to_legalize||'] por el Caso OSF-988';

      -- Adiciona comentario en la orden
      OS_ADDORDERCOMMENT( inuOrderId       => reg.ORDER_ID,
                          inuCommentTypeId => nuCommentType,
                          isbComment       => isbOrderComme,
                          onuErrorCode     => nuErrorCode,
                          osbErrorMessage  => sbErrorMesse);
      IF (nuErrorCode <> 0) THEN
        dbms_output.put_line('No se logro crear el comentario de La orden ['||reg.ORDER_ID||']');
      END IF;
      dbms_output.put_line('[OR_ORDER_COMMENT] - ['||isbOrderComme||']');
    END IF;

  END LOOP;

  COMMIT;

  dbms_output.put_line('---- Fin OSF-988 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-988----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/