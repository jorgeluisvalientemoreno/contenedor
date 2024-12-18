CREATE OR REPLACE procedure adm_person.GENIFRS_DUMMY
/**************************************************************************
   Autor       : Daniel Valiente / Horbath
   Fecha       : 2021-12-06
   Ticket      : 906
   Proceso     : GENIFRS_DUMMY
   Descripcion : Procedimiento vacio para ejecucion de GENIFRS

   HISTORIA DE MODIFICACIONES
   FECHA            AUTOR       DESCRIPCION
   17/06/2024       PAcosta     OSF-2795: Cambio de esquema ADM_PERSON 
  ***************************************************************************/
 IS
  nuVar NUMBER;
BEGIN
  nuVar := 1;
EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise;
  when OTHERS then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
end GENIFRS_DUMMY;
/

PROMPT Otorgando permisos de ejecucion a GENIFRS_DUMMY
BEGIN
    pkg_utilidades.praplicarpermisos('GENIFRS_DUMMY', 'ADM_PERSON');
END;
/