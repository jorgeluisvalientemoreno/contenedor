--validacion_ciclo
select ciclcodi,
       cicldesc,
       pc.pecscons,
       pc.pecsfeci,
       pc.pecsfecf,
       pf.pefacodi,
       pf.pefafimo,
       pf.pefaffmo,
       pf.pefaactu
  from open.ciclo
  left join open.pericose pc
    on pc.pecscico = ciclcodi
   and sysdate between pc.pecsfeci and pc.pecsfecf
  left join open.perifact pf
    on pf.pefacicl = ciclcodi
   and sysdate between pf.pefafimo and pf.pefaffmo
 where ciclcodi in (1501)
