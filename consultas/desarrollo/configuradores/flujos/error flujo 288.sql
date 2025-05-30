SELECT  mp.package_id SOLICITUD,
        mp.messag_delivery_date "FECHA_DE_REGISTRO",
        pt.package_type_id||' - '||pt.description "TIPO_SOLICITUD",
        'FLUJO EN EXCEPCIÓN' "DETENIDO_EN",
        el.message_desc "MENSAJE_ERROR",
        mp.user_id USUARIO,
        mp.pos_oper_unit_id||' - '||open.daor_operating_unit.fsbgetname(mp.pos_oper_unit_id,0) "AREA",
        wf.instance_id,
        WF.INITIAL_DATE,
        WF.INITIAL_DATE+20
FROM    open.wf_instance wf, open.wf_exception_log el, open.mo_packages mp, open.ps_package_type pt
WHERE   wf.instance_id = el.instance_id
AND     mp.package_id = wf.external_id
AND     mp.package_type_id = pt.package_type_id
AND     wf.status_id = 9
AND     el.status = 1
AND     mp.package_type_id = 288
