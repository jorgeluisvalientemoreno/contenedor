declare

  /*with suspension_voluntaria as
   (SELECT sv.PROD_SUSPENSION_ID,
           sv.PRODUCT_ID,
           sv.SUSPENSION_TYPE_ID,
           sv.REGISTER_DATE,
           sv.APLICATION_DATE,
           sv.INACTIVE_DATE,
           sv.ACTIVE,
           sv.CONNECTION_CODE
      FROM open.PR_PROD_SUSPENSION A
     WHERE sv.APLICATION_DATE IS NOT NULL
       AND sv.ACTIVE = 'N'
       AND sv.INACTIVE_DATE IS NULL
       AND sv.SUSPENSION_TYPE_ID = 5
     ORDER BY sv.PRODUCT_ID, sv.REGISTER_DATE)
  select distinct sv.*
    from suspension_voluntaria sv, open.mo_motive mm_sv, open.mo_packages mp_sv, open.mo_motive mm_rv, open.mo_packages mp_rv
   where mm_sv.product_id = sv.product_id
     and mm_sv.package_id = mp_sv.package_id
     and mp_sv.package_type_id = 100209
     and mp_sv.motive_status_id = 14
     and trunc(sv.REGISTER_DATE) = trunc(mp_sv.request_date)
     and mm_rv.product_id = sv.product_id
     and mm_rv.package_id = mp_rv.package_id
     and mp_rv.package_type_id = 100210
     and mp_rv.motive_status_id = 14
     and trunc(mp_sv.request_date) < trunc(mp_rv.request_date);*/

  cursor cuSuspensionVoluntaria is
    SELECT sv.*
      FROM open.PR_PROD_SUSPENSION sv
     WHERE sv.APLICATION_DATE IS NOT NULL
       AND sv.ACTIVE = 'N'
       AND sv.INACTIVE_DATE IS NULL
       AND sv.SUSPENSION_TYPE_ID = 5
       and (SELECT count(sv_.product_id)
              FROM open.PR_PROD_SUSPENSION sv_
             WHERE sv_.APLICATION_DATE IS NOT NULL
               AND sv_.ACTIVE = 'N'
               AND sv_.INACTIVE_DATE IS NULL
               AND sv_.SUSPENSION_TYPE_ID = 5
               and sv_.product_id = sv.product_id) = 1
     order by sv.product_id, sv.register_date;

  rfSuspensionVoluntaria cuSuspensionVoluntaria %rowtype;

  cursor cuSolicitudSV(inuProducto number) is
    select mp_sv.request_date, oo.LEGALIZATION_DATE
      from open.mo_motive         mm_sv,
           open.mo_packages       mp_sv,
           open.or_order_activity ooa,
           open.or_order          oo
     where mm_sv.product_id = inuProducto
       and mm_sv.package_id = mp_sv.package_id
       and mp_sv.package_type_id = 100209
       and mp_sv.motive_status_id = 14
       and mp_sv.package_id = ooa.package_id
       and ooa.order_id = oo.order_id
     order by ooa.product_id;

  rfSolicitudSV cuSolicitudSV%rowtype;

  cursor cuSolicitudRV(inuProducto number, idtFechaSV date) is
    select mp_rv.request_date, oo.execution_final_date
      from open.mo_motive         mm_rv,
           open.mo_packages       mp_rv,
           open.or_order_activity ooa,
           open.or_order          oo
     where mm_rv.product_id = inuProducto
       and mm_rv.package_id = mp_rv.package_id
       and mp_rv.package_type_id = 100210
       and mp_rv.motive_status_id = 14
       and mp_rv.package_id = ooa.package_id
       and ooa.order_id = oo.order_id;

  rfSolicitudRV cuSolicitudRV%rowtype;

  nuRV number := 1;

begin

  for rfSuspensionVoluntaria in cuSuspensionVoluntaria loop
  
    /*
    open cuSolicitudSV(rfSuspensionVoluntaria.PRODUCT_ID);
    fetch cuSolicitudSV
      into rfSolicitudSV;
    if cuSolicitudSV%found then
      dbms_output.put_line('Producto: ' ||
                           rfSuspensionVoluntaria.PRODUCT_ID ||
                           ' - Fecha Suspension: ' ||
                           rfSuspensionVoluntaria.REGISTER_DATE ||
                           ' - Fecha Registro Suspension: ' ||
                           rfSolicitudSV.request_date ||
                           ' - Fecha Legaliza Orden: ' ||
                           rfSolicitudSV.LEGALIZATION_DATE);
    end if;
    
    close cuSolicitudSV;
    */
  
    --/*
    open cuSolicitudRV(rfSuspensionVoluntaria.PRODUCT_ID,
                       rfSuspensionVoluntaria.REGISTER_DATE);
    fetch cuSolicitudRV
      into rfSolicitudRV;
    if cuSolicitudRV%found then
      dbms_output.put_line(nuRV || ' Producto: ' ||
                           rfSuspensionVoluntaria.PRODUCT_ID ||
                           ' - Fecha Suspension: ' ||
                           rfSuspensionVoluntaria.REGISTER_DATE ||
                           ' - Fecha Ejecucion Final Orden: ' ||
                           rfSolicitudRV.execution_final_date);
    end if;
  
    close cuSolicitudRV;
  
    nuRV := nuRV + 1;
    --*/
  
  end loop;

end;
