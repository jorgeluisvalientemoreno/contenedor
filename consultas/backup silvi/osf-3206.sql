select *
from diferido
where difesusc = 14228991
order by difefein desc;
select *
from notas n
where notasusc = 14228991 
and notafecr >= sysdate 
order by n.notafecr desc ;
select * 
from cuencobr 
where cuconuse = 6500001 
and cucosacu>0 ;


select *
from open.diferido d
inner join servsusc s on difesusc = sesususc 
where difesape >0
and s.sesuplfa != 58
and difecoin is not null /*or difetain is not null */
and not exists ( select null
            from open.cuencobr
            where cuconuse = difenuse
            and cucosacu >0 )
and difesusc > 11111111
and rownum <= 10
order by  d.difefein desc
