column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
DECLARE

    --cursor para Anular ordenes de contratos definidos del CASO OSF-874 Anulacion ordenes de comision vendedores.
    cursor cuproductopenins is
      select o.order_id ORDEN 
        from open.or_order o
       where o.order_id in (274213862,
274213079,
274213475,
274213746,
274213007,
274214183,
274213040,
274213919,
274212972,
274213576,
274212915,
274213060,
274213555,
274214096,
274213056,
274213467,
274212895,
274212949,
274214147,
274213673,
274214049,
274214190,
274212947,
274213089,
274213143,
274213399,
274214198,
274212979,
274214078,
274213259,
274214343,
274213942,
274213123,
274212893,
274214043,
274214009,
274212902,
274214118,
274214086,
274214207,
274212914,
274212991,
274214123,
274213557,
274213931,
274213781,
274213274,
274213640,
274212941,
274213086,
274212869,
274213174,
274214004,
274213539,
274213520,
274213490,
274213183,
274213146,
274213495,
274213690,
274214255,
274213465,
274214245,
274213901,
274213372,
274214125,
274213701,
274213897,
274214040,
274213732,
274213592,
274214088,
274213825,
274213725,
274213599,
274213587,
274213536,
274213923,
274213797,
274213620,
274213723,
274213258,
274214226,
274213129,
274213382,
274213071,
274212948,
274213936,
274212986,
274213190,
274213413,
274213656,
274213297,
274213574,
274213684,
274213035,
274213026,
274213885,
274213055,
274213178,
274214002,
274213748,
274214289,
274213424,
274213991,
274213930,
274214120,
274213248,
274213654,
274213978,
274213957,
274214490,
274214355,
274214302,
274213450,
274213388,
274213135,
274213423,
274213621,
274213708,
274213831,
274214153,
274214075,
274213659,
274213713,
274213706,
274214045,
274213318,
274214295,
274213858,
274214253,
274214053,
274213177,
274213204,
274213917,
274214438,
274212749,
274212858,
274214134,
274213964,
274213681,
274213337,
274213593,
274213808,
274213614,
274213546,
274213846,
274213330,
274213813,
274213886,
274214006,
274213344,
274212899,
274214392,
274213230,
274213132,
274214307,
274213158,
274213758,
274213980,
274213419,
274213730,
274214154,
274213954,
274213429,
274213852,
274213377,
274213963,
274213491);

    
    -- Cursor para validar que la OT no este en acta
    cursor cuacta(nuorden number) is
      select d.id_acta
        from open.ge_detalle_acta d
       where d.id_orden = nuorden
         and rownum = 1;

    rfcuproductopenins cuproductopenins%rowtype;

    --Comentario de orden 
    -- Registro de Comentario de la orden
    rcOR_ORDER_COMMENT open.daor_order_comment.styor_order_comment;

    nuPersonID open.ge_person.person_id%type;
    nuInfomrGen constant open.or_order_comment.comment_type_id%type := 1277; -- INFORMACION GENERAL

    SBCOMMENT       VARCHAR2(4000) := 'SE ANULA ORDEN SEGUN CASO OSF-874';
    nuCommentType   number:=1277;
    nuErrorCode     number;
    sbErrorMesse    varchar2(4000);
    nuacta          number;
    
  BEGIN

    --Recorrer ordenes del contrato de venta a constructora
    for rfcuproductopenins in cuproductopenins loop
      -- Validamos que no este en acta
      if cuacta%isopen then
        close cuacta;
      end if;
      --
      open cuacta(rfcuproductopenins.ORDEN);
      fetch cuacta into nuacta;
      close cuacta;
      --
      If nuacta is not null then
        dbms_output.put_line('Orden esta en acta ' || rfcuproductopenins.ORDEN || ' Acta : ' || nuacta);
      Else
        BEGIN
          -- Anulamos la OT
          or_boanullorder.anullorderwithoutval(rfcuproductopenins.ORDEN,SYSDATE);
          -- Borramos de la tabla de comisiones si allí esta 
          delete open.ldc_pkg_or_item o 
           where o.order_id = rfcuproductopenins.ORDEN;
          -- Adicionamos comentario a la OT
          OS_ADDORDERCOMMENT (rfcuproductopenins.ORDEN, nuCommentType, SBCOMMENT, nuErrorCode, sbErrorMesse);       
          --
          If nuErrorCode = 0 then
             commit;
          Else
             rollback;
             dbms_output.put_line('Error en Orden ' || rfcuproductopenins.ORDEN || ' Error : ' || sbErrorMesse);
          End if;           
          --
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('Error en Orden ' || rfcuproductopenins.ORDEN || ' Error : ' || SQLERRM);
        END;
      --  
      End if;
      --
    end loop;
    
    dbms_output.put_line('Fin de Proceso');

  END;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/