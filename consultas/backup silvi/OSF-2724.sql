SELECT l.package_id, decode(nvl(t.cucocodi,0),0,'D'||t.difecodi,'C'||t.cucocodi) "Cuenta_cobro",
        nvl(t.factcodi,0) "Factura",
        t.ano "Ano",
        t.mes "Mes",
        t.valor_fac "Valor_Fac",
        t.valor_rec "Valor_Rec",
        t.status "Estado"
    FROM ldc_liqsinibri l, ldc_liqsinibridet t
    WHERE l.package_id = t.package_id
      AND t.status  = 'R'
      AND l.package_id  in (SELECT m.package_id FROM mo_packages m WHERE m.package_id=l.package_id and m.motive_status_id=13)
      --AND l.package_id= 207150143
