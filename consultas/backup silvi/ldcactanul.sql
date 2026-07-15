 select 
                    sc.PACKAGE_ID solicitud_de_anulacion,
                    mp.PACKAGE_ID,
                     mp.package_type_id,
                     gs.SUBSCRIBER_NAME ||' '||gs.SUBS_LAST_NAME solicitante,
                     IDENTIFICATION,
                     mm.SUBSCRIPTION_ID,
                     mm.PRODUCT_ID,
                     TOTAL_VALUE val_venta,
                     INITIAL_PAYMENT cuota_ini,
                     cu.CUPONUME cupon,
                     cu.CUPOFLPA cupon_pagado
                from mo_packages      mp,
                     GE_SUBSCRIBER    gs,
                     mo_motive        mm,
                     Cupon_Anulado_Ventas            cu,
                     MO_GAS_SALE_DATA vn,
                     (select sa.PACKAGE_ID 
                    from mo_packages sa
                    where sa.package_type_id=100327 
                    and sa.NUMBER_OF_PROD is null  
                    AND sa.MOTIVE_STATUS_ID=13) sc
               where mp.pACKAGE_ID = pkg_bcsolicitudes.fnuGetSolicitudAnulacion(sc.PACKAGE_ID)
                 and gs.SUBSCRIBER_ID = mp.SUBSCRIBER_ID
                 and mp.pACKAGE_ID = mm.pACKAGE_ID
                 and cu.CUPOSUSC = mm.SUBSCRIPTION_ID
                 and mp.pACKAGE_ID = vn.pACKAGE_ID 
                 AND (SELECT 1 FROM or_order_activity OA WHERE OA.PACKAGE_ID =sc.PACKAGE_ID) IS NULL
