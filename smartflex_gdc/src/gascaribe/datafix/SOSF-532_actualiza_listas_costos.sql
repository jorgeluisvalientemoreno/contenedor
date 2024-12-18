declare
    cursor cuListas is
    with 
        auditoria as(
                        SELECT  rowid, to_char(previous_text) previous_text,
                                    upper(to_char(current_text)) current_text,
                                    au.current_date,
                                    au.current_user_mask
                        FROM OPEN.AU_AUDIT_POLICY_LOG au
                        where AUDIT_LOG_ID IN (321)
                            and au.current_date>=to_date('01/01/2022','dd/mm/yyyy')
                            and au.current_user_mask in ('EIDROJ','KARMEJ')
                    ),
        listas as(
                    select a.*,
                        substr(current_text,instr(current_text,'|',1)+1,instr(current_text,'|',instr(current_text,'|',1) )) lista2,
                        to_number(REGEXP_SUBSTR (current_text, '[^|]+', 1, 1)) lista,
                        REGEXP_SUBSTR (current_text, '[^|]+', 1, 2) desc_lista,
                        to_date(REGEXP_SUBSTR (current_text, '[^|]+', 1, 3),'dd/mm/yyyy hh24:mi:ss') fech_ini,
                        to_date(REGEXP_SUBSTR (current_text, '[^|]+', 1, 4),'dd/mm/yyyy hh24:mi:ss') fech_fin,
                        to_number(REGEXP_SUBSTR (current_text, '[^|]+', 1, 5)) unidad
                    from auditoria a )
        select distinct l.list_unitary_cost_id,
            l.description,
            l.validity_final_date,
            l.operating_unit_id,
            r.contrato,
            trunc(c.fecha_final) fecha_final,
            open.daor_operating_unit.fnugetcontractor_id(l.operating_unit_id, null) cntratista
        from listas
        inner join open.ge_list_unitary_cost l on l.list_unitary_cost_id=listas.lista and l.operating_unit_id is not null --and trunc(l.validity_start_date)=trunc(listas.fech_ini) and trunc(l.validity_final_date) =trunc(listas.fech_fin)
        inner join open.ldc_const_unoprl r on r.unidad_operativa=l.operating_unit_id
        inner join open.ge_contrato c on c.id_contrato=r.contrato
        where l.list_unitary_cost_id = (select max(l2.list_unitary_cost_id) from open.ge_list_unitary_cost l2 where l2.operating_unit_id=l.operating_unit_id)
        and trunc(l.validity_final_date) !=trunc(c.fecha_final);
begin
    dbms_output.put_line('LISTA|RESULTADO|CONTRATO|FECHA');
    for reg in cuListas loop
        begin
            update ge_list_unitary_cost l set l.validity_final_date = trunc(reg.fecha_final) where l.list_unitary_cost_id = reg.list_unitary_cost_id;
            commit;
            dbms_output.put_line(reg.list_unitary_cost_id||'|OK|'||reg.contrato||'|'||trunc(reg.fecha_final));
        exception
            when others then
                rollback;
                dbms_output.put_line(reg.list_unitary_cost_id||'|error: '||sqlerrm);
        end;
    end loop;
end;
/
