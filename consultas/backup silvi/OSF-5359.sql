/*nuActCIVZNR LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZNR');
  nuActCIVZSR LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZSR');
  nuActCIVZNC LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZNC');
  nuActCIVZSC LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZSC');
  nuActMZR    LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_MULTA_VENTA_OTRA_ZONA_RESID');
  nuActMZC    LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_MULTA_VENTA_OTRA_ZONA_COMM');

  nuRange     number := pkg_BCLD_Parameter.fnuObtieneValorNumerico('RANGO_COMISIONES_VENTA');
  nuActCLVZNR LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZNR');
  nuActCLVZSR LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZSR');
  nuActCLVZNC LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZNC');
  nuActCLVZSC LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZSC');

  nuPkgAtendido ps_package_type.package_type_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_ESTADO_PKG_ATENDTIDO');
  nuPkgAnulado  ps_package_type.package_type_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_ESTADO_PKG_ANULADA');
*/


select * 
from (
    select mo_packages.package_id id, 'B' sbTime ,  pkg_BOConsultaEmpresa.fsbObtEmpresaDireccion(mo_packages.address_id) as  Empresa
    from mo_packages
    where mo_packages.request_date between '11/02/2026' and sysdate
      and mo_packages.package_type_id in (
            SELECT to_number(regexp_substr(271,'[^,]+', 1, LEVEL))
            FROM dual
            CONNECT BY regexp_substr(271, '[^,]+', 1, LEVEL) IS NOT NULL
      )
      AND mo_packages.PACKAGE_TYPE_ID <> 100271
      and mo_packages.MOTIVE_STATUS_ID <> 32
      and (select count(1)
             from cupon
            where cupotipo = 'DE'
              AND cupoflpa = 'N'
              and cupodocu = to_char(mo_packages.package_id)) = 0
      and not exists (
            select null
            from LDC_PKG_OR_ITEM
            where mo_packages.package_id = LDC_PKG_OR_ITEM.package_id
              and LDC_PKG_OR_ITEM.order_item_id in (
                    100002336,100002340,100002337,
                    100002341,4001025,4295124
              )
      )

    union

    select mo_packages.package_id id, 'L' sbTime ,  pkg_BOConsultaEmpresa.fsbObtEmpresaDireccion(mo_packages.address_id) as  Empresa
    from mo_packages
    where mo_packages.request_date between '11/02/2026' and sysdate
      and mo_packages.package_type_id in (
            SELECT to_number(regexp_substr(271,'[^,]+', 1, LEVEL))
            FROM dual
            CONNECT BY regexp_substr(271, '[^,]+', 1, LEVEL) IS NOT NULL
      )
      and mo_packages.MOTIVE_STATUS_ID = 14
      and (select count(1)
             from cupon
            where cupotipo = 'DE'
              AND cupoflpa = 'N'
              and cupodocu = to_char(mo_packages.package_id)) = 0
      and not exists (
            select null
            from LDC_PKG_OR_ITEM
            where Mo_packages.package_id = LDC_PKG_OR_ITEM.package_id
              and LDC_PKG_OR_ITEM.order_item_id in (
                    100002336,100002340,100002337,
                    100002341,4001025,4295124
              )
      )
);
