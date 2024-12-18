CREATE OR REPLACE PROCEDURE prc_ActasFNB_Contabiliza_Sap IS
/*
    Propiedad intelectual de Gases del Caribe

    Unidad:       prc_ActasFNB_Contabiliza_Sap
    Descripcion:  Ejecuta el Procedimiento que registra la informacion de la contabilizacion
                  de las actas brilla procesadas el día inmediatamente anterior a su ejecución.
                  Se crea para poder ser usado desde GEMPS

    Autor:        German Dario Guevara Alzate - GlobaMVM
    Fecha:        05/04/2024
*/
BEGIN
    pkg_ContabilizaActasAut.prProcesaActasFNB_Sap;
EXCEPTION
   WHEN OTHERS THEN
      pkg_traza.trace('Error en procedimiento prc_ActasFNB_Contabiliza_Sap '||SQLERRM, 10);
END prc_ActasFNB_Contabiliza_Sap;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('PRC_ACTASFNB_CONTABILIZA_SAP','OPEN');
END;
/