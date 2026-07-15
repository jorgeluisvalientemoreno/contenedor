  SELECT *
   FROM VW_CMPRODCONSUMPTIONS
   JOIN SERVSUSC ON sesunuse = cosssesu
   WHERE cosspefa = 102219
 --  AND COSSMECC =3 
   AND cosspecs = 102194
   
