declare

  InuOrden              number := 273856219; --275457678;
  InuOrden_actividad    number;
  InuTipoTrabajo        number;
  InuCausalLegalizacion number := 9265;
  nuerrorcode           number;
  sbERROR               varchar2(4000);

  CADENALEGALIZACION varchar2(4000) := null;

  cursor cudatoadicional is
    select b.name_attribute name_attribute, null value
      from ge_attributes b, ge_attrib_set_attrib a
     where b.attribute_id = a.attribute_id
       and a.attribute_set_id in
           (select ottd.attribute_set_id
              from or_tasktype_add_data ottd
             where ottd.task_type_id =
                   (select oo.task_type_id
                      from open.or_order oo
                     where oo.order_id = InuOrden) --InuTipoTrabajo
               and ottd.active = 'Y'
               and (SELECT count(1) cantidad
                      FROM DUAL
                     WHERE dage_causal.fnugetclass_causal_id( /*(select oo.causal_id
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               from open.or_order oo
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              where oo.order_id =
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    InuOrden), --*/InuCausalLegalizacion,
                                                             NULL) IN
                           (select column_value
                              from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CLASS_CAUSAL_LEGO',
                                                                                                       NULL),
                                                                      ',')))) = 1
                  --/*
                  --CASO 200-1932
                  --and (ottd.use_ = decode(dage_causal.fnugetcausal_type_id(v_causal_id,null),
               and (ottd.use_ = decode(DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID( /*(select oo.causal_id
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           from open.or_order oo
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          where oo.order_id =
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                InuOrden), --*/InuCausalLegalizacion,
                                                                         null),
                                       1,
                                       'C',
                                       2,
                                       'I') or ottd.use_ = 'B') --*/
            )
    --and a.mandatory = 'Y'            
     order by a.attribute_set_id, a.attribute_id;

  rfcudatoadicional cudatoadicional%rowtype;

  SBDATOSADICIONALES VARCHAR2(4000);

  Actividad        number;
  Contrato         number;
  Producto         number;
  Solicitud        number;
  Unidad_Operativa NUMBER;
  Ciclo            number;
  certificado      varchar2(4000);
  tipotrabajo      number;

