SELECT *
  FROM open.LDC_VISTA_LDCRCDI2 a
 where a.codigo_unidad_operativa = 3624
   and a.estado_orden in (5, 6, 7)
   and nvl(a.costo_estimado, 0) > 0
