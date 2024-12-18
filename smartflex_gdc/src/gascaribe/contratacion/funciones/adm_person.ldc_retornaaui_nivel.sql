CREATE OR REPLACE FUNCTION adm_person.ldc_retornaaui_nivel (
    inuorder IN NUMBER
) RETURN NUMBER IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2014-01-09
  Descripcion : Obtenemos el A.U.I

  Parametros Entrada
    Nro_ordén de trabajo

  Valor de salida
    retorna el A.U.I

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  06/03/2024      Paola Acosta        OSF-2104: Se agregan permisos para REXEREPORTES por solicitud de CGonzalez     
  27/02/2024      Paola Acosta        OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON  

***************************************************************************/
--onuadmin ge_contrato.valor_aui_admin%TYPE;
--onuimpre ge_contrato.valor_aui_imprev%TYPE;
--onuutili ge_contrato.valor_aui_util%type;
BEGIN
  --LDC_GETAIUBYORDER (inuorder, onuAdmin, onuimpre, onuutili);
    RETURN nvl(ldc_getaiu(inuorder, 1), 0) + nvl(ldc_getaiu(inuorder, 2), 0) + nvl(ldc_getaiu(inuorder, 3), 0);
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END ldc_retornaaui_nivel;
/

BEGIN
    pkg_utilidades.praplicarpermisos('LDC_RETORNAAUI_NIVEL', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON adm_person.ldc_retornaaui_nivel TO REXEREPORTES;
/