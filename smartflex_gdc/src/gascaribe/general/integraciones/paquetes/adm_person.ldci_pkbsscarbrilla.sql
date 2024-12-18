CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKBSSCARBRILLA AS


 /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

         PAQUETE : LDCI_PKBSSCARBRILLA
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 29/01/2013
         RICEF   : I23
 DESCRIPCION : Paquete de interfaz,tiene como funcion principal
               el encapsulamiento de APIs proporcionadas por SMRTFLEX
               para integraci??n con IVR para realizar la consulta de saldos
			   tanto de brilla como de otros productos

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    29/01/2013  Creacion del paquete
 FRESIE       18/02/2019  Modificación del procedimiento proCnltaDeuda para corrección de error en la consulta de saldo pendiente.
************************************************************************/


PROCEDURE proCnltaSaldoPendBrilla    (inuSuscCodi          in    SUSCRIPC.SUSCCODI%TYPE,
                                      onuSaldoPend         out   NUMBER,
                                      onuCupoUtil          out   NUMBER,
                                      onuErrorCode         out   NUMBER,
                                      osbErrorMessage      out   VARCHAR2);

PROCEDURE proCnltaDeuda          (inuSuscCodi          in    SUSCRIPC.SUSCCODI%TYPE,
                                      inuProducto          in    NUMBER,
                                      onuSaldoPendiente    out    NUMBER,
                                      onuDiferido          out   NUMBER,
                                      onuSaldoExpirado     out   NUMBER,
                                      onuPeriodos          out   NUMBER,
                                      onuErrorCode         out   NUMBER,
                                      osbErrorMessage      out   VARCHAR2);


END LDCI_PKBSSCARBRILLA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKBSSCARBRILLA AS


/************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : proCnltaSaldoPendBrilla
         AUTOR : Hector Fabio Dominguez
         FECHA : 04/03/2013
         RICEF : I023
 DESCRIPCION : Paquete de gestion de la cartera brilla
			   Permite realiza la consulta del cupo utilizado y pendiente
			   del producto brilla, a trav??A?s de las API OS_GETSUBSCRIPBALANCE y
			   OS_GETQUOTABRILLA

 Parametros de Entrada

    inuproductid        in NUMBER,


 Parametros de Salida

       inuSuscCodi          in    SUSCRIPC.SUSCCODI%TYPE,
	   onuSaldoPend         out   NUMBER,
	   onuCupoUtil          out   NUMBER,
	   onuErrorCode         out   NUMBER,
	   osbErrorMessage      out   VARCHAR2

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    04/03/2013  Creacion del paquete
 ************************************************************************/

PROCEDURE proCnltaSaldoPendBrilla    (inuSuscCodi          in    SUSCRIPC.SUSCCODI%TYPE,
                                      onuSaldoPend         out   NUMBER,
                                      onuCupoUtil          out   NUMBER,
                                      onuErrorCode         out   NUMBER,
                                      osbErrorMessage      out   VARCHAR2) AS

  ONUDEFERREDBALANCE NUMBER;
  ONUEXPIREDBALANCE  NUMBER;
  ONUEXPIREDPERIODS  NUMBER;
  onuCupoAprob       NUMBER;
  onuCupoDisp        NUMBER;
  --onuSaldoPend       NUMBER;

  BEGIN
    /* TAREA Se necesita implementaci??A?n */
   -- onuCupoUtil:=0;
  OS_GETQUOTABRILLA( inuSuscCodi, onuCupoAprob, onuCupoUtil,onuCupoDisp, onuSaldoPend, onuErrorCode, osbErrorMessage );
  OS_GETSUBSCRIPBALANCE( inuSuscCodi, 7055, onuSaldoPend, ONUDEFERREDBALANCE => ONUDEFERREDBALANCE, ONUEXPIREDBALANCE => ONUEXPIREDBALANCE, ONUEXPIREDPERIODS => ONUEXPIREDPERIODS, ONUERRORCODE => ONUERRORCODE, OSBERRORMESSAGE => OSBERRORMESSAGE );

EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
         ROLLBACK;
         Errors.geterror (onuErrorCode, osbErrorMessage);
      WHEN OTHERS THEN
        osbErrorMessage := 'Error consultando el saldo pendiene brilla: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
        pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
        Errors.seterror;
        Errors.geterror (onuErrorCode, osbErrorMessage);

  END proCnltaSaldoPendBrilla;


  /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : fsbValidaContrato
         AUTOR : Hector Fabio Dominguez
         FECHA : 10/07/2013
         RICEF : I023
 DESCRIPCION : funcion que valida si un contrato existe

 Parametros de Entrada

    nuSusccodi        in NUMBER,


 Parametros de Salida

