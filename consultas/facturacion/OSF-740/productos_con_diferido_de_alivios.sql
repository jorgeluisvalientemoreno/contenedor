select diferido.difesusc,
       diferido.difenuse,
       servsusc.sesuserv , 
       servsusc.sesucicl, 
       diferido.difecodi , 
       diferido.difeconc , 
       diferido.difesape , 
       diferido.difefein, 
       diferido.difefumo , 
       diferido.difepldi || ' ' || plandife.pldidesc plan_dife
from open.diferido
left join open.servsusc on servsusc.sesunuse = diferido.difenuse and servsusc.sesususc = diferido.difesusc 
left join open.plandife on diferido.difepldi = plandife.pldicodi 
where diferido.difesape > 0
and servsusc.sesucicl in (1220) 
and diferido.difepldi in (110,111,112) 
and rownum < 20