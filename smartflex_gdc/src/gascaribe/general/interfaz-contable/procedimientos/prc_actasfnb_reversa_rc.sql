CREATE OR REPLACE PROCEDURE prc_ActasFNB_Reversa_RC IS
/*
    Propiedad intelectual de Gases del Caribe

    Unidad:       prc_ActasFNB_Reversa_RC
    Descripcion:  Ejecuta el Procedimiento para programar la reversión los registros contables (RC),
                  de las actas brilla procesadas el día inmediatamente anterior a su ejecución.
                  Se crea para poder ser usado desde GEMPS

    Autor:        German Dario Guevara Alzate - GlobaMVM
    Fecha:        05/04/2024
*/
BEGIN
    pkg_ContabilizaActasAut.prReversaRC_ActasFNB;
EXCEPTION
   WHEN OTHERS THEN
      pkg_traza.trace('Error en procedimiento prc_ActasFNB_Reversa_RC '||SQLERRM, 10);
END prc_ActasFNB_Reversa_RC;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('PRC_ACTASFNB_REVERSA_RC','OPEN');
END;
/