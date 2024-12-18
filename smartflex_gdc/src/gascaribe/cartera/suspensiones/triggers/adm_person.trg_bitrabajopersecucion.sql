create or replace trigger ADM_PERSON.TRG_BITRABAJOPERSECUCION
 /**************************************************************************

  Caso        :  868
  Descripcion :   Trigger para evitar duplicados de OT de Persecucion
  Autor       :  Dvaliente-Horbath
  Fecha       :  07/02/2022


  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  12/08/2022          Jorge Valiente     OSF-492:* Se retira la validacion FBLAPLICAENTREGAXCASO('0000868')
                                                 * Se modifica el trigger para que valide si el producto tiene 
                                                   una solicitud de RP en proceso no permita generar la orden.
                                                   Los tipos de solicitudes de RP que se deben validar se 
                                                   encuentran configurados en el parámetro COD_PKG_TYPE_ID_FILTRO_SUSP.
                                                 * Se adiciona filtro para validar si el prodcuto esta suspendido por RP (101,102,103,104)
  **************************************************************************/

  before insert on OR_ORDER_ACTIVITY
  for each row
  
when (NVL(NEW.LEGALIZE_TRY_TIMES,0) = 0)
declare
  sbValorPar ld_parameter.value_chain%type := dald_parameter.fsbgetvalue_chain('TIPOS_TRABAJO_PERSECUCION');
  nuconteo   number := 0;
  nuTT       number;
  
  ---OSF-492
  sbTSRP open.ld_parameter.value_chain%type := open.dald_parameter.fsbGetValue_Chain('COD_PKG_TYPE_ID_FILTRO_SUSP',null);
  
  cursor cuRPRegistrada is
    select count(*)
      from open.mo_motive mm, open.mo_packages mp
     where mm.package_id = mp.package_id
       and (mm.subscription_id = :new.subscription_id or
           mm.product_id = :new.product_id)
       and mp.package_type_id in
           (SELECT to_number(regexp_substr(sbTSRP, '[^,]+', 1, LEVEL)) AS estacort
              FROM dual
            CONNECT BY regexp_substr(sbTSRP, '[^,]+', 1, LEVEL) IS NOT NULL)
       and mp.motive_status_id = 13
       and (select count(1)
              from pr_prod_suspension p
             where p.product_id = :new.product_id
               and p.active = 'Y'
               and p.inactive_date is null
               and p.suspension_type_id in (101, 102, 103, 104)
               and rownum = 1) = 1;
  nucuRPRegistrada number;
  ---OSF-492 
  
begin

    --valido el tipo de trabajo con el parametro definido
    if :new.task_type_id is not null then
      select count(1)
        into nuTT
        from (select column_value
                from table(ldc_boutilities.splitstrings(sbValorPar, ',')))
       where column_value = :new.task_type_id;
    else
      select count(1)
        into nuTT
        from (select column_value
                from table(ldc_boutilities.splitstrings(sbValorPar, ',')))
       where column_value in
             (select otti.task_type_id
                from OR_TASK_TYPES_ITEMS otti
               where otti.items_id = :new.activity_id);
    end if;
    if nuTT > 0 then
      --validar si el producto tiene ordenes pendientes
      begin
        select count(*)
          into nuconteo
          from or_order o, or_order_activity oa
         where o.order_id = oa.order_id
           and oa.product_id = :new.product_id
           and o.task_type_id in
               (select column_value
                  from table(ldc_boutilities.splitstrings(sbValorPar, ',')))
           and o.order_status_id not in (8, 12);
      exception
        when others then
          nuconteo := 0;
      end;
      if nuconteo > 0 then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'No puede registrar una OT de Persecucion, ya el usuario tiene una OT en estado no Terminal');
        raise ex.CONTROLLED_ERROR;
      end if;
      ---Inicio OSF-492
      open cuRPRegistrada;
      fetch cuRPRegistrada into nucuRPRegistrada;
      close cuRPRegistrada;
      if nucuRPRegistrada > 0 then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'No puede registrar una OT de Persecucion, ya el usuario tiene solicitudes de RP en proceso');
        raise ex.CONTROLLED_ERROR;
      end if;
      ---Fin OSF-492
    end if;

EXCEPTION
  When ex.controlled_error Then
    Raise ex.controlled_error;
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    Raise ex.controlled_error;
end TRG_BITRABAJOPERSECUCION;
/