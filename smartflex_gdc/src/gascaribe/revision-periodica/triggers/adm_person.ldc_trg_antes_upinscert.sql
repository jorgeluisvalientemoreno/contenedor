CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_ANTES_UPINSCERT
/****************************************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : LDC_TRG_ANTES_UPINSCERT
  Descripcion    : Se valida antes que ingrese el certificado, que no exista uno vigente
  Autor          : John Jairo Jimenez Marim?n
  Fecha          : 28/05/2013

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  13/08/2018        josh brito        caso 200-2078 si encuentra un certificado activo en la tabla ldc_certificados_oia,
                                      valide que la fecha del día sea mayor a la fecha de inspección del certificado vigente.
                                      Si esta condición se da, permita continuar con la actualización, de lo contrario, se retorne mensaje de error
********************************************************************************************/
  BEFORE UPDATE OR INSERT ON ldc_certificados_oia
  FOR EACH ROW

DECLARE
  onuErrorCode    NUMBER;
  osbErrorMessage VARCHAR2(2000);
  nucontar        NUMBER;
  dtplazominimo   DATE;
BEGIN
   ut_trace.trace('Inicio LDC_TRG_INSCERT', 10);
   --Ejecutar el proceso solo si el certificado oia est? aprobado
   -- Validamos si se esta insertando
    IF fsbaplicaentrega('OSS_CON_ELAL_200_1607_1') = 'S' THEN
     IF inserting THEN
        nucontar := 0;
       SELECT COUNT(1) INTO nucontar
         FROM ldc_certificados_oia v
        WHERE v.id_producto = :new.id_producto
          AND v.status_certificado = 'A'
          AND v.FECHA_INSPECCION > :new.FECHA_INSPECCION;
        BEGIN
         SELECT plazo_minimo INTO dtplazominimo
           FROM(
                SELECT cv.plazo_min_revision plazo_minimo
                  FROM open.ldc_plazos_cert cv
                 WHERE cv.id_producto = :new.id_producto
                 ORDER BY cv.plazo_min_revision DESC
               )
          WHERE rownum = 1;
        EXCEPTION
         WHEN OTHERS THEN
          dtplazominimo := to_date('01/01/1900','dd/mm/yyyy');
        END;
      IF nucontar >= 1 AND trunc(SYSDATE) < trunc(dtplazominimo) THEN
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'ERROR: EL PRODUCTO : '||TO_CHAR(:new.id_producto)||' YA TIENE UN CERTFICADO APROBADO INGRESADO.');
       RAISE ex.controlled_error;
      END IF;
     END IF;
    END IF;
EXCEPTION
 WHEN ex.controlled_error THEN
  Errors.geterror(onuErrorCode, osbErrorMessage);
  RAISE ex.controlled_error;
END LDC_TRG_ANTES_UPINSCERT;
/
