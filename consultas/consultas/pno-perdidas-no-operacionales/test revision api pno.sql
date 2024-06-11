declare

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_LEG_NOTIF_PNO
  Descripcion    : Cuando se legaliza la orden de PNO se valida si para el tipo de trabajo
                   combinado con la causal que se esta usando tiene una configuracion en equivalencia,
                   de ser asi se busca la orden equivalente en las solcitudes de atencion al cliente
                   para legalizarlo con la respectiva causal.
                   Igual cuando se legaliza una orden de servicio al cliente asociada a un proceso
                   de PNO busca si hay equivalencia configurada para realizar la legalizacion de la
                   orden de PNO.

  Autor          :  Jhon Jairo Soto
  Fecha          : 10/10/2013

  Parametros              Descripcion
  ============         ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

        onuErrorCode                number;
        osbErrorMessage             Varchar2(2000);
        nuCausalId                  open.or_order.causal_id%type;
        nucasualOTLeg               open.or_order.causal_id%type;
        nuPackageId                 open.mo_packages.package_id%type;
        nuPackage2                  open.mo_packages.package_id%type;
        nuTipoTrab                  open.OR_ORDER.TASK_TYPE_ID%TYPE;
        nuTipoTrabOTLeg             open.OR_ORDER.TASK_TYPE_ID%TYPE;
        nuOrderId                   open.or_order.order_id%type;
        nuCurrActivityId            open.or_order_activity.order_activity_id%type;
        inuPersonId                 open.ge_person.person_id%type;
        nutypePack                  open.MO_PACKAGES.PACKAGE_TYPE_ID%type;
        nuOperatingUnit             open.OR_ORDER.OPERATING_UNIT_ID%TYPE;
        nupackages_ori              open.MO_PACKAGES.PACKAGE_TYPE_ID%type;
        nuCausalWF                  open.ge_equivalenc_values.target_value%type;
        nuInstance                  number;
        sbEquivalencia              open.GE_EQUIVALENC_VALUES.ORIGIN_VALUE%type;
        nuval                       number;


        -- Tipo tabla para guardar el codigo de las solicitudes encontradas en los cursores CuOtAtenUsuarios y cuPackageAsso
        type tyrcpackages is record
            (
                nuCodPackages   OPEN.MO_PACKAGES.PACKAGE_ID%type
            );

        type tytbpackages is table of tyrcpackages index by binary_integer;
        tbPackages tytbpackages;
        nuIndex number;

    -- Cursor para obtener la solicitud de servicio al cliente (queja) relacionada con una
    -- de las ordenes de la solicitud de PNO - Actuacion administrativa
    cursor CuOtAtenUsuarios (inuPackage_id   in   open.mo_packages.package_id%type) is
        SELECT DISTINCT B.PACKAGE_ID
        FROM   OPEN.OR_ORDER_ACTIVITY A, OPEN.MO_PACKAGES B
        WHERE  A.PACKAGE_ID = inuPackage_id
        AND    B.ORDER_ID = A.ORDER_ID;


    reg_OtAtenUsuarios  CuOtAtenUsuarios%rowtype;

    -- Cursor para buscar ordenes en estado asignado que pertenezcan a solicitud y tipo de trabajo
    -- pasados como parametro
    cursor cuLegalizaOT (nuSolicitud in open.or_order_activity.package_id%type,
                         nuTrabajo in open.or_order_activity.task_type_id%type) is
        select distinct a.order_id, A.OPERATING_UNIT_ID
        from open.or_order_activity a, open.or_order b
        where A.ORDER_ID = B.ORDER_ID
        and A.PACKAGE_ID = nuSolicitud
        and A.TASK_TYPE_ID = nuTrabajo
        and B.ORDER_STATUS_ID = 5;

    reg_LegalizaOT cuLegalizaOt%rowtype;

    -- Cursor para buscar la configuracion (tipo_trabajo-causal-) en la tabla GE_EQUIVALENC_VALUES
    cursor cuConfig (sbValor in open.GE_EQUIVALENC_VALUES.ORIGIN_VALUE%type) is
        select a.target_value
        from OPEN.GE_EQUIVALENC_VALUES a
        where A.ORIGIN_VALUE = sbValor
        and A.equivalence_set_id = 50301;

    reg_config cuConfig%rowtype;

    -- Cursor para buscar solicitudes asociadas a una solicitud pasada como parametro
    cursor cuPackageAsso (inuPackage_id   in   open.mo_packages.package_id%type) is
        select DISTINCT A.PACKAGE_ID
        from   open.mo_packages_asso a
        where  package_id_asso = inuPackage_id
        union
        select DISTINCT A.PACKAGE_ID
        from open.mo_packages_asso a
        where package_id = inuPackage_id;


    reg_PackageAsso cuPackageAsso%rowtype;

