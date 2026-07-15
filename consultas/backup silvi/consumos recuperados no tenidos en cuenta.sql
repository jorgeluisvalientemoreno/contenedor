select cosssesu, sum(nvl(cosscoca,0)) cosscoca
  from conssesu c , servsusc
 where cosspefa=102219
   and cossflli='S'
   and sesunuse = cosssesu
   and sesuesfn <> 'C'
   and not exists (select 'S'
                   from conssesu cc
                   where cc.cosspefa= pkbillingperiodmgr.fnugetperiodprevious(102219)
                   and cc.cossflli='S'
                   and cc.cosssesu = c.cosssesu ) 
group by cosssesu;
