CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_BCLEGALORDENVENTAS
IS

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCLEGALORDENVENTAS
    Descripcion    : Paquete para consulta las ordenes de solicitudes de ventas.
    Autor          : Jorge Luis Valiente Moreno
    Fecha          : 21/05/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FsbTipoSolicitud
  Descripcion    : Funcion para retornar codigo de la solicitud y descripcion.
  Autor          : Jorge Valiente
  Fecha          : 21/05/2013

  Parametros              Descripcion
  ============         ===================
  sbContrato           Contrato perteneciente al constratista.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FsbTipoSolicitud(sbTAG_NAME MO_PACKAGES.TAG_NAME%type)
    RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuSuscripc
  Descripcion    : Funcion para retornar codigo del CONTRATO
                   de la entidad MO_MOTIVE despues de realizada
                   la entrega de formulario de venta.
  Autor          : Jorge Valiente
  Fecha          : 20/09/2013

  Parametros              Descripcion
  ============         ===================
  nuSUBSCRIBER_ID      Contrato identificacion del cliente.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuContrato(nuPACKAGE_ID MO_PACKAGES.PACKAGE_ID%type)
    RETURN SUSCRIPC.SUSCCODI%TYPE;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FsbContrato
  Descripcion    : Funcion para retornar codigo del contrato y descripcion.
  Autor          : Jorge Valiente
  Fecha          : 21/05/2013

  Parametros              Descripcion
  ============         ===================
  sbContrato           Contrato perteneciente al constratista.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FsbContrato(sbID_CONTRATISTA GE_CONTRATO.ID_CONTRATISTA%type)
    RETURN GE_CONTRATO.DESCRIPCION%TYPE;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuSuscripc
  Descripcion    : Funcion para retornar codigo del SUSCRIPTOR.
  Autor          : Jorge Valiente
  Fecha          : 21/05/2013

  Parametros              Descripcion
  ============         ===================
  nuSUBSCRIBER_ID      Contrato identificacion del cliente.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuSuscripc(nuSUBSCRIBER_ID GE_SUBSCRIBER.SUBSCRIBER_ID%type)
    RETURN SUSCRIPC.SUSCCODI%TYPE;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuExist
  Descripcion    : Funcion para validar la existencia codigo de solicitud de venta.
  Autor          : Jorge Valiente
  Fecha          : 21/05/2013

  Parametros              Descripcion
  ============         ===================
  NURETURN             retorna
                          0 si no encontro el codigo de solicitud de venta.
                          1 o mas si encontro el codigo de solicitud de venta.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuExist(InuPACKAGE_TYPE_ID MO_PACKAGES.PACKAGE_TYPE_ID%type,
                    IsbPARAMETER_ID    LD_PARAMETER.PARAMETER_ID%TYPE)
    RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FrfOrdenesVentas
  Descripcion    : Funcion para obtener las ordenes de las
                   solictudes de ventas.
  Autor          : Jorge Valiente
  Fecha          : 21/05/2013

  Parametros              Descripcion
  ============         ===================
  rfcursor             Cursor con la ordenes generadas por las entidades de recudos
                       en una conciliaion en un periodo determinado.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Function FrfOrdenesVentas return pkConstante.tyRefCursor;

