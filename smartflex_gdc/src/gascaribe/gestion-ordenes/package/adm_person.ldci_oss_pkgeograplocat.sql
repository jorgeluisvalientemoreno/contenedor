CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_OSS_PKGEOGRAPLOCAT AS

/*
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : LDCI_OSS_PKGEOGRAPLOCAT
         AUTOR : OLSoftware / Carlos E. Virgen Londono
         FECHA : 20/06/2011
		RICEF : I046

 DESCRIPCION : Paquete de interfaz con SAP(PI), este paquete se encarga de
               recibir informacion de centros de costos.

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 carlosvl     09-04-2013  Creacion del paquete
 juanda       07-11-2013  Creacion de procedimiento de consulta de barrios
*/

  /* TODO enter package declarations (types, exceptions, methods etc) here */

-- procedimiento que notifica el registro de centro de costo
PROCEDURE proGetDepartamento(inuCodPais        in  GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type,
                             inuCodDepa        in  GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type,
																													orfGeographicData out LDCI_PKREPODATATYPE.tyRefcursor,
                             onuErrorCode      out GE_ERROR_LOG.ERROR_LOG_ID%type,
                             osbErrorMessage   out GE_ERROR_LOG.DESCRIPTION%type);

PROCEDURE proGetLocalidad(inuCodDepa        in  GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type,
                          inuCodLoca        in  GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type,
																										orfGeographicData out LDCI_PKREPODATATYPE.tyRefcursor,
                          onuErrorCode      out GE_ERROR_LOG.ERROR_LOG_ID%type,
                          osbErrorMessage   out GE_ERROR_LOG.DESCRIPTION%type);

PROCEDURE proGetBarrio(inuCodLoca        in  NUMBER,
                       inuCodBarrio      in  NUMBER,
                       orfGeographicData out LDCI_PKREPODATATYPE.tyRefcursor,
                       onuErrorCode      out NUMBER,
                       osbErrorMessage   out VARCHAR2);


END LDCI_OSS_PKGEOGRAPLOCAT;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_OSS_PKGEOGRAPLOCAT AS

PROCEDURE proGetDepartamento(inuCodPais        in  GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type,
                             inuCodDepa        in  GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type,
																													orfGeographicData out LDCI_PKREPODATATYPE.tyRefcursor,
                             onuErrorCode      out GE_ERROR_LOG.ERROR_LOG_ID%type,
                             osbErrorMessage   out GE_ERROR_LOG.DESCRIPTION%type) AS

/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_OSS_PKGEOGRAPLOCAT.proGetDepartamento
 * Tiquete : I046
 * Autor   : OLSoftware / Carlos E. Virgen Londono
 * Fecha   : 09/04/2013
 * Descripcion : Retorna los departamentos segun los parametros de consulta (Pais o departamento)
 *
 * Parametros:
 * inuCodPais: Codigo del pais
 * inuCodDepa: Codigo del departamento
 * orfGeographicData: Cursor referenciado con la informacion del departamento
 * onuErrorCode: Codigo de la excepcion
 * osbErrorMessage: Descripcion de la excepcion

 * Autor              Fecha         Descripcion
 * carlosvl           09-04-2013    Creacion del procedimiento
**/


	-- define variables
	nuCodPais        GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type;
	nuCodDepa        GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type;

	-- variables tipo registro
	reGEOGRAPHICDATA LDCI_PKREPODATATYPE.tyGeographicData;

