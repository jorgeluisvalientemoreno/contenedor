CREATE OR REPLACE PACKAGE adm_person.LDC_PKDATOSVISTAMATERIALIZADA is

  TYPE tyRefCursor IS REF CURSOR;

  /*****************************************************************
  Propiedad intelectual de GDO (c).

  Unidad         : LDC_PKDATOSVISTAMATERIALIZADA
  Descripcion    : Paquete para servicio para retornar datos a las tablas materializadas
  Autor          : Jorge Valiente
  Fecha          : 18/04/2017


  Parametros              Descripcion
  ============         ===================
  Fecha             Autor                Modificacion
  =========       =========             ====================
  23/07/2024      PAcosta               OSF-2952: Cambio de esquema ADM_PERSON
  ******************************************************************/

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBDESCIPCIONTIPOTRAB
  Descripcion : Funcion qeu retorna el nomrbre del codigo del tipo de trabajo.
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBDESCIPCIONTIPOTRAB(task_type_id or_task_type.task_type_id%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBNOMBRECOMPLETO
  Descripcion : Funcion que retorna el nomrbre del suscriptor.
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNOMBRECOMPLETO(inusubscriber_id ge_subscriber.subscriber_id%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBDIRECCIONORDEN
  Descripcion : Funcion que retorna la direccion de la orden
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBDIRECCIONCLIENTE(inusubscriber_id ge_subscriber.subscriber_id%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FDTFECHALEGALIZACION
  Descripcion : Funcion que retorna la fecha en que legalizacion la orden
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FDTFECHALEGALIZACION(inuorder_id open.or_order.order_id%type)
    RETURN open.or_order.legalization_date%type;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBCIUDADORDEN
  Descripcion : Funcion que retorna la ciudad relacionada con la orden
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBCIUDADORDEN(inuaddress_id ab_address.address_id%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBCIUDADCLIENTE
  Descripcion : Funcion que retorna la ciudad relacionada con la cliente
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBCIUDADCLIENTE(inusubscriber_id ge_subscriber.subscriber_id%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBMEDIDOR
  Descripcion : Funcion que retorna el medidor del prodcuto
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBMEDIDOR(inuproduct_id or_order_activity.product_id%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBIDENTIFICACION
  Descripcion : Funcion que retorna la identificacion del cliente
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBIDENTIFICACION(inusubscriber_id ge_subscriber.subscriber_id%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBNOMBRECONTRATO
  Descripcion : Funcion que retorna el nombre del contrato relacionado con el cliente
  Autor       : Jorge Valiente
  Fecha       : 19-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNOMBRECONTRATO(inususccodi suscripc.susccodi%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBLOCALIDAD
  Descripcion : Funcion que retorna el nombre de la localidad
  Autor       : Jorge Valiente
  Fecha       : 19-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBLOCALIDAD(inugeograp_location_id OPEN.ge_geogra_location.GEOGRAP_LOCATION_ID%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBNOMBRECICLO
  Descripcion : Funcion que retorna el nombre del ciclo
  Autor       : Jorge Valiente
  Fecha       : 19-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNOMBRECICLO(inususccodi suscripc.susccicl%type) RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBNOMBRECATEGORIA
  Descripcion : Funcion que retorna el nombre del la categoria del prodcuto
  Autor       : Jorge Valiente
  Fecha       : 19-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNOMBRECATEGORIA(inucategory_id pr_product.category_id%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBNOMBRESUBCATEGORIA
  Descripcion : Funcion que retorna el nombre del la categoria del prodcuto
  Autor       : Jorge Valiente
  Fecha       : 19-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNOMBRESUBCATEGORIA(inucategory_id    pr_product.category_id%type,
                                 inusubcategory_id pr_product.subcategory_id%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBMEDIDORPRODUCTO
  Descripcion : Funcion que retorna el medidor del prodcuto
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNUMEROMEDIDOR(inuproduct_id or_order_activity.product_id%type)
    RETURN number;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBNOMBRESERVICIO
  Descripcion : Funcion que retorna el nombre del servicio
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNOMBRESERVICIO(inuproduct_id or_order_activity.product_id%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBCIUDAD
  Descripcion : Funcion que retorna el nombre de la localidad con base a uan direccion
  Autor       : Jorge Valiente
  Fecha       : 19-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBCIUDAD(inuADDRESS_ID OPEN.ab_address.ADDRESS_ID%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBDIRECCION
  Descripcion : Funcion que retorna la direccion de la orden
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBDIRECCION(inuaddress_id ab_address.address_id%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBDIRECCIONSOLICITUD
  Descripcion : Funcion que retorna la direccion de la solicitud
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBDIRECCIONSOLICITUD(inuPACKAGE_ID OPEN.mo_packages.PACKAGE_ID%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSSUSCRIPTORSOLICITUD
  Descripcion : Funcion que retorna el nombre del suscriptor por la solicitud
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBSUSCRIPTORSOLICITUD(inuPACKAGE_ID OPEN.mo_packages.PACKAGE_ID%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSIDENTIFICACIONSOLICITUD
  Descripcion : Funcion que retorna la identificacion del suscriptor por la solicitud
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBIDENTIFICACIONSOLICITUD(inuPACKAGE_ID OPEN.mo_packages.PACKAGE_ID%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBCORREOSOLICITUD
  Descripcion : Funcion que retorna el correo relacionado con la solicitud del suscriptor
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBCORREOSOLICITUD(inuPACKAGE_ID OPEN.mo_packages.PACKAGE_ID%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBCONTACTOSOLICITUD
  Descripcion : Funcion que retorna el nombre del contacto registrado en la solicitud
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBCONTACTOSOLICITUD(inuPACKAGE_ID OPEN.mo_packages.PACKAGE_ID%type)
    RETURN varchar2;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBDIRECCIONCONTACTOSOLICITUD
  Descripcion : Funcion que retorna la direccion del contacto registrado en la solicitud
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBDIRECCIONCONTACTOSOLICITUD(inuPACKAGE_ID OPEN.mo_packages.PACKAGE_ID%type)
    RETURN varchar2;

End LDC_PKDATOSVISTAMATERIALIZADA;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKDATOSVISTAMATERIALIZADA AS

  /*****************************************************************
  Propiedad intelectual de GDO (c).

  Unidad         : LDC_PKDATOSVISTAMATERIALIZADA
  Descripcion    : Paquete para servicio para retornar datos a las tablas materializadas
  Autor          : Jorge Valiente
  Fecha          : 18/04/2017


  Parametros              Descripcion
  ============         ===================
  Fecha             Autor                Modificacion
  =========       =========             ====================

  ******************************************************************/

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBDESCIPCIONTIPOTRAB
  Descripcion : Funcion qeu retorna el nomrbre del codigo del tipo de trabajo.
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBDESCIPCIONTIPOTRAB(task_type_id or_task_type.task_type_id%type)
    RETURN varchar2 IS

    cursor cudescripcion is
      SELECT /*+ index (o PK_OR_TASK_TYPE)*/
       o.description
        FROM OPEN.or_task_type o
       WHERE o.task_type_id = task_type_id;

    rgcudescripcion cudescripcion%rowtype;

    sbdesctipotrab or_task_type.description%type := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBDESCIPCIONTIPOTRAB',
    --               10);
    open cudescripcion;
    fetch cudescripcion
      into rgcudescripcion;
    if cudescripcion%found then
      sbdesctipotrab := rgcudescripcion.description;
    else
      sbdesctipotrab := NULL;
    end if;
    close cudescripcion;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBDESCIPCIONTIPOTRAB',
    --               10);

    --Retorno la Variable.
    RETURN sbdesctipotrab;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbdesctipotrab;
  END FSBDESCIPCIONTIPOTRAB;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBNOMBRECOMPLETO
  Descripcion : Funcion que retorna el nomrbre del suscriptor.
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNOMBRECOMPLETO(inusubscriber_id ge_subscriber.subscriber_id%type)
    RETURN varchar2 IS

    cursor cunombrecompleto is
      SELECT /*+ index (g PK_GE_SUBSCRIBER) */
       subscriber_name || ' ' || subs_last_name nombrecompleto
        FROM OPEN.ge_subscriber g
       WHERE g.subscriber_id = inusubscriber_id;

    rgcunombrecompleto cunombrecompleto%rowtype;

    sbnombrecompleto varchar2(4000) := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRECOMPLETO',
    --               10);
    open cunombrecompleto;
    fetch cunombrecompleto
      into rgcunombrecompleto;
    if cunombrecompleto%found then
      sbnombrecompleto := rgcunombrecompleto.nombrecompleto;
    else
      sbnombrecompleto := NULL;
    end if;
    close cunombrecompleto;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRECOMPLETO',
    --               10);

    --Retorno la Variable.
    RETURN sbnombrecompleto;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbnombrecompleto;
  END FSBNOMBRECOMPLETO;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBDIRECCIONORDEN
  Descripcion : Funcion que retorna la direccion de la orden
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBDIRECCIONCLIENTE(inusubscriber_id ge_subscriber.subscriber_id%type)
    RETURN varchar2 IS

    cursor cudireccioncliente is
      SELECT /*+ index (b PK_AB_ADDRESS)*/
       b.address direccion
        FROM OPEN.ab_address b
       WHERE b.address_id =
             (SELECT /*+ index (g PK_GE_SUBSCRIBER) */
               g.address_id
                FROM OPEN.ge_subscriber g
               WHERE subscriber_id = inusubscriber_id);

    rfcudireccioncliente cudireccioncliente%rowtype;

    sbdireccioncliente varchar2(4000) := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBDIRECCIONCLIENTE',
    --               10);
    open cudireccioncliente;
    fetch cudireccioncliente
      into rfcudireccioncliente;
    if cudireccioncliente%found then
      sbdireccioncliente := rfcudireccioncliente.direccion;
    else
      sbdireccioncliente := NULL;
    end if;
    close cudireccioncliente;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBDIRECCIONCLIENTE',
    --               10);

    --Retorno la Variable.
    RETURN sbdireccioncliente;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbdireccioncliente;
  END FSBDIRECCIONCLIENTE;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FDTFECHALEGALIZACION
  Descripcion : Funcion que retorna la fecha en que legalizacion la orden
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FDTFECHALEGALIZACION(inuorder_id open.or_order.order_id%type)
    RETURN open.or_order.legalization_date%type IS

    cursor cufechalegalizacion is
      SELECT /*+ index (o PK_OR_ORDER) */
       o.legalization_date fechalegalizacion
        FROM OPEN.or_order o
       WHERE o.order_id = inuorder_id;

    rfcufechalegalizacion cufechalegalizacion %rowtype;

    dtfechalegalizacion open.or_order.legalization_date%type := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FDTFECHALEGALIZACION',
    --               10);
    open cufechalegalizacion;
    fetch cufechalegalizacion
      into rfcufechalegalizacion;
    if cufechalegalizacion%found then
      dtfechalegalizacion := rfcufechalegalizacion.fechalegalizacion;
    else
      dtfechalegalizacion := NULL;
    end if;
    close cufechalegalizacion;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FDTFECHALEGALIZACION',
    --               10);

    --Retorno la Variable.
    RETURN dtfechalegalizacion;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN dtfechalegalizacion;
  END FDTFECHALEGALIZACION;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBCIUDADORDEN
  Descripcion : Funcion que retorna la ciudad relacionada con la orden
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBCIUDADORDEN(inuaddress_id ab_address.address_id%type)
    RETURN varchar2 IS

    cursor cuciudadorden is
      SELECT /*+ index PK_AB_ADDRESS,PK_GE_GEOGRA_LOCATION */
       ge_geogra_location.description CIUDADORDEN
        FROM OPEN.ab_address, OPEN.ge_geogra_location
       WHERE ab_address.address_id = inuaddress_id
         AND ab_address.geograp_location_id =
             ge_geogra_location.geograp_location_id;

    rfcuciudadorden cuciudadorden%rowtype;

    sbciudadorden varchar2(4000) := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBCIUDADORDEN',
    --               10);
    open cuciudadorden;
    fetch cuciudadorden
      into rfcuciudadorden;
    if cuciudadorden%found then
      sbciudadorden := rfcuciudadorden.ciudadorden;
    else
      sbciudadorden := NULL;
    end if;
    close cuciudadorden;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBCIUDADORDEN',
    --               10);

    --Retorno la Variable.
    RETURN sbciudadorden;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbciudadorden;
  END FSBCIUDADORDEN;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBCIUDADCLIENTE
  Descripcion : Funcion que retorna la ciudad relacionada con la cliente
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBCIUDADCLIENTE(inusubscriber_id ge_subscriber.subscriber_id%type)
    RETURN varchar2 is

    cursor cuciudadcliente is
      SELECT /*+ index PK_AB_ADDRESS,PK_GE_GEOGRA_LOCATION */
       ge_geogra_location.description CIUDADCLIENTE
        FROM OPEN.ab_address, OPEN.ge_geogra_location
       WHERE ab_address.address_id =
             (SELECT /*+ index (g PK_GE_SUBSCRIBER) */
               g.address_id
                FROM OPEN.ge_subscriber g
               WHERE subscriber_id = inusubscriber_id)
         AND ab_address.geograp_location_id =
             ge_geogra_location.geograp_location_id;

    rfcuciudadcliente cuciudadcliente%rowtype;

    sbciudadcliente varchar2(4000) := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBCIUDADCLIENTE',
    --               10);
    open cuciudadcliente;
    fetch cuciudadcliente
      into rfcuciudadcliente;
    if cuciudadcliente%found then
      sbciudadcliente := rfcuciudadcliente.CIUDADCLIENTE;
    else
      sbciudadcliente := NULL;
    end if;
    close cuciudadcliente;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBCIUDADCLIENTE',
    --               10);

    --Retorno la Variable.
    RETURN sbciudadcliente;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbciudadcliente;
  END FSBCIUDADCLIENTE;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBMEDIDOR
  Descripcion : Funcion que retorna el medidor del prodcuto
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBMEDIDOR(inuproduct_id or_order_activity.product_id%type)
    RETURN varchar2 is

    cursor cumedidor is
      SELECT /*+ index (s PK_SERVSUSC) (m IX_EMSS_SESU)*/
       m.emsscoem medidor
        FROM OPEN.servsusc s
        LEFT JOIN OPEN.elmesesu m
          ON (m.emsssesu = s.sesunuse AND
             NVL(m.emssfere, TRUNC(SYSDATE)) >= TRUNC(SYSDATE))
       WHERE s.sesunuse = inuproduct_id;

    rfcumedidor cumedidor%rowtype;

    sbmedidor varchar2(4000) := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBMEDIDOR',
    --               10);
    open cumedidor;
    fetch cumedidor
      into rfcumedidor;
    if cumedidor%found then
      sbmedidor := rfcumedidor.medidor;
    else
      sbmedidor := NULL;
    end if;
    close cumedidor;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBMEDIDOR',
    --               10);

    --Retorno la Variable.
    RETURN sbmedidor;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbmedidor;
  END FSBMEDIDOR;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBIDENTIFICACION
  Descripcion : Funcion que retorna la identificacion del cliente
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBIDENTIFICACION(inusubscriber_id ge_subscriber.subscriber_id%type)
    RETURN varchar2 is

    cursor cuidentificacion is
      SELECT /*+ index (g PK_GE_SUBSCRIBER) */
       identification identificacion
        FROM OPEN.ge_subscriber g
       WHERE g.subscriber_id = inusubscriber_id;

    rfcuidentificacion cuidentificacion%rowtype;

    sbidentificacion OPEN.ge_subscriber.IDENTIFICATION%type := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBIDENTIFICACION',
    --               10);
    open cuidentificacion;
    fetch cuidentificacion
      into rfcuidentificacion;
    if cuidentificacion%found then
      sbidentificacion := rfcuidentificacion.identificacion;
    else
      sbidentificacion := NULL;
    end if;
    close cuidentificacion;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBIDENTIFICACION',
    --               10);

    --Retorno la Variable.
    RETURN sbidentificacion;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbidentificacion;
  END FSBIDENTIFICACION;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBNOMBRECONTRATO
  Descripcion : Funcion que retorna el nombre del contrato relacionado con el cliente
  Autor       : Jorge Valiente
  Fecha       : 19-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNOMBRECONTRATO(inususccodi suscripc.susccodi%type)
    RETURN varchar2 is

    cursor cunombrecontrato is
      SELECT /*+ index (c PK_GE_CONTRATO) */
       c.descripcion descripcion
        FROM OPEN.ge_contrato c
       WHERE c.id_contrato = inususccodi;

    rfcunombrecontrato cunombrecontrato%rowtype;

    sbnombrecontrato OPEN.ge_contrato.DESCRIPCION%type := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRECONTRATO',
    --               10);
    open cunombrecontrato;
    fetch cunombrecontrato
      into rfcunombrecontrato;
    if cunombrecontrato%found then
      sbnombrecontrato := rfcunombrecontrato.descripcion;
    else
      sbnombrecontrato := NULL;
    end if;
    close cunombrecontrato;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRECONTRATO',
    --               10);

    --Retorno la Variable.
    RETURN sbnombrecontrato;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbnombrecontrato;
  END FSBNOMBRECONTRATO;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBLOCALIDAD
  Descripcion : Funcion que retorna el nombre de la localidad
  Autor       : Jorge Valiente
  Fecha       : 19-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBLOCALIDAD(inugeograp_location_id OPEN.ge_geogra_location.GEOGRAP_LOCATION_ID%type)
    RETURN varchar2 is

    cursor culocalidad is
      SELECT /*+ index (geo PK_GE_GEOGRA_LOCATION) */
       geo.description descripcion
        FROM OPEN.ge_geogra_location geo
       WHERE geo.geograp_location_id = inugeograp_location_id;

    rfculocalidad culocalidad%rowtype;

    sblocalidad OPEN.ge_geogra_location.description%type := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRECONTRATO',
    --               10);
    open culocalidad;
    fetch culocalidad
      into rfculocalidad;
    if culocalidad%found then
      sblocalidad := rfculocalidad.descripcion;
    else
      sblocalidad := NULL;
    end if;
    close culocalidad;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRECONTRATO',
    --               10);

    --Retorno la Variable.
    RETURN sblocalidad;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sblocalidad;
  END FSBLOCALIDAD;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBNOMBRECICLO
  Descripcion : Funcion que retorna el nombre del ciclo
  Autor       : Jorge Valiente
  Fecha       : 19-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNOMBRECICLO(inususccodi suscripc.susccicl%type) RETURN varchar2 is

    cursor cunombreciclo is
      SELECT /*+ index (cl PK_CICLO) */
       cl.cicldesc nombreciclo
        FROM OPEN.ciclo cl
       WHERE cl.ciclcodi = inususccodi;

    rfcunombreciclo cunombreciclo%rowtype;

    sbnombreciclo OPEN.ge_contrato.DESCRIPCION%type := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRECICLO',
    --               10);
    open cunombreciclo;
    fetch cunombreciclo
      into rfcunombreciclo;
    if cunombreciclo%found then
      sbnombreciclo := rfcunombreciclo.nombreciclo;
    else
      sbnombreciclo := NULL;
    end if;
    close cunombreciclo;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRECICLO',
    --               10);

    --Retorno la Variable.
    RETURN sbnombreciclo;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbnombreciclo;
  END FSBNOMBRECICLO;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBNOMBRECATEGORIA
  Descripcion : Funcion que retorna el nombre del la categoria del prodcuto
  Autor       : Jorge Valiente
  Fecha       : 19-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNOMBRECATEGORIA(inucategory_id pr_product.category_id%type)
    RETURN varchar2 is

    cursor cunombrecategoria is
      SELECT /*+ index (cat PK_CATEGORI) */
       cat.catedesc nombrecategoria
        FROM OPEN.categori cat
       WHERE cat.catecodi = inucategory_id;

    rfcunombrecategoria cunombrecategoria%rowtype;

    sbnombrecategoria OPEN.categori.CATEDESC%type := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRECATEGORIA',
    --               10);
    open cunombrecategoria;
    fetch cunombrecategoria
      into rfcunombrecategoria;
    if cunombrecategoria%found then
      sbnombrecategoria := rfcunombrecategoria.nombrecategoria;
    else
      sbnombrecategoria := NULL;
    end if;
    close cunombrecategoria;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRECATEGORIA',
    --               10);

    --Retorno la Variable.
    RETURN sbnombrecategoria;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbnombrecategoria;
  END FSBNOMBRECATEGORIA;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBNOMBRESUBCATEGORIA
  Descripcion : Funcion que retorna el nombre del la categoria del prodcuto
  Autor       : Jorge Valiente
  Fecha       : 19-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNOMBRESUBCATEGORIA(inucategory_id    pr_product.category_id%type,
                                 inusubcategory_id pr_product.subcategory_id%type)
    RETURN varchar2 is

    cursor cunombresubcategoria is
      SELECT /*+ index (suca PK_SUBCATEG) */
       suca.sucadesc nombresubcategoria
        FROM OPEN.subcateg suca
       WHERE suca.sucacate = inucategory_id
         AND suca.sucacodi = inusubcategory_id;

    rfcunombresubcategoria cunombresubcategoria%rowtype;

    sbnombresubcategoria OPEN.categori.CATEDESC%type := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRESUBCATEGORIA',
    --               10);
    open cunombresubcategoria;
    fetch cunombresubcategoria
      into rfcunombresubcategoria;
    if cunombresubcategoria%found then
      sbnombresubcategoria := rfcunombresubcategoria.nombresubcategoria;
    else
      sbnombresubcategoria := NULL;
    end if;
    close cunombresubcategoria;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRESUBCATEGORIA',
    --               10);

    --Retorno la Variable.
    RETURN sbnombresubcategoria;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbnombresubcategoria;
  END FSBNOMBRESUBCATEGORIA;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBNUMEROMEDIDOR
  Descripcion : Funcion que retorna el medidor del prodcuto
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNUMEROMEDIDOR(inuproduct_id or_order_activity.product_id%type)
    RETURN number is

    cursor cumedidor is
      SELECT /*+ index (elm IX_EMSS_SESU)*/
       elm.emsselme medidor
        FROM OPEN.elmesesu elm
       WHERE elm.emsssesu = inuproduct_id
         AND (elm.emssfere IS NULL OR elm.emssfere > SYSDATE)
         AND elm.emssserv = 7014
         AND ROWNUM = 1;

    rfcumedidor cumedidor%rowtype;

    sbmedidor number := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBNUMEROMEDIDOR',
    --               10);
    open cumedidor;
    fetch cumedidor
      into rfcumedidor;
    if cumedidor%found then
      sbmedidor := rfcumedidor.medidor;
    else
      sbmedidor := NULL;
    end if;
    close cumedidor;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBNUMEROMEDIDOR',
    --               10);

    --Retorno la Variable.
    RETURN sbmedidor;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbmedidor;
  END FSBNUMEROMEDIDOR;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBNOMBRESERVICIO
  Descripcion : Funcion que retorna el nombre del servicio
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBNOMBRESERVICIO(inuproduct_id or_order_activity.product_id%type)
    RETURN varchar2 is

    cursor cunombreservicio is
      SELECT /*+ index (ser PK_SERVICIO)*/
       ser.servdesc servicio
        FROM OPEN.servicio ser
       WHERE ser.servcodi = inuproduct_id;

    rfcunombreservicio cunombreservicio%rowtype;

    sbnombreservicio varchar2(4000) := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRESERVICIO',
    --               10);
    open cunombreservicio;
    fetch cunombreservicio
      into rfcunombreservicio;
    if cunombreservicio%found then
      sbnombreservicio := rfcunombreservicio.servicio;
    else
      sbnombreservicio := NULL;
    end if;
    close cunombreservicio;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBNOMBRESERVICIO',
    --               10);

    --Retorno la Variable.
    RETURN sbnombreservicio;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbnombreservicio;
  END FSBNOMBRESERVICIO;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBCIUDAD
  Descripcion : Funcion que retorna el nombre de la localidad con base a uan direccion
  Autor       : Jorge Valiente
  Fecha       : 19-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBCIUDAD(inuADDRESS_ID OPEN.ab_address.ADDRESS_ID%type)
    RETURN varchar2 is

    cursor culocalidad is
      SELECT
      /*+ index PK_GE_GEOGRA_LOCATION */
       ge_geogra_location.description descripcion
        FROM OPEN.ab_address, OPEN.ge_geogra_location
       WHERE ab_address.address_id = inuADDRESS_ID
         AND ab_address.geograp_location_id =
             ge_geogra_location.geograp_location_id;

    rfculocalidad culocalidad%rowtype;

    sblocalidad OPEN.ge_geogra_location.description%type := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBCIUDAD',
    --               10);
    open culocalidad;
    fetch culocalidad
      into rfculocalidad;
    if culocalidad%found then
      sblocalidad := rfculocalidad.descripcion;
    else
      sblocalidad := NULL;
    end if;
    close culocalidad;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBCIUDAD',
    --               10);

    --Retorno la Variable.
    RETURN sblocalidad;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sblocalidad;
  END FSBCIUDAD;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBDIRECCION
  Descripcion : Funcion que retorna la direccion de la orden
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBDIRECCION(inuaddress_id ab_address.address_id%type)
    RETURN varchar2 IS

    cursor cudireccionorden is
      SELECT /*+ index (b PK_AB_ADDRESS)*/
       b.address direccion
        FROM OPEN.ab_address b
       WHERE b.address_id = inuaddress_id;

    rfcudireccionorden cudireccionorden%rowtype;

    sbdireccionorden varchar2(4000) := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBDIRECCION',
    --               10);
    open cudireccionorden;
    fetch cudireccionorden
      into rfcudireccionorden;
    if cudireccionorden%found then
      sbdireccionorden := rfcudireccionorden.direccion;
    else
      sbdireccionorden := NULL;
    end if;
    close cudireccionorden;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBDIRECCION',
    --               10);

    --Retorno la Variable.
    RETURN sbdireccionorden;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbdireccionorden;
  END FSBDIRECCION;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBDIRECCIONSOLICITUD
  Descripcion : Funcion que retorna la direccion de la solicitud
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBDIRECCIONSOLICITUD(inuPACKAGE_ID OPEN.mo_packages.PACKAGE_ID%type)
    RETURN varchar2 IS

    cursor cudireccionsolicitud is
      SELECT /*+ index (o IDX_MO_ADDRESS_03) */
       o.address direccion
        FROM OPEN.mo_address o
       WHERE o.package_id = inuPACKAGE_ID;

    rfcudireccionsolicitud cudireccionsolicitud%rowtype;

    sbdireccionsolicitud varchar2(4000) := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBDIRECCIONSOLICITUD',
    --               10);
    open cudireccionsolicitud;
    fetch cudireccionsolicitud
      into rfcudireccionsolicitud;
    if cudireccionsolicitud%found then
      sbdireccionsolicitud := rfcudireccionsolicitud.direccion;
    else
      sbdireccionsolicitud := NULL;
    end if;
    close cudireccionsolicitud;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBDIRECCIONSOLICITUD',
    --               10);

    --Retorno la Variable.
    RETURN sbdireccionsolicitud;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbdireccionsolicitud;
  END FSBDIRECCIONSOLICITUD;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSSUSCRIPTORSOLICITUD
  Descripcion : Funcion que retorna el nombre del suscriptor por la solicitud
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBSUSCRIPTORSOLICITUD(inuPACKAGE_ID OPEN.mo_packages.PACKAGE_ID%type)
    RETURN varchar2 IS

    cursor cususcriptorsolicitud is
      SELECT /*+ index PK_GE_SUBSCRIBER*/
       subscriber_name || ' ' || subs_last_name suscriptor
        FROM OPEN.ge_subscriber
       WHERE subscriber_id IN
             (SELECT /*+ index PK_MO_PACKAGES*/
               mo_packages.subscriber_id
                FROM OPEN.mo_packages
               WHERE mo_packages.package_id = inuPACKAGE_ID);

    rfcususcriptorsolicitud cususcriptorsolicitud%rowtype;

    sbsuscriptorsolicitud varchar2(4000) := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBSUSCRIPTORSOLICITUD',
    --               10);
    open cususcriptorsolicitud;
    fetch cususcriptorsolicitud
      into rfcususcriptorsolicitud;
    if cususcriptorsolicitud%found then
      sbsuscriptorsolicitud := rfcususcriptorsolicitud.suscriptor;
    else
      sbsuscriptorsolicitud := NULL;
    end if;
    close cususcriptorsolicitud;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBSUSCRIPTORSOLICITUD',
    --               10);

    --Retorno la Variable.
    RETURN sbsuscriptorsolicitud;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbsuscriptorsolicitud;
  END FSBSUSCRIPTORSOLICITUD;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSIDENTIFICACIONSOLICITUD
  Descripcion : Funcion que retorna la identificacion del suscriptor por la solicitud
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBIDENTIFICACIONSOLICITUD(inuPACKAGE_ID OPEN.mo_packages.PACKAGE_ID%type)
    RETURN varchar2 IS

    cursor cuidentificacionsolicitud is
      SELECT /*+ index PK_GE_SUBSCRIBER*/
       identification identificacion
        FROM OPEN.ge_subscriber
       WHERE subscriber_id IN
             (SELECT /*+ index PK_MO_PACKAGES*/
               mo_packages.subscriber_id
                FROM OPEN.mo_packages
               WHERE mo_packages.package_id = inuPACKAGE_ID);

    rfcuidentificacionsolicitud cuidentificacionsolicitud%rowtype;

    sbidentificacionsolicitud varchar2(4000) := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBIDENTIFICACIONSOLICITUD',
    --               10);
    open cuidentificacionsolicitud;
    fetch cuidentificacionsolicitud
      into rfcuidentificacionsolicitud;
    if cuidentificacionsolicitud%found then
      sbidentificacionsolicitud := rfcuidentificacionsolicitud.identificacion;
    else
      sbidentificacionsolicitud := NULL;
    end if;
    close cuidentificacionsolicitud;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBIDENTIFICACIONSOLICITUD',
    --               10);

    --Retorno la Variable.
    RETURN sbidentificacionsolicitud;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbidentificacionsolicitud;
  END FSBIDENTIFICACIONSOLICITUD;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBCORREOSOLICITUD
  Descripcion : Funcion que retorna el correo relacionado con la solicitud del suscriptor
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBCORREOSOLICITUD(inuPACKAGE_ID OPEN.mo_packages.PACKAGE_ID%type)
    RETURN varchar2 IS

    cursor cucorreosolicitud is
      SELECT /*+ index (s PK_GE_SUBSCRIBER)*/
       s.e_mail correo
        FROM OPEN.ge_subscriber s
       WHERE subscriber_id IN
             (SELECT /*+ index PK_MO_PACKAGES*/
               mo_packages.subscriber_id
                FROM OPEN.mo_packages
               WHERE mo_packages.package_id = inuPACKAGE_ID);

    rfcucorreosolicitud cucorreosolicitud%rowtype;

    sbcorreosolicitud varchar2(4000) := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBCORREOSOLICITUD',
    --               10);
    open cucorreosolicitud;
    fetch cucorreosolicitud
      into rfcucorreosolicitud;
    if cucorreosolicitud%found then
      sbcorreosolicitud := rfcucorreosolicitud.correo;
    else
      sbcorreosolicitud := NULL;
    end if;
    close cucorreosolicitud;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBCORREOSOLICITUD',
    --               10);

    --Retorno la Variable.
    RETURN sbcorreosolicitud;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbcorreosolicitud;
  END FSBCORREOSOLICITUD;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBCONTACTOSOLICITUD
  Descripcion : Funcion que retorna el nombre del contacto registrado en la solicitud
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBCONTACTOSOLICITUD(inuPACKAGE_ID OPEN.mo_packages.PACKAGE_ID%type)
    RETURN varchar2 IS

    cursor cucontactosolicitud is
      SELECT /*+ index PK_GE_SUBSCRIBER*/
       subscriber_name || ' ' || subs_last_name contacto
        FROM OPEN.ge_subscriber
       WHERE subscriber_id IN
             (SELECT /*+ index PK_MO_PACKAGES*/
               mo_packages.contact_id
                FROM OPEN.mo_packages
               WHERE mo_packages.package_id = inuPACKAGE_ID);

    rfcucontactosolicitud cucontactosolicitud%rowtype;

    sbcontatosolicitud varchar2(4000) := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBCONTACTOSOLICITUD',
    --               10);
    open cucontactosolicitud;
    fetch cucontactosolicitud
      into rfcucontactosolicitud;
    if cucontactosolicitud%found then
      sbcontatosolicitud := rfcucontactosolicitud.contacto;
    else
      sbcontatosolicitud := NULL;
    end if;
    close cucontactosolicitud;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBCONTACTOSOLICITUD',
    --               10);

    --Retorno la Variable.
    RETURN sbcontatosolicitud;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbcontatosolicitud;
  END FSBCONTACTOSOLICITUD;

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : FSBDIRECCIONCONTACTOSOLICITUD
  Descripcion : Funcion que retorna la direccion del contacto registrado en la solicitud
  Autor       : Jorge Valiente
  Fecha       : 18-04-2017

  ---------------------
  ***Variables de Entrada***
  ***Variables de Salida***

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FSBDIRECCIONCONTACTOSOLICITUD(inuPACKAGE_ID OPEN.mo_packages.PACKAGE_ID%type)
    RETURN varchar2 IS

    cursor cudireccioncontacto is
      SELECT /*+ index PK_GE_SUBSCRIBER*/
       address direccion
        FROM OPEN.ge_subscriber
       WHERE subscriber_id IN
             (SELECT /*+ index PK_MO_PACKAGES*/
               mo_packages.contact_id
                FROM OPEN.mo_packages
               WHERE mo_packages.package_id = inuPACKAGE_ID);

    rfcudireccioncontacto cudireccioncontacto%rowtype;

    sbdireccioncontacto varchar2(4000) := null;

  BEGIN

    --ut_trace.trace('INICIO LDC_PKDATOSVISTAMATERIALIZADA.FSBDIRECCIONCONTACTOSOLICITUD',
    --               10);
    open cudireccioncontacto;
    fetch cudireccioncontacto
      into rfcudireccioncontacto;
    if cudireccioncontacto%found then
      sbdireccioncontacto := rfcudireccioncontacto.direccion;
    else
      sbdireccioncontacto := NULL;
    end if;
    close cudireccioncontacto;

    --ut_trace.trace('FIN LDC_PKDATOSVISTAMATERIALIZADA.FSBDIRECCIONCONTACTOSOLICITUD',
    --               10);

    --Retorno la Variable.
    RETURN sbdireccioncontacto;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN sbdireccioncontacto;
  END FSBDIRECCIONCONTACTOSOLICITUD;

END LDC_PKDATOSVISTAMATERIALIZADA;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKDATOSVISTAMATERIALIZADA
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKDATOSVISTAMATERIALIZADA', 'ADM_PERSON');
END;
/