CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_TIPOLOCALIDADUNIDAD
BEFORE INSERT OR UPDATE ON TIPOLOCALIDADUNIDAD
FOR EACH ROW
DECLARE
  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Trigger     : LDC_TRG_TIPOLOCALIDADUNIDAD
  Descripcion : Trigger para controlar el ingreso de items en la tabla TIPOLOCALIDADUNIDAD.
                Consiste en validar que no se registre una combinación localidad y tipo de lista
                que ya esté configurada en la forma LDCTIPOLISTA (LDC_LOC_TIPO_LIST_DEP).
  Autor       : Sebastian Tapias || 200-1261
  Fecha       : 13-07-2017

  Historia de Modificaciones

    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  /*Variable para almacenar fecha actual*/
  x          number;
  msgerror   varchar2(200);
BEGIN
  /*Validamos si el tipo de lista y la localidad existen la tabla LDC_LOC_TIPO_LIST_DEP*/
  x := 0;
  SELECT COUNT(1)
    INTO x
    FROM LDC_LOC_TIPO_LIST_DEP LT
   WHERE LT.TIPO_LISTA = :new.tipo_lista--tipo_lista
     AND LT.LOCALIDAD = :new.localidad;--localidad;
  /*En caso de tener registro mandaremos error*/
  if x >= 1 then
    msgerror := 'Ya existe un registro tipo de lista: ' || :new.tipo_lista ||
                ' localidad: ' || :new.localidad || ' en la forma LDCTIPOLISTA';
    dbms_output.put_line(msgerror);
    errors.seterror(-1, msgerror);
    RAISE ex.controlled_error;
  end if;
EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE;
  WHEN others THEN
    RAISE;
END;
/