BEGIN
	-- valida inicializacion de variables de entrada
	nuCodPais := nvl(inuCodPais,-1);
	nuCodDepa := nvl(inuCodDepa,-1);

 -- hace la consulta de los departamentos para cargar el cursor
	open orfGeographicData for
	 select Parent.GEOGRAP_LOCATION_ID PARENT_LOCATION_ID,
		       Parent.DESCRIPTION         PARENT_DESCRIPTION,
         Child.GEOGRAP_LOCATION_ID  CHILD_LOCATION_ID,
		       Child.DESCRIPTION	         CHILD_DESCRIPTION
				from GE_GEOGRA_LOCATION Child,
				     GE_GEOGRA_LOCATION Parent
			where Child.GEOGRAP_LOCATION_ID = decode(nuCodDepa, -1, Child.GEOGRAP_LOCATION_ID, nuCodDepa)
	    and Child.GEO_LOCA_FATHER_ID = decode(nuCodPais, -1, Child.GEO_LOCA_FATHER_ID, nuCodPais)
					and Child.GEO_LOCA_FATHER_ID = Parent.GEOGRAP_LOCATION_ID
					and Parent.GEOG_LOCA_AREA_TYPE = 1 -- pais
					and Child.GEOG_LOCA_AREA_TYPE = 2 -- departamento
					order by Child.DESCRIPTION;

	onuErrorCode := 0;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      rollback;
      OPEN orfGeographicData FOR
						  -- carga el registro con datos a la -1
				  SELECT  -1 PARENT_LOCATION_ID,
						       '-----------------------' PARENT_DESCRIPTION,
													-1 CHILD_LOCATION_ID,
						       '-----------------------' CHILD_DESCRIPTION
						  FROM DUAL where 1 = 2;
						onuErrorCode    := -1;
						osbErrorMessage := '[LDCI_OSS_PKGEOGRAPLOCAT.proGetDepartamento.EXCEP_NO_ENCONTRO_REGISTRO]: ' || chr(13) ||
																									'No se encontro registro con el criterio de busqueda ingresado.' || chr(13) ||
																									'PaÃ­s:         ' || nuCodPais	  || chr(13) ||
																									'Departamento: ' || nuCodDepa   || chr(13);
   WHEN OTHERS THEN
      rollback;
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
END proGetDepartamento;


PROCEDURE proGetLocalidad(inuCodDepa        in  GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type,
																										inuCodLoca        in  GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type,
																										orfGeographicData out LDCI_PKREPODATATYPE.tyRefcursor,
																										onuErrorCode      out GE_ERROR_LOG.ERROR_LOG_ID%type,
																										osbErrorMessage   out GE_ERROR_LOG.DESCRIPTION%type) AS

/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_OSS_PKGEOGRAPLOCAT.proGetLocalidad
 * Tiquete : I046
 * Autor   : OLSoftware / Carlos E. Virgen Londono
 * Fecha   : 09/04/2013
 * Descripcion : Retorna los departamentos segun los parametros de consulta (Pais o departamento)
 *
 * Parametros:
 * inuCodPais: Codigo del pais
 * inuCodDepa: Codigo del departamento
 * orfGeographicData: Cursor referenciado con la informacion del departamento
 * onuErrorCode: Codigo de la excepcion
 * osbErrorMessage: Descripcion de la excepcion

 * Autor              Fecha         Descripcion
 * carlosvl           09-04-2013    Creacion del procedimiento
**/


-- define variables
nuCodDepa GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type;
nuCodLoca GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type;

	-- variables tipo registro
	reGEOGRAPHICDATA LDCI_PKREPODATATYPE.tyGeographicData;

BEGIN

	-- valida inicializacion de variables de entrada
	nuCodDepa := nvl(inuCodDepa,-1);
	nuCodLoca := nvl(inuCodLoca,-1);


 -- hace la consulta de los departamentos para cargar el cursor
	open orfGeographicData for
	 select Parent.GEOGRAP_LOCATION_ID PARENT_LOCATION_ID,
		       Parent.DESCRIPTION         PARENT_DESCRIPTION,
         Child.GEOGRAP_LOCATION_ID  CHILD_LOCATION_ID,
		       Child.DESCRIPTION	         CHILD_DESCRIPTION
				from GE_GEOGRA_LOCATION Child,
				     GE_GEOGRA_LOCATION Parent
			where Child.GEOGRAP_LOCATION_ID = decode(nuCodLoca, -1, Child.GEOGRAP_LOCATION_ID, nuCodLoca)
	    and Child.GEO_LOCA_FATHER_ID = decode(nuCodDepa, -1, Child.GEO_LOCA_FATHER_ID, nuCodDepa)
					and Child.GEO_LOCA_FATHER_ID = Parent.GEOGRAP_LOCATION_ID
					and Parent.GEOG_LOCA_AREA_TYPE = 2 -- departamento
					and Child.GEOG_LOCA_AREA_TYPE = 3 -- localidad
					order by Child.DESCRIPTION;

 onuErrorCode := 0;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      OPEN orfGeographicData FOR
						  -- carga el registro con datos a la -1
						  SELECT -1 PARENT_LOCATION_ID, '-----------------' PARENT_DESCRIPTION,
								       -1 CHILD_LOCATION_ID, '-----------------' CHILD_DESCRIPTION
  						  FROM DUAL;
						onuErrorCode    := -1;
						osbErrorMessage := '[LDCI_OSS_PKGEOGRAPLOCAT.proGetLocalidad.EXCEP_NO_ENCONTRO_REGISTRO]: ' || chr(13) ||
																									'No se encontro registro con el criterio de busqueda ingresado.' || chr(13) ||
																									'Departamento: ' || nuCodDepa	  || chr(13) ||
																									'Localidad: ' || nuCodLoca   || chr(13);
   WHEN OTHERS THEN
      rollback;
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
END proGetLocalidad;