end LDC_BCLEGALORDENVENTAS;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_BCLEGALORDENVENTAS
IS

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCLEGALORDENVENTAS
    Descripcion    : Paquete para consulta las ordenes de solicitudes de ventas.
    Autor          : Jorge Luis Valiente Moreno
    Fecha          : 21/05/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FsbTipoSolicitud
  Descripcion    : Funcion para retornar codigo de la solicitud y descripcion.
  Autor          : Jorge Valiente
  Fecha          : 21/05/2013

  Parametros              Descripcion
  ============         ===================
  sbContrato           Contrato perteneciente al constratista.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FsbTipoSolicitud(sbTAG_NAME MO_PACKAGES.TAG_NAME%type)
    RETURN VARCHAR2 IS

    sbTAG_NAME_SOLICITUD VARCHAR2(1000);

    CURSOR CUps_package_type IS
      select pspt.package_type_id || ' - ' || pspt.description
        from ps_package_type pspt
       where pspt.tag_name = sbTAG_NAME;

  BEGIN

    ut_trace.trace('Inicio LDC_BCLEGALORDENVENTAS.FsbContrato', 10);

    OPEN CUps_package_type;
    FETCH CUps_package_type
      INTO sbTAG_NAME_SOLICITUD;
    IF CUps_package_type%NOTFOUND THEN
      sbTAG_NAME_SOLICITUD := ' ';
    END IF;
    CLOSE CUps_package_type;

    ut_trace.trace('Fin LDC_BCLEGALORDENVENTAS.FsbContrato', 10);

    return(sbTAG_NAME_SOLICITUD);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return(' ');
    when others then
      return(' ');

  END FsbTipoSolicitud;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuSuscripc
  Descripcion    : Funcion para retornar codigo del CONTRATO
                   de la entidad MO_MOTIVE despues de realizada
                   la entrega de formulario de venta.
  Autor          : Jorge Valiente
  Fecha          : 20/09/2013

  Parametros              Descripcion
  ============         ===================
  nuSUBSCRIBER_ID      Contrato identificacion del cliente.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuContrato(nuPACKAGE_ID MO_PACKAGES.PACKAGE_ID%type)
    RETURN SUSCRIPC.SUSCCODI%TYPE IS

    sbContrato SUSCRIPC.SUSCCODI%TYPE;

    CURSOR CUMOTIVE IS
      SELECT MOM.Subscription_Id
        FROM MO_MOTIVE MOM
       WHERE MOM.package_id = nuPACKAGE_ID;

  BEGIN

    ut_trace.trace('Inicio LDC_BCLEGALORDENVENTAS.FnuContrato', 10);

    OPEN CUMOTIVE;
    FETCH CUMOTIVE
      INTO sbContrato;
    IF CUMOTIVE%NOTFOUND THEN
      sbContrato := 0;
    END IF;
    CLOSE CUMOTIVE;

    ut_trace.trace('Fin LDC_BCLEGALORDENVENTAS.FnuContrato', 10);

    return(sbContrato);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return(0);
    when others then
      return(0);

  END FnuContrato;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FsbContrato
  Descripcion    : Funcion para retornar codigo del contrato y descripcion.
  Autor          : Jorge Valiente
  Fecha          : 21/05/2013

  Parametros              Descripcion
  ============         ===================
  sbContrato           Contrato perteneciente al constratista.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FsbContrato(sbID_CONTRATISTA GE_CONTRATO.ID_CONTRATISTA%type)
    RETURN GE_CONTRATO.DESCRIPCION%TYPE IS

    sbContrato GE_CONTRATO.DESCRIPCION%TYPE;

    CURSOR CUGE_CONTRATO IS
      SELECT ID_CONTRATO || ' - ' || DESCRIPCION
        FROM GE_CONTRATO
       WHERE ID_CONTRATISTA = sbID_CONTRATISTA;

  BEGIN

    ut_trace.trace('Inicio LDC_BCLEGALORDENVENTAS.FsbContrato', 10);

    OPEN CUGE_CONTRATO;
    FETCH CUGE_CONTRATO
      INTO sbContrato;
    IF CUGE_CONTRATO%NOTFOUND THEN
      sbContrato := ' ';
    END IF;
    CLOSE CUGE_CONTRATO;

    ut_trace.trace('Fin LDC_BCLEGALORDENVENTAS.FsbContrato', 10);

    return(sbContrato);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return(' ');
    when others then
      return(' ');

  END FsbContrato;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuSuscripc
  Descripcion    : Funcion para retornar codigo del SUSCRIPTOR.
  Autor          : Jorge Valiente
  Fecha          : 21/05/2013

  Parametros              Descripcion
  ============         ===================
  nuSUBSCRIBER_ID      Contrato identificacion del cliente.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuSuscripc(nuSUBSCRIBER_ID GE_SUBSCRIBER.SUBSCRIBER_ID%type)
    RETURN SUSCRIPC.SUSCCODI%TYPE IS

    sbContrato SUSCRIPC.SUSCCODI%TYPE;

    CURSOR CUSUSCRIPC IS
      SELECT SUSCCODI
        FROM SUSCRIPC
       WHERE SUSCRIPC.SUSCCLIE = nuSUBSCRIBER_ID;

  BEGIN

    ut_trace.trace('Inicio LDC_BCLEGALORDENVENTAS.FnuSuscripc', 10);

    OPEN CUSUSCRIPC;
    FETCH CUSUSCRIPC
      INTO sbContrato;
    IF CUSUSCRIPC%NOTFOUND THEN
      sbContrato := 0;
    END IF;
    CLOSE CUSUSCRIPC;

    ut_trace.trace('Fin LDC_BCLEGALORDENVENTAS.FnuSuscripc', 10);

    return(sbContrato);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return(0);
    when others then
      return(0);

  END FnuSuscripc;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCLEGALORDENVENTAS
    Descripcion    : Paquete para consulta las ordenes de solicitudes de ventas.
    Autor          : Jorge Luis Valiente Moreno
    Fecha          : 21/05/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuExist
  Descripcion    : Funcion para validar la existencia codigo de solicitud de venta.
  Autor          : Jorge Valiente
  Fecha          : 21/05/2013

  Parametros              Descripcion
  ============         ===================
  NURETURN             retorna
                          0 si no encontro el codigo de solicitud de venta.
                          1 o mas si encontro el codigo de solicitud de venta.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuExist(InuPACKAGE_TYPE_ID MO_PACKAGES.PACKAGE_TYPE_ID%type,
                    IsbPARAMETER_ID    LD_PARAMETER.PARAMETER_ID%TYPE)
    RETURN NUMBER IS

    CURSOR CUEXIST IS
      SELECT COUNT(*)
        FROM DUAL
       WHERE InuPACKAGE_TYPE_ID in
             ((select to_number(column_value)
                from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain(IsbPARAMETER_ID,
                                                                                         NULL),
                                                        ','))));
    NURETURN NUMBER;

  BEGIN

    ut_trace.trace('Inicio LDC_BCLEGALORDENVENTAS.FsbContrato', 10);

    OPEN CUEXIST;
    FETCH CUEXIST
      INTO NURETURN;
    IF CUEXIST%NOTFOUND THEN
      NURETURN := 0;
    END IF;
    CLOSE CUEXIST;

    ut_trace.trace('Fin LDC_BCLEGALORDENVENTAS.FsbContrato', 10);

    return(NURETURN);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;

  END FnuExist;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FrfOrdenesVentas
  Descripcion    : Funcion para obtener las ordenes de las
                   solictudes de ventas.
  Autor          : Jorge Valiente
  Fecha          : 21/05/2013

  Parametros              Descripcion
  ============         ===================
  rfcursor             Cursor con la ordenes generadas por las entidades de recudos
                       en una conciliaion en un periodo determinado.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  21-Enero-2014  Jorge Valiente       NC 2648: Se modifico la consulta del PB (LOVSR) para que
                                      filtre las solicitudes que no este anuladas.
                                      par esto se crear un parametro donde se validara el
                                      estado de la solicitud.
  12-Enero-2014                       ARANADA 2758: Modificacion de consulta de filtro de ordenes
                                      de formularios de ventas.
                                      Por solicitud del funcionario Hernan Henao (GDO). Se realizaron
                                      las modificaciones:
                                      El campo REQUEST_DATE con el que se estaba realizado el filtro
                                      de fecha inicial y final final cambio por MESSAG_DELIVERY_DATE.
                                      EL campo ID_CONTRATISTA cambio por el campo POS_OPER_UNIT_ID
    25-08-2014        oparra          Team 1013. no permite consultar ordenes de trabajo generadas por
                                      ventas que hayan sido registradas con un punto de atenci?n que tiene
                                      una unidad de trabajo sin c?digo de contratista asociado.
  ******************************************************************/
  FUNCTION FrfOrdenesVentas return pkConstante.tyRefCursor
  IS

    rfcursor pkConstante.tyRefCursor;

    sbID_CONTRATISTA    ge_boInstanceControl.stysbValue;
    sbUSER_ID           ge_boInstanceControl.stysbValue;
    sbCONCFERE          ge_boInstanceControl.stysbValue;
    sbCONCFECI          ge_boInstanceControl.stysbValue;
    --
    sbUsuario           varchar2(30);       -- nombre del usuario
    --
    sbSQL               varchar2(4000);
    sbSQLContratista    varchar2(2000);
    sbSQLNoContrat      varchar2(2000);
    sbSQLUser           varchar2(2000);
    sbSQLGroup          varchar2(4000);

  BEGIN

    ut_trace.trace('Inicio LDC_BCLEGALORDENVENTAS.FrfOrdenesVentas', 10);

    sbID_CONTRATISTA := ge_boInstanceControl.fsbGetFieldValue('GE_CONTRATISTA','ID_CONTRATISTA');
    sbUSER_ID        := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES','USER_ID');
    sbCONCFERE       := ge_boInstanceControl.fsbGetFieldValue('CONCILIA','CONCFERE');
    sbCONCFECI       := ge_boInstanceControl.fsbGetFieldValue('CONCILIA','CONCFECI');

    sbSQL := 'SELECT OO.ORDER_ID "ORDEN",
             OO.TASK_TYPE_ID "T. TRABAJO",
             MO.PACKAGE_ID "SOLICITUD",
             open.LDC_BCLEGALORDENVENTAS.FsbTipoSolicitud(MO.Tag_Name) "TIPO SOLICITUD",
             OOA.ACTIVITY_ID || '' - '' ||
             open.DAGE_ITEMS.FSBGETDESCRIPTION(OOA.ACTIVITY_ID) "ACTIVIDAD",
             MO.USER_ID "DIGITADOR",
             OOU.CONTRACTOR_ID || '' - '' ||
             open.DAGE_CONTRATISTA.FSBGETNOMBRE_CONTRATISTA(OOU.CONTRACTOR_ID,NULL) "CONTRATISTA",
             MO.DOCUMENT_KEY "FORNULARIO VENTA",
             open.LDC_BCLEGALORDENVENTAS.FnuContrato(MO.PACKAGE_ID) "CONTRATO",
             MO.Messag_Delivery_Date "FECHA REGISTRO VENTA",
             open.DAAB_ADDRESS.FSBGETADDRESS(OO.EXTERNAL_ADDRESS_ID, NULL) DIRECCION
        FROM open.OR_ORDER          OO,
             open.OR_ORDER_ACTIVITY OOA,
             open.MO_PACKAGES       MO,
             open.OR_OPERATING_UNIT OOU,
             open.GE_CONTRATISTA    GC
       WHERE OO.ORDER_STATUS_ID = open.DALD_PARAMETER.fnuGetNumeric_Value(''COD_ESTADO_ASIGNADA_OT'',NULL)
         AND open.LDC_BCLEGALORDENVENTAS.FnuExist(OO.TASK_TYPE_ID,''COD_ENTR_FORM_VENT'') > 0
         AND OO.ORDER_ID = OOA.ORDER_ID
         AND OOA.PACKAGE_ID = MO.PACKAGE_ID
         AND MO.POS_OPER_UNIT_ID = OOU.Operating_Unit_Id
         AND open.LDC_BCLEGALORDENVENTAS.FnuExist(MO.PACKAGE_TYPE_ID,''COD_SOLI_VENT_RESI'') > 0
         AND MO.MOTIVE_STATUS_ID NOT IN
             (select to_number(column_value)
              from table(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain(''EST_SOL_EXC'',NULL),'','')))
         AND TRUNC(MO.MESSAG_DELIVERY_DATE) >= TRUNC(TO_DATE(:sbCONCFERE))
         AND TRUNC(MO.MESSAG_DELIVERY_DATE) <= TRUNC(TO_DATE(:sbCONCFECI)) ';

    sbSQLNoContrat     := ' AND OOU.CONTRACTOR_ID = GC.ID_CONTRATISTA(+) ';
    sbSQLContratista   := ' AND OOU.CONTRACTOR_ID = '|| sbID_CONTRATISTA;

    sbSQLGroup := ' GROUP BY OO.ORDER_ID,
                    OO.TASK_TYPE_ID,
                    MO.PACKAGE_ID,
                    open.LDC_BCLEGALORDENVENTAS.FsbTipoSolicitud(MO.Tag_Name),
                    OOA.ACTIVITY_ID || '' - '' ||
                    open.DAGE_ITEMS.FSBGETDESCRIPTION(OOA.ACTIVITY_ID),
                    MO.USER_ID,
                    OOU.CONTRACTOR_ID || '' - '' ||
                    open.DAGE_CONTRATISTA.FSBGETNOMBRE_CONTRATISTA(OOU.CONTRACTOR_ID,NULL),
                    open.LDC_BCLEGALORDENVENTAS.FnuContrato(MO.PACKAGE_ID),
                    MO.DOCUMENT_KEY,
                    MO.Messag_Delivery_Date,
                    open.DAAB_ADDRESS.FSBGETADDRESS(OO.EXTERNAL_ADDRESS_ID,NULL)
           ORDER BY OO.ORDER_ID';

    IF sbUSER_ID IS NOT NULL THEN
        begin
          SELECT SAU.MASK
          INTO sbUsuario
          FROM open.SA_USER SAU
          WHERE SAU.USER_ID = sbUSER_ID;

        exception
            when no_data_found then
                sbUsuario := NULL;
        end;
    END IF;

    if sbUsuario is not null then
        sbSQLUser   := ' AND MO.USER_ID = '''|| sbUsuario||'''';
        sbSQL       := sbSQL || sbSQLUser;
    end if;

    if sbID_CONTRATISTA is not null then
        sbSQL := sbSQL || sbSQLContratista;
    else
        sbSQL := sbSQL || sbSQLNoContrat;
    end if;

    sbSQL := sbSQL || sbSQLGroup;

    --CONSULTA DE FECHA INICIAL Y FINAL DE REGISTRO POR SOLICITUD
    OPEN rfcursor FOR sbSQL using sbCONCFERE, sbCONCFECI;


    /* ARANDA 2758: Consulta original fue comentariada y se cambio por
                    --otra consulta con  filtros personalizados por parte
                    --del funcionariopara obtener los datos que necesita
    SELECT OO.ORDER_ID "ORDEN",
           OO.TASK_TYPE_ID "T. TRABAJO",
           MO.PACKAGE_ID "SOLICITUD",
           LDC_BCLEGALORDENVENTAS.FsbTipoSolicitud(MO.Tag_Name) "TIPO SOLICITUD",
           OOA.ACTIVITY_ID || ' - ' ||
           DAGE_ITEMS.FSBGETDESCRIPTION(OOA.ACTIVITY_ID) "ACTIVIDAD",
           MO.USER_ID "DIGITADOR",
           GC.ID_CONTRATISTA || ' - ' ||
           DAGE_CONTRATISTA.FSBGETNOMBRE_CONTRATISTA(GC.ID_CONTRATISTA,
                                                     NULL) "CONTRATISTA",
           MO.DOCUMENT_KEY "FORNULARIO VENTA",
           LDC_BCLEGALORDENVENTAS.FnuContrato(MO.PACKAGE_ID) "CONTRATO",
           MO.REQUEST_DATE "FECHA REGISTRO VENTA",
           DAAB_ADDRESS.FSBGETADDRESS(OO.EXTERNAL_ADDRESS_ID, NULL) DIRECCION
      FROM OR_ORDER          OO,
           OR_ORDER_ACTIVITY OOA,
           MO_PACKAGES       MO,
           OR_OPERATING_UNIT OOU,
           GE_CONTRATISTA    GC
     WHERE OO.ORDER_STATUS_ID =
           DALD_PARAMETER.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT',
                                              NULL)
       AND LDC_BCLEGALORDENVENTAS.FnuExist(OO.TASK_TYPE_ID,
                                           'COD_ENTR_FORM_VENT') > 0
       AND OO.ORDER_ID = OOA.ORDER_ID
       AND OOA.PACKAGE_ID = MO.PACKAGE_ID
       AND LDC_BCLEGALORDENVENTAS.FnuExist(MO.PACKAGE_TYPE_ID,
                                           'COD_SOLI_VENT_RESI') > 0
       AND MO.MOTIVE_STATUS_ID NOT IN
           (select to_number(column_value)
              from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('EST_SOL_EXC',
                                                                                       NULL),
                                                      ',')))

       AND TRUNC(MO.REQUEST_DATE) >= TRUNC(TO_DATE(sbCONCFERE))
       AND TRUNC(MO.REQUEST_DATE) <= TRUNC(TO_DATE(sbCONCFECI))

       AND MO.USER_ID = DECODE(sbUSER_ID, NULL, MO.USER_ID, sbUSER_ID)
       AND MO.PERSON_ID = OOU.PERSON_IN_CHARGE
       AND OOU.CONTRACTOR_ID = GC.ID_CONTRATISTA
       AND GC.ID_CONTRATISTA =
           DECODE(sbID_CONTRATISTA,
                  NULL,
                  GC.ID_CONTRATISTA,
                  sbID_CONTRATISTA)
     GROUP BY OO.ORDER_ID,
              OO.TASK_TYPE_ID,
              MO.PACKAGE_ID,
              LDC_BCLEGALORDENVENTAS.FsbTipoSolicitud(MO.Tag_Name),
              OOA.ACTIVITY_ID || ' - ' ||
              DAGE_ITEMS.FSBGETDESCRIPTION(OOA.ACTIVITY_ID),
              MO.USER_ID,
              GC.ID_CONTRATISTA || ' - ' ||
              DAGE_CONTRATISTA.FSBGETNOMBRE_CONTRATISTA(GC.ID_CONTRATISTA,
                                                        NULL),
              LDC_BCLEGALORDENVENTAS.FnuContrato(MO.PACKAGE_ID),
              MO.DOCUMENT_KEY,
              MO.REQUEST_DATE,
              DAAB_ADDRESS.FSBGETADDRESS(OO.EXTERNAL_ADDRESS_ID, NULL)
     ORDER BY OO.ORDER_ID;
     --*/

    ut_trace.trace('Fin LDC_BCLEGALORDENVENTAS.FrfOrdenesVentas', 10);

    return(rfcursor);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;

  END FrfOrdenesVentas;

BEGIN

  null;

END LDC_BCLEGALORDENVENTAS;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BCLEGALORDENVENTAS', 'ADM_PERSON');
END;
/
