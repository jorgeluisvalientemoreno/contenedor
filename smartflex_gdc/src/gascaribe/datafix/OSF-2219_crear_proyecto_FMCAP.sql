column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  nuOrden open.or_order.order_id%TYPE;

  nuCausal open.or_order.causal_id%TYPE;

  nuOrdenPNO open.or_order.order_id%TYPE;

  nuProducto open.or_order_activity.product_id%TYPE;

  rcFM_Possible_NTL DAFM_Possible_NTL.styFM_Possible_NTL;

  CURSOR cuDatosProducto(inuOrden    open.or_order_activity.order_id%TYPE,
                         inuProducto number) IS
    SELECT oa.product_id,
           pr.product_Type_Id,
           ad.Geograp_Location_id,
           ad.Address_Id
      FROM open.or_order_activity oa,
           open.pr_product        pr,
           open.ab_address        ad
     WHERE oa.order_id = inuOrden
       AND oa.product_id = inuProducto
       AND pr.product_id = oa.product_id
       AND ad.address_id = oa.address_id;

  rcDatosProducto cuDatosProducto%ROWTYPE;

  CURSOR cuPNO_Activo(inuProducto open.or_order_activity.product_id%TYPE,
                      inuOrden    open.or_order_activity.order_id%TYPE) IS
    SELECT *
      FROM open.fm_possible_ntl
     WHERE product_id = inuProducto
       AND order_id = inuOrden;

  rcPNO_Activo cuPNO_Activo%ROWTYPE;

  CURSOR cuDATOSOTPNO is
    select OT.orden, OT.producto
      from (Select 301034138 orden, 1133907 producto
              from dual
            union all
            Select 304159612 orden, 1147896 producto
              from dual
            union all
            Select 301067420 orden, 1163679 producto
              from dual
            union all
            Select 304027276 orden, 1163859 producto
              from dual
            union all
            Select 306514806 orden, 1169683 producto
              from dual
            union all
            Select 296129510 orden, 1170434 producto
              from dual
            union all
            Select 306488072 orden, 1170628 producto
              from dual
            union all
            Select 307707002 orden, 1170922 producto
              from dual
            union all
            Select 303068520 orden, 1172303 producto
              from dual
            union all
            Select 304145817 orden, 1172311 producto
              from dual
            union all
            Select 296129094 orden, 1172910 producto
              from dual
            union all
            Select 300910680 orden, 1181200 producto
              from dual
            union all
            Select 297268106 orden, 2033460 producto
              from dual
            union all
            Select 305701562 orden, 2060783 producto
              from dual
            union all
            Select 297626987 orden, 2067160 producto
              from dual
            union all
            Select 302668295 orden, 2078814 producto
              from dual
            union all
            Select 306519331 orden, 2082418 producto
              from dual
            union all
            Select 296541064 orden, 3056325 producto
              from dual
            union all
            Select 295320801 orden, 4001249 producto
              from dual
            union all
            Select 296624526 orden, 5061237 producto
              from dual
            union all
            Select 305557999 orden, 6065078 producto
              from dual
            union all
            Select 302125983 orden, 6091233 producto
              from dual
            union all
            Select 309404275 orden, 6138441 producto
              from dual
            union all
            Select 307327505 orden, 13001495 producto
              from dual
            union all
            Select 296530569 orden, 17002309 producto
              from dual
            union all
            Select 298365071 orden, 17006683 producto
              from dual
            union all
            Select 302992758 orden, 17008548 producto
              from dual
            union all
            Select 296624635 orden, 17093528 producto
              from dual
            union all
            Select 308358968 orden, 17210927 producto
              from dual
            union all
            Select 306771633 orden, 38001097 producto
              from dual
            union all
            Select 304406740 orden, 50014172 producto
              from dual
            union all
            Select 296304078 orden, 50051379 producto
              from dual
            union all
            Select 308682201 orden, 50057977 producto
              from dual
            union all
            Select 299222705 orden, 50079830 producto
              from dual
            union all
            Select 298899000 orden, 50104069 producto
              from dual
            union all
            Select 307707267 orden, 50242647 producto
              from dual
            union all
            Select 309486036 orden, 50328571 producto
              from dual
            union all
            Select 304205833 orden, 50374196 producto
              from dual
            union all
            Select 306513386 orden, 50702736 producto
              from dual
            union all
            Select 306513342 orden, 50702808 producto
              from dual
            union all
            Select 306513340 orden, 50702858 producto
              from dual
            union all
            Select 306513331 orden, 50702880 producto
              from dual
            union all
            Select 306513373 orden, 50702925 producto
              from dual
            union all
            Select 306513357 orden, 50702961 producto
              from dual
            union all
            Select 306513392 orden, 50702984 producto
              from dual
            union all
            Select 306513339 orden, 50703008 producto
              from dual
            union all
            Select 306513354 orden, 50703009 producto
              from dual
            union all
            Select 306513393 orden, 50703124 producto
              from dual
            union all
            Select 306513334 orden, 50703130 producto
              from dual
            union all
            Select 306513362 orden, 50703137 producto
              from dual
            union all
            Select 306513358 orden, 50703191 producto
              from dual
            union all
            Select 306513361 orden, 50703227 producto
              from dual
            union all
            Select 306513383 orden, 50703233 producto
              from dual
            union all
            Select 306513389 orden, 50703244 producto
              from dual
            union all
            Select 306513356 orden, 50703251 producto
              from dual
            union all
            Select 306513391 orden, 50703254 producto
              from dual
            union all
            Select 296129088 orden, 50706227 producto
              from dual
            union all
            Select 299467276 orden, 50706335 producto
              from dual
            union all
            Select 302986640 orden, 50706395 producto
              from dual
            union all
            Select 306423577 orden, 50734011 producto
              from dual
            union all
            Select 296131886 orden, 50744909 producto
              from dual
            union all
            Select 306513338 orden, 50744966 producto
              from dual
            union all
            Select 306513363 orden, 50745017 producto
              from dual
            union all
            Select 306513369 orden, 50745020 producto
              from dual
            union all
            Select 302986797 orden, 50747439 producto
              from dual
            union all
            Select 299467261 orden, 50747444 producto
              from dual
            union all
            Select 296129040 orden, 50788034 producto
              from dual
            union all
            Select 306513364 orden, 50788077 producto
              from dual
            union all
            Select 302906327 orden, 50788085 producto
              from dual
            union all
            Select 296129004 orden, 50788103 producto
              from dual
            union all
            Select 296129034 orden, 50788112 producto
              from dual
            union all
            Select 302986174 orden, 50788138 producto
              from dual
            union all
            Select 296129031 orden, 50788172 producto
              from dual
            union all
            Select 296013992 orden, 6592488 producto
              from dual
            union all
            Select 299995585 orden, 51001162 producto
              from dual
            union all
            Select 306513347 orden, 51014578 producto
              from dual
            union all
            Select 296131819 orden, 51014598 producto
              from dual
            union all
            Select 306513350 orden, 51014622 producto
              from dual
            union all
            Select 306513395 orden, 51014649 producto
              from dual
            union all
            Select 306513348 orden, 51014678 producto
              from dual
            union all
            Select 296131873 orden, 51014726 producto
              from dual
            union all
            Select 306910882 orden, 51472160 producto
              from dual
            union all
            Select 303289480 orden, 52221055 producto
              from dual) OT,
           or_order_activity ooa
     where OT.orden = ooa.order_id
       and OT.producto = ooa.product_id;

  rfcuDATOSOTPNO cuDATOSOTPNO%rowtype;

  sbStatus FM_Possible_NTL.Status%type := 'R';

