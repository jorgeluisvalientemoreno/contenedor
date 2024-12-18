CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKLEMADOPA IS
  /***********************************************************************************************************
  Propiedad Intelectual de Gases del Caribe S.A E.S.P

   Funcion     : LDCI_PKLEMADOPA
   Descripcion : Paquete para la forma .net encargada de la legalizaci?n masiva de ordenes de revisi?n de documentos de pagare.
   Autor       : Roberto Parra
   Fecha       : 28-02-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
   10-08-18            Daniel Valiente    Se modifico la subconsulta del query principal para que muestre
                                          el Deudor. Caso 200-2071
  ************************************************************************************************************/
  FUNCTION fnConsultaLEMADOPA(inususc      in SUSCRIPC.SUSCCODI%type,
                              inuord       in OR_ORDER.ORDER_ID%type,
                              inupack      in MO_PACKAGES.PACKAGE_ID%type,
                              idtfeccreini in date,
                              idtfeccrefin in date,
                             inuprovcont  in or_operating_unit.operating_unit_id%type)
    return pkConstante.tyRefCursor;
  -- fnConsulCausLEMADOPA
  FUNCTION fnConsulCausLEMADOPA return pkConstante.tyRefCursor;
  -- fnActualizaLEMADOPA
  FUNCTION fnActualizaLEMADOPA(inuord    in OR_ORDER.ORDER_ID%type,
                               inuCaus   in ge_causal.causal_id%type,
                               isbObserv in varchar2) return number;

  --Inicio CASO 200-1880
 /***********************************************************************************************************
  Propiedad Intelectual de JM-Gesti?n inform?tica

   Funcion     : frfLVProvCont
   Descripcion : Servicio encargado Retornar las registros relacionados con el Unidad Operativa
                 tipo proveedor y contratista
   Autor       : Roberto Parra
   Fecha       : 25-05-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  FUNCTION frfLVProvCont return pkConstante.tyRefCursor;

  /**************************************************************************
  Funcion     :  FnuValidaCausal
  Descripcion :  Retorna un valor indicado si la causal es de EXITO o FALLO en LEMADOPA
                 1 - La Causal es de EXITO
                 2 - La Causal es de FALLO
  Autor       :  Jorge Valiente
  Fecha       :  25-05-2018

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FnuValidaCausal(inuCausal in number) RETURN NUMBER;
  --Fin CASO 200-1880

END LDCI_PKLEMADOPA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKLEMADOPA IS
  /***********************************************************************************************************
  Propiedad Intelectual de Gases del Caribe S.A E.S.P

   Funcion     : LDCI_PKLEMADOPA
   Descripcion : Paquete para la forma LEMADOPA encha en .net encargada de la legalizacion
                 masiva de ordenes de revision de documentos de pagare.
   Autor       : Roberto Parra
   Fecha       : 28-02-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  /***********************************************************************************************************
  Propiedad Intelectual de JM-Gesti?n inform?tica

   Funcion     : fnConsultaLEMADOPA
   Descripcion : Servicio encargado Retornar las ordenes a legalizar teniendo en cuenta el tipo de solicitud.
   Autor       : Roberto Parra
   Fecha       : 28-02-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
   10-08-18            Daniel Valiente    Se modifico la subconsulta del query principal para que muestre
                                          el Deudor. Caso 200-2071
  ************************************************************************************************************/
 FUNCTION fnConsultaLEMADOPA(inususc      in SUSCRIPC.SUSCCODI%type,
                             inuord       in OR_ORDER.ORDER_ID%type,
                             inupack      in MO_PACKAGES.PACKAGE_ID%type,
                             idtfeccreini in date,
                             idtfeccrefin in date,
                             inuprovcont  in or_operating_unit.operating_unit_id%type)
   return pkConstante.tyRefCursor is
   sbQuery  varchar2(32767);
   rfcursor pkConstante.tyRefCursor;
 BEGIN
   ut_trace.trace('LDC_FNCONSULTAORANPU : Construccion del select', 1);

   --200-2071
   --Se agrego a la subconsulta AND LPP.PROMISSORY_TYPE = ''D''
   sbQuery := 'select o.order_id ORDEN,
       --open.DAGE_SUBSCRIBER.FSBGETSUBSCRIBER_NAME(open.PKTBLSUSCRIPC.FNUGETSUSCCLIE(nvl(oa.subscription_id,-1))) Nombre,
       (select lpp.debtorname || '' '' || LPP.LAST_NAME  from ld_promissory_pu  lpp WHERE LPP.PACKAGE_ID = oa.package_id AND LPP.PROMISSORY_TYPE = ''D''  AND ROWNUM = 1)  Nombre,
       oa.package_id SOLICITUD,
       oa.subscription_id CONTRATO,
       --o.created_date FECHA_DE_CREACION,
       open.damo_packages.fdtgetrequest_date(oa.package_id ,null) FECHA_DE_CREACION,
       o.assigned_date FECHA_DE_ASIGNACION,
       open.daor_operating_unit.fsbgetname(open.damo_packages.fnugetoperating_unit_id(oa.package_id ,null) ,null) PROVCONT
  from open.or_order o, open.or_order_activity oa
 where o.order_id = oa.order_id
   and (oa.order_id, oa.package_id) in
       (select max(oa1.order_id), oa1.package_id
          from open.or_order_activity oa1,
               open.or_order          o1,
               open.mo_packages       m
         where oa1.package_id = m.package_id
           and m.package_type_id =
               Open.Dald_parameter.fnuGetNumeric_Value(''COD_TIPACK_FNB_PAGARE'')
           and o1.order_id = oa1.order_id
           and o1.order_status_id =
               Open.Dald_parameter.fnuGetNumeric_Value(''COD_ESTADO_ASIGNADA_OT'')
           and oa1.task_type_id =
               Open.Dald_parameter.fnuGetNumeric_Value(''TIPO_TRAB_PAGA_UNIC'')';

   ut_trace.trace('LDC_FNCONSULTAORANPU : Se validan campos a agregar', 1);
   --Contrato
   if (inususc is not null) then
     ut_trace.trace('LDC_FNCONSULTAORANPU : Se agrega el contrato', 1);
     sbQuery := sbQuery || 'and oa1.subscription_id =' || inususc;
   end if;
   --Orden
   if (inuord is not null) then
     ut_trace.trace('LDC_FNCONSULTAORANPU : Se agrega la orden', 1);
     sbQuery := sbQuery || 'and o1.order_id =' || inuord;
   end if;
   --solicitud
   if (inupack is not null) then
     ut_trace.trace('LDC_FNCONSULTAORANPU : Se agrega la solicitud', 1);
     sbQuery := sbQuery || 'and oa1.package_id =' || inupack;
   end if;
   --Fecha inicial
   if (idtfeccreini is not null) then
     ut_trace.trace('LDC_FNCONSULTAORANPU : Se agrega la Fecha inicial', 1);
     sbQuery := sbQuery || 'and trunc(m.request_date) >= to_date(''' ||
                idtfeccreini || ''')';
   end if;
   --Fecha Final
   if (idtfeccrefin is not null) then
     ut_trace.trace('LDC_FNCONSULTAORANPU : Se agrega la Fecha final', 1);
     sbQuery := sbQuery || 'and trunc(m.request_date) <= to_date(''' ||
                idtfeccrefin || ''')';
   end if;
   --Ultima parte de la consulta
   ut_trace.trace('LDC_FNCONSULTAORANPU : se agrega la ultima parte de la consulta',
                  1);
   sbQuery := sbQuery || 'group by oa1.package_id)';

   --Inicio CASO 200-1880
   --Fecha Final
   if (inuprovcont is not null) then
     ut_trace.trace('LDC_FNCONSULTAORANPU : Se agrega el proveedor / contratista',
                    1);
     sbQuery := sbQuery ||
                --' and nvl(open.damo_packages.fnugetoperating_unit_id(oa.package_id ,null),0) = ' ||
                ' and nvl(open.daor_operating_unit.fnugetcontractor_id(open.damo_packages.fnugetoperating_unit_id(oa.package_id, null),null),0) = ' ||
                inuprovcont;
   end if;
   --Fin CASO 200-1880

   ut_trace.trace('Ejecucion LDC_FNCONSULTAORANPU sbQuery Final => ' ||
                  sbQuery,
                  1);
   --Ejecutamos el Select haciendo uso de un cursor
   dbms_output.put_line(sbQuery);
   OPEN rfCursor FOR sbQuery;

   ut_trace.trace('LDC_FNCONSULTAORANPU : Finaliza Funcion', 1);
   -- Retornamos el Cursor
   return rfCursor;
   ut_trace.trace('LDC_FNCONSULTAORANPU : Se retorna cursor', 1);
 EXCEPTION
   When ex.CONTROLLED_ERROR then
     raise ex.CONTROLLED_ERROR;
   When others then
     Errors.setError;
     raise ex.CONTROLLED_ERROR;
 END fnConsultaLEMADOPA;
  /***********************************************************************************************************
  Propiedad Intelectual de JM-Gesti?n inform?tica

   Funcion     : fnConsultaLEMADOPA
   Descripcion : Servicio encargado Retornar las ordenes a legalizar teniendo en cuenta el tipo de solicitud.
   Autor       : Roberto Parra
   Fecha       : 28-02-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  FUNCTION fnConsulCausLEMADOPA return pkConstante.tyRefCursor is
    sbQuery  varchar2(32767);
    rfcursor pkConstante.tyRefCursor;
  BEGIN
    ut_trace.trace('LDC_FNCONSULTAORANPU : Construccion del select', 1);

    sbQuery := 'select ot.causal_id id, (select g.description
                         from ge_causal g
                         where g.causal_id = ot.causal_id) description
  from or_task_type_causal ot
  where ot.task_type_id=open.dald_parameter.fnuGetNumeric_Value(''TIPO_TRAB_PAGA_UNIC'')';
    --Ejecutamos el Select haciendo uso de un cursor
    OPEN rfCursor FOR sbQuery;

    ut_trace.trace('LDC_FNCONSULTAORANPU : Finaliza Funcion', 1);
    -- Retornamos el Cursor
    return rfCursor;
    ut_trace.trace('LDC_FNCONSULTAORANPU : Se retorna cursor', 1);
  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnConsulCausLEMADOPA;
  /***********************************************************************************************************
  Propiedad Intelectual de JM-Gesti?n inform?tica

   Funcion     : fnConsultaLEMADOPA
   Descripcion : Servicio encargado Retornar las ordenes a legalizar teniendo en cuenta el tipo de solicitud.
   Autor       : Roberto Parra
   Fecha       : 28-02-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  FUNCTION fnActualizaLEMADOPA(inuord    in OR_ORDER.ORDER_ID%type,
                               inuCaus   in ge_causal.causal_id%type,
                               isbObserv in varchar2) return number is

    sbQuery         varchar2(32767);
    nuError         number(10); --Numero del error del procedimiento que legaliza la orden
    sbMessage       varchar(2000); --Mensaje de error del procedimiento que legaliza la orden
    onuerrorcode    number(10); --Numero del error del procedimiento que mueve el flujo
    osberrormessage varchar(2000); --Mensaje de error del procedimiento que mueve el flujo

    CURSOR rfCursor IS

      SELECT oa.package_id,
             o.operating_unit_id,
             o.order_id ORDEN,
             oa.package_id SOLICITUD,
             oa.subscription_id CONTRATO
        FROM or_order o, or_order_activity oa
       where o.order_id = oa.order_id
         and o.order_id = inuord;
  BEGIN

    ------------------------------------------------
    -- User code
    ------------------------------------------------

    for reg in rfCursor loop
      --Se legaliza la orden
      os_legalizeorderallactivities(inuord,
                                    inuCaus,
                                    LD_BOUtilFlow.fnuGetPersonToLegal(reg.operating_unit_id),
                                    sysdate,
                                    sysdate,
                                    isbObserv, --se inserta la observacion
                                    null,
                                    nuError,
                                    sbMessage);
      if (nuError <> 0) then
        --Se inserta el error en una tabla
        LDC_PROINSERTAERRPAGAUNI(reg.contrato,
                                 reg.orden,
                                 reg.solicitud,
                                 null,
                                 null,
                                 nuError,
                                 sbMessage,
                                 'LEMADOPA');
        rollback;
      else
        /*  --Se atiende la solicitud
        CF_BOActions.AttendRequest(reg.package_id);
        --instruccion para mover el flujo
         LD_BOFlowFNBPack.procValidateFlowMove(8241,--Nuemero de la accion
                                             reg.solicitud,
                                             onuerrorcode,
                                             osberrormessage);
        */
        commit;
      end if;
    end loop;
    return nuError;
  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnActualizaLEMADOPA;

  --Inicio CASO 200-1880
 /***********************************************************************************************************
  Propiedad Intelectual de JM-Gesti?n inform?tica

   Funcion     : frfLVProvCont
   Descripcion : Servicio encargado Retornar las registros relacionados con el Unidad Operativa
                 tipo proveedor y contratista
   Autor       : Roberto Parra
   Fecha       : 25-05-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  FUNCTION frfLVProvCont return pkConstante.tyRefCursor is
    sbQuery  varchar2(32767);
    rfcursor pkConstante.tyRefCursor;
  BEGIN
    ut_trace.trace('Inicio LDC_FNCONSULTAORANPU.frfLVProvCont', 1);

    /*sbQuery := 'select oou.operating_unit_id ID, oou.name DESCRIPTION
                  from open.or_operating_unit oou
                 where oou.oper_unit_classif_id in
                       (nvl(open.DALD_PARAMETER.fnuGetNumeric_Value(''CONTRACTOR_SALES_FNB'',
                                                                    null),
                            0),
                        nvl(open.DALD_PARAMETER.fnuGetNumeric_Value(''SUPPLIER_FNB'', null), 0))';*/

      sbQuery := 'select gc.id_contratista ID, gc.nombre_contratista DESCRIPTION
                  from ge_contratista gc
                 where gc.id_contratista in
                       (select oou.contractor_id
                          from open.or_operating_unit oou
                         where oou.oper_unit_classif_id in
                               (nvl(open.DALD_PARAMETER.fnuGetNumeric_Value(''CONTRACTOR_SALES_FNB'',
                                                                            null),
                                    0),
                                nvl(open.DALD_PARAMETER.fnuGetNumeric_Value(''SUPPLIER_FNB'',
                                                                            null),
                                    0))
                           and oou.contractor_id is not null
                         group by oou.contractor_id)
                 order by 2';
    --Ejecutamos el Select haciendo uso de un cursor
    dbms_output.put_line(sbQuery);

    OPEN rfCursor FOR sbQuery;

    ut_trace.trace('Fin LDC_FNCONSULTAORANPU.frfLVProvCont', 1);
    -- Retornamos el Cursor
    return rfCursor;

  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END frfLVProvCont;

  /**************************************************************************
  Funcion     :  FnuValidaCausal
  Descripcion :  Retorna un valor indicado si la causal es de EXITO o FALLO en LEMADOPA
                 1 - La Causal es de EXITO
                 2 - La Causal es de FALLO
  Autor       :  Jorge Valiente
  Fecha       :  25-05-2018

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FnuValidaCausal(inuCausal in number) RETURN NUMBER

   IS

    nuEXITOFALLO number := 0;

    --Obtiene el numero de facturas
    cursor cuCAUSALI is
      select gc.class_causal_id nuExitoFallo
        from open.GE_CAUSAL gc
       where gc.causal_id = inuCausal;

    rfcuCAUSALI cuCAUSALI%rowtype;

  BEGIN

    ut_trace.trace('INICIO LDCI_PKLEMADOPA.FnuValidaCausal', 10);

    open cuCAUSALI;
    fetch cuCAUSALI
      into rfcuCAUSALI;
    if cuCAUSALI%found then
      nuEXITOFALLO := nvl(rfcuCAUSALI.nuExitoFallo, 0);
    else
      nuEXITOFALLO := 0;
    end if;
    close cuCAUSALI;

    ut_trace.trace('FIN LDCI_PKLEMADOPA.FnuValidaCausal', 10);

    return nuEXITOFALLO;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      --raise;
      return 0;
    when others then
      Errors.setError;
      --raise ex.CONTROLLED_ERROR;
      return 0;
  END FnuValidaCausal;
  --Fin CASO 200-1880

END LDCI_PKLEMADOPA;
/
PROMPT Otorgando permisos de ejecucion a LDCI_PKLEMADOPA
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKLEMADOPA','ADM_PERSON');
END;
/

