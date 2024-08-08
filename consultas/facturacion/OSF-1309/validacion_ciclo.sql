select ciclcodi "Ciclo",
       cicldesc "Desc Ciclo",
       pc.pecscons "Periodo Consumo",
       pc.pecsfeci "Inicio Per. Consumo",
       trunc(pc.pecsfecf) "Fin Per. Consumo",
       pc.pecsflav  "Critica",
       pf.pefacodi "Periodo Facturacion",
       pf.pefafimo "Inicio Per. Facturacion",
       trunc(pf.pefaffmo) "Fin Per. Facturacion",
       pf.pefaactu "Actual",
       trunc(sysdate) "Sysdate"
  from open.ciclo
  left join open.perifact pf on pf.pefacicl = ciclcodi
  left join open.pericose pc on pc.pecscico = ciclcodi
   and pc.pecsfecf between pf.pefafimo and pf.pefaffmo
 where ciclcodi in (1801)
  and sysdate between pf.pefafimo and pf.pefaffmo
