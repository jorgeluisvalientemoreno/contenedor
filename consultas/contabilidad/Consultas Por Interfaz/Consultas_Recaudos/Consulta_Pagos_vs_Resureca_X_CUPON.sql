-- Pagos vs Pagos Eliminados vs Resumen de Recaudo por día por entidad
select banco, cupon, fecha, sum(valor) total
  from (
        -- Consulta de Pagos del dia
        SELECT pagobanc banco, pagocupo cupon, trunc(pagofegr) fecha, SUM(pagovapa) valor, 'P' tipo
          FROM open.pagos p
         WHERE trunc(pagofegr) >= '&FECHA_INICIAL' and trunc(pagofegr) <= '&FECHA_FINAL 23:59:59' --and pagobanc = 603
        GROUP BY pagobanc, trunc(pagofegr), pagocupo
        UNION 
        -- Anulaciones de pagos del dia
        SELECT pagobanc banco, pagocupo cupon, paanfech fecha, (SUM(pagovapa)*-1) valor, 'PE' tipo --and pagobanc = 603
          FROM open.rc_pagoanul a, open.pagos p
         WHERE a.paancupo = p.pagocupo
           AND paanfech >= '&FECHA_INICIAL' and paanfech <= '&FECHA_FINAL 23:59:59'
        GROUP BY pagobanc, paanfech, pagocupo
        UNION 
        -- Detalle por concepto por cupon.
        SELECT rerebanc banco, r.rerecupo cupon,  rerefegr fecha, sum((rerevalo)*-1) valor, 'RR' Tipo
          FROM open.resureca r
         WHERE rerefegr >= '&FECHA_INICIAL' and rerefegr <= '&FECHA_FINAL 23:59:59' 
        GROUP BY rerebanc, rerefegr, r.rerecupo
       )
group by banco, cupon, fecha
having sum(valor) != 0
