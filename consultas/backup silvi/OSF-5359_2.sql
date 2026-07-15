select mo_packages.package_id id, mo_packages.address_id,  pkg_BOConsultaEmpresa.fsbObtEmpresaDireccion(mo_packages.address_id) as  Empresa
        from mo_packages
       where mo_packages.request_date between '11/02/2026' and sysdate
        and mo_packages.package_type_id in
        (
          SELECT to_number(regexp_substr(271,'[^,]+', 1, LEVEL)) AS tipk
                              FROM   dual
                              CONNECT BY regexp_substr(271, '[^,]+', 1, LEVEL) IS NOT NULL
        )
         AND mo_packages.PACKAGE_TYPE_ID <> 100271
         and mo_packages.MOTIVE_STATUS_ID <> 32  -- 32-Solicitud ANULADA
         and (select count(1) from    cupon where   cupotipo = 'DE' AND cupoflpa = 'N' and cupodocu = to_char(mo_packages.package_id)) = 0
         and not exists
       (select null
                from LDC_PKG_OR_ITEM
               where mo_packages.package_id = LDC_PKG_OR_ITEM.package_id
                 and LDC_PKG_OR_ITEM.order_item_id in
                     (  100002336,100002340,100002337,
                    100002341,4001025,4295124)
                 )
