declare
 cursor cuBase is
 select i.ITEMNUM , i.filepath
from itemdatapage i
where i.diskgroupnum =103
and (i.filepath like '\V149%' or
 i.filepath like '\V150%' or 
 i.filepath like '\V151%' or
 i.filepath like '\V152%' or
 i.filepath like '\V153%' or 
 i.filepath like '\V154%')
 order by filepath;
 cursor cuBase2(Vol varchar2, car varchar2) is
   select c.rowid, c.* --(select i.ITEMNUM from prueba i where  i.filepath like '%\'||c.volumen||'\'||c.subcarpeta||'\'||c.archivo||'%')
from uselserv.tmp_cuba_afectados c
where c.disk_num='103'
and c.itemnum is null
and c.volumen=Vol
and c.subcarpeta=car
;
sbArchivo varchar2(100);
sbVolumen varchar2(100);
sbCarpeta  varchar2(100);

begin
  for reg in cubase loop
    sbVolumen:=substr(reg.filepath,2, instr(reg.filepath,'\',1,2)-2);
    sbCarpeta:=substr(reg.filepath, instr(reg.filepath,'\',1,2)+1, instr(reg.filepath,'\',1,3) -(instr(reg.filepath,'\',1,2)+1));
    for reg2 in cubase2(sbVolumen, sbCarpeta) loop
      sbArchivo :='\'||reg2.volumen||'\'||reg2.subcarpeta||'\'||reg2.archivo;
      if reg.filepath like '%'||sbArchivo||'%' then
        update uselserv.tmp_cuba_afectados c set c.ITEMNUM=reg.ITEMNUM where c.rowid=reg2.rowid;
        commit;
      end if;
    end loop;
    dbms_output.put_line(reg.filepath);
  end loop; 
end;
/ 
