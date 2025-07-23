create or replace PACKAGE LDC_BCSALESCOMMISSION is

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : LDC_BCSalesCommission
  Descripcion    : Paquete donde se implementa la lógica para la generación de multas
     para procesos del área de ventas
  Autor          : Sayra Ocoro
  Fecha          : 08/03/2013

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             Autor               Modificacion
  =========         =========           ====================
  14-03-2023        Luis Valencia       OSF-882: Se modifica la función fnuGetPackagesVR
  18-06-2025        Lubin Pineda        OSF-4555: 
                                        * Se corrigen tildes
                                        * Se usa pkg_Trace
                                        * Se borra csbNitSurtigas.
                                        * Se ajusta PrGenerateCommission
  ******************************************************************/

  TYPE RgCommissionRegister IS RECORD(
    onuCommissionValue mo_gas_sale_data.TOTAL_VALUE%type,
    sbIsZone           ldc_info_predio.is_zona%type);

  /*----------------------------------------------------------------
  |                 Variables Globales                              |
  ------------------------------------------------------------------*/

  nuActCIVZNR LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZNR');
  nuActCIVZSR LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZSR');
  nuActCIVZNC LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZNC');
  nuActCIVZSC LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZSC');
  nuActMZR    LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_MULTA_VENTA_OTRA_ZONA_RESID');
  nuActMZC    LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_MULTA_VENTA_OTRA_ZONA_COMM');

  nuRange     number := pkg_BCLD_Parameter.fnuObtieneValorNumerico('RANGO_COMISIONES_VENTA');
  nuActCLVZNR LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZNR');
  nuActCLVZSR LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZSR');
  nuActCLVZNC LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZNC');
  nuActCLVZSC LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZSC');

  nuPkgAtendido ps_package_type.package_type_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_ESTADO_PKG_ATENDTIDO');
  nuPkgAnulado  ps_package_type.package_type_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_ESTADO_PKG_ANULADA');
  
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuGetCommissionValue
  Descripcion    : Función que retorna el valor de la comisión de venta al inicio de acuerdo a la
     configuración realizada en la forma CTCVE.
  Autor          : Sayra Ocoro
  Fecha          : 08/03/2013

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  ******************************************************************/
  function FnuGetCommissionValue(isbTime          IN varchar2,
                                 inuPackageId     IN mo_packages.package_id%type,
                                 inuAddressId     IN ab_address.address_id%type,
                                 inuProductid     IN pr_product.product_id%Type,
                                 inuOperatingUnit IN or_operating_unit.operating_unit_id%type)
    return RgCommissionRegister;
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrGenerateCommission
    Descripcion    : Procedimiento para generar comisiones por ventas al registro de la solicitud
    Autor          : Sayra Ocoro
    Fecha          : 08/03/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  26/09/2013        emirol            se modifico toda la logica del paquete
    ******************************************************************/
  procedure PrGenerateCommission;
  procedure PrGenerateCommission_Hilos (indtToday date, 
                                        indtBegin date, 
                                        insbPackagesType varchar2,
                                        innuNroHilo number,
                                        innuTotHilos number,
                                        innusesion number);
  procedure pro_grabalog_comision (inusesion number, idtfecha date, inuhilo number, 
                                 inuresult number, isbobse varchar2);                                        

  PROCEDURE ProcessGOPCV;
  /*Función que devuelve la versión del pkg*/
  FUNCTION fsbVersion RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetPackagesVR
  Descripcion    : Función que valida si una solicitud pertence a un tipo de paquete que tiene asociada unas ot
                   en estado 7 u 8. Se usa en condición de visualización solicitada en la NC 2046
  Autor          : Sayra Ocoro
  Fecha          : 05/12/2013

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  14/03/2023        Luis Valencia       OSF-882   Se modifica para validar si la solicitud
                                                  fue aprobada para anulación cuando
                                                  tiene ordenes legalizadas con causal de exito
  ******************************************************************/

  function fnuGetPackagesVR(inuPackagesId in mo_packages.package_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de PETI.
  Unidad         : LDC_FNUGETVLRVENTA
  Descripcion    : funcion que retorna el valor de la ventas antes de aplicar el iva para efectos de liquidar la comision
                 cuando esta es por porcentaje
                   Aranda caso numero 3038
  Autor          : Emiro Leyva
  Fecha          : 05/03/2014

   Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  function LDC_FNUGETVLRVENTA(isbCargdoso in cargos.cargdoso%type)
    return NUMBER;

end LDC_BCSalesCommission;
/

create or replace PACKAGE BODY LDC_BCSALESCOMMISSION is

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    /*Variable global*/
    CSBVERSION CONSTANT varchar2(40) := 'OSF-4555';

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCSalesCommission
    Descripcion    : Paquete donde se implementa la lógica para la generación de multas
                     para procesos del área de ventas
    Autor          : Sayra Ocoro
    Fecha          : 08/03/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    06-11-2013      Sayra Ocoró       Se modifica el método PrGenerateCommision para que las ordenes
                                      de comisión generadas como comisiones sean vistas desde el proceso
                                      de liquidación a contratistas -> Soluciona NC 1749
   05-12-2013       Sayra Ocoró       Se adiciona la función fnuGetPackagesVR para solucionar la NC 2046
   06-03-2014       Emiro Leyva       Aranda 3038 (Debe corregirse para que tome sólo el valor de la venta antes de IVA.).
                                       Solucion: se busca el valor de la venta en la tabla cargos de todos los
                                       conceptos de la venta atravez de la funcion LDC_FNUGETVLRVENTA, recibe
                                       como parametro 'PP-' concatenado con el numero de la solicitud de la venta.
   01-04-2014      Sayra Ocoró        Aranda 3275:Se deben actualizar correctamente la dirección (Address_id)
                                       de la venta en los campos "External_address_id" de la entidad OR_ORDER y
                                       "Address_id" de la entidad OR_ORDER_ACTIVITY.
   20-01-2015      Gabriel Gamarra    NC 3968: Se modifica el método PrGenerateCommision.
                                      Se añade validacion para que no procese las solicitudes del tipo
                                      100271 - Venta de Gas Formulario Migracion en la etapa de registro.
   05-02-2016      Francisco Castro  Caso 100.7353: Se implementa funcionalidad para ejecutar el proceso
                                     por hilos                                      
   14-03-2023      Luis Valencia      OSF-882: Se modifica la función LDC_BCSALESCOMMISSION.fnuGetPackagesVR
  ******************************************************************/

  function LDC_FNUGETVLRVENTA(isbCargdoso in cargos.cargdoso%type)
    return number is

    /*****************************************************************
    Propiedad intelectual de PETI.
    Unidad         : LDC_FNUGETVLRVENTA
    Descripcion    : funcion que retorna el valor de la ventas antes de aplicar el iva para efectos de liquidar la comision
                   cuando esta es por porcentaje
                     Aranda caso numero 3038
    Autor          : Emiro Leyva
    Fecha          : 05/03/2014

     Parametros              Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    19/09/2014      agordillo           Se modifica una condicion del cursor cuCargos,
                                        antes:  AND CARGCONC <> 287
                                        despues:  AND CARGCONC in (valores del parametro COD_CONC_VTA_LIQ_COMISIONES)
                                        Se cambia dado que se evidencio que pueden varias los conceptos que se quieren tomar
                                        en la liquidacion de comiciones, adicional con la resolucion 059 se liquida un concepto de iva mas
                                        se cambia para que se tome desde un parametro los conceptos que se tomarian como
                                        base de liquidacion de la comision.

    ******************************************************************/

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'LDC_FNUGETVLRVENTA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
    
        cursor cuCargos(sbCargdoso in cargos.cargdoso%type) is
          select nvl(SUM(NVL(CARGVALO, 0)), 0)
            from cargos
           where cargdoso = sbCargdoso
             AND CARGSIGN = 'DB'
             AND CARGCONC in
                 (SELECT column_value
                    from table(ldc_boutilities.SPLITstrings(pkg_BCLD_Parameter.fsbObtieneValorCadena('COD_CONC_VTA_LIQ_COMISIONES'),
                                                            ',')));

        nuCargvalo cargos.cargvalo%type;
        
    begin

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        open cuCargos(isbCargdoso);
        fetch cuCargos INTO nuCargvalo;
        close cuCargos;

        pkg_Traza.Trace('LDC_FNUGETVLRVENTA valor de la venta ' || nuCargvalo,
                       10);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
        return nuCargvalo;

    end LDC_FNUGETVLRVENTA;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrGenerateCommission
    Descripcion    : Procedimiento para generar comisiones por ventas al registro de la solicitud
    Autor          : Sayra Ocoro
    Fecha          : 08/03/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    06-11-2013      Sayra Ocoró        Se modifica el método PrGenerateCommision para que las ordenes
                                        de comisión generadas como comisiones sean vistas desde el proceso
                                        de liquidación a contratistas
    19-01-2014      Sayra Ocoró        Se adiciona búsqueda de la orden de referencia para la novedad para
                                      solucionar la NC 2561.
                                      Se modifica filtro para no multar doble.
    20-02-2014     Sayra Ocoró        Aranda 89871 : Se modifica lógica para manejo de errores
    21-02-2014     Sayra Ocoró        Aranda 2877:  Se modifican los parámetros que se envían al apli para
                                     registro de novedades OS_REGISTERNEWCHARGE
    06-03-2014     Emiro Leyva        aranda 3038 (Debe corregirse para que tome sólo el valor de la venta antes de IVA.).
                                     Solucion: se busca el valor de la venta en la tabla cargos de todos los
                                     conceptos de la venta atravez de la funcion LDC_FNUGETVLRVENTA, recibe
                                     como parametro 'PP-' concatenado con el numero de la solicitud de la venta.
    25-03-2014     Jorge Valiente     ARANDA 3224: Se colocaron validaciones para identificar cuando las varibales
                                                  con datos provenientes de servicios de 1er nivel tiene dato NULO.
    01-04-2014      Sayra Ocoró       Aranda 3275:Se deben actualizar correctamente la dirección (Address_id)
                                       de la venta en los campos "External_address_id" de la entidad OR_ORDER y
                                       "Address_id" de la entidad OR_ORDER_ACTIVITY.
    10-04-2014      Sayra Ocoró       Aranda 3275_2:Se ajusta la solución para que actualice los campos OPERATING_SECTOR_ID
                                              y GEOGRAP_LOCATION_ID de la tabla OR_ORDER y también el campo
                                               OPERATING_SECTOR_ID  de la tabla OR_ORDER_ACTIVITY.
    16-04-2014    Sayra Ocoró         Aranda 3420: Se corrige mensage de generación.
    08-09-2014      oparra            TEAM 33. Se modifica el proceso para que se pueda realizar el calculo y el
                                    pago decomisiones a contratistas pertenecientes al tramite de venta a constructoras,
                                    para que aplique para Surtigas y Gases del Caribe.
    20-01-2015      Gabriel Gamarra    NC 3968: Se añade validacion para que no procese las solicitudes del tipo
                                      100271 - Venta de Gas Formulario Migracion en la etapa de registro.
    05-02-2016      Francisco Castro  Caso 100.7353: Se implementa funcionalidad para ejecutar el proceso
                                    por hilos (se separa parte del codigo original que estaba en PrGenerateCommission
                                    pasandolo para PrGenerateCommission_Hilos
    18-06-2025        Lubin Pineda        OSF-4555: Se ajusta por borrado de csbNitSurtigas.                                    
    ******************************************************************/
    PROCEDURE PrGenerateCommission is

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PrGenerateCommission';
        
        dtLastExecution        date;
        dtToday                date := sysdate;

        sbPackagesType         varchar2(3000);

        nuHilosComision        number;
        nuTotReg               number;
        nuFinJobs              number(1);
        nuCont                 number;
        nusesion               number;
        nuresult               number(5);
    
        cursor cuPackages(idtToday         date,
                          idtLastExecution date,
                          isbPackagesType  varchar2) is
        --Solicitudes de venta pendientes por pago de comision al legalizar
         select count(1) from (
         (select mo_packages.package_id id, 'B' sbTime
            from mo_packages
           where mo_packages.request_date between idtLastExecution and idtToday
             and instr(','||isbPackagesType||',', ','||mo_packages.PACKAGE_TYPE_ID||',') > 0
             AND mo_packages.PACKAGE_TYPE_ID <> 100271
             and mo_packages.MOTIVE_STATUS_ID <> nuPkgAnulado -- 32-Solicitud ANULADA
             and not exists
           (select null
                from mo_packages MP, LDC_PKG_OR_ITEM
               where MP.package_id = LDC_PKG_OR_ITEM.package_id
                 and LDC_PKG_OR_ITEM.order_item_id in
                     (nuActCIVZNR,
                      nuActCIVZSR,
                      nuActCIVZNC,
                      nuActCIVZSC,
                      nuActMZR,
                      nuActMZC)
                 and instr(','||isbPackagesType||',', ','||mo_packages.PACKAGE_TYPE_ID||',') > 0
                 and mo_packages.package_id = MP.package_id))
        union
        --Solicitudes de venta pendientes por pago de comision al legalizar
       (select mo_packages.package_id id, 'L' sbTime
          from mo_packages
         where mo_packages.request_date between idtLastExecution and
               idtToday
           and instr(','||isbPackagesType||',', ','||mo_packages.PACKAGE_TYPE_ID||',') > 0
           and mo_packages.MOTIVE_STATUS_ID = nuPkgAtendido -- 14-Solicitud atendida
           and not exists
         (select null
                --select mo_packages.package_id id, 'L' sbTime
                  from mo_packages MP, LDC_PKG_OR_ITEM
                 where MP.package_id = LDC_PKG_OR_ITEM.package_id
                   and LDC_PKG_OR_ITEM.order_item_id in
                       (nuActCLVZNR,
                        nuActCLVZSR,
                        nuActCLVZNC,
                        nuActCLVZSC,
                        nuActMZR,
                        nuActMZC)
                   and instr(','||isbPackagesType||',', ','||mo_packages.PACKAGE_TYPE_ID||',') > 0
                   and mo_packages.package_id = MP.package_id)));
                   
  
        cursor cuJobs (nuInd number) is
        select resultado
        from ldc_log_salescomission
        where sesion = nusesion
        and fecha_inicio = dtToday
        and hilo = nuind
        AND resultado in (-1,2); -- -1 Termino con errores, 2 termino OK
  
        rgNewParameter ld_parameter%rowtype;
        
        dtBegin   date;
                
        nujob         number;
        sbWhat        varchar2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        nuHilosComision := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COMISION_HILOS');
        
        nusesion := pkg_Session.fnuGetSesion;
            
        pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Inicia Proceso');
     
        sbPackagesType := pkg_BCLD_Parameter.fsbObtieneValorCadena('ID_SOLIC_VENTA_GAS_CONST');

        --Obtener la fecha de la última ejecución del proceso
        if (dald_parameter.fblexist('FECHA_COM_REG_VENTA') = FALSE) then
          rgNewParameter.PARAMETER_ID := 'FECHA_COM_REG_VENTA';
          rgNewParameter.VALUE_CHAIN := SYSDATE;
          rgNewParameter.DESCRIPTION := 'ULTIMA FECHA DE EJECUCION DEL PROCESO PARA GENERAR COMISIONES DE VENTA AL REGISTRO';
          insert into ld_parameter
            (PARAMETER_ID, NUMERIC_VALUE, VALUE_CHAIN, DESCRIPTION)
          values
            (rgNewParameter.PARAMETER_ID,
             null,
             rgNewParameter.VALUE_CHAIN,
             rgNewParameter.DESCRIPTION);
          commit;          
        end if;
        
        --Almacenar en un parámetro para futuras ejecuciones
        dtLastExecution := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
        dtBegin         := dtLastExecution - nuRange;

        pkg_Traza.Trace('Fecha inicio dtBegin --> ' || dtBegin, 10);
        
        pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Inicia conteo regs a procesar. dtLastExecution: ' ||
                                dtLastExecution || ' dtBegin: '  || dtBegin);
                            
        -- se halla el total de registros a procesar
        open cuPackages(dtToday, dtBegin, sbPackagesType);
        fetch cuPackages into nuTotReg;
        close cuPackages;
    
        if nuTotReg is null then
            nuTotReg := -1;
        end if;    
    
        pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Termina conteo regs a procesar. Nro Regs: ' || nuTotReg);
       
        if nuTotReg > 0 then
            -- Si el numero de regs a procesar es menor o igual al Nro de hilos, se ejecutara en uno solo
            if nuTotReg <= nuHilosComision then 
                nuHilosComision := 1;
            end if;     

            pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Inicia creacion de los jobs');
            -- se crean los jobs y se ejecutan
            for rgJob in 1 .. nuHilosComision loop
                sbWhat := 'BEGIN'                                           || chr(10) ||
                '   SetSystemEnviroment;'                         || chr(10) ||
                '   LDC_BCSALESCOMMISSION.PrGenerateCommission_Hilos(' || 'to_date(''' ||to_char(dtToday,'DD/MM/YYYY  HH24:MI:SS')||'''),' || chr(10) ||  
                '                                                    to_date(''' ||to_char(dtBegin,'DD/MM/YYYY  HH24:MI:SS')||'''),' || chr(10) || 
                '                                                    ''' || sbPackagesType || ''',' || chr(10) || 
                '                                                    ' || rgJob || ',' || chr(10) ||
                '                                                    ' || nuHilosComision || ',' || chr(10) ||
                '                                                    ' || nusesion || ');' || chr(10) || 
                'END;';
                dbms_job.submit (nujob,
                             sbWhat,
                             sysdate + 1/3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
                commit;    
                pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Creo job: ' || rgJob ||
                                   ' Nro ' || nujob);
            end loop;

            -- se verifica si terminaron los jobs
            nuFinJobs := 0;
            while nuFinJobs = 0 loop
              nucont    := 0;
              for i in 1 .. nuHilosComision loop
                open cujobs (i);
                fetch cujobs into nuresult;
                if nuresult is not null then
                    nucont := nucont + 1;
                 end if;
                 close cujobs;
               end loop;
               if nucont = nuHilosComision then
                 nuFinJobs := 1;
               else
                 DBMS_LOCK.SLEEP(60);
               end if;
             end loop;

            pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Terminaron todos los hilos');
                
            pkg_Traza.Trace('Actualizando parámetro fecha', 10);
            dald_parameter.UPDVALUE_CHAIN('FECHA_COM_REG_VENTA', to_char(SYSDATE));
            pkg_Traza.Trace('Asentando transaccion', 10);
            commit;

            pkg_Traza.Trace('Ejecuta LDC_prorevercomisionventasanul', 10);

            pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Inicia LDC_prorevercomisionventasanul');
            LDC_prorevercomisionventasanul;
            pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Termino LDC_prorevercomisionventasanul. Fin proceso');

        else
            pro_grabalog_comision (nusesion, dtToday, 0, 0, 'LDC_BCSalesCommission.PrGenerateCommission con cero registros a procesar');
            pkg_Traza.Trace('LDC_BCSalesCommission.PrGenerateCommission con cero registros a procesar', 10);
        end if;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
            
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR then
            pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Error: ' || sqlerrm);
            rollback;
            raise;
        WHEN OTHERS then
            pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Error: ' || sqlerrm);
            rollback;
            gw_boerrors.checkerror(SQLCODE, SQLERRM);
    END PrGenerateCommission;


/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrGenerateCommission_Hilos
    Descripcion    : Procedimiento para generar comisiones por ventas al registro de la solicitud
                     Mediante hilos
    Autor          : Sayra Ocoro
    Fecha          : 08/03/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
   06-11-2013      Sayra Ocoró        Se modifica el método PrGenerateCommision para que las ordenes
                                        de comisión generadas como comisiones sean vistas desde el proceso
                                        de liquidación a contratistas
   19-01-2014      Sayra Ocoró        Se adiciona búsqueda de la orden de referencia para la novedad para
                                      solucionar la NC 2561.
                                      Se modifica filtro para no multar doble.
   20-02-2014     Sayra Ocoró        Aranda 89871 : Se modifica lógica para manejo de errores
   21-02-2014     Sayra Ocoró        Aranda 2877:  Se modifican los parámetros que se envían al apli para
                                     registro de novedades OS_REGISTERNEWCHARGE
   06-03-2014     Emiro Leyva        aranda 3038 (Debe corregirse para que tome sólo el valor de la venta antes de IVA.).
                                     Solucion: se busca el valor de la venta en la tabla cargos de todos los
                                     conceptos de la venta atravez de la funcion LDC_FNUGETVLRVENTA, recibe
                                     como parametro 'PP-' concatenado con el numero de la solicitud de la venta.
   25-03-2014     Jorge Valiente     ARANDA 3224: Se colocaron validaciones para identificar cuando las varibales
                                                  con datos provenientes de servicios de 1er nivel tiene dato NULO.
   01-04-2014      Sayra Ocoró       Aranda 3275:Se deben actualizar correctamente la dirección (Address_id)
                                       de la venta en los campos "External_address_id" de la entidad OR_ORDER y
                                       "Address_id" de la entidad OR_ORDER_ACTIVITY.
  10-04-2014      Sayra Ocoró       Aranda 3275_2:Se ajusta la solución para que actualice los campos OPERATING_SECTOR_ID
                                              y GEOGRAP_LOCATION_ID de la tabla OR_ORDER y también el campo
                                               OPERATING_SECTOR_ID  de la tabla OR_ORDER_ACTIVITY.
  16-04-2014    Sayra Ocoró         Aranda 3420: Se corrige mensage de generación.
  08-09-2014      oparra            TEAM 33. Se modifica el proceso para que se pueda realizar el calculo y el
                                    pago decomisiones a contratistas pertenecientes al tramite de venta a constructoras,
                                    para que aplique para Surtigas y Gases del Caribe.
  20-01-2015      Gabriel Gamarra    NC 3968: Se añade validacion para que no procese las solicitudes del tipo
                                      100271 - Venta de Gas Formulario Migracion en la etapa de registro.

  05-02-2016      Francisco Castro  Caso 100.7353: Se implementa funcionalidad para ejecutar el proceso
                                    por hilos (se separo parte del codigo original que estaba en PrGenerateCommission
                                    pasandolo para este procedimiento PrGenerateCommission_Hilos 
  ******************************************************************/
  procedure PrGenerateCommission_Hilos (indtToday date, 
                                        indtBegin date, 
                                        insbPackagesType varchar2,
                                        innuNroHilo number,
                                        innuTotHilos number,
                                        innusesion number) is
                                        
    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PrGenerateCommission_Hilos';
                                            
    nuTaskTypeId      or_task_type.task_type_id%type;
    nuCateCodi        LDC_COMISION_PLAN.CATECODI%type;
    nuGeograpDepto    ge_geogra_location.geograp_location_id%type;
    nuGeograpLoca     ge_geogra_location.geograp_location_id%type;
    nuOperatingUnitId or_operating_unit.operating_unit_id%type;
    nuSalesmanId      mo_packages.person_id%type;
    nuZoneIdProduct   or_operating_zone.operating_zone_id%type;
    nuZoneId          or_operating_zone.operating_zone_id%type;
    nuBaseId          ge_base_administra.id_base_administra%Type;
    sbAssignType      or_operating_unit.assign_type%type;
    nuSegmentId       ab_address.segment_id%type;
    nuAdressId        pr_product.address_id%type;
    RgCommission      RgCommissionRegister;
    rgData            ldc_pkg_or_item%rowtype;
    SBobservacion     ldc_pkg_or_item.OBSERVACION%TYPE;
    sbDOCUMENT_KEY    mo_packages.DOCUMENT_KEY%type;
    inuOrderId        or_order.order_id%type;
    nugrabados number := 0; 

    
    inuPersonId            SA_USER.user_id%type;
    isbObservation         VARCHAR2(400);
    onuErrorCode           number;
    osbErrorMessage        varchar2(2000);
    inuActivity            ge_items.items_id%type;
    nuOperatingSectorId    ab_segments.operating_sector_id%type;
    nuOperatingSectorIdAux ab_segments.operating_sector_id%type := 0;
    
    cursor cuPackages(idtToday         date,
                      idtLastExecution date,
                      isbPackagesType  varchar2) is
    --Solicitudes de venta pendientes por pago de comision al legalizar
    select * from (
    (
      select mo_packages.package_id id, 'B' sbTime
        from mo_packages
       where mo_packages.request_date between idtLastExecution and idtToday
         and instr(','||isbPackagesType||',', ','||mo_packages.PACKAGE_TYPE_ID||',') > 0
         AND mo_packages.PACKAGE_TYPE_ID <> 100271
         and mo_packages.MOTIVE_STATUS_ID <> nuPkgAnulado -- 32-Solicitud ANULADA
            -- minus
         and not exists
       (select null
              --select mo_packages.package_id id, 'B' sbTime
                from mo_packages MP, LDC_PKG_OR_ITEM
               where MP.package_id = LDC_PKG_OR_ITEM.package_id
                 and LDC_PKG_OR_ITEM.order_item_id in
                     (nuActCIVZNR,
                      nuActCIVZSR,
                      nuActCIVZNC,
                      nuActCIVZSC,
                      nuActMZR,
                      nuActMZC)
                 and instr(','||isbPackagesType||',', ','||mo_packages.PACKAGE_TYPE_ID||',') > 0
                 and mo_packages.package_id = MP.package_id))
      union
      --Solicitudes de venta pendientes por pago de comision al legalizar
       (select mo_packages.package_id id, 'L' sbTime
          from mo_packages
         where mo_packages.request_date between idtLastExecution and
               idtToday
           and instr(','||isbPackagesType||',', ','||mo_packages.PACKAGE_TYPE_ID||',') > 0
           and mo_packages.MOTIVE_STATUS_ID = nuPkgAtendido -- 14-Solicitud atendida

              --minus
           and not exists
         (select null
                --select mo_packages.package_id id, 'L' sbTime
                  from mo_packages MP, LDC_PKG_OR_ITEM
                 where MP.package_id = LDC_PKG_OR_ITEM.package_id
                   and LDC_PKG_OR_ITEM.order_item_id in
                       (nuActCLVZNR,
                        nuActCLVZSR,
                        nuActCLVZNC,
                        nuActCLVZSC,
                        nuActMZR,
                        nuActMZC)
                   and instr(','||isbPackagesType||',', ','||mo_packages.PACKAGE_TYPE_ID||',') > 0
                   and mo_packages.package_id = MP.package_id)))
       where mod(id,innuTotHilos)+innuNroHilo= innuTotHilos;
       
    
    nuProductId    pr_product.product_id%type;
    sbES_externa   or_operating_unit.es_externa%type;

    --Cursor para validar  el sector operativo
    cursor cuOperatingSector(inuBaseId   ge_base_administra.id_base_administra%type,
                             inuSectorId or_operating_sector.operating_sector_id%type) is
      select count(*) /*distinct nvl(ge_sectorope_zona.id_sector_operativo,0)*/ nuSectorId
        from or_zona_base_adm, ge_sectorope_zona
       where or_zona_base_adm.operating_zone_id =
             ge_sectorope_zona.id_zona_operativa
         and or_zona_base_adm.id_base_administra = inuBaseId
         and ge_sectorope_zona.id_sector_operativo = inuSectorId;

    nuValue   number := 0;
    nuDays    number := 0;
    nuPercent number;
    nuNDays   number;
    nuBan     number := 0;
    
    --Cursor para obtener el identificador de la orden de multa
    --Retorna nulo porque el api no alcanza a crear el registro
    cursor cuOtMulta(isbObservation or_order_comment.order_comment%type) is
      select order_id id
        from or_order_comment
       where order_comment like isbObservation;

    --Cursor para validar si durante el proceso ya se generó multa
    cursor cuExisteMulta(inuPackageId mo_packages.package_id%type) is
      select count(*)
        from ldc_pkg_or_item
       where ORDER_ITEM_ID in (nuActMZR, nuActMZC)
         and package_id = inuPackageId;
    nuCount       number := 0;
    nuActivityId  or_order_activity.order_activity_id%type;
    nucontareg    NUMBER(15) DEFAULT 0;
    nucantiregcom NUMBER(15) DEFAULT 0;
    nucantiregtot NUMBER(15) DEFAULT 0;

    begin
  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
          
        pkg_Traza.Trace('PrGenerateCommission Hilo ' || innuNroHilo, 10);
        
        pro_grabalog_comision (innusesion, indtToday, innuNroHilo, 1, 'Inicia Hilo: ' || innuNroHilo);
       
        --Buscar solicitudes de venta en estado "13 - Registrada" enun rango de fecha
        --Para cada solicitud, validar si ya se le generó una OT cerrada para el pago de la comisión, si no, entonces generar OT y generar
        --dbms_output.put_line('Inicio validar si ya se le generó una OT cerrada para el pago de la comisión');
        nucantiregcom := 0;
        nucantiregtot := 0;
        nucontareg    := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_CANTIDAD_REG_GUARDAR');
        nugrabados := 0; 
    
        for pkg in cuPackages(indtToday, indtBegin, insbPackagesType) loop 

        BEGIN
            pkg_Traza.Trace('Procesando solicitud --> ' || pkg.id || ' (Hilo ' || innuNroHilo || ')', 10);
        
      
           --dbms_output.put_line(pkg.id);
            nuBan       := 0;
            inuActivity := null;
            inuOrderId  := null;
            --Obtener unidad de trabajo o contratista para consultar en CTCVE
            nuSalesmanId := damo_packages.fnugetperson_id(pkg.id);
            pkg_Traza.Trace('nuSalesmanId --> ' || nuSalesmanId, 10);
            sbDOCUMENT_KEY := damo_packages.fsbgetdocument_key(pkg.id);
            pkg_Traza.Trace('sbDOCUMENT_KEY --> ' || sbDOCUMENT_KEY, 10);

            if nuSalesmanId is null then
              pkg_Traza.Trace('No existe un vendedor asociado a la solicitud de venta',
                             10);
              ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                               'No existe un vendedor asociado a la solicitud de venta ' ||
                                               pkg.id);
              raise ex.CONTROLLED_ERROR;
            end if;
            
            inuPersonId := nuSalesmanId;
        
        --Obtener la unidad asociada al punto de venta
        nuOperatingUnitId := damo_packages.fnugetpos_oper_unit_id(pkg.id);
        pkg_Traza.Trace('nuOperatingUnitId --> ' || nuOperatingUnitId, 10);

        if nuOperatingUnitId is null then
          pkg_Traza.Trace('La Solicitud ' || pkg.id ||
                         ' no esta asociado a una unidad de trabajo.',
                         10);
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'El Solicitud ' || pkg.id ||
                                           ' no está asociado a una unidad de trabajo.');
          raise ex.CONTROLLED_ERROR;
        end if;
        --Obtener el tipo de unidad operativa asociada a la solicitud de venta
        sbES_externa := daor_operating_unit.fsbgetes_externa(nuOperatingUnitId);

        pkg_Traza.Trace('sbES_externa --> ' || sbES_externa, 10);

        --Validar si la unidad operativa es externa
        --dbms_output.put_line('sbES_externa => '||sbES_externa);
        if sbES_externa = 'Y' then
          pkg_Traza.Trace('Unidad Operativa si es externa', 10);
          --Obener la dirección del producto
          nuAdressId := damo_packages.fnugetaddress_id(pkg.id);
          pkg_Traza.Trace('nuAdressId --> ' || nuAdressId, 10);
          --dbms_output.put_line('nuAdressId => '||nuAdressId);
          --Producto
          nuProductId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive',
                                                                         'package_id',
                                                                         'product_id',
                                                                         pkg.id));
          pkg_Traza.Trace('nuProductId --> ' || nuProductId, 10);
          --Categoria
          nuCateCodi := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive',
                                                                        'PACKAGE_ID',
                                                                        'CATEGORY_ID',
                                                                        pkg.id));
          pkg_Traza.Trace('nuCateCodi --> ' || nuCateCodi, 10);
          --Obtener la localidad
          nuGeograpLoca := daab_address.fnugetgeograp_location_id(nuAdressId,
                                                                  NULL);
          pkg_Traza.Trace('nuGeograpLoca --> ' || nuGeograpLoca, 10);
          --Obtener el Depto
          nuGeograpDepto := dage_geogra_location.fnugetgeo_loca_father_id(nuGeograpLoca,
                                                                          NULL);
          pkg_Traza.Trace('nuGeograpDepto --> ' || nuGeograpDepto, 10);
          --Obtener el segmento de la direccion del producto
          nuSegmentId := daab_address.fnugetsegment_id(nuAdressId, NULL);
          pkg_Traza.Trace('nuSegmentId --> ' || nuSegmentId, 10);
          --Obtener el sector operativo del segmento
          nuOperatingSectorId := daab_segments.fnugetoperating_sector_id(nuSegmentId,
                                                                         null);
          pkg_Traza.Trace('nuOperatingSectorId --> ' || nuOperatingSectorId,
                         10);
          --dbms_output.put_line('nuOperatingSectorId => '||nuOperatingSectorId);
          --dbms_output.put_line('nuOperatingSectorId => '||nuOperatingSectorId);
          --Obtener la zona del sector operativo asociado a la dirección del producto
          nuZoneIdProduct := daor_operating_sector.fnugetoperating_zone_id(nuOperatingSectorId);
          pkg_Traza.Trace('nuZoneIdProduct --> ' || nuZoneIdProduct, 10);
          --Obtener el tipo de asignación de la unidad operativa
          sbAssignType := daor_operating_unit.fsbgetassign_type(nuOperatingUnitId);
          pkg_Traza.Trace('sbAssignType --> ' || sbAssignType, 10);
          --dbms_output.put_line('sbAssignType => '||sbAssignType);
          --dbms_output.put_line('nuOperatingUnitId => '||nuOperatingUnitId);

          ----INICIO ARANDA 3224 PARTE 1
          IF nuSegmentId IS NOT NULL THEN
            --VALIDACION DEL SEGMENTO DE LA DIRECCION DEL PRODUCTO
            IF nuGeograpLoca IS NOT NULL THEN
              --VALIDACION DE LA LOCALIDAD
              ----FIN CONTROL VALIDACION DE DATA PARTE 1

              pkg_Traza.Trace('Valida si el tipo de asignación es por demanda ' ||
                             sbAssignType,
                             10);
              --Validar si el tipo de asignacion es por DEMANDA  : C => Obtener sectores de la Zona asociada a la Base Operativa de la UT
              if sbAssignType = 'C' then
                nuBaseId := daor_operating_unit.fnugetadmin_base_id(nuOperatingUnitId);
                --dbms_output.put_line('nuBaseId => '||nuBaseId);
                open cuOperatingSector(nuBaseId, nuOperatingSectorId);
                fetch cuOperatingSector
                  into nuOperatingSectorIdAux;
                close cuOperatingSector;
                --Si el tipo de asignacion es por CAPACIDAD : S => Obtener sectores de la Zona asociada a la UT
              elsif sbAssignType = 'S' then
                nuZoneId := daor_operating_unit.fnugetoperating_zone_id(nuOperatingUnitId);
              --  dbms_output.put_line('nuZoneId => ' || nuZoneId);
                nuOperatingSectorIdAux := to_number(LDC_BOUTILITIES.fsbgetvalorcampostabla('ge_sectorope_zona',
                                                                                           'id_zona_operativa',
                                                                                           'id_sector_operativo',
                                                                                           nuZoneId,
                                                                                           'id_sector_operativo',
                                                                                           nuOperatingSectorId));
              end if;

              pkg_Traza.Trace('nuOperatingSectorIdAux --> ' ||
                             nuOperatingSectorIdAux,
                             10);

              --dbms_output.put_line('nuOperatingSectorIdAux => '||nuOperatingSectorIdAux);
              --Validar si se registra multa o comisión
              pkg_Traza.Trace('Valida genera multa o comision ', 10);
              if nuOperatingSectorIdAux = 0 or nuOperatingSectorIdAux = -1 then

                pkg_Traza.Trace('MULTA ', 10);

                --Validar si la categoria del producto es residencial
                if nuCateCodi =
                   pkg_BCLD_Parameter.fnuObtieneValorNumerico('RESIDEN_CATEGORY') then
                  --Definir item de novedad y tipo de trabajo para multar
                  nuTaskTypeId := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_TT_MULTA_RESID');
                  inuActivity  := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_MULTA_VENTA_OTRA_ZONA_RESID');
                end if;
                --Validar si la categoria del producto es residencial
                if nuCateCodi =
                   pkg_BCLD_Parameter.fnuObtieneValorNumerico('COMMERCIAL_CATEGORY') then
                  nuTaskTypeId := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_TT_MULTA_COMME');
                  inuActivity  := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_MULTA_VENTA_OTRA_ZONA_COMM');
                end if;

                pkg_Traza.Trace('nuTaskTypeId --> ' || nuTaskTypeId ||
                               ' inuActivity --> ' || inuActivity,
                               10);

                --Obtener el valor de la multa de LDC_ALT de acuerdo a la configuración realizada
                ldc_boordenes.PROCVALRANGOTIEMPLEGOT(null,
                                                     null,
                                                     nuGeograpDepto,
                                                     null,
                                                     nuTaskTypeId,
                                                     null,
                                                     null,
                                                     nuDays,
                                                     nuPercent,
                                                     nuValue,
                                                     nuNDays);
                pkg_Traza.Trace(' Obtener el valor de la multa nuValue --> ' ||
                               nuValue || ' nuNDays --> ' || nuNDays,
                               10);
                --Si existe configuración
                if nuValue is not null and nuValue > 0 then
                  pkg_Traza.Trace('Validando si ya existe multa', 10);
                  --Validar si ya existe MULTA
                  nuCount := 0;
                  open cuExisteMulta(pkg.id);
                  fetch cuExisteMulta
                    into nuCount;
                  close cuExisteMulta;

                  pkg_Traza.Trace('nuCount --> ' || nuCount, 10);

                  if nuCount = 0 or nuCount is null then
                    pkg_Traza.Trace('No Existe multa, Registrar multa', 10);
                    --Registrar multa
                    isbObservation := 'MULTA GENERADA DESDE PROCESO AUTOMÁTICO' ||
                                      ' No.Documento:' || sbDOCUMENT_KEY ||
                                      ' No. Solicitud:' || pkg.id;
                    pkg_Traza.Trace(' Observation --> ' || isbObservation,
                                   10);

                    ---api de open para crear novedades orden cerrada
                    LDC_prRegisterNewCharge(nuOperatingUnitId,
                                            inuActivity,
                                            inuPersonId,
                                            null,
                                            nuValue,
                                            null,
                                            null,
                                            pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_TIPO_OBS_COMISION_VENTA'),
                                            isbObservation,
                                            onuErrorCode,
                                            osbErrorMessage,
                                            inuOrderId);
                     nugrabados := nugrabados + 1; 
                     if mod(nugrabados,nucontareg) = 0 then
                       pro_grabalog_comision (innusesion, indtToday, innuNroHilo, 0, 'Ha Generado hasta ahora: ' || nugrabados ||
                                             ' Ultima Orden generada: ' || inuOrderId); 
                     end if;
                       
                    pkg_Traza.Trace('onuErrorCode --> ' || onuErrorCode ||
                                   ' osbErrorMessage' || osbErrorMessage,
                                   10);
                    if (onuErrorCode <> 0) then
                      pkg_Traza.Trace('NO SE GENERO NOVEDAD DE MULTA', 10);
                      --persistencia para no generar pago de comisiones en ejecuciones futuras
                      rgData.LDC_PKG_OR_ITEM_ID := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LDC_PKG_OR_ITEM',
                                                                                       'SEQ_LDC_PKG_OR_ITEM');
                      rgData.order_item_id      := null;
                      rgData.order_id           := null;
                      rgData.package_id         := pkg.id;
                      rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
                      rgData.OBSERVACION        := 'NO SE GENERO NOVEDAD DE MULTA';

                      pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
                      pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                                     rgData.LDC_PKG_OR_ITEM_ID ||
                                     ' rgData.order_item_id->' ||
                                     rgData.order_item_id ||
                                     ' rgData.order_id->' ||
                                     rgData.order_id ||
                                     ' rgData.package_id->' ||
                                     rgData.package_id ||
                                     ' rgData.FECHA->' || rgData.FECHA ||
                                     ' rgData.OBSERVACION->' ||
                                     rgData.OBSERVACION,
                                     10);

                      insert into LDC_PKG_OR_ITEM
                        (LDC_PKG_OR_ITEM_ID,
                         ORDER_ITEM_ID,
                         ORDER_ID,
                         PACKAGE_ID,
                         FECHA,
                         OBSERVACION)
                      values
                        (rgData.LDC_PKG_OR_ITEM_ID,
                         rgData.order_item_id,
                         rgData.order_id,
                         rgData.package_id,
                         rgData.FECHA,
                         rgData.OBSERVACION);

                    else

                      pkg_Traza.Trace('inuOrderId --> ' || inuOrderId, 10);
                      nuActivityId := ldc_bcfinanceot.fnuGetActivityId(inuOrderId);
                      pkg_Traza.Trace('nuActivityId --> ' || nuActivityId,
                                     10);
                      daor_order_activity.updaddress_id(nuActivityId,
                                                        nuAdressId);

                      daor_order.updexternal_address_id(inuOrderId,
                                                        nuAdressId);
                      daor_order.updgeograp_location_id(inuOrderId,
                                                        nuGeograpLoca);
                      daor_order.updoperating_sector_id(inuOrderId,
                                                        nuOperatingSectorId);
                      daor_order_activity.updoperating_sector_id(nuActivityId,
                                                                 nuOperatingSectorId);

                      pkg_Traza.Trace('Fin Actualización ', 10);
                      
                      SBobservacion := 'SE GENERO NOVEDAD DE MULTA ' ||
                                       inuActivity || ' - ' ||
                                       dage_items.fsbgetdescription(inuActivity);
                      nuBan         := 1;
                    end if;
                  end if;
                else
                  pkg_Traza.Trace('Ya existe multa, persistencia para no generar pago de comisiones en ejecuciones futuras',
                                 10);
                  --persistencia para no generar pago de comisiones en ejecuciones futuras
                  rgData.LDC_PKG_OR_ITEM_ID := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LDC_PKG_OR_ITEM',
                                                                                   'SEQ_LDC_PKG_OR_ITEM');
                  rgData.order_item_id      := null;
                  rgData.order_id           := null;
                  rgData.package_id         := pkg.id;
                  rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
                  rgData.OBSERVACION        := 'NO SE ENCONTRARON CONDICIONES PARA GENERACIÓN DE MULTA';

                  pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
                  pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                                 rgData.LDC_PKG_OR_ITEM_ID ||
                                 ' rgData.order_item_id->' ||
                                 rgData.order_item_id ||
                                 ' rgData.order_id->' || rgData.order_id ||
                                 ' rgData.package_id->' ||
                                 rgData.package_id || ' rgData.FECHA->' ||
                                 rgData.FECHA || ' rgData.OBSERVACION->' ||
                                 rgData.OBSERVACION,
                                 10);

                  insert into LDC_PKG_OR_ITEM
                    (LDC_PKG_OR_ITEM_ID,
                     ORDER_ITEM_ID,
                     ORDER_ID,
                     PACKAGE_ID,
                     FECHA,
                     OBSERVACION)
                  values
                    (rgData.LDC_PKG_OR_ITEM_ID,
                     rgData.order_item_id,
                     rgData.order_id,
                     rgData.package_id,
                     rgData.FECHA,
                     rgData.OBSERVACION);

                end if;
              else

                pkg_Traza.Trace('COMISION', 10);
                --Al generar la novedad,  se debe calcular el valor a pagar (con la funcion -> IN: mo_packages.package_id)
                RgCommission := FnuGetCommissionValue(pkg.sbTime,
                                                      pkg.id,
                                                      nuAdressId,
                                                      nuProductId,
                                                      nuOperatingUnitId);
                pkg_Traza.Trace('Valida si tiene comisión RgCommission.onuCommissionValue -> ' ||
                               RgCommission.onuCommissionValue,
                               10);
                --dbms_output.put_line('RgCommission.onuCommissionValue => '||RgCommission.onuCommissionValue);
                if RgCommission.onuCommissionValue > 0 then

                  pkg_Traza.Trace('No existe comisión asociada, Genera comisión',
                                 10);
                  inuOrderId := null;
                  --Validar si la categoria del producto es comercial
                  if nuCateCodi =
                     pkg_BCLD_Parameter.fnuObtieneValorNumerico('RESIDEN_CATEGORY') then
                    if RgCommission.sbIsZone = 'N' then
                      if pkg.sbTime = 'B' then
                        inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZNR');
                      else
                        inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZNR');
                      end if;
                    else
                      if RgCommission.sbIsZone = 'S' then
                        if pkg.sbTime = 'B' then
                          inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZSR');
                        else
                          inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZSR');
                        end if;
                      end if;
                    end if;
                  else
                    --Validar si la categoria del producto es comercial
                    if nuCateCodi =
                       pkg_BCLD_Parameter.fnuObtieneValorNumerico('COMMERCIAL_CATEGORY') then
                      if RgCommission.sbIsZone = 'N' then
                        if pkg.sbTime = 'B' then
                          inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZNC');
                        else
                          inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZNC');
                        end if;
                      else
                        if RgCommission.sbIsZone = 'S' then
                          if pkg.sbTime = 'B' then
                            inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZSC');
                          else
                            inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZSC');
                          end if;
                        end if;
                      end if;
                    end if;
                  end if;
                  pkg_Traza.Trace('Actividad inuActivity --> ' ||
                                 inuActivity,
                                 10);
                  --API para registrar novedades
                  isbObservation := 'COMISION GENERADA DESDE PROCESO AUTOMÁTICO' ||
                                    ' No.Documento:' || sbDOCUMENT_KEY ||
                                    ' No. Solicitud:' || pkg.id;
                  pkg_Traza.Trace('Observation  --> ' || isbObservation, 10);

                  LDC_prRegisterNewCharge(nuOperatingUnitId,
                                          inuActivity,
                                          inuPersonId,
                                          null,
                                          RgCommission.onuCommissionValue,
                                          null,
                                          null,
                                          pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_TIPO_OBS_COMISION_VENTA'),
                                          isbObservation,
                                          onuErrorCode,
                                          osbErrorMessage,
                                          inuOrderId);
                                          
                  pkg_Traza.Trace('onuErrorCode --> ' || onuErrorCode ||
                                 ' osbErrorMessage' || osbErrorMessage,
                                 10);

                  if (onuErrorCode <> 0) then

                    pkg_Traza.Trace('NO SE GENERO NOVEDAD DE COMISION', 10);
                    --persistencia para no generar pago de comisiones en ejecuciones futuras
                    rgData.LDC_PKG_OR_ITEM_ID := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LDC_PKG_OR_ITEM',
                                                                                     'SEQ_LDC_PKG_OR_ITEM');
                    rgData.order_item_id      := null;
                    rgData.order_id           := null;
                    rgData.package_id         := pkg.id;
                    rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
                    rgData.OBSERVACION        := 'NO SE GENERO NOVEDAD DE COMISION' ||
                                                 inuActivity || ' - ' ||
                                                 dage_items.fsbgetdescription(inuActivity,
                                                                              NULL);

                    pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
                    pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                                   rgData.LDC_PKG_OR_ITEM_ID ||
                                   ' rgData.order_item_id->' ||
                                   rgData.order_item_id ||
                                   ' rgData.order_id->' || rgData.order_id ||
                                   ' rgData.package_id->' ||
                                   rgData.package_id || ' rgData.FECHA->' ||
                                   rgData.FECHA || ' rgData.OBSERVACION->' ||
                                   rgData.OBSERVACION,
                                   10);

                    insert into LDC_PKG_OR_ITEM
                      (LDC_PKG_OR_ITEM_ID,
                       ORDER_ITEM_ID,
                       ORDER_ID,
                       PACKAGE_ID,
                       FECHA,
                       OBSERVACION)
                    values
                      (rgData.LDC_PKG_OR_ITEM_ID,
                       rgData.order_item_id,
                       rgData.order_id,
                       rgData.package_id,
                       rgData.FECHA,
                       rgData.OBSERVACION);

                  else
                    pkg_Traza.Trace('inuOrderId --> ' || inuOrderId, 10);
                    nuActivityId := ldc_bcfinanceot.fnuGetActivityId(inuOrderId);
                    pkg_Traza.Trace('nuActivityId --> ' || nuActivityId, 10);
                    daor_order_activity.updaddress_id(nuActivityId,
                                                      nuAdressId);
                    pkg_Traza.Trace('Fin Actualización ', 10);
                    pkg_Traza.Trace('Orden generada inuOrderId --> ' ||
                                   inuOrderId,
                                   10);
                    --Aranda 3275
                    daor_order.updexternal_address_id(inuOrderId,
                                                      nuAdressId);
                    daor_order.updgeograp_location_id(inuOrderId,
                                                      nuGeograpLoca);
                    daor_order.updoperating_sector_id(inuOrderId,
                                                      nuOperatingSectorId);
                    daor_order_activity.updoperating_sector_id(nuActivityId,
                                                               nuOperatingSectorId);

                    SBobservacion := 'SE GENERO NOVEDAD DE COMISION ' ||
                                     inuActivity || ' - ' ||
                                     dage_items.fsbgetdescription(inuActivity,
                                                                  NULL);
                    pkg_Traza.Trace('SBobservacion --> ' || SBobservacion,
                                   10);

                    nuBan := 1;
                  end if;
                else

                  pkg_Traza.Trace('Ya existe comisión, persistencia para no generar pago de comisiones en ejecuciones futuras',
                                 10);
                  --persistencia para no generar pago de comisiones en ejecuciones futuras
                  rgData.LDC_PKG_OR_ITEM_ID := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LDC_PKG_OR_ITEM',
                                                                                   'SEQ_LDC_PKG_OR_ITEM');
                  rgData.order_item_id      := null;
                  rgData.order_id           := null;
                  rgData.package_id         := pkg.id;
                  rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
                  rgData.OBSERVACION        := 'NO SE ENCONTRARON CONDICIONES PARA PAGO DE COMISION';

                  pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
                  pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                                 rgData.LDC_PKG_OR_ITEM_ID ||
                                 ' rgData.order_item_id->' ||
                                 rgData.order_item_id ||
                                 ' rgData.order_id->' || rgData.order_id ||
                                 ' rgData.package_id->' ||
                                 rgData.package_id || ' rgData.FECHA->' ||
                                 rgData.FECHA || ' rgData.OBSERVACION->' ||
                                 rgData.OBSERVACION,
                                 10);

                  insert into LDC_PKG_OR_ITEM
                    (LDC_PKG_OR_ITEM_ID,
                     ORDER_ITEM_ID,
                     ORDER_ID,
                     PACKAGE_ID,
                     FECHA,
                     OBSERVACION)
                  values
                    (rgData.LDC_PKG_OR_ITEM_ID,
                     rgData.order_item_id,
                     rgData.order_id,
                     rgData.package_id,
                     rgData.FECHA,
                     rgData.OBSERVACION);
                end if;
              end if;

              pkg_Traza.Trace(' nuBan --> ' || nuBan, 10);
              --dbms_output.put_line('SBobservacion => '||SBobservacion);
              if nuBan = 1 then
                pkg_Traza.Trace('Valida actividad ' || inuActivity, 10);
                if nvl(inuActivity, 0) > 0 then
                  pkg_Traza.Trace('Persistencia para no generar pago de comisiones en ejecuciones futuras',
                                 10);
                  --persistencia para no generar pago de comisiones en ejecuciones futuras
                  rgData.LDC_PKG_OR_ITEM_ID := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LDC_PKG_OR_ITEM',
                                                                                   'SEQ_LDC_PKG_OR_ITEM');
                  rgData.order_item_id      := inuActivity;
                  rgData.order_id           := inuOrderId;
                  rgData.package_id         := pkg.id;
                  rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
                  rgData.OBSERVACION        := SBobservacion;

                  pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
                  pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                                 rgData.LDC_PKG_OR_ITEM_ID ||
                                 ' rgData.order_item_id->' ||
                                 rgData.order_item_id ||
                                 ' rgData.order_id->' || rgData.order_id ||
                                 ' rgData.package_id->' ||
                                 rgData.package_id || ' rgData.FECHA->' ||
                                 rgData.FECHA || ' rgData.OBSERVACION->' ||
                                 rgData.OBSERVACION,
                                 10);

                  insert into LDC_PKG_OR_ITEM
                    (LDC_PKG_OR_ITEM_ID,
                     ORDER_ITEM_ID,
                     ORDER_ID,
                     PACKAGE_ID,
                     FECHA,
                     OBSERVACION)
                  values
                    (rgData.LDC_PKG_OR_ITEM_ID,
                     rgData.order_item_id,
                     rgData.order_id,
                     rgData.package_id,
                     rgData.FECHA,
                     rgData.OBSERVACION);
                end if;
              end if;

            ELSE

              pkg_Traza.Trace('LA DIRECCION DE LA VARIABLE nuAdressId NO EXISTE O NO ES VALIDA',
                             10);
              --persistencia para no generar pago de comisiones en ejecuciones futuras
              rgData.LDC_PKG_OR_ITEM_ID := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LDC_PKG_OR_ITEM',
                                                                               'SEQ_LDC_PKG_OR_ITEM');
              rgData.order_item_id      := null;
              rgData.order_id           := null;
              rgData.package_id         := pkg.id;
              rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
              rgData.OBSERVACION        := 'NO EXISTE DIRECCION VALIDA PARA OBTENER LA LOCALIDAD';

              pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
              pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                             rgData.LDC_PKG_OR_ITEM_ID ||
                             ' rgData.order_item_id->' ||
                             rgData.order_item_id || ' rgData.order_id->' ||
                             rgData.order_id || ' rgData.package_id->' ||
                             rgData.package_id || ' rgData.FECHA->' ||
                             rgData.FECHA || ' rgData.OBSERVACION->' ||
                             rgData.OBSERVACION,
                             10);

              insert into LDC_PKG_OR_ITEM
                (LDC_PKG_OR_ITEM_ID,
                 ORDER_ITEM_ID,
                 ORDER_ID,
                 PACKAGE_ID,
                 FECHA,
                 OBSERVACION)
              values
                (rgData.LDC_PKG_OR_ITEM_ID,
                 rgData.order_item_id,
                 rgData.order_id,
                 rgData.package_id,
                 rgData.FECHA,
                 rgData.OBSERVACION);
            END IF; --VALIDACION UBICACION GEOGRAFICA
          ELSE

            pkg_Traza.Trace('LA DIRECCION DE LA VARIABLE nuAdressId NO EXISTE O NO ES VALIDA',
                           10);
            --persistencia para no generar pago de comisiones en ejecuciones futuras
            rgData.LDC_PKG_OR_ITEM_ID := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LDC_PKG_OR_ITEM',
                                                                             'SEQ_LDC_PKG_OR_ITEM');
            rgData.order_item_id      := null;
            rgData.order_id           := null;
            rgData.package_id         := pkg.id;
            rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
            rgData.OBSERVACION        := 'NO EXISTE SEGMENTO PARA LA DIRECCION';

            pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
            pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                           rgData.LDC_PKG_OR_ITEM_ID ||
                           ' rgData.order_item_id->' ||
                           rgData.order_item_id || ' rgData.order_id->' ||
                           rgData.order_id || ' rgData.package_id->' ||
                           rgData.package_id || ' rgData.FECHA->' ||
                           rgData.FECHA || ' rgData.OBSERVACION->' ||
                           rgData.OBSERVACION,
                           10);

            insert into LDC_PKG_OR_ITEM
              (LDC_PKG_OR_ITEM_ID,
               ORDER_ITEM_ID,
               ORDER_ID,
               PACKAGE_ID,
               FECHA,
               OBSERVACION)
            values
              (rgData.LDC_PKG_OR_ITEM_ID,
               rgData.order_item_id,
               rgData.order_id,
               rgData.package_id,
               rgData.FECHA,
               rgData.OBSERVACION);
          END IF;

        END IF;
      exception

        when others then

          pkg_Traza.Trace('En ERROR others ', 10);
          --persistencia para no generar pago de comisiones en ejecuciones futuras
          rgData.LDC_PKG_OR_ITEM_ID := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LDC_PKG_OR_ITEM',
                                                                           'SEQ_LDC_PKG_OR_ITEM');
          rgData.order_item_id      := null;
          rgData.order_id           := null;
          rgData.package_id         := pkg.id;
          rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
          rgData.OBSERVACION        := 'ERROR DURANTE LA EJECUCION DEL PROCESO ' ||
                                       sqlcode || ' - ' || sqlerrm;

          pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
          pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                         rgData.LDC_PKG_OR_ITEM_ID ||
                         ' rgData.order_item_id->' || rgData.order_item_id ||
                         ' rgData.order_id->' || rgData.order_id ||
                         ' rgData.package_id->' || rgData.package_id ||
                         ' rgData.FECHA->' || rgData.FECHA ||
                         ' rgData.OBSERVACION->' || rgData.OBSERVACION,
                         10);

          insert into LDC_PKG_OR_ITEM
            (LDC_PKG_OR_ITEM_ID,
             ORDER_ITEM_ID,
             ORDER_ID,
             PACKAGE_ID,
             FECHA,
             OBSERVACION)
          values
            (rgData.LDC_PKG_OR_ITEM_ID,
             rgData.order_item_id,
             rgData.order_id,
             rgData.package_id,
             rgData.FECHA,
             rgData.OBSERVACION);
      end;
      ---22-02-2014
      nucantiregcom := nucantiregcom + 1;
      IF nucantiregcom >= nucontareg THEN
        COMMIT;
        nucantiregtot := nucantiregtot + nucantiregcom;
        nucantiregcom := 0;
      END IF;
    end loop;
    commit;
    pro_grabalog_comision (innusesion, indtToday, innuNroHilo, 0, 'Proceso: ' || nucantiregtot); 
    pro_grabalog_comision (innusesion, indtToday, innuNroHilo, 0, 'Genero: ' || nugrabados); 
    pro_grabalog_comision (innusesion, indtToday, innuNroHilo, 2, 'Termino Hilo: ' || innuNroHilo ||
                           ' - Proceso Ok'); 
    pkg_Traza.Trace('Finalizo LDC_BCSalesCommission.PrGenerateCommission Hilo ' || innuNroHilo, 10);
   
  exception
    WHEN ex.CONTROLLED_ERROR then
      pro_grabalog_comision (innusesion, indtToday, innuNroHilo, -1, 'Hilo: ' || innuNroHilo ||
                             ' Termino con errores: ' || sqlerrm);
      rollback;
      raise;
    When others then
      pro_grabalog_comision (innusesion, indtToday, innuNroHilo, -1, 'Hilo: ' || innuNroHilo ||
                             ' Termino con errores: ' || sqlerrm);
      rollback;
      gw_boerrors.checkerror(SQLCODE, SQLERRM);
  end PrGenerateCommission_Hilos;
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : FnuGetCommissionValue
    Descripcion    : Función que retorna el valor de la comisión de venta al inicio de acuerdo a la
                     configuración realizada en la forma CTCVE.
    Autor          : Sayra Ocoro
    Fecha          : 08/03/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    12-08-2014        agordillo         NC 1185, Se cambia el bloque del excepcion para el cursor cuPlanCommissionId,
                                        dado que con no_data_found no se controlaria cuando el cursor viene
                                        nulo, se cambiar por:  IF cuPlanCommissionId%NOTFOUND THEN
  ******************************************************************/

    function FnuGetCommissionValue(isbTime          IN varchar2,
                                 inuPackageId     IN mo_packages.package_id%type,
                                 inuAddressId     IN ab_address.address_id%type,
                                 inuProductid     IN pr_product.product_id%Type,
                                 inuOperatingUnit IN or_operating_unit.operating_unit_id%type)
    return RgCommissionRegister is
    
    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'FnuGetCommissionValue';
        
    RgReturn           RgCommissionRegister;
    nuContractorId     or_operating_unit.contractor_id%type;
    nuCommissionType   LDC_COMISION_PLAN.COMISION_PLAN_ID%type;
    nuCommercialPlanId LDC_COMISION_PLAN.COMMERCIAL_PLAN_ID%type;
    nuMereCodi         LDC_COMISION_PLAN.MERECODI%type;
    nuCateCodi         LDC_COMISION_PLAN.CATECODI%type;
    nuSucaCodi         LDC_COMISION_PLAN.SUCACODI%type;
    nuCommissionPlanId LDC_COMISION_PLAN.COMISION_PLAN_ID%type;
    dtAttentionDate    mo_packages.ATTENTION_DATE%type;
    nuTotalPercent     LDC_COMI_TARIFA.PORC_TOTAL_COMI%type;
    nuInitialPercent   LDC_COMI_TARIFA.PORC_ALFINAL%type;
    nuInitialValue     LDC_COMI_TARIFA.VALOR_ALFINAL%type;
    nuFinalPercent     LDC_COMI_TARIFA.PORC_ALFINAL%type;
    nuFinalValue       LDC_COMI_TARIFA.VALOR_ALFINAL%type;
    nuPercent          ldc_info_predio.PORC_PENETRACION%type;
    nuIdPremise        ab_premise.premise_id%type;
    nuTotalValueValue  mo_gas_sale_data.TOTAL_VALUE%type;
    AXnuMereCodi       LDC_COMISION_PLAN.MERECODI%type;
    AXnuCateCodi       LDC_COMISION_PLAN.CATECODI%type;
    AXnuSucaCodi       LDC_COMISION_PLAN.SUCACODI%type;
    SW                 NUMBER;
    nuGeograpLoca      ge_geogra_location.geograp_location_id%type;
    --Cursor para obtener
    cursor cuPlanCommissionId(nuCommissionType   LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
                              nuCommercialPlanId LDC_COMISION_PLAN.COMMERCIAL_PLAN_ID%type,
                              sbIsZone           ldc_info_predio.is_zona%type,
                              nuMereCodi         LDC_COMISION_PLAN.MERECODI%type,
                              nuCateCodi         LDC_COMISION_PLAN.CATECODI%type,
                              nuSucaCodi         LDC_COMISION_PLAN.SUCACODI%type) is
      select nvl(COMISION_PLAN_ID, 0) PlanCommissionId
        from LDC_COMISION_PLAN
       where TIPO_COMISION_ID = nuCommissionType
         and IS_ZONA = sbIsZone
         and COMMERCIAL_PLAN_ID = nuCommercialPlanId
         and NVL(MERECODI, -1) = NVL(nuMereCodi, -1)
         and NVL(CATECODI, -1) = NVL(nuCateCodi, -1)
         and NVL(SUCACODI, -1) = NVL(nuSucaCodi, -1);

    --Cursor para obtener los valores para aplicar en el cálculo de la comisión al registro
    cursor cuCommission(dtAttentionDate    mo_packages.ATTENTION_DATE%type,
                        nuCommissionPlanId LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
                        nuPercent          ldc_info_predio.PORC_PENETRACION%type) is
      select nvl(PORC_TOTAL_COMI, 0) totalPercent,
             nvl(PORC_ALINICIO, 0) initialPercent,
             nvl(VALOR_ALINICIO, 0) initialValue,
             nvl(PORC_ALFINAL, 0) finalPercent,
             nvl(VALOR_ALFINAL, 0) finalValue
        from LDC_COMI_TARIFA
       where COMISION_PLAN_ID = nuCommissionPlanId
         and dtAttentionDate between FECHA_VIG_INICIAL and FECHA_VIG_FINAL
         and nuPercent between RANG_INI_PENETRA and RANG_FIN_PENETRA;

    --Cursor para obtener el tipo de zona y el porcentaje de cobertura en la zona
    cursor cuZonePercent(nuIdPremise ab_premise.premise_id%type) is
      select IS_ZONA sbZone, nvl(PORC_PENETRACION, 0) nuPercent
        from ldc_info_predio
       where PREMISE_ID = nuIdPremise
         and rownum = 1;
    sbCargdoso cargos.cargdoso%type;
    begin
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        --dbms_output.put_line(csbMetodo,'FnuGetCommissionValue');
        RgReturn.onuCommissionValue := 0;
        RgReturn.sbIsZone           := 'X';
        --NIVELES DE VALIDACIÓN
        --POR ZONA -> MERCADO RELEVANTE->CATEGORIA->SUBCATEGORIA->PLAN COMERCIAL
        --COMODINES: zona, subcategoria,plan comercial, rango % covertura, (% o valor) excluyentes
        --Obtener id predio
        nuIdPremise := daab_address.fnugetestate_number(inuAddressId);
        --dbms_output.put_line('nuIdPremise => '||nuIdPremise);
        if nuIdPremise is null then
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'No existe predio asociado a la dirección ' ||
                                       inuAddressId);
            raise ex.CONTROLLED_ERROR;
        end if;
        
    --Obtener zona  porcentaje de cobertura para la zona
    open cuZonePercent(nuIdPremise);
    fetch cuZonePercent into RgReturn.sbIsZone, nuPercent;
    --dbms_output.put_line('RgReturn.sbIsZone => '||RgReturn.sbIsZone);
    --dbms_output.put_line('nuPercent => '||nuPercent);
    if cuZonePercent%notfound then
      RgReturn.onuCommissionValue := 0;
      RgReturn.sbIsZone           := 'X';
      close cuZonePercent;
      return RgReturn;
    end if;

    --Obtener la localidad
    nuGeograpLoca := daab_address.fnugetgeograp_location_id(inuAddressId);
    --dbms_output.put_line('nuGeograpLoca => '||nuGeograpLoca);
    --Categoria
    nuCateCodi := to_number(dapr_product.fnuGetCATEGORY_ID(inuProductId,
                                                           NULL));
    --dbms_output.put_line('nuCateCodi => '||nuCateCodi);
    --Subcategoria
    nuSucaCodi := to_number(dapr_product.fnuGetSUBCATEGORY_ID(inuProductId,
                                                              NULL));
    --dbms_output.put_line('nuSucaCodi => '||nuSucaCodi);
    --Obtener mercado relevante
    nuMereCodi := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('fa_locamere',
                                                                  'LOMRLOID',
                                                                  'LOMRMECO',
                                                                  nuGeograpLoca));
    --dbms_output.put_line('nuMereCodi => '||nuMereCodi);
    --Obtener fecha de la solicitud
    dtAttentionDate := damo_packages.fdtGetREQUEST_DATE(inuPackageId);
    --dbms_output.put_line('dtAttentionDate => '||dtAttentionDate);
    --Obtener plan comercial
    nuCommercialPlanId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive',
                                                                          'PACKAGE_ID',
                                                                          'COMMERCIAL_PLAN_ID',
                                                                          inuPackageId));
    --dbms_output.put_line('nuCommercialPlanId => '||nuCommercialPlanId);
    if nuCommercialPlanId is null or nuCommercialPlanId = -1 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'No existe un plan comercial asociado a la solicitud de venta ' ||
                                       inuPackageId);
      raise ex.CONTROLLED_ERROR;
    end if;
    --Obtener el contratista de la unidad operativa
    nuContractorId := daor_operating_unit.fnugetcontractor_id(inuOperatingUnit);
    --dbms_output.put_line('nuContractorId => '||nuContractorId);
    if nuContractorId is null or nuContractorId = -1 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'La unidad operativa ' ||
                                       inuOperatingUnit ||
                                       ' no está asociado a una órden de trabajo.');
      raise ex.CONTROLLED_ERROR;
    end if;
    --Obtener tipo de comisión para contratista y validar
    --Validar si se realizó la configuración para el contratista
    nuCommissionType := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('LDC_INFO_OPER_UNIT',
                                                                        'OPERATING_UNIT_ID',
                                                                        'TIPO_COMISION_ID',
                                                                        nuContractorId));
   -- dbms_output.put_line('nuCommissionType => '||nuCommissionType);

    if nuCommissionType = -1 or nuCommissionType is null then
      return RgReturn;
    else
      SW           := 0;
      AXnuMereCodi := nuMereCodi;
      AXnuCateCodi := nuCateCodi;
      AXnuSucaCodi := nuSucaCodi;
      LOOP
        BEGIN
          open cuPlanCommissionId(nuCommissionType,
                                  nuCommercialPlanId,
                                  RgReturn.sbIsZone,
                                  AXnuMereCodi,
                                  AXnuCateCodi,
                                  AXnuSucaCodi);
          fetch cuPlanCommissionId
            into nuCommissionPlanId;
          IF cuPlanCommissionId%NOTFOUND THEN
            IF SW = 0 THEN
              AXnuMereCodi := nuMereCodi;
              AXnuCateCodi := nuCateCodi;
              AXnuSucaCodi := NULL;
            ELSIF SW = 1 THEN
              AXnuMereCodi := NULL;
              AXnuCateCodi := nuCateCodi;
              AXnuSucaCodi := nuSucaCodi;
            ELSIF SW = 2 THEN
              AXnuMereCodi := nuMereCodi;
              AXnuCateCodi := NULL;
              AXnuSucaCodi := NULL;
            ELSIF SW = 3 THEN
              AXnuMereCodi := NULL;
              AXnuCateCodi := nuCateCodi;
              AXnuSucaCodi := NULL;
            ELSIF SW = 4 THEN
              AXnuMereCodi := NULL;
              AXnuCateCodi := NULL;
              AXnuSucaCodi := NULL;
            END IF;
          END IF;

        END;
        close cuPlanCommissionId;
        EXIT WHEN nuCommissionPlanId > 0 OR SW = 5;
        SW := SW + 1;

      END LOOP;
      
      open cuCommission(dtAttentionDate, nuCommissionPlanId, nuPercent);
      fetch cuCommission
        into nuTotalPercent,
             nuInitialPercent,
             nuInitialValue,
             nuFinalPercent,
             nuFinalValue;
      close cuCommission;
      if nuTotalPercent = 0 then
        if isbTime = 'B' then
          RgReturn.onuCommissionValue := nuInitialValue;
        else
          if isbTime = 'L' then
            RgReturn.onuCommissionValue := nuFinalValue;
          end if;
        end if;
        return RgReturn;
      else

        sbCargdoso        := 'PP-' || inuPackageId;
        nuTotalValueValue := LDC_FNUGETVLRVENTA(sbCargdoso);

        if isbTime = 'B' then
      --  dbms_output.put_Line('Tipo: B');
          RgReturn.onuCommissionValue := ((nuTotalPercent / 100) *
                                         (nuInitialPercent / 100)) *
                                         nuTotalValueValue;

        else
          if isbTime = 'L' then
        --  dbms_output.put_Line('Tipo: L');
            RgReturn.onuCommissionValue := ((nuTotalPercent / 100) *
                                           (nuFinalPercent / 100)) *
                                           nuTotalValueValue;
          end if;
        end if;
        return RgReturn;
      end if;
    end if;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        return RgReturn;

    exception
        WHEN ex.CONTROLLED_ERROR then
            raise;
        WHEN others then
            gw_boerrors.checkerror(SQLCODE, SQLERRM);
    end FnuGetCommissionValue;

  /*Función que devuelve la versión del pkg*/
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    return CSBVERSION;
  END FSBVERSION;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetPackagesVR
  Descripcion    : Función que valida si una solicitud pertence a un tipo de paquete que tiene asociada unas ot
                   en estado 7 u 8. Se usa en condición de visualización solicitada en la NC 2046
  Autor          : Sayra Ocoro
  Fecha          : 05/12/2013

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  03-ENE-2015       Jorge Valiente    NC4298: Se creara un nuevo cursor el cual permitira establecer
                                              cuantas ordenes bloqueadas tiene la solicitud.
                                              Esto con el fin de permitirile al funcionario
                                              anular la orden para el proceso de visualizacion
                                              del codicional CNCRM
  12/Abril/2016     Jorge Valiente    SS100-9883: Se creara un nuevo cursor cuOtExito identificar 
                                                  las ordenes de la solciitud y fueron legalizadas con 
                                                  causal de EXITO.
                                                  Si hay minumo una orden con causal de EXITO esta 
                                                  retornara el valor de -1.
                                                  para indicar que esta solcitud NO sera puede ser anulada.
                                                  En caso contrario retornara el codigo de la solcuitud para 
                                                  identificar en la regla de visualizcion que la 
                                                  solicitud puede ser ANULADA.
                                                  Se modificar la logica del cursor cuPackages para que solo 
                                                  identitque las OT ejecutadas.
  22/07/2019        Horbarth Tech       CA 000-0015 se adiciona control para las solicitudes que esten configuradas en el 
                                                   parametro LDC_TIPSOLICIANUL, de tal forma que valide el estado de sus ordenes
                                                  asociadas.
  14/03/2023        Luis Valencia       OSF-882   Se modifica para validar si la solicitud
                                                  fue aprobada para anulación cuando
                                                  tiene ordenes legalizadas con causal de exito
  ******************************************************************/

    FUNCTION fnuGetPackagesVR(inuPackagesId in mo_packages.package_id%type)
    RETURN number IS

        --NC4298 Cursor
        CURSOR cuOrdenBloqueada
        (
            inuPackageId mo_packages.package_id%TYPE,
            sbTaskTypeId varchar2
        ) 
        IS
        SELECT COUNT(*)
        FROM or_order_activity, or_order
        WHERE or_order_activity.package_id = inuPackageId
        AND or_order_activity.order_id = or_order.order_id
        AND instr(sbTaskTypeId, to_char(or_order.task_type_id)) > 0
        AND or_order.order_status_id in
        (pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_ESTA_BLOQ'));
        --Fin NC4298

        CURSOR cuPackages
        (
            inuPackageId mo_packages.package_id%type,
            sbTaskTypeId varchar2
        ) 
        IS
        SELECT COUNT(*)
        FROM or_order_activity, or_order
        WHERE or_order_activity.package_id = inuPackageId
        AND or_order_activity.order_id = or_order.order_id
        AND instr(sbTaskTypeId, to_char(or_order.task_type_id)) > 0
        AND or_order.order_status_id in
        (pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_ESTA_EJEC')
        );


        --/*--Inicio SS 100-9883    
        --Cursor para identificar al menos uan ot legalizada con el identificador
        --de causal de EXITO 
        CURSOR cuOtCausalExito(inuPackageId mo_packages.package_id%type,
                       sbTaskTypeId varchar2) is
        SELECT COUNT(*)
        FROM or_order_activity, or_order
        WHERE or_order_activity.package_id = inuPackageId
        AND or_order_activity.order_id = or_order.order_id
        AND instr(sbTaskTypeId, to_char(or_order.task_type_id)) > 0
        AND or_order.order_status_id in
         (pkg_BCLD_Parameter.fnuObtieneValorNumerico('ESTADO_CERRADO'))            
        AND DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(or_order.causal_id, null) =
         pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_IDE_CLA_CAU_EXITO')
        ;
      
        sbTipoSolicitud VARCHAR2(500) := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_TIPSOLICIANUL');  --TICKET 0015 --se almacenan tipo de solicitud a validar
        sbEstadoOrden VARCHAR2(500) := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_STAANULORD');  --TICKET 0015 --se almacenan estado de las ordenes a validar
        csbCodigoCaso CONSTANT VARCHAR2(30) := '000-0015'; --TICKET 0015 --se alamcena codigo del caso

        --TICKET 0015 -- se valida si la solicitud tiene ordenes pendiente
        CURSOR cuGetOrdenesPend IS
        SELECT COUNT(*)
        FROM or_order_activity oa, or_order o, mo_packages s
        where s.package_id = inuPackagesId 
        AND s.package_type_id in ( SELECT to_number(regexp_substr(sbTipoSolicitud,'[^,]+', 1, LEVEL)) 
                                     FROM   dual 
                                     CONNECT BY regexp_substr(sbTipoSolicitud, '[^,]+', 1, LEVEL) IS NOT NULL)
        AND oa.package_id = s.package_id
        AND OA.order_id = O.order_id
        AND o.order_status_id IN ( SELECT to_number(regexp_substr(sbEstadoOrden,'[^,]+', 1, LEVEL)) 
                                   FROM   dual 
                                   CONNECT BY regexp_substr(sbEstadoOrden, '[^,]+', 1, LEVEL) IS NOT NULL);
                                   
        
        CURSOR cuValidaAprobacion
        (
            inuSolicitud    IN  mo_packages.package_id%TYPE
        )
        IS
        SELECT  COUNT(package_id)
        FROM    personalizaciones.LDC_APPROVED_REQUESTS
        WHERE   package_id = inuSolicitud;

        sbPackagesType varchar2(2000);
        sbTaskTypeId   varchar2(2000);
        nuCount        number := 0;
        nuExistApproved    NUMBER := 0;

    BEGIN
        sbPackagesType := pkg_BCLD_Parameter.fsbObtieneValorCadena('ID_PKG_VALIDA_VENTA');
        IF instr(sbPackagesType,
             to_char(damo_packages.fnugetpackage_type_id(inuPackagesId))) > 0 THEN
             
            sbTaskTypeId := pkg_BCLD_Parameter.fsbObtieneValorCadena('ID_TT_VALIDA_VENTA');

            pkg_Traza.Trace('Solicitud [' || inuPackagesId ||
                         '] - Tipo de Trabajo [' || sbTaskTypeId || ']',
                         10);

            --NC 4298
            pkg_Traza.Trace('inicio cuOrdenBloqueada', 10);
            OPEN cuOrdenBloqueada(inuPackagesId, sbTaskTypeId);
            FETCH cuOrdenBloqueada INTO nuCount;
            CLOSE cuOrdenBloqueada;
            
            IF nuCount > 0 THEN
                pkg_Traza.Trace('Retornar --> ' || inuPackagesId, 10);
                RETURN inuPackagesId;
            END IF;
            pkg_Traza.Trace('fin cuOrdenBloqueada', 10);
            --fin NC4298

            --INICIO CASO 100-9983
            OPEN cuOtCausalExito(inuPackagesId, sbTaskTypeId);
            FETCH cuOtCausalExito INTO nuCount;
            CLOSE cuOtCausalExito;
            
            IF nuCount > 0 THEN
            
                OPEN cuValidaAprobacion(inuPackagesId);
                FETCH cuValidaAprobacion INTO nuExistApproved;
                CLOSE cuValidaAprobacion;
                
                IF (nuExistApproved = 0) THEN
                    RETURN - 1;
                END IF;
            END IF;
            --FIN CASO 100-9983 

            OPEN cuPackages(inuPackagesId, sbTaskTypeId);
            FETCH cuPackages INTO nuCount;
            CLOSE cuPackages;
            
            IF nuCount > 0 THEN
                RETURN - 1;
            END IF;

            RETURN inuPackagesId;

        ELSE
            --TICKET 0015 -- se valida si la entrega aplica para la gasera
            OPEN cuGetOrdenesPend;
            FETCH cuGetOrdenesPend INTO nuCount;
            CLOSE cuGetOrdenesPend;

            IF nuCount > 0 THEN        
              RETURN -1;
            END IF;
     
            RETURN inuPackagesId;
        END IF;
    EXCEPTION
    WHEN OTHERS THEN 
       RETURN inuPackagesId;
    end fnuGetPackagesVR;

     /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : pro_grabalog_comision
      Descripcion    : Procedimiento que graba el Log de los Jobs
      Autor          : F.Castro
      Fecha          : 07/02/2016

      Metodos

      Nombre         :
      Parametros         Descripcion
      ============  ===================


      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
     
      ******************************************************************/
    procedure pro_grabalog_comision (inusesion number, idtfecha date, inuhilo number, 
                                     inuresult number, isbobse varchar2) is
        PRAGMA AUTONOMOUS_TRANSACTION;                                             
    begin
        insert into ldc_log_salescomission 
                  (sesion, usuario, fecha_inicio, fecha_final, hilo, resultado, observacion)
           values (inusesion, user, idtfecha, sysdate, inuhilo, inuresult, isbobse);
        commit;
    end pro_grabalog_comision;

--------------------------------------------------------------------------------------------------------------
    PROCEDURE ProcessGOPCV
    IS

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbOBJECT_TYPE_ID ge_boInstanceControl.stysbValue;
    sbFECHA ge_boInstanceControl.stysbValue;
   
    BEGIN

        sbFECHA := ge_boInstanceControl.fsbGetFieldValue('SM_INTERFACE', 'NEXT_ATTEMP_DATE');
                ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------


        if (sbFECHA is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Fecha');
            raise ex.CONTROLLED_ERROR;
        end if;

        

        ------------------------------------------------
        -- User code
        ------------------------------------------------

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessGOPCV;
end LDC_BCSalesCommission;
/

