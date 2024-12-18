CREATE OR REPLACE PROCEDURE adm_person.ldc_procvalidafununidoper(
                                                      nuunidadoper  or_operating_unit.operating_unit_id%TYPE
                                                     ,nufuncionario ge_person.person_id%TYPE
                                                     ,nucoderror    OUT NUMBER
                                                     ,sbmensaerror  OUT VARCHAR2
                                                     ) IS
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  ldc_procvalidafununidoper
  Descripcion :  

  Autor       : 
  Fecha       : 

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  09/05/2024          Paola Acosta       OSF-2672: Cambio de esquema ADM_PERSON                                         
  **************************************************************************/
  
nucontaunper       NUMBER(6);
sbnombrefuncinario ge_person.name_%TYPE;
sbnombreunitoper   or_operating_unit.name%TYPE;
error              EXCEPTION;
BEGIN
 SELECT COUNT(*) INTO nucontaunper
   FROM or_oper_unit_persons up
  WHERE up.operating_unit_id = nuunidadoper
    AND up.person_id         = nufuncionario;
     IF nucontaunper = 0 THEN
      nucoderror   := -1;
      BEGIN
       SELECT pe.name_ INTO sbnombrefuncinario
         FROM ge_person pe
        WHERE pe.person_id = nufuncionario;
      EXCEPTION
       WHEN no_data_found THEN
        sbnombrefuncinario := '------';
      END;
      BEGIN
       SELECT uo.name INTO sbnombreunitoper
         FROM or_operating_unit uo
        WHERE uo.operating_unit_id = nuunidadoper;
      EXCEPTION
       WHEN no_data_found THEN
        sbnombreunitoper := '------';
      END;
      sbmensaerror := 'El funcionario : "'||to_char(nufuncionario)||' - '||sbnombrefuncinario||'", no pertenece a la unidad operativa : "'||to_char(nuunidadoper)||' - '||sbnombreunitoper||'". Favor validar la información.';
     ELSE
      nucoderror   := 0;
      sbmensaerror := 'Ok.';
     END IF;
EXCEPTION
 WHEN OTHERS THEN
  nucoderror   := -1;
  sbmensaerror := 'Error al ejecutar el procedimiento : ldc_procvalidafununidoper. '||SQLERRM;
END ldc_procvalidafununidoper;
/
PROMPT Otorgando permisos de ejecucion a LDC_PROCVALIDAFUNUNIDOPER
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PROCVALIDAFUNUNIDOPER', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_PROCVALIDAFUNUNIDOPER para reportes
GRANT EXECUTE ON adm_person.LDC_PROCVALIDAFUNUNIDOPER TO rexereportes;
/