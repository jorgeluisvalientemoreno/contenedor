declare

  -- Nombre de este metodo
  csbMT_NAME VARCHAR2(30) := 'pCreaRegistroPNO';

  nuOrden open.or_order.order_id%TYPE;

  nuCausal open.or_order.causal_id%TYPE;

  nuOrdenPNO open.or_order.order_id%TYPE;

  --rcFM_Possible_NTL DAFM_Possible_NTL.styFM_Possible_NTL;

  CURSOR cuDatosProducto(inuOrden open.or_order_activity.order_id%TYPE) IS
    SELECT oa.product_id,
           pr.product_Type_Id,
           ad.Geograp_Location_id,
           ad.Address_Id
      FROM open.or_order_activity oa,
           open.pr_product        pr,
           open.ab_address        ad
     WHERE oa.order_id = inuOrden
       AND pr.product_id = oa.product_id
       AND ad.address_id = oa.address_id;
  /*SELECT oa.product_id,
        pr.product_Type_Id,
        ad.Geograp_Location_id,
        ad.Address_Id
   FROM open.or_order_activity oa,
        open.pr_product        pr,
        open.ab_address        ad
  WHERE oa.order_id = inuOrden
    AND pr.address_id = oa.address_id
    AND ad.address_id = oa.address_id
    AND pr.product_type_id = 7014
    and rownum = 1;*/

  rcDatosProducto cuDatosProducto%ROWTYPE;

  CURSOR cuPNO_Activo(inuProducto open.or_order_activity.product_id%TYPE,
                      inuOrden    open.or_order_activity.order_id%TYPE) IS
    SELECT *
      FROM open.fm_possible_ntl
     WHERE product_id = inuProducto
       AND order_id = inuOrden;

  rcPNO_Activo cuPNO_Activo%ROWTYPE;

  CURSOR cuDATOSOTPNO is
    with base as
     (select distinct oo.ORDER_ID        ot_pad,
                      oo.ORDER_STATUS_ID Estado_orden_pad,
                      oo.created_date    Fecha_Creacion
        from open.or_order_activity ooa, open.or_order oo
       where ooa.order_id = oo.order_id
         and oo.task_type_id in (12669)
         and oo.order_status_id not in (8, 12)
         and (select count(1)
                from open.ct_item_novelty cin
               where cin.items_id = ooa.activity_id) = 0)
    select base.*
      from base
     where (select count(1)
              from open.fm_possible_ntl a3
             where a3.order_id = base.ot_pad) = 0
       and base.Estado_orden_pad not in (8, 12);

  rfcuDATOSOTPNO cuDATOSOTPNO%rowtype;

BEGIN

  dbms_output.put_line('Inicia Registro PNO');

  for rfcuDATOSOTPNO in cuDATOSOTPNO loop
  
    -- Obtiene la orden que se esta procesando
    nuOrdenPNO := rfcuDATOSOTPNO.ot_pad;
  
    OPEN cuDatosProducto(nuOrdenPNO);
    FETCH cuDatosProducto
      INTO rcDatosProducto;
    CLOSE cuDatosProducto;
  
    OPEN cuPNO_Activo(rcDatosProducto.product_id, nuOrdenPNO);
    FETCH cuPNO_Activo
      INTO rcPNO_Activo;
    CLOSE cuPNO_Activo;
  
    --/*-- Si no hay ordenes relacionadas con registro en PNO se crea registro
    IF rcPNO_Activo.Possible_NTL_Id IS NULL THEN
      dbms_output.put_line('Orden [' || rfcuDATOSOTPNO.ot_pad ||
                           '] - Estado Orden[' ||
                           rfcuDATOSOTPNO.Estado_orden_pad ||
                           '] - Fecha Creacion[' ||
                           rfcuDATOSOTPNO.Fecha_creacion || ']');
      /*
      dbms_output.put_line('**************************************************
                            rcFM_Possible_NTL.Possible_NTL_Id     := SEQ_FM_POSSIBLE_NTL_123873.NextVal;
                            rcFM_Possible_NTL.Status              := ''R'';
                            rcFM_Possible_NTL.Product_Id          := ' ||rcDatosProducto.Product_Id || ';
                            rcFM_Possible_NTL.Product_Type_Id     := ' ||rcDatosProducto.Product_Type_Id || ';
                            rcFM_Possible_NTL.Geograp_Location_Id := ' ||rcDatosProducto.Geograp_Location_Id || ';
                            rcFM_Possible_NTL.Address_Id          := ' ||rcDatosProducto.Address_Id || ';
                            rcFM_Possible_NTL.Register_Date       := ' ||SYSDATE || ';
                            rcFM_Possible_NTL.Discovery_Type_Id   := 4;
                            rcFM_Possible_NTL.Order_id            := ' ||nuOrdenPNO || ';
                            rcFM_Possible_NTL.Comment_            := ''GENERADO POR ACTIVDAD DE PNO'';
                            rcFM_Possible_NTL.Value_              := 0;');
      --*/
    
      /*
      BEGIN
        rcFM_Possible_NTL.Possible_NTL_Id     := SEQ_FM_POSSIBLE_NTL_123873.NextVal;
        rcFM_Possible_NTL.Status              := 'R';
        rcFM_Possible_NTL.Product_Id          := rcDatosProducto.Product_Id;
        rcFM_Possible_NTL.Product_Type_Id     := rcDatosProducto.Product_Type_Id;
        rcFM_Possible_NTL.Geograp_Location_Id := rcDatosProducto.Geograp_Location_Id;
        rcFM_Possible_NTL.Address_Id          := rcDatosProducto.Address_Id;
        rcFM_Possible_NTL.Register_Date       := SYSDATE;
        rcFM_Possible_NTL.Discovery_Type_Id   := 4;
        rcFM_Possible_NTL.Order_id            := nuOrdenPNO;
        rcFM_Possible_NTL.Comment_            := 'GENERADO POR ACTIVDAD DE PNO POR CASO OSF-1426';
        rcFM_Possible_NTL.Value_              := 0;
      
        DAFM_Possible_NTL.InsRecord(rcFM_Possible_NTL);
      
        --rollback;
        commit;
        dbms_output.put_line('Orden [' || nuOrdenPNO ||
                             '] genera Proyecto generado PNO');
      EXCEPTION
        WHEN OTHERS THEN
          rollback;
          dbms_output.put_line('Orden [' || nuOrdenPNO ||
                               '] NO genera Proyecto generado PNO');
      END;
      */
    
    END IF;
    --*/
  
  end loop;

  dbms_output.put_line('Termina Registro PNO');

EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('Error No Controlado: ' || sqlerrm);
  
end;
