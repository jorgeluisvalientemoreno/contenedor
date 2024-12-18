CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKINBOXDETBRILLA AS
  /*************************************************************************************************************
     PROCEDIMIENTO : ldci_pkinboxdetBrilla
     AUTOR         : AAcuna
     FECHA         : 18/04/2018
     CASO         :  200-1511
     DESCRIPCION   : lectura de xml para la venta brila
           General

    Historia de Modificaciones
    Autor           Fecha        Descripcion
    AAcuna          18/04/2018   Creacion
  **************************************************************************************************************/

  ---------------------------------------------------------------------------------------

  /*
  * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
  *
  * Proceso     : proProcesaXMLVENTABRILLA
  * Tiquete     :
  * Fecha       : 23-10-2017
  * Descripcion : Se encarga de generaar la venta brilla

  * Historia de Modificaciones
  * Autor       Fecha           Descripcion
  * AAcuna      18/04/2018      Creacion
  *
  *
  **/

  PROCEDURE proProcesaXMLVENTABRILLA(CODIGO        In Number,
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

END LDCI_PKINBOXDETBRILLA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKINBOXDETBRILLA AS

  /*************************************************************************************************************
     PROCEDIMIENTO : ldci_pkinboxVENTABRILLA
     AUTOR         : AAcuna
     FECHA         : 18/04/2018
     CASO         :  200-1511
     DESCRIPCION   : lectura de xml para la venta brila
           General

    Historia de Modificaciones
    Autor           Fecha        Descripcion
    AAcuna          18/04/2018   Creacion
  **************************************************************************************************************/

  ---------------------------------------------------------------------------------------

  /*
  * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
  *
  * Proceso     : proProcesaXMLVENTABRILLA
  * Tiquete     :
  * Fecha       : 23-10-2017
  * Descripcion : Se encarga de generaar la venta brilla

  * Historia de Modificaciones
  * Autor       Fecha           Descripcion
  * AAcuna      18/04/2018      Creacion
  *
  *
  **/

  PROCEDURE proProcesaXMLVENTABRILLA(CODIGO        In Number,
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

    onupackages number;

  BEGIN

    onupackages := null;

    LDCI_PKVENTABRILLA.proRegistraVenta(isbXML,
                                        onupackages,
                                        onuErrorCodi,
                                        osbErrorMsg);

    open ocurRespuesta for

      select 'idSolicitud' parametro, to_char(onupackages) valor
        from dual
      union
      select 'idProcesoExterno' parametro, to_char(inuProcesoExt) valor
        from dual
      union
      select 'idContrato' parametro, to_char(inuContrato) valor
        from dual
      union
      select 'idProducto' parametro, to_char(inuProducto) valor
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

  End proProcesaXMLVENTABRILLA;

End LDCI_PKINBOXDETBRILLA;
/
PROMPT Otorgando permisos de ejecucion a LDCI_PKINBOXDETBRILLA
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKINBOXDETBRILLA','ADM_PERSON');
END;
/
