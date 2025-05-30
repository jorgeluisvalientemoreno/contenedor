select mp.package_id,
       mp.motive_status_id,
       MDFO.MOTIVE_ID,
       MDFO.ITEM_ID || ' - ' || gi.description,
       'MODALIDAD [' || DECODE(pea.pay_modality,
                               1,
                               '1-Antes de Hacer los Trabajos',
                               2,
                               '2-Al Finalizar los Trabajos',
                               3,
                               '3-Segun Avance de Obra',
                               4,
                               '4-Sin Cotizaci¿n',
                               'N/A') || ']' Metodo_Pago
  from OPEN.MO_DATA_FOR_ORDER MDFO
  left join open.mo_motive mm
    on mm.package_id = MDFO.Package_Id
   and mm.package_id is not null
  left join open.mo_packages mp
    on mp.package_id = MM.Package_Id
  left join open.ge_items gi
    on gi.items_id = MDFO.Item_Id
  left join ps_engineering_activ pea
    on pea.items_id = MDFO.Item_Id
 where 1 = 1
--and pea.pay_modality = 3
--and mp.motive_status_id = 13
--and mm.package_id = 78852081;
