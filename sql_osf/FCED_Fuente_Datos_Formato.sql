SELECT ed_confexme.*, ed_bloque.*, ed_fuendato.fudasERV, ed_franform.FRFOFORM
  FROM ed_bloqfran, ed_franform, ed_bloque, ed_fuendato, ed_confexme
 where 1 = 1
   and ed_bloqfran.blfrfrfo = ed_franform.frfocodi
   AND ed_bloque.bloqcodi = ed_bloqfran.blfrbloq
   AND ed_fuendato.fudacodi = ed_bloque.BLOQFUDA
   AND ed_franform.FRFOFORM = 244 --formato
   and ed_confexme.coempada(+) = '<' || ed_franform.FRFOFORM || '>'
--244 estado de cuenta
--104 spool
