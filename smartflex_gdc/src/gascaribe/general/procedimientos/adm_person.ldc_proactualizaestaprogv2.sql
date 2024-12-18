CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PROACTUALIZAESTAPROGv2(
																 v_sesion NUMBER
																 ,v_observacion VARCHAR2
																 ,v_proceso VARCHAR2
																 ,v_estado VARCHAR2
																 ,vrowid   VARCHAR2
															   ) IS
 PRAGMA AUTONOMOUS_TRANSACTION;
/**************************************************************************
  Autor       : dsaltarin
  Fecha       : 27/09/2021
  Descripcion : Se modifica el proceso LDC_PROACTUALIZAESTAPROG para agregar
                el rowid que se va a actualizar, ya que cuando se ejecuta esta funcion
                en un job actualiza multimples registros

  Parametros Entrada
    v_sesion sesion
    v_observacion
    v_proceso proceso
    v_estado estado
    vrowid   rowid


  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
BEGIN
 UPDATE ldc_osf_estaproc l
    SET fecha_final_ejec = SYSDATE,
        estado = 'Termino '||v_estado,
        l.observacion = v_observacion
  WHERE l.sesion = v_sesion
    AND l.proceso = v_proceso
    AND l.rowid = vrowid;
 COMMIT;
END;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROACTUALIZAESTAPROGv2', 'ADM_PERSON');
END;
/
