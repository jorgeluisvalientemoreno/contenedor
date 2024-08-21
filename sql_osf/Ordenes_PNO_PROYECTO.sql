declare

  nuOrden open.or_order.order_id%TYPE;

  nuCausal open.or_order.causal_id%TYPE;

  nuOrdenPNO open.or_order.order_id%TYPE;

  nuProducto open.or_order_activity.product_id%TYPE;

  rcFM_Possible_NTL open.DAFM_Possible_NTL.styFM_Possible_NTL;

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
      from (select 303933435 orden, 1505583 producto from dual union all
select 264214053 orden, 6087729 producto from dual union all
select 263966945 orden, 3058954 producto from dual union all
select 252508179 orden, 52059705 producto from dual union all
select 251492384 orden, 6126636 producto from dual union all
select 251492296 orden, 9056128 producto from dual union all
select 251492221 orden, 1155509 producto from dual union all
select 249717643 orden, 50257759 producto from dual union all
select 248383941 orden, 50065345 producto from dual union all
select 248383783 orden, 50065203 producto from dual union all
select 247569513 orden, 6506537 producto from dual union all
select 245635036 orden, 6526573 producto from dual union all
select 244692470 orden, 52010402 producto from dual union all
select 244086372 orden, 13002430 producto from dual union all
select 242363023 orden, 14525754 producto from dual union all
select 242342774 orden, 50666423 producto from dual union all
select 236749517 orden, 17121503 producto from dual union all
select 236302957 orden, 6588448 producto from dual union all
select 236173449 orden, 6638806 producto from dual union all
select 231381652 orden, 6522344 producto from dual union all
select 231036386 orden, 1022740 producto from dual 
) OT,
           open.or_order_activity ooa
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
      
        /*
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
