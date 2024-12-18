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
      from (select 261209361 orden, 14512920 producto from dual union all
            select 261480139 orden, 14521202 producto from dual union all
            select 262075443 orden, 6634614 producto from dual union all
            select 265319021 orden, 24000475 producto from dual union all
            select 265319027 orden, 24000609 producto from dual union all
            select 267091914 orden, 24000208 producto from dual union all
            select 267091955 orden, 24000545 producto from dual union all
            select 267091978 orden, 24000775 producto from dual union all
            select 267091943 orden, 24000450 producto from dual union all
            select 267092188 orden, 50186743 producto from dual union all
            select 267092215 orden, 50784726 producto from dual union all
            select 267091907 orden, 24000147 producto from dual union all
            select 267091995 orden, 24000867 producto from dual union all
            select 267091996 orden, 24000872 producto from dual union all
            select 267092103 orden, 50000542 producto from dual union all
            select 267092086 orden, 24001466 producto from dual union all
            select 267092208 orden, 50549629 producto from dual union all
            select 267092178 orden, 50107867 producto from dual union all
            select 267092220 orden, 51302435 producto from dual union all
            select 267092000 orden, 24000891 producto from dual union all
            select 267092155 orden, 50094713 producto from dual union all
            select 267092221 orden, 51458537 producto from dual union all
            select 267092216 orden, 50918544 producto from dual union all
            select 267092192 orden, 50192430 producto from dual union all
            select 267092041 orden, 24001180 producto from dual union all
            select 267092013 orden, 24000973 producto from dual union all
            select 267092224 orden, 51486942 producto from dual union all
            select 267092174 orden, 50100330 producto from dual union all
            select 267092020 orden, 24001043 producto from dual union all
            select 267091984 orden, 24000815 producto from dual union all
            select 267091967 orden, 24000671 producto from dual union all
            select 267092137 orden, 50045839 producto from dual union all
            select 267092112 orden, 50005571 producto from dual union all
            select 267092136 orden, 50041914 producto from dual union all
            select 267092134 orden, 50040975 producto from dual union all
            select 267092098 orden, 24001580 producto from dual union all
            select 267091971 orden, 24000698 producto from dual union all
            select 267091979 orden, 24000780 producto from dual union all
            select 267091940 orden, 24000440 producto from dual union all
            select 267091942 orden, 24000448 producto from dual union all
            select 267092043 orden, 24001187 producto from dual union all
            select 267092087 orden, 24001473 producto from dual union all
            select 267091965 orden, 24000643 producto from dual union all
            select 267092225 orden, 51486945 producto from dual union all
            select 267092075 orden, 24001370 producto from dual union all
            select 267091966 orden, 24000649 producto from dual union all
            select 267091976 orden, 24000736 producto from dual union all
            select 267092070 orden, 24001359 producto from dual union all
            select 267091954 orden, 24000534 producto from dual union all
            select 267092150 orden, 50089669 producto from dual union all
            select 267091948 orden, 24000471 producto from dual union all
            select 297442982 orden, 14521202 producto from dual union all
            select 290526792 orden, 50315937 producto from dual union all
            select 291682759 orden, 1074662 producto from dual union all
            select 292816710 orden, 17009704 producto from dual union all
            select 303570570 orden, 8085584 producto from dual) OT,
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

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/