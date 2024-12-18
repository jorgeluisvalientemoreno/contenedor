CREATE OR REPLACE PACKAGE adm_person.ldc_bopoliticasldc IS

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  24/06/2024   Adrianavg   OSF-2849: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
--{
    --------------------------------------------
    -- Constantes
    --------------------------------------------

    --------------------------------------------
    -- Variables
    --------------------------------------------

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    ------------------------------
    -- fnuVisualizarOT
    ------------------------------
    FUNCTION fnuVisualizarOT(inuOrderId in OR_order.order_id%type, inuOperatingUnitId   OR_order.operating_unit_id%type  )
    RETURN OR_order.order_id%type;

    FUNCTION fnuVisualizaConciliacion(nuDocusoreId in docusore.DOSRCODI%type, inuBanco in docusore.DOSRBANC%type )
    RETURN docusore.DOSRCODI%type;

    FUNCTION fnuVisualizarArea(inuOrganizat_area_id in ge_organizat_area.organizat_area_id%type )
    RETURN ge_organizat_area.organizat_area_id%type;

     FUNCTION fnuVisualizaER(inuBANCTIER in banco.BANCTIER%type)
    RETURN banco.BANCTIER%type;

    FUNCTION fnuRepBrillaPot1581(nusubscription_id in suscripc.susccodi%type)
    RETURN or_order_activity.order_activity_id%type;

    FUNCTION fnuOrdenesOrgos(inuOrden_id or_order.order_id%type, inuTaskType_id or_order.task_type_id%type)
    RETURN or_order.order_id%type;

END LDC_BOPoliticasLDC;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BOPoliticasLDC AS

    --------------------------------------------
    -- Constantes
    --------------------------------------------

    --------------------------------------------
    -- Variables
    --------------------------------------------

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    FUNCTION fnuVisualizarOT(inuOrderId in OR_order.order_id%type, inuOperatingUnitId   OR_order.operating_unit_id%type )
    RETURN OR_order.order_id%type
    IS

        CURSOR cuUnidadOperativa( inuIDPersona number, inuIDUnidad number)
        IS
        select count(*) from OPEN.OR_OPER_UNIT_PERSONS a
        where A.PERSON_ID = inuIDPersona
          and A.OPERATING_UNIT_ID = inuIDUnidad;

        nuCodUnidad         or_order.operating_unit_id%type;
        nuCodUsuario        ge_person.user_id%type;
        nuCodPersona        ge_person.person_id%type;

        nuExiste number;
                               nombre_instancia        varchar2(4000);


    BEGIN

       if inuOperatingUnitId is not null then   -- Si el parametro de entrada es nulo (cuanndo la orden se encuentra en un estado el cual no tiene aun una unidad asignada)

        -- Se obtiene la U.O de la Orden
        nuCodUnidad := inuOperatingUnitId;

        -- Se obtiene el usuario conectado
        nuCodUsuario := SA_BOUser.fnuGetUserId;

        -- Se obtiene la persona asociada al usuario conectado
        nuCodPersona := GE_BCPerson.fnuGetFirstPersonByUserId(nuCodUsuario);

        --nombre_instancia := ut_session.getmodule;

              if nuCodUsuario <> 1 THEN  -- Si es diferente al usuario OPEN
                 open cuUnidadOperativa( nuCodPersona, nuCodUnidad);
                 fetch cuUnidadOperativa INTO nuExiste;
                 close cuUnidadOperativa;

                 if nuExiste > 0 then
                    return inuOrderId;
                 else
                    return -1;
                 end if;
              end if;

       end if;

      return inuOrderId;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


FUNCTION fnuVisualizaConciliacion(nuDocusoreId in docusore.DOSRCODI%type, inuBanco in docusore.DOSRBANC%type )
    RETURN docusore.DOSRCODI%type
    IS

       --1. Cursor para obtener las conciliaciones asociadas a entidades de recaudo
       --financieras que no han sido legalizadas
        cursor cuBanco (inuDocusoreId in docusore.DOSRCODI%type, inuBanco in docusore.DOSRBANC%type ) is
            select count(*)
            from banco
            where banco.BANCCODI = inuBanco
            and banco.BANCTIER = 1;
            --and DOSRCODI not in (select distinct nvl(TBDSDOSR,-1) from trbadosr)
            --and DOSRCODI = inuDocusoreId;

        CURSOR cuTransaccion(nuDocusoreId in docusore.DOSRCODI%type)
        IS
        SELECT count(*)
        FROM trbadosr
        WHERE trbadosr.TBDSDOSR = nuDocusoreId;

        nuExisteBanco           number := 0;
        nuExisteTransaccion     number := 0;
        nombre_instancia        varchar2(4000);


    BEGIN

     -- Obtiene el nombre de la APP que actualmente se est? ejecutando en Smartflex
        nombre_instancia := ut_session.getmodule;

       -- ut_trace.trace('************ Politica fnuVisualizaConciliacion nombre_instancia:['||nombre_instancia||']',1);

        if nombre_instancia = 'FREC' then
                  open cuBanco (nuDocusoreId,inuBanco);
                  fetch cuBanco INTO nuExisteBanco;
                  close cuBanco;

                  if (nuExisteBanco > 0) then

                      open cuTransaccion (nuDocusoreId);
                      fetch cuTransaccion INTO nuExisteTransaccion;
                      close cuTransaccion;

                      if (nuExisteTransaccion = 0) then
                          return -1;
                      else
                          return nuDocusoreId;
                      END if;

                  END if;
         end if;
         return nuDocusoreId;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuVisualizaConciliacion;


    -- LLOZADA
    FUNCTION fnuVisualizarArea(inuOrganizat_area_id in ge_organizat_area.organizat_area_id%type )
    RETURN ge_organizat_area.organizat_area_id%type
    IS
        CURSOR cuUnidadOperativa( inuIDPersona number)
        IS
            select count(1)
            from OPEN.OR_OPER_UNIT_PERSONS a
            where A.PERSON_ID = inuIDPersona
            AND a.operating_unit_id = dage_parameter.fsbgetvalue('AREA_TO_RETURN_ORDER');

        --CURSOR cuUnidadesHijas( inuIDPersona number)
        --IS
         --   SELECT count(1)
          --  FROM OR_OPER_UNIT_PERSONS
           -- WHERE operating_unit_id in ()

            /*SELECT count(1)
            FROM or_operating_unit
            WHERE operating_unit_id = inuOrganizat_area_id
            AND father_oper_unit_id in (select operating_unit_id
                                          FROM OR_OPER_UNIT_PERSONS
                                          WHERE PERSON_ID = inuIDPersona);*/

        nuCodUsuario        ge_person.user_id%type;
        nuCodPersona        ge_person.person_id%type;
        nombre_instancia     varchar2(4000);

        sbExecutable sa_executable.name%type;
        nuExiste number := 0;


    BEGIN
        --ut_trace.init;
        --ut_trace.setlevel(99);
        --ut_trace.setoutput(ut_trace.fntrace_output_db);

        -- Obtiene el nombre de la APP que actualmente se est? ejecutando en Smartflex
        nombre_instancia := ut_session.getmodule;

        --ut_trace.trace('************ Politica LLOZADA nombre_instancia_:['||nombre_instancia||']',1);
        -- Se obtiene el usuario conectado
        nuCodUsuario := SA_BOUser.fnuGetUserId;

        --ut_trace.trace('Politica LLOZADA nuCodUsuario:['||nuCodUsuario||']',2);

        -- Se obtiene la persona asociada al usuario conectado
        nuCodPersona := GE_BCPerson.fnuGetFirstPersonByUserId(nuCodUsuario);

        --ut_trace.trace('Politica LLOZADA nuCodPersona:['||nuCodPersona||']',2);

        if nombre_instancia = 'ORGO_' then
            open cuUnidadOperativa( nuCodPersona);
            fetch cuUnidadOperativa INTO nuExiste;
            close cuUnidadOperativa;

            if nuExiste = 0 then
                return -1;
           end if;
        END if;

        return inuOrganizat_area_id;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuVisualizarArea;

    -- LLOZADA
    FUNCTION fnuOrdenesOrgos(inuOrden_id or_order.order_id%type, inuTaskType_id or_order.task_type_id%type)
    RETURN or_order.order_id%type
    IS
        CURSOR cuUnidadOperativa( inuIDPersona number)
        IS
            select count(1)
            from OPEN.OR_OPER_UNIT_PERSONS a
            where A.PERSON_ID = inuIDPersona
            AND a.operating_unit_id = dage_parameter.fsbgetvalue('LDC_PERSONA_LEGALIZA');

        /*CURSOR cuUnidadesHijas( inuIDPersona number)
        IS
            SELECT count(1)
            FROM or_operating_unit
            WHERE operating_unit_id = inuOrganizat_area_id
            AND father_oper_unit_id in (select operating_unit_id
                                          FROM OR_OPER_UNIT_PERSONS
                                          WHERE PERSON_ID = inuIDPersona); */

        nuCodUsuario        ge_person.user_id%type;
        nuCodPersona        ge_person.person_id%type;
        nombre_instancia     varchar2(4000);

        nuExiste number := 0;


    BEGIN
        --ut_trace.init;
        --ut_trace.setlevel(99);
        --ut_trace.setoutput(ut_trace.fntrace_output_db);

        -- Obtiene el nombre de la APP que actualmente se est? ejecutando en Smartflex
        nombre_instancia := ut_session.getmodule;

        --ut_trace.trace('************ Politica ORGOS-ORDEN LLOZADA nombre_instancia:['||nombre_instancia||']',1);

        -- Se obtiene el usuario conectado
        nuCodUsuario := SA_BOUser.fnuGetUserId;

        --ut_trace.trace('Politica ORGOS-ORDEN LLOZADA nuCodUsuario:['||nuCodUsuario||']',2);

        -- Se obtiene la persona asociada al usuario conectado
        nuCodPersona := GE_BCPerson.fnuGetFirstPersonByUserId(nuCodUsuario);

        --ut_trace.trace('Politica ORGOS-ORDEN LLOZADA nuCodPersona:['||nuCodPersona||']',2);

        if nombre_instancia = 'ORGOS' then
            for rc in (SELECT column_value
                from table (ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('LDC_PERSONA_LEGALIZA'),'|')))
                loop
                    if nuCodPersona = rc.column_value then
                        --ut_trace.trace('Politica ORGOS-ORDEN LLOZADA ENTRA A DEVOLVER LA ORDEN',2);
                        return inuOrden_id;
                    END if;
                END loop;

                if inuTaskType_id = 10002 then
                    return -1;
                else
                    return inuOrden_id;
                END if;
        else
           return inuOrden_id;
        END if;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuOrdenesOrgos;

    FUNCTION fnuVisualizaER(inuBANCTIER in banco.BANCTIER%type)
    RETURN banco.BANCTIER%type
        IS
        sbNombreModulo        varchar2(4000) := null;
        sbNombreAccion        varchar2(4000) := null;
    BEGIN

     -- Obtiene el nombre de la APP que actualmente se est? ejecutando en Smartflex
        --sbNombreModulo := ut_session.getmodule();
        ut_session.getmodule(sbNombreModulo,sbNombreAccion);

        --ut_trace.trace('************ Politica fnuVisualizaER nombre_instancia:['||sbNombreModulo||']',1);
        if  sbNombreModulo = 'FREC'  then
                  if inuBANCTIER = 1 then
                      return -1;
                  else
                      return inuBANCTIER;
                  end if;
        end if;
        return inuBANCTIER;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuVisualizaER;

    --Jsoto   20140119
    --Politica para ejeucion de reporte potenciales de brilla
    --LLOZADA 21072014: Se usa esta politica para restringir la data de los ruteros
