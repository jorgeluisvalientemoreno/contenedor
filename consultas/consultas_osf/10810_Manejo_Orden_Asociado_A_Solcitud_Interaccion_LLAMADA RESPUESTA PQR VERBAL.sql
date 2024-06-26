DECLARE

  --variables
  nuorden                        number;
  nuClasCausal                   number;
  nuCOD_CAU_GEN_OT_SOL_INT       open.ld_parameter.numeric_value%type;
  nuCOD_CAU_CER_OT_SOL_INT       open.ld_parameter.numeric_value%type;
  nuCOD_CAU_REG_OT_SOL_INT       open.ld_parameter.numeric_value%type;
  nuCOD_CAU_GEN_OT_CER_SOL_INT   open.ld_parameter.numeric_value%type;
  nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 open.ld_parameter.numeric_value%type;
  nuCAN_DIA_VAL_ACT_EN_SOL_INT_2 open.ld_parameter.numeric_value%type;
  nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 open.ld_parameter.numeric_value%type;

  sbcomentario                varchar2(4000);
  nuOrderId                   number := null;
  nuOrderActivityId           number := null;
  nuMotive                    number := null;
  product_id                  number := null;
  suscription_id              number := null;
  nuCOD_ACT_EDRCD_ASO_SOL_INT number;
  nuCOD_ACT_ASO_SOL_INT       number;

  sbERROR varchar2(4000) := NULL;

  nuCantDias number := null;

  --cursor
  --cursor permitir? obtener datos de la orden legalizada.
  cursor cuorder is
    select oo.task_type_id tipo_trabajo,
           oo.order_id     orden,
           ooa.package_id  Solicitud
      from open.or_order oo, open.or_order_activity ooa
     where oo.order_status_id in (0, 5)
       and oo.task_type_id =
           dald_parameter.fnuGetNumeric_Value('COD_TIP_TRA_ASO_SOL_INT',
                                              NULL)
       and oo.order_id = ooa.order_id
       AND OO.ORDER_ID = 325934619;

  rfcuorder cuorder%rowtype;

  --cursor permitir? obtener datos de la orden legalizada.
  cursor cuorderactivity(inuorder_id number) is
    select ooa.*
      from open.or_order_activity ooa
     where ooa.order_id = inuorder_id;

  rfcuorderactivity cuorderactivity%rowtype;

  --cursor permitir? obtener datos de la orden legalizada.
  cursor cuSolicitudPLUGIN(inupackage_id number) is
    select ooa.*
      from open.MO_PACKAGES           mp,
           open.OR_ORDER_ACTIVITY     ooa,
           open.OR_ORDER              oo,
           open.LDC_PROCEDIMIENTO_OBJ lpo
     where mp.CUST_CARE_REQUES_NUM =
           open.damo_packages.fsbgetcust_care_reques_num(inupackage_id,
                                                         null)
       and mp.package_id <> inupackage_id
       and mp.package_id = ooa.package_id
       and ooa.ORDER_ID = oo.order_id
       and oo.TASK_TYPE_ID = lpo.task_type_id
       and lpo.procedimiento =
           'LDC_PKSOLICITUDINTERACCION.LDC_PRGENOTLLARESPQRVER';
  --and lpo.activo = 'S';

  rfcuSolicitudPLUGIN cuSolicitudPLUGIN%rowtype;

  --cursor para comparar dato numerio si existe en paremtro tipo dato cadena
  cursor cuexistedanudaca(inudato number, isbdato varchar2) is
    select count(1) cantidad
      from dual
     where inudato IN
           (select to_number(column_value)
              from table(ldc_boutilities.splitstrings(isbdato, ',')));

  rfcuexistedanudaca cuexistedanudaca%rowtype;
  --TICKET 200-1329 LJLB -- se consultan comentarios de las ordenes 10810
  CURSOR cucomentarios IS
    select *
      from (SELECT ORDER_COMMENT comentarioot
              FROM open.or_order_comment
             WHERE order_id = nuorden
             order by ORDER_COMMENT_ID asc)
     where rownum = 1;

  nuerrorcode number; --TICKET 200-1329 LJLB -- se almacena codigo de error

