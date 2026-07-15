-- Validar_diferidos_creados
select difecodi "Codigo de diferido",
       difesusc "Contrato",
       difenuse "Producto",
       sesuserv "Tipo de producto",
       difeconc || ' ' ||initcap (c.concdesc)  "Concepto",
       difevatd "Valor_total_dif",
       difenucu "Cuotas",
       difefein "Fecha ingreso dif",difefumo "Fecha ult mov dif",
       difeprog "Programa" , 
      d.difepldi || '-  ' || initcap(pd.pldidesc)  "Plan_diferido"
from open.diferido d
left join open.plandife  pd on d.difepldi = pd.pldicodi
left join open.concepto  c on c.conccodi = d.difeconc
left join servsusc on sesunuse = difenuse and sesususc = difesusc 
where difesusc in (1000895)
 and difefein >= '02/05/2025'
group by difecodi,difesusc,difenuse ,sesuserv , difeconc, c.concdesc,difesape,difevatd ,difenucu, difefein, difeprog ,difepldi ,pd.pldidesc,difefumo
order by difefein asc 
