column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  dbms_output.put_line('fecha de inicio '||sysdate);
  execute immediate 'alter trigger trgInsPeriFact  disable';
  insert into perifact
  with base as(
  select  pefaano,
          pefames,
          pefasaca,
          pefafimo,
          pefaffmo,
          pefafeco,
          pefafepa,
          pefaffpa,
          pefafege,
          pefaobse ||' MIGRADO DEL CICLO ' || PEFACICL pefaobse,
          h.ciclhomo,
          pefadesc,
          pefafcco,
          pefafgci,
          pefaactu,
          pefafeem
  from open.perifact_gg g
  inner join homologacion.homociclo h on h.ciclcodi = g.pefacicl
  where pefaano<=2020
    and not exists(select null from open.perifact p where p.pefacicl=h.ciclhomo and p.pefaano=g.pefaano and p.pefames = g.pefames)
  order by pefaano, pefames, pefacicl)
  select rownum pefacodi,
         base.*
  from base;
  

   insert into perifact
  with base as(
  select  pefaano,
          pefames,
          pefasaca,
          pefafimo,
          pefaffmo,
          pefafeco,
          pefafepa,
          pefaffpa,
          pefafege,
          pefaobse ||' MIGRADO DEL CICLO ' || PEFACICL pefaobse,
          h.ciclhomo,
          pefadesc,
          pefafcco,
          pefafgci,
          pefaactu,
          pefafeem
  from open.perifact_gg g
  inner join homologacion.homociclo h on h.ciclcodi = g.pefacicl
  where pefaano>2020
    and not exists(select null from open.perifact p where p.pefacicl=h.ciclhomo and p.pefaano=g.pefaano and p.pefames = g.pefames)
  order by pefaano, pefames, pefacicl)
  select SQ_PERIFACT_PEFACODI.NEXTVAL pefacodi,
         base.*
  from base;

  execute immediate 'alter trigger trgInsPeriFact  enable';
  dbms_output.put_line('PROCESO TERMINO OK');
    dbms_output.put_line('fecha fin '||sysdate);
exception  
  when others then
       execute immediate 'alter trigger trgInsPeriFact  enable';
       dbms_output.put_line(sqlerrm);
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/