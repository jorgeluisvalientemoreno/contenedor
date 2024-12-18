column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    CURSOR cuSubsidioUbicacion
    IS
    SELECT tb.*      
    FROM (SELECT  su.deal_id, su.subsidy_id ,u.ubication_id,
            u.GEOGRA_LOCATION_ID,
            u.sucacate,
            u.sucacodi,
            sum(a.subsidy_value) valor_entregado_cal,
          (
                SELECT sum(total_deliver) FROM ld_ubication ab
                WHERE  ab.ubication_id = u.ubication_id
                AND    ab.sucacate = u.sucacate
                AND    ab.sucacodi = u.sucacodi
            ) total_entregado_real,
            (
                SELECT sum(authorize_value) FROM ld_ubication ab
                WHERE  ab.ubication_id = u.ubication_id
                AND    ab.sucacate = u.sucacate
                AND    ab.sucacodi = u.sucacodi
            ) authorize_value_real,
            (
                SELECT sum(total_available) FROM ld_ubication ab
                WHERE  ab.ubication_id = u.ubication_id
                AND    ab.sucacate = u.sucacate
                AND    ab.sucacodi = u.sucacodi
            ) total_available_real  
    FROM    ld_asig_subsidy a, 
            mo_packages m,
            ld_ubication u,
            ld_subsidy su
    WHERE   m.package_id=a.package_id
    AND     u.subsidy_id = a.subsidy_id
    AND     u.ubication_id = a.ubication_id
    AND     a.subsidy_id = su.subsidy_id 
    AND     m.motive_status_id not in (32)
    AND     trunc(su.initial_date) <= trunc(sysdate) and trunc(su.final_date) >= trunc(sysdate)
    GROUP BY su.deal_id, su.subsidy_id, u.ubication_id,
            u.GEOGRA_LOCATION_ID,
            u.sucacate,
            u.sucacodi) tb 
    where valor_entregado_cal - total_entregado_real  != 0;

    CURSOR cuSubsidio
    IS
    SELECT *  FROM (
    SELECT  b.subsidy_id,
            b.deal_id,
            b.authorize_value,
            NVL(b.total_deliver,0) total_entregado_subsidio,
            NVL(b.total_available,0) total_dispo_subsidio,
            (
                SELECT NVL(sum(a.total_deliver),0)  from ld_ubication a WHERE a.subsidy_id = b.subsidy_id 
            )total_entregado_ubi,
            (
                SELECT NVL(sum(a.total_available),0)  from ld_ubication a WHERE a.subsidy_id = b.subsidy_id 
            )total_dispo_ubi
    FROM    ld_subsidy b
    WHERE   trunc(b.initial_date) <= trunc(sysdate) and trunc(b.final_date) >= trunc(sysdate)
    ) tb
    WHERE total_entregado_subsidio != total_entregado_ubi;
BEGIN
  dbms_output.put_line('Inicia caso OSF-3687 !');

  dbms_output.put_line('Inicia Actualizacion Subsidio por localidad!');

  FOR reg IN cuSubsidioUbicacion LOOP

      dbms_output.put_line('Convenio: '||reg.deal_id);
      dbms_output.put_line('Subsidio: '||reg.subsidy_id);
      dbms_output.put_line('Valor entregado Anterior: '||reg.total_entregado_real);
      dbms_output.put_line('Valor entregado calculado: '||reg.valor_entregado_cal);

      UPDATE  ld_ubication
      SET     total_deliver = reg.valor_entregado_cal,
              total_available =  authorize_value - reg.valor_entregado_cal
      WHERE   ubication_id = reg.ubication_id;
    
  END LOOP;

  dbms_output.put_line('Fin Actualizacion Subsidio por localidad!');

  dbms_output.put_line('Inicia Actualizacion Subsidio por general!');

  FOR regis IN cuSubsidio LOOP

      dbms_output.put_line('Convenio: '||regis.deal_id);
      dbms_output.put_line('Subsidio: '||regis.subsidy_id);
      dbms_output.put_line('Valor entregado Anterior: '||regis.total_entregado_subsidio);
      dbms_output.put_line('Valor entregado calculado: '||regis.total_entregado_ubi);

      UPDATE  ld_subsidy
      SET     total_deliver = regis.total_entregado_ubi,
              total_available =  authorize_value - regis.total_entregado_ubi
      WHERE   subsidy_id = regis.subsidy_id;
    
  END LOOP;
  dbms_output.put_line('Fin Actualizacion Subsidio por general!');
  COMMIT;
  dbms_output.put_line('Fin caso OSF-3687 !');
exception
when others then 
			dbms_output.put_line('Error actualizando subsidios: '||sqlerrm);
			rollback;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/