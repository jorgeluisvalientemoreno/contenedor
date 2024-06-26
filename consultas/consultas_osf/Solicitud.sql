select distinct mp.package_id,
                mp.package_type_id || ' - ' ||
                (select b.description
                   from open.ps_package_type b
                  where b.package_type_id = mp.package_type_id) Tipo_Solicitud,
                mp.reception_type_id || ' - ' ||
                (select c.description
                   from open.ge_reception_type c
                  where c.reception_type_id = mp.reception_type_id) Medio_Recepcion,
                mp.request_date Fecha_Registro,
                mp.attention_date Fecha_Atencion,
                mp.init_register_date Fecha_Inicio_Registro,
                mp.cust_care_reques_num Interaccion,
                mp.motive_status_id || ' - ' ||
                (select d.description
                   from open.ps_motive_status d
                  where d.motive_status_id = mp.motive_status_id) Estado_Solicitud,
                mp.comment_ Comentario,
                mm.motive_id Motivo,
                MP.USER_ID Usuario,
                mp.reception_type_id,
                (select mp.pos_oper_unit_id || ' - ' || oou.name
                   from open.or_operating_unit oou
                  where oou.operating_unit_id = mp.pos_oper_unit_id) Punto_Venta,
                (select mp.operating_unit_id || ' - ' || oou.name
                   from open.or_operating_unit oou
                  where oou.operating_unit_id = mp.operating_unit_id) Unidad_Operativa,
                mp.management_area_id,
                mm.product_id,
                mm.subscription_id,
                (select mm.motive_status_id || ' - ' || d.description
                   from open.ps_motive_status d
                  where d.motive_status_id = mm.motive_status_id) Estado_Motivo,
                (select mm.motive_status_id || ' - ' || d.description
                   from open.ps_motive_status d
                  where d.motive_status_id = mc.motive_status_id) Estado_Componentes
  from open.mo_packages mp
  left join open.mo_motive mm
    on MP.PACKAGE_ID = MM.PACKAGE_ID
  left join open.mo_component mc
    on mc.package_id = mp.package_id
   and 'S' in &ConsultaComponente
 where mp.package_type_id = 323
   and mp.motive_status_id = 14
--and (mm.subscription_id = 48052064 or mm.product_id = 50062001)
-- and mp.cust_care_reques_num = '213303669'   
--   and mm.product_id = 50366875
--and mp.package_type_id = 100030
--and trunc(mp.request_date) = '23/04/2024'
 order by MP.REQUEST_DATE desc;

/*select mp.*
  from open.mo_packages mp
 where trunc(mp.request_date) >= trunc(sysdate)
   and mp.package_type_id = 268;

select mm.*, rowid
  from open.mo_motive mm
 where mm.package_id in (select mp.package_id
                           from open.mo_packages mp
                          where trunc(mp.request_date) >= trunc(sysdate)
                            and mp.package_type_id = 268);*/
