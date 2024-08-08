declare
cursor cuVolumen is 
with base as(
select distinct c.disk_num, volumen
from uselserv.tmp_cuba_afectados_sin_cuba c
where c.disk_num='104'
and c.itemnum is null
order by volumen
)
,base2 as(
select base.disk_num, base.volumen ,rownum fila
from base)
select *
from base2
;

cursor cuitemdata(vol varchar, discok varchar) is
with base as(
 select i.ITEMNUM , i.filepath, 
 substr(i.filepath,2, instr(i.filepath,'\',1,2)-2) volumen, 
 substr(i.filepath, instr(i.filepath,'\',1,2)+1, instr(i.filepath,'\',1,3) -(instr(i.filepath,'\',1,2)+1)) carpeta,
 trim(substr(i.filepath, instr(i.filepath,'\',1,3)+1))  archivo
from itemdatapage i
where i.diskgroupnum =discok
and (i.filepath like '\'||vol||'\%')
 order by filepath)
select base.*,
       (select a.rowid from uselserv.tmp_cuba_afectados_sin_cuba a where a.disk_num=discok and a.volumen=base.volumen and a.subcarpeta=base.carpeta and base.archivo = a.archivo  and a.itemnum is null and rownum=1) registro
from base;
 
 
nuCanti number;
sbArchivo varchar2(100);
sbVolumen varchar2(100);
sbCarpeta  varchar2(100);
begin
    for reg in cuVolumen loop
       dbms_output.put_line(reg.volumen);
       for reg2 in cuitemdata(reg.volumen, reg.disk_num) loop
          if reg2.registro is not null then
            update uselserv.tmp_cuba_afectados_sin_cuba a set a.itemnum=reg2.itemnum where a.rowid=reg2.registro;
            commit;
          end if;
       end loop;     
    end loop;
end;
