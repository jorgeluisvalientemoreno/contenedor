/*****************************************************************
    Propiedad intelectual de GDC.

    Unidad         : fnuGetLecturaSuger
    Descripcion    : funcion que retorna la lectura de retiro sugerida
    Autor          : Luis Felipe Valencia Hurtado
    Ticket         : OSF-625     
    Fecha          : 12/01/2023
    
    Datos de Entrada
      inuProductId          Producto
      idtEjecDate           Fecha de Ejecución
      isbTipoLect           Tipo de Lectura
      idtFechaUltLect       Fecha de Última Lectura
      inuperiactual         Periodo Actual
      inuano                Año
      inumes                Mes
      inuUltiLect           Última Lectura
      inuPeriConsact        Periodo de Consumo Actual
      inuDiasConsActu       Días de Consumo de Periodo Actual
      inuCicloCons          Ciclo de Consumo

    Historia de Modificaciones
    Fecha                Autor             Modificacion
    =========            =========         ====================
    OSF-1421             felipe.valencia    Se elimina la función
  ******************************************************************/
DECLARE
  nuConta NUMBER;
BEGIN
SELECT COUNT(1) INTO nuConta
  FROM DBA_OBJECTS
  WHERE OBJECT_NAME = upper('ldc_fnuGetLecturaSuger')
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE='FUNCTION';

  IF nuConta >= 1 THEN
      EXECUTE IMMEDIATE 'DROP FUNCTION  OPEN.ldc_fnuGetLecturaSuger';
  END IF;
END;
/
