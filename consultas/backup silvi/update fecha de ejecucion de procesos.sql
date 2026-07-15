select pj.prejcope, pefacicl, pefaano, pefames
  from procejec pj, perifact pf
 where pj.prejcope = pefacodi
   and trunc(pj.prejfech) = trunc(SYSDATE-1)
      and pj.prejprog = 'FGCC'
      
      
      
      select prejcope ,prejfech 
      from procejec pj
      where pj.prejprog = 'FGCC'
      and pj.prejcope = 101659 
      for update 
