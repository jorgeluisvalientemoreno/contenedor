PL/SQL Developer Test script 3.0
24
-- Created on 3/03/2023 by JORGE VALIENTE 
declare

  RCHISTCODI open.FA_HISTCODI%ROWTYPE;
  CURSOR CUCONS IS
    SELECT --+ index_desc (fa_histcodi IX_FA_HISTCODI01)
     *
      FROM open.fa_histcodi h
     WHERE h.hicdtico = 1
       AND h.hicdnume = 465099;
BEGIN
  
  
  IF CUCONS%ISOPEN THEN
    CLOSE CUCONS;
  END IF;
  OPEN CUCONS;
  FETCH CUCONS
    INTO RCHISTCODI;
  CLOSE CUCONS;

  dbms_output.put_line(RCHISTCODI.hicdesta);

end;
0
0
