CREATE OR REPLACE PACKAGE adm_person.GDO_ReporteConsumos
AS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
	29/30/2025				jerazomvm		OSF-4170: Se migra el procedimiento Processeprocastiinm 
													  al paquete pkg_uildc_procinclumas
    30/07/2024              PAcosta         OSF-2952: Cambio de esquema ADM_PERSON                              
    ****************************************************************/  

    PROCEDURE ProcessDLRHCCI;
    PROCEDURE ProcessCartdia;
    PROCEDURE ProcessCartconccierre;
    PROCEDURE Processevausucasti;
    PROCEDURE getLocalidadcast(id in number, description in varchar2, rfQuery OUT Constants.tyRefCursor);
    PROCEDURE getSubcategoriacast(id in number, description in varchar2, rfQuery OUT Constants.tyRefCursor);
    PROCEDURE ProcessLDRCVBM;
    PROCEDURE ProcessCartdiacontrato;
    PROCEDURE Processflujocaja;
END GDO_ReporteConsumos;
/
CREATE OR REPLACE PACKAGE BODY adm_person.GDO_ReporteConsumos
AS



    PROCEDURE ProcessDLRHCCI
    IS

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbFATHER_ADDRESS_ID ge_boInstanceControl.stysbValue;
    sbGEOGRAP_LOCATION_ID ge_boInstanceControl.stysbValue;
    sbCATECODI ge_boInstanceControl.stysbValue;
    sbSUCACODI ge_boInstanceControl.stysbValue;
    sbSUSCCODI ge_boInstanceControl.stysbValue;
    sbMARKETING_SEGMENT_ID ge_boInstanceControl.stysbValue;
    sbECONOMIC_ACTIVITY_ID ge_boInstanceControl.stysbValue;
    sbIDENTIFICATION ge_boInstanceControl.stysbValue;
    sbDIRECTORY_ID ge_boInstanceControl.stysbValue;
    sbPEFAANO ge_boInstanceControl.stysbValue;
    sbPEFACICL ge_boInstanceControl.stysbValue;
    sbPEFAMES ge_boInstanceControl.stysbValue;
    sbCOSANVEC ge_boInstanceControl.stysbValue;
    sbE_MAIL ge_boInstanceControl.stysbValue; -- E-Mail

    BEGIN

        sbFATHER_ADDRESS_ID := ge_boInstanceControl.fsbGetFieldValue ('AB_ADDRESS', 'FATHER_ADDRESS_ID');
        sbGEOGRAP_LOCATION_ID := ge_boInstanceControl.fsbGetFieldValue ('AB_ADDRESS', 'GEOGRAP_LOCATION_ID');
        sbCATECODI := ge_boInstanceControl.fsbGetFieldValue ('CATEGORI', 'CATECODI');
        sbSUCACODI := ge_boInstanceControl.fsbGetFieldValue ('SUBCATEG', 'SUCACODI');
        sbMARKETING_SEGMENT_ID := ge_boInstanceControl.fsbGetFieldValue ('GE_SUBSCRIBER', 'MARKETING_SEGMENT_ID');
        sbECONOMIC_ACTIVITY_ID := ge_boInstanceControl.fsbGetFieldValue ('GE_SUBSCRIBER', 'ECONOMIC_ACTIVITY_ID');
        sbIDENTIFICATION := ge_boInstanceControl.fsbGetFieldValue ('GE_SUBSCRIBER', 'IDENTIFICATION');
        sbSUSCCODI := ge_boInstanceControl.fsbGetFieldValue ('SUSCRIPC', 'SUSCCODI');
        sbDIRECTORY_ID := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'DIRECTORY_ID');
        sbPEFAANO := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAANO');
        sbPEFACICL := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFACICL');
        sbPEFAMES := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAMES');
        sbCOSANVEC := ge_boInstanceControl.fsbGetFieldValue ('FA_CONSSESA', 'COSANVEC');
        sbE_MAIL := ge_boInstanceControl.fsbGetFieldValue('GE_SUBSCRIBER', 'E_MAIL');
        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        if (sbFATHER_ADDRESS_ID is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Departamento');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbGEOGRAP_LOCATION_ID is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Localidad');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbCATECODI is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Categoria');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbSUCACODI is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Sub Categoria');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbMARKETING_SEGMENT_ID is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Segmento de mercado');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbECONOMIC_ACTIVITY_ID is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Actividad Economica');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbPEFAANO is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?o Inicial');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbPEFACICL is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?o Final');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbDIRECTORY_ID is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Directorio Reporte');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbE_MAIL is null) then
            Errors.SetError(cnuNULL_ATTRIBUTE, 'Correo de entrega');
            raise ex.CONTROLLED_ERROR;
        end if;

        ut_trace.trace('FIN GDO_ReporteConsumos.ProcessDLRHCCI', 15);

        EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessDLRHCCI;

