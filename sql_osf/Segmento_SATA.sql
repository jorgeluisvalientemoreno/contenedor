select distinct oo.order_id                    Orden,
                mm.motive_id                   Motivo,
                mbdc.old_category_id           Categoria_Anterior_CAMBIO_USO,
                mbdc.new_category_id           Nueva_Categoria_CAMBIO_USO,
                mbdc.old_subcategory_id        SubCat_Anterior_CAMBIO_USO,
                mbdc.new_subcategory_id        Nueva_SubCategoria_CAMBIO_USO,
                SegmentoDireccion.Category_    Cat_Segmento,
                SegmentoDireccion.Subcategory_ SubCat_Segmento
  from open.or_order_activity ooa
  left join open.or_order oo
    on oo.order_id = ooa.order_id
  left join open.mo_packages mp
    on mp.package_id = ooa.package_id
  left join open.mo_motive mm
    on mm.package_id = ooa.package_id
  left join open.pr_product pp
    on pp.product_id = ooa.product_id
  left join open.ab_address DireccionProducto
    on DireccionProducto.Address_Id = pp.address_id
  left join open.ab_segments SegmentoDireccion
    on SegmentoDireccion.Segments_Id = DireccionProducto.Segment_Id
  left join OPEN.MO_BILL_DATA_CHANGE mbdc
    on mbdc.package_id = ooa.package_id
 where oo.task_type_id in (12622)
   and oo.order_status_id = 5
   and mp.motive_status_id = 13
   and mp.package_type_id = 100225
   and mbdc.new_category_id in (1)
   and SegmentoDireccion.Category_ = mm.category_id
   and SegmentoDireccion.Subcategory_ <> mm.subcategory_id;
