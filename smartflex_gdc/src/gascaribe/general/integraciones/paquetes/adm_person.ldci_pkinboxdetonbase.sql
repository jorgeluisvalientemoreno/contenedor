CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKINBOXDETONBASE AS
  /*************************************************************************************************************
     PROCEDIMIENTO : ldci_pkinboxdetOnBase
     AUTOR         : Jose Donado
     FECHA         : 03/10/2018
     CASO         :  200-1752
     DESCRIPCION   : lectura de xml para la operaciones de OnBase
           General

    Historia de Modificaciones
    Autor           Fecha        Descripcion
    jdonado         03/10/2018   Creacion
  **************************************************************************************************************/

  ---------------------------------------------------------------------------------------

  /*
  * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
  *
  * Proceso     : proProcesaXMLDOCUORDEN
  * Tiquete     :
  * Fecha       : 03-10-2018
  * Descripcion : Se encarga de procesar los cambios de estado de documento de ordenes

  * Historia de Modificaciones
  * Autor       Fecha           Descripcion
  * jdonado     03/10/2018      Creacion
  *
  *
  **/

  PROCEDURE proProcesaXMLDOCUORDEN(CODIGO        In Number,
                                     INBOX_ID      in VARCHAR2,
                                     inuProcesoExt in NUMBER,
                                     isbSistema    in VARCHAR2,
                                     isbOperacion  in VARCHAR2,
                                     isbXML        in CLOB,
                                     inuContrato   in Varchar2,
                                     inuProducto   in Varchar2,
                                     inuUnid_oper  in number,
                                     inuOrden      in number,
                                     ocurRespuesta Out SYS_REFCURSOR,
                                     onuErrorCodi  out NUMBER,
                                     osbErrorMsg   out VARCHAR2);

END LDCI_PKINBOXDETONBASE;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKINBOXDETONBASE AS

  /*************************************************************************************************************
     PROCEDIMIENTO : ldci_pkinboxdetOnBase
     AUTOR         : Jose Donado
     FECHA         : 03/10/2018
     CASO         :  200-1752
     DESCRIPCION   : lectura de xml para la operaciones de OnBase
           General

    Historia de Modificaciones
    Autor           Fecha        Descripcion
    jdonado         03/10/2018   Creacion
  **************************************************************************************************************/

  ---------------------------------------------------------------------------------------

  /*
  * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
  *
  * Proceso     : proProcesaXMLDOCUORDEN
  * Tiquete     :
  * Fecha       : 03-10-2018
  * Descripcion : Se encarga de procesar los cambios de estado de documento de ordenes

  * Historia de Modificaciones
  * Autor       Fecha           Descripcion
  * jdonado     03/10/2018      Creacion
  *
  *
  **/

  PROCEDURE proProcesaXMLDOCUORDEN(CODIGO        In Number,
                                     INBOX_ID      in VARCHAR2,
                                     inuProcesoExt in NUMBER,
                                     isbSistema    in VARCHAR2,
                                     isbOperacion  in VARCHAR2,
                                     isbXML        in CLOB,
                                     inuContrato   in Varchar2,
                                     inuProducto   in Varchar2,
                                     inuUnid_oper  in number,
                                     inuOrden      in number,
                                     ocurRespuesta Out SYS_REFCURSOR,
                                     onuErrorCodi  out NUMBER,
                                     osbErrorMsg   out VARCHAR2) AS

  BEGIN

    PORUPDATESTATUSDOCORD(isbXML,
                          onuErrorCodi,
                          osbErrorMsg);

    open ocurRespuesta for

      select 'idProcesoExterno' parametro, to_char(inuProcesoExt) valor
        from dual
      union
      select 'idContrato' parametro, to_char(inuContrato) valor
        from dual
      union
      select 'idProducto' parametro, to_char(inuProducto) valor
        from dual
      union
      select 'idOrden' parametro, to_char(inuOrden) valor
        from dual
      union
      select 'codigoError' parametro, to_char(onuErrorCodi) valor
        from dual
      union
      select 'mensajeError' parametro, osbErrorMsg valor from dual;

  Exception

    When Others Then

      errors.geterror(onuErrorCodi, osbErrorMsg);

      open ocurRespuesta for

        select 'idProcesoExterno' parametro, to_char(inuProcesoExt) valor
          from dual
        union
        select 'codigoError' parametro, to_char(onuErrorCodi) valor
          from dual
        union
        select 'mensajeError' parametro, osbErrorMsg valor from dual;

  End proProcesaXMLDOCUORDEN;

End LDCI_PKINBOXDETONBASE;
/
PROMPT Otorgando permisos de ejecucion a LDCI_PKINBOXDETONBASE
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKINBOXDETONBASE','ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKINBOXDETONBASE to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKINBOXDETONBASE to INTEGRADESA;
/
