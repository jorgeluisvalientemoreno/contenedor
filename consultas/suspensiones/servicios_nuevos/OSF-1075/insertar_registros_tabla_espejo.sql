insert into ldc_susp_autoreco_pl  (sarecodi,
       saresesu,
       saresape,
       sarecons,
       sareacti,
       sarepeva,
       sareaure,
       sarefege,
       sareuser,
       sarefepr,
       sarecicl,
       sareorde,
       sareacor,
       saredepa,
       sareloca,
       saresect,
       sareclie,
       sarecont,
       sareespr,
       saredire,
       sarecate,
       sareleac,
       sarelean,
       sarelesu,
       sarefesu,
       sarettsu,
       sareorsu,
       saremarc,
       saremult,
       sareplma,
       sareproc)
       select sarecodi,
       saresesu,
       saresape,
       sarecons,
       sareacti,
       sarepeva,
       sareaure,
       sarefege,
       sareuser,
       sarefepr,
       sarecicl,
       sareorde,
       sareacor,
       saredepa,
       sareloca,
       saresect,
       sareclie,
       sarecont,
       sareespr,
       saredire,
       sarecate,
       sareleac,
       sarelean,
       sarelesu,
       sarefesu,
       sarettsu,
       sareorsu,
       saremarc,
       saremult,
       sareplma,
       sareproc
   from LDC_SUSP_AUTORECO
   where sareproc = 7
   where sareproc = 7