BEGIN

  /*ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);*/

  ut_trace.trace('INICIO LDC_PKSOLICITUDINTERACCION.fsbcadenalegalizada',
                 10);

  -- Llama el API de lagalizacion de Ordenes

  ---Inicio Datos Adicionales--------------------
  --cadena datos adicionales
  --SBDATOSADICIONALES := ';;;;';

  for rfcudatoadicional in cudatoadicional loop
    IF SBDATOSADICIONALES IS NULL THEN
      SBDATOSADICIONALES := rfcudatoadicional.NAME_ATTRIBUTE || '=' ||
                            rfcudatoadicional.Value;
    ELSE
      SBDATOSADICIONALES := SBDATOSADICIONALES || ';' ||
                            rfcudatoadicional.NAME_ATTRIBUTE || '=' ||
                            rfcudatoadicional.Value;
    END IF;
  end loop;
  dbms_output.put_line('SBDATOSADICIONALES  => ' || SBDATOSADICIONALES);
  --fin cadena datos adicionales   

  ---Fin Datos Adicionales-----------------------------  
  /*select oo.causal_id
   INTO InuCausalLegalizacion
   from open.or_order oo
  where oo.order_id = InuOrden;*/

  begin
  
    select ooa.order_activity_id,
           ooa.subscription_id,
           ooa.product_id,
           ooa.package_id,
           ooa.operating_unit_id,
           (select s.susccicl
              from suscripc s
             where s.susccodi = ooa.subscription_id),
           oo.task_type_id,
           oo.operating_unit_id
      into InuOrden_actividad,
           Contrato,
           Producto,
           Solicitud,
           Unidad_Operativa,
           Ciclo,
           tipotrabajo,
           Unidad_Operativa
      from open.Or_Order_Activity ooa, or_order oo
     where ooa.order_id = InuOrden
       and ooa.order_id = oo.order_id;
  
    update LDC_CERTIFICADOS_OIA t
       set ID_CONTRATO = Contrato,
           ID_PRODUCTO = Producto,
           PACKAGE_ID  = Solicitud,
           ORDER_ID    = InuOrden
     WHERE t.certificados_oia_id = 10;
  
    select t.certificado, ID_CONTRATO, ID_PRODUCTO, PACKAGE_ID
      into certificado, Contrato, Producto, Solicitud
      from LDC_CERTIFICADOS_OIA t
     WHERE t.certificados_oia_id = 10;
    commit;
  end;

  dbms_output.put_line('inuorderid  => ' || InuOrden);
  dbms_output.put_line('inucausalid => ' || InuCausalLegalizacion);
  dbms_output.put_line('inupersonid => ' || ge_bopersonal.fnuGetPersonId);
  dbms_output.put_line('idtchangedate => null');

  SELECT (InuOrden || '|' || InuCausalLegalizacion || '|' ||
         ge_bopersonal.fnuGetPersonId || '|' || SBDATOSADICIONALES || '|' ||
         A.ORDER_ACTIVITY_ID || '>' ||
         decode(nvl(dage_causal.fnugetclass_causal_id(InuCausalLegalizacion,
                                                       null),
                     0),
                 1,
                 1,
                 0) || ';;;;' || '|' || NULL || '|' || NULL || '|1277;' ||
         'Legalizacion PLUGIN LUDYORDEN')
    INTO CADENALEGALIZACION
    FROM OPEN.OR_ORDER O, OPEN.OR_ORDER_ACTIVITY A
   WHERE O.ORDER_ID = A.ORDER_ID
     AND O.ORDER_ID = InuOrden
     AND ROWNUM = 1;

  DBMS_OUTPUT.put_line('CERTIFICADO[' || certificado || '], ICONTRATO[' ||
                       CONTRATO || '], PRODUCTO[' || PRODUCTO ||
                       '], Solicitud[' || Solicitud || '], Tipo Trabajo[' ||
                       tipotrabajo || '],
           Unidad Operativa[' || Unidad_Operativa || ']');

  --dbms_output.put_line('257706463|9265|20746|COD_UNIDAD_APOYO=;VAL_CERTIFICADO=78259778;NUM_CUOTAS_DIFERIDO=48;LDC_LECTTOMSUSP=864|249744008>1;;;;|||1277;red conforme');
  --CADENALEGALIZACION := '277241142|9265|1|VAL_CERTIFICADO=13910;LDC_LECTTOMSUSP=0;COD_UNIDAD_APOYO=;NUM_CUOTAS_DIFERIDO=;DEFECTO_EN_CDM_RP=SI;DEF_CDM_DESCRIPCION=|269517983>1;;;;|||1277;Legalizacion desde JOB - LDC_PRJOBADMORDSOLINT';
  if tipotrabajo = 10795 then
    CADENALEGALIZACION := InuOrden || '|9265|1|VAL_CERTIFICADO=' ||
                          certificado ||
                          ';LDC_LECTTOMSUSP=0;DEFECTO_EN_CDM_RP=SI;DEF_CDM_DESCRIPCION=PRUEBA DANO ENCONTRATO CON OBSERVACION|' ||
                          InuOrden_actividad ||
                          '>1;;;;|||1277;Legalizacion PLUGIN Objeto Accion';
    dbms_output.put_line(CADENALEGALIZACION);
  else
    if tipotrabajo = 10444 then
      CADENALEGALIZACION := InuOrden || '|9265|1|VAL_CERTIFICADO=' ||
                            certificado ||
                            ';LDC_LECTTOMSUSP=0;COD_UNIDAD_APOYO=;NUM_CUOTAS_DIFERIDO=;DEFECTO_EN_CDM_RP=SI;DEF_CDM_DESCRIPCION=PRUEBA DANO ENCONTRATO CON OBSERVACION|' ||
                            InuOrden_actividad ||
                            '>1;;;;|||1277;Legalizacion PLUGIN Objeto Accion';
      dbms_output.put_line(CADENALEGALIZACION);
    end if;
  end if;

  update LDCI_ORDENESALEGALIZAR t
     set t.dataorder = CADENALEGALIZACION, t.state = 'P'
   WHERE T.ORDER_ID = InuOrden;
  commit;

  /*
  api_legalizeorders(CADENALEGALIZACION,
                     sysdate,
                     sysdate,
                     sysdate,
                     nuerrorcode,
                     sbERROR);
  --*/

  dbms_output.put_line('onuerrorcode => ' || nuerrorcode);
  dbms_output.put_line('osberrormessage => ' || sbERROR);

  if nuerrorcode <> 0 then
    rollback;
  end if;

  ut_trace.trace('FIN LDC_PKSOLICITUDINTERACCION.fsbcadenalegalizada', 10);

end;
