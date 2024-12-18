CREATE OR REPLACE PACKAGE adm_person.ldc_pkdlrclpb AS
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   26/06/2024   OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
  PROCEDURE DLRCLPB;

  /****************************************************************
   Propiedad intelectual de Gases del Caribe S.A.
   Unidad         : VALID_DLRCLPB
   Descripcion    : Validacion de los valores ingresados en la forma PB LDC_DLRCLPBP (200-2060)
   Autor          : Daniel Valiente
   Fecha          : 03/08/2018

   Parametros              Descripcion
   ============         ===================

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
   ******************************************************************/
  PROCEDURE VALID_DLRCLPB;

/****************************************************************
   Propiedad intelectual de Gases del Caribe S.A.
   Unidad         : DLRCLPBP
   Descripcion    : Recibe los valores del PB LDC_DLRCLPBP (200-2060)
   Autor          : Daniel Valiente
   Fecha          : 03/08/2018

   Parametros              Descripcion
   ============         ===================

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
   ******************************************************************/
  PROCEDURE DLRCLPBP( inuDepart         NUMBER,
                     inulocali         NUMBER,
                     inubarrio         NUMBER,
                     inucatego         NUMBER,
                     inusubcat         NUMBER,
                     inuciclos         NUMBER,
                     inuestcor         NUMBER,
                     inuprodat         NUMBER,
                     inusegm           NUMBER);

/****************************************************************
   Propiedad intelectual de Gases del Caribe S.A.
   Unidad         : pro_grabalog
   Descripcion    : Registra en LDC_LOG_DLRCLPB el avance de las transacciones en los Hilos (200-2060)
   Autor          : Daniel Valiente
   Fecha          : 03/08/2018

   Parametros              Descripcion
   ============         ===================

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
   ******************************************************************/
  procedure pro_grabalog(inusesion  number,
                         inuproceso varchar2,
                         idtfecha   date,
                         inuhilo    number,
                         inuresult  number,
                         isbobse    varchar2);

/****************************************************************
   Propiedad intelectual de Gases del Caribe S.A.
   Unidad         : DLRCLPBHILOS
   Descripcion    : se encarga de la ejecucion secuencial de los Hilos de DLRCLPBP (200-2060)
   Autor          : Daniel Valiente
   Fecha          : 03/08/2018

   Parametros              Descripcion
   ============         ===================

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
   ******************************************************************/
  PROCEDURE DLRCLPBPHILOS( sbano             ldc_osf_sesucier.nuano%type,
                          sbmes             ldc_osf_sesucier.numes%type,
                          idttoday          date,
                          inuDepart         NUMBER,
                          inulocali         NUMBER,
                          inubarrio         NUMBER,
                          inucatego         NUMBER,
                          inusubcat         NUMBER,
                          inuciclos         NUMBER,
                          inuestcor         NUMBER,
                          inuprodat         NUMBER,
                          inusegm           NUMBER,
                          innuNroHilo       number,
                          innuTotHilos      number,
                          innusesion        number);

