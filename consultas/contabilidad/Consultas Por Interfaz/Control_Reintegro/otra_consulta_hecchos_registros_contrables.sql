-- Consulta_hechos_registros_control_reintegro
SELECT a.movitimo TipoMovi,
       (select m.timodesc from open.ic_tipomovi m where m.timocodi = a.movitimo) DesTipoMovi,
       a.MOVIFECO FechaContabilizacion,
       a.MOVIBACO EntidadConciliacion,
       d.bancnomb Desc_Entidad,
       sum(a.MOVIVALO*-1) Valor,
       'HE' TIPO
  FROM open.ic_movimien a, open.banco d, open.tipoenre f, open.cuenbanc e, open.ic_tipomovi g
 WHERE MOVITIDO = 74
   AND MOVITIMO IN (38, 65)
   AND a.MOVIFECO >= '&FECHA_INICIAL'
   AND a.MOVIFECO <= '&FECHA_FINAL'
   AND a.MOVIBACO = d.banccodi
   AND d.banctier = 2
   AND a.movitibr = f.tiercodi
   AND a.movicuba = e.cubacodi
   AND g.timocodi = a.movitimo
group by a.movitimo, a.MOVIFECO, a.MOVIBACO, d.bancnomb, 'HE'
union all
SELECT a.movitimo TipoMovi,
       (select m.timodesc from open.ic_tipomovi m where m.timocodi = a.movitimo) DesTipoMovi,
       a.MOVIFECO FechaContabilizacion,
       a.MOVIBACO EntidadConciliacion,
       d.bancnomb Desc_Entidad,
       sum(a.MOVIVALO*-1) Valor,
       'CO' TIPO
  FROM open.ic_movimien a, open.banco d, open.ic_tipomovi g
 WHERE MOVITIDO = 74
   AND MOVITIMO = (22)
   AND a.MOVIFECO >= '&FECHA_INICIAL'
   AND a.MOVIFECO <= '&FECHA_FINAL'
   AND a.MOVIBACO = d.banccodi
   AND g.timocodi = a.movitimo
   and a.movitdsr = 16
group by a.movitimo, a.MOVIFECO, a.MOVIBACO, d.bancnomb, 'CO'
