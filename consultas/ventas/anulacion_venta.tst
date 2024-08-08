PL/SQL Developer Test script 3.0
155
declare
inuPackagesId open.mo_packages.package_id%type:=184819085;


    --NC4298 Cursor
    cursor cuOrdenBloqueada(inuPackageId open.mo_packages.package_id%type,
                            sbTaskTypeId varchar2) is
      select count(*)
        from open.or_order_activity, open.or_order
       where or_order_activity.package_id = inuPackageId
         and or_order_activity.order_id = or_order.order_id
         and instr(sbTaskTypeId, to_char(or_order.task_type_id)) > 0
         and or_order.order_status_id in
             (open.DALD_PARAMETER.fnuGetNumeric_Value('COD_ESTA_BLOQ'));
    --Fin NC4298

    cursor cuPackages(inuPackageId open.mo_packages.package_id%type,
                      sbTaskTypeId varchar2) is
      select count(*)
        from open.or_order_activity, open.or_order
       where or_order_activity.package_id = inuPackageId
         and or_order_activity.order_id = or_order.order_id
         and instr(sbTaskTypeId, to_char(or_order.task_type_id)) > 0
         and or_order.order_status_id in
             (open.DALD_PARAMETER.fnuGetNumeric_Value('COD_ESTA_EJEC')--,
              --DALD_PARAMETER.fnuGetNumeric_Value('ESTADO_CERRADO')
              );


    --/*--Inicio SS 100-9883
    --Cursor para identificar al menos uan ot legalizada con el identificador
    --de causal de EXITO
    cursor cuOtCausalExito(inuPackageId open.mo_packages.package_id%type,
                           sbTaskTypeId varchar2) is
      select count(*)
        from open.or_order_activity, open.or_order
       where or_order_activity.package_id = inuPackageId
         and or_order_activity.order_id = or_order.order_id
         and instr(sbTaskTypeId, to_char(or_order.task_type_id)) > 0
         and or_order.order_status_id in
             (open.DALD_PARAMETER.fnuGetNumeric_Value('ESTADO_CERRADO'))
         and open.DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(or_order.causal_id, null) =
             open.DALD_PARAMETER.fnuGetNumeric_Value('COD_IDE_CLA_CAU_EXITO')
      ----Fin SS 100-9883*/
      ;

      sbTipoSolicitud VARCHAR2(500) := open.DALD_PARAMETER.fsbGetValue_Chain('LDC_TIPSOLICIANUL',  NULL);  --TICKET 0015 --se almacenan tipo de solicitud a validar
      sbEstadoOrden VARCHAR2(500) := open.DALD_PARAMETER.fsbGetValue_Chain('LDC_STAANULORD',  NULL);  --TICKET 0015 --se almacenan estado de las ordenes a validar
      csbCodigoCaso CONSTANT VARCHAR2(30) := '000-0015'; --TICKET 0015 --se alamcena codigo del caso

      --TICKET 0015 -- se valida si la solicitud tiene ordenes pendiente
      CURSOR cuGetOrdenesPend IS
      SELECT COUNT(*)
      FROM open.or_order_activity oa, open.or_order o, open.mo_packages s
      where s.package_id = inuPackagesId
        AND s.package_type_id in ( SELECT to_number(regexp_substr(sbTipoSolicitud,'[^,]+', 1, LEVEL))
                                     FROM   dual
                                     CONNECT BY regexp_substr(sbTipoSolicitud, '[^,]+', 1, LEVEL) IS NOT NULL)
        AND oa.package_id = s.package_id
        AND OA.order_id = O.order_id
        AND o.order_status_id IN ( SELECT to_number(regexp_substr(sbEstadoOrden,'[^,]+', 1, LEVEL))
                                   FROM   dual
                                   CONNECT BY regexp_substr(sbEstadoOrden, '[^,]+', 1, LEVEL) IS NOT NULL);

    sbPackagesType varchar2(2000);
    sbTaskTypeId   varchar2(2000);
    nuCount        number := 0;

  begin
    sbPackagesType := open.DALD_PARAMETER.fsbGetValue_Chain('ID_PKG_VALIDA_VENTA',
                                                       NULL);
    if instr(sbPackagesType,
             to_char(open.damo_packages.fnugetpackage_type_id(inuPackagesId))) > 0 then
      sbTaskTypeId := open.DALD_PARAMETER.fsbGetValue_Chain('ID_TT_VALIDA_VENTA',
                                                       NULL);

      

      --NC 4298
     
      open cuOrdenBloqueada(inuPackagesId, sbTaskTypeId);
      fetch cuOrdenBloqueada
        into nuCount;
      close cuOrdenBloqueada;
      if nuCount > 0 then
      
         dbms_output.put_line('cuOrdenBloqueada: '||inuPackagesId);
      end if;
      
      --fin NC4298

      --INICIO CASO 100-9983
      open cuOtCausalExito(inuPackagesId, sbTaskTypeId);
      fetch cuOtCausalExito
        into nuCount;
      close cuOtCausalExito;
      if nuCount > 0 then
        
        dbms_output.put_line('nuCount1: '||-1);
        return;
      --else
      --  return inuPackagesId;
      end if;
      --FIN CASO 100-9983

      open cuPackages(inuPackagesId, sbTaskTypeId);
      fetch cuPackages
        into nuCount;
      close cuPackages;
      if nuCount > 0 then

        dbms_output.put_line('nuCount2: '||-1);
        return;
      --else
      --  return inuPackagesId;
      end if;
      dbms_output.put_line('inuPackagesId: '||inuPackagesId);
      return;

      /*comentariado por CASO 100-9883
      open cuPackages(inuPackagesId, sbTaskTypeId);
      fetch cuPackages
        into nuCount;
      close cuPackages;
      if nuCount > 0 then
        return - 1;
      else
        return inuPackagesId;
      end if;
      --*/

    else
      --TICKET 0015 -- se valida si la entrega aplica para la gasera
      IF OPEN.fblAplicaentregaxcaso(csbCodigoCaso) THEN
         --TICKET 0015 --se valida si la soli tiene ordenes pendientes
        OPEN cuGetOrdenesPend;
        FETCH cuGetOrdenesPend INTO nuCount;
        CLOSE cuGetOrdenesPend;

        IF nuCount > 0 THEN
          dbms_output.put_line('nuCount3: '||-1);
          return;
        END IF;
      END IF;

      
      dbms_output.put_line('inuPackagesId2: '||inuPackagesId);
      return;
    end if;


  EXCEPTION
    WHEN OTHERS THEN
       RETURN;
  end;
0
0
