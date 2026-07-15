select cc.cosssesu, cc.cosstcon,cc.cosspefa, cc.cossnvec, cc.cosscoca, cc.cosselme, ol.obledesc as observacion_lect,
      cc.cossmecc, cc.cossflli, cc.cossdico, cc.cossidre, cc.cossfere,cc.cossfufa, cc.cosscavc
      , cc.cossfunc,cc.cosspecs,cc.cosscons,cc.cossfcco,l.leemoble
from lectelme l, conssesu cc , obselect ol
  where  cc.cossmecc != 3  
  and l.leemoble = ol.oblecodi
  and cc.cossfere >= '01/01/2021'
  and cosscoca > 0
  /*  and l.leemoble != 76*/
  and cosspefa = 97836
    and l.leempefa = cc.cosspefa 
  and cc.cosssesu = l.leemsesu 
  and cc.cosssesu = 1021255; 
  
  
  
  Select cc.cosssesu, cc.cosstcon,cc.cosspefa, cc.cossnvec, cc.cosscoca, cc.cosselme,
      cc.cossmecc,l.leemoble, cc.cossflli, cc.cossdico, cc.cossidre, cc.cossfere,cc.cossfufa, cc.cosscavc,
       cc.cossfunc,cc.cosspecs,cc.cosscons,cc.cossfcco
 From lectelme l, conssesu cc 
  where  l.leempefa = cc.cosspefa 
  And cc.cossfere >= '01/01/2021'
  And cosscoca > 0 
  And cosspefa = 99979
   AND cc.cosssesu =52074048
     And cc.cosssesu = l.leemsesu
     order by cossfere desc ; 
       
  SELECT COUNT(cc.cossmecc)
  FROM conssesu cc 
  WHERE  cc.cosssesu = 52074048
  And cosspefa = 99979
  AND cc.cossmecc = 3;
 
select * from conssesu cc
  WHERE  cc.cosssesu = 52074048
  
   select ol.obledesc , l.leemoble
   from  obselect ol
   inner join lectelme l on l.leemoble = ol.oblecodi
    where l.leemoble = 76
    group by (ol.obledesc , l.leemoble);
  

