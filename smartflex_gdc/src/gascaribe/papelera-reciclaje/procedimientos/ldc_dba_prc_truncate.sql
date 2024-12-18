CREATE OR REPLACE procedure ldc_dba_prc_truncate(v_owner varchar, v_objeto varchar ) is
/**************************************************************************************
 .   Autor           :  Carlos H Giraldo Z  | DBA SETI S.A.S                          .
 .   Descripción     :  Procedimiento para truncar tablas, manejando excepcion para   .
 .                      evitar que realice calculo de estadisticas si el              .
 .                      TRUNCATE FALLA                                                .
 .   Notas           :                                                                .
 .                                                                                    .
 .   Variables       :  Recibe como variables el OWNER y el OBJECT_NAME                                                              .
 .                                                                                    .
 .                                                                                    .
 **************************************************************************************
 .   Modificaciones  :                                                                .
 .                                                                                    .
 .                                                                                    .
 .                                                                                    .
 **************************************************************************************
 .   Quien             Cuando            Que                                          .
 .                                                                                    .
 .                                                                                    .
 .                                                                                    .
 **************************************************************************************
 .   Revision Historica                                                               .
 .   Version 1.0                                                                      .
 **************************************************************************************/
str0 varchar2(400);
str1 varchar2(400);
 f_Handle        Utl_File.File_Type;
 tmp_file        varchar2(50);
 v_file_name     varchar2(200);
begin
-- Documentado session
   dbms_application_info.set_module(module_name => 'TRUNCA TABLAS', action_name => 'TRUNCANDO TABLA');
   dbms_application_info.set_client_info('DBA');
-- Variables - Incio TRACE
   tmp_file :='trace'||'_'||v_objeto||'.trc';
   f_Handle := Utl_File.FOpen( 'LDC_DBA_DIR_TRUNCATE' , tmp_file, 'a' );
-- Inicio proceso TRUNCATE
   v_file_name:=to_char(sysdate,'yyyymmddhhmmss')||' - '||'Objeto '||v_objeto||' Inicia TRUNCADO ...';
   Utl_File.put_Line( f_Handle, v_file_name);
   v_file_name:='';
   str0:='truncate table '||v_owner||'.'||v_objeto||' DROP STORAGE';
   execute immediate str0;
   v_file_name:=to_char(sysdate,'yyyymmddhhmmss')||' - '||'Objeto '||v_objeto||' Finaliza TRUNCADO ...';
   Utl_File.put_Line( f_Handle, v_file_name);
   v_file_name:='';
-- Inicio procedo DBMS_STATS
   v_file_name:=to_char(sysdate,'yyyymmddhhmmss')||' - '||'Objeto '||v_objeto||' Inicia DBMS_STATS ...';
   Utl_File.put_Line( f_Handle, v_file_name);
   v_file_name:='';
   str1:='BEGIN dbms_stats.gather_table_stats(ownname => '||''''||v_owner||''''||','||'tabname => '||''''||v_objeto||''''||',cascade => true, estimate_percent => 100, degree=>2); END;';
   execute immediate str1;
   v_file_name:=to_char(sysdate,'yyyymmddhhmmss')||' - '||'Objeto '||v_objeto||' Finaliza DBMS_STATS ...';
   Utl_File.put_Line( f_Handle, v_file_name);
   v_file_name:=''; 
-- Cerrar archivo TRACE
   UTL_FILE.Fclose(f_Handle);
EXCEPTION
 WHEN OTHERS THEN
   v_file_name:=to_char(sysdate,'yyyymmddhhmmss')||' - '||'Objeto '||v_objeto||' ERROR TRUNCADO ...';
   Utl_File.put_Line( f_Handle, v_file_name);
   UTL_FILE.Fclose(f_Handle);
end;
/
GRANT EXECUTE on LDC_DBA_PRC_TRUNCATE to SYSTEM_OBJ_PRIVS_ROLE;
/
