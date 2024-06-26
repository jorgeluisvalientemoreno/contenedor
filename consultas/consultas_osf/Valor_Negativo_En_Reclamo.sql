select a.*, rowid from open.servsusc a where a.sesunuse = 51116865;
select a.*, rowid
  from open.cuencobr a
 where a.cuconuse = 51116865
   and a.cucovare <> 0
 order by a.cucofeve desc;
select * from open.cargtram a where a.catrnuse = 51116865; -- and a.catrvalo = 2857;
select *
  from open.LDC_LIQSINIBRIdet A
 WHERE A.ANO = 2022
   AND A.MES IN (7, 8, 9, 10)
   AND VALOR_FAC IN (select ABS(a.cucovare)
                       from open.cuencobr a
                      where a.cuconuse = 51116865
                        and a.cucovare <> 0)
