WITH PeFaCiclo AS
    (
        SELECT pf.pefacicl, pf.pefacodi
        FROM perifact pf
        WHERE 1=1
         and pf.pefacodi = 117837
         and pf.pefafimo >= '01/06/2025'
         /*and not exists (select null
          from procejec p2
         where p2.prejcope = pf.pefacodi
           and p2.prejprog in ('FGCC')
           and p2.prejespr = 'T'
           and p2.prejfech >= '01/06/2025')*/
    ) ,
    contratos AS
    (
        SELECT  sc.susccodi, sc.suscclie, sc.susciddi, pc.pefacodi, pc.pefacicl
        FROM PeFaCiclo pc, suscripc sc
        WHERE sc.susccicl = pc.pefacicl
        AND NOT EXISTS
        (
            SELECT '1'
            FROM factura fa
            WHERE fa.factsusc = sc.susccodi
            AND fa.factpefa = pc.pefacodi
            AND fa.factprog = 6
        )
    ),
    productos AS
    (
        SELECT ct.susccodi sesususc, pr.product_id sesunuse, ct.suscclie, ct.susciddi, pr.category_id sesucate, pr.subcategory_id sesusuca, ct.pefacodi, ct.pefacicl
        FROM contratos ct, pr_product pr, servsusc ss
        WHERE pr.subscription_id = ct.susccodi
          AND pr.product_type_id = 7014 --cnuSERVICIO_GAS_CLM
          AND pr.product_status_id IN
              (
                SELECT ps.product_status_id
                FROM ps_product_status ps
                WHERE ps.prod_status_type_id = 1
                  AND ps.is_active_product = 'Y'
                  AND ps.is_final_status= 'Y'
              )
          AND ss.sesunuse = pr.product_id
          AND ss.sesuesfn NOT IN ('C')
    ),
    ult_medidor as
    (
        SELECT es.EMSSSESU, es.emsscoem,  RANK() OVER (PARTITION BY es.emsssesu ORDER BY es.emssfere DESC) posicion
        FROM elmesesu es
    )

    SELECT 117837 Periodo, --pr.pefacodi  periodo, /*inuPeriodo*/
           pr.pefacicl,
           pr.sesususc Contrato,
           pr.sesunuse Producto,
           sr.subscriber_name || ' ' || sr.subs_last_name nombre_cliente,
           ad.ADDRESS_PARSED Direccion_Cobro,
           -1 TipoNotificacion,
           personalizaciones.pkg_BcGestionCartaRP.fnuTipoNotificacion (open.Ldc_pkgprocrevperfact.fnuEdadCertificadoSpool(pr.sesunuse)) tipo_noti, --> :inuEdadCertificado
           ad.geograp_location_id Localidad,
           gl.description Nombre_Localidad,
           dp.description Nombre_Departamento,
           -1 EdadCertificado,
           um.emsscoem medidor,
           pr.sesucate categoria,
           pr.sesusuca subcategoria
    FROM    productos pr, ge_subscriber sr,
            ab_address ad,
            ge_geogra_location gl,
            ge_geogra_location dp,
            ult_medidor um
    WHERE sr.subscriber_id = pr.suscclie
    AND ad.address_id = pr.susciddi
    AND gl.geograp_location_id = ad.geograp_location_id
    AND dp.geograp_location_id =  gl.GEO_LOCA_FATHER_ID
    AND um.emsssesu(+) = pr.sesunuse
    AND um.posicion(+) = 1
    AND personalizaciones.pkg_BcGestionCartaRP.fnuTipoNotificacion (open.Ldc_pkgprocrevperfact.fnuEdadCertificadoSpool(pr.sesunuse)) in (1,5)
    --and rownum <= 100
    order by pr.pefacodi;