PROCEDURE proGetBarrio(inuCodLoca        in  NUMBER,
                       inuCodBarrio      in  NUMBER,
                       orfGeographicData out LDCI_PKREPODATATYPE.tyRefcursor,
                       onuErrorCode      out NUMBER,
                       osbErrorMessage   out VARCHAR2) AS
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_OSS_PKGEOGRAPLOCAT.proGetBarrio
 * Tiquete : I046
 * Autor   : OLSoftware / Juan David Aragon
 * Fecha   : 07/11/2013
 * Descripcion : Retorna los barrios segun los parametros de consulta (Localidad o barrio)
 *
 * Parametros:
 * inuCodLoca: Codigo de la localidad
 * inuCodBarrio: Codigo del barrio
 * orfGeographicData: Cursor referenciado con la informacion del barrio
 * onuErrorCode: Codigo de la excepcion
 * osbErrorMessage: Descripcion de la excepcion

 * Autor              Fecha         Descripcion
 * juanda             07-11-2013    Creacion del procedimiento
**/

-- define variables
nuCodLoca NUMBER(6,0);
nuCodBarrio NUMBER(6,0);

-- variables tipo registro
reGEOGRAPHICDATA LDCI_PKREPODATATYPE.tyGeographicData;

BEGIN

  -- Valida inicializacion de variables de entrada
	nuCodLoca := nvl(inuCodLoca,-1);
	nuCodBarrio := nvl(inuCodBarrio,-1);

  -- Realiza la consulta de los barrios para cargar el cursor
	open orfGeographicData for
	 SELECT Parent.GEOGRAP_LOCATION_ID PARENT_LOCATION_ID,
		      Parent.DESCRIPTION         PARENT_DESCRIPTION,
          Child.GEOGRAP_LOCATION_ID  CHILD_LOCATION_ID,
		      Child.DESCRIPTION	         CHILD_DESCRIPTION,
          Child.DISPLAY_DESCRIPTION  CHILD_DISPLAY_DESC
   FROM GE_GEOGRA_LOCATION Child,
	      GE_GEOGRA_LOCATION Parent
	 WHERE Child.GEOGRAP_LOCATION_ID = decode(nuCodBarrio, -1, Child.GEOGRAP_LOCATION_ID, nuCodBarrio)
	       and Child.GEO_LOCA_FATHER_ID = decode(nuCodLoca, -1, Child.GEO_LOCA_FATHER_ID, nuCodLoca)
				 and Child.GEO_LOCA_FATHER_ID = Parent.GEOGRAP_LOCATION_ID
				 and Parent.GEOG_LOCA_AREA_TYPE = 3 -- Localidad
				 and Child.GEOG_LOCA_AREA_TYPE = 5 -- Barrio
         order by Child.DESCRIPTION;

onuErrorCode := 0;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      OPEN orfGeographicData FOR
					  -- carga el registro con datos a la -1
					  SELECT -1 PARENT_LOCATION_ID, '-----------------' PARENT_DESCRIPTION,
						       -1 CHILD_LOCATION_ID, '-----------------' CHILD_DESCRIPTION
  				  FROM DUAL;
						onuErrorCode    := -1;
						osbErrorMessage := '[LDCI_OSS_PKGEOGRAPLOCAT.proGetBarrio.EXCEP_NO_ENCONTRO_REGISTRO]: ' || chr(13) ||
																									'No se encontro registro con el criterio de busqueda ingresado.' || chr(13) ||
																									'Localidad: ' || nuCodLoca	  || chr(13) ||
																									'Barrio: ' || nuCodBarrio   || chr(13);
   WHEN OTHERS THEN
      rollback;
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
END proGetBarrio;

END LDCI_OSS_PKGEOGRAPLOCAT;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_OSS_PKGEOGRAPLOCAT', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_OSS_PKGEOGRAPLOCAT to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_OSS_PKGEOGRAPLOCAT to INTEGRADESA;
/
