CREATE OR REPLACE PROCEDURE PBACUCARTOT
(
    inuProgramacion  IN ge_process_schedule.process_schedule_id%TYPE
)
IS
    /*******************************************************************************
    Nombre         :  PBACUCARTOT
    Descripcion    :  Proceso  para generar PBACUCARTOT
    Autor          :  Josh Brito / olsoftware
    Fecha          :  2020-07-08

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========       =========          ====================
    30/04/2024      jpinedc             OSF-2581: Se reemplaza ldc_sendemail por
                                        pkg_Correo.prcEnviaCorreo
    /*******************************************************************************/

    csbMetodo        CONSTANT VARCHAR2(70) := 'PBACUCARTOT';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    sbParametros    GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;
    nuHilos         NUMBER := 1;
    nuLogProceso    GE_LOG_PROCESS.LOG_PROCESS_ID%TYPE;

    nuTipoProducto  number;
    nuDepartamento  number;
    nuLocalidad     number;
    nuCategoria     number;
    nuAnoIni        number;
    nuMesInicial    number;

    rfCursor constants.tyRefCursor;

    TYPE rcAcuCartTotal IS RECORD(
    nuano                       number,
    numes                       number,
    tipo_producto               number,
    departa                     number,
    localid                     number,
    categoria                   number,
    total_cartera               number,
    total_vencida               number,
    cartera_a_mas_90_dias       number,
    cartera_tot_a_mas_90_dias   number,
    usuarios_mas_90_dias        number,
    usuarios_activos            number,
    fecha_reg                   date);

    TYPE tbAcuCartTotal IS TABLE OF rcAcuCartTotal;
    rfAcuCartTotal tbAcuCartTotal := tbAcuCartTotal();


    sbmessage     varchar2(2000);
    sbEmail         varchar2(50) := pkg_BCLD_Parameter.fsbObtieneValorCadena('PAREMAILNOTACUCATO');

    cursor cuEmails is
      select trim(column_value) email
      from table(ldc_boutilities.splitstrings(sbEmail, ','));
      
    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
    
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
     
    -- se adiciona al log de procesos
    ge_boschedule.AddLogToScheduleProcess(inuProgramacion,nuHilos,nuLogProceso);

    -- se obtiene parametros
    sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion);

    -- se extrae valores de los parametros
    nuTipoProducto := ut_string.getparametervalue(sbParametros, 'SERVSETI','|','=');
    nuDepartamento := ut_string.getparametervalue(sbParametros,'DEPARTAMENTO','|','=');
    nuLocalidad := ut_string.getparametervalue(sbParametros, 'LOCALIDAD','|','=');
    nuCategoria := ut_string.getparametervalue(sbParametros,'CATEGORY_ID','|','=');
    nuAnoIni := ut_string.getparametervalue(sbParametros, 'PEFAANO','|','=');
    nuMesInicial := ut_string.getparametervalue(sbParametros,'PEFAMES','|','=');

    open rfCursor for
      SELECT nuano,
		       numes,
		       tipo_producto,
		       nuDepartamento,
		       nuLocalidad,
		       nuCategoria,
		       NVL(SUM(total_cartera), 0) total_cartera,
		       NVL(SUM(total_vencida), 0) total_vencida,
		       --
		       (select SUM(caccsape)
		          from (select ic.*,
		                       ldc_edad_mes(TO_NUMBER((sELECT trunc(ci.cicofech)
		                                                      FROM ldc_ciercome ci
		                                                     WHERE ci.cicoano =
		                                                           nuAnoIni
		                                                       AND ci.cicomes = nuMesInicial
		                                                       and ci.cicoesta = 'S') -
		                                                   TRUNC(ic.caccfeve))) edad_mora
		                  from ic_cartcoco ic
		                 where ic.caccserv IN nuTipoProducto
		                   and ic.cacccate = DECODE(nuCategoria, -1, ic.cacccate , nuCategoria)
		                   and ic.caccnuse in
		                       (Select product_id
		                          From pr_product,
		                               ab_address ab,
		                               ge_geogra_location ge,
		                               ge_geogra_location ge1
		                         Where ab.address_id = pr_product.address_id
		                           And ge.geograp_location_id = ab.geograp_location_id
		                           And ge1.geograp_location_id = ge.geo_loca_father_id
		                           and ge.geo_loca_father_id =
		                               DECODE(nuDepartamento, -1, ge.geo_loca_father_id, nuDepartamento)
		                           and ge.geograp_location_id =
		                               DECODE(nuLocalidad, -1, ge.geograp_location_id, nuLocalidad)
		                           And pr_product.suspen_ord_act_id Is Null)
		                   and ic.caccfege = (SELECT trunc(ci.cicofech)
		                                        FROM ldc_ciercome ci
		                                       WHERE ci.cicoano = nuAnoIni
		                                         AND ci.cicomes = nuMesInicial
		                                         and ci.cicoesta = 'S'))
		         where edad_mora >= 120
		           and caccnaca = 'N') cartera_a_mas_90_dias,
		       --
		       NVL(SUM(cartera_tot_a_mas_90_dias), 0) cartera_tot_a_mas_90_dias,
		       NVL(SUM(usuarios_mas_90_dias), 0) usuarios_mas_90_dias,
		       NVL(SUM(usuarios_activos), 0) usuarios_activos,
		       SYSDATE
		  FROM (SELECT nuano,
		               numes,
		               t.tipo_producto,
		               NVL(SUM(t.total_cartera), 0) total_cartera,
		               ldc_fncrecuperadeudasval(t.nuano,
		                                             t.numes,
		                                             t.tipo_producto,
		                                             t.departamento,
		                                             t.localidad,
		                                             t.categoria,
		                                             1) total_vencida,
		               ldc_fncrecuperadeudasval(t.nuano,
		                                             t.numes,
		                                             t.tipo_producto,
		                                             t.departamento,
		                                             t.localidad,
		                                             t.categoria,
		                                             3) cartera_tot_a_mas_90_dias,
		               ldc_fncrecuperadeudasval(t.nuano,
		                                             t.numes,
		                                             t.tipo_producto,
		                                             t.departamento,
		                                             t.localidad,
		                                             t.categoria,
		                                             4) usuarios_mas_90_dias,
		               ldc_fncrecuperadeudasval(t.nuano,
		                                             t.numes,
		                                             t.tipo_producto,
		                                             t.departamento,
		                                             t.localidad,
		                                             t.categoria,
		                                             5) usuarios_activos
		          FROM total_cart_mes t
		         WHERE nuano = nuAnoIni
		           AND numes = nuMesInicial
		           AND t.departamento = DECODE(nuDepartamento, -1, t.departamento, nuDepartamento)
		           AND t.localidad = DECODE(nuLocalidad, -1, t.localidad, nuLocalidad)
		           AND t.tipo_producto IN nuTipoProducto
		           AND t.categoria = DECODE(nuCategoria, -1, t.categoria , nuCategoria)
		         GROUP BY nuano,
		                  numes,
		                  t.tipo_producto,
		                  t.departamento,
		                  t.localidad,
		                  t.categoria)
		GROUP BY nuano, numes, tipo_producto;

    loop
        fetch rfCursor bulk collect
          into rfAcuCartTotal limit 200;

          BEGIN
              forall i in 1..rfAcuCartTotal.count save exceptions
              insert into TABACUCARTOT values rfAcuCartTotal (i);
          exception
            when pkg_Error.CONTROLLED_ERROR then
              pkg_Error.getError(nuError, sbError);
              sbMessage := sbError ||' Error al insertar en la tabla TABACUCARTOT';
              pkg_error.setErrorMessage( isbMsgErrr => sbMessage);
            when others then
              pkg_Error.setError;
              pkg_Error.getError(nuError, sbError);
              sbMessage := sbError ||' Error al insertar en la tabla TABACUCARTOT';
              pkg_error.setErrorMessage( isbMsgErrr => sbMessage);
          END;

        EXIT WHEN rfCursor%NOTFOUND;

    end loop;
      commit;
    close rfCursor;

    FOR i IN cuEmails LOOP

        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => i.email,
            isbAsunto           => 'Notificacion Automatica [Ejecución PB PBACUCARTOT - ACUMULADOS CARTERA TOTAL]',
            isbMensaje          => '[Proceso terminó] - Consultar reporte LDRACUCARTOT'
        );      
      
    END LOOP;

    ge_boschedule.changelogProcessStatus(nuLogProceso,'F');

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);    
    
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);  
        RAISE;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
        raise pkg_Error.CONTROLLED_ERROR;
END PBACUCARTOT;
/
