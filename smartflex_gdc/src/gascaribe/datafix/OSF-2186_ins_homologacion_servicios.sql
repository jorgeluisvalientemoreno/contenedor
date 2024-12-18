set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25
DEFINE CASO=OSF-2186

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
FECHA:          10/11/2023
CASO:           OSF-2186
DESCRIPCIÓN:
Inserta los servicios para la validación de entregas aplicadas
ya que estos no se deben utilizar más. 

***********************************************************/
 
rcNuevoServicio     homologacion_servicios%ROWTYPE;
begin
    begin        
        rcNuevoServicio.esquema_origen     := 'OPEN';
        rcNuevoServicio.servicio_origen    := 'FBLAPLICAENTREGA';
        rcNuevoServicio.descripcion_origen := 'Validación si la entrega aplica en el ambiente de ejecución.';
        rcNuevoServicio.esquema_destino    := 'N/A';
        rcNuevoServicio.servicio_destino   := 'VER OBSERVACIÓN';
        rcNuevoServicio.descripcion_destino:= 'VER OBSERVACIÓN';
        rcNuevoServicio.observacion        := '--Se debe validar el condicional en el que se encuentra el objeto con el fin de eliminar el'||chr(13)||
                                                '--Código que no aplica y dejar solo el que sí debe seguirse ejecutando. Ejemplo:'||chr(13)||
                                                '     if FBLAPLICAENTREGA(nucaso) then'||chr(13)||
                                                '         ---hace x, y, z'||chr(13)||
                                                '     else '||chr(13)||
                                                '         ---hace abc '||chr(13)||
                                                '     end if;'||chr(13)||
                                                'En este caso se debe validar el resultado de la función con el caso enviado, sí el resultado es true'||chr(13)||
                                                'se sacan del if las opciones: x,y y z para que se ejecuten siempre y se borra  todo el condicional.'||chr(13)||
                                                ' Si retorna false se sacan del if las opciones abc para que se ejecuten siempre y se borra todo el condicional.';
        insert into homologacion_servicios values rcNuevoServicio;
        dbms_output.put_line('Creado servicio de homologación para: FBLAPLICAENTREGA');
        commit;
    exception
    when others then
            dbms_output.put_line('Error insertando servicio: FBLAPLICAENTREGA');
            dbms_output.put_line('Error:'||sqlcode||'-'||sqlerrm);
            rollback;  
    end;-- fin inserta  FBLAPLICAENTREGA    
    ---------------------------------------------
    begin
        rcNuevoServicio.esquema_origen     := 'OPEN';
        rcNuevoServicio.servicio_origen    := 'FBLAPLICAENTREGAXCASO';
        rcNuevoServicio.descripcion_origen := 'Validación si la entrega aplica en el ambiente de ejecución.';
        rcNuevoServicio.esquema_destino    := 'N/A';
        rcNuevoServicio.servicio_destino   := 'VER OBSERVACIÓN';
        rcNuevoServicio.descripcion_destino:= 'VER OBSERVACIÓN';
        rcNuevoServicio.observacion        := '--Se debe validar el condicional en el que se encuentra el objeto con el fin de eliminar el'||chr(13)||
                                            '--Código que no aplica y dejar solo el que sí debe seguirse ejecutando. Ejemplo:'||chr(13)||
                                            '     if FBLAPLICAENTREGAXCASO(nucaso) then'||chr(13)||
                                            '         ---hace x, y, z'||chr(13)||
                                            '     else '||chr(13)||
                                            '         ---hace abc '||chr(13)||
                                            '     end if;'||chr(13)||
                                            'En este caso se debe validar el resultado de la función con el caso enviado, sí el resultado es true'||chr(13)||
                                            'se sacan del if las opciones: x,y y z para que se ejecuten siempre y se borra  todo el condicional  '||chr(13)||
                                            'Si retorna false se sacan del if las opciones abc para que se ejecuten siempre y se borra todo el condicional.';
        insert into homologacion_servicios values rcNuevoServicio;
        dbms_output.put_line('Creado servicio de homologación para: FBLAPLICAENTREGAXCASO');   
    commit;
    exception
    when others then
            dbms_output.put_line('Error insertando servicio: FBLAPLICAENTREGAXCASO');
            dbms_output.put_line('Error:'||sqlcode||'-'||sqlerrm);
            rollback;  
    end;-- fin inserta  FBLAPLICAENTREGAXCASO       
    ---------------------------------------------
    begin
        rcNuevoServicio.esquema_origen     := 'OPEN';
        rcNuevoServicio.servicio_origen    := 'FNUAPLICAENTREGA';
        rcNuevoServicio.descripcion_origen := 'Validación si la entrega aplica en el ambiente de ejecución.';
        rcNuevoServicio.esquema_destino    := 'N/A';
        rcNuevoServicio.servicio_destino   := 'VER OBSERVACIÓN';
        rcNuevoServicio.descripcion_destino:= 'VER OBSERVACIÓN';
        rcNuevoServicio.observacion        := '--Se debe validar el condicional en el que se encuentra el objeto con el fin de eliminar el'||chr(13)||
                                            '--Código que no aplica y dejar solo el que sí debe seguirse ejecutando. Ejemplo:'||chr(13)||
                                            '     if FNUAPLICAENTREGA(nucaso) = 1 then'||chr(13)||
                                            '         ---hace x, y, z'||chr(13)||
                                            '     else '||chr(13)||
                                            '         ---hace abc '||chr(13)||
                                            '     end if;'||chr(13)||
                                            'En este caso se debe validar el resultado de la función con el caso enviado, sí el resultado es 1'||chr(13)||
                                            'se sacan del if las opciones: x,y y z para que se ejecuten siempre y se borra  todo el condicional  '||chr(13)||
                                            'Si retorna 0 se sacan del if las opciones abc para que se ejecuten siempre y se borra todo el condicional.';
        insert into homologacion_servicios values rcNuevoServicio;
        dbms_output.put_line('Creado servicio de homologación para: FNUAPLICAENTREGA');
        commit;    
    exception
    when others then
            dbms_output.put_line('Error insertando servicio: FNUAPLICAENTREGA');
            dbms_output.put_line('Error:'||sqlcode||'-'||sqlerrm);
            rollback;  
    end;-- fin inserta  FNUAPLICAENTREGA       
    ---------------------------------------------
    begin
        rcNuevoServicio.esquema_origen     := 'OPEN';
        rcNuevoServicio.servicio_origen    := 'LDC_FBLAPLICAENTREGA';
        rcNuevoServicio.descripcion_origen := 'Validación si la entrega aplica en el ambiente de ejecución.';
        rcNuevoServicio.esquema_destino    := 'N/A';
        rcNuevoServicio.servicio_destino   := 'VER OBSERVACIÓN';
        rcNuevoServicio.descripcion_destino:= 'VER OBSERVACIÓN';
        rcNuevoServicio.observacion        := '--Se debe validar el condicional en el que se encuentra el objeto con el fin de eliminar el'||chr(13)||
                                            '--Código que no aplica y dejar solo el que sí debe seguirse ejecutando. Ejemplo:'||chr(13)||
                                            '     if LDC_FBLAPLICAENTREGA(nucaso) = SIA then'||chr(13)||
                                            '         ---hace x, y, z'||chr(13)||
                                            '     else '||chr(13)||
                                            '         ---hace abc '||chr(13)||
                                            '     end if;'||chr(13)||
                                            'En este caso se debe validar el resultado de la función con el caso enviado, sí el resultado es SI'||chr(13)||
                                            'se sacan del if las opciones: x,y y z para que se ejecuten siempre y se borra  todo el condicional.  '||chr(13)||
                                            'Si retorna NO se sacan del if las opciones abc para que se ejecuten siempre y se borra todo el condicional.';
        insert into homologacion_servicios values rcNuevoServicio;
        dbms_output.put_line('Creado servicio de homologación para: LDC_FBLAPLICAENTREGA');
        commit; 
    exception
    when others then
            dbms_output.put_line('Error insertando servicio: LDC_FBLAPLICAENTREGA');
            dbms_output.put_line('Error:'||sqlcode||'-'||sqlerrm);
            rollback;  
    end;-- fin inserta  LDC_FBLAPLICAENTREGA            

    ---------------------------------------------
    begin
        rcNuevoServicio.esquema_origen     := 'OPEN';
        rcNuevoServicio.servicio_origen    := 'LDC_FNAPLICAENTREGAXCASO';
        rcNuevoServicio.descripcion_origen := 'Validación si la entrega aplica en el ambiente de ejecución.';
        rcNuevoServicio.esquema_destino    := 'N/A';
        rcNuevoServicio.servicio_destino   := 'VER OBSERVACIÓN';
        rcNuevoServicio.descripcion_destino:= 'VER OBSERVACIÓN';
        rcNuevoServicio.observacion        := '--Se debe validar el condicional en el que se encuentra el objeto con el fin de eliminar el'||chr(13)||
                                            '--Código que no aplica y dejar solo el que sí debe seguirse ejecutando. Ejemplo:'||chr(13)||
                                            '     if LDC_FNAPLICAENTREGAXCASO(nucaso) = 1 then'||chr(13)||
                                            '         ---hace x, y, z'||chr(13)||
                                            '     else '||chr(13)||
                                            '         ---hace abc '||chr(13)||
                                            '     end if;'||chr(13)||
                                            'En este caso se debe validar el resultado de la función con el caso enviado, sí el resultado es 1'||chr(13)||
                                            'se sacan del if las opciones: x,y y z para que se ejecuten siempre y se borra  todo el condicional.  '||chr(13)||
                                            'Si retorna 0 se sacan del if las opciones abc para que se ejecuten siempre y se borra todo el condicional.';
        insert into homologacion_servicios values rcNuevoServicio;
        dbms_output.put_line('Creado servicio de homologación para: LDC_FNAPLICAENTREGAXCASO');
        commit;  
    exception
    when others then
            dbms_output.put_line('Error insertando servicio: LDC_FNAPLICAENTREGAXCASO');
            dbms_output.put_line('Error:'||sqlcode||'-'||sqlerrm);
            rollback;  
    end;-- fin inserta  LDC_FNAPLICAENTREGAXCASO             
    ---------------------------------------------
    begin
        rcNuevoServicio.esquema_origen     := 'OPEN';
        rcNuevoServicio.servicio_origen    := 'LDC_FNU_APLICAENTREGA';
        rcNuevoServicio.descripcion_origen := 'Validación si la entrega aplica en el ambiente de ejecución.';
        rcNuevoServicio.esquema_destino    := 'N/A';
        rcNuevoServicio.servicio_destino   := 'VER OBSERVACIÓN';
        rcNuevoServicio.descripcion_destino:= 'VER OBSERVACIÓN';
        rcNuevoServicio.observacion        := '--Se debe validar el condicional en el que se encuentra el objeto con el fin de eliminar el'||chr(13)||
                                            '--Código que no aplica y dejar solo el que sí debe seguirse ejecutando. Ejemplo:'||chr(13)||
                                            '     if LDC_FNU_APLICAENTREGA(nucaso) = 1 then'||chr(13)||
                                            '         ---hace x, y, z'||chr(13)||
                                            '     else '||chr(13)||
                                            '         ---hace abc '||chr(13)||
                                            '     end if;'||chr(13)||
                                            'En este caso se debe validar el resultado de la función con el caso enviado, sí el resultado es 1'||chr(13)||
                                            'se sacan del if las opciones: x,y y z para que se ejecuten siempre y se borra  todo el condicional.  '||chr(13)||
                                            'Si retorna 0 se sacan del if las opciones abc para que se ejecuten siempre y se borra todo el condicional.';
        insert into homologacion_servicios values rcNuevoServicio;
        dbms_output.put_line('Creado servicio de homologación para: LDC_FNU_APLICAENTREGA');
        commit;  
        exception
        when others then
                dbms_output.put_line('Error insertando servicio: LDC_FNU_APLICAENTREGA');
                dbms_output.put_line('Error:'||sqlcode||'-'||sqlerrm);
                rollback;  
        end;-- fin inserta  LDC_FNU_APLICAENTREGA      
exception
when others then
        dbms_output.put_line('Error actualizando:OPEN.DAOR_OPERATING_UNIT.FSBGETASSIGN_TYPE');
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