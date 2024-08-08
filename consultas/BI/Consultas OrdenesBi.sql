SELECt  FORMAT(  ot.FechaLegalizacion, 'MM') MES , SUM(OI.Valor)
FROM Comun.FactOrden ot
Inner Join Comun.FactItemOrden Oi on oi.IdOrden =ot.IdOrden 
Inner join Comun.DimItem i on i.IdiTEM=oi.IdItem and i.IdClasificacionItem in (3,8,21) AND I.Valido=1
where ot.FechaLegalizacion>= CONVERT(DATETIME, '2022-01-01', 102) 
  and ot.FechaLegalizacion<CONVERT(DATETIME, '2023-01-01', 102) 
  and ot.IdTipoTrabajo!=0
  GROUP BY FORMAT(  ot.FechaLegalizacion,'MM') ;