-1 Error
1  Existe
0  No existe

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    10/07/2013  Creacion del paquete
************************************************************************/

  FUNCTION fsbValidaContrato (nuSusccodi in open.suscripc.susccodi%type)
  RETURN VARCHAR2
      IS
         nuExiste number;
         nuResExiste varchar(2);
      BEGIN
      nuResExiste := '-1';
         BEGIN
            SELECT count(1)
            INTO   nuExiste
            FROM   open.suscripc
            WHERE  susccodi = nuSusccodi
            AND  susccodi > 0 ; --Se excluye el  codigo -1  comodin
         EXCEPTION
         WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
         END;

         IF (nuExiste = 1) then
           --DBMS_OUTPUT.PUT_LINE('El contrato Si existe');
           nuResExiste := '1';
         ELSE
           --DBMS_OUTPUT.PUT_LINE('El contrato No existe');
           nuResExiste := '0';
         END IF;

      RETURN nuResExiste;

      EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
      RETURN nuResExiste;
         raise ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         RETURN nuResExiste;
         Errors.setError;
         raise ex.CONTROLLED_ERROR;
   END fsbValidaContrato;



  /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : proCnltaDeuda
         AUTOR : Hector Fabio Dominguez
         FECHA : 04/03/2013
         RICEF : I023
 DESCRIPCION :  Paquete que consulta la deuda
			    de un contrato, de un producto elegido
				o de todos los productos. Se debe enviar
				nulo el producto, para obtener la respuesta
				total

 Parametros de Entrada

      inuSuscCodi          in    SUSCRIPC.SUSCCODI%TYPE,
	  inuProducto          in    NUMBER,



 Parametros de Salida

      onuSaldoPendiente    out    NUMBER,
	  onuDiferido          out   NUMBER,
	  onuSaldoExpirado     out   NUMBER,
	  onuPeriodos          out   NUMBER,
	  onuErrorCode         out   NUMBER,
	  osbErrorMessage      out   VARCHAR2

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    04/03/2013  Creacion del paquete
 FRESIE       18/02/2019  Modificación del procedimiento proCnltaDeuda para corrección de error en la consulta de saldo pendiente.
************************************************************************/

PROCEDURE proCnltaDeuda           (inuSuscCodi          in    SUSCRIPC.SUSCCODI%TYPE,
                                      inuProducto          in    NUMBER,
                                      onuSaldoPendiente    out    NUMBER,
                                      onuDiferido          out   NUMBER,
                                      onuSaldoExpirado     out   NUMBER,
                                      onuPeriodos          out   NUMBER,
                                      onuErrorCode         out   NUMBER,
                                      osbErrorMessage      out   VARCHAR2) AS

  ONUDEFERREDBALANCE NUMBER;
  ONUEXPIREDBALANCE  NUMBER;
  ONUEXPIREDPERIODS  NUMBER;
  onuCupoAprob       NUMBER;
  onuCupoDisp        NUMBER;
  --onuSaldoPend       NUMBER;

  /*
   * cuSaldoPendienteTotal
   *
   * Consulta la cantidad de periodos vencidos
   *
   */
  CURSOR cuSaldoPendienteTotal is

  Select nvl(sum(nvl(CUCOSACU,0)),0) valor
    From Cuencobr Cc
    Where CUCONUSE in (select sesunuse
                    from servsusc
                    where sesususc = inuSuscCodi)
          And Cc.Cucosacu > 0;
  /*
   * cuSaldoPendiente
   *
   * Consulta la cantidad de periodos vencidos
   *
   */
    CURSOR cuSaldoPendiente is

  Select nvl(sum(nvl(CUCOSACU,0)),0) valor
    From Cuencobr Cc
    Where CUCONUSE in (select sesunuse
                    from servsusc
                    where sesususc = inuSuscCodi and
                          sesuserv = inuProducto)
          And Cc.Cucosacu > 0;


    /*
   * cuPeriodosVencidosTotal
   *
   * Consulta la cantidad de periodos vencidos
   *
   */
 CURSOR cuPeriodosVencidosTotal is

 Select count(distinct f.FACTPEFA)
 From Factura F
 Where F.Factcodi In (Select Cc.Cucofaag
                      From Cuencobr Cc
                      Where Cc.Cucofeve < Sysdate And
                            Cuconuse IN (select sesunuse
                                          from servsusc
                                          where sesususc = inuSuscCodi)
                       And Cucosacu>0);


  /*
   * cuSaldoExpirado
   *
   * Consulta la cantidad de periodos vencidos
   *
   */
 CURSOR cuPeriodosVencidos is

 Select count(distinct f.FACTPEFA)
 From Factura F
 Where F.Factcodi In (Select Cc.Cucofaag
                      From Cuencobr Cc
                      Where Cc.Cucofeve < Sysdate And
                            Cuconuse IN (select sesunuse
                                          from servsusc
                                          where sesususc = inuSuscCodi and
                                                sesuserv = inuProducto)
                       And Cucosacu>0);
   /*
   * cuSaldoExpiradoTotal
   *
   * Consulta el saldo expirado
   * de un contrato
   *
   */


  CURSOR cuSaldoExpirado is

  Select nvl(sum(nvl(CUCOSACU,0)),0) valor
    From Cuencobr Cc
    Where Cc.CUCOFEVE < Sysdate
     and CUCONUSE in (select sesunuse
                    from servsusc
                    where sesususc = inuSuscCodi and
                          sesuserv = inuProducto);


   /*
   * cuSaldoExpirado
   *
   * Consulta el saldo expirado
   * de un contrato
   *
   */


  CURSOR cuSaldoExpiradoTotal is

  Select nvl(sum(nvl(CUCOSACU,0)),0) valor
    From Cuencobr Cc
    Where Cc.CUCOFEVE < Sysdate
     and CUCONUSE in (select sesunuse
                    from servsusc
                    where sesususc = inuSuscCodi);



  /*
   * cuDiferidos
   *
   * Se encarga de traer el valor total
   * del diferido de un suscriptor
   * de acuerdo al producto suministrado
   *
   */
