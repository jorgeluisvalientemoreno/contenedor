CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKBSSFACTCONS AS

 /************************************************************************
   PROPIEDAD INTELECTUAL DE PETI


   PAQUETE : LDCI_PKBSSFACTCONS
   AUTOR   : Adrian Baldovino Barrios
   FECHA   : 10/07/2014
   DESCRIPCION :   Consultas relacionadas a la facturacion.

   Historia de Modificaciones

   Autor         Fecha       Descripcion.
   abaldovino    10/07/2014    Creacion del paquete.
  ************************************************************************/

  procedure proCnltaLectActualPorSusc(inuSuscCodi IN SUSCRIPC.SUSCCODI%TYPE,
                                      onuLectAct  OUT LECTELME.LEEMLETO%TYPE,
                                      onuErrorCode        out  NUMBER,
                                      osbErrorMessage     out  VARCHAR2);

  procedure proCnltaCuponPorCtto(inuSuscCodi in SUSCRIPC.SUSCCODI%TYPE,
                                 onuCupon        out  CUPON.CUPONUME%TYPE,
                                 onuErrorCode    out  NUMBER,
                                 osbErrorMessage out  VARCHAR2);

END LDCI_PKBSSFACTCONS;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKBSSFACTCONS AS

 /************************************************************************
   PROPIEDAD INTELECTUAL DE PETI


   PAQUETE : LDCI_PKBSSFACTCONS
   AUTOR   : Adrian Baldovino Barrios
   FECHA   : 10/07/2014
   DESCRIPCION :   Consultas relacionadas a la facturacion.

   Historia de Modificaciones

   Autor         Fecha       Descripcion.
   abaldovino    10/07/2014    Creacion del paquete.
  ************************************************************************/

  procedure proCnltaLectActualPorSusc(inuSuscCodi IN SUSCRIPC.SUSCCODI%TYPE,
                                      onuLectAct  OUT LECTELME.LEEMLETO%TYPE,
                                      onuErrorCode        out  NUMBER,
                                      osbErrorMessage     out  VARCHAR2) is

    /********************
    Adrian Baldovino Barrios
    Junio 12 de 2014

    Objetivo: Obtener valor de ultima lectura del medidor a partir del numero de suscripcion
    *********************/

    --Obtiene la lectura actual de la factura indicada en inFactCodi
    cursor cuCnltaLectActual(inFactCodi number) is
      select nvl(leemleto,0) leac,
             nvl(leemlean,0) lean
      from open.factura,
           open.servsusc,
           open.lectelme
      where factcodi = inFactCodi and
            factsusc = inuSuscCodi and
            sesususc = factsusc and
            sesuserv = 7014  and --Servicio de gas
            leemsesu = sesunuse and
            leempefa = factpefa;

    nuFactura factura.factcodi%type;

  begin
    nuFactura := -1;

    --Obtiene la ultima factura del contrato
    select max(factcodi) into nuFactura
    from factura where factsusc=inuSuscCodi AND FACTPROG=6;

    for rgLecdt in cuCnltaLectActual(nuFactura) loop
        onuLectAct := rgLecdt.leac;
    end loop;

    exception
    when ex.CONTROLLED_ERROR then
           rollback;
           Errors.geterror (onuErrorCode, osbErrorMessage);
        when others then
           onuErrorCode := -1;
           osbErrorMessage := 'Error general: '||Sqlerrm;

  end proCnltaLectActualPorSusc;

  procedure proCnltaCuponPorCtto(inuSuscCodi in SUSCRIPC.SUSCCODI%TYPE,
                                 onuCupon        out  CUPON.CUPONUME%TYPE,
                                 onuErrorCode    out  NUMBER,
                                 osbErrorMessage out  VARCHAR2) AS

    /********************
    Adrian Baldovino Barrios
    Junio 13 de 2014

    Objetivo: Obtener el ultimo cupon generado a partir del numero de suscripcion
    *********************/

    nuFactura factura.factcodi%type;
  begin

    --Obtiene la ultima factura del contrato
    select max(factcodi) into nuFactura
    from factura where factsusc=inuSuscCodi AND FACTPROG=6;

    select max(cuponume) into onuCupon
      from cupon
      where cuposusc = inuSuscCodi and
            cupodocu = nuFactura;

    exception
        when ex.CONTROLLED_ERROR then
           rollback;
           Errors.geterror (onuErrorCode, osbErrorMessage);
        when others then
           onuErrorCode := -1;
           osbErrorMessage := 'Error general: '||Sqlerrm;
  end proCnltaCuponPorCtto;

END LDCI_PKBSSFACTCONS;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKBSSFACTCONS', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSFACTCONS to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSFACTCONS to INTEGRADESA;
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSFACTCONS to REXEINNOVA;
/