PROCEDURE ProcessCartdia AS
 sbdepa ge_boInstanceControl.stysbValue;
 sbloca ge_boInstanceControl.stysbValue;
 sbtp ge_boInstanceControl.stysbValue;
 sbcicl ge_boInstanceControl.stysbValue;
 sbcate ge_boInstanceControl.stysbValue;
 sbsuca ge_boInstanceControl.stysbValue;
 sbedde ge_boInstanceControl.stysbValue;
 sbnucusa NUMBER(4);
 cnuNULL_ATTRIBUTE constant number := 2126;
BEGIN

 sbdepa := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEO_LOCA_FATHER_ID');
 sbloca := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEOGRAP_LOCATION_ID');
 sbtp := ge_boInstanceControl.fsbGetFieldValue ('PR_PRODUCT', 'PRODUCT_TYPE_ID');
 sbcate := ge_boInstanceControl.fsbGetFieldValue ('PR_PRODUCT', 'CATEGORY_ID');
 sbsuca := ge_boInstanceControl.fsbGetFieldValue ('PR_PRODUCT', 'SUBCATEGORY_ID');
 sbcicl := ge_boInstanceControl.fsbGetFieldValue ('CICLO', 'CICLCODI');
 sbedde := ge_boInstanceControl.fsbGetFieldValue ('CICLO', 'CICLCICO');


  ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        if (sbdepa is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Departamento');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbloca is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Localidad');
            raise ex.CONTROLLED_ERROR;
        end if;


        if (sbcate is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Categoria');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbsuca is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Subcategoria');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbtp is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Tipo de producto');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbcicl is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Ciclo del producto');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbedde is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Edad de deuda');
            raise ex.CONTROLLED_ERROR;
        end if;

 EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
END;

PROCEDURE ProcessCartconccierre AS
 sbpano ge_boInstanceControl.stysbValue;
 sbpmes ge_boInstanceControl.stysbValue;
 cnuNULL_ATTRIBUTE constant number := 2126;
BEGIN

 sbpano := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEO_LOCA_FATHER_ID');
 sbpmes := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEOGRAP_LOCATION_ID');

  ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        if (sbpano is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?o');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbpmes is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Mes');
            raise ex.CONTROLLED_ERROR;
        end if;

 EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
END;

PROCEDURE Processevausucasti AS
 sbdia ge_boInstanceControl.stysbValue;
 sbedin ge_boInstanceControl.stysbValue;
 sbedfi ge_boInstanceControl.stysbValue;
 sbdepa ge_boInstanceControl.stysbValue;
 sbloca ge_boInstanceControl.stysbValue;
 sbtp   ge_boInstanceControl.stysbValue;
 sbcate ge_boInstanceControl.stysbValue;
 sbsuca ge_boInstanceControl.stysbValue;
 cnuNULL_ATTRIBUTE constant number := 2126;
