SELECT o.product_id producto,
       o.order_id orden,
       o.package_id solicitud,
       o.activity_id || '-' ||
       (SELECT description FROM open.ge_items where items_id = activity_id) ACTIVIDAD,
       s.proceso,
       s.MENSERROR mensaje_error,
       s.FECHGENE fecha_generacion,
       (SELECT SESUESCO FROM OPEN.SERVSUSC where sesunuse = o.product_id) estado_corte,
       (select decode(pp.sesuesfn,
                      'D',
                      'Con Deuda',
                      'M',
                      'En Mora',
                      'A',
                      'Al Dia',
                      'C',
                      'Castigado')
          from open.servsusc pp
         where pp.sesunuse = o.product_id) ESTADO
  FROM OPEN.LDC_LOGERRLEORRESU s, open.or_order_activity o
 WHERE (UPPER(proceso) LIKE 'PRGENRECORP%' OR
       UPPER(PROCESO) LIKE 'PRJOBRECOYSUSPRP%')
   AND s.ORDER_ID = o.order_id
   AND FECHGENE BETWEEN
       to_date(&FECHA_INI || ' 00:00:00', 'DD/MM/YYYY HH24:MI:SS') AND
       to_date(&FECHA_FIN || ' 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
   and o.product_id = 6500086
union all
SELECT prcanuse producto,
       null orden,
       null solicitud,
       null actividad,
       'PRINDEPRODSUCA' proceso,
       prcaobse,
       prcafeva,
       prcaesco,
       (select decode(pp.sesuesfn,
                      'D',
                      'Con Deuda',
                      'M',
                      'En Mora',
                      'A',
                      'Al Dia',
                      'C',
                      'Castigado')
          from open.servsusc pp
         where pp.sesunuse = prcanuse) ESTADO
  FROM OPEN.LDC_PRVACASU
 WHERE prcafeva BETWEEN
       to_date(&FECHA_INI || ' 00:00:00', 'DD/MM/YYYY HH24:MI:SS') AND
       to_date(&FECHA_FIN || ' 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
   and prcanuse = 6500086;
SELECT PRREPROD PRODUCTO,
       PRREACTI || '-' ||
       (SELECT description FROM open.ge_items where items_id = PRREACTI) ACTIVIDAD,
       PRREFEGE FECHA_GENERACION,
       DECODE(PRREPROC, 'N', 'NO', 'SI') PROCESADO,
       PRREFEPR FECHA_PROCESADO,
       PRREOBSE OBSERVACION
  FROM OPEN.LDC_PRODRERP
 where PRREPROD = 6500086;
