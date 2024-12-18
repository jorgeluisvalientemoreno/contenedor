CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_TIPO_ASIGNACION_UO
  BEFORE INSERT OR UPDATE OF Assign_Type ON OR_OPERATING_UNIT
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW

/**************************************************************
Propiedad intelectual de Gases del Caribe

Trigger       :  LDC_TRG_TIPO_ASIGNACION_UO
Descripcion   : Trigger que valida cuando se este inserta o actualiza el tipo de asignacion
                la actualizacion del estado.

Autor         : Jorge Valiente
Fecha         : 12-04-2022

Historia de Modificaciones
Fecha        IDEntrega           Modificacion
**************************************************************/

DECLARE

BEGIN

  ut_trace.Trace('Inicio: LDC_TRG_TIPO_ASIGNACION_UO', 10);
  ut_trace.Trace('OSF Jira 186', 10);

  IF FBLAPLICAENTREGAXCASO('OSF-186') THEN

    IF :new.assign_type = 'C' Then
      :new.assign_type := 'N';
    END IF;
  END IF;

  ut_trace.Trace('Fin: LDC_TRG_TIPO_ASIGNACION_UO', 10);

EXCEPTION
  when ex.CONTROLLED_ERROR then
    GE_BOERRORS.SETERRORCODEARGUMENT(2741,
                                     'Error al actualizar Tipo Asignacion de CAPACIDAD HORARIA a POR DEMANDA');
    raise;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
END;
/
