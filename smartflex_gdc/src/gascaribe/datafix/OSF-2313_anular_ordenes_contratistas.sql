column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
DECLARE

    --cursor para Anular ordenes de contratos definidos del CASO OSF-2313 Anulacion ordenes generadas a contratistas viejos.
    cursor cuproductopenins is
      select o.order_id ORDEN 
        from open.or_order o
       where o.order_id in (312266009,
302269564,
298976132,
313922099,
313922133,
313922098,
313922097,
313922136,
313920041,
313922119,
313922156,
192198178,
192198183,
313920042,
313921457,
313922110,
313922107,
313922130,
313922149,
313922159,
313922124,
313922151,
310408595,
313922148,
313922105,
313922152,
313922122,
313922182,
313922185,
192198174,
313922181,
313922080,
192198175,
192198179,
192198176,
313922138,
313922143,
313922104,
313922190,
192198180,
313922111,
313922127,
312266032,
313922126,
313922137,
313922193,
313922088,
313922093,
313922116,
313922141,
313922163,
313922075,
313922089,
313922112,
313922168,
192198177,
313922189,
313922083,
313922101,
313922140,
313922155,
313922167,
313922092,
313922179,
313922197,
313922079,
313922183,
313922131,
313922077,
313922118,
313922121,
313922191,
313922195,
192198181,
313922087,
313922188,
313922086,
313922096,
313922158,
313922106,
313922173,
313922134,
313922095,
313922162,
313922186,
313922199,
313922109,
313922165,
313922194,
313922103,
313922120,
313922125,
313922139,
313922090,
313922177,
313922102,
313922164,
313922108,
313922161,
313922091,
313922084,
313922129,
313922100,
313922166,
313922196,
313922175,
192198184,
313922113,
313922154,
313922085,
313922157,
313922171,
313922153,
313922094,
313922142,
313922170,
313922192,
313922200,
313921444,
313922114,
313922132,
313922145,
313922117,
192198182,
313922076,
313922150,
313922160,
313922187,
313922172,
313920048,
313922123,
313922135,
313922169,
313922147,
313922128,
313922082,
313922146,
313922198,
313922115,
313922174,
313922176,
192198185	) ;

    
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

    SBCOMMENT       VARCHAR2(4000) := 'SE ANULA ORDEN SEGUN CASO OSF-2313';
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

      nuacta := null;
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