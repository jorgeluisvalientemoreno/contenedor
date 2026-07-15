Select sesususc,sesunuse , sesuserv , (sum(difesape)) "saldo_pend "
left join diferido  on difenuse = sesunuse  
where (select  ( sum(br2.cucovare) - sum(br2.cucovrap))
     from servsusc s2, cuencobr br2
     where  br2.cuconuse = s2.sesunuse
     and s2.sesunuse = cargnuse 
     and br2.cucosacu > 0
     group by s2.sesunuse, s2.sesuserv) = 0 
and sesucicl = 1501
 group by sesususc,sesunuse , sesuserv 
