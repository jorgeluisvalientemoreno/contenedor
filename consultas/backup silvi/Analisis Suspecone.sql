select sesion,
       tipo_analisis,
       fecha_analisis,
       producto,
       est_prod,
       est_corte,
       nro_activ_ult_act_susp,
       ult_act_susp,
       nro_susp_act_producto,
       id_susp_act_prod_1,
       tipo_susp_act_prod_1,
       fech_apli_susp_act_prod_1,
       id_susp_act_prod_2,
       tipo_susp_act_prod_2,
       fech_apli_susp_act_prod_2,
       nr_susp_act_componentes,
       id_susp_act_comp_1,
       cod_susp_act_comp_1,
       tipo_susp_act_comp_1,
       fech_apli_susp_act_comp_1,
       id_susp_act_comp_2,
       cod_susp_act_comp_2,
       tipo_susp_act_comp_2,
       fech_apli_susp_act_comp_2,
       id_susp_act_comp_3,
       cod_susp_act_comp_3,
       tipo_susp_act_comp_3,
       fech_apli_susp_act_comp_3,
       id_susp_act_comp_4,
       cod_susp_act_comp_4,
       tipo_susp_act_comp_4,
       fech_apli_susp_act_comp_4,
       nro_componentes,
       id_componente_1,
       estado_comp_1,
       id_componente_2,
       estado_comp_2,
       nro_orden_1,
       orden_1,
       /*tipo_trab_orden_1,
       estado_orden_1,
       fecha_crea_orden_1,
       fecha_lega_orden_1,*/
       nro_orden_2,
       orden_2,
       /*tipo_trab_orden_2,
       estado_orden_2,
       fecha_crea_orden_2,
       fecha_lega_orden_2,*/
       nro_orden_3,
       orden_3,
       /*tipo_trab_orden_3,
       estado_orden_3,
       fecha_crea_orden_3,
       fecha_lega_orden_3,*/
       nro_orden_4,
       orden_4,
       /*tipo_trab_orden_4,
       estado_orden_4,
       fecha_crea_orden_4,
       fecha_lega_orden_4,*/
       nro_ord_suspcone_1,
       tipo_suspcone_1 ,  fech_orde_suspcone_1 ,fech_aten_suspcone_1,
       --- tipo_suspcone_1 || '    ' || fech_orde_suspcone_1 || '    ' || fech_aten_suspcone_1 datos_suspcone_1,
      /* fech_orde_suspcone_1,
       fech_aten_suspcone_1,*/
       nro_ord_suspcone_2,
       tipo_suspcone_2 , fech_orde_suspcone_2 , fech_aten_suspcone_2, 
       --- tipo_suspcone_2 || '    ' || fech_orde_suspcone_2 || '    ' || fech_aten_suspcone_2 datos_suspcone_2, 
       /*tipo_suspcone_2,
       fech_orde_suspcone_2,
       fech_aten_suspcone_2,*/
       decode(nro_soli_reconex_deteni,null,null,
       (lpad(nro_soli_reconex_deteni,10,' ') || '         ' || lpad(nro_orde_recone_deteni,10,' ') || '         ' ||  lpad(tt_orde_reconex_deteni,6,' ') 
      -- || '         ' || (select tt.description from open.or_task_type tt where tt.description = tt_orde_reconex_deteni)
       || '         ' || lpad(esta_orde_reconex_deteni,3,' '))) sol_reconex_detenida,
       
       ult_act_susp_de_rp,
       (select tt.task_type_id || ' - ' || tt.description from open.or_order o, open.or_order_Activity a, open.or_task_type tt where o.order_id = a.order_id
         and o.task_type_id = tt.task_type_id and a.order_activity_id = ult_act_susp_de_rp) tt_ult_Act_susp_rp,
       ult_act_susp_de_ca,
       (select tt.task_type_id || ' - ' || tt.description from open.or_order o, open.or_order_Activity a, open.or_task_type tt where o.order_id = a.order_id
         and o.task_type_id = tt.task_type_id and a.order_activity_id = ult_act_susp_de_ca) tt_ult_Act_susp_ca
  from OPEN.LDC_ANALISIS_SUSPCONE t
where t.sesion in (937376683)
   ---t.producto=:Producto
     and (SELECT p.PRODUCT_TYPE_ID FROM OPEN.PR_PRODUCT p WHERE p.PRODUCT_ID = t.producto)=7014
  --- where t.producto=:Producto
  ---  and t.producto not in (select a.producto from open.ldc_ajusta_suspcone a where a.producto = t.producto and a.observacion = 'Procesado')
    



 --- where sesion = 558050562
-- where t.sesion = :sesion
 --  and t.tipo_analisis = :tipoanalisis
 
 ---select * from open.ldc_osf_Estaproc t where t.proceso = 'LDC_PKAJUSTASUSPCONE'
