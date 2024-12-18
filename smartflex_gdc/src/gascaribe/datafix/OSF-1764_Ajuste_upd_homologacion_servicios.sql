set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25
DEFINE CASO=OSF-1764

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
CASO:           OSF-1764
DESCRIPCIÓN:
Actualizacón nombre de servicios origen de los DAO, el nombre actual es
FSBCAMPO o FNUCAMPO, se actualiza por el nombre correcto que debe ser:
FSBGETCAMPO o FNUCAMPO. 

Archivo de entrada:

Archivo de Salida:

***********************************************************/

rcNuevoServicio     homologacion_servicios%ROWTYPE;
sbIdCaso            VARCHAR2(10) := 'OSF-1764';
nuIdAjuste          number;
sbSentencia         VARCHAR2(4000);
csbNueLinea         CONSTANT VARCHAR2(1) := chr(10);
csbComilla          CONSTANT VARCHAR2(1) := chr(39);
begin    
  --actualización casos puntuales: 
  dbms_output.put_line('Actualizaciones puntuales'); 
   
   begin  
      rcNuevoServicio.esquema_origen     := 'OPEN';
      rcNuevoServicio.servicio_origen    := 'DAPR_PRODUCT.FNUGETCATEGORY_ID';
      rcNuevoServicio.descripcion_origen := 'Obtiene Código Categoría para el producto.';
      rcNuevoServicio.esquema_destino    := 'ADM_PERSON';
      rcNuevoServicio.servicio_destino   := 'PKG_BCPRODUCTO.FNUCATEGORIA';
      rcNuevoServicio.descripcion_destino:= 'Retorna Id Categoría del producto.';
      rcNuevoServicio.observacion        := null;

      insert into homologacion_servicios values rcNuevoServicio;
      dbms_output.put_line('Creado servicio de homologación para: OPEN.DAPR_PRODUCT.FNUCATEGORIA nuevo servcio: ADM_PERSON.PKG_BCPRODUCTO.FNUCATEGORIA');
       commit;

   exception
       when others then
           dbms_output.put_line('Error Insetando:DAPR_PRODUCT.FNUCATEGORIA');
           dbms_output.put_line('Error:'||sqlcode||'-'||sqlerrm);
           rollback;
  end;  



  begin
          
      rcNuevoServicio.esquema_origen     := 'OPEN';
      rcNuevoServicio.servicio_origen    := 'DAPR_PRODUCT.FNUGETSUBCATEGORY_ID';
      rcNuevoServicio.descripcion_origen := 'Obtiene Código subategoría para el producto.';
      rcNuevoServicio.esquema_destino    := 'ADM_PERSON';
      rcNuevoServicio.servicio_destino   := 'PKG_BCPRODUCTO.FNUSUBCATEGORIA';
      rcNuevoServicio.descripcion_destino:= 'Retorna Id Subcategoría del producto.';
      rcNuevoServicio.observacion        := null;
      insert into homologacion_servicios values rcNuevoServicio;
      dbms_output.put_line('Creado servicio de homologación para: OPEN.DAPR_PRODUCT.FNUGETSUBCATEGORY_ID nuevo servcio: ADM_PERSON.PKG_BCPRODUCTO.FNUCATEGORIA');
      commit;

  exception
    when others then
         dbms_output.put_line('Error actualizando:DAPR_PRODUCT.FNUGETSUBCATEGORY_ID');
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