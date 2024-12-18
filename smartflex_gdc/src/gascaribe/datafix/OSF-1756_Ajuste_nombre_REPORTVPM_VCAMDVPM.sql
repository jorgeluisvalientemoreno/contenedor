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
FECHA:          11/10/2023
CASO:           OSF-1756
DESCRIPCIÓN:
SDADADSA

Archivo de entrada:

Archivo de Salida:

***********************************************************/

    sbdescripcion     SA_EXECUTABLE.name%type;
begin
    

  for rcexec in (SELECT EXECUTABLE_ID, NAME, DESCRIPTION
                  FROM SA_EXECUTABLE
                   where name in ('REPORTVPM', 'VCAMDVPM'))
  loop                 
  begin
        sbdescripcion:= 'NO USAR - '||rcexec.description;
        update sa_executable e
           set e.description = sbdescripcion
         where e.executable_id = rcexec.executable_id;
         dbms_output.put_line('Modificada opción:'||rcexec.name||' nuevo nombre:'||sbdescripcion);
         commit;
         
  exception
      when others then         
         dbms_output.put_line('Error actualizando:'||rcexec.name);
         dbms_output.put_line('Error:'||sqlcode||'-'||sqlerrm);
         rollback;
  end;       
  end loop;      


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