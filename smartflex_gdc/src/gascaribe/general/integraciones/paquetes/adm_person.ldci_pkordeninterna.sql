CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKORDENINTERNA AS

/*
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : LDCI_PKORDENINTERNA.sql
         AUTOR : OLSoftware / Carlos Virgen
         FECHA : 23/05/2013
		RICEF : I057

 DESCRIPCION : Paquete de interfaz con SAP(PI), este paquete se encarga de
               recibir informacion de ordenes internas.

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 carlosvl    23/05/2013  Creacion del paquete
*/

  /* TODO enter package declarations (types, exceptions, methods etc) here */

-- procedimiento que notifica una orden interna
PROCEDURE proCrearOrdenInterna(isbCodigo         IN LDCI_ORDENINTERNA.CODI_ORDEINTERNA%type,
                              isbClase          IN LDCI_ORDENINTERNA.CLAS_CRDEN%type,
                              isbAbierta        IN LDCI_ORDENINTERNA.ESTA_ABIERTA%type,
                              isbLiberada       IN LDCI_ORDENINTERNA.ESTA_LIBERADA%type,
                              isbCerradaTec     IN LDCI_ORDENINTERNA.ESTA_CERRADATEC%type,
                              isbCerrada        IN LDCI_ORDENINTERNA.ESTA_CERRADA%type,
                              isbEstadis        IN LDCI_ORDENINTERNA.TIPO_ESTADISTICA%type,
                              isbCentro         IN LDCI_ORDENINTERNA.CODI_CEBE%type,
                              isbDescripcion    IN LDCI_ORDENINTERNA.DESC_ORDEINTERNA%type);


END LDCI_PKORDENINTERNA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKORDENINTERNA AS


PROCEDURE proCrearOrdenInterna(isbCodigo         IN LDCI_ORDENINTERNA.CODI_ORDEINTERNA%type,
                              isbClase          IN LDCI_ORDENINTERNA.CLAS_CRDEN%type,
                              isbAbierta        IN LDCI_ORDENINTERNA.ESTA_ABIERTA%type,
                              isbLiberada       IN LDCI_ORDENINTERNA.ESTA_LIBERADA%type,
                              isbCerradaTec     IN LDCI_ORDENINTERNA.ESTA_CERRADATEC%type,
                              isbCerrada        IN LDCI_ORDENINTERNA.ESTA_CERRADA%type,
                              isbEstadis        IN LDCI_ORDENINTERNA.TIPO_ESTADISTICA%type,
                              isbCentro         IN LDCI_ORDENINTERNA.CODI_CEBE%type,
                              isbDescripcion    IN LDCI_ORDENINTERNA.DESC_ORDEINTERNA%type) as


/*
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : LDCI_PKORDENINTERNA.proCrearOrdenInterna
         AUTOR : OLSoftware / Carlos Virgen
         FECHA : 23/05/2013
		RICEF : I057

 DESCRIPCION : Paquete de interfaz con SAP(PI), este paquete se encarga de
               recibir informacion de ordenes internas.

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 carlosvl    23/05/2013  Creacion del paquete
*/


	onuErrorCode    GE_ERROR_LOG.ERROR_LOG_ID%type;
	osbErrorMessage GE_ERROR_LOG.DESCRIPTION%type;
 -- definicion de cursores
	CURSOR cuLDCI_ORDENINTERNA(isbCodigo LDCI_ORDENINTERNA.CODI_ORDEINTERNA%type) is
					SELECT *
							FROM LDCI_ORDENINTERNA
						WHERE CODI_ORDEINTERNA=isbCodigo;

	-- registro del cursor
	reLDCI_ORDENINTERNA cuLDCI_ORDENINTERNA%rowtype;

BEGIN
 -- valida que la orden interna que se esta notificando exista
	OPEN cuLDCI_ORDENINTERNA(trim(isbCodigo));
	FETCH cuLDCI_ORDENINTERNA INTO reLDCI_ORDENINTERNA;


	IF (cuLDCI_ORDENINTERNA%notfound) THEN
	   --  crea el nuevo registro de orden interna
				INSERT INTO LDCI_ORDENINTERNA (CODI_ORDEINTERNA,
																																		CLAS_CRDEN,
																																		ESTA_ABIERTA,
																																		ESTA_LIBERADA,
																																		ESTA_CERRADATEC,
																																		ESTA_CERRADA,
																																		TIPO_ESTADISTICA,
																																		CODI_CEBE,
																																		DESC_ORDEINTERNA)
																									VALUES (trim(isbCodigo),
																																	isbClase,
																																	isbAbierta,
																																	isbLiberada,
																																	isbCerradaTec,
																																	isbCerrada,
																																	isbEstadis,
																																	isbCentro,
																																	upper(isbDescripcion)
																												);
		ELSE
    -- actualiza el registro existente
				UPDATE LDCI_ORDENINTERNA
						SET     CLAS_CRDEN       = isbClase,
														ESTA_ABIERTA     = isbAbierta,
														ESTA_LIBERADA    = isbLiberada,
														ESTA_CERRADATEC  = isbCerradaTec,
														ESTA_CERRADA     = isbCerrada,
														TIPO_ESTADISTICA = isbEstadis,
														CODI_CEBE        = isbCentro,
														DESC_ORDEINTERNA=upper(isbDescripcion)
						WHERE CODI_ORDEINTERNA=trim(isbCodigo);

	END IF; -- IF (cuLDCI_ORDENINTERNA%notfound) THEN;
	CLOSE cuLDCI_ORDENINTERNA;

 onuErrorCode := 0;

EXCEPTION
   WHEN OTHERS THEN
      rollback;

						 onuErrorCode    := -20001;
							osbErrorMessage := '[LDCI_PKORDENINTERNA.proCrearOrdenInterna]: Error no controlado: ' || chr(13) || SQLERRM;
       Errors.seterror (onuErrorCode, osbErrorMessage);
       raise_application_error(onuErrorCode, osbErrorMessage);
END proCrearOrdenInterna;


END LDCI_PKORDENINTERNA;
/
PROMPT Otorgando permisos de ejecucion a LDCI_PKORDENINTERNA
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKORDENINTERNA','ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKORDENINTERNA to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKORDENINTERNA to INTEGRADESA;
/

