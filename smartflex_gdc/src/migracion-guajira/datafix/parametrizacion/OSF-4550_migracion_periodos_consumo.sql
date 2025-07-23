column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  execute immediate 'alter trigger trgbiurPericose disable';
  
  insert into pericose 
  select pefacodi as PECSCONS, p.pefafimo as PECSFECI, p.pefaffmo as PECSFECF, 'S' as PECSPROC,
        'MIGRAGG' PECSUSER,
        'MIGRAGG' as PECSTERM,
        'MIGRAGG' AS MIGARCION,
        p.pefacicl as PECSCICO,
        'S' as PECSFLAV,
        p.pefafimo as PECSFEAI, 
        p.pefaffmo as PECSFEAF
  from open.perifact p
  where exists(select null from homologacion.homociclo h where h.ciclhomo =pefacicl)
  order by pefaano, pefames, pefacicl;

 execute immediate 'alter trigger trgbiurPericose enable';

 dbms_output.put_line('PROCESO TERMINO OK');
   
exception  
  when others then
       rollback;
       dbms_output.put_line(sqlerrm);
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/