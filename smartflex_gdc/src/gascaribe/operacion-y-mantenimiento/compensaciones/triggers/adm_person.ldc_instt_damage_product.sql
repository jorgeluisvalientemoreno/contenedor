create or replace trigger ADM_PERSON.LDC_INSTT_DAMAGE_PRODUCT
  before INSERT ON tt_damage_product
  FOR EACH ROW

/*****************************************************************
    Unidad         : LDC_INSTT_DAMAGE_PRODUCT
    Descripcion    : Inicializa datos para prodcutos con categoria en el parametro CAT_SIN_TIEM_COMP
                     que no deben tener tiempo compensado
    Autor          : Jorge Valiente
    Fecha          : 19/07/2016
    CASO           : OSF-554

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
  ******************************************************************/

declare

  sbCAT_SIN_TIEM_COMP open.ld_parameter.value_chain%type := open.dald_parameter.fsbGetValue_Chain('CAT_SIN_TIEM_COMP',
                                                                                                  null);

  --Cursor para identificar productos que no obtendran tiempo compensado
  cursor cuproducto is
    select count(1)
      from pr_product b
     where b.product_id = :new.product_id
       and b.category_id in
           (SELECT to_number(regexp_substr(sbCAT_SIN_TIEM_COMP,
                                           '[^,]+',
                                           1,
                                           LEVEL)) AS categoria
              FROM dual
            CONNECT BY regexp_substr(sbCAT_SIN_TIEM_COMP, '[^,]+', 1, LEVEL) IS NOT NULL);

  nuConteo number;

BEGIN

  ut_trace.trace('Inicio LDC_INSTT_DAMAGE_PRODUCT', 2);

  ut_trace.trace('CAT_SIN_TIEM_COMP[' || sbCAT_SIN_TIEM_COMP || ']', 5);
  --inicia llamado de cursor
  open cuproducto;
  fetch cuproducto
    into nuConteo;
  close cuproducto;
  ut_trace.trace('Conteo[' || nuConteo || ']', 5);

  ---inicia conteo para inicializar data de prodcutos que no tendra tiempo compensado
  IF nuConteo > 0 then
    ut_trace.trace('Inicializa datos para no tener tiempo compensado', 5);
    :new.damage_produ_status := 'C';
    :new.compensated_time    := 0;
    :new.repaired            := 'Y';
  
    --Registro de producto que no tendra tiempo compensado
    ut_trace.trace('Inicio LDC_DAMPRO_SIN_TIEMCOM', 8);
    insert into LDC_DAMPRO_SIN_TIEMCOM
      (DAMAGES_PRODUCT_ID, PRODUCT_ID, PACKAGE_ID)
    values
      (:new.damages_product_id, :new.product_id, :new.package_id);
    ut_trace.trace('Fin LDC_DAMPRO_SIN_TIEMCOM', 8);
  
  END if;

  ut_trace.trace('Fin LDC_INSTT_DAMAGE_PRODUCT', 2);

exception
  when others then
    ut_trace.trace('Error ' || sqlerrm, 12);
    null;
END;
/
