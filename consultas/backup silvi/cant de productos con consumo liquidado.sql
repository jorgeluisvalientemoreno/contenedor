with consumos as
   (select cosspefa, cosssesu, sum(nvl(cosscoca,0)) cosscoca
  from conssesu, servsusc
 where cosspefa= 102219
   and cossflli='S'
   and sesunuse = cosssesu
   and sesuesfn <> 'C'
group by cosssesu, cosspefa),
 lectperi as (
 select min(p2.pecsfecf) lectperio
  from perifact p1, pericose p2
 where p2.pecsfecf between p1.pefafimo and p1.pefaffmo
   and p1.pefacicl = p2.pecscico
   and p1.pefacodi = 102219),
   datos_generales as (
   select consumos.*, nvl(e.leemfele, (select lectperio from lectperi)) fecha
  from  consumos
     left join lectelme e on leemsesu = cosssesu
   and leempefa= 102219
   and e.leemclec in ('I','F')
   and NVL(LEEMOBLE,-1) IN (-1,76))
   select COSSPEFA, COSSSESU, COSSCOCA,EXTRACT(YEAR FROM FECHA) anio, EXTRACT( MONTH  FROM FECHA) mes,   FECHA
   from datos_generales;
   
  /* SELECT *
   FROM VW_CMPRODCONSUMPTIONS
   JOIN SERVSUSC ON sesunuse = cosssesu
   WHERE cosspefa = 102219
   AND COSSMECC =3 
   AND cosspecs = 102194
   */