BEGIN
 sbdia := ge_boInstanceControl.fsbGetFieldValue ('SERVSUSC', 'SESUFEIN');
 sbedin := ge_boInstanceControl.fsbGetFieldValue ('SERVSUSC', 'SESUPLFA');
 sbedfi := ge_boInstanceControl.fsbGetFieldValue ('SERVSUSC', 'SESUDEPA');
 sbdepa := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEO_LOCA_FATHER_ID');
 sbloca := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEOGRAP_LOCATION_ID');
 sbtp := ge_boInstanceControl.fsbGetFieldValue ('SERVSUSC', 'SESUSERV');
 sbcate := ge_boInstanceControl.fsbGetFieldValue ('SERVSUSC', 'SESUCATE');
 sbsuca := ge_boInstanceControl.fsbGetFieldValue ('SERVSUSC', 'SESUSUCA');


  ------------------------------------------------
        -- Required Attributes
  ------------------------------------------------

-- Validamos el dia
 if (sbdia is null) then
     Errors.SetError (cnuNULL_ATTRIBUTE, 'Dia');
     raise ex.CONTROLLED_ERROR;
 end if;
-- Validamos edad deuda inicial
 if (sbedin is null) then
    Errors.SetError (cnuNULL_ATTRIBUTE, 'Edad deuda inicial');
    raise ex.CONTROLLED_ERROR;
 end if;
 -- Validamos edad deuda final
 if (sbedfi is null) then
     Errors.SetError (cnuNULL_ATTRIBUTE, 'Edad deuda final');
     raise ex.CONTROLLED_ERROR;
 end if;
 -- Validamos Departamento
 if (sbdepa is null) then
     Errors.SetError (cnuNULL_ATTRIBUTE, 'Departamento');
     raise ex.CONTROLLED_ERROR;
 end if;
 -- Validamos Localidad
 if (sbloca is null) then
     Errors.SetError (cnuNULL_ATTRIBUTE, 'Localidad');
     raise ex.CONTROLLED_ERROR;
 end if;
 -- Validamos Tipo de producto
 if (sbtp is null) then
     Errors.SetError (cnuNULL_ATTRIBUTE, 'Tipo de producto');
     raise ex.CONTROLLED_ERROR;
 end if;
  -- Validamos Categoria
  if (sbcate is null) then
      Errors.SetError (cnuNULL_ATTRIBUTE, 'Categoria');
      raise ex.CONTROLLED_ERROR;
  end if;
 -- Validamos Subcategoria
  if (sbsuca is null) then
      Errors.SetError (cnuNULL_ATTRIBUTE, 'Subcategoria');
      raise ex.CONTROLLED_ERROR;
  end if;

 EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
END;

 PROCEDURE getLocalidadcast(id in number, description in varchar2, rfQuery OUT Constants.tyRefCursor) AS


        sbSql           varchar2(2000) := '';
        sbInstance      Ge_BOInstanceControl.stysbName;
        nuUbicacion     AB_ADDRESS.FATHER_ADDRESS_ID%type;

    BEGIN

    ge_boinstancecontrol.getcurrentinstance(sbInstance);
    GE_BOInstanceControl.GetAttributeNewValue(sbInstance,Null,'GE_GEOGRA_LOCATION','GEO_LOCA_FATHER_ID',nuUbicacion);

    IF (nuUbicacion is null) THEN
        ge_boerrors.SetErrorCodeArgument(2741,'Por Favor Seleccione un Departamento');
    END IF;

    sbSql := 'select GEOGRAP_LOCATION_ID id, DESCRIPTION description
              from GE_GEOGRA_LOCATION
              where geog_loca_area_type = 3
              and geo_loca_father_id = '||nuUbicacion||' UNION ALL SELECT -1,''TODAS LAS LOCALIDADES'' FROM DUAL ORDER BY 1';

     OPEN rfQuery FOR sbSql;

     EXCEPTION
        when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
 END;
  PROCEDURE getSubcategoriacast(id in number, description in varchar2, rfQuery OUT Constants.tyRefCursor) AS
        sbSql           varchar2(2000) := '';
        sbInstance      Ge_BOInstanceControl.stysbName;
        nuCategoria     SUBCATEG.SUCACATE%type;

    BEGIN

    ge_boinstancecontrol.getcurrentinstance(sbInstance);
    GE_BOInstanceControl.GetAttributeNewValue(sbInstance,Null,'SERVSUSC','SESUCATE',nuCategoria);

    IF (nuCategoria is null) THEN
        ge_boerrors.SetErrorCodeArgument(2741,'Por Favor Seleccione una Categoria');
    END IF;

    sbSql := 'select sucacodi ID, sucadesc DESCRIPTION
                from subcateg
                where sucacate = '||nuCategoria;

    OPEN rfQuery FOR sbSql;

     EXCEPTION
        when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END getSubcategoriacast;

   PROCEDURE ProcessLDRCVBM AS
 sbpano ge_boInstanceControl.stysbValue;
 sbpmes ge_boInstanceControl.stysbValue;
 cnuNULL_ATTRIBUTE constant number := 2126;
