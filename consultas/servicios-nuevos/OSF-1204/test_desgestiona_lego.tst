PL/SQL Developer Test script 3.0
66
DECLARE

    cursor cudesgestionarOT is
      select distinct lol.order_id Orden
        from ldc_otlegalizar lol, or_order_activity ooa
       where lol.legalizado = 'N'
            --and lol.task_type_id =
            --    decode(&inuTipoTrab, -1, lol.task_type_id, &inuTipoTrab)
            --and trunc(lol.fecha_registro) >= trunc(to_date(&idtDesde))
            --and trunc(lol.fecha_registro) <= trunc(to_date(&idtHasta))
         and lol.order_id = ooa.order_id
         AND LOL.ORDER_ID=265498481;

    rfcudesgestionarOT cudesgestionarOT%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_PKGESTIONORDENES.PrDesgestionarOT', 10);

    for rfcudesgestionarOT in cudesgestionarOT loop

      ut_trace.trace('Orden a desgestionar [' || rfcudesgestionarOT.Orden || ']',
                     10);
      dbms_output.put_line('Orden a desgestionar [' ||
                           rfcudesgestionarOT.Orden || ']');

      /*
      delete from ldc_otlegalizar t
       where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otadicional t
       where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otdalegalizar t
       where order_id = rfcudesgestionarOT.Orden;
      delete from LDC_ANEXOLEGALIZA t
       where order_id = rfcudesgestionarOT.Orden;
       */

      delete from ldc_otlegalizar t
       where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otadicional t
       where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otdalegalizar t
       where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otadicionalda t
       where order_id = rfcudesgestionarOT.Orden;
      delete from LDC_ANEXOLEGALIZA t
       where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otitem t where order_id = rfcudesgestionarOT.Orden;
      delete from ldc_otdatoactividad t
       where order_id = rfcudesgestionarOT.Orden;
      delete from LDC_DATOACTIVIDADOTADICIONAL t
       where order_id = rfcudesgestionarOT.Orden;

    end loop;

    commit;

    ut_trace.trace('Fin LDC_PKGESTIONORDENES.PrDesgestionarOT', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END;
0
0
