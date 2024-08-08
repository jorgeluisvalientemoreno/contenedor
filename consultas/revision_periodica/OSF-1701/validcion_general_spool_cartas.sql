--validcion_general_spool_cartas
select  ss.sesunuse, sc.susccodi, sc.suscclie, sc.susciddi, p.product_status_id, ss.sesuesco, ss.sesuesfn, ss.sesucicl
        from servsusc  ss
        inner join suscripc sc  on ss.sesususc = sc.susccodi
        inner join pr_product  p  on p.product_id = ss.sesunuse
        --inner join ps_product_status ps  on ps.product_status_id = p.product_status_id and ps.prod_status_type_id = 1 and ps.is_active_product != 'N'
        where p.product_type_id = 7014
        --and   ss.sesucicl = 101
        and  open.ldc_pkgOSFFacture.fnuTipoNotificacion (open.Ldc_pkgprocrevperfact.fnuEdadCertificadoSpool(ss.sesunuse))  in (1,5)
        and not exists
        (
            select null
            from factura fa
            where fa.factsusc = ss.sesususc
            --and fa.factpefa = 107328
            and   factfege >= '01/10/2023'
            and fa.factprog = 6
        )
  order by ss.sesucicl
