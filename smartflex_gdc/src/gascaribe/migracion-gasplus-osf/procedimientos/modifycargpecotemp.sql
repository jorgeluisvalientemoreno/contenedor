CREATE OR REPLACE procedure modifycargpecotemp(inubasedato number)
as
cursor cucuencobr
is
select rowid, substr(cargdoso, instr(cargdoso, '-',-1,1) + 1) cuenta,substr(cargdoso,1, instr(cargdoso, '-',-1,1)) rest from ldc_temp_cargos_sge where cargdoso like '%CO%AJCC%' and basedato=inubasedato;

begin

     for r in cucuencobr
      loop 
       update ldc_temp_cargos_sge set cargdoso=r.rest||to_char(to_number(r.cuenta)+to_number(decode(inubasedato,2,1000000000,3,2000000000))) where rowid=r.rowid; 
       commit;
      end loop;  

end; 
/