END LDC_pkDLRCLPB;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_pkDLRCLPB AS

  ------------------------------------------------------------------------
  PROCEDURE DLRCLPB IS

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe / Efigas S.A.

    Nombre del Proceso: DLRCLPB
    Descripcion: Proceso que llena la tabla LDC_DLRCLPB con toda la informacion de la consulta del reporte DLRCLPB - Clientes potenciales detallado brilla
                 extraida del reporte Crystal DLRCLPB, con la finalidad que desde la forma de PB se pueda mejorar el rendimiento del reporte original.

    Autor  : Ing.Francisco Jose Romero Romero, Ludycom S.A.
    Fecha  : 04-03-2016 (Fecha Creacion Paquete)  No Tiquete CA(100-8699)

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.        Modificacion
    -----------  -------------------    -------------------------------------

    ******************************************************************/
    cnuNULL_ATTRIBUTE constant number := 2126;

    nuprodat ge_boInstanceControl.stysbValue;
    nulocali ge_boInstanceControl.stysbValue;
    nuDepart ge_boInstanceControl.stysbValue;
    nuciclos ge_boInstanceControl.stysbValue;
    nucatego ge_boInstanceControl.stysbValue;
    nusubcat ge_boInstanceControl.stysbValue;
    nuestcor ge_boInstanceControl.stysbValue;
    nubarrio ge_boInstanceControl.stysbValue;
    nusegm   ge_boInstanceControl.stysbValue;
    nutisu   ge_boInstanceControl.stysbValue;

    nuExec_id NUMBER; -- Codigo del ejecutable del reporte
    nuCont    NUMBER; -- Conteo de registros para saber cada cuanto registros hago commit
    nusession NUMBER; -- Numero de sesion

    -- Obtiene la informacion del ejecutable a levantar
    CURSOR cuGetExecutable IS
      SELECT EXECUTABLE_ID
        FROM OPEN.SA_EXECUTABLE
       WHERE UPPER(NAME) = 'DLRCLPB';

    --Recorre datos base para actualizar el cupo usado
    CURSOR cuDatosBase IS
      SELECT T.CONTRATO FROM OPEN.LDC_DLRCLPB T;

    TYPE tytbData IS TABLE OF cuDatosBase%ROWTYPE INDEX BY BINARY_INTEGER; --Tomo el tipo del cursor
    tbData tytbData; --Variable tipo tabla basada en el cursor

  BEGIN
    DELETE FROM OPEN.LDC_OSF_ESTAPROC P WHERE P.PROCESO = 'LDC_DLRCLPB';
    COMMIT;

    --Control de registro que inicio y fin satisfactorio del proceso
    SELECT userenv('sessionid') INTO nusession FROM dual;
    ldc_proinsertaestaprog(to_number(to_char(sysdate, 'YYYY')),
                           to_number(to_char(sysdate, 'MM')),
                           'LDC_DLRCLPB',
                           'Inicia ejecucion..',
                           nusession,
                           USER);

    --Obtenemos los datos que vienen de filtro del PB
    nuprodat := ge_boInstanceControl.fsbGetFieldValue('GE_SUBSCRIBER',
                                                      'SUBSCRIBER_ID');
    nulocali := ge_boInstanceControl.fsbGetFieldValue('GE_ORGANIZAT_AREA',
                                                      'ORGANIZAT_AREA_ID');
    nuDepart := ge_boInstanceControl.fsbGetFieldValue('GE_ORGANIZAT_AREA',
                                                      'GEO_AREA_FATHER_ID');
    nuciclos := ge_boInstanceControl.fsbGetFieldValue('GE_ORGANIZAT_AREA',
                                                      'ORGANIZAT_AREA_TYPE');
    nucatego := ge_boInstanceControl.fsbGetFieldValue('GE_SUBSCRIBER',
                                                      'CATEGORY_ID');
    nusubcat := ge_boInstanceControl.fsbGetFieldValue('GE_SUBSCRIBER',
                                                      'COLLECT_PROGRAM_ID');
    nuestcor := ge_boInstanceControl.fsbGetFieldValue('GE_SUBSCRIBER',
                                                      'IDENT_TYPE_ID');
    nubarrio := ge_boInstanceControl.fsbGetFieldValue('PERIFACT',
                                                      'PEFACODI');
    --caso 200-350
   -- nutisu := ge_boInstanceControl.fsbGetFieldValue('SUSCRIPC', 'SUSCTISU');
    nusegm := ge_boInstanceControl.fsbGetFieldValue('LDC_SEGMENT_SUSC', 'SEGMENT_ID');

    --Validacion de atributos o filtros requeridos:
    IF (nuprodat IS NULL) THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Proteccion de Datos');
      RAISE ex.CONTROLLED_ERROR;
    END IF;

    IF (nulocali IS NULL) THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Localidad');
      RAISE ex.CONTROLLED_ERROR;
    END IF;

    IF (nuDepart IS NULL) THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Departamento');
      RAISE ex.CONTROLLED_ERROR;
    END IF;

    IF (nuciclos IS NULL) THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Ciclo');
      RAISE ex.CONTROLLED_ERROR;
    END IF;

    IF (nucatego IS NULL) THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Categoria');
      RAISE ex.CONTROLLED_ERROR;
    END IF;

    IF (nusubcat IS NULL) THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Subcategoria');
      RAISE ex.CONTROLLED_ERROR;
    END IF;

    IF (nuestcor IS NULL) THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Estado de Corte');
      RAISE ex.CONTROLLED_ERROR;
    END IF;

    IF (nubarrio IS NULL) THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Barrio');
      RAISE ex.CONTROLLED_ERROR;
    END IF;
    --caso200-350
    /*IF (nutisu IS NULL) THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Tipo Suscripcion');
      RAISE ex.CONTROLLED_ERROR;
    END IF;*/

    IF (nusegm IS NULL) THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Segmentacion');
      RAISE ex.CONTROLLED_ERROR;
    END IF;

    -----------------------------------------------

    --Limpiamos la tabla de resultados para usarla
    DELETE FROM OPEN.LDC_DLRCLPB;
    COMMIT;

    --Insertamos la informacion base a la tabla de resultados
    INSERT INTO OPEN.LDC_DLRCLPB
      (cod_dpto,
       desc_dpto,
       cod_localidad,
       desc_localidad,
       cod_barrio,
       desc_barrio,
       nombre_suscriptor,
       cedula,
       contrato,
       telefonos,
       correo,
       direccion,
       ciclo,
       mul,
       categoria,
       subcategoria,
       estado_corte,
       estado_conexion,
       cupo_asignado,
       manzana,
       num_predio,
       cuotas_pendientes,
       rutareparto,
       cupo_usado,
       fecha_nacimiento,
       genero,
       estado_civil,
       desc_estado_civil,
       grado_escolaridad,
       desc_grado_escolaridad,
       escala_salarial,
       desc_escala_salarial,
       profesion,
       desc_profesion,
       tipo_suscripcion,
       desc_tipo_suscripcion,
       segmentacion,
       desc_segmentacion,
       pagare_id)
      SELECT /*+ RULE */
      distinct null Cod_dpto,
               (SELECT ge.description
                  FROM Open.ge_geogra_location ge
                 WHERE ge.geograp_location_id =
                       ge_geogra_location.geo_loca_father_id) Desc_dpto,
               ge_geogra_location.geograp_location_id Cod_Localidad,
               ge_geogra_location.description Desc_localidad,
               null Cod_barrio,
               (SELECT ge.description
                  FROM Open.ge_geogra_location ge
                 WHERE ge.geograp_location_id = ab_address.neighborthood_id) Desc_barrio,
               cli.subscriber_name || ' ' || cli.subs_last_name || ' ' ||
               cli.subs_second_last_name Nombre_suscriptor,
               cli.identification Cedula,
               suscripc.susccodi Contrato,
               cli.phone Telefonos,
               cli.e_mail Correo,
               ab_address.address_parsed Direccion,
               suscripc.susccicl Ciclo,
               null Mul,
               (select ca.catedesc
                  from open.categori ca
                 where ca.catecodi = servsusc.sesucate) Categoria,
               (select sc.sucadesc
                  from open.subcateg sc
                 where sc.sucacate = servsusc.sesucate
                   and sc.sucacodi = servsusc.sesusuca) SubCategoria,
               (select ec.escodesc
                  from open.estacort ec
                 where ec.escocodi = servsusc.sesuesco) Estado_corte,
               (select ep.description
                  from open.ps_product_status ep
                 where ep.product_status_id = pr.product_status_id) Estado_conexion,
               (SELECT CB.QUOTA_VALUE CUPO
                  FROM OPEN.LD_QUOTA_BY_SUBSC CB
                 WHERE CB.SUBSCRIPTION_ID = suscripc.susccodi
                   AND ROWNUM = 1) Cupo_asignado,
               null manzana,
               null Num_predio,
               case
                 when (select count(1)
                         from Open.servsusc ser1
                        where ser1.sesususc = suscripc.susccodi
                          AND ser1.sesuserv IN (7055, 7056)) > 0 then
                  (SELECT SUM(nvl(dif.difenucu - dif.difecupa, 0))
                     FROM Open.diferido dif, Open.servsusc ser
                    WHERE dif.difesusc = suscripc.susccodi
                      AND ser.sesususc = suscripc.susccodi
                      AND dif.difenuse = ser.sesunuse
                      AND dif.difesape > 0
                      AND ser.sesuserv IN (7055, 7056))
                 else
                  0
               end Cuotas_pendientes,
               NULL RUTAREPARTO,
               -1   Cupo_Usado,
               ------200-350
               gd.date_birth,
               gd.gender,
               null civil_state_id,
               (select description
                  from open.GE_CIVIL_STATE
                 where CIVIL_STATE_ID = gd.civil_state_id) desc_estadoCivil,
               null school_degree_id,
               (select description
                  from open.GE_SCHOOL_DEGREE
                 where SCHOOL_DEGREE_ID = gd.school_degree_id) desc_GradoEsco,
               null wage_scale_id,
               (SELECT description
                  FROM OPEN.GE_WAGE_SCALE
                 WHERE WAGE_SCALE_ID = gd.wage_scale_id) DESC_EscSal,
               null profession_id,
               (select description
                  from open.ge_profession
                 where gd.profession_id = profession_id) desc_profe,
               null susctisu,
               null description,
               s.segment_id,
               cs.acronym || ' - ' || cs.description seg,
               (select pagare_id
                  from ldc_pagunidat
                 where suscription_id = susccodi
                   and estado =
                       (select numeric_value
                          from ld_parameter
                         where parameter_id = 'COD_EST_EN_PRO_PAG_UNI')
                          AND ROWNUM = 1) paga_uni
      ------------
        FROM Open.suscripc,
             Open.servsusc,
             Open.pr_product pr,
             Open.ldc_proteccion_datos,
             Open.ge_subscriber cli,
             Open.ge_geogra_location,
             Open.ab_address,
             open.ldc_info_predio d,
             -------200-350
             open.ldc_segment_susc        s,
             open.ldc_condit_commerc_segm cs,
             open.GE_SUBS_GENERAL_DATA    gd
       WHERE suscripc.suscclie = cli.subscriber_id
         AND suscripc.susccodi = servsusc.sesususc
         AND servsusc.sesuserv = 7014
         AND servsusc.sesunuse = pr.product_id
         and pr.product_type_id = 7014
         AND ab_address.address_id = pr.address_id
         AND ab_address.geograp_location_id =
             ge_geogra_location.geograp_location_id
         AND ab_address.estate_number = d.premise_id
         AND ldc_proteccion_datos.id_cliente = cli.subscriber_id
         AND ldc_proteccion_datos.estado = 'S'
         AND (ldc_proteccion_datos.cod_estado_ley =
             decode(nuprodat,
                     -1,
                     ldc_proteccion_datos.cod_estado_ley,
                     nuprodat) OR ldc_proteccion_datos.cod_estado_ley =
             decode(nuprodat, 2, 3, 3, 3, 1, 1))
         AND ge_geogra_location.geograp_location_id =
             decode(nulocali,
                    -1,
                    ge_geogra_location.geograp_location_id,
                    nulocali)
         AND ge_geogra_location.geo_loca_father_id =
             decode(nuDepart,
                    -1,
                    ge_geogra_location.geo_loca_father_id,
                    nuDepart)
         AND suscripc.susccicl =
             decode(nuciclos, -1, suscripc.susccicl, nuciclos)
         AND servsusc.sesusuca =
             decode(nusubcat, -1, servsusc.sesusuca, nusubcat)
         AND servsusc.sesucate =
             decode(nucatego, -1, servsusc.sesucate, nucatego)
         AND servsusc.sesuesco =
             decode(nuestcor, -1, servsusc.sesuesco, nuestcor)
         AND pr.subcategory_id =
             decode(nusubcat, -1, pr.subcategory_id, nusubcat)
         AND pr.category_id =
             decode(nucatego, -1, pr.category_id, nucatego)
         AND ab_address.neighborthood_id =
             decode(nubarrio, -1, ab_address.neighborthood_id, nubarrio)
            -----200-350
         and s.subscription_id = suscripc.susccodi
         and servsusc.sesususc = s.subscription_id
         and s.segment_id = cs.cond_commer_segm_id (+)
         and suscripc.suscclie = gd.subscriber_id
         /*and suscripc.susctisu =
             decode(nutisu, -1, suscripc.susctisu, nutisu)*/
         and s.segment_id = decode(nusegm, -1, s.segment_id, nusegm)
         -----------req 200-1220
         union
          SELECT /*+ RULE */
        distinct null Cod_dpto,
               (SELECT ge.description
                  FROM Open.ge_geogra_location ge
                 WHERE ge.geograp_location_id =
                       ge_geogra_location.geo_loca_father_id) Desc_dpto,
               ge_geogra_location.geograp_location_id Cod_Localidad,
               ge_geogra_location.description Desc_localidad,
               null Cod_barrio,
               (SELECT ge.description
                  FROM Open.ge_geogra_location ge
                 WHERE ge.geograp_location_id = ab_address.neighborthood_id) Desc_barrio,
               cli.subscriber_name || ' ' || cli.subs_last_name || ' ' ||
               cli.subs_second_last_name Nombre_suscriptor,
               cli.identification Cedula,
               suscripc.susccodi Contrato,
               cli.phone Telefonos,
               cli.e_mail Correo,
               ab_address.address_parsed Direccion,
               suscripc.susccicl Ciclo,
               null Mul,
               (select ca.catedesc
                  from open.categori ca
                 where ca.catecodi = servsusc.sesucate) Categoria,
               (select sc.sucadesc
                  from open.subcateg sc
                 where sc.sucacate = servsusc.sesucate
                   and sc.sucacodi = servsusc.sesusuca) SubCategoria,
               (select ec.escodesc
                  from open.estacort ec
                 where ec.escocodi = servsusc.sesuesco) Estado_corte,
               (select ep.description
                  from open.ps_product_status ep
                 where ep.product_status_id = pr.product_status_id) Estado_conexion,
               (SELECT CB.QUOTA_VALUE CUPO
                  FROM OPEN.LD_QUOTA_BY_SUBSC CB
                 WHERE CB.SUBSCRIPTION_ID = suscripc.susccodi
                   AND ROWNUM = 1) Cupo_asignado,
               null manzana,
               null Num_predio,
               case
                 when (select count(1)
                         from Open.servsusc ser1
                        where ser1.sesususc = suscripc.susccodi
                          AND ser1.sesuserv IN (7055, 7056)) > 0 then
                  (SELECT SUM(nvl(dif.difenucu - dif.difecupa, 0))
                     FROM Open.diferido dif, Open.servsusc ser
                    WHERE dif.difesusc = suscripc.susccodi
                      AND ser.sesususc = suscripc.susccodi
                      AND dif.difenuse = ser.sesunuse
                      AND dif.difesape > 0
                      AND ser.sesuserv IN (7055, 7056))
                 else
                  0
               end Cuotas_pendientes,
               NULL RUTAREPARTO,
               -1   Cupo_Usado,
               ------200-350
               gd.date_birth,
               gd.gender,
               null civil_state_id,
               (select description
                  from open.GE_CIVIL_STATE
                 where CIVIL_STATE_ID = gd.civil_state_id) desc_estadoCivil,
               null school_degree_id,
               (select description
                  from open.GE_SCHOOL_DEGREE
                 where SCHOOL_DEGREE_ID = gd.school_degree_id) desc_GradoEsco,
               null wage_scale_id,
               (SELECT description
                  FROM OPEN.GE_WAGE_SCALE
                 WHERE WAGE_SCALE_ID = gd.wage_scale_id) DESC_EscSal,
               null profession_id,
               (select description
                  from open.ge_profession
                 where gd.profession_id = profession_id) desc_profe,
               null susctisu,
               null description,
               s.segment_id,
               cs.acronym || ' - ' || cs.description seg,
               (select pagare_id
                  from ldc_pagunidat
                 where suscription_id = susccodi
                   and estado =
                       (select numeric_value
                          from ld_parameter
                         where parameter_id = 'COD_EST_EN_PRO_PAG_UNI')
                          AND ROWNUM = 1) paga_uni
      ------------
        FROM Open.suscripc,
             Open.servsusc,
             Open.pr_product pr,
             Open.ge_subscriber cli,
             Open.ge_geogra_location,
             Open.ab_address,
             open.ldc_info_predio d,
             -------200-350
             open.ldc_segment_susc        s,
             open.ldc_condit_commerc_segm cs,
             open.GE_SUBS_GENERAL_DATA    gd
       WHERE suscripc.suscclie = cli.subscriber_id
         AND suscripc.susccodi = servsusc.sesususc
         AND servsusc.sesuserv = 7014
         AND servsusc.sesunuse = pr.product_id
         and pr.product_type_id = 7014
         AND ab_address.address_id = pr.address_id
         AND ab_address.geograp_location_id =
             ge_geogra_location.geograp_location_id
         AND ab_address.estate_number = d.premise_id
         AND ge_geogra_location.geograp_location_id =
             decode(nulocali,
                    -1,
                    ge_geogra_location.geograp_location_id,
                    nulocali)
         AND ge_geogra_location.geo_loca_father_id =
             decode(nuDepart,
                    -1,
                    ge_geogra_location.geo_loca_father_id,
                    nuDepart)
         AND suscripc.susccicl =
             decode(nuciclos, -1, suscripc.susccicl, nuciclos)
         AND servsusc.sesusuca =
             decode(nusubcat, -1, servsusc.sesusuca, nusubcat)
         AND servsusc.sesucate =
             decode(nucatego, -1, servsusc.sesucate, nucatego)
         AND servsusc.sesuesco =
             decode(nuestcor, -1, servsusc.sesuesco, nuestcor)
         AND pr.subcategory_id =
             decode(nusubcat, -1, pr.subcategory_id, nusubcat)
         AND pr.category_id =
             decode(nucatego, -1, pr.category_id, nucatego)
         AND ab_address.neighborthood_id =
             decode(nubarrio, -1, ab_address.neighborthood_id, nubarrio)
            -----200-350
         and s.subscription_id = suscripc.susccodi
         and servsusc.sesususc = s.subscription_id
         and s.segment_id = cs.cond_commer_segm_id (+)
         and suscripc.suscclie = gd.subscriber_id
         /*and suscripc.susctisu =
             decode(nutisu, -1, suscripc.susctisu, nutisu)*/
         and s.segment_id = decode(nusegm, -1, s.segment_id, nusegm)
         ;
    COMMIT;

    --Inicializamos el contador para realizar commit cada 100 registros
    nuCont := 0;

    --Se recorre la poblacion
    OPEN cuDatosBase;
    LOOP

      --Borra tabla temporal
      tbData.delete;

      FETCH cuDatosBase BULK COLLECT
        INTO tbData LIMIT 10;

      IF (tbData.count > 0) THEN

        FOR nuIndex IN tbData.first .. tbData.last LOOP

          BEGIN
            --Luego actualizamos el cupo usado usando la funcion y el contrato de cada registro
            UPDATE LDC_DLRCLPB T
               SET T.CUPO_USADO = Open.ld_bononbankfinancing.fnugetusedquote(tbData(nuIndex)
                                                                             .CONTRATO)
             WHERE T.CONTRATO = tbData(nuIndex).CONTRATO;
            COMMIT;

          EXCEPTION
            WHEN OTHERS THEN
              ldc_proactualizaestaprog(nusession,
                                       SUBSTR('FALLO INSERCION: ' ||
                                              sqlerrm,
                                              1,
                                              2000),
                                       'LDC_DLRCLPB',
                                       'Termino con Error');
              GOTO ABORTAR;
          END;

          --Control de commit cada 100 registros
          nuCont := nuCont + 1;
          IF (nuCont >= 100) THEN
            COMMIT;
            nuCont := 0;
          END IF;

        END LOOP; -- Loop sobre la tabla tbData

      END IF; -- if validacion que la tabla (tbData) pl contenga registros

      EXIT WHEN(cuDatosBase%notfound);

    END LOOP; -- Loop sobre el cursor cuRegistros

    CLOSE cuDatosBase;

    COMMIT;

    --Se indica en la tabla de estado de proceso que termina
    ldc_proactualizaestaprog(nusession,
                             'Proceso Finalizado',
                             'LDC_DLRCLPB',
                             'Ok');

    --Obtiene el id del ejecutable de Crystal que se requiere
    OPEN cuGetExecutable;
    FETCH cuGetExecutable
      INTO nuExec_id;
    CLOSE cuGetExecutable;
    --Llamado al reporte de Crystal
    GE_BOIOpenExecutable.setonevent(nuExec_id, 'POST_REGISTER');

    <<ABORTAR>>
    NULL;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
      ldc_proactualizaestaprog(nusession,
                               SUBSTR('FALLO GENERAL: ' || sqlerrm, 1, 2000),
                               'LDC_DLRCLPB',
                               'Termino con Error');
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
      ldc_proactualizaestaprog(nusession,
                               SUBSTR('FALLO GENERAL: ' || sqlerrm, 1, 2000),
                               'LDC_DLRCLPB',
                               'Termino con Error');
  END DLRCLPB;