FUNCTION fnuRepBrillaPot1581(nusubscription_id in suscripc.susccodi%type)
    RETURN or_order_activity.order_activity_id%type
    IS

       CURSOR culdc_proteccion_datos
       is
            select id_cliente
            from ldc_proteccion_datos
            where id_cliente = nusubscription_id
            and estado = 'S'
            and cod_estado_ley = 1;

        nuExisteReg             number := 0;
        nombre_instancia        varchar2(4000);
        sbExecutable sa_executable.name%type;
        nuSubscriber_id  suscripc.susccodi%type;
        nuCodUsuario        ge_person.user_id%type;
        nuCodPersona        ge_person.person_id%type;

    BEGIN
        --ut_trace.init;
        --ut_trace.setlevel(99);
        --ut_trace.setoutput(ut_trace.fntrace_output_db);
        -- Se obtiene el usuario conectado
        nuCodUsuario := SA_BOUser.fnuGetUserId;

        --ut_trace.trace('Politica LLOZADA nuCodUsuario:['||nuCodUsuario||']',2);

        -- Se obtiene la persona asociada al usuario conectado
        nuCodPersona := GE_BCPerson.fnuGetFirstPersonByUserId(nuCodUsuario);

        --nuSubscriber_id := PKTBLSUSCRIPC.fnugetsuscclie(nusubscription_id);

        --ut_trace.trace('************ Politica fnuRepBrillaPot1581 sbExecutable:['||sbExecutable||']',10);
        --ut_trace.trace('************ Politica fnuRepBrillaPot1581 nombre_instancia:['||nombre_instancia||']',10);

        for rc in (SELECT column_value
                from table (ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('LDC_USUARIOS_FNB'),'|')))
        loop
            if nuCodPersona = rc.column_value  then
                return nusubscription_id;
            end if;
        END loop;

        --open culdc_proteccion_datos;
        --fetch culdc_proteccion_datos INTO nuExisteReg;
        --close culdc_proteccion_datos;

        --if nuExisteReg IS not null then
       --     return nusubscription_id;
       -- else
            return -1;
       -- END if;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuRepBrillaPot1581;


END LDC_BOPoliticasLDC;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_BOPOLITICASLDC
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOPOLITICASLDC', 'ADM_PERSON'); 
END;
/