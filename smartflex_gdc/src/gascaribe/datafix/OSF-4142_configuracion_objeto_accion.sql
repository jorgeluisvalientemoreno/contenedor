column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare


  sbExiste    varchar2(1);

  -- Poblacion a la que aplica el Datafix
  CURSOR cuExiste(isbTipoAccion VARCHAR, isbNombreObje VARCHAR2) IS
  SELECT 'X'
  FROM objetos_accion
  WHERE idaccion = 7
    AND tipoaccion = isbTipoAccion
    AND nombreobjeto = isbNombreObje
    AND tipotrabajo = 11260;

begin
   OPEN cuExiste('POST',  'OAL_INACTIVARPRODCASTIGADO');
   FETCH cuExiste INTO sbExiste;
   CLOSE cuExiste;

   IF sbExiste IS NULL THEN
      INSERT INTO objetos_accion (idaccion, tipoaccion, nombreobjeto, tipotrabajo, idactividad, idcausal, unidadoperativa, descripcion, procesonegocio, ordenejecucion, activo, fechacreacion)
         VALUES(7, 'POST', 'OAL_INACTIVARPRODCASTIGADO', 11260, NULL, NULL, NULL, 'INACTIVA PRODUCTO CASTIGADO POR CAMBIO DE MEDIDOR', 6, 1, 'S',SYSDATE);
   END IF;

   sbExiste := NULL;

   OPEN cuExiste('PRE',  'OAL_ACTIVARPRODCASTIGADO');
   FETCH cuExiste INTO sbExiste;
   CLOSE cuExiste;
   
   IF sbExiste IS NULL THEN
    INSERT INTO objetos_accion (idaccion, tipoaccion, nombreobjeto, tipotrabajo, idactividad, idcausal, unidadoperativa, descripcion, procesonegocio, ordenejecucion, activo, fechacreacion)
      VALUES(7, 'PRE', 'OAL_ACTIVARPRODCASTIGADO', 11260, NULL, NULL, NULL, 'ACTIVA TEMPORALMENTE PRODUCTO CASTIGADO POR CAMBIO DE MEDIDOR', 6, 1, 'S',SYSDATE);
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    rollback;
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/