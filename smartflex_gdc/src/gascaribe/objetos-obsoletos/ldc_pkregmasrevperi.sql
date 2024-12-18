CREATE OR REPLACE PACKAGE LDC_PKREGMASREVPERI AS

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LDC_PKGENVENFORMASI
  Descripcion    : Paquete para el PB LDCVEFM el cual procesa un archivo plano para generacion
                   masiva de ventas por formulario
                   El proceso lee el archivo plano y genera las solicitudes de ventas
  Autor          : Karem Baquero
  Fecha          : 22/08/2016 ERS 200-465

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================
  25/01/2024    jpinedc                 OSF-2018: Se reemplaza el código
                                        por null en Os_regrevperi y 
                                        LDCREVPM
  ******************************************************************/
  ------------------
  -- Constantes
  ------------------
  csbYes constant varchar2(1) := 'Y';
  csbNo  constant varchar2(1) := 'N';
  -- cnuValorTopeAjuste constant number := 1;
  -- Error en la configuracion normal de cuotas
  -- cnuERROR_CUOTA constant number(6) := 10381;

  -----------------------
  -- Variables
  -----------------------

  nuDepa cuencobr.cucodepa%type;
  nuLoca cuencobr.cucoloca%type;
  --------------------Variables a extraer

  -----------------------
  -- Elementos Packages
  -----------------------
  FUNCTION Fnuinisolociorigen(inclien mo_packages.subscriber_id%type)
    return number;

    PROCEDURE Os_regrevperi(inupack         in mo_packages.package_id%type,
                          sbobse          in mo_packages.comment_%type,
                          onuErrorCode    out number,
                          osbErrorMessage out varchar2);

  FUNCTION ProcregrevperimasSearch RETURN pkConstante.tyRefCursor;

  PROCEDURE LDCREVPM(isbpack         IN VARCHAR2,
                     inuCurrent      IN NUMBER,
                     inuTotal        IN NUMBER,
                     onuErrorCode    OUT NUMBER,
                     osbErrorMessage OUT VARCHAR2);

END LDC_PKREGMASREVPERI;
/

