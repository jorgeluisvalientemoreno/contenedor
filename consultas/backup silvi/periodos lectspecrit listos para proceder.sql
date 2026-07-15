SELECT DISTINCT l.sesunuse, l.pefacodi, l.pecscons
FROM ldc_cm_lectesp l,
     perifact      pf,
     or_order      o,
     pericose      pc
WHERE     o.order_id = l.order_id
     AND l.pefacodi = pf.pefacodi
     AND l.pecscons = pc.pecscons
     AND pf.pefaactu = 'S'
     AND pc.pecsflav = 'N'
     AND o.order_status_id <> 8
     AND l.procesado = 'N'
ORDER BY l.sesunuse DESC;

--50086819
select * from LDC_CM_LECTESP_CICL