BEGIN

 sbpano := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAANO');
 sbpmes := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAMES');


  ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        if (sbpano is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?o');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbpmes is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Mes');
            raise ex.CONTROLLED_ERROR;
        end if;

 EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
END;

PROCEDURE ProcessCartdiacontrato AS
 sbdia      ge_boInstanceControl.stysbValue;
 sbcontrato ge_boInstanceControl.stysbValue;
 cnuNULL_ATTRIBUTE constant number := 2126;
BEGIN
 sbdia := ge_boInstanceControl.fsbGetFieldValue ('SERVSUSC', 'SESUFEIN');
 sbcontrato := ge_boInstanceControl.fsbGetFieldValue ('SERVSUSC', 'SESUSUSC');

  ------------------------------------------------
        -- Required Attributes
  ------------------------------------------------

-- Validamos el dia
 if (sbdia is null) then
     Errors.SetError (cnuNULL_ATTRIBUTE, 'Dia');
     raise ex.CONTROLLED_ERROR;
 end if;
-- Validamos el contrato
 if (sbcontrato is null or sbcontrato < 1) then
    Errors.SetError (cnuNULL_ATTRIBUTE, 'Contrato');
    raise ex.CONTROLLED_ERROR;
 end if;
 EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
END ProcessCartdiacontrato;

PROCEDURE Processflujocaja AS
 sbpano    ge_boInstanceControl.stysbValue;
 sbpmes    ge_boInstanceControl.stysbValue;
 sbactive  ge_boInstanceControl.stysbValue;
 sbdirect  ge_boInstanceControl.stysbValue;
 sbnomarch ge_boInstanceControl.stysbValue;
 cnuNULL_ATTRIBUTE constant number := 2126;
BEGIN

 sbpano    := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEO_LOCA_FATHER_ID');
 sbpmes    := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEOGRAP_LOCATION_ID');
 sbactive  := ge_boInstanceControl.fsbGetFieldValue ('GE_SUBSCRIBER', 'ACTIVE');
 sbdirect  := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'PATH');
 sbnomarch := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'DESCRIPTION');

  ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        if (sbpano is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?o');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbpmes is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Mes');
            raise ex.CONTROLLED_ERROR;
        end if;

         if (nvl(sbactive,'N') IN('y','Y')) then
           IF (sbdirect IS NULL OR sbnomarch IS NULL) THEN
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Flag carga archivo sap esta activo('||nvl(sbactive,'N')||'), debe diligenciar los campos ruta y nombre de archivo.');
            raise ex.CONTROLLED_ERROR;
          end if;
        END IF;

 EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
END Processflujocaja;

END GDO_ReporteConsumos;
/
PROMPT Otorgando permisos de ejecucion a GDO_REPORTECONSUMOS
BEGIN
    pkg_utilidades.praplicarpermisos('GDO_REPORTECONSUMOS', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre GDO_REPORTECONSUMOS para reportes
GRANT EXECUTE ON adm_person.GDO_REPORTECONSUMOS TO rexereportes;
/
