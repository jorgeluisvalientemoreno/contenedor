select *
from ld_parameter
where parameter_id='COD_EXT_MEZ_NET_LDCGFV';

select *
from ed_confexme
where coemcodi=95;


 SELECT *
FROM ed_franform f, ed_bloqfran b, ed_bloque bl, ed_fuendato fd
WHERE f.frfoform = 43
 AND f.frfocodi = b.blfrfrfo
  AND b.blfrbloq = bl.bloqcodi
  AND fd.fudacodi = bl.bloqfuda;
  
  
select *
from ed_confexme

--ese es el bloque
--padi es la plantilla
select *
from OPEN.ED_BLOQUE;
select *
from OPEN.ED_PLANTILL;