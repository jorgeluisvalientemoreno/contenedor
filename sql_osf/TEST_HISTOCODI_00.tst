PL/SQL Developer Test script 3.0
47
-- Created on 3/03/2023 by JORGE VALIENTE 
declare
  -- Local variables here
  i number;
  -- Test statements here
  cursor cunumeroventa is
    select to_number(trim(mp.document_key)) numerovante
      from open.mo_packages mp
     where mp.document_type_id = 1
       and mp.package_type_id = 271
     order by mp.document_key desc;

  rfcunumeroventa cunumeroventa%rowtype;

  nuvalidar     number := -1;
  nunumeroventa number := -1;

begin

  /*for rfcunumeroventa in cunumeroventa loop
  
    if nuvalidar = -1 then
      nuvalidar := rfcunumeroventa.numerovante;
    end if;
    if rfcunumeroventa.numerovante <> nuvalidar then
      dbms_output.put_line(nuvalidar);
    end if;
    nuvalidar := nuvalidar - 1;
    
  end loop;*/

  --FOR i IN 99000 .. 99999 LOOP
  FOR i IN 190001 .. 490000 LOOP
    begin
      SELECT count(nvl(h.hicdnume,0))
        into nuvalidar
        FROM open.fa_histcodi h
       WHERE h.hicdtico = 1
         AND h.hicdnume = i;         
    end;
    if nuvalidar = 0 then
      dbms_output.put_line(i);
    end if;
    
  END LOOP;

end;
0
0
