set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25
DEFINE CASO=OSF-1856

SELECT SYS_CONTEXT('USERENV', 'DB_NAME') instancia,
       TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss') fecha_ejec,
       SYS_CONTEXT('USERENV','CURRENT_SCHEMA') esquema,
       USER ejecutado_por,
       SYS_CONTEXT('USERENV', 'OS_USER') usuario_so
  FROM DUAL;

PROMPT
PROMPT =========================================
PROMPT  ****   Información de Ejecución    ****
PROMPT =========================================
PROMPT Instancia        : &instancia
PROMPT Fecha ejecución  : &fecha_ejec
PROMPT Usuario DB       : &ejecutado_por
PROMPT Usuario O.S      : &usuario_so
PROMPT Esquema          : &esquema
PROMPT CASO             : &CASO
PROMPT =========================================
PROMPT
PROMPT **** INICIO ****

DECLARE
/***********************************************************
ELABORADO POR:  Edilay Peña Osorio - Global MVM
FECHA:          04/12/2023
CASO:           OSF-1856
DESCRIPCIÓN:
Actualiza el registro para el servicio DAMO_PACKAGES.FRCGETRECORS 
por el nombre correcto: DAMO_PACKAGES.GETRECORD 

***********************************************************/

csbComilla          VARCHAR2(1) := chr(39);    
rcNuevoServicio     homologacion_servicios%ROWTYPE;

begin

    update homologacion_servicios
      set SERVICIO_ORIGEN = 'DAMO_PACKAGES.GETRECORD'
    where SERVICIO_ORIGEN = 'DAMO_PACKAGES.FRCGETRECORS'
    ;
    COMMIT; 
    dbms_output.put_line('Actualizado servicio DAMO_PACKAGES.FRCGETRECORS por DAMO_PACKAGES.GETRECORD');

exception
  when others then
        dbms_output.put_line('Error actualizando:DAMO_PACKAGES.GETRECORD');
        dbms_output.put_line('Error:'||sqlcode||'-'||sqlerrm);
        rollback;

end;
/
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin
  FROM DUAL;
PROMPT **** FIN EJECUCIÓN ****
PROMPT CASO             : &CASO
PROMPT Fecha fin        : &fecha_fin
PROMPT =========================================

set serveroutput off
/