------------------------------------------------------------------------
  /****************************************************************
   Propiedad intelectual de Gases del Caribe S.A.
   Unidad         : VALID_DLRCLPB
   Descripcion    : Validacion de los valores ingresados en la forma PB LDC_DLRCLPBP (200-2060)
   Autor          : Daniel Valiente
   Fecha          : 03/08/2018

   Parametros              Descripcion
   ============         ===================

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
   ******************************************************************/
  PROCEDURE VALID_DLRCLPB IS

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbOBJECT_TYPE_ID ge_boInstanceControl.stysbValue;
    sbprodat         ge_boInstanceControl.stysbValue;
    sblocali         ge_boInstanceControl.stysbValue;
    sbDepart         ge_boInstanceControl.stysbValue;
    sbciclos         ge_boInstanceControl.stysbValue;
    sbcatego         ge_boInstanceControl.stysbValue;
    sbsubcat         ge_boInstanceControl.stysbValue;
    sbestcor         ge_boInstanceControl.stysbValue;
    sbbarrio         ge_boInstanceControl.stysbValue;
    sbsegm           ge_boInstanceControl.stysbValue;

  BEGIN

    sbprodat := ge_boInstanceControl.fsbGetFieldValue('GE_SUBSCRIBER','SUBSCRIBER_ID');
    sblocali := ge_boInstanceControl.fsbGetFieldValue('GE_ORGANIZAT_AREA','ORGANIZAT_AREA_ID');
    sbDepart := ge_boInstanceControl.fsbGetFieldValue('GE_ORGANIZAT_AREA','GEO_AREA_FATHER_ID');
    sbciclos := ge_boInstanceControl.fsbGetFieldValue('GE_ORGANIZAT_AREA','ORGANIZAT_AREA_TYPE');
    sbcatego := ge_boInstanceControl.fsbGetFieldValue('GE_SUBSCRIBER','CATEGORY_ID');
    sbsubcat := ge_boInstanceControl.fsbGetFieldValue('GE_SUBSCRIBER','COLLECT_PROGRAM_ID');
    sbestcor := ge_boInstanceControl.fsbGetFieldValue('GE_SUBSCRIBER','IDENT_TYPE_ID');
    sbbarrio := ge_boInstanceControl.fsbGetFieldValue('PERIFACT','PEFACODI');
    sbsegm := ge_boInstanceControl.fsbGetFieldValue('LDC_SEGMENT_SUSC','SEGMENT_ID');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    if (sbDepart is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Departamento');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (sblocali is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Localidad');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (sbbarrio is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Barrio');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (sbcatego is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Categoría');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (sbsubcat is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Sub-Categoría');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (sbciclos is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Ciclo');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (sbestcor is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Estado del Corte');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (sbprodat is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Protección de Datos');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (sbsegm is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Codigo de Segmentación');
      raise ex.CONTROLLED_ERROR;
    end if;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;

    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END VALID_DLRCLPB;

  /****************************************************************
   Propiedad intelectual de Gases del Caribe S.A.
   Unidad         : DLRCLPBP
   Descripcion    : Recibe los valores del PB LDC_DLRCLPBP (200-2060)
   Autor          : Daniel Valiente
   Fecha          : 03/08/2018

   Parametros              Descripcion
   ============         ===================

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
   ******************************************************************/
  PROCEDURE DLRCLPBP( inuDepart         NUMBER,
                     inulocali         NUMBER,
                     inubarrio         NUMBER,
                     inucatego         NUMBER,
                     inusubcat         NUMBER,
                     inuciclos         NUMBER,
                     inuestcor         NUMBER,
                     inuprodat         NUMBER,
                     inusegm           NUMBER) IS

    --Manejo de Hilos
    TYPE CUR_TYP IS REF CURSOR;
    c_cursor     CUR_TYP;
    sbQuery      varchar2(32000);
    nuHilosQ     number;
    dtToday      date := sysdate;
    nuMonth      number;
    nuYear       number;
    nusesion     number;
    nuTotReg     number;
    nuFinJobs    number(1);
    nuCont       number;
    nuresult     number(5);
    nujob        number;
    sbWhat       varchar2(4000);
    cursor cuJobs(nuInd number) is
      select resultado
        from LDC_LOG_DLRCLPB
       where sesion = nusesion
         and fecha_inicio = dtToday
         and hilo = nuind
         and proceso = 'LDC_DLRCLPBP'
         AND resultado in (-1, 2); -- -1 Termino con errores, 2 termino OK
    --fin variables Hilos

  BEGIN

    --Limpiamos la tabla de resultados para usarla
    DELETE FROM OPEN.LDC_DLRCLPB;
    COMMIT;

    --I HILOS
    select userenv('SESSIONID') into nusesion from dual;
    nuMonth := extract(month from dtToday);
    nuYear  := extract(year from dtToday);

    /*Eliminamos log de procesos de hilos*/
    DELETE FROM LDC_LOG_DLRCLPB
     WHERE sesion = nusesion
       and proceso = 'LDC_DLRCLPBP';
    commit;
    nuHilosQ := dald_parameter.fnuGetNumeric_Value('DLRCLPB_HILOS');

    LDC_pkDLRCLPB.pro_grabalog(nusesion,'LDC_DLRCLPBP',dtToday,0,0,'Inicia Proceso');

    LDC_pkDLRCLPB.pro_grabalog(nusesion,'LDC_DLRCLPBP',dtToday,0,0,'Inicia conteo regs a procesar con ' || nuHilosQ || ' hilo(s)');
    --F HILOS

    --I PB PROGRAMADO
    ldc_proinsertaestaprog(nuYear,nuMonth,'LDC_DLRCLPBP','Inicia ejecucion..',nusesion,USER);
    --F PB PROGRAMADO

    --I HILOS
    sbQuery := 'SELECT COUNT(*) FROM (
    SELECT /*+ RULE */
    suscripc.susccodi Contrato
    FROM Open.suscripc,
    Open.servsusc,
    Open.pr_product pr,
    Open.ldc_proteccion_datos,
    Open.ge_subscriber cli,
    Open.ge_geogra_location,
    Open.ab_address,
    open.ldc_info_predio d,
    open.ldc_segment_susc        s,
    open.ldc_condit_commerc_segm cs,
    open.GE_SUBS_GENERAL_DATA    gd
    WHERE suscripc.suscclie = cli.subscriber_id
    AND suscripc.susccodi = servsusc.sesususc
    AND servsusc.sesuserv = 7014
    AND servsusc.sesunuse = pr.product_id
    and pr.product_type_id = 7014
    AND ab_address.address_id = pr.address_id
    AND ab_address.geograp_location_id = ge_geogra_location.geograp_location_id
    AND ab_address.estate_number = d.premise_id
    AND ldc_proteccion_datos.id_cliente = cli.subscriber_id
    AND ldc_proteccion_datos.estado = ''S''
    AND (ldc_proteccion_datos.cod_estado_ley = decode(' || inuprodat || ',-1,ldc_proteccion_datos.cod_estado_ley,' || inuprodat || ')
    OR ldc_proteccion_datos.cod_estado_ley = decode(' || inuprodat || ', 2, 3, 3, 3, 1, 1))
    AND ge_geogra_location.geograp_location_id = decode(' || inulocali || ',-1,ge_geogra_location.geograp_location_id,' || inulocali || ')
    AND ge_geogra_location.geo_loca_father_id = decode(' || inuDepart || ',-1,ge_geogra_location.geo_loca_father_id,' || inuDepart || ')
    AND suscripc.susccicl = decode(' || inuciclos || ', -1, suscripc.susccicl, ' || inuciclos || ')
    AND servsusc.sesusuca = decode(' || inusubcat || ', -1, servsusc.sesusuca, ' || inusubcat || ')
    AND servsusc.sesucate = decode(' || inucatego || ', -1, servsusc.sesucate, ' || inucatego || ')
    AND servsusc.sesuesco = decode(' || inuestcor || ', -1, servsusc.sesuesco, ' || inuestcor || ')
    AND pr.subcategory_id = decode(' || inusubcat || ', -1, pr.subcategory_id, ' || inusubcat || ')
    AND pr.category_id = decode(' || inucatego || ', -1, pr.category_id, ' || inucatego || ')
    AND ab_address.neighborthood_id = decode(' || inubarrio || ', -1, ab_address.neighborthood_id, ' || inubarrio || ')
    and s.subscription_id = suscripc.susccodi
    and servsusc.sesususc = s.subscription_id
    and s.segment_id = cs.cond_commer_segm_id (+)
    and suscripc.suscclie = gd.subscriber_id
    and s.segment_id = decode(' || inusegm || ', -1, s.segment_id, ' || inusegm || ')
    union
    SELECT /*+ RULE */
    suscripc.susccodi Contrato
    FROM Open.suscripc,
    Open.servsusc,
    Open.pr_product pr,
    Open.ge_subscriber cli,
    Open.ge_geogra_location,
    Open.ab_address,
    open.ldc_info_predio d,
    open.ldc_segment_susc        s,
    open.ldc_condit_commerc_segm cs,
    open.GE_SUBS_GENERAL_DATA    gd
    WHERE suscripc.suscclie = cli.subscriber_id
    AND suscripc.susccodi = servsusc.sesususc
    AND servsusc.sesuserv = 7014
    AND servsusc.sesunuse = pr.product_id
    and pr.product_type_id = 7014
    AND ab_address.address_id = pr.address_id
    AND ab_address.geograp_location_id = ge_geogra_location.geograp_location_id
    AND ab_address.estate_number = d.premise_id
    AND ge_geogra_location.geograp_location_id = decode(' || inulocali || ',-1,ge_geogra_location.geograp_location_id,' || inulocali || ')
    AND ge_geogra_location.geo_loca_father_id = decode(' || inuDepart || ',-1,ge_geogra_location.geo_loca_father_id,' || inuDepart || ')
    AND suscripc.susccicl = decode(' || inuciclos || ', -1, suscripc.susccicl, ' || inuciclos || ')
    AND servsusc.sesusuca = decode(' || inusubcat || ', -1, servsusc.sesusuca, ' || inusubcat || ')
    AND servsusc.sesucate = decode(' || inucatego || ', -1, servsusc.sesucate, ' || inucatego || ')
    AND servsusc.sesuesco = decode(' || inuestcor || ', -1, servsusc.sesuesco, ' || inuestcor || ')
    AND pr.subcategory_id = decode(' || inusubcat || ', -1, pr.subcategory_id, ' || inusubcat || ')
    AND pr.category_id = decode(' || inucatego || ', -1, pr.category_id, ' || inucatego || ')
    AND ab_address.neighborthood_id = decode(' || inubarrio || ', -1, ab_address.neighborthood_id, ' || inubarrio || ')
    and s.subscription_id = suscripc.susccodi
    and servsusc.sesususc = s.subscription_id
    and s.segment_id = cs.cond_commer_segm_id (+)
    and suscripc.suscclie = gd.subscriber_id
    and s.segment_id = decode(' || inusegm || ', -1, s.segment_id, ' || inusegm || ')
    ) TABLA';

    OPEN c_cursor FOR sbQuery;
    FETCH c_cursor
      INTO nuTotReg;
    if nuTotReg is null then
      nuTotReg := -1;
    end if;
    close c_cursor;
    --F HILOS

    LDC_pkDLRCLPB.pro_grabalog(nusesion,'LDC_DLRCLPBP',dtToday,0,0,'Termina conteo regs a procesar. Nro Regs: ' || nuTotReg);

    if nuTotReg > 0 then
      if nuTotReg <= nuHilosQ then
        nuHilosQ := 1;
      end if;

      LDC_pkDLRCLPB.pro_grabalog(nusesion,'LDC_DLRCLPBP',dtToday,0,0,'Inicia creacion de los jobs');

      --I HILOS
      -- se crean los jobs y se ejecutan
      for rgJob in 1 .. nuHilosQ loop
        sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) ||
                  '   LDC_pkDLRCLPB.DLRCLPBPHilos(' ||
                  nuYear || ',' || chr(10) ||
                  '                                ' || nuMonth || ',' ||
                  chr(10) || '                                to_date(''' ||
                  to_char(dtToday, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                  chr(10) || '                                ' ||
                  inuDepart || ',' || chr(10) ||
                  '                                ' || inulocali || ',' ||
                  chr(10) ||
                  '                                ' || inubarrio || ',' ||
                  chr(10) ||
                  '                                ' || inucatego || ',' ||
                  chr(10) ||
                  '                                ' || inusubcat || ',' ||
                  chr(10) ||
                  '                                ' || inuciclos || ',' ||
                  chr(10) ||
                  '                                ' || inuestcor || ',' ||
                  chr(10) ||
                  '                                ' || inuprodat || ',' ||
                  chr(10) ||
                  '                                ' || inusegm || ',' ||
                  chr(10) ||
                  '                                ' || rgJob || ',' ||
                  chr(10) || '                                ' || nuHilosQ || ',' ||
                  chr(10) || '                                ' || nusesion || ');' ||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 2 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;

        LDC_pkDLRCLPB.pro_grabalog(nusesion,'LDC_DLRCLPBP',dtToday,0,0,'Creo job: ' || rgJob || ' Nro ' || nujob);

      end loop;

      -- se verifica si terminaron los jobs
      nuFinJobs := 0;
      while nuFinJobs = 0 loop
        nucont := 0;
        for i in 1 .. nuHilosQ loop
          open cujobs(i);
          fetch cujobs
            into nuresult;
          if cujobs%found then
            nucont := nucont + 1;
          end if;
          close cujobs;
        end loop;
        if nucont = nuHilosQ then
          nuFinJobs := 1;
        else
          DBMS_LOCK.SLEEP(60);
        end if;
      end loop;
      --F HILOS

      LDC_pkDLRCLPB.pro_grabalog(nusesion,'LDC_DLRCLPBP',dtToday,0,0,'Terminaron todos los hilos');

      ldc_proinsertaestaprog(nuYear,nuMonth,'LDC_DLRCLPBP','Proceso termino',nusesion,USER);

    else

      LDC_pkDLRCLPB.pro_grabalog(nusesion,'LDC_DLRCLPBP',dtToday,0,0,'LDC_pkDLRCLPB.DLRCLPBP con cero registros a procesar');

    end if;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
      ldc_proactualizaestaprog(nusesion,SUBSTR('FALLO GENERAL: ' || sqlerrm, 1, 2000),'LDC_DLRCLPBP','Termino con Error');
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
      ldc_proactualizaestaprog(nusesion,SUBSTR('FALLO GENERAL: ' || sqlerrm, 1, 2000),'LDC_DLRCLPBP','Termino con Error');
  END DLRCLPBP;

  /****************************************************************
   Propiedad intelectual de Gases del Caribe S.A.
   Unidad         : pro_grabalog
   Descripcion    : Registra en LDC_LOG_DLRCLPB el avance de las transacciones en los Hilos (200-2060)
   Autor          : Daniel Valiente
   Fecha          : 03/08/2018

   Parametros              Descripcion
   ============         ===================

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
   ******************************************************************/
  procedure pro_grabalog(inusesion  number,
                         inuproceso varchar2,
                         idtfecha   date,
                         inuhilo    number,
                         inuresult  number,
                         isbobse    varchar2) is
    PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    insert into LDC_LOG_DLRCLPB
      (sesion,
       proceso,
       usuario,
       fecha_inicio,
       fecha_final,
       hilo,
       resultado,
       observacion)
    values
      (inusesion,
       inuproceso,
       user,
       idtfecha,
       sysdate,
       inuhilo,
       inuresult,
       isbobse);
    commit;
  end pro_grabalog;

  /****************************************************************
   Propiedad intelectual de Gases del Caribe S.A.
   Unidad         : DLRCLPBHILOS
   Descripcion    : se encarga de la ejecucion secuencial de los Hilos de DLRCLPBP (200-2060)
   Autor          : Daniel Valiente
   Fecha          : 03/08/2018

   Parametros              Descripcion
   ============         ===================

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
   ******************************************************************/
  PROCEDURE DLRCLPBPHILOS( sbano             ldc_osf_sesucier.nuano%type,
                          sbmes             ldc_osf_sesucier.numes%type,
                          idttoday          date,
                          inuDepart         NUMBER,
                          inulocali         NUMBER,
                          inubarrio         NUMBER,
                          inucatego         NUMBER,
                          inusubcat         NUMBER,
                          inuciclos         NUMBER,
                          inuestcor         NUMBER,
                          inuprodat         NUMBER,
                          inusegm           NUMBER,
                          innuNroHilo       number,
                          innuTotHilos      number,
                          innusesion        number) IS

    tbSuscripc pktblsuscripc.tysusccodi;
    orfSuscripc pkConstante.tyRefCursor;
    nuSuscripc suscripc.susccodi%type;
    nuReg NUMBER:=0;

  begin

    ldc_proinsertaestaprog(sbano,sbmes,'LDC_DLRCLPBP','Inicia ejecucion Hilo: ' || innuNroHilo,innusesion,USER);

    LDC_pkDLRCLPB.pro_grabalog(innusesion,'LDC_DLRCLPBP',idttoday,innuNroHilo,1,'Inicia Hilo: ' || innuNroHilo);

    INSERT INTO OPEN.LDC_DLRCLPB
      (cod_dpto,
       desc_dpto,
       cod_localidad,
       desc_localidad,
       cod_barrio,
       desc_barrio,
       nombre_suscriptor,
       cedula,
       contrato,
       telefonos,
       correo,
       direccion,
       ciclo,
       mul,
       categoria,
       subcategoria,
       estado_corte,
       estado_conexion,
       cupo_asignado,
       manzana,
       num_predio,
       cuotas_pendientes,
       rutareparto,
       cupo_usado,
       fecha_nacimiento,
       genero,
       estado_civil,
       desc_estado_civil,
       grado_escolaridad,
       desc_grado_escolaridad,
       escala_salarial,
       desc_escala_salarial,
       profesion,
       desc_profesion,
       tipo_suscripcion,
       desc_tipo_suscripcion,
       segmentacion,
       desc_segmentacion,
       pagare_id)
    SELECT * FROM (
    SELECT /*+ RULE */
    distinct null Cod_dpto,
    (SELECT ge.description
    FROM Open.ge_geogra_location ge
    WHERE ge.geograp_location_id = ge_geogra_location.geo_loca_father_id) Desc_dpto,
    ge_geogra_location.geograp_location_id Cod_Localidad,
    ge_geogra_location.description Desc_localidad,
    null Cod_barrio,
    (SELECT ge.description
    FROM Open.ge_geogra_location ge
    WHERE ge.geograp_location_id = ab_address.neighborthood_id) Desc_barrio,
    cli.subscriber_name || ' ' || cli.subs_last_name || ' ' ||
    cli.subs_second_last_name Nombre_suscriptor,
    cli.identification Cedula,
    suscripc.susccodi Contrato,
    cli.phone Telefonos,
    cli.e_mail Correo,
    ab_address.address_parsed Direccion,
    suscripc.susccicl Ciclo,
    null Mul,
    (select ca.catedesc
    from open.categori ca
    where ca.catecodi = servsusc.sesucate) Categoria,
    (select sc.sucadesc
    from open.subcateg sc
    where sc.sucacate = servsusc.sesucate
    and sc.sucacodi = servsusc.sesusuca) SubCategoria,
    (select ec.escodesc
    from open.estacort ec
    where ec.escocodi = servsusc.sesuesco) Estado_corte,
    (select ep.description
    from open.ps_product_status ep
    where ep.product_status_id = pr.product_status_id) Estado_conexion,
    (SELECT CB.QUOTA_VALUE CUPO
    FROM OPEN.LD_QUOTA_BY_SUBSC CB
    WHERE CB.SUBSCRIPTION_ID = suscripc.susccodi
    AND ROWNUM = 1) Cupo_asignado,
    null manzana,
    null Num_predio,
    case
    when (select count(1)
    from Open.servsusc ser1
    where ser1.sesususc = suscripc.susccodi
    AND ser1.sesuserv IN (7055, 7056)) > 0 then
    (SELECT SUM(nvl(dif.difenucu - dif.difecupa, 0))
    FROM Open.diferido dif, Open.servsusc ser
    WHERE dif.difesusc = suscripc.susccodi
    AND ser.sesususc = suscripc.susccodi
    AND dif.difenuse = ser.sesunuse
    AND dif.difesape > 0
    AND ser.sesuserv IN (7055, 7056))
    else
    0
    end Cuotas_pendientes,
    NULL RUTAREPARTO,
    NULL  Cupo_Usado,
    gd.date_birth,
    gd.gender,
    null civil_state_id,
    (select description
    from open.GE_CIVIL_STATE
    where CIVIL_STATE_ID = gd.civil_state_id) desc_estadoCivil,
    null school_degree_id,
    (select description
    from open.GE_SCHOOL_DEGREE
    where SCHOOL_DEGREE_ID = gd.school_degree_id) desc_GradoEsco,
    null wage_scale_id,
    (SELECT description
    FROM OPEN.GE_WAGE_SCALE
    WHERE WAGE_SCALE_ID = gd.wage_scale_id) DESC_EscSal,
    null profession_id,
    (select description
    from open.ge_profession
    where gd.profession_id = profession_id) desc_profe,
    null susctisu,
    null description,
    s.segment_id,
    cs.acronym || ' - ' || cs.description seg,
    (select pagare_id
    from ldc_pagunidat
    where suscription_id = susccodi
    and estado = (select numeric_value
    from ld_parameter
    where parameter_id = 'COD_EST_EN_PRO_PAG_UNI')
    AND ROWNUM = 1) paga_uni
    FROM Open.suscripc,
    Open.servsusc,
    Open.pr_product pr,
    Open.ldc_proteccion_datos,
    Open.ge_subscriber cli,
    Open.ge_geogra_location,
    Open.ab_address,
    open.ldc_info_predio d,
    open.ldc_segment_susc        s,
    open.ldc_condit_commerc_segm cs,
    open.GE_SUBS_GENERAL_DATA    gd
    WHERE suscripc.suscclie = cli.subscriber_id
    AND suscripc.susccodi = servsusc.sesususc
    AND servsusc.sesuserv = 7014
    AND servsusc.sesunuse = pr.product_id
    and pr.product_type_id = 7014
    AND ab_address.address_id = pr.address_id
    AND ab_address.geograp_location_id = ge_geogra_location.geograp_location_id
    AND ab_address.estate_number = d.premise_id
    AND ldc_proteccion_datos.id_cliente = cli.subscriber_id
    AND ldc_proteccion_datos.estado = 'S'
    AND (ldc_proteccion_datos.cod_estado_ley = decode(inuprodat,-1,ldc_proteccion_datos.cod_estado_ley,inuprodat)
    OR ldc_proteccion_datos.cod_estado_ley = decode(inuprodat, 2, 3, 3, 3, 1, 1))
    AND ge_geogra_location.geograp_location_id = decode(inulocali,-1,ge_geogra_location.geograp_location_id,inulocali)
    AND ge_geogra_location.geo_loca_father_id = decode(inuDepart,-1,ge_geogra_location.geo_loca_father_id,inuDepart)
    AND suscripc.susccicl = decode(inuciclos, -1, suscripc.susccicl,inuciclos)
    AND servsusc.sesusuca = decode(inusubcat, -1, servsusc.sesusuca,inusubcat)
    AND servsusc.sesucate = decode(inucatego, -1, servsusc.sesucate,inucatego)
    AND servsusc.sesuesco = decode(inuestcor, -1, servsusc.sesuesco,inuestcor)
    AND pr.subcategory_id = decode(inusubcat, -1, pr.subcategory_id,inusubcat)
    AND pr.category_id = decode(inucatego, -1, pr.category_id,inucatego)
    AND ab_address.neighborthood_id = decode(inubarrio, -1, ab_address.neighborthood_id,inubarrio)
    and s.subscription_id = suscripc.susccodi
    and servsusc.sesususc = s.subscription_id
    and s.segment_id = cs.cond_commer_segm_id (+)
    and suscripc.suscclie = gd.subscriber_id
    and s.segment_id = decode(inusegm, -1, s.segment_id, inusegm)
    union
    SELECT /*+ RULE */
    distinct null Cod_dpto,
    (SELECT ge.description
    FROM Open.ge_geogra_location ge
    WHERE ge.geograp_location_id =
    ge_geogra_location.geo_loca_father_id) Desc_dpto,
    ge_geogra_location.geograp_location_id Cod_Localidad,
    ge_geogra_location.description Desc_localidad,
    null Cod_barrio,
    (SELECT ge.description
    FROM Open.ge_geogra_location ge
    WHERE ge.geograp_location_id = ab_address.neighborthood_id) Desc_barrio,
    cli.subscriber_name || ' ' || cli.subs_last_name || ' ' ||
    cli.subs_second_last_name Nombre_suscriptor,
    cli.identification Cedula,
    suscripc.susccodi Contrato,
    cli.phone Telefonos,
    cli.e_mail Correo,
    ab_address.address_parsed Direccion,
    suscripc.susccicl Ciclo,
    null Mul,
    (select ca.catedesc
    from open.categori ca
    where ca.catecodi = servsusc.sesucate) Categoria,
    (select sc.sucadesc
    from open.subcateg sc
    where sc.sucacate = servsusc.sesucate
    and sc.sucacodi = servsusc.sesusuca) SubCategoria,
    (select ec.escodesc
    from open.estacort ec
    where ec.escocodi = servsusc.sesuesco) Estado_corte,
    (select ep.description
    from open.ps_product_status ep
    where ep.product_status_id = pr.product_status_id) Estado_conexion,
    (SELECT CB.QUOTA_VALUE CUPO
    FROM OPEN.LD_QUOTA_BY_SUBSC CB
    WHERE CB.SUBSCRIPTION_ID = suscripc.susccodi
    AND ROWNUM = 1) Cupo_asignado,
    null manzana,
    null Num_predio,
    case
    when (select count(1)
    from Open.servsusc ser1
    where ser1.sesususc = suscripc.susccodi
    AND ser1.sesuserv IN (7055, 7056)) > 0 then
    (SELECT SUM(nvl(dif.difenucu - dif.difecupa, 0))
    FROM Open.diferido dif, Open.servsusc ser
    WHERE dif.difesusc = suscripc.susccodi
    AND ser.sesususc = suscripc.susccodi
    AND dif.difenuse = ser.sesunuse
    AND dif.difesape > 0
    AND ser.sesuserv IN (7055, 7056))
    else
    0
    end Cuotas_pendientes,
    NULL RUTAREPARTO,
    NULL  Cupo_Usado,
    gd.date_birth,
    gd.gender,
    null civil_state_id,
    (select description
    from open.GE_CIVIL_STATE
    where CIVIL_STATE_ID = gd.civil_state_id) desc_estadoCivil,
    null school_degree_id,
    (select description
    from open.GE_SCHOOL_DEGREE
    where SCHOOL_DEGREE_ID = gd.school_degree_id) desc_GradoEsco,
    null wage_scale_id,
    (SELECT description
    FROM OPEN.GE_WAGE_SCALE
    WHERE WAGE_SCALE_ID = gd.wage_scale_id) DESC_EscSal,
    null profession_id,
    (select description
    from open.ge_profession
    where gd.profession_id = profession_id) desc_profe,
    null susctisu,
    null description,
    s.segment_id,
    cs.acronym || ' - ' || cs.description seg,
    (select pagare_id
    from ldc_pagunidat
    where suscription_id = susccodi
    and estado = (select numeric_value
    from ld_parameter
    where parameter_id = 'COD_EST_EN_PRO_PAG_UNI')
    AND ROWNUM = 1) paga_uni
    FROM Open.suscripc,
    Open.servsusc,
    Open.pr_product pr,
    Open.ge_subscriber cli,
    Open.ge_geogra_location,
    Open.ab_address,
    open.ldc_info_predio d,
    open.ldc_segment_susc        s,
    open.ldc_condit_commerc_segm cs,
    open.GE_SUBS_GENERAL_DATA    gd
    WHERE suscripc.suscclie = cli.subscriber_id
    AND suscripc.susccodi = servsusc.sesususc
    AND servsusc.sesuserv = 7014
    AND servsusc.sesunuse = pr.product_id
    and pr.product_type_id = 7014
    AND ab_address.address_id = pr.address_id
    AND ab_address.geograp_location_id = ge_geogra_location.geograp_location_id
    AND ab_address.estate_number = d.premise_id
    AND ge_geogra_location.geograp_location_id = decode(inulocali,-1,ge_geogra_location.geograp_location_id,inulocali)
    AND ge_geogra_location.geo_loca_father_id = decode(inuDepart,-1,ge_geogra_location.geo_loca_father_id,inuDepart)
    AND suscripc.susccicl = decode( inuciclos , -1, suscripc.susccicl, inuciclos)
    AND servsusc.sesusuca = decode( inusubcat , -1, servsusc.sesusuca, inusubcat)
    AND servsusc.sesucate = decode( inucatego , -1, servsusc.sesucate, inucatego)
    AND servsusc.sesuesco = decode( inuestcor , -1, servsusc.sesuesco, inuestcor)
    AND pr.subcategory_id = decode( inusubcat, -1, pr.subcategory_id, inusubcat)
    AND pr.category_id = decode( inucatego , -1, pr.category_id, inucatego)
    AND ab_address.neighborthood_id = decode(inubarrio, -1, ab_address.neighborthood_id, inubarrio)
    and s.subscription_id = suscripc.susccodi
    and servsusc.sesususc = s.subscription_id
    and s.segment_id = cs.cond_commer_segm_id (+)
    and suscripc.suscclie = gd.subscriber_id
    and s.segment_id = decode(inusegm , -1, s.segment_id, inusegm)
    )tabla
    where mod(tabla.contrato, innuTotHilos) + innuNroHilo = innuTotHilos;

    OPEN orfSuscripc FOR 'SELECT T.CONTRATO FROM OPEN.LDC_DLRCLPB T WHERE T.CUPO_USADO IS NULL';

    FETCH orfSuscripc BULK COLLECT
      INTO tbSuscripc;
    CLOSE orfSuscripc;

    if tbSuscripc.count > 0 then
      for i in tbSuscripc.FIRST .. tbSuscripc.LAST loop
        nuReg := nuReg + 1;
        if tbSuscripc.EXISTS(i) then
          nuSuscripc := tbSuscripc(i);
          UPDATE LDC_DLRCLPB T
          SET T.CUPO_USADO = Open.ld_bononbankfinancing.fnugetusedquote(nuSuscripc)
          WHERE T.CONTRATO = nuSuscripc;
        end if;
      end loop;
    /*else
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error, 'No se encontraron registros para procesar, Favor validar');*/
    end if;

    COMMIT;

    LDC_pkDLRCLPB.pro_grabalog(innusesion,'LDC_DLRCLPBP',idttoday,innuNroHilo,2,'Se procesaron en el Hilo ' || innuNroHilo || ', ' || nuReg || ' Registros');

    LDC_pkDLRCLPB.pro_grabalog(innusesion,'LDC_DLRCLPBP',idttoday,innuNroHilo,2,'Termino Hilo: ' || innuNroHilo);

    ldc_proinsertaestaprog(sbano,sbmes,'LDC_DLRCLPBP','Proceso termino Hilo: ' || innuNroHilo,innusesion,USER);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      raise ex.CONTROLLED_ERROR;
    WHEN others THEN
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end DLRCLPBPHILOS;

END LDC_PKDLRCLPB;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKDLRCLPB
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKDLRCLPB', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS EXECUTE a REXEREPORTES sobre LDC_PKDLRCLPB
GRANT EXECUTE ON ADM_PERSON.LDC_PKDLRCLPB TO REXEREPORTES;
/   