CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKAPIUTIL AS
/************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : LDCI_PKAPIUTIL.sql
         AUTOR : Hector Fabio Dominguez
         FECHA : 30/05/2011

 DESCRIPCION : Paquete de interfaz con SAP(PI),tiene como funcion manejar
               en el encoding y deconding de datos de la bd
               Tiquete 143105.
 Parametros de Entrada



 Parametros de Salida

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    30/05/2011  Creacion del paquete
************************************************************************/
  /* TODO enter package declarations (types, exceptions, methods etc) here */
  FUNCTION procRestoreDataWS(inuUtilCod LDCI_utilws.utilcod%TYPE) RETURN LDCI_utilws.UTILDATA%TYPE;
  FUNCTION procEncodDataWS(inuUtilCod LDCI_utilws.utildata%TYPE) RETURN LDCI_utilws.UTILDATA%TYPE;
END LDCI_PKAPIUTIL;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKAPIUTIL AS

/************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : procRestoreDataWS
         AUTOR : Hector Fabio Dominguez
         FECHA : 30/05/2011

 DESCRIPCION : Procedimiento de interfaz con SAP(PI),tiene como funcion manejar
               en el encoding y deconding de datos de la bd
               Tiquete 143105.
 Parametros de Entrada



 Parametros de Salida

   sbIden OUT VARCHAR2
   sbName OUT VARCHAR2

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    30/05/2011  Creacion del paquete
************************************************************************/
  FUNCTION procRestoreDataWS(inuUtilCod LDCI_utilws.utilcod%TYPE) RETURN LDCI_utilws.UTILDATA%TYPE
  AS

  CURSOR CuRestoreData IS
        SELECT utl_encode.mimeheader_decode(
                                            UTL_RAW.cast_to_varchar2(
                                                                      utl_encode.base64_decode(UTILDATA)
                                                                     )
                                           ) UTILDATA
        FROM LDCI_utilws WHERE utilcod=inuUtilCod;
  rgRestore CuRestoreData%rowtype;
  BEGIN

  OPEN CuRestoreData;
    FETCH CuRestoreData INTO rgRestore;
  CLOSE CuRestoreData;


    RETURN rgRestore.UTILDATA;

  END procRestoreDataWS;


/************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : procEncodDataWS
         AUTOR : Hector Fabio Dominguez
         FECHA : 30/05/2011

 DESCRIPCION : Procedimiento de interfaz con SAP(PI),tiene como funcion manejar
               en el encoding
               Tiquete 143105.
 Parametros de Entrada



 Parametros de Entrada

 inuUtilCod LDCI_utilws.utildata%TYPE


 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    30/05/2011  Creacion del paquete
************************************************************************/
  FUNCTION procEncodDataWS(inuUtilCod LDCI_utilws.utildata%TYPE) RETURN LDCI_utilws.UTILDATA%TYPE
  AS
  BEGIN

    RETURN utl_encode.base64_encode(UTL_RAW.cast_to_raw('=?ISO-8859-1?Q?'||inuUtilCod||'?='));

  END procEncodDataWS;

END LDCI_PKAPIUTIL;
/

PROMPT Asignación de permisos para el paquete LDCI_PKAPIUTIL
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKAPIUTIL', 'ADM_PERSON');
end;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKAPIUTIL to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKAPIUTIL to INTEGRADESA;
/