create or replace package body LDC_PKREGMASREVPERI AS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LDC_PKREGMASREVPERI
  Descripcion    : Paquete para el PB LDCREVPM el cual procesa masivamente las solicitudes
                   de revision periodiocas
  Autor          : Karem Baquero
  Fecha          : 13/09/2016 ERS 200-443

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================

  ******************************************************************/

  ------------------
  -- Constantes
  ------------------
  -- Esta constante se debe modificar cada vez que se entregue el
  -- paquete con un SAO
  csbVersion CONSTANT VARCHAR2(250) := 'CA200465';

  -- Nombre del programa ejecutor Generate Invoice
  csbPROGRAMA constant varchar2(4) := 'ANDM';

  -- Maximo numero de registros Hash para Parametros o cadenas
  cnuHASH_MAX_RECORDS constant number := 100000;

  -- Constante de error de no Aplicacion para el API OS_generateInvoice
  cnuERRORNOAPLI number := 500;

  cnuNivelTrace constant number(2) := 5;
  -----------------------
  -- Variables
  -----------------------
  sbErrMsg varchar2(2000); -- Mensajes de Error

  -- Programa
  sbApplication varchar2(10);

  sbgUser     varchar2(50); -- Nombre usuario
  sbgTerminal varchar2(50); -- Terminal
  gnuPersonId ge_person.person_id%type; -- Id de la persona

  --********************************************************************************************
  FUNCTION Fnuinisolociorigen(inclien mo_packages.subscriber_id%type)
    return number is

    onupack number;

  begin

    UT_TRACE.TRACE('**************** INICIO LDC_PKREGMASREVPERI.Fnuinisolociorigen    ',

                   10);

    SELECT max(m.package_id)--M.PACKAGE_ID
      into onupack
      from mo_packages m, or_order_activity o
     where --m.package_id=10411060--
     m.subscriber_id = inclien --286296
     and m.motive_status_id = 13
     AND m.package_id = o.package_id
     and exists (select r.order_id
        from open.or_order r
       where r.order_id = o.order_id
         and r.order_status_id in (0, 5))
     and open.LDC_BCRegeReviPeri.fnuValidaEntraCNCRN(m.package_id) = 1;

    UT_TRACE.TRACE('**************** Fin LDC_PKREGMASREVPERI.Fnuinisolociorigen    ',

                   10);

    return(onupack);

  END Fnuinisolociorigen;

  --********************************************************************************************
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : ProcregrevperimasSearch
  Descripcion    : Procedimiento llamado para consultar los datos del PB
                   teniendo en cuenta los parametros dados.
  Autor          : Karem Baquero
  Fecha          : 13/09/2016 ERS 200-443

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================

  ******************************************************************/
  FUNCTION ProcregrevperimasSearch RETURN pkConstante.tyRefCursor IS

    nugeoloca   MO_PACKAGES.ADDRESS_ID%type;
    nugeodepa   MO_PACKAGES.ADDRESS_ID%type;
    nusectop    MO_PACKAGES.ZONE_ADMIN_ID%type;
    nupacktype  MO_PACKAGES.PACKAGE_TYPE_ID%type;
    dtfecini    MO_PACKAGES.REQUEST_DATE%type;
    dtfecfin    MO_PACKAGES.ATTENTION_DATE%type;
    dtfcfin     MO_PACKAGES.ATTENTION_DATE%type;
    nuopertunit MO_PACKAGES.POS_OPER_UNIT_ID%type;
    dtfcini     DATE;

    rfcursor pkConstante.tyRefCursor;
    sbsql    varchar2(6000);
    -- sbsqltipack varchar2(4000);
    sbquerydet varchar2(6000);

  BEGIN

    UT_TRACE.TRACE('**************** Inicio LDC_PKREGMASREVPERI.ProcregrevperimasSearch  ',
                   10);

    sbquerydet  := null;
    nugeodepa   := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                         'ADDRESS_ID');
    nugeoloca   := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                         'USER_ID');
    nusectop    := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                         'ZONE_ADMIN_ID');
    nupacktype  := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                         'PACKAGE_TYPE_ID');
    dtfecini    := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                         'REQUEST_DATE');
    dtfecfin    := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                         'ATTENTION_DATE');
    nuopertunit := ge_boInstanceControl.fsbGetFieldValue('MO_PACKAGES',
                                                         'POS_OPER_UNIT_ID');

    ut_trace.Trace('nugeodepa ' || nugeodepa || ' nugeoloca ' || nugeoloca ||
                   ' dtfecini ' || dtfecini,
                   10);

    UT_TRACE.TRACE('**************** Inicio sbsql', 10);

    sbsql := ' select  m.package_id,
       m.request_date,
    (SELECT d.geograp_location_id||'' - ''||d.DESCRIPTION
          FROM open.GE_GEOGRA_LOCATION d, open.GE_GEOGRA_LOCATION B, open.AB_ADDRESS C
         WHERE C.ADDRESS_ID = o.address_id
           AND C.GEOGRAP_LOCATION_ID = B.GEOGRAP_LOCATION_ID
           AND d.GEOGRAP_LOCATION_ID = B.GEO_LOCA_FATHER_ID) Departamento,
     (select ge_geogra_location.geograp_location_id||'' - ''||ge_geogra_location.description
          from open.ab_address, open.ge_geogra_location
         where ab_address.address_id = o.address_id
           and ab_address.geograp_location_id =
               ge_geogra_location.geograp_location_id) Localidad,

   o.operating_sector_id,
       o.product_id Producto,
       o.subscription_id Contrato,

       (select p.category_id
          from  open.pr_product p
         where o.product_id = p.product_id
and rownum=1) || '' - '' ||
       (select c.catedesc
          from open.categori c
         where c.catecodi =
               (select p.category_id
                  from open.pr_product p
                 where o.product_id = p.product_id
                  and rownum=1)) categoria,
       (select p.subcategory_id
          from  open.pr_product p
         where o.product_id = p.product_id
           and rownum=1) || '' - '' ||(select s.sucadesc
          from open.subcateg s
         where s.sucacate =
               (select p.category_id
                  from open.pr_product p
                 where o.product_id = p.product_id
                  and rownum=1)
           and s.sucacodi =
               (select p.subcategory_id
                  from  open.pr_product p
                 where o.product_id = p.product_id
                       and rownum=1)) Subcategoria,

       (select p.product_status_id
          from  open.pr_product p
         where o.product_id = p.product_id and rownum=1) || '' - '' ||(select d.description
          from open.ps_product_status d
         where d.product_status_id =
               (select p.product_status_id
                  from  open.pr_product p
                 where o.product_id = p.product_id and rownum=1)) Estado_product,
              (select r.order_id
          from open.or_order r
         where r.order_id = o.order_id) Orden,
       (select r.operating_unit_id
          from open.or_order r
         where r.order_id = o.order_id) || '' - '' ||(select u.name
          from open.or_operating_unit u
         where u.operating_unit_id =
               (select r.operating_unit_id
                  from open.or_order r
                 where r.order_id = o.order_id )) Unidad_OP,

  (select r.order_status_id
          from open.or_order r
         where r.order_id = o.order_id) || '' -'' ||
       (select a.description
          from open.or_order_status a
         where a.order_status_id =
               (select r.order_status_id
                  from open.or_order r
                 where r.order_id = o.order_id)) Estado_OT,

       o.task_type_id|| '' - '' ||
       (select t.description
          from open.or_task_type t
         where t.task_type_id = o.task_type_id) Tipo_Trabbajo

