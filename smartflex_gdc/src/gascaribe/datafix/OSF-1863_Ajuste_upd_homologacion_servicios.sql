set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25
DEFINE CASO=OSF-1863

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
CASO:           OSF-1863
DESCRIPCIÓN:
Inserta los registros para los métodos a homologar: LDC_PROINSERTAESTAPROGV2 y LDC_PROACTUALIZAESTAPROGV2

Archivo de entrada:

Archivo de Salida:

***********************************************************/

csbComilla          VARCHAR2(1) := chr(39);    
rcNuevoServicio     homologacion_servicios%ROWTYPE;

begin

  begin  
  --actualización casos puntuales: 
    rcNuevoServicio.esquema_origen     := 'OPEN';
    rcNuevoServicio.servicio_origen    := 'LDC_PROINSERTAESTAPROGV2';
    rcNuevoServicio.descripcion_origen := 'Inserta registro en LDC_OSF_ESTAPROC.';
    rcNuevoServicio.esquema_destino    := 'PERSONALIZACIONES';
    rcNuevoServicio.servicio_destino   := 'PKG_ESTAPROC.PRINSERTAESTAPROC';
    rcNuevoServicio.descripcion_destino:= 'INSERTA REGISTRO EN ESTAPROC.';
    rcNuevoServicio.observacion        := '-- Sugerencia de uso'||
                                          'DECLARE'||
                                          '  sbproceso  VARCHAR2(100) := nombreproceso||TO_CHAR(SYSDATE,'||csbComilla||'DDMMYYYYHH24MISS'||csbComilla||');'||
                                          '   nutotareg NUMBER;'||
                                          '   nuerror     NUMBER;'||
                                          '   sberror      VARCHAR2(4000);'||
                                          'BEGIN'||
                                          '   nutotareg  := funcionobttotalreg;'||
                                          '   pkg_estaproc.prinsertaestaproc( sbproceso , nutotareg);'||
                                          '   EXCEPTION'||
                                          '   WHEN pkg_Error.CONTROLLED_ERROR THEN'||
                                          '       pkg_Error.getError( nuerror,sberror);'||
                                          '       pkg_estaproc.practualizaestaproc( sbproceso, '||csbComilla||'Error '||csbComilla||', sberror  );'||
                                          '   WHEN OTHERS THEN'||
                                          '       pkg_error.seterror;'||
                                          '       pkg_error.geterror(nuerror, sberror  );'||
                                          '       pkg_estaproc.practualizaestaproc( sbproceso, '||csbComilla||'Error '||csbComilla||', sberror  );'||
                                          'END;';
    insert into homologacion_servicios values rcNuevoServicio;
    dbms_output.put_line('Creado servicio de homologación para: OPEN.LDC_PROINSERTAESTAPROGV2 nuevo servcio: OPEN.PKG_ESTAPROC.PRINSERTAESTAPROC');
    commit;

  exception
    when others then
         dbms_output.put_line('Error actualizando:OPEN.LDC_PROINSERTAESTAPROGV2');
         dbms_output.put_line('Error:'||sqlcode||'-'||sqlerrm);
         rollback;
  end;



  begin  

    rcNuevoServicio.esquema_origen     := 'OPEN';
    rcNuevoServicio.servicio_origen    := 'LDC_PROACTUALIZAESTAPROGV2';
    rcNuevoServicio.descripcion_origen := 'Actualiza registro en LDC_OSF_ESTAPROC.';
    rcNuevoServicio.esquema_destino    := 'PERSONALIZACIONES';
    rcNuevoServicio.servicio_destino   := 'PKG_ESTAPROC.PRACTUALIZAESTAPROC';
    rcNuevoServicio.descripcion_destino:= 'ACTUALIZA REGISTRO EN ESTAPROC.';
    rcNuevoServicio.observacion        :=	'El nombre del proceso a enviar corresponde al utilizado al registrar el proceso, '||
                                          'teniendo en cuenta que la recomendación de uso incluye la fecha de inicio incluyendo '||
                                          'minutos y segundos en el nombre del proceso a registrar';
    insert into homologacion_servicios values rcNuevoServicio;
    dbms_output.put_line('Creado servicio de homologación para: OPEN.LDC_PROINSERTAESTAPROGV2 nuevo servcio: OPEN.PKG_ESTAPROC.PRINSERTAESTAPROC');
    commit;

  exception
    when others then
         dbms_output.put_line('Error actualizando:OPEN.LDC_PROACTUALIZAESTAPROGV2');
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