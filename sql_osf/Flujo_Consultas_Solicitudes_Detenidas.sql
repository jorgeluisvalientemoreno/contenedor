--MOPRP
SELECT  lm.package_id SOLICITUD,
        p.messag_delivery_date "FECHA_DE_REGISTRO",
        pt.package_type_id||' - '||pt.description "TIPO_SOLICITUD",
        'MOPRP' "DETENIDO_EN",
        el.message "MENSAJE_ERROR",
        p.user_id USUARIO,
        p.pos_oper_unit_id||' - '||open.daor_operating_unit.fsbgetname(p.pos_oper_unit_id,0) "AREA",
        lm.log_date
FROM    open.mo_executor_log_mot lm,
        open.ge_executor_log el,
        open.mo_packages p,
        open.ps_package_type pt
WHERE   lm.executor_log_id = el.executor_log_id
AND     p.package_id = lm.package_id
AND     p.package_type_id = pt.package_type_id
AND     lm.status_exec_log_id = 4
and     p.package_id in (67553750)
/
union
/
--MOPWP
SELECT  lm.package_id SOLICITUD,
        p.messag_delivery_date "FECHA_DE_REGISTRO",
        pt.package_type_id||' - '||pt.description "TIPO_SOLICITUD",
        'MOPWP' "DETENIDO_EN",
        el.message "MENSAJE_ERROR",
        p.user_id USUARIO,
        p.pos_oper_unit_id||' - '||open.daor_operating_unit.fsbgetname(p.pos_oper_unit_id,0) "AREA",
        el.date_
FROM    open.mo_wf_pack_interfac lm,
        open.ge_executor_log el,
        open.mo_packages p,
        open.ps_package_type pt
WHERE   lm.executor_log_id = el.executor_log_id
AND     p.package_id = lm.package_id
AND     p.package_type_id = pt.package_type_id
AND     lm.status_activity_id = 4
and     p.package_id in (67553750)
/
union
--MOPWM
/
SELECT  p.package_id SOLICITUD,
        p.messag_delivery_date "FECHA_DE_REGISTRO",
        pt.package_type_id||' - '||pt.description "TIPO_SOLICITUD",
        'MOPWM' "DETENIDO_EN",
        el.message "MENSAJE_ERROR",
        p.user_id USUARIO,
        p.pos_oper_unit_id||' - '||open.daor_operating_unit.fsbgetname(p.pos_oper_unit_id,0) "AREA",
        el.date_
FROM    open.mo_wf_motiv_interfac lm,
        open.ge_executor_log el,
        open.mo_packages p,
        open.mo_motive m,
        open.ps_package_type pt
WHERE   lm.executor_log_id = el.executor_log_id
AND     p.package_id = m.package_id
AND     m.motive_id = lm.motive_id
AND     p.package_type_id = pt.package_type_id
AND     lm.status_activity_id = 4
and     p.package_id in (67553750)
/
union
/
--MOPWC
SELECT  p.package_id SOLICITUD,
        p.messag_delivery_date "FECHA_DE_REGISTRO",
        pt.package_type_id||' - '||pt.description "TIPO_SOLICITUD",
        'MOPWC' "DETENIDO_EN",
        el.message "MENSAJE_ERROR",
        p.user_id USUARIO,
        p.pos_oper_unit_id||' - '||open.daor_operating_unit.fsbgetname(p.pos_oper_unit_id,0) "AREA",
        el.date_
FROM    open.mo_wf_comp_interfac lm,
        open.ge_executor_log el,
        open.mo_packages p,
        open.mo_component c,
        open.ps_package_type pt
WHERE   lm.executor_log_id = el.executor_log_id
AND     p.package_id = c.package_id
AND     c.component_id = lm.component_id
AND     p.package_type_id = pt.package_type_id
AND     lm.status_activity_id = 4
and     p.package_id in (67553750)
/
union
/
--Flujos en Excepción
SELECT  mp.package_id SOLICITUD,
        mp.messag_delivery_date "FECHA_DE_REGISTRO",
        pt.package_type_id||' - '||pt.description "TIPO_SOLICITUD",
        'FLUJO EN EXCEPCIÓN' "DETENIDO_EN",
        el.message_desc "MENSAJE_ERROR",
        mp.user_id USUARIO,
        mp.pos_oper_unit_id||' - '||open.daor_operating_unit.fsbgetname(mp.pos_oper_unit_id,0) "AREA",
        el.log_date
FROM    open.wf_instance wf, open.wf_exception_log el, open.mo_packages mp, open.ps_package_type pt
WHERE   wf.instance_id = el.instance_id
AND     mp.package_id = wf.external_id
AND     mp.package_type_id = pt.package_type_id
AND     wf.status_id = 9
AND     el.status = 1
and     mp.package_id in (67553750)
/
union
--INPHI
/
SELECT  c.package_id SOLICITUD,
        c.messag_delivery_date "FECHA_DE_REGISTRO",
        f.package_type_id||' - '||f.description "TIPO_SOLICITUD",
        'INRMO ('||b.instance_id||')' "DETENIDO_EN",
        a.last_mess_desc_error "MENSAJE_ERROR",
        c.user_id USUARIO,
        c.pos_oper_unit_id||' - '||open.daor_operating_unit.fsbgetname(c.pos_oper_unit_id,0) "AREA",
        a.inserting_date
FROM    open.in_interface_history a,
        open.wf_instance b,
        open.mo_packages c,
        open.ps_package_type f
WHERE   a.request_number_origi = b.instance_id
AND     b.parent_external_id = c.package_id
AND     c.package_type_id = f.package_type_id
AND     a.status_id = 9
and    c.package_id in (67553750);
/