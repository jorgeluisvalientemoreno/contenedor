CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_CARTERADIFERIDA" (nupproducto NUMBER,dtpdia DATE) return number IS
/**************************************************************************
    Autor       : Viviana Barrag?n G?mez
    Fecha       : 2015-12-11
    Descripcion : Generamos informacion de la cartera diaria por concepto por producto

    Parametros Entrada
      nupproducto producto
      dtpdia Fecha antes refinanciaci?n.

    Valor de salida
      sbmen  mensaje
      error  codigo del error

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
***************************************************************************/
nuErrorCode             NUMBER;
sbErrorMessage          VARCHAR2(4000);
onuCurrentAccountTotal  NUMBER;
onuDeferredAccountTotal NUMBER;
onuCreditBalance        NUMBER;
onuClaimValue           NUMBER;
onuDefClaimValue        NUMBER;
otbBalanceAccounts      fa_boaccountstatustodate.tytbBalanceAccounts;
otbDeferredBalance      fa_boaccountstatustodate.tytbDeferredBalance;
pos                     VARCHAR2(1000);
nuconcepto              concepto.conccodi%TYPE;
nuvalorconc             cargos.cargvalo%TYPE;

nucarteradiferida       number(16,2);
BEGIN

  nucarteradiferida:= 0;
   fa_boaccountstatustodate.ProductBalanceAccountsToDate
    (
    nupproducto,
    dtpdia,
    onuCurrentAccountTotal,
    onuDeferredAccountTotal,
    onuCreditBalance,
    onuClaimValue,
    onuDefClaimValue,
    otbBalanceAccounts,
    otbDeferredBalance
    );

    -- Conceptos cartera diferida
    pos:= otbDeferredBalance.first;
    while pos IS not null loop
      nuconcepto  := otbDeferredBalance(pos).conccodi;
      nuvalorconc := otbDeferredBalance(pos).saldvalo;
      nucarteradiferida:=nucarteradiferida+nuvalorconc;
      pos         := otbDeferredBalance.next(pos);
    END loop;
    return nucarteradiferida;
EXCEPTION
 WHEN OTHERS THEN
  Errors.setError;
  Errors.getError(nuErrorCode, sbErrorMessage);
 END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CARTERADIFERIDA', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_CARTERADIFERIDA TO REPORTES;
/