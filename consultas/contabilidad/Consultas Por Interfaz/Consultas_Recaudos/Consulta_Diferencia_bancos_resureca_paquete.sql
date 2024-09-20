-- Verifica descuadre en Interfaz
select abs(sum(valor)) valor  from (
    SELECT pagobanc banco, trunc(pagofegr) fecha, COUNT(1)cantidad, SUM(pagovapa) valor, 'P' tipo
      FROM open.pagos
     WHERE trunc(pagofegr) >= '22-02-2015'
       AND trunc(pagofegr) <= '22-02-2015'
     GROUP BY pagobanc, trunc(pagofegr)
    UNION
    SELECT pagobanc banco, paanfech fecha, COUNT(1) cantidad, (SUM(pagovapa)*-1) valor, 'PE' tipo
      FROM open.rc_pagoanul a, open.pagos p
     WHERE a.paancupo = p.pagocupo
       AND paanfech >= '22-02-2015'
       AND paanfech <= '22-02-2015'
     GROUP BY pagobanc, paanfech
    UNION
    SELECT rerebanc banco, rerefegr fecha, count(1) cantidad, (sum(rerevalo)*-1) valor, 'RR' Tipo
      FROM open.resureca
     WHERE rerefegr >= '22-02-2015'
       AND rerefegr <= '22-02-2015'
     GROUP BY rerebanc, rerefegr);
