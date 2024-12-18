CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_RETORADEDUAAFECHA" (nupproduct NUMBER,dtpfecha DATE) RETURN NUMBER IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-07-18
  Descripcion : Obtiene la deuda de acuerdo a una fecha

  Parametros Entrada
   nupproduct codigo de producto
   dtpfecha fecha -1 de la financiación

  Valor de Retorno
   la deuda producto a esa fecha

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    inuProductId            number := 1003;
    idtDate                 date   := sysdate - 120;
    onuCurrentAccountTotal  number;
    onuDeferredAccountTotal number;
    onuCreditBalance        number;
    onuClaimValue           number;
    onuDefClaimValue        number;
    otbBalanceAccounts      fa_boaccountstatustodate.tytbBalanceAccounts;
    otbDeferredBalance      fa_boaccountstatustodate.tytbDeferredBalance;
    SaldoVencido            number := 0;
    EdadMora                number := 0;
    pos                     varchar2(1000);
    sbConcepts              varchar2(10000) := '';
    sbTab                   varchar2(2) := chr(9);
    sbTab2                  varchar2(6) := chr(9)||chr(9)||chr(9)||chr(9);
    sbLine                  varchar2(2) := chr(10);
BEGIN                         -- ge_module
    fa_boaccountstatustodate.ProductBalanceAccountsToDate
    (
    nupproduct,
    dtpfecha,
    onuCurrentAccountTotal,
    onuDeferredAccountTotal,
    onuCreditBalance,
    onuClaimValue,
    onuDefClaimValue,
    otbBalanceAccounts,
    otbDeferredBalance
    );
    pos:= otbBalanceAccounts.first;
    while pos IS not null loop
        if otbBalanceAccounts(pos).cucodive > 0 then
            SaldoVencido := SaldoVencido + otbBalanceAccounts(pos).saldvalo;
            if otbBalanceAccounts(pos).cucodive > EdadMora then
                EdadMora := otbBalanceAccounts(pos).cucodive;
            END if;
        END if;
        pos := otbBalanceAccounts.next(pos);
    END loop;
  RETURN  onuCurrentAccountTotal+SaldoVencido+onuDeferredAccountTotal;


EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_RETORADEDUAAFECHA', 'ADM_PERSON');
END;
/
