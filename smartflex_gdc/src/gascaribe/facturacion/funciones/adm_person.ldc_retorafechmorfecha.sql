CREATE OR REPLACE FUNCTION adm_person.ldc_retorafechmorfecha (
    inupproduct IN NUMBER,
    idtpfecha   IN DATE
) RETURN NUMBER IS
  /**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-07-18
  Descripcion : Obtiene edad de la mora de acuerdo a una fecha

  Parametros Entrada
   inupproduct codigo de producto
   idtpfecha fecha -1 de la financiacion

  Valor de Retorno
    edad de la mora

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  07/03/2024      Paola Acosta        OSF-2104: Se crean sinonimos
  06/03/2024      Paola Acosta        OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez
  27/02/2024      Paola Acosta        OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON  
  ***************************************************************************/
  
    nuerrorcode             NUMBER;
    sberrormessage          VARCHAR2(4000);
    inuproductid            NUMBER := 1003;
    idtdate                 DATE := sysdate - 120;
    onucurrentaccounttotal  NUMBER;
    onudeferredaccounttotal NUMBER;
    onucreditbalance        NUMBER;
    onuclaimvalue           NUMBER;
    onudefclaimvalue        NUMBER;
    otbbalanceaccounts      fa_boaccountstatustodate.tytbbalanceaccounts;
    otbdeferredbalance      fa_boaccountstatustodate.tytbdeferredbalance;
    saldovencido            NUMBER := 0;
    edadmora                NUMBER := 0;
    pos                     VARCHAR2(1000);
    sbconcepts              VARCHAR2(10000) := '';
    sbtab                   VARCHAR2(2) := chr(9);
    sbtab2                  VARCHAR2(6) := chr(9)
                          || chr(9)
                          || chr(9)
                          || chr(9);
    sbline                  VARCHAR2(2) := chr(10);
BEGIN                         -- ge_module
    fa_boaccountstatustodate.productbalanceaccountstodate(inupproduct, idtpfecha, onucurrentaccounttotal, onudeferredaccounttotal, onucreditbalance,
                                                         onuclaimvalue, onudefclaimvalue, otbbalanceaccounts, otbdeferredbalance);

    pos := otbbalanceaccounts.first;
    WHILE pos IS NOT NULL LOOP
        IF otbbalanceaccounts(pos).cucodive > 0 THEN
            saldovencido := saldovencido + otbbalanceaccounts(pos).saldvalo;
            IF otbbalanceaccounts(pos).cucodive > edadmora THEN
                edadmora := otbbalanceaccounts(pos).cucodive;
            END IF;

        END IF;

        pos := otbbalanceaccounts.next(pos);
    END LOOP;

    RETURN ldc_edad_mes(edadmora);
EXCEPTION
    WHEN ex.controlled_error THEN
        errors.geterror(nuerrorcode, sberrormessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: ' || nuerrorcode);
        dbms_output.put_line('error osbErrorMess: ' || sberrormessage);
    WHEN OTHERS THEN
        errors.seterror;
        errors.geterror(nuerrorcode, sberrormessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: ' || nuerrorcode);
        dbms_output.put_line('error osbErrorMess: ' || sberrormessage);
END ldc_retorafechmorfecha;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_RETORAFECHMORFECHA', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_RETORAFECHMORFECHA TO REXEREPORTES;
/