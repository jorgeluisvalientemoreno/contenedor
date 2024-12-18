set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25
DEFINE CASO=OSF-1756

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
FECHA:          13/12/2023
CASO:           OSF-1865
DESCRIPCIÓN:
Se registra el servicio ldc_boutilities.splitstrings
Archivo de entrada:

Archivo de Salida:

***********************************************************/

rcNuevoServicio     homologacion_servicios%ROWTYPE;

begin


  begin
        
    rcNuevoServicio.esquema_origen     := 'OPEN';
    rcNuevoServicio.servicio_origen    := 'LDC_BOUTILITIES.SPLITSTRINGS';
    rcNuevoServicio.descripcion_origen := 'Método que retorna una tabla con la cadena enviada.';
    rcNuevoServicio.esquema_destino    := 'N/A';
    rcNuevoServicio.servicio_destino   := 'REGEXP_SUBSTR';
    rcNuevoServicio.descripcion_destino:= 'Utilización buenas prácticas. Ver campo observación';
    rcNuevoServicio.observacion        := '--Código actual'||chr(10)||
                                          'SELECT TO_NUMBER (COLUMN_VALUE)'||chr(10)||
                                          '  FROM TABLE ( ldc_boutilities.splitstrings ('||chr(10)||
                                          '                                             dald_parameter.fsbgetvalue_chain ('||chr(39)||'VAL_TRAMITES_NUEVOS_FLUJOS'||chr(39)||',NULL),'||chr(10)||
                                          '                                             '||chr(39)||','||chr(39)||chr(10)||
                                          '                                            )'||chr(10)||
                                          '             )'||chr(10)||
                                          '--***************************'||chr(10)||
                                          '--Código sugerido'||chr(10)||
                                          ''||chr(10)||
                                          'SELECT (regexp_substr(dald_parameter.fsbgetvalue_chain ('||chr(39)||'VAL_TRAMITES_NUEVOS_FLUJOS'||chr(39)||',NULL),'||chr(10)||
                                          '                                                        '||chr(39)||'[^,]+'||chr(39)||', '||chr(10)||
                                          '                                                        1, '||chr(10)||
                                          '                                                        LEVEL)'||chr(10)||
                                          '                                                        ) AS vlrColumna'||chr(10)||
                                          '  FROM dual'||chr(10)||
                                          'CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain ('||chr(39)||'VAL_TRAMITES_NUEVOS_FLUJOS'||chr(39)||',NULL), '||chr(10)||
                                          '                                                          '||chr(39)||'[^,]+'||chr(39)||', '||chr(10)||
                                          '                                                          1,'||chr(10)||
                                          '                                                          LEVEL'||chr(10)||
                                          '                                                          ) IS NOT NULL  '||chr(10)
                                          ;

    insert into homologacion_servicios values rcNuevoServicio;
    dbms_output.put_line('Creado servicio de homologación para: OPEN.LDC_BOUTILITIES.SPLITSTRINGS nuevo servcio: Ver registro en tabla');
    commit;

  exception
    when others then
         dbms_output.put_line('Error actualizando:OPEN.DAOR_OPERATING_UNIT.FSBGETASSIGN_TYPE');
         dbms_output.put_line('Error:'||sqlcode||'-'||sqlerrm);
         rollback;
  end;  
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