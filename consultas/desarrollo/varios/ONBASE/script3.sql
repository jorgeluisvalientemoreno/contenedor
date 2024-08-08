declare
cursor cuVolumen is 
with base as(
select distinct volumen
from uselserv.tmp_cuba_afectados c
where c.disk_num='104'
and c.itemnum is null
order by volumen
)
,base2 as(
select base.volumen ,rownum fila
from base)
select *
from base2
where mod(fila,10) + 1 = 1;

cursor cuitemdata(vol varchar) is
 select i.ITEMNUM , i.filepath
from itemdatapage i
where i.diskgroupnum =104
and (i.filepath like '\'||vol||'\%')
 order by filepath;
 
 cursor cudata(Vol varchar2, car varchar2) is
   select c.rowid, c.* --(select i.ITEMNUM from prueba i where  i.filepath like '%\'||c.volumen||'\'||c.subcarpeta||'\'||c.archivo||'%')
from uselserv.tmp_cuba_afectados c
where c.disk_num='104'
and c.itemnum is null
and c.volumen=Vol
and c.subcarpeta=car
; 
 
nuCanti number;
sbArchivo varchar2(100);
sbVolumen varchar2(100);
sbCarpeta  varchar2(100);
begin
    for reg in cuVolumen loop
       dbms_output.put_line(reg.volumen);
       for reg2 in cuitemdata(reg.volumen) loop
         sbVolumen:=substr(reg2.filepath,2, instr(reg2.filepath,'\',1,2)-2);
         sbCarpeta:=substr(reg2.filepath, instr(reg2.filepath,'\',1,2)+1, instr(reg2.filepath,'\',1,3) -(instr(reg2.filepath,'\',1,2)+1));
         for reg3 in cudata(sbVolumen, sbCarpeta) loop
           sbArchivo :='\'||reg3.volumen||'\'||reg3.subcarpeta||'\'||reg3.archivo;
            if reg2.filepath like '%'||sbArchivo||'%' then
              update uselserv.tmp_cuba_afectados c set c.ITEMNUM=reg2.ITEMNUM where c.rowid=reg3.rowid;
              commit;
            end if;
         end loop;
         
       end loop;     
    end loop;
end;
