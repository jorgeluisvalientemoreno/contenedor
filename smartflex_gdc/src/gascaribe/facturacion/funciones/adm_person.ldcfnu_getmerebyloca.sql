CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDCFNU_GETMEREBYLOCA" (nulomrloid fa_locamere.lomrloid%TYPE)
/**************************************************************************
  Autor       : Manuel Mejia
  Fecha       : 2013-12-22
  Descripcion : Obtiene el codigo del mercado relevante

  Parametros Entrada
     nulomrloid  Codigo de la localidad del mercado relevante

  Valor de Retorno
    Codigo del mercado relevante

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
RETURN NUMBER  IS

CURSOR cr_fa_locamere
 IS
SELECT  lomrmeco
FROM    open.fa_locamere
WHERE   lomrloid = nulomrloid;

nu_cr_fa_locamere fa_locamere.lomrmeco%TYPE;
BEGIN
  OPEN cr_fa_locamere;
  FETCH  cr_fa_locamere INTO nu_cr_fa_locamere;
  CLOSE cr_fa_locamere;

  RETURN nu_cr_fa_locamere;
EXCEPTION
  WHEN Others THEN
     NULL;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCFNU_GETMEREBYLOCA', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDCFNU_GETMEREBYLOCA TO REXEREPORTES;
/