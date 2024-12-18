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
FECHA:          10/11/2023
CASO:           OSF-1756
DESCRIPCIÓN:
Actualizacón nombre de servicios origen de los DAO, el nombre actual es
FSBCAMPO o FNUCAMPO, se actualiza por el nombre correcto que debe ser:
FSBGETCAMPO o FNUCAMPO. 

Archivo de entrada:

Archivo de Salida:

***********************************************************/
cursor cuServicioErr is 
WITH excluidos as
(
  select he.* 
    from homologacion_servicios he
   where (   upper(servicio_origen) like upper('%DA%.FSBG%')
          OR upper(servicio_origen) like upper('%DA%.FNUG%')  
       )
),
nuevo as
(
select hs.esquema_origen, hs.servicio_origen, hs.esquema_destino,  hs.servicio_destino,
       CASE 
        WHEN INSTR(servicio_origen,'.FSB') > 0 THEN
             replace (servicio_origen,'.FSB','.FSBGET') 
        WHEN INSTR(servicio_origen,'.FNU') > 0 THEN
             replace (servicio_origen,'.FNU','.FNUGET') 
        END NUEVO_NOMBRE
  from homologacion_servicios hs
 where (   upper(servicio_origen) like upper('DA%.FSB%')--Dage_Subscriber.fsbGetSubscriber_Name
        OR upper(servicio_origen) like upper('DA%.FNU%')  
       )
   and not exists (select 'x'
                     from excluidos e
                    where e.servicio_origen = hs.servicio_origen 
                   )
)
select  n.esquema_origen, n.servicio_origen, n.esquema_destino,  n.servicio_destino,
        n.nuevo_nombre,
       (select count(1) tot 
          from all_procedures
        where object_name||'.'||procedure_name = n.NUEVO_NOMBRE
       ) valida
  from nuevo n
;  
    
rcNuevoServicio     homologacion_servicios%ROWTYPE;
begin
  for rcServicioErr in cuServicioErr loop
  begin
      if rcServicioErr.valida = 1 then
            update homologacion_servicios se
               set se.servicio_origen = rcServicioErr.NUEVO_NOMBRE
             where se.esquema_origen  = rcServicioErr.esquema_origen
               and se.servicio_origen = rcServicioErr.servicio_origen
               and se.esquema_destino = rcServicioErr.esquema_destino
               and se.servicio_destino= rcServicioErr.servicio_destino; 
              commit;
              dbms_output.put_line('modificado servicio '||
                                    rcServicioErr.esquema_origen||'.'||rcServicioErr.servicio_origen||
                                    ' por: '||
                                    rcServicioErr.NUEVO_NOMBRE||
                                    '|OK');
              
     else 
        dbms_output.put_line('No se encontro método correspondiente para el servicio origen: '||
                              rcServicioErr.esquema_origen||'.'||
                              rcServicioErr.servicio_origen||
                              '| NO ENCONTRADO'
                            );             
          
     end if;
  exception
    when others then
         dbms_output.put_line('Error actualizando:'||rcServicioErr.esquema_origen||'.'||
                              rcServicioErr.servicio_origen);
         dbms_output.put_line('Error:'||sqlcode||'-'||sqlerrm);
         rollback;
  end;
  end loop;
  
  --actualización casos puntuales: 
  dbms_output.put_line('Actualizaciones puntuales');
  begin
    update homologacion_servicios se
      set se.servicio_origen = 'DAOR_OPERATING_UNIT.FSBGETASSIGN_TYPE'
    where se.esquema_origen  = 'OPEN'
      and se.servicio_origen = 'DAOR_OPERATING_UNIT.FNUASSIGN_TYPE'
      and se.esquema_destino = 'ADM_PERSON'
      and se.servicio_destino= 'PKG_BCUNIDADOPERATIVA.FSBGETTIPOASIGNACION'; 
      dbms_output.put_line('modificado servicio '||
                      'OPEN.DAOR_OPERATING_UNIT.FNUASSIGN_TYPE'||
                      ' por: '||
                      'DAOR_OPERATING_UNIT.FSBGETASSIGN_TYPE'||
                      '|OK');
      commit;                

  exception
    when others then
         dbms_output.put_line('Error actualizando:OPEN.DAOR_OPERATING_UNIT.FSBGETASSIGN_TYPE');
         dbms_output.put_line('Error:'||sqlcode||'-'||sqlerrm);
         rollback;
  end;

  begin
        
    rcNuevoServicio.esquema_origen     := 'OPEN';
    rcNuevoServicio.servicio_origen    := 'LD_BOFLOWFNBPACK.COMMENTDELORDER';
    rcNuevoServicio.descripcion_origen := 'Método creación comentario para la orden de entrega.';
    rcNuevoServicio.esquema_destino    := 'ADM_PERSON';
    rcNuevoServicio.servicio_destino   := 'API_ADDORDERCOMMENT';
    rcNuevoServicio.descripcion_destino:= 'Api genérico personalizado para el registro de comentarios.';
    rcNuevoServicio.observacion        := 'Como tipo de comentario para este reemplazo se envía el que está en el parámetro TIPO_COMENT_ORD_ENTR.'||
                                         ' DALD_Parameter.fnuGetNumeric_Value('||chr(39)||'TIPO_COMENT_ORD_ENTR'||chr(39)||');';
    insert into homologacion_servicios values rcNuevoServicio;
    dbms_output.put_line('Creado servicio de homologación para: OPEN.LD_BOFLOWFNBPACK.COMMENTDELORDER nuevo servcio: ADM_PERSON.API_ADDORDERCOMMENT');
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