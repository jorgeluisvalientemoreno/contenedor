select cargcuco , cargnuse , cargconc,cargcaca , co.concdesc, co.concticl , cargsign , cargpefa, cargvalo,cargvabl , cargdoso, cargcodo, cargusua, cargtipr, cargfecr , cargprog
from open.cuencobr br
inner join open.cargos c on cargcuco = cucocodi
left join open.concepto co on conccodi= cargconc
where  cargnuse = 14518626 and cargfecr >= trunc(sysdate)
order by cargfecr desc;