BEGIN

    dbms_output.put_line('INICIA - LDC_LEG_NOTIF_PNO');

    nuOrderId := 26974194;--orden legalizada

    dbms_output.put_line('LDC_LEG_NOTIF_PNO - nuOrderId -->'||nuOrderId);

    nuTipoTrab :=  open.daor_order.fnugettask_type_id(nuOrderId);

    dbms_output.put_line('LDC_LEG_NOTIF_PNO - nuTipoTrab -->'||nuTipoTrab);

    nuPackageId  := open.ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                                    'ORDER_ID',
                                                                    'PACKAGE_ID',
                                                                    nuOrderId);

    nuTypePack := open.LDC_BOUTILITIES.FNUGETTIPOPACK(nuPackageId);

    dbms_output.put_line('LDC_LEG_NOTIF_PNO - nuPackageId -->'||nuPackageId);

    nuCausalId := open.daor_order.fnugetcausal_id(nuOrderId);

    dbms_output.put_line('LDC_LEG_NOTIF_PNO - nuCausalId -->'||nuCausalId);

    sbEquivalencia := nuTipoTrab||'-'||nuCausalId||'-';

    dbms_output.put_line('LDC_LEG_NOTIF_PNO - sbEquivalencia -->'||sbEquivalencia);


    if cuConfig%ISOPEN
    THEN
    CLOSE cuConfig;
    END IF;

    open cuConfig(sbEquivalencia);  -- Buscamos si para la combinacion de TT y Causal que estan legalizando hay configuracion en GE_EQUIVALENC_VALUES
    fetch cuConfig into reg_config;
        if cuConfig%found then
           -- Si hay configuracion separamos y obtenemos el tipo de trabajo para buscar si el producto tiene ordenes de ese tipo
           -- pendientes de cerrar, y la causal para legalizar la orden encontrada con dicha causal.
           nutipotrabOTLeg   := to_number(substr(reg_config.target_value,1,instr(reg_config.target_value,'-',1,1)-1));
           nucasualOTLeg     := to_number(substr(reg_config.target_value, instr(reg_config.target_value, '-', 1, 1) + 1, (instr(reg_config.target_value, '-', 1, 2)) - (instr(reg_config.target_value, '-', 1, 1) + 1)));

           dbms_output.put_line('LDC_LEG_NOTIF_PNO- Equivalencia encontrada, --> '||reg_config.target_value);

           if nuTypePack = 288 then   -- Si el tipo de solicitud es de PNO - ACTUACION ADMINISTRATIVA

              dbms_output.put_line('LDC_LEG_NOTIF_PNO - Condicional nuTypePack -->'||nuTypePack);

              if CuOtAtenUsuarios%ISOPEN
                THEN
                CLOSE CuOtAtenUsuarios;
              END IF;

                open CuOtAtenUsuarios(nuPackageId); -- Busca nueva solicitud relacionada mediante la orden por queja
                   fetch CuOtAtenUsuarios into reg_OtAtenUsuarios;
                        if CuOtAtenUsuarios%found then
                           dbms_output.put_line('LDC_LEG_NOTIF_PNO - Datos encontrados en cursor CuOtAtenUsuarios ');
                           -- Si encuentra llenamos tabla tbPackages con las solicitudes que se encuentren asociadas
                           if cuPackageAsso%ISOPEN
                           THEN
                           CLOSE cuPackageAsso;
                           END IF;

                           tbPackages(reg_OtAtenUsuarios.package_id).nuCodPackages := reg_OtAtenUsuarios.package_id; --Guardamos la primera solicitud
                           nuIndex := tbPackages.first;
                           dbms_output.put_line('LDC_LEG_NOTIF_PNO- Primera busqueda de solicitudes asociadas en las cuales buscaremos ordenes, --> solicitud: '||nuIndex);

                           open cuPackageAsso (reg_OtAtenUsuarios.package_id); -- Buscamos solicitudes asociadas a la solicitud de queja
                           loop
                           exit when cuPackageAsso%notfound;
                              dbms_output.put_line('LDC_LEG_NOTIF_PNO - Datos encontrados en cursor cuPackageAsso ');
                              fetch cuPackageAsso into reg_PackageAsso;
                              if tbPackages.exists(reg_PackageAsso.package_id) then
                                 null;
                              else
                                 tbPackages(reg_PackageAsso.package_id).nuCodPackages := reg_PackageAsso.package_id; --Guardamos otras solcitudes asociadas
                                 dbms_output.put_line('LDC_LEG_NOTIF_PNO- Otras Solicitudes Asociadas, --> solicitud: '||reg_PackageAsso.package_id);
                              END if;
                           end loop;
                           close cuPackageAsso;

                        end if;
                close CuOtAtenUsuarios;

                if nuIndex is not null then
                   nuIndex := tbPackages.first;
                end if;

                loop  -- Recorremos nuevamente todas las solicitudes hasta ahora guardadas en la tabla tbPackages para validar si hay mas solicitudes asociadas
                exit when nuIndex is null;
                  if tbPackages(nuIndex).nuCodPackages IS NOT NULL then

                       dbms_output.put_line('LDC_LEG_NOTIF_PNO- Recorrido de solicitudes, --> solicitud: '||tbPackages(nuIndex).nuCodPackages);

                       if cuPackageAsso%ISOPEN
                       THEN
                       CLOSE cuPackageAsso;
                       END IF;

                       open cuPackageAsso (tbPackages(nuIndex).nuCodPackages); -- Buscamos solicitudes asociadas a la solicitud de queja
                            fetch cuPackageAsso into reg_PackageAsso;
                            dbms_output.put_line('LDC_LEG_NOTIF_PNO- Solicitudes asociadas a la queja, --> solicitud: '||reg_PackageAsso.package_id);
                            if tbPackages.exists(reg_PackageAsso.package_id) then
                               null;
                            else
                               tbPackages(reg_PackageAsso.package_id).nuCodPackages := reg_PackageAsso.package_id;
                               dbms_output.put_line('LDC_LEG_NOTIF_PNO- Segunda busqueda de solicitudes asociadas en las cuales buscaremos ordenes, --> solicitud: '||reg_PackageAsso.package_id);
                            END if;
                       close cuPackageAsso;
                  END if;
                 nuIndex := tbPackages.next(nuIndex);
                end loop;

                   nuIndex := tbPackages.first;

                loop  -- Recorremos cada solicitud y buscamos ordenes segun la configuracion de equivalencia (tipo_trabajo-Causal-)
                exit when nuIndex is null;

                  dbms_output.put_line('LDC_LEG_NOTIF_PNO- Recorremos cada solicitud y buscamos ordenes segun la configuracion de equivalencia, Solicitud --> '||nuIndex);

                  if tbPackages(nuIndex).nuCodPackages IS NOT NULL then

                    if cuLegalizaOT%ISOPEN
                    THEN
                    CLOSE cuLegalizaOT;
                    END IF;
                    dbms_output.put_line('LDC_LEG_NOTIF_PNO- Si encuentra ordenes se procesan para legalizar, --> solicitud: '||tbPackages(nuIndex).nuCodPackages);
                    open cuLegalizaOT (tbPackages(nuIndex).nuCodPackages,nutipotrabOTLeg);
                    fetch cuLegalizaOT into reg_legalizaOT;
                        if cuLegalizaOT%found then
                           dbms_output.put_line('LDC_LEG_NOTIF_PNO- Se encontro orden --> : '||reg_legalizaOT.order_id);
                           begin
                              select person_id into inuPersonId
                              from open.or_oper_unit_persons
                              where operating_unit_id = reg_legalizaOT.operating_unit_id and rownum = 1;
                              dbms_output.put_line('LDC_LEG_NOTIF_PNO- inuPersonId  --> : '||inuPersonId);
                           exception
                           when no_data_found then
                           inuPersonId := 4068;
                           dbms_output.put_line('LDC_LEG_NOTIF_PNO- Dato no encontrado  --> : '||inuPersonId);
                           when others then
                           dbms_output.put_line('LDC_LEG_NOTIF_PNO- Error  --> : '||sqlerrm);
                           end;
                           --inuPersonId := daor_order_person.fnugetperson_id(reg_legalizaOT.operating_unit_id,reg_legalizaOT.order_id);
                            dbms_output.put_line('LDC_LEG_NOTIF_PNO- Unidad operativa - person --> : '||reg_legalizaOT.operating_unit_id||'-'||inuPersonId);
              dbms_output.put_line('ldc_closeOrder');
                           --ldc_closeOrder(reg_legalizaOT.order_id,nucasualOTLeg,inuPersonId,reg_legalizaOT.operating_unit_id);
                        end if;
                    close cuLegalizaOT;

                  END if;
                 nuIndex := tbPackages.next(nuIndex);
                end loop;

           else   -- De lo contrario seria una solicitud de servicio al cliente

                nupackage2 := nuPackageid;

                if nuTypePack = 268  then-- Si es tipo interaccion obtenemos la solicitud asociada

                   begin

                      select a.package_id
                      into nupackage2
                      from open.mo_packages_asso a
                      where A.PACKAGE_ID_ASSO = nuPackageId;
                      dbms_output.put_line('LDC_LEG_NOTIF_PNO- Solicitud Asociada a la interaccion. nupackage2 --> : '||nupackage2);
                   exception
                      when others then
                      nuPackage2 := -1;
                      dbms_output.put_line('LDC_LEG_NOTIF_PNO- Solicitud Asociada a la interaccion no encontrada. nupackage2 --> : '||nupackage2);
                   end;

                end if;

              -- Buscamos orden relacionada al paquete y buscar el package origen (PNO) de la queja
                begin
                    select A.PACKAGE_ID into nupackages_ori
                    from OPEN.OR_ORDER_ACTIVITY A
                    WHERE A.ORDER_ID = OPEN.DAMO_PACKAGES.fnugetorder_id(nuPackage2,null)
                    AND OPEN.DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(A.PACKAGE_ID,NULL) = 288;
                    dbms_output.put_line('LDC_LEG_NOTIF_PNO- Solicitud Origen de PNO. nupackages_ori --> : '||nupackages_ori);
                exception
                when no_data_found then
                nupackages_ori := -1;
                dbms_output.put_line('LDC_LEG_NOTIF_PNO- Solicitud origen PNO no encontrada - nupackages_ori  --> : '||nupackages_ori);
                end;

                if cuLegalizaOT%ISOPEN
                THEN
                CLOSE cuLegalizaOT;
                END IF;

               if nupackages_ori <> -1 then
                    open cuLegalizaOT (nupackages_ori,nutipotrabOTLeg);
                    fetch cuLegalizaOT into reg_legalizaOT;
                    if cuLegalizaOT%found then
                        begin
                        select person_id into inuPersonId
                        from open.or_oper_unit_persons
                        where operating_unit_id = reg_legalizaOT.operating_unit_id and rownum = 1;
                        dbms_output.put_line('LDC_LEG_NOTIF_PNO- inuPersonId  --> : '||inuPersonId);
                        exception
                        when no_data_found then
                        inuPersonId := -1;
                        dbms_output.put_line('LDC_LEG_NOTIF_PNO- Dato no encontrado  --> : '||inuPersonId);
                        when others then
                        dbms_output.put_line('LDC_LEG_NOTIF_PNO- Error  --> : '||sqlerrm);
                        end;
            dbms_output.put_line('ldc_closeOrder');
                        --ldc_closeOrder(reg_legalizaOT.order_id,nucasualOTLeg,inuPersonId,reg_legalizaOT.operating_unit_id);
                    end if;
                    close cuLegalizaOT;
               end if;
           end if;

            --ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Fin de ejecucion LDC_LEG_NOTIF_PNO 1');
            --raise ex.CONTROLLED_ERROR;

            -- Obtiene la causal de WF
            SELECT target_value
            INTO nuCausalWF
            FROM (
                    SELECT target_value
                    FROM open.ge_equivalenc_values
                    WHERE equivalence_set_id = 218
                    AND origin_value = nucasualOTLeg
                    AND rownum = 1
                  UNION ALL
                    SELECT '-1'  FLAG_VALIDATE FROM dual
                 )
            WHERE rownum = 1;

            dbms_output.put_line('LDC_LEG_NOTIF_PNO- nuCausalWF  --> : '||nuCausalWF);

            -- Obtiene la instance del Flujo
            begin
                SELECT  instance_id
                INTO nuInstance
                FROM open.or_order_activity
                WHERE ORDER_id = reg_legalizaOT.order_id
                AND rownum = 1;
            exception
            when others then
                nuInstance := -1;
            end;

            dbms_output.put_line('LDC_LEG_NOTIF_PNO- nuInstance  --> : '||nuInstance);

            -- Valida si tiene configurada Regeneracion que detiene el flujo.
            SELECT count(*)
            INTO nuVal
            FROM open.or_regenera_activida
            WHERE actividad in (SELECT activity_id FROM open.or_order_activity WHERE order_id in (reg_legalizaOT.order_id))
                AND or_regenera_activida.id_causal = nucasualOTLeg
                AND or_regenera_activida.actividad_wf = 'Y';

            dbms_output.put_line('LDC_LEG_NOTIF_PNO- nuVal  --> : '||nuVal);

            -- Envio de Actividad a la Cola de WF
            IF nuCausalWF <> -1 AND nuVal = 0  and nuInstance <> -1 THEN
                --wf_boanswer_receptor.answerreceptorbyqueue(nuInstance,to_number(nuCausalWF));
                dbms_output.put_line('LDC_LEG_NOTIF_PNO- wf_boanswer_receptor.answerreceptorbyqueue()  --> : '||nuInstance||','||nuCausalWF);
            END IF;
        end if;

    close cuConfig;

       dbms_output.put_line('FIN LDC_LEG_NOTIF_PNO ');
            --ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Fin de ejecucion LDC_LEG_NOTIF_PNO 2');
            --raise ex.CONTROLLED_ERROR;

  EXCEPTION
    when "OPEN".ex.CONTROLLED_ERROR then
      raise;
    when others then
      "OPEN".Errors.setError;
      raise "OPEN".ex.CONTROLLED_ERROR;

END;
