CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKFACTACTA AS

  /*
     PROPIEDAD INTELECTUAL
     PAQUETE       : LDCI_PKFACTACTA
     AUTOR         : Arquitecsoft / Hectpr Dominguez
     FECHA         : 22/10/2014
     RICEF :

     DESCRIPCION: Permite relacionar las actas y las facturas docuware

    Historia de Modificaciones
    Autor      Fecha      Descripcion
    hectorfdv  22-10-2014 Cracion
  */


  procedure proActFechActa(inuIdActa           IN NUMBER,
                              idtFechaPago     IN DATE,
                              inuFactura       IN NUMBER,
                              onuErrorCode     OUT NUMBER,
                              osbErrorMessage  OUT VARCHAR2);

END LDCI_PKFACTACTA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKFACTACTA AS

  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     PAQUETE       :
     AUTOR         : Arquitecsoft / Hectpr Dominguez
     FECHA         : 12/06/2014
     RICEF : I080,i081
     DESCRIPCION:

    Historia de Modificaciones
    Autor   Fecha      Descripcion
  */


  --------------------------------------------------------------------------
  --------------------------------------------------------------------------

  procedure proActFechActa(inuIdActa           IN NUMBER,
                              idtFechaPago     IN DATE,
                              inuFactura       IN NUMBER,
                              onuErrorCode     OUT NUMBER,
                              osbErrorMessage  OUT VARCHAR2)
  IS
    /***********************************************************
       PROPIEDAD INTELECTUAL DE SURTIGAS S.A E.S.P
       PAQUETE       : proActFechActa
       AUTOR         : Arquitecsoft / Hector Dominguz
       FECHA         : 08/11/2014
       RICEF         : 0104
       DESCRIPCION   : Registra acta factura

      Historia de Modificaciones
      Autor     Fecha       Descripcion

    ***************************************************************/

  begin

    UT_Trace.Trace('proActFechActa', 15);

    OS_UPDPAIDCERTIF(
    inuIdActa,
    idtFechaPago,
    inuFactura,
   onuErrorCode,
   osbErrorMessage
  );

  exception
    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           osbErrorMessage);
      Errors.seterror;
      Errors.geterror(onuErrorCode, osbErrorMessage);

  end proActFechActa;


END LDCI_PKFACTACTA;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKFACTACTA', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTACTA to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTACTA to INTEGRADESA;
/


