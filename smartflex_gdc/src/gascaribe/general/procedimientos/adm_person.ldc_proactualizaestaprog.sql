CREATE OR REPLACE PROCEDURE adm_person.ldc_proactualizaestaprog(
                                                     v_sesion NUMBER
                                                     ,v_observacion VARCHAR2
                                                     ,v_proceso VARCHAR2
                                                     ,v_estado VARCHAR2
                                                   ) IS
 PRAGMA AUTONOMOUS_TRANSACTION;
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-21-12
  Descripcion : Actualizamos estado del proceso

  Parametros Entrada
    v_sesion sesion
    v_observacion
    v_proceso proceso
    v_estado estado


  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
   16/05/2024   Adrianavg   OSF-2675: Se migra del esquema OPEN al esquema ADM_PERSON
***************************************************************************/
BEGIN
 UPDATE ldc_osf_estaproc l
    SET fecha_final_ejec = SYSDATE,
        estado = 'Terminó '||v_estado,
        l.observacion = v_observacion
  WHERE l.sesion = v_sesion
    AND l.proceso = v_proceso;
 COMMIT;
END;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PROACTUALIZAESTAPROG
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROACTUALIZAESTAPROG', 'ADM_PERSON'); 
END;
/
