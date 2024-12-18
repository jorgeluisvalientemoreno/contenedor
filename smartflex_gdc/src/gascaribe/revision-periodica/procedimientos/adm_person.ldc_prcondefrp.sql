CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRCONDEFRP IS

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_PRCONDEFRP
  Descripcion    : PLUGIN que actualiza el conteo de repacaiones para defecros criticos y no criticos
                   y actualizar la unidad opertaiva
  Autor          : GDC
  CAMBIO         : 836
  Fecha          : 24/09/2021

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

  --Variables
  nuorden             or_order.order_id%type;
  nutask_type_id      or_order.task_type_id%type;
  nucausal_id         or_order.causal_id%type;
  nuoperating_unit_id or_order.operating_unit_id%type;

  VnuPRODCUTO  NUMBER;
  VnuACTIVIDAD NUMBER;

  VNuExiste          NUMBER := 0;
  VNuExisteTT        NUMBER := 0;
  VNuExisteCAUSAL    NUMBER := 0;
  VNuExisteActividad NUMBER := 0;

  VNuUnidadDefecto number := 0;
  VNuReparaciones  number := 0;

  --Cursor
  cursor cuDATAorden(InuOrden number) is
    select oo.task_type_id, oo.causal_id, oo.operating_unit_id
      from open.or_order oo
     where oo.order_id = InuOrden;

  ---Servicios
  --Funcion para establecer si el valor esta definido en el parametro
  FUNCTION FNUEXISTE(PARAMETRO VARCHAR2, VALOR NUMBER) RETURN number IS
    --PRAGMA AUTONOMOUS_TRANSACTION;

    cursor cuexiste is
      select count(1)
        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain(PARAMETRO,
                                                                                 NULL),
                                                ','))
       where to_number(column_value) = VALOR;

    nuExiste NUMBER;

  BEGIN

    open cuexiste;
    fetch cuexiste
      into nuExiste;
    close cuexiste;

    return(nuExiste);

  EXCEPTION
    WHEN others THEN
      return(0);

  END;

  --Procedimiento para estabelcer el prodcuto y la activdad asocaida a la orden
  PROCEDURE PRORDERACTIVITY(ORDEN     NUMBER,
                            PRODCUTO  OUT NUMBER,
                            ACTIVIDAD OUT NUMBER) IS
    --PRAGMA AUTONOMOUS_TRANSACTION;

    cursor cuorderactivity is
      select ooa.product_id, ooa.activity_id
        from open.Or_Order_Activity ooa
       where ooa.order_id = ORDEN;

    nuPRODCUTO  NUMBER;
    nuACTIVIDAD NUMBER;

  BEGIN

    open cuorderactivity;
    fetch cuorderactivity
      into nuPRODCUTO, nuACTIVIDAD;
    close cuorderactivity;

    PRODCUTO  := nuPRODCUTO;
    ACTIVIDAD := nuACTIVIDAD;

  EXCEPTION
    WHEN others THEN
      PRODCUTO  := 0;
      ACTIVIDAD := 0;

  END;

  --Funcion para establecer si el valor esta definido en el parametro
  FUNCTION FNUDATAREPARACION(InuPRODUCTO NUMBER) RETURN number IS
    --PRAGMA AUTONOMOUS_TRANSACTION;

    cursor cuLDCCONDEFRP is
      select count(1)
        from open.LDC_CONDEFRP LCR
       where LCR.PRODUCTO = InuPRODUCTO;

    NuConteo NUMBER;

  BEGIN

    /*open cuLDCCONDEFRP;
    fetch cuLDCCONDEFRP
      into NuConteo;
    close cuLDCCONDEFRP;*/

    execute immediate 'select count(1) from LDC_CONDEFRP where PRODUCTO = :nuprodcuto'
      into NuConteo
      using InuPRODUCTO;
    --dbms_output.put_line(l_cnt);

    return(NuConteo);

    --DBMS_OUTPUT.put_line('CONTEO --> ' || NuConteo);

  EXCEPTION
    WHEN others THEN
      return(0);

  END;

BEGIN

  ut_trace.trace('Inicio LDC_PRCONDEFRP', 10);

  IF FBLAPLICAENTREGAXCASO('0000836') THEN

    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuorden := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Numero de la Orden:' || nuorden, 10);

    open cuDATAorden(nuorden);
    fetch cuDATAorden
      into nutask_type_id, nucausal_id, nuoperating_unit_id;
    close cuDATAorden;

    VNuExisteTT := FNUEXISTE('COD_TITR_DEF', nutask_type_id);
    --DBMS_OUTPUT.put_line('Tipo de trabajo ' || :new.task_type_id || ' valida para el parametro COD_TITR_DEF --> ' || VNuExisteTT);

    PRORDERACTIVITY(nuorden, VnuPRODCUTO, VnuACTIVIDAD);
    --DBMS_OUTPUT.put_line('PRODCUTO: ' || VnuPRODCUTO);
    --DBMS_OUTPUT.put_line('ITEM: ' || VnuACTIVIDAD);

    --Inicio Logica para estabelcer la unidad opertaiva
    VNuExisteCAUSAL := FNUEXISTE('COD_CAU_DEF', nucausal_id);
    --DBMS_OUTPUT.put_line('Causal de legalizacion ' || :new.causal_id || ' valida para el parametro COD_CAU_DEF --> ' || VNuExisteCAUSAL);
    ut_trace.trace('PRODCUTO: ' || VnuPRODCUTO || ' - ACTIVIDAD: ' ||
                   VnuACTIVIDAD || ' - CAUSAL: ' || nucausal_id,
                   10);

    if nvl(VNuExisteTT, 0) > 0 and nvl(VNuExisteCAUSAL, 0) > 0 then
      --VNuUnidadDefecto := :new.operating_unit_id;
      --DBMS_OUTPUT.put_line('unidad Operativa: ' || :new.operating_unit_id);

      VNuUnidadDefecto := FNUDATAREPARACION(VnuPRODCUTO);

      if nvl(VNuUnidadDefecto, 0) = 0 then
        --DBMS_OUTPUT.put_line('No existe registro para unidad operativa');
        insert into open.LDC_CONDEFRP
          (producto, reparacion, unidad_operativa)
        values
          (VnuPRODCUTO, 1, nuoperating_unit_id);
      else
        --DBMS_OUTPUT.put_line('Actualizo DATA unidad operativa');
        update open.LDC_CONDEFRP LCR
           set LCR.REPARACION = LCR.REPARACION + 1
         where LCR.PRODUCTO = VnuPRODCUTO;
      end if;

    end if;
    --Fin Logica para estabelcer la unidad opertaiva

  END IF;

  ut_trace.trace('Fin LDC_PRCONDEFRP', 10);

end LDC_PRCONDEFRP;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRCONDEFRP', 'ADM_PERSON');
END;
/