CURSOR cuDiferidos is

 select nvl(sum(nvl(difesape,0)),0) valor
 from diferido d
 where d.difesusc = inuSuscCodi
 and d.difenuse in (select sesunuse
                    from servsusc
                    where sesususc = inuSuscCodi and
                          sesuserv = inuProducto);

  /*
   * cuDiferidosTotal
   *
   * Se encarga de traer el valor total
   * del diferido de un suscriptor
   *
   */

CURSOR cuDiferidosTotal is

 select nvl(sum(nvl(difesape,0)),0) valor
 from diferido d
 where d.difenuse in (select sesunuse
                    from servsusc
                    where sesususc = inuSuscCodi);


 /*
  * Se declara excepcion para cuando no exista el contrato
  */
  CONTRATO_NO_EXISTE EXCEPTION;
  BEGIN


  IF fsbValidaContrato(inuSuscCodi)<>'1' THEN
     RAISE CONTRATO_NO_EXISTE;
  END IF;



  onuErrorCode:=0;
  /*
   * Validamos si el el numero de producto es null
   * si es null, se trae el diferido total
   * de todos los productos de ese suscriptor
   */
  IF inuProducto IS NULL THEN

     OPEN cuDiferidosTotal;
      FETCH cuDiferidosTotal INTO onuDiferido;
     CLOSE cuDiferidosTotal;

     OPEN cuSaldoExpiradoTotal;
      FETCH cuSaldoExpiradoTotal INTO onuSaldoExpirado;
     CLOSE cuSaldoExpiradoTotal;

     OPEN cuPeriodosVencidosTotal;
       FETCH cuPeriodosVencidosTotal INTO onuPeriodos;
      CLOSE cuPeriodosVencidosTotal;

      OPEN cuSaldoPendienteTotal;
       FETCH cuSaldoPendienteTotal INTO onuSaldoPendiente;
      CLOSE cuSaldoPendienteTotal;

  ELSE
  /*
   * si no es null, se trae el diferido total
   * del producto enviado para ese suscriptor
   */
    OPEN cuDiferidos;
      FETCH cuDiferidos INTO onuDiferido;
     CLOSE cuDiferidos;

    /*
     * Consulta el saldo expirado
     * para el contrato dado
     */


     OPEN cuSaldoExpirado;
      FETCH cuSaldoExpirado INTO onuSaldoExpirado;
     CLOSE cuSaldoExpirado;


      OPEN cuPeriodosVencidos;
       FETCH cuPeriodosVencidos INTO onuPeriodos;
      CLOSE cuPeriodosVencidos;

       OPEN cuSaldoPendiente;
       FETCH cuSaldoPendiente INTO onuSaldoPendiente;
      CLOSE cuSaldoPendiente;

  END IF;

EXCEPTION
      WHEN CONTRATO_NO_EXISTE THEN
	      onuErrorCode:=666;
          osbErrorMessage:='Contrato no existe';
          onuSaldoPendiente:=0;
          onuPeriodos:=0;
          onuSaldoExpirado:=0;
          onuDiferido:=0;

      WHEN ex.CONTROLLED_ERROR then
         ROLLBACK;
         Errors.geterror (onuErrorCode, osbErrorMessage);
      WHEN OTHERS THEN
        osbErrorMessage := 'Error consultando el saldo pendiene brilla: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
        pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
        Errors.seterror;
        Errors.geterror (onuErrorCode, osbErrorMessage);

  END proCnltaDeuda;

END LDCI_PKBSSCARBRILLA;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKBSSCARBRILLA', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSCARBRILLA to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSCARBRILLA to INTEGRADESA;
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSCARBRILLA to REXEINNOVA;

/

