CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TGR_ALMACEN
/**************************************************************************

  UNIDAD      :  LDC_TGR_ALMACEN
  Descripcion :  Trigger que valida el ingreso de valores en el campo ALMACEN
                 cuando se intenta crear uan unidad operativa.
  Autor       :  Antonio Benitez Llorente
  Fecha       :  15-07-2019

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================

  **************************************************************************/
BEFORE INSERT OR UPDATE OF ASSO_OPER_UNIT ON OR_OPERATING_UNIT
FOR EACH ROW
DECLARE
 sbEntrega varchar2(30):='OSS_OL_0000022_2';
BEGIN
  IF fblaplicaentrega(sbEntrega) THEN
     ut_trace.trace('INICIA LOG LDC_TGR_ALMACEN ',5);
     if :NEW.ASSO_OPER_UNIT IS NOT null then
       GE_BOERRORS.SETERRORCODEARGUMENT(2741,'ERROR, NO SE PUEDE INGRESAR VALOR EN EL CAMPO: ALMACEN');
     end if;
     ut_trace.trace('FINALIZA LOG LDC_TGR_ALMACEN ',5);
  END IF;
END;
/
