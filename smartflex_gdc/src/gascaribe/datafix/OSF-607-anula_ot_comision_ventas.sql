column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  DECLARE

    --cursor para Anular ordenes de contratos definidos del CASO 100-82555 de la solicitude de venta a construtora 25892909.
    cursor cuproductopenins is
      select ooa.package_id, ooa.product_id PRODUCTO, ooa.order_id ORDEN
        from open.Or_Order_Activity ooa
      where ooa.order_id in (238600580,238600581,240489104,242008130,243575063,244939261,247504234,248779104,248779107,248779109,248779110,
          249127559,250916320,250916322,250916323,250916324,250916325,250916326,250916327,250916328,250916329,250916330,250916332,250916333,
          250916334,250916335,250916336,250916337,250916338,250916339,250916340,250916341,251358496,252923601,252923958,252924113,252924171,
          252924172,252924175,252924176,252924177,252924183,252924188,252924192,252924193,252924197,252924198,252924204,252924205,252924211,
          252924212,252924217,252924218,252924219,252924222,252924223,252924228,252924230,252924231,252924238,252924239,252924242,252924243,
          252924248,252924250,252924251,252924252,252924253,252924254,252924256,252924257,252924259,252924260,252924261,252924280,252924281,
          252924283,252924287,252924288,252924290,252924291,252924295,252924296,252924298,252924299,252924303,252924306,252924308,252924309,
          252924310,252924313,252924314,252924316,252924317,252924320,252924321,252924323,252924324,252924325,252924328,253827556,254486807,
          256017889,256017890,256017891,256017892,257739457,257739459,257739460,257739461,257739462,257739463,257739464,257739465,257739466,
          257739467,257739468,257739469,257739471,257739472,257739473,257739475,259304182,259304183,260919895,260919912,260919916);
    
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

    SBCOMMENT       VARCHAR2(4000) := 'SE ANULA ORDEN SEGUN CASO OSF-607';
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
        --
        or_boanullorder.anullorderwithoutval(rfcuproductopenins.ORDEN,SYSDATE);
        --
        OS_ADDORDERCOMMENT (rfcuproductopenins.ORDEN, nuCommentType, SBCOMMENT, nuErrorCode, sbErrorMesse);       
        --
        If nuErrorCode = 0 then
           commit;
        Else
           rollback;
           dbms_output.put_line('Error en Orden ' || rfcuproductopenins.ORDEN || ' Error : ' || sbErrorMesse);
        End if;
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