from open.mo_packages m, open.or_order_activity o
where m.motive_status_id = 13
AND m.package_id=o.package_id
    and exists
 (select r.order_id
          from open.or_order r
         where r.order_id = o.order_id
          and r.order_status_id in (0, 5))
  and open.LDC_BCRegeReviPeri.fnuValidaEntraCNCRN(m.package_id) = 1';

    UT_TRACE.TRACE('**************** fin sbsql' || sbsql, 10);

    -- ut_trace.Trace('nugeodepa '||nugeodepa||' nugeoloca '||nugeoloca||' dtfecini '||dtfecini, 10);

    --           dtfecini := substr(dtfecini, 1, 10);

    select substr(dtfecini, 1, 10) INTO dtfcini from dual;

    ut_trace.Trace('dtfecini ' || dtfcini, 10);

    sbquerydet := sbquerydet || ' And trunc(m.request_date) >= ''' ||
                  dtfcini || '''';

    --  dtfecfin := substr(dtfecfin, 1, 10);

    select substr(dtfecfin, 1, 10) INTO dtfcfin from dual;

    sbquerydet := sbquerydet || ' And trunc(m.request_date) <= ''' ||
                  dtfcfin || '''';

    sbquerydet := sbquerydet || ' And m.package_type_id = ' || nupacktype;

    sbquerydet := sbquerydet ||
                  ' And exists (SELECT Ag.DESCRIPTION
                FROM open.GE_GEOGRA_LOCATION Ag,
                     open.GE_GEOGRA_LOCATION Bg,
                     open.AB_ADDRESS         Cg
               WHERE Cg.ADDRESS_ID = o.address_id
                 AND Cg.GEOGRAP_LOCATION_ID = Bg.GEOGRAP_LOCATION_ID
                 AND Ag.GEOGRAP_LOCATION_ID = Bg.GEO_LOCA_FATHER_ID
                 AND  Bg.GEO_LOCA_FATHER_ID = ' ||
                  nugeodepa || ')';

    UT_TRACE.TRACE('**************** fin sbquerydet' || sbquerydet, 10);

    if nusectop is not null then
      sbquerydet := sbquerydet || 'And o.operating_sector_id= ' || nusectop;
    end if;

    if nugeoloca is not null then
      sbquerydet := sbquerydet ||
                    ' And exists (SELECT AE.DESCRIPTION
                 FROM open.GE_GEOGRA_LOCATION AE,
                      open.GE_GEOGRA_LOCATION BE,
                      open.AB_ADDRESS         CE
                WHERE CE.ADDRESS_ID = o.address_id
                  AND CE.GEOGRAP_LOCATION_ID = BE.GEOGRAP_LOCATION_ID
                  AND AE.GEOGRAP_LOCATION_ID = BE.GEO_LOCA_FATHER_ID
                  AND  BE.GEOGRAP_LOCATION_ID = ' ||
                    nugeoloca || ')';
    end if;

    ut_trace.Trace('init query', 5);

    sbsql := sbsql || sbquerydet;

    ut_trace.Trace('sbquery ' || sbsql, 5);

    OPEN rfcursor FOR sbsql;

    Return(rfcursor);

    UT_TRACE.TRACE('**************** Fin LDC_PKREGMASREVPERI.ProcregrevperimasSearch  ',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END ProcregrevperimasSearch;
  --********************************************************************************************
  PROCEDURE Os_regrevperi(inupack         in mo_packages.package_id%type,
                          sbobse          in mo_packages.comment_%type,
                          onuErrorCode    out number,
                          osbErrorMessage out varchar2) is
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LDCREVPM
    Descripcion    : Procedimiento llamado por el PB
    Autor          : Karem Baquero
    Fecha          : 20/09/2016 ERS 200-443

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    19/04/2017    dsaltarin               200-1230 Se elimina el commit y el rollback y se lanzan excepciones.
    25/01/2024    jpinedc                 OSF-2018: Se reemplaza el código por null
    ******************************************************************/
    begin
    
        NULL;
        
    end Os_regrevperi;

  --********************************************************************************************

  PROCEDURE LDCREVPM(isbpack         IN VARCHAR2,
                     inuCurrent      IN NUMBER,
                     inuTotal        IN NUMBER,
                     onuErrorCode    OUT NUMBER,
                     osbErrorMessage OUT VARCHAR2) IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LDCREVPM
    Descripcion    : Procedimiento llamado por el PB
    Autor          : Karem Baquero
    Fecha          : 20/09/2016 ERS 200-443

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    19/04/2017    dsaltarin               200-1230 Se agrega captura de excepciones
    25/01/2024    jpinedc                 OSF-2018: Se reemplaza el código por null    
    ******************************************************************/
    BEGIN
    
        NULL;
        
    END LDCREVPM;

END LDC_PKREGMASREVPERI;
/

