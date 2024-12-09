with pefaciclo as
    (
        select pf.pefacicl, pf.pefacodi
        from perifact pf
        where pf.pefacodi = 113347 --inuperiodo
    ) ,
    contratos as
    (
        select  sc.susccodi, sesunuse,sc.suscclie, sc.susciddi, sl.sesuesco, sl.sesuesfn
        from pefaciclo pc, suscripc sc, servsusc sl
        where  sl.sesususc = sc.susccodi
        and sl.sesucicl = pefacicl
       and not exists
        (
            select '1'
            from factura fa
            where fa.factsusc = sc.susccodi
            and fa.factpefa = pefacodi
            and fa.factprog = 6
        )
    ),
    productos as
    (
        select ct.susccodi sesususc, pr.product_id sesunuse, ct.suscclie, ct.susciddi, pr.category_id sesucate, pr.subcategory_id sesusuca, pr.product_status_id  estprod, ct.sesuesco  estcorte, ct.sesuesfn  estfinan
        from contratos ct, pr_product pr, servsusc so
        where pr.subscription_id = ct.susccodi and  pr.product_id = ct.sesunuse
          and pr.product_type_id = 7014
          and pr.product_status_id in
              (
                select ps.product_status_id
                from ps_product_status ps
                where ps.prod_status_type_id = 1
                  and ps.is_active_product = 'Y'
                and ps.is_final_status = 'Y'
              )
          and so.sesunuse = pr.product_id
         -- and so.sesuesfn not in ('C')
    ),
    ult_medidor as
    (
        select es.emsssesu, es.emsscoem,  rank() over (partition by es.emsssesu order by es.emssfere desc) posicion
        from elmesesu es
    )

    select 113347 /*inuperiodo*/ periodo,
           pr.sesususc contrato,
           pr.sesunuse producto,
           pr.estprod,
           pr.estcorte, 
           pr.estfinan,
           sr.subscriber_name || ' ' || sr.subs_last_name nombre_cliente,
           ad.address_parsed direccion_cobro,
           open.ldc_getedadrp(pr.sesunuse) edad_rp,
           open.Ldc_pkgprocrevperfact.fnuEdadCertificadoSpool(pr.sesunuse) edad_rp2,
           -1 tiponotificacion,
           open.ldc_pkgOSFFacture.fnuTipoNotificacion (open.Ldc_pkgprocrevperfact.fnuEdadCertificadoSpool(pr.sesunuse)) tipo_noti,
           ad.geograp_location_id localidad,
           gl.description nombre_localidad,
           dp.description nombre_departamento,
           -1 edadcertificado,
           um.emsscoem medidor,
           pr.sesucate categoria,
           pr.sesusuca subcategoria, 
           open.ldc_getedadrp(pr.sesunuse) edad_rp
    from    productos pr, ge_subscriber sr,
            ab_address ad,
            ge_geogra_location gl,
            ge_geogra_location dp,
            ult_medidor um
    where sr.subscriber_id = pr.suscclie
    and ad.address_id = pr.susciddi
    and gl.geograp_location_id = ad.geograp_location_id
    and dp.geograp_location_id =  gl.geo_loca_father_id
    and um.emsssesu(+) = pr.sesunuse
    and um.posicion(+) = 1
  and open.ldc_pkgOSFFacture.fnuTipoNotificacion (open.Ldc_pkgprocrevperfact.fnuEdadCertificadoSpool(pr.sesunuse))  in (1,5)
