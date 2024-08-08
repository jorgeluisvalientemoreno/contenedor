PL/SQL Developer Test script 3.0
33
-- Created on 10/11/2022 by JORGE VALIENTE 
declare
  -- Local variables here
  i      integer;
  result boolean;
begin
  -- Test statements here

  if open.MO_BOPACKAGES_ASSO.FBOHASACTIVEASSOPACKS(192687739) then
    -- 192687739 192687684
    dbms_output.put_line('192687739 1 - True');
  else
    dbms_output.put_line('192687739 0 - False');
  end if;

  if open.MO_BOPACKAGES_ASSO.FBOHASACTIVEASSOPACKS(192687684) then
    -- 192687739 192687684
    dbms_output.put_line(' 192687684 1 - True');
  else
    dbms_output.put_line('192687684 0 - False');
  end if;

  result := mo_bopackages_asso.fbohasactiveassopacks(inupackage_id => 192687739);

  dbms_output.put_line(sys.diutil.bool_to_int(result));

  if sys.diutil.bool_to_int(result) = 1 then
    dbms_output.put_line('1 - True');
  else
    dbms_output.put_line('0 - False');
  end if;

end;
0
0
