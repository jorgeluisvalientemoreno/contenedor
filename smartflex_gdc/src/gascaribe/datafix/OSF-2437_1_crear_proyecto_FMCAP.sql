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
      from (select 302266694 orden, 50509393 producto from dual) OT,
           or_order_activity ooa
     where OT.orden = ooa.order_id
       and OT.producto = ooa.product_id;

  rfcuDATOSOTPNO cuDATOSOTPNO%rowtype;

  sbStatus FM_Possible_NTL.Status%type := 'R';

BEGIN

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
        rcFM_Possible_NTL.Comment_            := 'GENERADO POR ACTIVDAD DE PNO POR CASO OSF-2437';
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

EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('Error No Controlado: ' || sqlerrm);
  
end;
/

declare

  CURSOR cuDATOSOTPNO is
    select OT.PNO, OT.orden, OT.producto
      from (select 510395 PNO, 303399144 orden, 8085584 producto
              from dual
            union all
            select 510392 PNO, 272575015 orden, 17009704 producto
              from dual
            union all
            select 510394 PNO, 268163855 orden, 1074662 producto
              from dual
            union all
            select 510393 PNO, 297070833 orden, 14521202 producto
              from dual) OT,
           open.or_order_activity ooa
     where OT.orden = ooa.order_id
       and OT.producto = ooa.product_id;

  rfcuDATOSOTPNO cuDATOSOTPNO%rowtype;

BEGIN

  for rfcuDATOSOTPNO in cuDATOSOTPNO loop
  
    BEGIN
    
      --/*
      update FM_Possible_NTL
         set FM_Possible_NTL.Order_Id = rfcuDATOSOTPNO.orden
       where FM_Possible_NTL.Possible_NTL_Id = rfcuDATOSOTPNO.PNO
         and FM_Possible_NTL.product_id = rfcuDATOSOTPNO.producto;
      
      commit;
      --*/
      dbms_output.put_line('Orden [' || rfcuDATOSOTPNO.orden ||
                           '] se actualizo en el proyecto PNO ' ||
                           rfcuDATOSOTPNO.PNO);
    EXCEPTION
      WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Orden [' || rfcuDATOSOTPNO.orden ||
                             '] NO se actualizo en el proyecto PNO ' ||
                             rfcuDATOSOTPNO.PNO);
    END;
  
  end loop;

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