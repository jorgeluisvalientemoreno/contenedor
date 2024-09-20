-- CONSULTA * OK * REAL INGRESOS
select CEBE, b.cebedesc DESCRIPCION, invmsesu NUSE, /*sesucate CATE,*/ invmconc CONCEPTO, o.concdesc,
       invmvain VR_iNGRESO, REPORTADO
from (
      select m.invmsesu , m.invmconc , m.invmvain, 
             decode((SELECT 1
                       FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                      WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                        AND OR_related_order.related_order_id = OR_order_activity.order_id
                        AND OR_order_activity.Status = 'F'
                        AND OR_order_activity.package_id = mo_packages.package_id
                        AND OR_order_activity.task_type_id in (10622, 10624)
                        AND mo_packages.package_type_id in (323, 100271, 100229) 
                        AND OR_order.order_id = OR_related_order.related_order_id
                        AND OR_order.legalization_date >= '09-02-2015'    AND OR_order.legalization_date < '01-03-2015'                  
                        AND OR_order_activity.product_id = m.invmsesu
                        AND m.invmconc = 30
                        AND ROWNUM = 1), 1, m.invmvain, 0) REPORTADO
        from open.ldci_ingrevemi m, open.servsusc v, open.suscripc s
       where m.invmsesu not in (select h.hcecnuse from open.hicaesco h
                                 where h.hcececan = 96
                                   and h.hcececac = 1 and hcecserv = 7014
                                   and h.hcecfech >= '09-02-2015' and h.hcecfech < '01-03-2015'
                                   and h.hcecnuse = m.invmsesu
                                   and open.dapr_product.fnugetproduct_status_id (m.invmsesu) = 1)
         and m.invmsesu = v.sesunuse
         and v.sesususc = s.susccodi order by invmsesu, invmconc
     ), OPEN.LDCI_centrobenef b, open.concepto o
 WHERE cebe     = b.cebecodi 
   AND invmconc = o.conccodi     
