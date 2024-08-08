SELECT  unique mo_packages.package_id, request_date, tag_name,
                wf_data_external.plan_id, instance_id
                --status_id,
                --description 
    FROM open.mo_packages , open.wf_data_external, open.wf_instance i
    WHERE  motive_status_id = 13
        AND trunc(request_date) > '31-12-2014'
        AND tag_name <> 'P_INTERACCION_268'
        AND request_date < to_date('27/02/2016 12:48:00 am', 'dd/MM/yyyy hh:mi:ss am')
        AND mo_packages.package_id = wf_data_external.package_id
        AND  wf_data_external.plan_id = i.plan_id
        AND status_id in (3,2)
        AND  mo_packages.package_id  in (
36425507,
36289592,
34910196,
36300559,
36600807,
36670961,
36671168,
37016854,
35927246,
10663924   
);
