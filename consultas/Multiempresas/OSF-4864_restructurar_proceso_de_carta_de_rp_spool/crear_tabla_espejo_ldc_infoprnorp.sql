CREATE TABLE ldc_infoprnorp_espejo_qh_antes AS
SELECT s.inpnsesu,
       s.inpnsusc,
       s.inpnpefa,
       s.inpnmere,
       s.inpnfere,
       s.inpnorim,
       s.inpnorec,
       s.inpninco,
       s.inpnfein
  FROM ldc_infoprnorp s
 WHERE s.inpnpefa IN (117477);
 
 
---ldc_infoprnorp_espejo_pl
-- ldc_infoprnorp_espejo_qh_antes


--inserción

INSERT INTO ldc_infoprnorp_espejo_pl (
    inpnsesu,
    inpnsusc,
    inpnpefa,
    inpnmere,
    inpnfere,
    inpnorim,
    inpnorec,
    inpninco,
    inpnfein
)
SELECT s.inpnsesu,
       s.inpnsusc,
       s.inpnpefa,
       s.inpnmere,
       s.inpnfere,
       s.inpnorim,
       s.inpnorec,
       s.inpninco,
       s.inpnfein
  FROM ldc_infoprnorp s
 WHERE s.inpnpefa IN (117477);
