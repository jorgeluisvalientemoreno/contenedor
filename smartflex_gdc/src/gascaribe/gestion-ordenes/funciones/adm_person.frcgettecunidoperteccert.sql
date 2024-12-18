CREATE OR REPLACE FUNCTION adm_person.FRCGETTECUNIDOPERTECCERT
  RETURN constants.tyRefCursor IS
  sbProcessInstance ge_boinstancecontrol.stysbname;
  nuIndex           ge_boInstanceControl.stynuIndex;
  rcResult          constants.tyrefcursor;
  sbtecunidadoper   VARCHAR2(1000);
  nutecunidadoper   ge_person.person_id%TYPE;
  Unit_Opera        number; --se adiciona para filtrar por unidad operativo
  Unit_Opera_       varchar2(4000); --se adiciona para filtrar por unidad operativo

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : frcGettecunidoperteccert
    Descripcion    : Funcion para obtener el conjunto de registros para la forma ODTCI
    Autor          :
    Fecha          :

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
	08-01-2014     Sayra Ocoro       Se modifica la consulta del cursor para que obtenga registros unicos, y para
                                     que proyecte las colunas que se obtienen con la <<funcion frcGetunidoperteccert>>
                                     (Servicio de consulta de OATCI) => Soluciona NC 2295
    08/07/2015	   Samuel Pacheco	 Se modifica proceso para que tenga encuenta filtro por unidad de trabajo ara 8183
	02/01/2024	cgonzalez	OSF-2095: Migrar del esquema OPEN al esquema ADM_PERSON
  ******************************************************************/

BEGIN
  ge_boinstancecontrol.GetCurrentInstance(sbProcessInstance);
  -- se obtiene el valor de la instancia si existe
  IF ge_boinstancecontrol.fblAcckeyAttributeStack(sbProcessInstance,
                                                  Null,
                                                  'LDC_ASIG_OT_TECN',
                                                  'TECNICO_UNIDAD',
                                                  nuIndex) THEN
    GE_BOInstanceControl.GetAttributeNewValue(sbProcessInstance,
                                              null,
                                              'LDC_ASIG_OT_TECN',
                                              'TECNICO_UNIDAD',
                                              sbtecunidadoper);
    -- Se obtiene el valor varchar de la linea de negocio
    pkg_traza.Trace(sbtecunidadoper, 1);
    -- Se obtiene el valor numerico del id de la orden
    nutecunidadoper := to_number(trim(sbtecunidadoper));

    --unidad operativa
    GE_BOInstanceControl.GetAttributeNewValue(sbProcessInstance,
                                              null,
                                              'LDC_ASIG_OT_TECN',
                                              'UNIDAD_OPERATIVA',
                                              Unit_Opera_);
    -- Se obtiene el valor varchar de la linea de negocio
    pkg_traza.Trace(Unit_Opera_, 1);
    -- Se obtiene el valor numerico del id de la orden
    Unit_Opera := to_number(trim(Unit_Opera_));

  END IF;

  OPEN rcResult FOR
    SELECT distinct l.orden orden,
                    o.task_type_id || ' - ' ||
                    daor_task_type.fsbgetdescription(o.task_type_id) tipo_trabajo,
                    o.assigned_date fecha_asignacion,
                    a.package_id solicitud,
                    p.SUBSCRIPTION_ID contrato,
                    p.product_id producto,
                    cl.subscriber_name || ' ' || cl.subs_last_name || ' ' ||
                    cl.subs_second_last_name nombre_cliente,
                    se.operating_sector_id || ' - ' || so.description sector_operativo,
                    d.address_parsed direccion,
                    u.operating_unit_id || ' - ' || u.name unidad_operativa

      FROM ldc_asig_ot_tecn         l,
           or_order                 o,
           or_operating_unit        u,
           or_order_activity        a,
           pr_product               p,
           ab_address               d,
           open.ge_subscriber       cl,
           open.mo_packages         mp,
           open.or_operating_sector so,
           open.ab_segments         se
     WHERE l.tecnico_unidad = nutecunidadoper
       AND o.order_status_id =
           dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT',
                                              NULL)
       AND l.unidad_operativa = u.operating_unit_id
       AND l.orden = o.order_id
       AND l.orden = a.order_id
       AND a.product_id = p.product_id
       AND p.address_id = d.address_id
          --
       and mp.subscriber_id = cl.subscriber_id
       AND a.package_id = mp.package_id

       AND p.address_id = d.address_id
       AND d.segment_id = se.segments_id
       AND se.operating_sector_id = so.operating_sector_id
       AND u.operating_unit_id = Unit_Opera
    --
     ORDER BY l.orden;
  return rcResult;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FRCGETTECUNIDOPERTECCERT', 'ADM_PERSON');
END;
/