BEGIN

  dbms_output.put_line('Inicia Registro PNO generados por oorder de lectura');

  for rfcuDATOSOTPNO in cuDATOSOTPNO loop
  
    nuOrdenPNO := rfcuDATOSOTPNO.orden;
  
    nuProducto := rfcuDATOSOTPNO.producto;
  
    OPEN cuDatosProducto(nuOrdenPNO, nuProducto);
    FETCH cuDatosProducto
      INTO rcDatosProducto;
    CLOSE cuDatosProducto;
  
    OPEN cuPNO_Activo(rcDatosProducto.product_id, nuOrdenPNO);
    FETCH cuPNO_Activo
      INTO rcPNO_Activo;
    CLOSE cuPNO_Activo;
  
    IF rcPNO_Activo.Possible_NTL_Id IS NULL THEN
    
      BEGIN
      
        IF rcDatosProducto.Product_Id = 2082418 THEN
          sbStatus := 'N';
        ELSE
          sbStatus := 'R';
        END IF;
      
        --/*
        rcFM_Possible_NTL.Possible_NTL_Id     := SEQ_FM_POSSIBLE_NTL_123873.NextVal;
        rcFM_Possible_NTL.Status              := sbStatus;
        rcFM_Possible_NTL.Product_Id          := rcDatosProducto.Product_Id;
        rcFM_Possible_NTL.Product_Type_Id     := rcDatosProducto.Product_Type_Id;
        rcFM_Possible_NTL.Geograp_Location_Id := rcDatosProducto.Geograp_Location_Id;
        rcFM_Possible_NTL.Address_Id          := rcDatosProducto.Address_Id;
        rcFM_Possible_NTL.Register_Date       := SYSDATE;
        rcFM_Possible_NTL.Discovery_Type_Id   := 4;
        rcFM_Possible_NTL.Order_id            := nuOrdenPNO;
        rcFM_Possible_NTL.Comment_            := 'GENERADO POR ACTIVDAD DE PNO POR CASO OSF-2219';
        rcFM_Possible_NTL.Value_              := 0;
        
        DAFM_Possible_NTL.InsRecord(rcFM_Possible_NTL);
        
        commit;
        --*/
        dbms_output.put_line('Orden [' || nuOrdenPNO ||
                             '] genera Proyecto PNO con estado ' ||
                             sbStatus);
      EXCEPTION
        WHEN OTHERS THEN
          rollback;
          dbms_output.put_line('Orden [' || nuOrdenPNO ||
                               '] NO genera Proyecto generado PNO');
      END;
    
    END IF;
  
  end loop;

  dbms_output.put_line('Termina Registro PNO generados por oorder de lectura');

EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('Error No Controlado: ' || sqlerrm);
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/