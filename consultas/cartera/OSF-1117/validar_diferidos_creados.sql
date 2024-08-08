select difecodi "Codigo de diferido",
       difesusc "Contrato",
       difenuse "Producto",
       sesuserv "Tipo de producto",
       difeconc || ' ' ||INITCAP (c.concdesc)  "Concepto", 
       difesape "Saldo pendiente",
       difevatd "Valor_total_dif",
       difefein "Fecha ingreso dif",difefumo "Fecha ult mov dif",
       difeprog "Programa" , 
      d.difepldi || '-  ' || INITCAP(pd.pldidesc)  "Plan_diferido"
from open.diferido d
left join open.plandife  pd on d.difepldi = pd.pldicodi
left join open.concepto  c on c.conccodi = d.difeconc
left join servsusc on sesunuse = difenuse and sesususc = difesusc 
where difesusc in (14218407)/* and difesape >0*/ and difefein >'11/07/2023'
group by difecodi,difesusc,difenuse ,sesuserv , difeconc, c.concdesc,difesape,difevatd ,difefein, difeprog ,difepldi ,pd.pldidesc,difefumo
order by difefein asc 
