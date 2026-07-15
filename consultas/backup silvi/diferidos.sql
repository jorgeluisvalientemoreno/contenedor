select difecodi "Codigo de diferido",
       grace_peri_defe_id "Id_periodo_grac", 
       difesusc "Contrato",
       difenuse "Producto",
       sesuserv "Tipo de producto",
       difeconc || ' ' ||INITCAP (c.concdesc)  "Concepto", 
       difesape "Saldo pendiente",
       difevatd "Valor_total_dif",
       difefein "Fecha ingreso dif",difefumo "Fecha ult mov dif",
       gp.grace_period_id  || '-  ' || INITCAP(pc.description)  "Periodo_Gracia", 
       gp.initial_date  "Inicio_P_Gracia", 
       gp.end_date  "Fin_P_Gracia",
       difeprog "Programa" , 
      d.difepldi || '-  ' || INITCAP(pd.pldidesc)  "Plan_diferido"
from open.diferido d
left join open.cc_grace_peri_defe  gp on gp.deferred_id = d.difecodi
left join open.plandife  pd on d.difepldi = pd.pldicodi
left join open.concepto  c on c.conccodi = d.difeconc
left join open.cc_grace_period  pc on pc.grace_period_id = gp.grace_period_id
left join servsusc on sesunuse = difenuse and sesususc = difesusc 
where difesusc in (1000016) and difesape >0 
--and gp.end_date > sysdate
and gp.end_date  = ( select max (gp2.end_date ) from cc_grace_peri_defe gp2 where  gp2.deferred_id = d.difecodi)
group by difecodi,difesusc,difenuse ,sesuserv , difeconc, c.concdesc,difesape,difevatd ,difefein,gp.grace_period_id, pc.description, 
       gp.initial_date, gp.end_date , difeprog ,difepldi ,pd.pldidesc,grace_peri_defe_id,difefumo
order by difefein asc 


--and difepldi in (110,111)
--and difenuse = 17144911

--and difefein < '07/07/2021'

--17144911
--and cargpefa= 99966
--and cargcuco =3017705636
--and difeconc in (203,159)
--and difefein  < '01/01/2020'



--and difeprog in ( 'GCNED')
-- AND SESUSERV = 7014 ;

--SUBSTR(CARGDOSO, 4, 20)
 --AND DIFEFEIN > TO_DATE('01/01/2020')
-- AND SESUNUSE = DIFENUSE 
 -- and difenuse =  6585820
 
 /*select *
 from diferido
 where difesape > 0 
and difesusc in (48000651) 
order by difeinte asc 
 for update 
*/
