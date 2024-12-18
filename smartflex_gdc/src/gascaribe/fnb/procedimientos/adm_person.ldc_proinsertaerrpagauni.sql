CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PROINSERTAERRPAGAUNI(
																inususc   in LDC_ERR_PAGAUNI.SUBSCRIPTION_ID%type ,
																inuord    in LDC_ERR_PAGAUNI.Order_Id%type,
																inupack   in LDC_ERR_PAGAUNI.Package_Id%type,
																inusesi   in LDC_ERR_PAGAUNI.Sesion%type,
																inuusco   in LDC_ERR_PAGAUNI.Usuario_Conect%type,
																inucoderr in LDC_ERR_PAGAUNI.Codigo_Err%type,
																isbmenerr in LDC_ERR_PAGAUNI.Mensaje_Err%type,
																isbprog in LDC_ERR_PAGAUNI.PROGRAMA%type
																) IS
 PRAGMA AUTONOMOUS_TRANSACTION;
/**************************************************************************
  Propiedad Intelectual de JM Gestion Informatica

  Autor       : Roberto parra
  Fecha       : 26/02/2018
  Descripcion : Registramos lOS ERRORES PRODUCIDOS AL MOMENTO
                DE LEGALIZAR UNA ORDEN DE PARAGARE UNICO

  HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/

BEGIN
 INSERT INTO LDC_ERR_PAGAUNI
                             (ID_EL,
                              SUBSCRIPTION_ID,
                              ORDER_ID,
                              PACKAGE_ID,
                              SESION,
                              USUARIO_CONECT,
                              FECHA_PROCESO,
                              CODIGO_ERR,
                              MENSAJE_ERR,
                              PROGRAMA
                              )
                        VALUES(S_LDC_ERR_PAGAUNI.NEXTVAL,
                              inususc,
                              inuord,
                              inupack,
                              inusesi,
                              inuusco,
                              sysdate,
                              inucoderr,
                              isbmenerr,
                              isbprog
                              );
 COMMIT;
END;
/

PROMPT Otorgando permisos de ejecucion a LDC_PROINSERTAERRPAGAUNI
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_PROINSERTAERRPAGAUNI','ADM_PERSON');
END;
/