BEGIN

  dbms_output.put_line('INICIO LDC_PKSOLICITUDINTERACCION.LDC_PRJOBADMORDSOLINT');

  for rfcuorder in cuorder loop
  
    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuorden := rfcuorder.orden;
    dbms_output.put_line('*****Numero de la Orden a legalizar [' ||
                         nuorden || ']');
  
    --paremtro de causal para cerrar la OT 10810 y generar orden 12579
    nuCOD_CAU_GEN_OT_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_CAU_GEN_OT_SOL_INT',
                                                                        null);
  
    dbms_output.put_line('**********Valor parametro COD_CAU_GEN_OT_SOL_INT [' ||
                         nuCOD_CAU_GEN_OT_SOL_INT || ']');
  
    if nvl(nuCOD_CAU_GEN_OT_SOL_INT, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro COD_CAU_GEN_OT_SOL_INT';
      RAISE ex.CONTROLLED_ERROR;
    end if;
  
    --parametro de causal para cerrar de forma automatica la orden y solicitud
    nuCOD_CAU_CER_OT_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_CAU_CER_OT_SOL_INT',
                                                                        null);
  
    dbms_output.put_line('**********Valor parametro COD_CAU_CER_OT_SOL_INT [' ||
                         nuCOD_CAU_CER_OT_SOL_INT || ']');
  
    if nvl(nuCOD_CAU_CER_OT_SOL_INT, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro COD_CAU_CER_OT_SOL_INT';
      RAISE ex.CONTROLLED_ERROR;
    end if;
  
    --parametro de causal para cerrar de forma automatica la orden y solicitud
    nuCOD_CAU_REG_OT_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_CAU_REG_OT_SOL_INT',
                                                                        null);
  
    dbms_output.put_line('**********Valor parametro COD_CAU_REG_OT_SOL_INT [' ||
                         nuCOD_CAU_REG_OT_SOL_INT || ']');
  
    if nvl(nuCOD_CAU_REG_OT_SOL_INT, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro COD_CAU_REG_OT_SOL_INT';
      RAISE ex.CONTROLLED_ERROR;
    end if;
  
    --parametro de causal para cerrar de forma automatica la orden y solicitud
    nuCOD_CAU_GEN_OT_CER_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_CAU_GEN_OT_CER_SOL_INT',
                                                                            null);
  
    dbms_output.put_line('**********Valor parametro COD_CAU_GEN_OT_CER_SOL_INT [' ||
                         nuCOD_CAU_GEN_OT_CER_SOL_INT || ']');
  
    if nvl(nuCOD_CAU_GEN_OT_CER_SOL_INT, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro COD_CAU_GEN_OT_CER_SOL_INT';
      RAISE ex.CONTROLLED_ERROR;
    end if;
  
    nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 := open.dald_parameter.fnuGetNumeric_Value('CAN_DIA_VAL_ACT_EN_SOL_INT_1',
                                                                              null);
  
    dbms_output.put_line('**********Valor parametro CAN_DIA_VAL_ACT_EN_SOL_INT_1 [' ||
                         nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 || ']');
  
    if nvl(nuCAN_DIA_VAL_ACT_EN_SOL_INT_1, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro CAN_DIA_VAL_ACT_EN_SOL_INT_1';
      RAISE ex.CONTROLLED_ERROR;
    end if;
  
    nuCAN_DIA_VAL_ACT_EN_SOL_INT_2 := open.dald_parameter.fnuGetNumeric_Value('CAN_DIA_VAL_ACT_EN_SOL_INT_2',
                                                                              null);
    dbms_output.put_line('**********Valor parametro CAN_DIA_VAL_ACT_EN_SOL_INT_2 [' ||
                         nuCAN_DIA_VAL_ACT_EN_SOL_INT_2 || ']');
  
    if nvl(nuCAN_DIA_VAL_ACT_EN_SOL_INT_2, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro CAN_DIA_VAL_ACT_EN_SOL_INT_2';
      RAISE ex.CONTROLLED_ERROR;
    end if;
  
    nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 := open.dald_parameter.fnuGetNumeric_Value('CAN_DIA_VAL_ACT_EN_SOL_INT_3',
                                                                              null);
  
    dbms_output.put_line('**********Valor parametro CAN_DIA_VAL_ACT_EN_SOL_INT_3 [' ||
                         nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 || ']');
  
    if nvl(nuCAN_DIA_VAL_ACT_EN_SOL_INT_3, 0) = 0 then
      sbERROR := 'Dato no valido en el parametro CAN_DIA_VAL_ACT_EN_SOL_INT_3';
      RAISE ex.CONTROLLED_ERROR;
    end if;
  
    --if nvl(nuClasCausal, 0) = 2 then
  
    --cursor permitir? obtener datos de la orden legalizada.
    open cuorderactivity(nuorden);
    fetch cuorderactivity
      into rfcuorderactivity;
    close cuorderactivity;
  
    open cuSolicitudPLUGIN(rfcuorderactivity.package_id);
    fetch cuSolicitudPLUGIN
      into rfcuSolicitudPLUGIN;
    close cuSolicitudPLUGIN;
  
    dbms_output.put_line('***************Solcitiud [' ||
                         rfcuSolicitudPLUGIN.package_id || ']');
    dbms_output.put_line('***************Solcitiud de Interaccion [' ||
                         rfcuorderactivity.package_id || ']');
    dbms_output.put_line('***************sysdate [' || sysdate || '] -
               open.damo_packages.fdtgetrequest_date(rfcuorderactivity.package_id)[' ||
                         open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id,
                                                               null) || ']');
  
    /*
    nuCantDias := round(sysdate -
                        open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id),
                        0);
    --*/
  
    dbms_output.put_line('***************Dias de diferencia [' ||
                         round(open.pkHolidayMgr.Fnugetnumofdaynonholiday(open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id,
                                                                                                                null),
                                                                          SYSDATE),
                               0) || ']');
  
    --if nuCantDias <= nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 then
    /*
    if round(sysdate -
             open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id),
             0) <= nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 then
      --*/
    --/*
    if open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id,
                                             null) is not null then
      -- OSF-444
      if round(open.pkHolidayMgr.Fnugetnumofdaynonholiday(open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id),
                                                          SYSDATE),
               0) >= nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 then
      
        /*
        elsif round(sysdate -
                    open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id),
                    0) > nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 then
        --*/
        dbms_output.put_line('***************nuCAN_DIA_VAL_ACT_EN_SOL_INT_3');
      
        --Inicio OSF-1188
        LDC_PKSOLICITUDINTERACCION.PrlegalizaOrden(nuorden,
                                                   rfcuorder.tipo_trabajo,
                                                   nuCOD_CAU_GEN_OT_CER_SOL_INT,
                                                   nuerrorcode,
                                                   sbERROR);
        if nuerrorcode = 0 then
          --commit;
          dbms_output.put_line('LDC_PKSOLICITUDINTERACCION.PrlegalizaOrden IF;');
          rollback;
        else
          dbms_output.put_line('LDC_PKSOLICITUDINTERACCION.PrlegalizaOrden ELSE rollback;');
          rollback;
        end if;
        --Fin OSF-1188
      
      elsif round(open.pkHolidayMgr.Fnugetnumofdaynonholiday(open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id,
                                                                                                   null) - 1,
                                                             SYSDATE),
                  0) Between nuCAN_DIA_VAL_ACT_EN_SOL_INT_1 and
            nuCAN_DIA_VAL_ACT_EN_SOL_INT_3 then
        --*/
      
        dbms_output.put_line('***************nuCAN_DIA_VAL_ACT_EN_SOL_INT_1');
      
        --incia proceso de creacion de nueva orden
        nuOrderId                   := null;
        nuOrderActivityId           := null;
        nuMotive                    := mo_bopackages.fnuGetInitialMotive(rfcuorderactivity.Package_Id);
        product_id                  := mo_bomotive.fnugetproductid(nuMotive);
        suscription_id              := mo_bomotive.fnugetsubscription(nuMotive);
        sbcomentario                := 'Orden generada al cerrar la orden ' ||
                                       nuorden;
        nuCOD_ACT_EDRCD_ASO_SOL_INT := open.dald_parameter.fnuGetNumeric_Value('COD_ACT_EDRCD_ASO_SOL_INT',
                                                                               null);
      
        if nvl(nuCOD_ACT_EDRCD_ASO_SOL_INT, 0) = 0 then
          sbERROR := 'Dato no valido en el parametro COD_ACT_EDRCD_ASO_SOL_INT';
          RAISE ex.CONTROLLED_ERROR;
        end if;
      
        or_boorderactivities.CreateActivity(nuCOD_ACT_EDRCD_ASO_SOL_INT,
                                            rfcuorderactivity.Package_Id,
                                            nuMotive,
                                            null,
                                            null,
                                            rfcuorderactivity.Address_Id,
                                            null,
                                            null,
                                            suscription_id,
                                            product_id,
                                            null,
                                            null,
                                            null,
                                            null,
                                            sbcomentario,
                                            null,
                                            null,
                                            nuOrderId,
                                            nuOrderActivityId,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null);
      
        dbms_output.put_line('Se creo la orden[' || nuOrderId ||
                             '] - Codigo Actiivdad[' || nuOrderActivityId || ']');
      
        --TICKET 200 1329 LJLB -- asignacion de comentarios de diferentes ordenes a la nueva orden generada
        FOR rfcucomentarios IN cucomentarios LOOP
          os_addordercomment(nuOrderId,
                             3,
                             substr(rfcucomentarios.comentarioot, 1, 1900),
                             nuerrorcode,
                             sbERROR);
          IF nuerrorcode <> 0 THEN
            RAISE ex.CONTROLLED_ERROR;
          END IF;
        
        END LOOP;
      
        --Inicio OSF-1188
        LDC_PKSOLICITUDINTERACCION.PrlegalizaOrden(nuorden,
                                                   rfcuorder.tipo_trabajo,
                                                   nuCOD_CAU_CER_OT_SOL_INT,
                                                   nuerrorcode,
                                                   sbERROR);
        if nuerrorcode = 0 then
          --commit;
          dbms_output.put_line('LDC_PKSOLICITUDINTERACCION.PrlegalizaOrden IF;');
          rollback;
        else
          dbms_output.put_line('LDC_PKSOLICITUDINTERACCION.PrlegalizaOrden ELSE rollback;');
          rollback;
        end if;
        --Fin OSF-1188
      
      end if;
    
    end if; --if nvl(open.damo_packages.fdtgetrequest_date(rfcuSolicitudPLUGIN.package_id,null)) <> 0 then
  
  end loop;

  dbms_output.put_line('FIN LDC_PKSOLICITUDINTERACCION.LDC_PRJOBADMORDSOLINT');

  --RAISE ex.CONTROLLED_ERROR;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    rollback;
    if sbERROR is null then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'ERROR SERVICIO LDC_PKSOLICITUDINTERACCION.LDC_PRJOBADMORDSOLINT');
    else
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       sbERROR);
    end if;
  when OTHERS then
    rollback;
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'ERROR SERVICIO LDC_PKSOLICITUDINTERACCION.LDC_PRJOBADMORDSOLINT');
  
END;
