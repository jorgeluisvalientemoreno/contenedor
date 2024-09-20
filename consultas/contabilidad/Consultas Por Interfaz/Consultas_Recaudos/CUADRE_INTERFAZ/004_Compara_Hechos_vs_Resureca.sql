-- 003 Compara Hechos vs RESURECA
SELECT movibanc banco, movifeco fecha, 
       clasificador, (SELECT clcodesc FROM open.ic_clascont WHERE clcocodi = clasificador) desc_clas,
       sum(decode(movisign, 'C', movivalo*-1, movivalo)) valor, 'HE' tipo 
  FROM (
        SELECT movibanc, movifeco, (SELECT concclco FROM open.concepto WHERE conccodi = moviconc) clasificador,
               movisign, movivalo
          FROM open.ic_movimien 
         WHERE movitido = 72
           AND movifeco >= '&FECHA_INICIAL'
           AND movifeco <= '&FECHA_FINAL'
           AND moviconc IS NOT NULL
)
GROUP BY movibanc, movifeco, clasificador
UNION
SELECT rerebanc banco, rerefegr fecha, 
       clasificador, 
       (SELECT clcodesc FROM open.ic_clascont WHERE clcocodi = clasificador) desc_clas,
       (sum(rerevalo)*-1) valor, 'RR' Tipo
  FROM (SELECT rerebanc, rerefegr, rereconc, (SELECT concclco FROM open.concepto WHERE conccodi = rereconc) clasificador, rerevalo
          FROM open.resureca 
         WHERE rerefegr >= '&FECHA_INICIAL'
           AND rerefegr <= '&FECHA_FINAL')
GROUP BY rerebanc, rerefegr, clasificador;
