  select lm.leemleto, 
         lm.leemfele,
         leemtcon, 
         leemclec 
  from open.lectelme lm
  where lm.leemsesu = 52294404
  order by lm.leemfele desc
   