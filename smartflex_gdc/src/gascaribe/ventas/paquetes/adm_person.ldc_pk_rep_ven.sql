CREATE OR REPLACE package adm_person.ldc_pk_rep_ven is
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad           : LDC_PK_REP_VEN
    Descripcion      : Paquete para reportes de ventas
    Autor            :  Diego Fernando Rodriguez
    Fecha            :  05/06/2013

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========         =========             ====================
    01/11/2013        Arquitecsoft/mmoreno  - Se crean las funciones que retorna el
                                              codigo y descripcion de un mercado
                                              relevante asociado a una localidad.
                                              fnuMercaRelevanLo y fsbNombMercaRelevanLo
                                              Respectivametne.
                                            - En el cursor cuDatos de la funcion
                                              fsbTipoVivien se adiciona el separador del
                                              codigo y la descripcion.
                                            - Se crea la funcion FsbMedioPago que retorna
                                              la descripcion del medio de pago de un package_id.
    18/11/2013        Arquitecsoft/mmoreno  - Se crea la funcion fvaRetTelCliente la cual retorna los
                                              telefonos asociados a un cliente.
  ******************************************************************/

   FUNCTION FSBVERSION  RETURN VARCHAR2;

   -- Retornan el mercado relevante de una direccion
   function fnuMercaRelevan ( inuAddress   AB_ADDRESS.ADDRESS_ID%type) return number;
   --<<
   -- Arquitecsoft/mmoreno
   -- 01/11/2013
   -- Retornan el codigo del mercado relevante de una localidad
   -->>
   FUNCTION fnuMercaRelevanLo(inuge_geogra_location ge_geogra_location.geograp_location_id%TYPE)
     RETURN NUMBER;

   -- Retornan el nombre del mercado relevante de una direccion
   function fsbNomMercaRelevan ( inuAddress   AB_ADDRESS.ADDRESS_ID%type) return varchar2;
   --<<
   -- Arquitecsoft/mmoreno
   -- 01/11/2013
   -- Retornan el nombre del mercado relevante de una localidad
   -->>
   FUNCTION fsbNombMercaRelevanLo(inuge_geogra_location ge_geogra_location.geograp_location_id%TYPE)
     RETURN VARCHAR2;

   -- Retornan el nombre de la localidad
   function fsbNomLocalidad ( inuGEOGRA_LOCATION   GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type) return varchar2;

   -- Retorna el departamento
   function fnuDepartamento ( inuGEOGRA_LOCATION   GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type) return number;

   -- Retorna el departamento
   function fsbNomDepartamento ( inuGEOGRA_LOCATION   GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type) return Varchar2;

   -- Retorna la Direccion de Instalacion
   function fsbDireInstala ( inuAddress   AB_ADDRESS.ADDRESS_ID%type) return varchar2;

   -- Retorna la manzana
   function fsbManzana ( inuAddress   AB_ADDRESS.ADDRESS_ID%type) return varchar2;

   -- Retorna el Ciclo
   function fnuCiclo ( inuAddress   AB_ADDRESS.ADDRESS_ID%type) return number;

   -- Retorna el Uso-Servicio
   function fsbUsoServicio ( inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2;

   -- Retorna la categoria
   function fnuCate(nuProducto   servsusc.sesunuse%type) return number;

   -- Retorna el nombre de la categoria
   function fsbNombreCate(nuProducto   servsusc.sesunuse%type)    return Varchar2;

   -- Retorna la subcateoria
   function fnuSubCate(nuProducto   servsusc.sesunuse%type)  return number;

   -- Retorna el nombre de la subcateoria
   function fsbSubCate(nuProducto   servsusc.sesunuse%type)  return Varchar2;

   -- Barrio
   function fnuBarrio (inuAddress   AB_ADDRESS.ADDRESS_ID%type)  return number;

   -- Nombre de Barrio
   function fsbBarrio (inuAddress   AB_ADDRESS.ADDRESS_ID%type)  return varchar2;

   -- Retorna el estado de la solicitud
   function fsbEstadoSolicitud(nucodigo PS_MOTIVE_STATUS.MOTIVE_STATUS_ID%type)  return Varchar2;

   -- Asesor
   function fsbAsesor(nucodigo GE_PERSON.PERSON_ID%type)  return Varchar2;

   -- Unidad operativa
   function fsbUnidaTrabajo (nucodigo or_operating_unit.operating_unit_id%type) return Varchar2;

   -- Contratista
   function fnuContratista (nucodigo or_operating_unit.operating_unit_id%type)  return number;

   -- Nombre delcontratista
   function fsbContratista (nucodigo or_operating_unit.operating_unit_id%type)  return varchar2;

   -- Tipo de identificacion del cliente
   function fsbTipoIdentCliente (inucodigo or_operating_unit.operating_unit_id%type)  return varchar2;

   -- Tipo de cliente
   function fsbTipoCliente (inucodigo GE_SUBSCRIBER_TYPE.SUBSCRIBER_TYPE_ID%type)  return varchar2;

   -- Solisitud de Cotizacion
   function fnuSolicituCoti ( inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number;

   -- Zona
   function fsbZona (inuparser_address_id mo_address.parser_address_id%type) return varchar2;

   -- Cotizacion
   function fnuCotizacion ( inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2;

   -- Empresa Cliente
   function fsbEmpreCliente (nuContrato   suscripc.susccodi%type) return varchar2;

   -- Cargos Cliente
   function fsbCargoCliente (nuContrato   suscripc.susccodi%type) return varchar2;

   -- Numero Persona Hogar
   function fnuPerHogar (nuContrato   suscripc.susccodi%type) return number;

   -- Energetico anterior
   function fsbEnergAnte (nuContrato   suscripc.susccodi%type) return varchar2;

   -- Energetico anterior Costo Mensual
   function fsbEnergAnteCM (nuContrato   suscripc.susccodi%type) return varchar2;

   -- Energetico anterior Tiemp con el Energetico
   function fsbEnergAnteTE (nuContrato   suscripc.susccodi%type) return varchar2;

   -- Tipo de Vivienda
   function fsbTipoVivien (nuContrato   suscripc.susccodi%type) return varchar2;

   -- Nombre de propietario del predio
   function fsbNombrePropi (nuContrato suscripc.susccodi%type) return varchar2;

   -- Telefono de contacto
   function fsbTelCont (nuContrato suscripc.susccodi%type) return varchar2;

   -- Referencia
   function fsbReferencia (nuContrato suscripc.susccodi%type) return varchar2;

   -- Tipo de Instalacion
   function fsbTipoInstal (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2;

   -- Nombre del plan comercial
   function fsbPlanComercial (inuCodigo   cc_commercial_plan.commercial_plan_id%type) return varchar2;

   -- Promociones
   function fsbPromociones (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2;

   -- Plan de Financiacion
   function fnuPlanFinan (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number;

   -- Nombre del Plan de Financiacion
   function fsbPlanFinan (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2;

   -- Valor Total de Venta
   function fnuValorVenta (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number;

   -- Valor Descuento
   function fnuValorDescuento (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number;

   -- Valor Cuota Inicial
   function fnuValorCuoInic (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number;

   -- Numero de Cuotas
   function fnuNumeCuotas (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number;

   -- Valor a financiar
   function fnuValFinanc (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number;

   -- Valor Cuota Inicial
   function fnuValCuotIni (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number;

   -- Medio de Pago Cuota Inicial
   function fsbMedPagCuotIni (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2;

   -- Cuota Inicial recibida por Vendedor
   function fsbCuoIniRecVende (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2;

   -- Predio anillado
   function fsbPredioAnillado (inuAddress   AB_ADDRESS.ADDRESS_ID%type) return varchar2;

   -- Fecha anillado
   function fsbFechaAnillado (inuAddress   AB_ADDRESS.ADDRESS_ID%type) return varchar2;
  --<<
  -- Arquitecsoft/mmoreno
  -- 01/11/2013
  -- Obtiene la descripcion del medio de pago de un package_id
  -->>
  FUNCTION FsbMedioPago (inuPackages   MO_PACKAGES.PACKAGE_ID%type) RETURN VARCHAR2;
  --<<
  -- Arquitecsoft/mmoreno
  -- 18/11/2013
  -- retorna los telefonos fijos asociados a un cliente.
  -->>
  FUNCTION fvaRetTelCliente(inusubscriber_id OPEN.ge_subscriber.subscriber_id%TYPE,
                            vaTipoTel VARCHAR2
                           ) RETURN VARCHAR2;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad           : fnuGetMultiHousing
    Descripcion      : Retornan el mercado relevante de una direccion
    Autor            : Carlos Alberto Ramírez
    Fecha            : 12-02-2014

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    12-02-2014  Arquitecsoft/carlosr
    Creación
  ******************************************************************/
    FUNCTION fnuGetMultiHousing
    (
        inuAddress_id    ab_address.address_id%TYPE
    )
    return number;

end LDC_PK_REP_VEN;
/
CREATE OR REPLACE package body adm_person.ldc_pk_rep_ven is
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad           : fnuMercaRelevan
    Descripcion      : Retornan el mercado relevante de una direccion
    Autor            :  Diego Fernando Rodriguez
    Fecha            :  05/06/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    csbVERSION                  CONSTANT VARCHAR2(10) := 'OSF-2884';

    FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END FSBVERSION;

-- Retornan el mercado relevante de una direccion
function fnuMercaRelevan ( inuAddress   AB_ADDRESS.ADDRESS_ID%type) return number
IS
   nuMerc   FA_LOCAMERE.LOMRMECO%type;

   cursor cuMercaRele is
      select M.LOMRMECO
        from AB_ADDRESS A,GE_GEOGRA_LOCATION L,FA_LOCAMERE M
       where A.GEOGRAP_LOCATION_ID = L.GEOGRAP_LOCATION_ID
         and L.GEOGRAP_LOCATION_ID = M.LOMRLOID
         and A.ADDRESS_ID = inuAddress;
begin
    for rcMercaRele in cuMercaRele loop
        nuMerc := rcMercaRele.LOMRMECO;
    end loop;

    return nuMerc;
end fnuMercaRelevan;
   --<<
   -- Arquitecsoft/mmoreno
   -- 01/11/2013
   -- Retornan el codigo del mercado relevante de una localidad
   -->>
  FUNCTION fnuMercaRelevanLo(inuge_geogra_location ge_geogra_location.geograp_location_id%TYPE)
    RETURN NUMBER  IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad           : fnuMercaRelevanLo
    Descripcion      : Retornan el codigo mercado relevante de una localidad
    Autor            : Arquitecsoft/mmoreno
    Fecha            :  01/11/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
    --<<
    -- Variables del proceso
    -->>
    nuMerc   FA_LOCAMERE.LOMRMECO%type;
    --<<
    -- Cursores del proceso.
    -->>
    CURSOR cuMercaRele IS
    SELECT M.LOMRMECO
      FROM GE_GEOGRA_LOCATION L,FA_LOCAMERE M
     WHERE L.GEOGRAP_LOCATION_ID = M.LOMRLOID
       AND L.GEOGRAP_LOCATION_ID = inuge_geogra_location;
BEGIN
    for rcMercaRele in cuMercaRele loop
        nuMerc := rcMercaRele.LOMRMECO;
    end loop;

    return nuMerc;

  END fnuMercaRelevanLo;

-- Retornan Nombre del mercado relevante de una direccion
function fsbNomMercaRelevan ( inuAddress   AB_ADDRESS.ADDRESS_ID%type) return varchar2
IS
   nuMerc   FA_MERCRELE.MEREDESC%type;

   cursor cuMercaRele is
      select R.MEREDESC
        from AB_ADDRESS A,GE_GEOGRA_LOCATION L,FA_LOCAMERE M,FA_MERCRELE R
       where A.GEOGRAP_LOCATION_ID = L.GEOGRAP_LOCATION_ID
         and L.GEOGRAP_LOCATION_ID = M.LOMRLOID
         and M.LOMRMECO = R.MERECODI
         and A.ADDRESS_ID = inuAddress;
begin
    for rcMercaRele in cuMercaRele loop
        nuMerc := rcMercaRele.MEREDESC;
    end loop;

    return nuMerc;
end fsbNomMercaRelevan;

   --<<
   -- Arquitecsoft/mmoreno
   -- 01/11/2013
   -- Retornan el nombre del mercado relevante de una localidad
   -->>
  FUNCTION fsbNombMercaRelevanLo(inuge_geogra_location ge_geogra_location.geograp_location_id%TYPE)
    RETURN VARCHAR2  IS
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad           : fsbNombMercaRelevanLo
    Descripcion      : Retornan el nombre del mercado relevante de una localidad
    Autor            : Arquitecsoft/mmoreno
    Fecha            :  01/11/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
    --<<
    -- Variables del proceso
    -->>
    vaMerc   FA_MERCRELE.MEREDESC%type;
    --<<
    -- Cursores del proceso
    -->>
    CURSOR cuMercaRele IS
    SELECT R.MEREDESC
      FROM GE_GEOGRA_LOCATION L,FA_LOCAMERE M,FA_MERCRELE R
       where L.GEOGRAP_LOCATION_ID = M.LOMRLOID
         and M.LOMRMECO = R.MERECODI
         and L.GEOGRAP_LOCATION_ID = inuge_geogra_location;
  BEGIN
    FOR rcMercaRele in cuMercaRele LOOP
        vaMerc := rcMercaRele.MEREDESC;
    END LOOP;

    RETURN vaMerc;

  END fsbNombMercaRelevanLo;

-- Retornan Nombre de la localidad
function fsbNomLocalidad ( inuGEOGRA_LOCATION   GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type) return varchar2
IS
    cursor cuLocalida is
       select DESCRIPTION
        from GE_GEOGRA_LOCATION
       where  GEOGRAP_LOCATION_ID = inuGEOGRA_LOCATION;

    sbCadena  GE_GEOGRA_LOCATION.DESCRIPTION%type;
begin

   for rcLocalida in cuLocalida loop
       sbCadena := rcLocalida.DESCRIPTION;
   end loop;

   return sbCadena;
end;

-- Retorna el departamento
function fnuDepartamento ( inuGEOGRA_LOCATION   GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type) return number
IS
    cursor cuLocalida is
       select GEO_LOCA_FATHER_ID
        from GE_GEOGRA_LOCATION
       where  GEOGRAP_LOCATION_ID = inuGEOGRA_LOCATION;

    nuDepa  GE_GEOGRA_LOCATION.GEO_LOCA_FATHER_ID%type;
begin
    for rcLocalida in cuLocalida loop
        nuDepa  := rcLocalida.GEO_LOCA_FATHER_ID;
    end loop;

    return nuDepa;

End fnuDepartamento;

-- Retorna el nombre del departamento
function fsbNomDepartamento ( inuGEOGRA_LOCATION   GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type) return Varchar2
IS
    cursor cuLocalida (inuGEOGRA_LOC   GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type) is
       select GEO_LOCA_FATHER_ID,DESCRIPTION
        from GE_GEOGRA_LOCATION
       where  GEOGRAP_LOCATION_ID = inuGEOGRA_LOC;

    cursor cuLocalida2 (inuGEOGRA_LOC   GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type) is
       select GEO_LOCA_FATHER_ID,DESCRIPTION
        from GE_GEOGRA_LOCATION
       where  GEOGRAP_LOCATION_ID = inuGEOGRA_LOC;

    nuDepa  GE_GEOGRA_LOCATION.GEO_LOCA_FATHER_ID%type;
    sbDepa  GE_GEOGRA_LOCATION.DESCRIPTION%type;
begin
    for rcLocalida in cuLocalida(inuGEOGRA_LOCATION) loop
        nuDepa  := rcLocalida.GEO_LOCA_FATHER_ID;

        for rcLocalida2 in cuLocalida2 (nuDepa) loop
            sbDepa := rcLocalida2.DESCRIPTION;
        end loop;

    end loop;

    return sbDepa;

End fsbNomDepartamento;

-- Retorna la Direccion de Instalacion
function fsbDireInstala ( inuAddress   AB_ADDRESS.ADDRESS_ID%type) return varchar2
IS
   sbDire   AB_ADDRESS.ADDRESS%type;

   cursor cuDire is
      select a.address
        from AB_ADDRESS A
       where  A.ADDRESS_ID = inuAddress;
begin
    for rcDire in cuDire loop
        sbDire := rcDire.address;
    end loop;

    return sbDire;

end fsbDireInstala;

-- Retorna la manzana
function fsbManzana ( inuAddress   AB_ADDRESS.ADDRESS_ID%type) return varchar2
IS
   nuManz   AB_SEGMENTS.BLOCK_ID%type;

   cursor cuManzana is
      select S.BLOCK_ID
        from AB_ADDRESS A,AB_SEGMENTS S
       where A.SEGMENT_ID = S.SEGMENTS_ID
         and A.ADDRESS_ID = inuAddress;
begin

    for rcManzana in cuManzana loop
        nuManz := rcManzana.BLOCK_ID;
    end loop;

    return nuManz;

end fsbManzana;

-- Retorna el Ciclo
function fnuCiclo ( inuAddress   AB_ADDRESS.ADDRESS_ID%type) return number
IS
   nuCiclo   AB_SEGMENTS.BLOCK_ID%type;

   cursor cuCiclo is
      select S.CICLCODI
        from AB_ADDRESS A,AB_SEGMENTS S
       where A.SEGMENT_ID = S.SEGMENTS_ID
         and A.ADDRESS_ID = inuAddress;
begin

    for rcCiclo in cuCiclo loop
        nuCiclo := rcCiclo.CICLCODI;
    end loop;

    return nuCiclo;

end fnuCiclo;

-- Retorna el Uso-Servicio
function fsbUsoServicio ( inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2
IS
   cursor cuUso is
      select decode(USAGE,1,'1-Residencial',2,'2-No residencial',USAGE) Uso
      from MO_GAS_SALE_DATA
     where PACKAGE_ID = inuPackages;

   sbUso Varchar2(200);
begin

   for rcUso in cuUso loop
       sbUso := rcUso.Uso;
   end loop;

   return sbUso;

end  fsbUsoServicio;

function fnuCate(nuProducto   servsusc.sesunuse%type) return number
is
    cursor cuCate is
       select cg.catecodi
         from servsusc ss,categori cg
         where ss.sesucate = cg.catecodi and ss.sesunuse = nuProducto and rownum < 2;

    nuCadeana categori.catecodi%type;
begin

    for rcCate in cuCate loop
         nuCadeana := rcCate.catecodi;
    end loop;

    -- Retorna el valor calculado
    return nuCadeana;

end fnuCate;

function fsbNombreCate(nuProducto   servsusc.sesunuse%type) return Varchar2
is
    cursor cuCate is
       select cg.catedesc
         from servsusc ss,categori cg
         where ss.sesucate = cg.catecodi and ss.sesunuse = nuProducto and rownum < 2;

    sbCadeana categori.catedesc%type;
begin

    for rcCate in cuCate loop
         sbCadeana := rcCate.catedesc;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

end fsbNombreCate;

-- Retorna la subcateoria
function fnuSubCate(nuProducto   servsusc.sesunuse%type)  return number
is
    cursor cuSubCategor is
      select sc.sucacodi
        from servsusc ss,subcateg sc
        where ss.sesusuca = sc.sucacodi
          and ss.sesucate = sc.sucacate
          and ss.sesunuse = nuProducto and rownum <2;

    nuCadeana subcateg.sucacodi%type;
begin

    for rcSubCategor in cuSubCategor loop
         nuCadeana := rcSubCategor.sucacodi;
    end loop;

    -- Retorna el valor calculado
    return nuCadeana;

end fnuSubCate;

-- Retorna el nombre de la subcateoria
function fsbSubCate(nuProducto   servsusc.sesunuse%type)  return Varchar2
is
    cursor cuSubCategor is
      select sc.sucadesc  description
        from servsusc ss,subcateg sc
        where ss.sesusuca = sc.sucacodi
          and ss.sesucate = sc.sucacate
          and ss.sesunuse = nuProducto and rownum <2;

    sbCadeana Varchar2(2000);
begin

    for rcSubCategor in cuSubCategor loop
         sbCadeana := rcSubCategor.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

end fsbSubCate;

-- Barrio
function fnuBarrio (inuAddress   AB_ADDRESS.ADDRESS_ID%type)  return number
is

   nuBarrio   AB_SEGMENTS.BLOCK_ID%type;

   cursor cuBarrio is
      select S.NEIGHBORHOOD_ID
        from AB_ADDRESS A,AB_SEGMENTS S
       where A.SEGMENT_ID = S.SEGMENTS_ID
         and A.ADDRESS_ID = inuAddress;
begin

    for rcBarrio in cuBarrio loop
        nuBarrio := rcBarrio.NEIGHBORHOOD_ID;
    end loop;

    return nuBarrio;

end fnuBarrio;

-- Barrio
function fsbBarrio (inuAddress   AB_ADDRESS.ADDRESS_ID%type)  return varchar2
is

   nuBarrio   AB_SEGMENTS.BLOCK_ID%type;
   sbBarrio   GE_GEOGRA_LOCATION.DESCRIPTION%type;

   cursor cuBarrio is
      select S.NEIGHBORHOOD_ID
        from AB_ADDRESS A,AB_SEGMENTS S
       where A.SEGMENT_ID = S.SEGMENTS_ID
         and A.ADDRESS_ID = inuAddress;

   cursor cuNombreBarrio (inuBarrio  AB_SEGMENTS.NEIGHBORHOOD_ID%type) is
      select description
        from GE_GEOGRA_LOCATION
       where GEOGRAP_LOCATION_ID =inuBarrio;
begin

    for rcBarrio in cuBarrio loop
        nuBarrio := rcBarrio.NEIGHBORHOOD_ID;

        for rcNombreBarrio in cuNombreBarrio(nuBarrio) loop
           sbBarrio := rcNombreBarrio.Description;
        end loop;

    end loop;

    return sbBarrio;

end fsbBarrio;

-- Retorna el estado de la solicitud
function fsbEstadoSolicitud(nucodigo PS_MOTIVE_STATUS.MOTIVE_STATUS_ID%type)  return Varchar2
is
    cursor cuEstadoSolicitud is
      select MOTIVE_STATUS_ID||'-'||DESCRIPTION Cadena
        from PS_MOTIVE_STATUS
        where MOTIVE_STATUS_ID = nucodigo;

    sbCadeana Varchar2(2000);
begin

    for rcEstadoSolicitud in cuEstadoSolicitud loop
         sbCadeana := rcEstadoSolicitud.Cadena;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

end fsbEstadoSolicitud;

-- Asesor
function fsbAsesor(nucodigo GE_PERSON.PERSON_ID%type)  return Varchar2
is
    cursor cuPerson is
      select NAME_ Cadena
        from GE_PERSON
        where PERSON_ID = nucodigo;

    sbCadeana Varchar2(2000);
begin

    for rcPerson in cuPerson loop
         sbCadeana := rcPerson.Cadena;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

end fsbAsesor;

-- Unidad de Trabajo
function fsbUnidaTrabajo (nucodigo or_operating_unit.operating_unit_id%type)  return Varchar2
is
    cursor cuUnidadTrabajo is
      select name Cadena
        from or_operating_unit
        where operating_unit_id = nucodigo;

    sbCadeana Varchar2(2000);
begin

    for rcUnidadTrabajo in cuUnidadTrabajo loop
         sbCadeana := rcUnidadTrabajo.Cadena;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

end fsbUnidaTrabajo;

function fnuContratista (nucodigo or_operating_unit.operating_unit_id%type)  return number
is
    cursor cuUnidadTrabajo is
      select contractor_id
        from or_operating_unit
        where operating_unit_id = nucodigo;

    nuCadeana or_operating_unit.contractor_id%type;
begin

    for rcUnidadTrabajo in cuUnidadTrabajo loop
         nuCadeana := rcUnidadTrabajo.contractor_id;
    end loop;

    -- Retorna el valor calculado
    return nuCadeana;

end fnuContratista;

-- Nombre del contratiista
function fsbContratista (nucodigo or_operating_unit.operating_unit_id%type)  return varchar2
is
   nuCadeana or_operating_unit.contractor_id%type;

   cursor cuContratista (inuContratista ge_contratista.id_contratista%type) is
      select nombre_contratista
        from ge_contratista
        where id_contratista = inuContratista;
   sbContratista ge_contratista.nombre_contratista%type;

begin
    nuCadeana := LDC_PK_REP_VEN.fnuContratista(nucodigo);

    for rcContratista in cuContratista(nuCadeana) loop
       sbContratista := rcContratista.Nombre_Contratista;
    end loop;

    -- Retorna el valor calculado
    return sbContratista;

end fsbContratista;

-- Tipo de identificacion del cliente
function fsbTipoIdentCliente (inucodigo or_operating_unit.operating_unit_id%type)  return varchar2
is

   cursor cuTipoIdentCliente is
      select IDENT_TYPE_ID||'-'||DESCRIPTION Cadena
        from GE_IDENTIFICA_TYPE
        where IDENT_TYPE_ID = inucodigo;

   sbContratista Varchar2(2000);
begin

    for rcTipoIdentCliente in cuTipoIdentCliente loop
       sbContratista := rcTipoIdentCliente.Cadena;
    end loop;

    -- Retorna el valor calculado
    return sbContratista;

end fsbTipoIdentCliente;

-- Tipo de cliente
function fsbTipoCliente (inucodigo GE_SUBSCRIBER_TYPE.SUBSCRIBER_TYPE_ID%type)  return varchar2
is

   cursor cuTipoCliente is
      select DESCRIPTION
        from GE_SUBSCRIBER_TYPE
        where SUBSCRIBER_TYPE_ID = inucodigo;

   sbTipoCliente GE_SUBSCRIBER_TYPE.DESCRIPTION%type;
begin

    for rcTipoCliente in cuTipoCliente loop
       sbTipoCliente := rcTipoCliente.DESCRIPTION;
    end loop;

    -- Retorna el valor calculado
    return sbTipoCliente;

end fsbTipoCliente;

-- Solisitud de Cotizacion

/******************************************************************************
    ------------------------------
    Historial de Modificaciones
    ------------------------------
    Fecha   Nombre
    Modificación
    ---------------------------------------------------------------------------
    17-12-2013  carlosr
    Se modifica para que traiga solo el paquete de tipo solicitud

******************************************************************************/
function fnuSolicituCoti ( inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number
IS
   cursor cuSoli is
        SELECT  PACKAGE_ID_ASSO
        FROM    mo_packages_asso asso,mo_packages pkg
        WHERE   asso.package_id= inuPackages
        AND     pkg.package_id = asso.package_id_asso
        AND     pkg.package_type_id = 303;

   nuSoli mo_packages_asso.package_id%type;
begin

   for rcSoli in cuSoli loop
       nuSoli := rcSoli.PACKAGE_ID_ASSO;
   end loop;

   return nuSoli;

end  fnuSolicituCoti;

-- Zona
function fsbZona ( inuparser_address_id mo_address.parser_address_id%type) return varchar2
IS
    cursor cuZona is
        select l.is_zona
          from ab_address a,LDC_INFO_PREDIO l
         where a.estate_number = l.PREMISE_ID
           and a.address_id = inuparser_address_id;
   --<<
   -- Se modifica el tipo de dato.
   -->>
   sbZona VARCHAR2(2000);
begin

   for rcZona in cuZona loop
       sbZona := rcZona.is_zona;

       if (sbZona = 'S') then
          sbZona := 'S-Zona saturada';
       elsif (sbZona = 'N') then
          sbZona := 'N-Zona nueva';
       end if;

   end loop;

   return sbZona;

end  fsbZona;

-- Cotizacion
/******************************************************************************
    ------------------------------
    Historial de Modificaciones
    ------------------------------
    Fecha   Nombre
    Modificación
    ---------------------------------------------------------------------------
    17-12-2013  carlosr
    Se modifica para que traiga solo las cotizaciones Aprobadas y Aceptadas

******************************************************************************/
function fnuCotizacion ( inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2
IS

    CURSOR cuCoti
    IS
        SELECT  quotation_id||' - '||description
        FROM    cc_quotation
        WHERE   PACKAGE_id = inuPackages
        AND     status in ('A','C')   ;

    nuCoti varchar2(4000);
begin

/*
   for rcSoli in cuSoli loop
       for rcCoti in cuCoti(rcSoli.PACKAGE_ID_ASSO) loop
           nuCoti := rcCoti.Quotation_Id;
       end loop;
   end loop;
*/
    open cuCoti;
    fetch cuCoti INTO nuCoti;
    close cuCoti;

    return nuCoti;

end  fnuCotizacion;

-- Empresa Cliente
function fsbEmpreCliente (nuContrato   suscripc.susccodi%type) return varchar2
IS
    cursor cuEmprCliente is
        select COMPANY
          from ge_subs_work_relat g
         where subscriber_id = nuContrato;

   sbEmpsCliente ge_subs_work_relat.COMPANY%type;
begin

   for rcEmprCliente in cuEmprCliente loop
       sbEmpsCliente := rcEmprCliente.Company;
   end loop;

   return sbEmpsCliente;

end  fsbEmpreCliente;

-- Cargos Cliente
function fsbCargoCliente (nuContrato   suscripc.susccodi%type) return varchar2
IS
    cursor cuCargCliente is
        select g.title
          from ge_subs_work_relat g
         where subscriber_id = nuContrato;

   sbCargoCliente ge_subs_work_relat.title%type;
begin

   for rcCargCliente in cuCargCliente loop
       sbCargoCliente := rcCargCliente.title;
   end loop;


   return sbCargoCliente;

end  fsbCargoCliente;
-- Numero Persona Hogar
function fnuPerHogar (nuContrato   suscripc.susccodi%type) return number
IS
    cursor cuPersoCargo is
        select g.number_depend_people
          from ge_subs_family_data g
         where g.subscriber_id = nuContrato;

   nuPerHogar ge_subs_family_data.number_depend_people%type;
begin

   for rcPersoCargo in cuPersoCargo loop
       nuPerHogar := rcPersoCargo.number_depend_people;
   end loop;

   return nuPerHogar;

end  fnuPerHogar;

-- Energetico anterior
function fsbEnergAnte (nuContrato   suscripc.susccodi%type) return varchar2
IS
    cursor cuDatos is
        select g.service_name
          from ge_third_part_serv g
         where g.subscriber_id = nuContrato;

   sbDato ge_subs_general_data.old_operator%type;
begin

   for rcDatos in cuDatos loop
       sbDato := rcDatos.Service_Name;
   end loop;

   return sbDato;

end  fsbEnergAnte;

-- Energetico anterior Costo Mensual
function fsbEnergAnteCM (nuContrato   suscripc.susccodi%type) return varchar2
IS
    cursor cuDatos is
        select g.monthly_cost
          from ge_third_part_serv g
         where g.subscriber_id = nuContrato;

   sbDato ge_subs_general_data.old_operator%type;
begin

   for rcDatos in cuDatos loop
       sbDato := rcDatos.monthly_cost;
   end loop;

   return sbDato;

end  fsbEnergAnteCM;

-- Energetico anterior Tiempo con el Energetico
function fsbEnergAnteTE (nuContrato   suscripc.susccodi%type) return varchar2
IS
    cursor cuDatos is
        select g.service_time
          from ge_third_part_serv g
         where g.subscriber_id = nuContrato;

   sbDato ge_subs_general_data.old_operator%type;
begin

   for rcDatos in cuDatos loop
       sbDato := rcDatos.service_time;
   end loop;

   return sbDato;

end  fsbEnergAnteTE;

-- Tipo de Vivienda
function fsbTipoVivien (nuContrato   suscripc.susccodi%type) return varchar2
IS
    --<<
    -- arquitecsoft/mmoreno
    -- 01/11/2013
    -- Se adicina el separador del codigo y descripcion
    -->>
    cursor cuDatos is
        select g.house_type_id||' - '||h.description Cadena
          from ge_subs_housing_data g,ge_house_type h
          where g.HOUSE_TYPE_ID = h.house_type_id
          and  g.subscriber_id = nuContrato;

   sbDato Varchar2(2000);
begin

   for rcDatos in cuDatos loop
       sbDato := rcDatos.Cadena;
   end loop;


   return sbDato;

end  fsbTipoVivien;
-- Nombre de propietario del predio
function fsbNombrePropi (nuContrato suscripc.susccodi%type) return varchar2
IS
    cursor cuDatos is
        select renter_name
          from ge_subs_housing_data g
          where g.subscriber_id = nuContrato;

   sbDato ge_subs_housing_data.renter_name%type;
begin

   for rcDatos in cuDatos loop
       sbDato := rcDatos.renter_name;
   end loop;

   return sbDato;

end  fsbNombrePropi;

-- Telefono de contacto
function fsbTelCont (nuContrato suscripc.susccodi%type) return varchar2
IS
    cursor cuDatos is
        select phone
          from ge_subs_phone g
          where g.subscriber_id = nuContrato;

   sbDato ge_subs_phone.phone%type;
begin

   for rcDatos in cuDatos loop
       sbDato := rcDatos.phone;
   end loop;

   return sbDato;

end  fsbTelCont;

-- Referencia
function fsbReferencia (nuContrato suscripc.susccodi%type) return varchar2
IS
    cursor cuDatos is
        select ' ['||reference_type_id||'_'||ident_type_id||'_'||identification||'_'||name_||'_'||phone||'] '||chr(10) cadena
          from ge_subs_referen_data g
          where g.subscriber_id = nuContrato;

   sbDato Varchar2(4000);
begin

   for rcDatos in cuDatos loop
       sbDato := sbDato||rcDatos.cadena;
   end loop;

   return sbDato;

end  fsbReferencia;

-- Tipo de Instalacion
function fsbTipoInstal (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2
IS
    cursor cuDatos is
        select decode(INSTALL_TYPE,1,'1-A la vIsta',2,'2-Empotrado',INSTALL_TYPE) cadena
          from MO_GAS_SALE_DATA g
          where g.package_id = inuPackages;

   sbDato Varchar2(2000);
begin

   for rcDatos in cuDatos loop
       sbDato := rcDatos.cadena;
   end loop;

   return sbDato;

end  fsbTipoInstal;

-- Nombre del plan comercial
function fsbPlanComercial (inuCodigo   cc_commercial_plan.commercial_plan_id%type) return varchar2
IS
    cursor cuDatos is
        select description
          from cc_commercial_plan g
          where g.commercial_plan_id = inuCodigo;

   sbDato Varchar2(2000);
begin

   for rcDatos in cuDatos loop
       sbDato := rcDatos.description;
   end loop;

   return sbDato;

end  fsbPlanComercial;

-- Promociones
function fsbPromociones (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2
IS
    cursor cuDatos is
        select '['||description||'-'||c.description||'] '||chr(10) cadena
          from mo_motive m,mo_motivo_promocion mp,cc_promotion c
         where m.MOTIVE_ID = mp.ID_MOTIVO
           and mp.id_promocion = c.promotion_id
           and m.package_id = inuPackages;

   sbDato Varchar2(4000);
begin

   for rcDatos in cuDatos loop
       sbDato := sbDato||rcDatos.cadena;
   end loop;

   return sbDato;

end  fsbPromociones;

-- Plan de Financiacion
function fnuPlanFinan (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number
IS
    cursor cuDatos is
        select g.financing_plan_id
          from cc_sales_financ_cond g
         where g.package_id = inuPackages;

   nuDato number;
begin

   for rcDatos in cuDatos loop
       nuDato := rcDatos.financing_plan_id;
   end loop;

   return nuDato;

end  fnuPlanFinan;

-- Nombre del Plan de Financiacion
function fsbPlanFinan (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2
IS
    cursor cuDatos is
        select p.pldidesc
          from cc_sales_financ_cond g,PLANDIFE p
         where g.financing_plan_id = p.PLDICODI
           and g.package_id = inuPackages;

   sbDato PLANDIFE.pldidesc%type;
begin

   for rcDatos in cuDatos loop
       sbDato := rcDatos.pldidesc;
   end loop;

   return sbDato;

end  fsbPlanFinan;

-- Valor Total de Venta
function fnuValorVenta (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number
IS
    cursor cuDatos is
        select TOTAL_VALUE
          from MO_GAS_SALE_DATA g
         where g.PACKAGE_ID = inuPackages;

   nuDato MO_GAS_SALE_DATA.TOTAL_VALUE%type;
begin

   for rcDatos in cuDatos loop
       nuDato := rcDatos.TOTAL_VALUE;
   end loop;

   return nuDato;

end  fnuValorVenta;

-- Valor Descuento
function fnuValorDescuento (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number
IS
    cursor cuDatos is
        select total_disc_value
          from cc_quotation g
         where g.PACKAGE_ID = inuPackages;

    cursor cuDatos1 is
        SELECT sum(cargvalo) Valor
        FROM cargos a, cc_promotion b, mo_mot_promotion c, mo_motive d, cc_prom_detail e
        WHERE d.package_id= inuPackages
        AND d.motive_id=c.motive_id
        AND  b.promotion_id=c.promotion_id
        AND d.product_id= a.cargnuse
        AND cargdoso='PP-'||inuPackages
        AND b.promotion_id=e.promotion_id
        AND cargconc=e.concept_id;

   nuDato cc_quotation.total_disc_value%type := 0;
begin

   for rcDatos in cuDatos loop
       nuDato := rcDatos.total_disc_value;
   end loop;

   for rcDatos1 in cuDatos1 loop
       nuDato := rcDatos1.Valor;
   end loop;

   return nuDato;

end  fnuValorDescuento;

-- Valor Cuota Inicial
function fnuValorCuoInic (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number
IS
    cursor cuDatos is
        select INITIAL_PAYMENT
          from MO_GAS_SALE_DATA g
         where g.PACKAGE_ID = inuPackages;

   nuDato cc_quotation.total_disc_value%type;
begin

   for rcDatos in cuDatos loop
       nuDato := rcDatos.INITIAL_PAYMENT;
   end loop;

   return nuDato;

end  fnuValorCuoInic;

-- Numero de Cuotas
function fnuNumeCuotas (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number
IS
    cursor cuDatos is
        select quotas_number
          from cc_sales_financ_cond g
         where g.PACKAGE_ID = inuPackages;

   nuDato cc_sales_financ_cond.quotas_number%type;
begin

   for rcDatos in cuDatos loop
       nuDato := rcDatos.quotas_number;
   end loop;

   return nuDato;

end  fnuNumeCuotas;

-- Valor a financiar
function fnuValFinanc (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number
IS
    cursor cuDatos is
        select value_to_finance
          from cc_sales_financ_cond g
         where g.PACKAGE_ID = inuPackages;

   nuDato cc_sales_financ_cond.value_to_finance%type;
begin

   for rcDatos in cuDatos loop
       nuDato := rcDatos.value_to_finance;
   end loop;

   return nuDato;

end  fnuValFinanc;

-- Valor Cuota Inicial
function fnuValCuotIni (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return number
IS
    cursor cuDatos is
        select average_quote_value
          from cc_sales_financ_cond g
         where g.PACKAGE_ID = inuPackages;

   nuDato cc_sales_financ_cond.average_quote_value%type;
begin

   for rcDatos in cuDatos loop
       nuDato := rcDatos.average_quote_value;
   end loop;

   return nuDato;

end  fnuValCuotIni;

-- Medio de Pago Cuota Inicial
function fsbMedPagCuotIni (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2
IS
    cursor cuDatos is
        select INIT_PAYMENT_MODE
          from MO_GAS_SALE_DATA g
         where g.PACKAGE_ID = inuPackages;

   sbDato MO_GAS_SALE_DATA.INIT_PAYMENT_MODE%type;
begin

   for rcDatos in cuDatos loop
       sbDato := rcDatos.INIT_PAYMENT_MODE;
   end loop;

   return sbDato;

end  fsbMedPagCuotIni;

-- Cuota Inicial recibida por Vendedor
function fsbCuoIniRecVende (inuPackages   MO_PACKAGES.PACKAGE_ID%type) return varchar2
IS
    cursor cuDatos is
        select INIT_PAY_RECEIVED
          from MO_GAS_SALE_DATA g
         where g.PACKAGE_ID = inuPackages;

   nuDato MO_GAS_SALE_DATA.INIT_PAY_RECEIVED%type;
begin

   for rcDatos in cuDatos loop
       nuDato := rcDatos.INIT_PAY_RECEIVED;
   end loop;

   return nuDato;

end  fsbCuoIniRecVende;

-- Predio anillado
/******************************************************************************
    ------------------------------
    Historial de Modificaciones
    ------------------------------
    Fecha   Nombre
    Modificación
    ---------------------------------------------------------------------------
    18-12-2013  carlosr
    Se modifica para hacer bien los join entre las tablas

******************************************************************************/

function fsbPredioAnillado (inuAddress   AB_ADDRESS.ADDRESS_ID%type) return varchar2
IS
    cursor cuDatos is
        select i.IS_RING
        from ab_address a,AB_PREMISE ap,ab_info_premise i
        where a.estate_number = ap.premise_id
        and i.premise_id = ap.premise_id
        and a.address_id = inuAddress;

   sbDato ab_info_premise.IS_RING%type;
begin

   for rcDatos in cuDatos loop
       sbDato := rcDatos.IS_RING;
   end loop;

   return sbDato;

end  fsbPredioAnillado;

-- Fecha anillado

/******************************************************************************
    ------------------------------
    Historial de Modificaciones
    ------------------------------
    Fecha   Nombre
    Modificación
    ---------------------------------------------------------------------------
    18-12-2013  carlosr
    Se modifica para hacer bien los join entre las tablas

******************************************************************************/
function fsbFechaAnillado (inuAddress   AB_ADDRESS.ADDRESS_ID%type) return varchar2
IS
    cursor cuDatos is
        select i.DATE_RING
        from ab_address a,AB_PREMISE ap,ab_info_premise i
        where a.estate_number = ap.premise_id
        and i.premise_id = ap.premise_id
        and a.address_id = inuAddress;

   sbDato ab_info_premise.DATE_RING%type;
begin

   for rcDatos in cuDatos loop
       sbDato := to_char(rcDatos.DATE_RING,'DD-MM-YYYY');
   end loop;

   return sbDato;

end  fsbFechaAnillado;

  --<<
  -- Arquitecsoft/mmoreno
  -- 01/11/2013
  -- Obtiene la descripcion del medio de pago de un package_id
  -->>
  FUNCTION FsbMedioPago (inuPackages   MO_PACKAGES.PACKAGE_ID%type) RETURN VARCHAR2 IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad           : FsbMedioPago
    Descripcion      : Retornan el la descripcion
    Autor            : Arquitecsoft/mmoreno
    Fecha            :  01/11/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
    --<<
    -- Variables del proceso
    -->>
    vaMedioPago  OPEN.FORMPAGO.fopadesc%TYPE;
    --<<
    -- Cursores del proceso
    -->>
    -- Obtiene la descripcion del medio de pago de  un package_id
    -->>
    CURSOR cuDatos IS
    SELECT INIT_PAYMENT_MODE
      FROM MO_GAS_SALE_DATA g
     WHERE g.PACKAGE_ID = inuPackages;

   sbDato MO_GAS_SALE_DATA.INIT_PAYMENT_MODE%type;

  BEGIN

    FOR rcDatos in cuDatos LOOP
       sbDato := rcDatos.INIT_PAYMENT_MODE;
    END LOOP;

    --<<
    -- Si existe medio de pago obtiene la descripcion
    -->>
    IF sbDato IS NOT NULL THEN
      vaMedioPago := OPEN.pktblformpago.fsbgetdescription(sbDato);
    END IF;

    RETURN vaMedioPago;
  END FsbMedioPago;
  --<<
  -- Arquitecsoft/mmoreno
  -- 18/11/2013
  -- retorna los telefonos fijos asociados a un cliente.
  -->>
  FUNCTION fvaRetTelCliente(inusubscriber_id OPEN.ge_subscriber.subscriber_id%TYPE,
                            vaTipoTel VARCHAR2
                           ) RETURN VARCHAR2  IS
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad           : fvaRetTelCliente
    Descripcion      : Retorna los telefonos asociados a un cliente
    Autor            :  Millerlandy Moreno
    Fecha            :  18/11/2013

    Parametros de entrada
    vaTipoTel:  Indica el tipo de telefono que se desea consultar.
                F: Telefonos fijos del cliente
                C: Telefonos celular del cliente

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
    --<<
    -- Variables del proceso
    -->>
    vaTelefonos  VARCHAR2(2000) := NULL; -- Numero de telefono a retornar.
    --<<
    -- Cursores del proceso
    -->>
    --<<
    -- Retorna los telefonos fijos asociados a un cliente
    -->>
    CURSOR cuTelFijoCliente IS
    SELECT phone
      FROM OPEN.GE_SUBS_PHONE
     WHERE subscriber_id = inusubscriber_id
       AND phone_type_id IN (3,4);
    --<<
    -- Retorna los telefonos celulares asociados a un cliente
    -->>
    CURSOR cuTelCeluarCliente IS
    SELECT phone
      FROM OPEN.GE_SUBS_PHONE
     WHERE subscriber_id = inusubscriber_id
       AND phone_type_id IN (1,2);

  BEGIN
    --<<
    -- Valida que tipo de telefono se requiere
    -->>
    -- Telefono Fijo
    IF vaTipoTel = 'F' THEN
      --<<
      -- Carga la variable con los telefonos fijos
      -->>
      FOR rgcuTelFijoCliente IN cuTelFijoCliente LOOP
        IF vaTelefonos = NULL THEN
          vaTelefonos := rgcuTelFijoCliente.phone;
        ELSE
          vaTelefonos := vaTelefonos||'-'||rgcuTelFijoCliente.phone;
        END IF;

      END LOOP;
    END IF;
    -- Telefono Celuar
    IF vaTipoTel = 'C' THEN
      --<<
      -- Carga la variable con los telefonos celulares
      -->>
      FOR rgcuTelCeluarCliente IN cuTelCeluarCliente LOOP
        IF vaTelefonos = NULL THEN
          vaTelefonos := rgcuTelCeluarCliente.phone;
        ELSE
          vaTelefonos := vaTelefonos||'-'||rgcuTelCeluarCliente.phone;
        END IF;

      END LOOP;
    END IF;

    RETURN vaTelefonos;
  END fvaRetTelCliente;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad           : fnuGetMultiHousing
    Descripcion      : Retornan el mercado relevante de una direccion
    Autor            : Carlos Alberto Ramírez
    Fecha            : 12-02-2014

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    12-02-2014  Arquitecsoft/carlosr
    Creación
  ******************************************************************/
    FUNCTION fnuGetMultiHousing
    (
        inuAddress_id    ab_address.address_id%TYPE
    )
    return number
    IS
        CURSOR cuGetMultiHousing
        IS
            SELECT  multivivienda
            FROM    ldc_info_predio inf, ab_address abad
            WHERE   abad.estate_number = inf.premise_id
            AND     abad.address_id =  inuAddress_id;

        nuMultiHousing  number;
    BEGIN
        -- Se extrae la info
        open  cuGetMultiHousing;
        fetch cuGetMultiHousing INTO nuMultiHousing;
        close cuGetMultiHousing;

        -- Se retorna el valor
        return nuMultiHousing;

    EXCEPTION
        when others then
            return null;
    END fnuGetMultiHousing;

end LDC_PK_REP_VEN;
/
Prompt Otorgando permisos sobre ADM_PERSON.LDC_PK_REP_VEN
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('LDC_PK_REP_VEN'), 'ADM_PERSON');
END;
/
GRANT DEBUG on ADM_PERSON.LDC_PK_REP_VEN to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on ADM_PERSON.LDC_PK_REP_VEN to REXEOPEN;
GRANT EXECUTE on ADM_PERSON.LDC_PK_REP_VEN to RCONSULTA;
GRANT DEBUG on ADM_PERSON.LDC_PK_REP_VEN to RCONSULTA;
GRANT EXECUTE on ADM_PERSON.LDC_PK_REP_VEN to RSELSYS;
/
