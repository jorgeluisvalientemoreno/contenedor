CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_CARTERACORRIENTE" (nupproducto NUMBER,dtpdia DATE) RETURN NUMBER IS
/**************************************************************************
    Autor       : Viviana Barrag?n G?mez
    Fecha       : 2015-12-11
    Descripcion : Obtener el valor de la cartera corriente.

    Parametros Entrada
       nupproducto producto
       dtpdia fecha

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
nuvalornove             cargos.cargvalo%TYPE;
nuvalorvenc             cargos.cargvalo%TYPE;
nudiasvenci             NUMBER(8);
nuvalorcorriente        NUMBER(16,2);

BEGIN
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

    nuvalorcorriente := 0;
    -- Conceptos cartera corriente
    pos:= otbBalanceAccounts.first;
    nuvalornove := 0;
    nuvalorvenc := 0;
    while pos IS not null loop
     nuconcepto  := otbBalanceAccounts(pos).conccodi;
     nuvalorconc := otbBalanceAccounts(pos).saldvalo;
     nudiasvenci := NVL(otbBalanceAccounts(pos).cucodive,0);
     IF nudiasvenci <= 0 THEN
      nuvalornove := nuvalorconc;
      nuvalorvenc := 0;
     ELSE
      nuvalorvenc := nuvalorconc;
      nuvalornove := 0;
     END IF;
     nuvalorcorriente:=nuvalorcorriente+nuvalorvenc+nuvalornove;
     pos := otbBalanceAccounts.next(pos);
    END loop;
    return nuvalorcorriente;

EXCEPTION
 WHEN OTHERS THEN
  Errors.setError;
  Errors.getError(nuErrorCode, sbErrorMessage);
 END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CARTERACORRIENTE', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_CARTERACORRIENTE TO REPORTES;
/