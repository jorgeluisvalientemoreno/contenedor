CREATE OR REPLACE PACKAGE OPEN.ld_bcgenerationrandomsample IS

  -- Author  : LUDYCOM
  -- Created : 22/09/2012 02:49:43 p.m.
  -- Purpose : Componente de negocio que lleva a cabo la generacion de los archivos de la central de riesgo
  /***************************************************************************************
   Historia de Modificaciones

    Fecha           IDEntrega
	04-05-2022      CGONZALEZ - OSF-467: Se modifica el servicio <obtdatosdeudorprom> para validar si el traslado de deuda
										 tiene saldo pendiente
	04-05-2022      CGONZALEZ - OSF-260: Se modifica el servicio <obtdatosdeudorsubs> y <obtdatosdeudorprom> para obtener la
										 direccion de cobro del contrato.
    26-07-2018      HORBATH - Se cambian las consultas de los cursores para mejoramiento 200-1816

    19-04-2018      F.Castro - CA 200-1821
    Se modifica para que la marcacion se haga teniendo en cuenta si la edad de mora real
    al cierre es mayor al parametro EDAD_MORA_NOTI
    Igualmente, se modifica para que la fecha de vencimiento de la cuenta de cobro
    (payment_deadline_dc) sea la de la cuenta mas antigua con saldo

    14-10-2016      Sandra Mu?oz - CA 200-792
    Se agrega al cursor CU_SERVICIOS el campo VALOR_RECLAMO y al la variable tipo registr
    reg_suscrib_ser


    29-06-2016      CarenBerdejo
    Se modifican los cursores cu_diferido, cu_diferido_not_exists, cu_codeudor_dif,
    cu_codeudor_ser, cu_servicios y cu_servicios_not_exists

    15-04-2016      CarenBerdejo
    Se modifican los cursores cu_diferido, cu_diferido_not_exists, cu_codeudor_dif,
    cu_codeudor_ser, cu_servicios y cu_servicios_not_exists

    29-01-2014      slemusSAO2315254
    Se modifica el cursor cuota_mora para que traiga cero(0) en caso de que el valor sea nulo

    17-12-2013      smunozSAO227685
    Creacion del procedimiento proElimRegistrosAdicMuestra

    21-11-2013      smunozSAO213793
    Se realizan los ajustes necesarios para evitar que los valores nulos se graben con
    ceros en la base de datos, ya que para CIFIN los valores nulos deben imprimirse
    en el reporte con espacios.  Para DATACREDITO no se realizan modificaciones.
    Modificaciones realizadas:
    * Se crean variables para llenar los campos Term_cf, Card_class_dc, Payment_Date en
      cero o null dependiendo que central se este procesando.
    * Se modifican los procedimientos proInsLd_Random_Sample_Detai, proInsLd_Sample_Detai,
      proObtenerDatosDetail

    Se muestra el saldo inicial en miles.
    Procedimientos modificados: proInsLd_Random_Sample_Detai, proInsLd_Sample_Detai

    29-08-2013      JsilveraSAO215195
    Se actualiza paquete para que la validacion de las inconsistencias de datacredito tenga en cuenta el nivel

    29-08-2013      slemusSAO214386
    Se actualiza paquete para que la informacion de los diferidos tenga en cuenta todos los cargos
    que pertenecen al diferido

    27-08-2013      slemus213862
    Se realiza correcion del numero de facturas y se corrige la informacion del nombre del usuario
    para alinear a la izquierda

    26-08-2013     smunozSAO213366
    Se hace el ajuste a todos los queries que obtienen el numero de
    facturas pendientes por pago para diferidos, con el fin que tengan
    en cuenta los valores de reclamos tal y como se hace para los servicios
    Cursor modificado:  cu_diferidos, cuota_mora, cuotas_pagas, cuedadmora

    25-08-2013      slemusSAO213001
    Se realiza actualizacion del dato de la variable v_entity_code
    para que almacene el codigo de la entidad ante CIFIN.

    23-08-2013      smunozSAO213366
    Se completa con ceros a la derecha e izquierda para alcanzar
    la longitud que datacredito tiene para este tipo de archivos
    Procedimiento modificado fsbEstadoInconsistencia

    21-08-2013      smunozSAO213366
    Se obtiene la informacion para las variables dependiendo de la central que se este
    procesando. Procedimiento modificado: proObtieneDatosDetail.

    21-08-2013      smunozSAO213366
    Se realiza la correccion al campo nucount para que si esta en null se llene con 0.
    Procedimiento modificado proinsertld_error_account


    16-08-2013      slemusSAO213076
    Se realiza modificacion para realizar el reporte por factura, adicional se corrigen campos que
    reportan los valores en miles.

    12-08-2013      smunozSAO213366
    Se llena el campo que indica si el registro es de diferido o producto.
    Se toma la informacion de valores en reclamo.
    Procedimientos modificados: Proinsld_Sample_Detai, Proinsld_Random_Sample_Detai
    Cursores modificados: Cu_Servicios, Cu_Servicios_Not_Exists

    08-08-2013      smunozSAO213862
    Se genera la muestra por sector y producto.
    Procedimientos modificados: proSample, proSample_cont, proSample_fin,
    proParametros_Generales, proGenerationDif, proGenerationSe

    01-08-2013      smunozSAO213076
    Se aplican el formato de miles a los campos que muestran valores.
    Procedimientos modificados: proInsLd_Random_Sample_Detai, proInsLd_Sample_Detai
    Creacion de la funcion fnuValuesInMil

    30-07-2013      smunozSAO212456
    Se ajustan los procedimientos para que retorne correctamente las variables
    de error y sea registrar el resultado del proceso en ge_error_log.
    Se modifican las unidades de programa pbogenerationser, pbogenerationdif

    24-07-2013      smunozSAO212457
    Se ajusta el paquete para permitir registrar el avance del proceso
    Creacion proactualizaavance.
    Modificacion de los procesos: pbogenerationser, pbogenerationdif, proprocesadif,
    proprocesaser

    22-07-2013      smunozSAO212459
    Se ajusta el paquete para que sea posible reanudar la ejecucion a partir del punto
    donde se produjo algun error en la ejecucion inmediatamente anterior.
    Creacion p_borra_trace.
    Modificacion de los paquetes: prosample, proupdatesample_cont, prosample_cont,
    prosample_fin, proprocesadif, proprocesaser, pbogenerationdif, pbogenerationser

    16-07-2013      smunoz
    cu_servicios, cu_diferidos  - Se ajusta el ordenamiento aleatorio en los cursores
    de tal forma que solo aplique a los cursores de muestra y adicional a esto, primero
    de ordene aleatoriamente y por ultimo tome los datos que debe enviar a la muestra.

    10-07-2013      smunoz
    Modificacion proprocesadif y proprocesaser

    09-07-2013      smunoz
    Correccion de todas las consultas que podrian devolver null al realizar sum.
    Se aplico el filtro a la fecha de vencimiento en los cursores que lo requerian con el fin
    de solo buscar informacion con fecha de vencimiento menor al dia en que se esta
    ejecutando el reporte

    08-07-2013      smunoz
    Modificacion proSample.
    Modificacion proSampleCont.

    03-07-2013      smunoz
    Modificacion proobtenerdatosdetail

    03-07-2013      smunoz
    Modificacion proSample_Detai

    02-07-2013      smunoz
    Simplificacion de llamados a procedimientos aprovechando la declaracion de
    variables globales a nivel de paquete

    28-06-2013      smunoz
    Modificacion provalidadatosobligatorios

    27-06-2013      smunoz
    Modificacion provalidadatosobligatorios.
    Creacion fbestadoinconsistencia.

    20-06-2013      smunoz
    Eliminacion de variables no utiizadas en todo el paquete

    15-06-2013      smunoz
    Modificacion en pbogenerationdif y pbogenerationser

    20-05-2013      Javier Rodriguez
    Optimizacion de validaciones para generar el reporte



    DD-MM-2013      usuarioSAO######
    Descripcion breve, precisa y clara de la modificacion realizada.
  ****************************************************************************************/

  -- Cursores

  CURSOR cu_servicios(p_credit_bureau_id  ld_sample.credit_bureau_id%TYPE,
                      p_typesector        ld_sample.type_sector%TYPE,
                      p_typeproductid     ld_sample.type_product_id%TYPE,
                      p_category          ld_selection_criteria.category%TYPE,
                      p_overduebills      ld_selection_criteria.overdue_bills%TYPE,
                      p_repomuestra       VARCHAR2,
                      p_subscriber_number ld_random_sample.subscriber_number%TYPE,
                      p_nuano             NUMBER,
                      p_numes             NUMBER) IS
  -- Listar los servicios. Se ejecuta para generar muestra

  -- Se toma la informacion de valores en reclamo. Todos los calculos nvl(cucosacu, 0)
  -- se reemplazan por nvl(cucosacu, 0) - nvl(cucovare) - nvl(cucovrap, 0).
  -- Se elimina el condicional Totvare = 0. smunozSAO213366

    SELECT subscriber_id,
           ident_type_id,
           identification,
           sesunuse,
           subscriber_name,
           subs_last_name,
           subs_second_last_name,
           sesufein,
           sesucate,
           address,
           phone,
           e_mail,
           sesususc,
           geo_loca_father_id,
           geograp_location_id,
           sesuesfn,
           sesusuca,
           to_date(retire_date) retire_date,
           cuensald,
           sesuserv,
           valor_reclamo, -- CA 200-792
           COUNT(1) over() total
      FROM (SELECT subscriber_id,
                   ident_type_id,
                   identification,
                   sesunuse,
                   subscriber_name,
                   subs_last_name,
                   subs_second_last_name,
                   sesufein,
                   sesucate,
                   address,
                   phone,
                   e_mail,
                   sesususc,
                   geo_loca_father_id,
                   geograp_location_id,
                   sesuesfn,
                   sesusuca,
                   NULL retire_date,
                   cuensald,
                   sesuserv,
                   valor_reclamo -- CA 200-792
              FROM (SELECT subscriber_id,
                           ident_type_id,
                           identification,
                           sesunuse,
                           subscriber_name,
                           subs_last_name,
                           subs_second_last_name,
                           sesufein,
                           sesucate,
                           address,
                           phone,
                           e_mail,
                           sesususc,
                           geo_loca_father_id,
                           geograp_location_id,
                           sesuesfn,
                           sesusuca,
                           NULL retire_date,
                           cuensald,
                           sesuserv,
                           valor_reclamo -- CA 200-792
                      FROM (SELECT 1 subscriber_id,
                                   1 ident_type_id,
                                   '              ' identification,
                                   s.sesunuse,
                                   o.nombres subscriber_name,
                                   o.apellido subs_last_name,
                                   o.segundo_apellido subs_second_last_name,
                                   s.sesufein,
                                   o.categoria sesucate,
                                   NULL address,
                                   NULL phone,
                                   NULL e_mail,
                                   s.sesususc,
                                   o.departamento geo_loca_father_id,
                                   o.localidad geograp_location_id,
                                   o.estado_financiero sesuesfn,
                                   o.subcategoria sesusuca,
                                   NULL retire_date,
                                   o.edad cuensald,
                                   o.tipo_producto sesuserv,
                                   o.valor_reclamo -- CA 200-792
                              FROM servsusc s, ldc_osf_sesucier_T o
                             WHERE s.sesunuse = o.producto
                               AND o.estado_corte NOT IN
                                   (SELECT numercial_value
                                      FROM ld_general_parameters
                                     WHERE parameter_desc LIKE
                                           'ESTADO_CORTE_NO_REPORTA%')
                               AND o.nuano = p_nuano
                               AND o.numes = p_numes)
                     WHERE p_repomuestra = 'M'
                       AND cuensald >= p_overduebills
                       AND sesucate =
                           decode(p_category, -1, sesucate, p_category)
                       AND sesuserv = decode(p_typeproductid,
                                             -1,
                                             sesuserv,
                                             p_typeproductid))
             WHERE rownum <= p_subscriber_number
            UNION ALL
            SELECT subscriber_id,
                   ident_type_id,
                   identification,
                   sesunuse,
                   subscriber_name,
                   subs_last_name,
                   subs_second_last_name,
                   sesufein,
                   sesucate,
                   address,
                   phone,
                   e_mail,
                   sesususc,
                   geo_loca_father_id,
                   geograp_location_id,
                   sesuesfn,
                   sesusuca,
                   retire_date,
                   cuensald,
                   sesuserv,
                   valor_reclamo -- CA 200-792
              FROM (SELECT subscriber_id,
                           ident_type_id,
                           identification,
                           sesunuse,
                           subscriber_name,
                           subs_last_name,
                           subs_second_last_name,
                           sesufein,
                           sesucate,
                           address,
                           phone,
                           e_mail,
                           sesususc,
                           geo_loca_father_id,
                           geograp_location_id,
                           sesuesfn,
                           sesusuca,
                           retire_date,
                           cuensald,
                           sesuserv,
                           valor_reclamo -- CA 200-792
                      FROM (SELECT 1 subscriber_id,
                                   1 ident_type_id,
                                   ' ' identification,
                                   s.sesunuse,
                                   o.nombres subscriber_name,
                                   o.apellido subs_last_name,
                                   o.segundo_apellido subs_second_last_name,
                                   s.sesufein,
                                   o.categoria sesucate,
                                   NULL address,
                                   NULL phone,
                                   NULL e_mail,
                                   s.sesususc,
                                   o.departamento geo_loca_father_id,
                                   o.localidad geograp_location_id,
                                   o.estado_financiero sesuesfn,
                                   o.subcategoria sesusuca,
                                   NULL retire_date,
                                   o.edad cuensald,
                                   o.tipo_producto sesuserv,
                                   valor_reclamo -- CA 200-792
                              FROM servsusc s, ldc_osf_sesucier_T o
                             WHERE s.sesunuse = o.producto
                               AND o.estado_corte NOT IN
                                   (SELECT numercial_value
                                      FROM ld_general_parameters
                                     WHERE parameter_desc LIKE
                                           'ESTADO_CORTE_NO_REPORTA%')
                               AND o.nuano = p_nuano
                               AND o.numes = p_numes)
                     WHERE p_repomuestra = 'R'
                          --AND sesucate = decode('1', -1, sesucate, '1')
                       AND sesuserv = decode(p_typeproductid,
                                             -1,
                                             sesuserv,
                                             p_typeproductid)));

  CURSOR cu_servicios_not_exists(p_credit_bureau_id ld_sample.credit_bureau_id%TYPE,
                                 p_typeproductid    ld_sample.type_product_id%TYPE,
                                 p_category         ld_selection_criteria.category%TYPE,
                                 p_overduebills     ld_selection_criteria.overdue_bills%TYPE,
                                 p_nuano            NUMBER,
                                 p_numes            NUMBER) IS
  -- Lista los servicios de un suscriptor. Se ejecuta para generar reporte

  -- Se toma la informacion de valores en reclamo. Todos los calculos nvl(cucosacu, 0)
  -- se reemplazan por nvl(cucosacu, 0) - nvl(cucovare) - nvl(cucovrap, 0).
  -- Se elimina el condicional Totvare = 0. smunozSAO213366
    SELECT subscriber_id,
           ident_type_id,
           identification,
           sesunuse,
           subscriber_name,
           subs_last_name,
           subs_second_last_name,
           sesufein,
           sesucate,
           address,
           phone,
           e_mail,
           sesususc,
           geo_loca_father_id,
           geograp_location_id,
           sesuesfn,
           sesusuca,
           retire_date,
           cuensald,
           sesuserv,
           COUNT(1) over() total
      FROM (SELECT 1 subscriber_id,
                   1 ident_type_id,
                   ' ' identification,
                   s.sesunuse,
                   o.nombres subscriber_name,
                   o.apellido subs_last_name,
                   o.segundo_apellido subs_second_last_name,
                   s.sesufein,
                   o.categoria sesucate,
                   NULL address,
                   NULL phone,
                   NULL e_mail,
                   s.sesususc,
                   o.departamento geo_loca_father_id,
                   o.localidad geograp_location_id,
                   o.estado_financiero sesuesfn,
                   o.subcategoria sesusuca,
                   NULL retire_date,
                   o.edad cuensald,
                   o.tipo_producto sesuserv
              FROM servsusc s, ldc_osf_sesucier_T o
             WHERE s.sesunuse = o.producto
               AND o.nuano = p_nuano
               AND o.numes = p_numes)
     WHERE sesunuse = 51007038
          --AND sesucate = decode('1', -1, sesucate, '1')
       AND sesuserv =
           decode(p_typeproductid, -1, sesuserv, p_typeproductid)
       AND NOT EXISTS
     (SELECT 'x'
              FROM ld_reported_products lrp
             WHERE product_id = sesunuse
               AND credit_bureau = p_credit_bureau_id);

  CURSOR cu_diferido(p_amount            ld_selection_criteria.minimum_amount%TYPE,
                     p_subscriber_number ld_selection_criteria.subscriber_number%TYPE,
                     p_duebil            ld_selection_criteria.overdue_bills%TYPE,
                     p_category          ld_selection_criteria.category%TYPE,
                     p_typeproductid     ld_sample.type_product_id%TYPE,
                     p_repomuestra       VARCHAR2,
                     p_credit_bureau_id  ld_sample.credit_bureau_id%TYPE) IS
  --   Listar una muestra de obigaciones mediante parametro sbsubscriber_number

  /********************************************************************************************
                                                                                                                                                                                                                                                                                       */
    SELECT difecodi,
           difefein,
           difevatd,
           difesape,
           difenucu,
           difevacu,
           sesunuse,
           sesucate,
           sesususc,
           sesuesfn,
           sesusuca,
           sesuserv,
           cuensald,
           COUNT(1) over() total
      FROM (SELECT difecodi,
                   difefein,
                   difevatd,
                   difesape,
                   difenucu,
                   difevacu,
                   sesunuse,
                   sesucate,
                   sesususc,
                   sesuesfn,
                   sesusuca,
                   sesuserv,
                   cuensald
              FROM (SELECT DISTINCT difecodi,
                                    difefein,
                                    difevatd,
                                    difesape,
                                    difenucu,
                                    difevacu,
                                    sesunuse,
                                    sesucate,
                                    sesususc,
                                    sesuesfn,
                                    sesusuca,
                                    sesuserv,
                                    cuensald
                      FROM (SELECT d.difecodi,
                                   d.difefein,
                                   d.difevatd,
                                   d.difesape,
                                   d.difenucu,
                                   d.difevacu,
                                   s.sesunuse,
                                   s.sesucate,
                                   s.sesususc,
                                   s.sesuesfn,
                                   s.sesusuca,
                                   s.sesuserv,
                                   (SELECT COUNT(*)
                                      FROM cargos a, cuencobr u
                                     WHERE u.cuconuse = s.sesunuse
                                       AND nvl(u.cucosacu, 0) -
                                           nvl(u.cucovare, 0) -
                                           nvl(u.cucovrap, 0) > 0
                                       AND u.cucocodi = a.cargcuco
                                       AND a.cargdoso = 'DF-' || d.difecodi
                                       AND u.cucofeve < SYSDATE) cuensald
                              FROM diferido d, servsusc s
                             WHERE d.difenuse = s.sesunuse
                               AND sesucate =
                                   decode(p_category, -1, sesucate, p_category)
                               AND sesuserv =
                                   decode(p_typeproductid,
                                          -1,
                                          sesuserv,
                                          p_typeproductid))
                     WHERE p_repomuestra = 'M'
                       AND cuensald >= p_duebil
                       AND rownum <= p_subscriber_number)
            UNION ALL
            SELECT difecodi,
                   difefein,
                   difevatd,
                   difesape,
                   difenucu,
                   difevacu,
                   sesunuse,
                   sesucate,
                   sesususc,
                   sesuesfn,
                   sesusuca,
                   sesuserv,
                   cuensald
              FROM (SELECT d.difecodi,
                           d.difefein,
                           d.difevatd,
                           d.difesape,
                           d.difenucu,
                           d.difevacu,
                           s.sesunuse,
                           s.sesucate,
                           s.sesususc,
                           s.sesuesfn,
                           s.sesusuca,
                           s.sesuserv,
                           0 cuensald
                      FROM diferido d, servsusc s
                     WHERE p_repomuestra = 'R'
                       AND d.difenuse = s.sesunuse
                       AND sesucate =
                           decode(p_category, -1, sesucate, p_category)
                       AND sesuserv = decode(p_typeproductid,
                                             -1,
                                             sesuserv,
                                             p_typeproductid)
                       AND EXISTS
                     (SELECT 'x'
                              FROM ld_reported_deferred lrd
                             WHERE deferred_id = d.difecodi
                               AND credit_bureau = p_credit_bureau_id)));

  CURSOR cu_diferido_not_exists(p_amount           ld_selection_criteria.minimum_amount%TYPE,
                                p_duebil           ld_selection_criteria.overdue_bills%TYPE,
                                p_category         ld_selection_criteria.category%TYPE,
                                p_typeproductid    ld_sample.type_product_id%TYPE,
                                p_credit_bureau_id ld_sample.credit_bureau_id%TYPE) IS
  -- Cursor para listar obligaciones por suscripcion
    SELECT difecodi,
           difefein,
           difevatd,
           difesape,
           difenucu,
           difevacu,
           sesunuse,
           sesucate,
           sesususc,
           sesuesfn,
           sesusuca,
           sesuserv,
           cuensald,
           COUNT(1) over() total
      FROM (SELECT difecodi,
                   difefein,
                   difevatd,
                   difesape,
                   difenucu,
                   difevacu,
                   sesunuse,
                   sesucate,
                   sesususc,
                   sesuesfn,
                   sesusuca,
                   sesuserv,
                   cuensald
              FROM (SELECT d.difecodi,
                           d.difefein,
                           d.difevatd,
                           d.difesape,
                           d.difenucu,
                           d.difevacu,
                           s.sesunuse,
                           s.sesucate,
                           s.sesususc,
                           s.sesuesfn,
                           s.sesusuca,
                           s.sesuserv,
                           (SELECT COUNT(*)
                              FROM cargos a, cuencobr u
                             WHERE u.cuconuse = s.sesunuse
                               AND nvl(u.cucosacu, 0) - nvl(u.cucovare, 0) -
                                   nvl(u.cucovrap, 0) > 0
                               AND u.cucocodi = a.cargcuco
                               AND a.cargdoso = 'DF-' || d.difecodi
                               AND u.cucofeve < SYSDATE) cuensald
                      FROM diferido d, servsusc s
                     WHERE d.difenuse = s.sesunuse
                       AND sesucate =
                           decode(p_category, -1, sesucate, p_category)
                       AND sesuserv = decode(p_typeproductid,
                                             -1,
                                             sesuserv,
                                             p_typeproductid))
             WHERE cuensald >= p_duebil
               AND NOT EXISTS
             (SELECT 'x'
                      FROM ld_reported_deferred lrd
                     WHERE deferred_id = difecodi
                       AND credit_bureau = p_credit_bureau_id));

  CURSOR cu_codeudor_dif(p_cudifcodi diferido.difecodi%TYPE) IS
  --  Cursor para listar el codeudor de un obligacion solicitada
    SELECT DISTINCT p.promissory_id,
                    p.ident_type_id,
                    p.identification,
                    p.debtorname,
                    p.last_name,
                    a.address,
                    p.phone1_id,
                    p.email
      FROM ld_promissory p,
           ab_address a,
           (SELECT DISTINCT s.suscclie, c.subscriber_id, d.difecofi
              FROM diferido d, pagare p, fi_cosigner c, suscripc s
             WHERE p.pagacodi = c.promissory_note_id
               AND d.difecofi = p.pagacofi
               AND d.difesusc = s.susccodi
               AND d.difecodi = p_cudifcodi) financiacion
     WHERE p.address_id = a.address_id
       AND upper(p.promissory_type) = 'C'
       AND p.promissory_id = financiacion.subscriber_id;

  CURSOR cu_codeudor_ser(nupackage ld_promissory.package_id%TYPE,
                         pidentdeu ld_promissory.identification%TYPE) IS
    SELECT p.ident_type_id,
           identification,
           debtorname,
           last_name,
           (SELECT ge_geogra_location.description
              FROM ab_address, ge_geogra_location
             WHERE ab_address.address_id = p.address_id
               AND ab_address.geograp_location_id =
                   ge_geogra_location.geograp_location_id) city_desc,
           (SELECT ge_geogra_location.geograp_location_id
              FROM ab_address, ge_geogra_location
             WHERE ab_address.address_id = p.address_id
               AND ab_address.geograp_location_id =
                   ge_geogra_location.geograp_location_id) city,
           (SELECT ge_geogra_location.description
              FROM ge_geogra_location
             WHERE geograp_location_id IN
                   (SELECT ge_geogra_location.geo_loca_father_id
                      FROM ab_address, ge_geogra_location
                     WHERE ab_address.address_id = p.address_id
                       AND ab_address.geograp_location_id =
                           ge_geogra_location.geograp_location_id)) department_desc,
           daab_address.fsbgetaddress(p.address_id, 0) address_id,
           propertyphone_id,
           (SELECT ge_geogra_location.description
              FROM ab_address, ge_geogra_location
             WHERE ab_address.address_id = p.companyaddress_id
               AND ab_address.geograp_location_id =
                   ge_geogra_location.geograp_location_id) city_company_desc,
           (SELECT ge_geogra_location.geograp_location_id
              FROM ab_address, ge_geogra_location
             WHERE ab_address.address_id = p.companyaddress_id
               AND ab_address.geograp_location_id =
                   ge_geogra_location.geograp_location_id) city_company_id,
           (SELECT ge_geogra_location.description
              FROM ge_geogra_location
             WHERE geograp_location_id IN
                   (SELECT ge_geogra_location.geo_loca_father_id
                      FROM ab_address, ge_geogra_location
                     WHERE ab_address.address_id = p.companyaddress_id
                       AND ab_address.geograp_location_id =
                           ge_geogra_location.geograp_location_id)) departmentwork_desc,
           (SELECT address
              FROM ab_address
             WHERE ab_address.address_id = p.companyaddress_id) companyaddress_id,
           phone1_id,
           p.email
      FROM ld_promissory p
     WHERE p.package_id = nupackage
       AND upper(p.promissory_type) = 'C'
       AND p.identification <> pidentdeu;

  CURSOR cuselcrit(inutypesector     ld_selection_criteria.sector_id%TYPE,
                   inucreditbereauid ld_selection_criteria.credit_bureau%TYPE) IS
    SELECT minimum_amount, subscriber_number, overdue_bills, category
      FROM ld_selection_criteria
     WHERE sector_id = inutypesector
       AND credit_bureau = inucreditbereauid;

  -- Procedimientos

  PROCEDURE proelimregistrosadicmuestra(inurandom_sample_id ld_random_sample.random_sample_id%TYPE,
                                        nutotalreg          ld_random_sample.subscriber_number%TYPE);

  PROCEDURE pbogenerationser(p_inucreditbereauid    ld_random_sample.credit_bureau_id%TYPE,
                             p_inutypesector        ld_random_sample.type_sector%TYPE,
                             p_inutypeproductid     ld_random_sample.type_product_id%TYPE,
                             p_isbsubscriber_number ld_random_sample.subscriber_number%TYPE DEFAULT NULL,
                             p_innusampleid         ld_sample.sample_id%TYPE DEFAULT NULL,
                             p_insbtypegen          VARCHAR2 DEFAULT NULL,
                             p_ionutotalrec         IN OUT ld_sample_fin.number_of_record%TYPE,
                             p_ionutotalerr         IN OUT NUMBER,
                             p_ionutotalnov         IN OUT ld_sample_fin.sum_of_new%TYPE,
                             p_idtfechgen           DATE DEFAULT NULL,
                             p_isbrepomuestra       VARCHAR2,
                             p_onuerrorcode         OUT NUMBER,
                             p_osberrormessage      OUT VARCHAR2,
                             p_table_name_trace     OUT user_tables.table_name%TYPE,
                             p_operation_trace      OUT ld_trace_gen_report.operation%TYPE,
                             p_table_name_error     IN ld_trace_gen_report.table_name%TYPE,
                             p_operation_error      IN ld_trace_gen_report.operation%TYPE,
                             p_rec_procesados       IN OUT ld_trace_gen_report.operation%TYPE,
                             p_rec_a_procesar       IN NUMBER,
                             p_program_id           IN estaprog.esprprog%TYPE,
                             p_nucambiosector       IN VARCHAR2,
                             p_nucambioproducto     IN VARCHAR2);

  PROCEDURE pbogenerationdif(p_nucreditbereauid    ld_sample.credit_bureau_id%TYPE,
                             p_inutypesector       ld_sample.type_sector%TYPE,
                             p_inutypeproductid    ld_sample.type_product_id%TYPE,
                             p_innusampleid        ld_sample.sample_id%TYPE,
                             p_sbsubscriber_number ld_random_sample.subscriber_number%TYPE,
                             p_insbtypegen         VARCHAR2,
                             p_ionutotalrec        IN OUT ld_sample_fin.number_of_record%TYPE,
                             p_ionutotalerr        IN OUT NUMBER,
                             p_ionutotalnov        IN OUT ld_sample_fin.sum_of_new%TYPE,
                             p_idtfechgen          DATE,
                             p_onuerrorcode        OUT NUMBER,
                             p_osberrormessage     OUT VARCHAR2,
                             p_isbrepomuestra      VARCHAR2,
                             p_table_name_trace    OUT user_tables.table_name%TYPE,
                             p_operation_trace     OUT ld_trace_gen_report.operation%TYPE,
                             p_table_name_error    IN ld_trace_gen_report.table_name%TYPE,
                             p_operation_error     IN ld_trace_gen_report.operation%TYPE,
                             p_rec_procesados      IN OUT ld_trace_gen_report.operation%TYPE,
                             p_rec_a_procesar      IN NUMBER,
                             p_program_id          IN estaprog.esprprog%TYPE,
                             p_nucambiosector      IN VARCHAR2,
                             p_nucambioproducto    IN VARCHAR2);

  PROCEDURE proactualizaavance(p_sesunuse servsusc.sesunuse%TYPE);

  FUNCTION fsbclientedioautorizparaenvio(inuident_type_id   ld_send_authorized.ident_type_id%TYPE,
                                         isbidentification  ld_send_authorized.identification%TYPE,
                                         isbTipoResponsable ld_send_authorized.tipo_responsable%TYPE -- CA-200792. Tipo responsable
                                   --      inuidproduct       ld_send_authorized.product_id%TYPE
                                         ) RETURN VARCHAR2;

  PROCEDURE obtdatosdeudorprom(sesunuse       servsusc.sesunuse%TYPE,
                               nupackage_id   OUT ld_promissory.package_id%TYPE,
                               ident_type_id  OUT NUMBER,
                               identification OUT ld_promissory.identification%TYPE,
                               name_complete  OUT ld_promissory.debtorname%TYPE,
                               last_name      OUT ld_promissory.last_name%TYPE,
                               sbcityresdesc  OUT ge_geogra_location.description%TYPE,
                               nucityrescode  OUT ge_geogra_location.geograp_location_id%TYPE,
                               sbdepresdesc   OUT ge_geogra_location.description%TYPE,
                               address        OUT ab_address.address%TYPE,
                               property_phone OUT ld_promissory.propertyphone_id%TYPE,
                               sbcitywordesc  OUT ge_geogra_location.description%TYPE,
                               nucityworcode  OUT ge_geogra_location.geo_loca_father_id%TYPE,
                               sbdeprwordesc  OUT ge_geogra_location.description%TYPE,
                               sbworkadrress  OUT ab_address.address%TYPE,
                               phone1_id      OUT NUMBER,
                               email          OUT VARCHAR2);

  PROCEDURE obtdatosdeudorsubs(sesunuse       servsusc.sesunuse%TYPE,
                               ident_type_id  OUT ld_promissory.ident_type_id%TYPE,
                               identification OUT ld_promissory.identification%TYPE,
                               name_complete  OUT ld_promissory.debtorname%TYPE,
                               sbcityresdesc  OUT ge_geogra_location.description%TYPE,
                               nucityrescode  OUT ge_geogra_location.geograp_location_id%TYPE,
                               sbdepresdesc   OUT ge_geogra_location.description%TYPE,
                               address        OUT ab_address.address%TYPE,
                               property_phone OUT ld_promissory.propertyphone_id%TYPE,
                               sbcitywordesc  OUT ge_geogra_location.description%TYPE,
                               nucityworcode  OUT ge_geogra_location.geo_loca_father_id%TYPE,
                               sbdeprwordesc  OUT ge_geogra_location.description%TYPE,
                               sbworkadrress  OUT ab_address.address%TYPE,
                               phone1_id      OUT NUMBER,
                               email          OUT VARCHAR2);

  cnunull_attribute CONSTANT NUMBER := 2126;
  FUNCTION Fnc_EnvioNotificacion(IdMuestra NUMBER) RETURN BOOLEAN;
  PROCEDURE PRO_MARCARUSUARIOS;
  PROCEDURE PRO_MARCARUSUARIOS(sbSAMPLE_ID NUMBER);
  FUNCTION fnuAplicaEntrega200_792 RETURN NUMBER;

END ld_bcgenerationrandomsample;
/
CREATE OR REPLACE PACKAGE BODY OPEN.ld_bcgenerationrandomsample IS

  -- Entregas
  csbBSS_CAR_SMS_200792 VARCHAR2(400) := 'BSS_CAR_SMS_200792_3';

  -- excepciones
  exparametrosincompletos EXCEPTION;

  -- Constantes
  csbversion   CONSTANT VARCHAR2(250) := 'OSF-467';
  cdatacredito CONSTANT VARCHAR2(1) := 1;
  ccifin       CONSTANT VARCHAR2(1) := 2;
  cdiferido    CONSTANT VARCHAR2(1) := 1;
  cservicio    CONSTANT VARCHAR2(1) := 2;
  gsbPaquete   CONSTANT VARCHAR2(30) := 'ld_bcGenerationRandomSample';

  -- Variables recuperadas de los parametros con qu se llama el procedimiento principal

  inusampleid         ld_sample.sample_id%TYPE;
  insbtypegen         VARCHAR2(1);
  ionutotalrec        ld_sample_fin.number_of_record%TYPE;
  ionutotalnov        ld_sample_fin.sum_of_new%TYPE;
  idtfechgen          DATE;
  onuerrorcode        NUMBER;
  osberrormessage     VARCHAR2(4000);
  inucreditbereauid   ld_sample.credit_bureau_id%TYPE;
  inutypesector       ld_sample.type_sector%TYPE;
  inutypeproductid    ld_sample.type_product_id%TYPE;
  nucategory          ld_selection_criteria.category%TYPE;
  nuoverduebills      ld_selection_criteria.overdue_bills%TYPE;
  isbrepomuestra      VARCHAR2(10);
  sbsubscriber_number ld_random_sample.subscriber_number%TYPE;
  nuterm_contract_cf  ld_sample_detai.term_contract_cf%TYPE;
  nuavaliblequote     NUMBER := 0; -- cupo disponible brilla
  nuassignedquote     NUMBER := 0; -- cupo asignado brilla
  nuusedquote         NUMBER := 0; -- cupo usado brilla

  g_table_name_error ld_trace_gen_report.table_name%TYPE;
  g_operation_error  ld_trace_gen_report.operation%TYPE;
  g_table_name_trace ld_trace_gen_report.table_name%TYPE;
  g_operation_trace  ld_trace_gen_report.operation%TYPE;
  g_rec_procesados   NUMBER;
  g_rec_a_procesar   NUMBER;
  g_program_id       estaprog.esprprog%TYPE;
  g_nucambiosector   VARCHAR2(1);
  g_nucambioproducto VARCHAR2(1);

  -- Variables

  sesunuse       servsusc.sesunuse%TYPE;
  ident_type_id  ge_subscriber.ident_type_id%TYPE;
  nupackage      ld_promissory.package_id%TYPE;
  identification ld_promissory.identification%TYPE;
  name_complete  ld_promissory.debtorname%TYPE;
  last_name      ld_promissory.last_name%TYPE;
  sbcityresdesc  ge_geogra_location.description%TYPE;
  nucityrescode  ge_geogra_location.geograp_location_id%TYPE;
  sbdepresdesc   ge_geogra_location.description%TYPE;
  address        ab_address.address%TYPE;
  property_phone ld_promissory.propertyphone_id%TYPE;
  sbcitywordesc  ge_geogra_location.description%TYPE;
  nucityworcode  ge_geogra_location.geo_loca_father_id%TYPE;
  sbdeprwordesc  ge_geogra_location.description%TYPE;
  sbworkadrress  ab_address.address%TYPE;
  phone1_id      ld_promissory.phone1_id%TYPE;
  email          ld_promissory.email%TYPE;

  -- Variables numericas
  nusecuencia             NUMBER;
  respuesta               NUMBER(8);
  nudto                   NUMBER(8);
  nuduedt                 NUMBER(8);
  nucuomor                NUMBER(8);
  nufeulpa                NUMBER(8);
  nufelipa                NUMBER(8);
  nucuopag                NUMBER(8);
  nudtstatusorigin        NUMBER(8); --LD_STATUS_ORIGIN
  nuopdt                  NUMBER(8);
  nuduedate               NUMBER(8);
  nustorigin              NUMBER(8);
  nutypemoney             NUMBER(1);
  nutypewarr              NUMBER(1);
  nuinitial_issue_date_cf NUMBER(8);
  nutermination_date_cf   NUMBER(8);
  nutotalshare            NUMBER(3);
  nudiasdemora            NUMBER(10);
  nuvalinici              NUMBER(15);
  nuultimopasoejecutado   NUMBER; -- Indica cual fue el ultimo paso que se ejeucto antes de ocurrir un error.  Ultimo consecutivo: 151
  vnuinconsissincorregir  NUMBER;
  nuanogen                NUMBER(4);
  numesgen                NUMBER(2);

  -- Constantes
  cnurecord_ya_existe CONSTANT NUMBER(1) := 2; -- Reg. ya esta en BD

  -- Variables booleanas
  boencontrado   BOOLEAN;
  blnotification BOOLEAN;
  boinsdetail    BOOLEAN;
  blexisdp       BOOLEAN;
  blexislc       BOOLEAN;

  -- Variables de texto
  sbfullname  VARCHAR2(600); --FULL NAME
  v_sbdifoser VARCHAR2(1);
  sbestatus   VARCHAR2(1);

  -- Variables basadas en tabla
  v_initial_record_identifier ld_random_sample_cont.initial_record_identifier%TYPE;
  v_type_account              ld_random_sample_cont.type_account%TYPE;
  v_enlargement_goals         ld_random_sample_cont.enlargement_goals%TYPE;
  v_type_of_delivery          ld_random_sample_cont.type_of_delivery%TYPE;
  v_indicator_values_in_mil   ld_random_sample_cont.indicator_values_in_mil%TYPE;
  v_code_of_subscriber        ld_random_sample_cont.code_of_subscriber%TYPE;
  v_star_report_date          ld_random_sample_cont.star_report_date%TYPE;
  v_end_report_dat            ld_random_sample_cont.end_report_dat%TYPE;
  v_statement_date            ld_random_sample_cont.statement_date%TYPE;
  v_indicator_from            ld_random_sample_cont.indicator_from%TYPE;
  v_filler                    ld_random_sample_cont.filler%TYPE;
  v_type_of_record            ld_random_sample_cont.type_of_record%TYPE;
  v_code_package              ld_random_sample_cont.code_package%TYPE;
  v_entity_type               ld_random_sample_cont.entity_type%TYPE;
  v_type_report               ld_random_sample_cont.type_report%TYPE;
  v_entity_code               ld_random_sample_cont.entity_code%TYPE;
  v_reserved                  ld_random_sample_cont.reserved%TYPE;
  v_final_record_indicator    ld_random_sample_fin.final_record_indicator%TYPE;
  v_date_of_proccess          ld_random_sample_fin.date_of_process%TYPE;
  type_register_1             ld_record_type_cf.record_type_id%TYPE;
  type_register_2             ld_record_type_cf.record_type_id%TYPE;
  type_register_9             ld_record_type_cf.record_type_id%TYPE;
  nuuser_id                   sa_user.user_id%TYPE;
  gsberrmsg                   ge_error_log.description%TYPE;
  numethpay                   ld_method_payment_dc.method_payment_id%TYPE;
  sbaccstatcf                 ld_account_status_cf.account_state_id%TYPE;
  sbaccstatdc                 ld_account_status_dc.account_state_id%TYPE;
  nutypeport                  ld_type_portfolio_cf.type_portfolio_id%TYPE;
  nulinecred                  ld_line_credit_cf.line_credit_id%TYPE;
  sbinfpack                   ld_information_packets_cf.information_packets_id%TYPE;
  sbtypcont                   ld_type_contract_cf.type_contract_id%TYPE;
  nustatobl                   ld_state_obligation_cf.state_obligation_id%TYPE;
  nucount                     ld_sample_detai.detail_sample_id%TYPE := 0;
  nudebttodc                  ld_sample_detai.debt_to_dc%TYPE; --DEBT_TO_DC
  nudebt                      ld_sample_detai.debt_to_dc%TYPE;
  numontvalue                 ld_sample_detai.monthly_value%TYPE;
  sbradoff                    sistema.sistempr%TYPE;
  nuvalmor                    cargos.cargvalo%TYPE;
  dtfemven                    cuencobr.cucofeve%TYPE;
  nuedamora                   ld_sample_detai.mora_age%TYPE;
  nuyearmora                  ld_sample_detai.mora_years_cf%TYPE;
  v_new_portfolio             ld_sample_detai.new_portfolio_id_dc%TYPE := 0;
  nuvalpen                    cuencobr.cucovato%TYPE;
  nusalpen                    diferido.difesape%TYPE;
  sbnomdepa                   ge_geogra_location.description%TYPE;
  sbnomloca                   ge_geogra_location.description%TYPE;
  nutypobl                    ld_general_parameters.numercial_value%TYPE;
  ident_type_cf               ld_type_identificat_cf.type_identificacion_id%TYPE;
  ident_type_dc               ld_type_identificat_dc.type_identificacion_id%TYPE;
  nuamount                    ld_selection_criteria.minimum_amount%TYPE;

  -- sao226523 SANMUN 06-12-2013. Siempre se trabaja con el numero de suscriptores que
  -- ingresa por parametro al procedimiento
  --nusubscribernumber          ld_selection_criteria.subscriber_number%Type;
  v_sum_of_new                ld_sample_fin.sum_of_new%TYPE := 0; --Number(8) := 0;
  nuerrorcount                ld_error_account.error_id%TYPE := 0; --Number := 0;
  accoutn_error               ld_error_account.error_id%TYPE := 0; --Number(2);
  g_reportar_codeudor_central ld_general_parameters.text_value%TYPE;
  sbservice_category          ld_sample_detai.service_category%TYPE;
  sbscore                     ld_sample_detai.score%TYPE;
  nucodereport                ld_sample_detai.sample_id%TYPE;
  nudeucodedt                 ld_sample_detai.situation_holder_dc%TYPE;
  sbdeucodecf                 ld_sample_detai.quality_cf%TYPE;
  nuterm_cf                   ld_sample_detai.term_cf%TYPE; -- smunozSAO223793 20-11-2013 Se envia el dato vacio a la tabla
  nucard_class_dc             ld_sample_detai.card_class_dc%TYPE; -- Clase tarjeta. SAO223793

  -- Tipo de registro
  TYPE reg_suscrib_ser IS RECORD(
    subscriber_id         NUMBER(15),
    ident_type_id         NUMBER(15),
    identification        VARCHAR2(15),
    sesunuse              ldc_osf_sesucier.producto%TYPE,
    subscriber_name       ldc_osf_sesucier.nombres%TYPE,
    subs_last_name        ldc_osf_sesucier.apellido%TYPE,
    subs_second_last_name ldc_osf_sesucier.apellido%TYPE,
    sesufein              servsusc.sesufein%TYPE,
    sesucate              ldc_osf_sesucier.categoria%TYPE,
    address               VARCHAR2(100),
    phone                 VARCHAR2(50),
    e_mail                VARCHAR2(100),
    sesususc              ldc_osf_sesucier.contrato%TYPE,
    geo_loca_father_id    ldc_osf_sesucier.departamento%TYPE,
    geograp_location_id   ldc_osf_sesucier.localidad%TYPE,
    sesuesfn              ldc_osf_sesucier.estado_financiero%TYPE,
    sesusuca              ldc_osf_sesucier.subcategoria%TYPE,
    retire_date           DATE,
    cuensald              NUMBER,
    sesuserv              ldc_osf_sesucier.tipo_producto%TYPE,
    total                 NUMBER,
    valor_reclamo         ldc_osf_sesucier.valor_reclamo%TYPE); -- CA200-792

  TYPE reg_suscrib_dif IS RECORD(
    subscriber_id         ge_subscriber.subscriber_id%TYPE,
    ident_type_id         ge_subscriber.ident_type_id%TYPE,
    identification        ge_subscriber.identification%TYPE,
    difecodi              diferido.difecodi%TYPE,
    subscriber_name       ge_subscriber.subscriber_name%TYPE,
    subs_last_name        ge_subscriber.subs_last_name%TYPE,
    subs_second_last_name ge_subscriber.subs_second_last_name%TYPE,
    difefein              diferido.difefein%TYPE,
    sesucate              servsusc.sesucate%TYPE,
    difevatd              diferido.difevatd%TYPE,
    difesape              diferido.difesape%TYPE,
    difenucu              diferido.difenucu%TYPE,
    difevacu              diferido.difevacu%TYPE,
    address               ge_subscriber.address%TYPE,
    phone                 ge_subscriber.phone%TYPE,
    e_mail                ge_subscriber.e_mail%TYPE,
    sesunuse              servsusc.sesunuse%TYPE,
    sesususc              servsusc.sesususc%TYPE,
    sesuesfn              servsusc.sesuesfn%TYPE,
    sesusuca              servsusc.sesusuca%TYPE,
    geo_loca_father_id    ge_geogra_location.geo_loca_father_id%TYPE,
    geograp_location_id   ge_geogra_location.geograp_location_id%TYPE,
    cuensald              VARCHAR2(100),
    sesuserv              servsusc.sesuserv%TYPE,
    total                 NUMBER);

  -- Cursores

  CURSOR cuota_mora(nuservsu   servsusc.sesunuse%TYPE,
                    nudiferido diferido.difecodi%TYPE) IS
  -- Cursor para obtener al cuota de mora

  -- Se toma la informacion de valores en reclamo. Todos los calculos nvl(cucosacu, 0)
  -- se reemplazan por nvl(cucosacu, 0) - nvl(cucovare) - nvl(cucovrap, 0).  smunozSAO213366

    SELECT nvl(SUM(decode(cargsign, 'DB', cargvalo, cargvalo * -1)), 0),
           COUNT(DISTINCT(factpefa)) total
      FROM cuencobr, factura, cargos
     WHERE cucofact = factcodi
       AND cuconuse = nuservsu
       AND cargcuco = cucocodi
       AND cargdoso LIKE '%-' || nudiferido
          --And nvl(cucosacu, 0) > 0
       AND nvl(cucosacu, 0) - nvl(cucovare, 0) - nvl(cucovrap, 0) > 0
       AND cucofeve < trunc(v_statement_date)
       AND factfege <= v_statement_date HAVING
     SUM(decode(cargsign, 'DB', cargvalo, cargvalo * -1)) > 0;

  CURSOR cuotas_pagas(nuservsu   servsusc.sesunuse%TYPE,
                      nudiferido diferido.difecodi%TYPE) IS
  -- Se toma la informacion de valores en reclamo. Todos los calculos nvl(cucosacu, 0)
  -- se reemplazan por nvl(cucosacu, 0) - nvl(cucovare) - nvl(cucovrap, 0).  smunozSAO213366
  -- Cursor para obtener cuotas pagas
    SELECT COUNT(DISTINCT(factpefa))
      FROM cuencobr, factura
     WHERE cucofact = factcodi
       AND cuconuse = nuservsu
          --And nvl(cucosacu, 0) = 0
       AND nvl(cucosacu, 0) - nvl(cucovare, 0) - nvl(cucovrap, 0) = 0
       AND factfege <= v_statement_date
       AND EXISTS (SELECT cargcuco
              FROM cargos
             WHERE cargcuco = cucocodi
               AND cargdoso = 'DF-' || nudiferido);

  CURSOR cufechpago(nuservsu   servsusc.sesunuse%TYPE,
                    nudiferido diferido.difecodi%TYPE) IS
  -- Para obtener las fechas de cuenta de cobro

  /*  SELECT nvl(to_number(to_char(MAX(cucofepa), 'yyyymmdd')), 0) fepa,
           nvl(to_number(to_char(MAX(cucofeve), 'yyyymmdd')), 0) feve
      FROM cuencobr, factura
     WHERE cucofact = factcodi
       AND cuconuse = nuservsu
       AND factfege <= v_statement_date
       AND EXISTS (SELECT cargcuco
              FROM cargos
             WHERE cargnuse = cuconuse
               AND cargcuco = cucocodi
               AND cargdoso = 'DF-' || nudiferido);*/
       SELECT nvl(to_number(to_char(MAX(cucofepa), 'yyyymmdd')), 0) fepa
        FROM cuencobr, factura
       WHERE cuconuse = nuservsu
         AND cucofact = factcodi
         AND factfege <= v_statement_date
         AND cucofepa <= v_statement_date
         AND EXISTS (SELECT cargcuco
              FROM cargos
             WHERE cargnuse = cuconuse
               AND cargcuco = cucocodi
               AND cargdoso = 'DF-' || nudiferido);

CURSOR cufechvenc (nuservsu   servsusc.sesunuse%TYPE,
                        nudiferido diferido.difecodi%TYPE) IS
  -- Para obtener las fechas de cuenta de cobro

      SELECT nvl(to_number(to_char(MIN(caccfeve), 'yyyymmdd')), 0) feve
        FROM ic_cartcoco
       WHERE caccfege = v_statement_date
         AND caccnuse = nuservsu
         AND caccnaca = 'N'
         AND EXISTS (SELECT cargcuco
              FROM cargos
             WHERE cargnuse = caccnuse
               AND cargcuco = cacccuco
               AND cargdoso = 'DF-' || nudiferido);

  CURSOR cuedadmora(nuservsu   servsusc.sesunuse%TYPE,
                    nudiferido diferido.difecodi%TYPE) IS
  -- Cursor para obtener la edad de mora
  -- Se toma la informacion de valores en reclamo. Todos los calculos nvl(cucosacu, 0)
  -- se reemplazan por nvl(cucosacu, 0) - nvl(cucovare) - nvl(cucovrap, 0).  smunozSAO213366
    SELECT MIN(cucofeve)
      FROM cuencobr, factura
     WHERE cucofact = factcodi
       AND cuconuse = nuservsu
          --And nvl(cucosacu, 0) > 0
       AND nvl(cucosacu, 0) - nvl(cucovare, 0) - nvl(cucovrap, 0) > 0
       AND cucofeve < trunc(v_statement_date)
       AND factfege <= v_statement_date
       AND EXISTS (SELECT cargcuco
              FROM cargos
             WHERE cargnuse = cuconuse
               AND cargcuco = cucocodi
               AND cargdoso = 'DF-' || nudiferido
               AND cargsign = 'DB');

  FUNCTION fsbremovechars(i_input VARCHAR2, nulength NUMBER) RETURN VARCHAR AS
    l_temp   VARCHAR2(3000);
    o_output VARCHAR2(3000);
    i        NUMBER;
  BEGIN
    FOR i IN 1 .. nvl(length(i_input), 1) LOOP
      SELECT substr(i_input, i, 1) INTO l_temp FROM dual;
      IF l_temp IS NOT NULL THEN
        IF ascii(l_temp) >= 48 AND ascii(l_temp) <= 57 THEN
          o_output := o_output || l_temp;
        END IF;
      END IF;
    END LOOP;
    o_output := substr(o_output, 1, nulength);
    RETURN o_output;
  END fsbremovechars;

  FUNCTION fsbname(sbname VARCHAR2) RETURN VARCHAR2 AS
    sbfirstname VARCHAR2(30);
    sblastname  VARCHAR2(30);
    sboutname   VARCHAR2(30);
  BEGIN
    sbfirstname := substr(sbname, 1, instr(sbname, ' ', 1));
    sblastname  := substr(sbname, instr(sbname, ' ', 1) + 1, length(sbname));
    sboutname   := rpad(sbfirstname, 15, ' ') || rpad(sblastname, 15, ' ');
    RETURN(sboutname);
  END;

  PROCEDURE p_borra_trace IS
    /***************************************************************
    Proposito:   Eliminar la marca de error en el sistma cuando el reporte
                se ejecuta por segunda vez y el error queda corregido

    Historia de Modificaciones

    Fecha           IDEntrega
    22-07-2013      smunozSAO212459
    Creacion.
    ****************************************************************/

  BEGIN
    IF g_table_name_error = g_table_name_trace AND
       g_operation_error = g_operation_trace THEN
      DELETE ld_trace_gen_report;
      COMMIT;
    END IF;
  END;

  PROCEDURE proinsertld_error_account(isbaccount_number        ld_error_account.account_number%TYPE,
                                      inuidentification_number ld_error_account.identification_number%TYPE,
                                      inutype_identification   ld_error_account.type_identification%TYPE,
                                      isberror_message         ld_error_account.error_message%TYPE) IS
    /******************************************************************
    Proposito:  Crear registro en la tabla LD_ERROR_ACCOUNT
    Historia de Modificaciones

    Fecha           IDEntrega

    21-08-2013      smunozSAO213366
    Se realiza la correccion al procedimiento, para que si el campo nuerrorcount
    llega vacio, se inicialice con 0.

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

  BEGIN

    nuultimopasoejecutado := 150;
    nuerrorcount          := nvl(nuerrorcount, 0) + 1;

    nuultimopasoejecutado := 160;
    INSERT INTO ld_error_account
      (error_id,
       account_number,
       full_name,
       identification_number,
       sample_id,
       statement_date,
       type_identification,
       type_of_report,
       type_sector,
       credit_bureau,
       error_message)
    VALUES
      (nuerrorcount,
       isbaccount_number,
       sbfullname,
       inuidentification_number,
       nusecuencia,
       v_statement_date,
       inutype_identification,
       isbrepomuestra,
       inutypesector,
       inucreditbereauid,
       isberror_message);
  EXCEPTION
    WHEN OTHERS THEN
      pkerrors.pop;
      gsberrmsg := nuultimopasoejecutado || ' - ' || SQLERRM;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);

  END proinsertld_error_account;

  PROCEDURE proregistrarerror(inutype_identification   IN ld_random_sample_detai.type_identification_cf%TYPE,
                              inuidentification_number IN ld_random_sample_detai.identification_number%TYPE,
                              isbaccount_number        IN ld_random_sample_detai.account_number%TYPE) IS
    /******************************************************************
    Proposito:  Crear registro en la tabla ld_error_account
    Historia de Modificaciones

    Fecha           IDEntrega

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

  BEGIN
    proinsertld_error_account(isbaccount_number        => isbaccount_number,
                              inuidentification_number => inuidentification_number,
                              inutype_identification   => inutype_identification,
                              isberror_message         => nuultimopasoejecutado ||
                                                          ' - ' || SQLERRM);
  END proregistrarerror;

  FUNCTION fnc_validacodeudor(nuidentification ld_sample_detai.identification_number%TYPE)
    RETURN BOOLEAN IS
    /*********************Historial de Modificaciones*************************

    Fecha              Usuario
    17-08-2013       JsilveraSAO210144
    Proceso que valida si el codeudor fue o no notificado . y si fue notificado debe tener 20 dias la generacion
    de la notificacion

    *************************************************************************/

    /*Declaracion de Cursores*/
    CURSOR curnotification IS
      SELECT d.*
        FROM ld_detail_notification d, ld_notification n
       WHERE d.detail_id = n.notification_id
         AND n.notification_id =
             (SELECT MAX(t.detail_id) FROM ld_detail_notification t)
         AND d.document_number = nuidentification;
    num_dias        NUMBER;
    sbdummy         VARCHAR2(200);
    regnotification curnotification%ROWTYPE;
    resuldias       NUMBER;
    valido          BOOLEAN := TRUE;
    no_valido       BOOLEAN := FALSE;

  BEGIN
    /*Obtiene el valor del numeor de dias*/
    provapatapa('NRO_DIAS_REPORT', 'N', num_dias, sbdummy);

    /*Abre el cursor de las notificacion*/
    OPEN curnotification;
    FETCH curnotification
      INTO regnotification;

    /*Verificar si encuentro Datos*/
    IF (curnotification%FOUND) THEN

      resuldias := trunc(SYSDATE) - trunc(regnotification.register_date);

      IF (resuldias >= num_dias) THEN
        RETURN valido; -- valido para reportar ser reportado
      ELSE
        RETURN no_valido; -- no valido para reportarse ante la central de riesgo
      END IF;
    END IF;

    /*Si el cursor esta abierto.. cierrelo*/
    IF (curnotification%ISOPEN) THEN
      CLOSE curnotification;
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END fnc_validacodeudor;

  FUNCTION fnc_validacalifcodeudor(inutype           IN ld_sample_detai.type_identification_cf%TYPE, -- Tipo de identificacion
                                   inuidentification IN ld_sample_detai.identification_number%TYPE,
                                   sbestado          IN VARCHAR2, -- Estado (N: nuevo, V: viejo)
                                   sbestafina        IN servsusc.sesuesfn%TYPE, -- Esatdo financiero
                                   inusampleant      IN ld_sample_detai.sample_id%TYPE, -- identificador del reporte anterior
                                   nuaccount_number  IN ld_sample_detai.account_number%TYPE) -- numero de obligacion
   RETURN NUMBER IS
    /**************Historia de Modificacion**************************
    Fecha          usuario
    17-08-2013    JsilveraSAO210144
    Proceso que valida si el usuario entr el lapso de tiempo que hay entre la notificacion
    a la generacion del reporte tuvo cambio de calificacion

    Retorna
    1: Reporte
    2: No Reporta
    3: Reporta Mes anterior

    ****************************************************************/
    CURSOR curcodeudor IS
      SELECT d.score
        FROM ld_detail_notification d, ld_notification l
       WHERE d.notification_id = l.notification_id
         AND l.notification_id IN
             (SELECT MAX(ld_notification.notification_id)
                FROM ld_notification)
         AND d.document_number = inuidentification
         AND d.document_type = inutype;

    CURSOR cursampleanterior IS
      SELECT d.score
        FROM ld_sample_detai d
       WHERE d.sample_id = inusampleant
         AND d.account_number = nuaccount_number;

    regestafina   cursampleanterior%ROWTYPE; -- Estado financiero
    regcodudeudor ld_detail_notification.score%TYPE;
    resul         BOOLEAN;

  BEGIN

    /*Usuario nuevo*/

    IF (sbestado = 'N') THEN
      OPEN curcodeudor;
      FETCH curcodeudor
        INTO regcodudeudor;
      -- si encuentra en la entidad codeudor
      IF (curcodeudor%FOUND) THEN
        resul := fnc_validacodeudor(nuidentification => inuidentification); -- Valido si es reportado
        IF (resul = TRUE) THEN
          RETURN 1; -- reportar a la fecha
        ELSE
          RETURN 2; -- no reportar
        END IF;
      ELSE
        RETURN 2; -- no reportar
      END IF;

      CLOSE curcodeudor;
    END IF;

    IF (curcodeudor%ISOPEN) THEN
      CLOSE curcodeudor;
    END IF;

    -- Estado del usuario viejo
    IF (sbestado = 'V') THEN
      IF (sbestafina IN ('C', 'D')) THEN
        OPEN curcodeudor;
        FETCH curcodeudor
          INTO regestafina;
        IF (curcodeudor%FOUND) THEN
          CLOSE curcodeudor;
          resul := fnc_validacodeudor(nuidentification => inuidentification); -- Valido si es reportado
          IF (resul = TRUE) THEN
            RETURN 1; -- reportar a la fecha
          ELSE
            RETURN 2; -- no reportar
          END IF;
        ELSE
          -- NO FUE NOTIFICADO
          CLOSE curcodeudor;
          OPEN cursampleanterior;
          FETCH cursampleanterior
            INTO regestafina;
          CLOSE cursampleanterior;
          IF (regestafina.score = 'N') THEN
            RETURN 1; -- reportar a la fecha
          ELSE
            RETURN 3; -- reportar con el mes anterior

          END IF; -- end if calificacion positiva
        END IF; -- end if no notificado

        IF (curcodeudor%ISOPEN) THEN
          CLOSE curcodeudor;
        END IF;
      END IF; --  end if calificacion negativa
      RETURN 1; --reportar al dia
    END IF; -- end if usuario viejo

  EXCEPTION
    WHEN OTHERS THEN
      proregistrarerror(inutype, inuidentification, nuaccount_number);

  END fnc_validacalifcodeudor;

  PROCEDURE pro_atrasa_cartera(nuidreportactual   IN ld_sample.sample_id%TYPE, -- Numero del reporte actual
                               nuidreportanterior IN ld_sample.sample_id%TYPE, -- Numero del reporte anterior
                               inuobligation      IN ld_sample_detai.account_number%TYPE) IS
    -- Numero de obligacion

    PRAGMA AUTONOMOUS_TRANSACTION;
    /***************************Historial de Modificacion *******************************
    Fecha             Usuario
    17-08-2013       JsilveraSAO209648
    Proceso que se encarga de borrar ne la tabla del reporte de cartera el registro del suscriptor
    para enviarlo con la informacion del rpeorte pasado en el caso que el codeudor no ha sido notifcado
    **************************************************************************************/

    CURSOR curreporteanterior IS
      SELECT *
        FROM ld_sample_detai d
       WHERE d.account_number = inuobligation
         AND d.sample_id = nuidreportanterior;

    regcurreporteanterior curreporteanterior%ROWTYPE;

  BEGIN

    --  Borra el registro de este suscriptor en el mes presente

    EXECUTE IMMEDIATE 'Delete * From ld_sample_detai d Where d.account_number = Inuobligation and d.sample_id = ' ||
                      nuidreportactual;

    -- Inserta los datos del suscriptor del reporte anterior
    BEGIN
      OPEN curreporteanterior;
      FETCH curreporteanterior
        INTO regcurreporteanterior;
      CLOSE curreporteanterior;

      INSERT INTO ld_sample_detai
        (type_identification_dc,
         type_identification_cf,
         identification_number,
         record_type_id_cf,
         full_name,
         account_number,
         branch_office_cf,
         situation_holder_dc,
         opening_date,
         due_date_dc,
         responsible_dc,
         type_obligation_id_dc,
         mortgage_subsidy_dc,
         date_subsidy_dc,
         type_contract_id_cf,
         state_of_contract_cf,
         term_contract_cf,
         term_contract_dc,
         method_payment_id_cf,
         method_payment_id_dc,
         periodicity_id_dc,
         periodicity_id_cf,
         new_portfolio_id_dc,
         state_obligation_cf,
         situation_holder_cf,
         account_state_id_dc,
         date_status_origin,
         source_state_id,
         date_status_account,
         status_plastic_dc,
         date_status_plastic_dc,
         adjetive_dc,
         date_adjetive_dc,
         card_class_dc,
         franchise_dc,
         private_brand_name_dc,
         type_money_dc,
         type_warranty_dc,
         ratings_dc,
         probability_default_dc,
         mora_age,
         initial_values_dc,
         debt_to_dc,
         value_available,
         monthly_value,
         value_delay,
         total_shares,
         shares_canceled,
         shares_debt,
         clause_permanence_dc,
         date_clause_permanence_dc,
         payment_deadline_dc,
         payment_date,
         radication_office_dc,
         city_radication_office_dc,
         city_radi_offi_dane_cod_dc,
         residential_city_dc,
         city_resi_offi_dane_cod_dc,
         residential_department_dc,
         residential_address_dc,
         residential_phone_dc,
         city_work_dc,
         city_work_dane_code_dc,
         department_work_dc,
         address_work_dc,
         phone_work_dc,
         city_correspondence_dc,
         department_correspondence_dc,
         address_correspondence_dc,
         email_dc,
         destination_subscriber_dc,
         cel_phone_dc,
         city_correspondence_dane_code,
         filler,
         sample_id,
         reserved_cf,
         branch_code_cf,
         quality_cf,
         ratings_cf,
         state_status_holder_cf,
         state_cf,
         mora_years_cf,
         statement_date_cf,
         initial_issue_date_cf,
         termination_date_cf,
         due_date_cf,
         exticion_mode_id_cf,
         type_payment_cf,
         fixed_charge_value_cf,
         credit_line_cf,
         restructurated_obligation_cf,
         number_of_restructuring_cf,
         number_of_returned_checks_cf,
         term_cf,
         days_of_portfolio_cf,
         third_house_address_cf,
         third_home_phone_cf,
         every_city_code_cf,
         town_house_party_cf,
         home_department_code_cf,
         department_of_third_house_cf,
         company_name_cf,
         company_address_cf,
         company_phone_cf,
         city_code_cf,
         now_city_of_third_cf,
         departament_code_cf,
         third_company_department_cf,
         nat_restructuring_cf,
         detail_sample_id,
         legal_nature,
         value_of_collateral,
         service_category,
         type_of_account,
         space_overdraft,
         authorized_days,
         default_mora_age_id_cf,
         type_portfolio_id_cf,
         number_months_contract_cf,
         credit_mode,
         nivel,
         start_date_excension_gmf_cf,
         termination_date_exc_gmf_cf,
         number_of_renewal_cdt_cf,
         gmf_free_savings_cta_cf,
         native_type_identification_cf,
         ident_number_of_native_cf,
         entity_type_native_cf,
         entity_code_originating_cf,
         type_of_trust_cf,
         number_of_trust_cf,
         name_trust_cf,
         type_of_debt_portfolio_cf,
         policy_type_cf,
         ramification_code,
         date_of_prescription,
         score)
      VALUES
        (regcurreporteanterior.type_identification_dc,
         regcurreporteanterior.type_identification_cf,
         regcurreporteanterior.identification_number,
         regcurreporteanterior.record_type_id_cf,
         regcurreporteanterior.full_name,
         regcurreporteanterior.account_number,
         regcurreporteanterior.branch_office_cf,
         regcurreporteanterior.situation_holder_dc,
         regcurreporteanterior.opening_date,
         regcurreporteanterior.due_date_dc,
         regcurreporteanterior.responsible_dc,
         regcurreporteanterior.type_obligation_id_dc,
         regcurreporteanterior.mortgage_subsidy_dc,
         regcurreporteanterior.date_subsidy_dc,
         regcurreporteanterior.type_contract_id_cf,
         regcurreporteanterior.state_of_contract_cf,
         regcurreporteanterior.term_contract_cf,
         regcurreporteanterior.term_contract_dc,
         regcurreporteanterior.method_payment_id_cf,
         regcurreporteanterior.method_payment_id_dc,
         regcurreporteanterior.periodicity_id_dc,
         regcurreporteanterior.periodicity_id_cf,
         regcurreporteanterior.new_portfolio_id_dc,
         regcurreporteanterior.state_obligation_cf,
         regcurreporteanterior.situation_holder_cf,
         regcurreporteanterior.account_state_id_dc,
         regcurreporteanterior.date_status_origin,
         regcurreporteanterior.source_state_id,
         regcurreporteanterior.date_status_account,
         regcurreporteanterior.status_plastic_dc,
         regcurreporteanterior.date_status_plastic_dc,
         regcurreporteanterior.adjetive_dc,
         regcurreporteanterior.date_adjetive_dc,
         regcurreporteanterior.card_class_dc,
         regcurreporteanterior.franchise_dc,
         regcurreporteanterior.private_brand_name_dc,
         regcurreporteanterior.type_money_dc,
         regcurreporteanterior.type_warranty_dc,
         regcurreporteanterior.ratings_dc,
         regcurreporteanterior.probability_default_dc,
         regcurreporteanterior.mora_age,
         regcurreporteanterior.initial_values_dc,
         regcurreporteanterior.debt_to_dc,
         regcurreporteanterior.value_available,
         regcurreporteanterior.monthly_value,
         regcurreporteanterior.value_delay,
         regcurreporteanterior.total_shares,
         regcurreporteanterior.shares_canceled,
         regcurreporteanterior.shares_debt,
         regcurreporteanterior.clause_permanence_dc,
         regcurreporteanterior.date_clause_permanence_dc,
         regcurreporteanterior.payment_deadline_dc,
         regcurreporteanterior.payment_date,
         regcurreporteanterior.radication_office_dc,
         regcurreporteanterior.city_radication_office_dc,
         regcurreporteanterior.city_radi_offi_dane_cod_dc,
         regcurreporteanterior.residential_city_dc,
         regcurreporteanterior.city_resi_offi_dane_cod_dc,
         regcurreporteanterior.residential_department_dc,
         regcurreporteanterior.residential_address_dc,
         regcurreporteanterior.residential_phone_dc,
         regcurreporteanterior.city_work_dc,
         regcurreporteanterior.city_work_dane_code_dc,
         regcurreporteanterior.department_work_dc,
         regcurreporteanterior.address_work_dc,
         regcurreporteanterior.phone_work_dc,
         regcurreporteanterior.city_correspondence_dc,
         regcurreporteanterior.department_correspondence_dc,
         regcurreporteanterior.address_correspondence_dc,
         regcurreporteanterior.email_dc,
         regcurreporteanterior.destination_subscriber_dc,
         regcurreporteanterior.cel_phone_dc,
         regcurreporteanterior.city_correspondence_dane_code,
         regcurreporteanterior.filler,
         regcurreporteanterior.sample_id,
         regcurreporteanterior.reserved_cf,
         regcurreporteanterior.branch_code_cf,
         regcurreporteanterior.quality_cf,
         regcurreporteanterior.ratings_cf,
         regcurreporteanterior.state_status_holder_cf,
         regcurreporteanterior.state_cf,
         regcurreporteanterior.mora_years_cf,
         regcurreporteanterior.statement_date_cf,
         regcurreporteanterior.initial_issue_date_cf,
         regcurreporteanterior.termination_date_cf,
         regcurreporteanterior.due_date_cf,
         regcurreporteanterior.exticion_mode_id_cf,
         regcurreporteanterior.type_payment_cf,
         regcurreporteanterior.fixed_charge_value_cf,
         regcurreporteanterior.credit_line_cf,
         regcurreporteanterior.restructurated_obligation_cf,
         regcurreporteanterior.number_of_restructuring_cf,
         regcurreporteanterior.number_of_returned_checks_cf,
         regcurreporteanterior.term_cf,
         regcurreporteanterior.days_of_portfolio_cf,
         regcurreporteanterior.third_house_address_cf,
         regcurreporteanterior.third_home_phone_cf,
         regcurreporteanterior.every_city_code_cf,
         regcurreporteanterior.town_house_party_cf,
         regcurreporteanterior.home_department_code_cf,
         regcurreporteanterior.department_of_third_house_cf,
         regcurreporteanterior.company_name_cf,
         regcurreporteanterior.company_address_cf,
         regcurreporteanterior.company_phone_cf,
         regcurreporteanterior.city_code_cf,
         regcurreporteanterior.now_city_of_third_cf,
         regcurreporteanterior.departament_code_cf,
         regcurreporteanterior.third_company_department_cf,
         regcurreporteanterior.nat_restructuring_cf,
         regcurreporteanterior.detail_sample_id,
         regcurreporteanterior.legal_nature,
         regcurreporteanterior.value_of_collateral,
         regcurreporteanterior.service_category,
         regcurreporteanterior.type_of_account,
         regcurreporteanterior.space_overdraft,
         regcurreporteanterior.authorized_days,
         regcurreporteanterior.default_mora_age_id_cf,
         regcurreporteanterior.type_portfolio_id_cf,
         regcurreporteanterior.number_months_contract_cf,
         regcurreporteanterior.credit_mode,
         regcurreporteanterior.nivel,
         regcurreporteanterior.start_date_excension_gmf_cf,
         regcurreporteanterior.termination_date_exc_gmf_cf,
         regcurreporteanterior.number_of_renewal_cdt_cf,
         regcurreporteanterior.gmf_free_savings_cta_cf,
         regcurreporteanterior.native_type_identification_cf,
         regcurreporteanterior.ident_number_of_native_cf,
         regcurreporteanterior.entity_type_native_cf,
         regcurreporteanterior.entity_code_originating_cf,
         regcurreporteanterior.type_of_trust_cf,
         regcurreporteanterior.number_of_trust_cf,
         regcurreporteanterior.name_trust_cf,
         regcurreporteanterior.type_of_debt_portfolio_cf,
         regcurreporteanterior.policy_type_cf,
         regcurreporteanterior.ramification_code,
         regcurreporteanterior.date_of_prescription,
         regcurreporteanterior.score);

    EXCEPTION
      WHEN OTHERS THEN
        proregistrarerror(inutype_identification   => nvl(regcurreporteanterior.type_identification_dc,

                                                          regcurreporteanterior.type_identification_cf),
                          inuidentification_number => regcurreporteanterior.identification_number,
                          isbaccount_number        => inuobligation);
    END;
  EXCEPTION
    WHEN OTHERS THEN
      proregistrarerror(inutype_identification   => nvl(regcurreporteanterior.type_identification_dc,
                                                        regcurreporteanterior.type_identification_cf),
                        inuidentification_number => regcurreporteanterior.identification_number,
                        isbaccount_number        => inuobligation);
  END pro_atrasa_cartera;

  PROCEDURE proinsertalm_random_sample IS
    /***************************************************************
    Proposito:   Insertar un registro en la tabla LM_RANDOM_SAMPLE

    Historia de Modificaciones

    Fecha           IDEntrega
    15-06-2013      smunoz
    Creacion.
    ****************************************************************/
  BEGIN

    nuultimopasoejecutado := 10;

    INSERT INTO ld_random_sample
      (random_sample_id,
       generation_date,
       type_sector,
       subscriber_number,
       approval_sample,
       user_id,
       register_date,
       credit_bureau_id,
       type_product_id)
    VALUES
      (nusecuencia,
       v_statement_date,
       inutypesector,
       sbsubscriber_number,
       'N',
       nuuser_id,
       SYSDATE,
       inucreditbereauid,
       inutypeproductid);

  EXCEPTION
    WHEN dup_val_on_index THEN
      pkerrors.pop;
      RAISE login_denied;
    WHEN OTHERS THEN
      pkerrors.pop;
      pkerrors.geterrorvar(onuerrorcode, osberrormessage);
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);

  END proinsertalm_random_sample;

  PROCEDURE proinsertalm_sample IS
    /******************************************************************
    Proposito:  Inserta un registro en la tabla LD_SAMPLE

    Historia de Modificaciones

    Fecha           IDEntrega

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/
  BEGIN
    nuultimopasoejecutado := 20;

    INSERT INTO ld_sample
      (sample_id,
       generation_date,
       type_sector,
       user_id,
       register_date,
       credit_bureau_id,
       flag,
       type_product_id)
    VALUES
      (nusecuencia,
       v_statement_date,
       inutypesector,
       nuuser_id,
       SYSDATE,
       inucreditbereauid,
       'N',
       inutypeproductid);

  EXCEPTION
    WHEN dup_val_on_index THEN
      pkerrors.pop;
      RAISE login_denied;
    WHEN OTHERS THEN

      pkerrors.pop;
      pkerrors.geterrorvar(onuerrorcode, osberrormessage);
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);

  END proinsertalm_sample;

  PROCEDURE prosample IS
  BEGIN
    /******************************************************************
    Proposito:  Insertar un registro en la tabla lm_random_sample si lo
                que se esta generando es una muestra o insertar un
                registro en la tabla lm_sample si se esta genrando la
                primera parate del reporte

    Historia de Modificaciones

    Fecha           IDEntrega

    08-08-2013      smunozSAO213862
    Se genera la muestra por sector y producto.

    27-07-2013      smunozSAO212457
    Se agregan las variables que permiten identificar la tabla y la
    operacion que se esta realizando para que si el programa llega
    a entrar en una excepcion sea posible saber hasta que punto se
    alcanzo a ejecutar. Si el programa se esta reanudando, es decir,
    se esta retomando un proceso anterior terminado con error, se
    evalua si esta seccion se alcanzo a ejecutar y se parte de este
    punto.


    08-07-2013      smunoz
    Si se esta procesando la segunda parte del mismo reporte
    se debe almacenar tanto en el campo sector y producto el valor -1

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

    nuultimopasoejecutado := 30;

    g_table_name_trace := 'LD_SAMPLE';
    g_operation_trace  := 'INSERT';

    -- Si se esta creando una nueva muestra o reporte debe insertarse
    -- un registro en ld_sample_cont. smunozSAO213862
    IF insbtypegen = 'N' THEN

      nuultimopasoejecutado := 40;
      -- Si se esta generando la muestra
      IF isbrepomuestra = 'M' THEN
        nuultimopasoejecutado := 50;
        proinsertalm_random_sample;

        -- Si se esta procesando la segunda parte del mismo procedimiento no se crea
        -- otro encabezado
      ELSIF isbrepomuestra = 'R' THEN
        nuultimopasoejecutado := 60;
        IF nvl(g_table_name_error, g_table_name_trace) = g_table_name_trace AND
           nvl(g_operation_error, g_operation_trace) = g_operation_trace THEN
          proinsertalm_sample;
        END IF;

      END IF; -- If insbrepomuestra = 'M' Then
      -- Si no se esta creando una nueva muestra o reporte debe actualizarse
      -- un registro en ld_sample_cont. smunozSAO213862
    ELSIF insbtypegen <> 'N' THEN
      IF isbrepomuestra = 'R' THEN
        g_table_name_trace := 'LD_SAMPLE';
        g_operation_trace  := 'UPDATE';
        IF nvl(g_table_name_error, g_table_name_trace) = g_table_name_trace AND
           nvl(g_operation_error, g_operation_trace) = g_operation_trace THEN

          UPDATE ld_sample ls
             SET ls.type_product_id = decode(g_nucambioproducto,
                                             'S',
                                             -1,
                                             inutypeproductid),
                 ls.type_sector     = decode(g_nucambiosector,
                                             'S',
                                             -1,
                                             inutypesector)
           WHERE ls.sample_id = nusecuencia;
          p_borra_trace;
        END IF; -- If   nvl(g_table_name_error, g_table_name_trace) = g_table_name_trace And
      ELSIF isbrepomuestra = 'M' THEN
        UPDATE ld_random_sample lrs
           SET lrs.type_product_id = decode(g_nucambioproducto,
                                            'S',
                                            -1,
                                            inutypeproductid),
               lrs.type_sector     = decode(g_nucambiosector,
                                            'S',
                                            -1,
                                            inutypesector)
         WHERE lrs.random_sample_id = nusecuencia;
      END IF; -- If isbrepomuestra = 'R' Then

    END IF; --If insbtypegen = 'N' Then

    p_borra_trace;

  END prosample;

  PROCEDURE proinsertald_sample_cont IS

    /******************************************************************
    Proposito:  Insertar un registro en la tabla LD_SAMPLE_CONT

    Historia de Modificaciones

    Fecha           IDEntrega

    13-09-2016      Sandra Mu?oz
    Se elimina el insert con SYSDATE al campo star_report_date

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

  BEGIN

    nuultimopasoejecutado := 70;

    -- Inicio CA 200-792
    IF NOT fblaplicaentrega(csbBSS_CAR_SMS_200792) THEN
      v_star_report_date := SYSDATE;
    END IF;
    -- Fin CA 200-792

    INSERT INTO ld_sample_cont
      (id_sample_cont,
       sample_id,
       initial_record_identifier,
       code_of_subscriber,
       type_account,
       statement_date,
       enlargement_goals,
       indicator_values_in_mil,
       type_of_delivery,
       star_report_date,
       end_report_dat,
       indicator_from,
       filler,
       type_of_record,
       code_package,
       entity_type,
       entity_code,
       reserved,
       type_report,
       credit_bureau,
       sector_type,
       product_type_id)
    VALUES
      (nusecuencia, --                 id_random_sample_cont,
       nusecuencia, --                 random_sample_id,
       v_initial_record_identifier, -- initial_record_identifier,
       v_code_of_subscriber, --        code_of_subscriber,
       v_type_account, --              type_account,
       v_statement_date, --            statement_date,
       v_enlargement_goals, --         enlargement_goals,
       v_indicator_values_in_mil, --   indicator_values_in_mil,
       v_type_of_delivery, --          type_of_delivery,
       v_star_report_date, -- star_report_date,   -- CA 200-792
       v_end_report_dat, --            end_report_dat,
       v_indicator_from, --            indicator_from,
       v_filler, --                    filler,
       type_register_1, --             type_of_record,
       v_code_package, --              code_package,
       v_entity_type, --               entity_type,
       v_entity_code, --               entity_code,
       v_reserved, --                  reserved,
       v_type_report, --               type_report,
       inucreditbereauid, --           credit_bureau,
       inutypesector, --               sector_type,
       inutypeproductid); --           product_type_id)

  EXCEPTION
    WHEN dup_val_on_index THEN
      pkerrors.pop;
      RAISE login_denied;
    WHEN OTHERS THEN
      pkerrors.pop;
      pkerrors.geterrorvar(onuerrorcode, osberrormessage);
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  END proinsertald_sample_cont;

  PROCEDURE pronsertald_random_sample_cont IS
    /******************************************************************
    Proposito:  Insertar un registro en la tabla ld_random_sample_cont

    Historia de Modificaciones

    Fecha           IDEntrega
    13-09-2016      Sandra Mu?oz
    Se elimina el insert con SYSDATE al campo star_report_date


    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

  BEGIN
    nuultimopasoejecutado := 90;

    -- Inicio CA 200-792
    IF NOT fblaplicaentrega(csbBSS_CAR_SMS_200792) THEN
      v_star_report_date := SYSDATE;
    END IF;
    -- Fin CA 200-792

    INSERT INTO ld_random_sample_cont
      (id_random_sample_cont,
       random_sample_id,
       initial_record_identifier,
       code_of_subscriber,
       type_account,
       statement_date,
       enlargement_goals,
       indicator_values_in_mil,
       type_of_delivery,
       star_report_date,
       end_report_dat,
       indicator_from,
       filler,
       type_of_record,
       code_package,
       entity_type,
       entity_code,
       reserved,
       type_report,
       credit_bureau,
       sector_type,
       product_type_id)
    VALUES
      (nusecuencia, --                 id_random_sample_cont,
       nusecuencia, --                 random_sample_id,
       v_initial_record_identifier, -- initial_record_identifier,
       v_code_of_subscriber, --        code_of_subscriber,
       v_type_account, --              type_account,
       v_statement_date, --            statement_date,
       v_enlargement_goals, --         enlargement_goals,
       v_indicator_values_in_mil, --   indicator_values_in_mil,
       v_type_of_delivery, --          type_of_delivery,
       v_star_report_date, --          star_report_date,  -- CA 200-792
       v_end_report_dat, --            end_report_dat,
       v_indicator_from, --            indicator_from,
       v_filler, --                    filler,
       type_register_1, --             type_of_record,
       v_code_package, --              code_package,
       v_entity_type, --               entity_type,
       v_entity_code, --               entity_code,
       v_reserved, --                  reserved,
       v_type_report, --               type_report,
       inucreditbereauid, --           credit_bureau,
       inutypesector, --               sector_type,
       inutypeproductid); --           product_type_id)

  EXCEPTION
    WHEN dup_val_on_index THEN
      pkerrors.pop;
      RAISE login_denied;
    WHEN OTHERS THEN
      pkerrors.pop;
      pkerrors.geterrorvar(onuerrorcode, osberrormessage);
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  END;

  PROCEDURE proupdatesample_cont IS
    /******************************************************************
    Proposito:  Actualiza la fecha de finalizacion del reporte

    Historia de Modificaciones

    Fecha           IDEntrega

    14-10-2016      Sandra Mu?oz.  CA - 200-972
    S?lo se realiza la modificaci?n si la entrega es diferente a T o si la entrega no est?
    aplicada

    27-07-2013      smunozSAO212457
    Se agregan las variables que permiten identificar la tabla y la
    operacion que se esta realizando para que si el programa llega
    a entrar en una excepcion sea posible saber hasta que punto se
    alcanzo a ejecutar. Si el programa se esta reanudando, es decir,
    se esta retomando un proceso anterior terminado con error, se
    evalua si esta seccion se alcanzo a ejecutar y se parte de este
    punto.

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/
  BEGIN

    IF isbrepomuestra = 'M' THEN
      IF v_type_of_delivery <> 'T' OR
         NOT fblaplicaentrega(csbBSS_CAR_SMS_200792) THEN
        -- CA 200-792
        UPDATE ld_random_sample_cont lrsc
           SET lrsc.end_report_dat = SYSDATE
         WHERE lrsc.id_random_sample_cont = nusecuencia
           AND lrsc.random_sample_id = nusecuencia;
      END IF;
    ELSIF isbrepomuestra = 'R' THEN
      g_table_name_trace := 'LD_SAMPLE_CONT';
      g_operation_trace  := 'UPDATE_2';

      -- Se ejecuta la instruccion solo si el error ocurrio en alguna de las
      -- tablas que deben llenarse antes que ella
      IF (nvl(g_table_name_error, g_table_name_trace) = g_table_name_trace AND
         nvl(g_operation_error, g_operation_trace) = g_operation_trace) OR
         g_table_name_error = 'LD_SAMPLE' OR
         (g_table_name_error = 'LD_SAMPLE_CONT' AND
         (g_operation_error = 'INSERT' OR g_operation_error = 'UPDATE_1')) OR
         g_table_name_error = 'LD_SAMPLE_FIN' THEN

        IF v_type_of_delivery <> 'T' OR
           NOT fblaplicaentrega(csbBSS_CAR_SMS_200792) THEN
          -- CA 200-792
          UPDATE ld_sample_cont lsc
             SET lsc.end_report_dat = SYSDATE
           WHERE lsc.id_sample_cont = nusecuencia
             AND lsc.sample_id = nusecuencia;
        END IF;
        p_borra_trace;
      END IF;
    END IF; -- If isbrepomuestra = 'M' Then

  EXCEPTION
    WHEN OTHERS THEN
      pkerrors.pop;
      pkerrors.geterrorvar(onuerrorcode, osberrormessage);
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  END proupdatesample_cont;

  PROCEDURE prosample_cont IS

    /******************************************************************
    Proposito:  Crear registro en la tabla ld_sample_cont o ld_random_sample_cont
                dependiendo si lo que se esta procesando es una muestra o un reporte

    Historia de Modificaciones

    Fecha           IDEntrega

    08-08-2013      smunozSAO213862
    Se genera la muestra por sector y producto.

    27-07-2013      smunozSAO212457
    Se agregan las variables que permiten identificar la tabla y la
    operacion que se esta realizando para que si el programa llega
    a entrar en una excepcion sea posible saber hasta que punto se
    alcanzo a ejecutar. Si el programa se esta reanudando, es decir,
    se esta retomando un proceso anterior terminado con error, se
    evalua si esta seccion se alcanzo a ejecutar y se parte de este
    punto.

    08-07-2013      smunoz
    Si se esta procesando la segunda parte del mismo reporte
    se debe almacenar tanto en el campo sector y producto el valor -1

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

  BEGIN
    -- Si se esta generando un reporte
    g_table_name_trace := 'LD_SAMPLE_CONT';
    g_operation_trace  := 'INSERT';

    nuultimopasoejecutado := 100;

    -- No se debe generar nueva muestra o reporte si es continuacio'n. smunozSAO213862
    IF insbtypegen = 'N' THEN

      IF isbrepomuestra = 'R' THEN
        IF (nvl(g_table_name_error, g_table_name_trace) =
           g_table_name_trace AND
           nvl(g_operation_error, g_operation_trace) = g_operation_trace) OR
           g_table_name_error = 'LD_SAMPLE' THEN
          proinsertald_sample_cont;
          p_borra_trace;
        END IF;
        -- Si se esta generando un reporte se crea la notificacion

        nuultimopasoejecutado := 110;

      ELSIF isbrepomuestra = 'M' THEN

        nuultimopasoejecutado := 120;
        pronsertald_random_sample_cont;
      END IF; -- If insbrepomuestra = 'R' Then

    ELSIF insbtypegen <> 'N' THEN
      IF isbrepomuestra = 'R' THEN
        g_table_name_trace := 'LD_SAMPLE_CONT';
        g_operation_trace  := 'UPDATE_1';
        IF (nvl(g_table_name_error, g_table_name_trace) =
           g_table_name_trace AND
           nvl(g_operation_error, g_operation_trace) = g_operation_trace) OR
           g_table_name_error = 'LD_SAMPLE' THEN

          UPDATE ld_sample_cont lsc
             SET lsc.product_type_id = decode(g_nucambioproducto,
                                              'S',
                                              -1,
                                              inutypeproductid),
                 lsc.sector_type     = decode(g_nucambiosector,
                                              'S',
                                              -1,
                                              inutypesector)
           WHERE lsc.sample_id = nusecuencia;
          p_borra_trace;
        END IF;
      ELSIF isbrepomuestra = 'M' THEN

        UPDATE ld_random_sample_cont lrsc
           SET lrsc.product_type_id = decode(g_nucambioproducto,
                                             'S',
                                             -1,
                                             inutypeproductid),
               lrsc.sector_type     = decode(g_nucambiosector,
                                             'S',
                                             -1,
                                             inutypesector)
         WHERE lrsc.random_sample_id = nusecuencia;
      END IF;

    END IF; --   IF (isbrepomuestra = 'R' AND isbtypegen = 'N') OR isbrepomuestra = 'M' THEN

  END prosample_cont;

  PROCEDURE proinsertald_reported_deferred(isbaccount_number        diferido.difecodi%TYPE,
                                           regsuscrib_ident_type_id ge_subscriber.ident_type_id%TYPE,
                                           inuidentification_number ge_subscriber.identification%TYPE) IS

    /******************************************************************
    Proposito:  Crear registro en la tabla ld_reported_deferred
    Historia de Modificaciones

    Fecha           IDEntrega

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

  BEGIN

    nuultimopasoejecutado := 130;
    INSERT INTO ld_reported_deferred
      (deferred_id, identification_type, identification, credit_bureau)
    VALUES
      (isbaccount_number,
       regsuscrib_ident_type_id,
       inuidentification_number,
       inucreditbereauid);
  EXCEPTION
    WHEN dup_val_on_index THEN
      NULL;
    WHEN OTHERS THEN
      pkerrors.pop;
      pkerrors.geterrorvar(onuerrorcode, osberrormessage);

  END;

  PROCEDURE proinsertald_reported_products(inuproduct_id          ld_reported_products.product_id%TYPE,
                                           inuidentification_type ld_reported_products.identification_type%TYPE,
                                           inuidentification      ld_reported_products.identification%TYPE) IS

    /******************************************************************
    Proposito:  Crear registro en la tabla ld_reported_products
    Historia de Modificaciones

    Fecha           IDEntrega

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/
  BEGIN
    nuultimopasoejecutado := 140;
    INSERT INTO ld_reported_products
      (product_id, identification_type, identification, credit_bureau)
    VALUES
      (inuproduct_id,
       inuidentification_type,
       inuidentification,
       inucreditbereauid);

  EXCEPTION
    WHEN dup_val_on_index THEN
      NULL;
    WHEN OTHERS THEN
      pkerrors.pop;
      pkerrors.geterrorvar(onuerrorcode, osberrormessage);

  END proinsertald_reported_products;

  FUNCTION fnuvaluesinmil(inuvalue NUMBER) RETURN NUMBER IS
    /******************************************************************
    Proposito:  Si el sistema esta parametrizado para mostrar la informacion
                de cantidades en miles, se divide el valor recibido
                por parametro entre mil y se redondea.

    Historia de Modificaciones

    Fecha           IDEntrega

    01-08-2013      smunozSAO213076
    Creacion.
    ******************************************************************/
  BEGIN

    -- El parametro INDICATOR_VALUES_IN_MIL aplica para datacredito, para
    -- cifin siempre se muestra la informacion en miles
    IF (v_indicator_values_in_mil = 'M' AND
       inucreditbereauid = cdatacredito) OR inucreditbereauid = ccifin THEN
      RETURN round(inuvalue / 1000);
    END IF;
    RETURN inuvalue;
  EXCEPTION

    WHEN OTHERS THEN
      RETURN inuvalue;
  END fnuvaluesinmil;

  PROCEDURE proinsld_random_sample_detai(inuidentification_number       ld_random_sample_detai.identification_number%TYPE,
                                         isbaccount_number              ld_random_sample_detai.account_number%TYPE,
                                         isbtype_contract_id_cf         ld_random_sample_detai.type_contract_id_cf%TYPE,
                                         inustate_of_contract_cf        ld_random_sample_detai.state_of_contract_cf%TYPE,
                                         inuterm_contract_cf            ld_random_sample_detai.term_contract_cf%TYPE,
                                         inumethod_payment_id_cf        ld_random_sample_detai.method_payment_id_cf%TYPE,
                                         inuaccount_state_id_dc         ld_random_sample_detai.account_state_id_dc%TYPE,
                                         inudate_status_account         ld_random_sample_detai.date_status_account%TYPE,
                                         inuvalue_delay                 ld_random_sample_detai.value_delay%TYPE,
                                         isbradication_office_dc        ld_random_sample_detai.radication_office_dc%TYPE,
                                         isbcity_radication_office_dc   ld_random_sample_detai.city_radication_office_dc%TYPE,
                                         inucity_radi_offi_dane_cod_dc  ld_random_sample_detai.city_radi_offi_dane_cod_dc%TYPE,
                                         isbresidential_city_dc         ld_random_sample_detai.residential_city_dc%TYPE,
                                         inucity_resi_offi_dane_cod_dc  ld_random_sample_detai.city_resi_offi_dane_cod_dc%TYPE,
                                         isbresidential_address_dc      ld_random_sample_detai.residential_address_dc%TYPE,
                                         inuresidential_phone_dc        ld_random_sample_detai.residential_phone_dc%TYPE,
                                         isbdepartment_work_dc          ld_random_sample_detai.department_work_dc%TYPE,
                                         isbaddress_work_dc             ld_random_sample_detai.address_work_dc%TYPE,
                                         inuphone_work_dc               ld_random_sample_detai.phone_work_dc%TYPE,
                                         isbcity_correspondence_dc      ld_random_sample_detai.city_correspondence_dc%TYPE,
                                         isbdept_correspondence_dc      ld_random_sample_detai.department_correspondence_dc%TYPE,
                                         isbaddress_correspondence_dc   ld_random_sample_detai.address_correspondence_dc%TYPE,
                                         isbemail_dc                    ld_random_sample_detai.email_dc%TYPE,
                                         inucel_phone_dc                ld_random_sample_detai.cel_phone_dc%TYPE,
                                         inucity_corresp_dane_code      ld_random_sample_detai.city_correspondence_dane_code%TYPE,
                                         isbfiller                      ld_random_sample_detai.filler%TYPE,
                                         inureserved_cf                 ld_random_sample_detai.reserved_cf%TYPE,
                                         isbbranch_code_cf              ld_random_sample_detai.branch_code_cf%TYPE,
                                         isbratings_cf                  ld_random_sample_detai.ratings_cf%TYPE,
                                         inumora_years_cf               ld_random_sample_detai.mora_years_cf%TYPE,
                                         inuinitial_issue_date_cf       ld_random_sample_detai.initial_issue_date_cf%TYPE,
                                         inutermination_date_cf         ld_random_sample_detai.termination_date_cf%TYPE,
                                         inudue_date_cf                 ld_random_sample_detai.due_date_cf%TYPE,
                                         inutype_payment_cf             ld_random_sample_detai.type_payment_cf%TYPE,
                                         inufixed_charge_value_cf       ld_random_sample_detai.fixed_charge_value_cf%TYPE,
                                         inurestruct_obligation_cf      ld_random_sample_detai.restructurated_obligation_cf%TYPE,
                                         inunumber_of_restructuring_cf  ld_random_sample_detai.number_of_restructuring_cf%TYPE,
                                         inunumber_of_retur_checks_cf   ld_random_sample_detai.number_of_returned_checks_cf%TYPE,
                                         inudays_of_portfolio_cf        ld_random_sample_detai.days_of_portfolio_cf%TYPE,
                                         isbthird_house_address_cf      ld_random_sample_detai.third_house_address_cf%TYPE,
                                         isbthird_home_phone_cf         ld_random_sample_detai.third_home_phone_cf%TYPE,
                                         inuevery_city_code_cf          ld_random_sample_detai.every_city_code_cf%TYPE,
                                         isbtown_house_party_cf         ld_random_sample_detai.town_house_party_cf%TYPE,
                                         inuhome_department_code_cf     ld_random_sample_detai.home_department_code_cf%TYPE,
                                         isbdepar_of_third_house_cf     ld_random_sample_detai.department_of_third_house_cf%TYPE,
                                         isbcompany_name_cf             ld_random_sample_detai.company_name_cf%TYPE,
                                         inucompany_phone_cf            ld_random_sample_detai.company_phone_cf%TYPE,
                                         inucity_code_cf                ld_random_sample_detai.city_code_cf%TYPE,
                                         isbnow_city_of_third_cf        ld_random_sample_detai.now_city_of_third_cf%TYPE,
                                         inudepartament_code_cf         ld_random_sample_detai.departament_code_cf%TYPE,
                                         isbthird_company_department_cf ld_random_sample_detai.third_company_department_cf%TYPE,
                                         inunat_restructuring_cf        ld_random_sample_detai.nat_restructuring_cf%TYPE,
                                         isblegal_nature                ld_random_sample_detai.legal_nature%TYPE,
                                         isbvalue_of_collateral         ld_random_sample_detai.value_of_collateral%TYPE,
                                         isbservice_category            ld_random_sample_detai.service_category%TYPE,
                                         inuspace_overdraft             ld_random_sample_detai.space_overdraft%TYPE,
                                         inuauthorized_days             ld_random_sample_detai.authorized_days%TYPE,
                                         isbcompany_address_cf          ld_random_sample_detai.company_address_cf%TYPE,
                                         inunumber_months_contract_cf   ld_random_sample_detai.number_months_contract_cf%TYPE,
                                         isbcredit_mode                 ld_random_sample_detai.credit_mode%TYPE) IS
    /******************************************************************
    Proposito:  Crear registro en la tabla LD_RANDOM_SANPLE_DETAIL
    Historia de Modificaciones

    Fecha           IDEntrega

    21-11-2013      smunozSAO213793
    Se realizan los ajustes necesarios para evitar que los valores nulos se graben con
    ceros en la base de datos, ya que para CIFIN los valores nulos deben imprimirse
    en el reporte con espacios.  Para DATACREDITO no se realizan modificaciones.
    Se muestra el saldo inicial en miles.

    12-08-2013      smunozSAO213366
    Se llena el campo que indica si el registro es de diferido o producto.

    01-08-2013      smunozSAO213076
    Se aplican el formato de miles a los campos que muestran valores.

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

    -- Creacion de las variables para aplicar miles a las cifras. smunozSAO213076
    dbdebt_to_dc   ld_sample_detai.debt_to_dc%TYPE;
    dbvalue_delay  ld_sample_detai.value_delay%TYPE;
    dbmonthlyvalue ld_sample_detai.monthly_value%TYPE;
    dbinitialvalue ld_sample_detai.initial_values_dc%TYPE;
    -- Se muestra el saldo inicial en miles. smunozSAO223793
    dbvalue_available ld_sample_detai.value_available%TYPE;

  BEGIN
    nuultimopasoejecutado := 170;

    -- Se aplica la funcion de convertir a miles antes de insertar en las tablas
    -- y estos valores se usan para insertar en la tabla para las columnas debt_to_dc
    -- y value_detai. smunozSAO213076
    dbdebt_to_dc   := fnuvaluesinmil(nudebt);
    dbvalue_delay  := fnuvaluesinmil(inuvalue_delay);
    dbmonthlyvalue := fnuvaluesinmil(numontvalue);
    dbinitialvalue := fnuvaluesinmil(nuvalinici);
    -- Se muestra el saldo inicial en miles. smunozSAO223793
    dbvalue_available := fnuvaluesinmil(nuavaliblequote);

    INSERT INTO ld_random_sample_detai
      (type_identification_dc,
       type_identification_cf,
       identification_number,
       record_type_id_cf,
       full_name,
       account_number,
       branch_office_cf,
       situation_holder_dc,
       opening_date,
       due_date_dc,
       responsible_dc,
       type_obligation_id_dc,
       mortgage_subsidy_dc,
       date_subsidy_dc,
       type_contract_id_cf,
       state_of_contract_cf,
       term_contract_cf,
       term_contract_dc,
       method_payment_id_cf,
       method_payment_id_dc,
       periodicity_id_dc,
       periodicity_id_cf,
       new_portfolio_id_dc,
       state_obligation_cf,
       situation_holder_cf,
       account_state_id_dc,
       date_status_origin,
       source_state_id,
       date_status_account,
       status_plastic_dc,
       date_status_plastic_dc,
       adjetive_dc,
       date_adjetive_dc,
       card_class_dc,
       franchise_dc,
       private_brand_name_dc,
       type_money_dc,
       type_warranty_dc,
       ratings_dc,
       probability_default_dc,
       mora_age,
       initial_values_dc,
       debt_to_dc,
       value_available,
       monthly_value,
       value_delay,
       total_shares,
       shares_canceled,
       shares_debt,
       clause_permanence_dc,
       date_clause_permanence_dc,
       payment_deadline_dc,
       payment_date,
       radication_office_dc,
       city_radication_office_dc,
       city_radi_offi_dane_cod_dc,
       residential_city_dc,
       city_resi_offi_dane_cod_dc,
       residential_department_dc,
       residential_address_dc,
       residential_phone_dc,
       city_work_dc,
       city_work_dane_code_dc,
       department_work_dc,
       address_work_dc,
       phone_work_dc,
       city_correspondence_dc,
       department_correspondence_dc,
       address_correspondence_dc,
       email_dc,
       destination_subscriber_dc,
       cel_phone_dc,
       city_correspondence_dane_code,
       filler,
       random_sample_id,
       reserved_cf,
       branch_code_cf,
       quality_cf,
       ratings_cf,
       state_cf,
       mora_years_cf,
       statement_date_cf,
       initial_issue_date_cf,
       termination_date_cf,
       due_date_cf,
       exticion_mode_id_cf,
       type_payment_cf,
       fixed_charge_value_cf,
       credit_line_cf,
       restructurated_obligation_cf,
       number_of_restructuring_cf,
       number_of_returned_checks_cf,
       term_cf,
       days_of_portfolio_cf,
       third_house_address_cf,
       third_home_phone_cf,
       every_city_code_cf,
       town_house_party_cf,
       home_department_code_cf,
       department_of_third_house_cf,
       company_name_cf,
       company_phone_cf,
       city_code_cf,
       now_city_of_third_cf,
       departament_code_cf,
       third_company_department_cf,
       nat_restructuring_cf,
       legal_nature,
       value_of_collateral,
       service_category,
       type_of_account,
       space_overdraft,
       authorized_days,
       default_mora_age_id_cf,
       type_portfolio_id_cf,
       state_status_holder_cf,
       company_address_cf,
       random_detail_sample_id,
       number_months_contract_cf,
       credit_mode,
       -- Se llena el campo que indica si el registro es de diferido o producto.
       -- smunozSAO213366.
       nivel,
       score)
    VALUES
      (ident_type_dc, -- type_identification_dc,
       ident_type_cf, -- type_identification_cf,
       inuidentification_number, -- identification_number,
       type_register_2, -- record_type_id_cf,
       sbfullname, -- full_name,
       isbaccount_number, -- account_number,
       v_code_of_subscriber, -- branch_office_cf,
       0, -- situation_holder_dc,
       nuopdt, -- opening_date,
       nuduedate, -- due_date_dc,
       nudeucodedt, -- responsible_dc,
       nutypobl, -- type_obligation_id_dc,
       0, -- mortgage_subsidy_dc,
       0, -- date_subsidy_dc,
       isbtype_contract_id_cf, -- type_contract_id_cf,
       inustate_of_contract_cf, -- state_of_contract_cf,
       nuterm_contract_cf, -- term_contract_cf,
       1, -- term_contract_dc,
       inumethod_payment_id_cf, -- method_payment_id_cf,
       numethpay, -- method_payment_id_dc,
       1, -- periodicity_id_dc,
       1, -- periodicity_id_cf,
       v_new_portfolio, -- new_portfolio_id_dc,
       nustatobl, -- state_obligation_cf,
       6, -- situation_holder_cf,
       inuaccount_state_id_dc, -- account_state_id_dc,
       nuopdt, -- date_status_origin,
       0, -- source_state_id,
       inudate_status_account, -- date_status_account, sysdate
       0, -- status_plastic_dc,
       0, -- date_status_plastic_dc,
       0, -- adjetive_dc,
       0, -- date_adjetive_dc,
       nucard_class_dc, -- card_class_dc, --Se llena el campo con la variable nuCard_Class_Dc. SAO223793
       0, -- franchise_dc,
       NULL, -- private_brand_name_dc,
       nutypemoney, -- type_money_dc,
       nutypewarr, -- type_warranty_dc,
       NULL, -- ratings_dc,
       0, -- probability_default_dc,
       nudiasdemora, -- mora_age,
       dbinitialvalue, -- initial_values_dc,
       dbdebt_to_dc, -- debt_to_dc,
       dbvalue_available, --value_available, -- Se muestra el valor en miles. smunozSAO223793
       dbmonthlyvalue, -- monthly_value,
       dbvalue_delay, -- value_delay,
       nutotalshare, -- total_shares,
       nucuopag, -- shares_canceled,
       nucuomor, -- shares_debt,
       0, -- clause_permanence_dc,
       0, -- date_clause_permanence_dc,
       nufelipa, -- payment_deadline_dc,
       nufeulpa, -- payment_date,
       isbradication_office_dc, -- radication_office_dc,
       isbcity_radication_office_dc, -- city_radication_office_dc,
       inucity_radi_offi_dane_cod_dc, -- city_radi_offi_dane_cod_dc,
       isbresidential_city_dc, -- residential_city_dc,
       inucity_resi_offi_dane_cod_dc, -- city_resi_offi_dane_cod_dc,
       isbdept_correspondence_dc, -- residential_department_dc,
       isbresidential_address_dc, -- residential_address_dc,
       inuresidential_phone_dc, -- residential_phone_dc,
       isbcity_correspondence_dc, -- city_work_dc,
       inucity_resi_offi_dane_cod_dc, -- city_work_dane_code_dc,
       isbdepartment_work_dc, -- department_work_dc,
       isbaddress_work_dc, -- address_work_dc,
       inuphone_work_dc, -- phone_work_dc,
       isbcity_correspondence_dc, -- city_correspondence_dc,
       isbdept_correspondence_dc, -- department_correspondence_dc,
       isbaddress_correspondence_dc, -- address_correspondence_dc,
       isbemail_dc, -- email_dc,
       0, -- destination_subscriber_dc,
       inucel_phone_dc, -- cel_phone_dc,
       inucity_corresp_dane_code, -- city_correspondence_dane_code,
       isbfiller, -- filler,
       nusecuencia, -- random_sample_id,
       inureserved_cf, -- reserved_cf,
       isbbranch_code_cf, -- branch_code_cf,
       sbdeucodecf, -- quality_cf,
       isbratings_cf, -- ratings_cf,
       nustatobl, -- state_cf,
       inumora_years_cf, -- mora_years_cf,
       v_statement_date, -- statement_date_cf,
       nuinitial_issue_date_cf, -- initial_issue_date_cf,
       nutermination_date_cf, -- termination_date_cf,
       inudue_date_cf, -- due_date_cf,
       1, -- exticion_mode_id_cf,
       1, -- type_payment_cf,
       0, -- fixed_charge_value_cf,
       nulinecred, -- credit_line_cf,
       inurestruct_obligation_cf, -- restructurated_obligation_cf,
       inunumber_of_restructuring_cf, -- number_of_restructuring_cf,
       inunumber_of_retur_checks_cf, -- number_of_returned_checks_cf,
       nuterm_cf, -- smunozSAO223793 20-11-2013 Se envia el dato vacio a la tabla
       inudays_of_portfolio_cf, -- days_of_portfolio_cf,
       isbthird_house_address_cf, -- third_house_address_cf,
       isbthird_home_phone_cf, -- third_home_phone_cf,
       inuevery_city_code_cf, -- every_city_code_cf,
       isbtown_house_party_cf, -- town_house_party_cf,
       inuhome_department_code_cf, -- home_department_code_cf,
       isbdepar_of_third_house_cf, -- department_of_third_house_cf,
       isbcompany_name_cf, -- company_name_cf,
       inuphone_work_dc, -- company_phone_cf,
       inucity_code_cf, -- city_code_cf,
       isbnow_city_of_third_cf, -- now_city_of_third_cf,
       inudepartament_code_cf, -- departament_code_cf,
       isbthird_company_department_cf, -- third_company_department_cf,
       inunat_restructuring_cf, -- nat_restructuring_cf,
       isblegal_nature, -- legal_nature,
       isbvalue_of_collateral, -- value_of_collateral,
       sbservice_category, -- service_category,
       v_type_account, -- type_of_account,
       inuspace_overdraft, -- space_overdraft,
       inuauthorized_days, -- authorized_days,
       nuedamora, -- default_mora_age_id_cf,
       nutypeport, -- type_portfolio_id_cf,
       NULL, -- state_status_holder_cf,
       isbaddress_work_dc, -- company_address_cf,
       nucount, -- random_detail_sample_id,
       nutotalshare, -- number_months_contract_cf,
       isbcredit_mode, -- credit_mode)
       -- Se llena el campo que indica si el registro es de diferido o producto.
       -- smunozSAO213366.
       v_sbdifoser,
       sbscore); -- Nivel

  END proinsld_random_sample_detai;

  PROCEDURE proinsld_sample_detai(inuidentification_number       ld_sample_detai.identification_number%TYPE,
                                  isbaccount_number              ld_sample_detai.account_number%TYPE,
                                  isbtype_contract_id_cf         ld_sample_detai.type_contract_id_cf%TYPE,
                                  inustate_of_contract_cf        ld_sample_detai.state_of_contract_cf%TYPE,
                                  inuterm_contract_cf            ld_sample_detai.term_contract_cf%TYPE,
                                  inumethod_payment_id_cf        ld_sample_detai.method_payment_id_cf%TYPE,
                                  inuaccount_state_id_dc         ld_sample_detai.account_state_id_dc%TYPE,
                                  inudate_status_account         ld_sample_detai.date_status_account%TYPE,
                                  inuvalue_delay                 ld_sample_detai.value_delay%TYPE,
                                  isbradication_office_dc        ld_sample_detai.radication_office_dc%TYPE,
                                  isbcity_radication_office_dc   ld_sample_detai.city_radication_office_dc%TYPE,
                                  inucity_radi_offi_dane_cod_dc  ld_sample_detai.city_radi_offi_dane_cod_dc%TYPE,
                                  isbresidential_city_dc         ld_sample_detai.residential_city_dc%TYPE,
                                  inucity_resi_offi_dane_cod_dc  ld_sample_detai.city_resi_offi_dane_cod_dc%TYPE,
                                  isbresidential_address_dc      ld_sample_detai.residential_address_dc%TYPE,
                                  inuresidential_phone_dc        ld_sample_detai.residential_phone_dc%TYPE,
                                  isbdepartment_work_dc          ld_sample_detai.department_work_dc%TYPE,
                                  isbaddress_work_dc             ld_sample_detai.address_work_dc%TYPE,
                                  inuphone_work_dc               ld_sample_detai.phone_work_dc%TYPE,
                                  isbcity_correspondence_dc      ld_sample_detai.city_correspondence_dc%TYPE,
                                  isbdept_correspondence_dc      ld_sample_detai.department_correspondence_dc%TYPE,
                                  isbaddress_correspondence_dc   ld_sample_detai.address_correspondence_dc%TYPE,
                                  isbemail_dc                    ld_sample_detai.email_dc%TYPE,
                                  inucel_phone_dc                ld_sample_detai.cel_phone_dc%TYPE,
                                  inucity_corresp_dane_code      ld_sample_detai.city_correspondence_dane_code%TYPE,
                                  isbfiller                      ld_sample_detai.filler%TYPE,
                                  inureserved_cf                 ld_sample_detai.reserved_cf%TYPE,
                                  isbbranch_code_cf              ld_sample_detai.branch_code_cf%TYPE,
                                  isbratings_cf                  ld_sample_detai.ratings_cf%TYPE,
                                  inumora_years_cf               ld_sample_detai.mora_years_cf%TYPE,
                                  inuinitial_issue_date_cf       ld_sample_detai.initial_issue_date_cf%TYPE,
                                  inutermination_date_cf         ld_sample_detai.termination_date_cf%TYPE,
                                  inudue_date_cf                 ld_sample_detai.due_date_cf%TYPE,
                                  inutype_payment_cf             ld_sample_detai.type_payment_cf%TYPE,
                                  inufixed_charge_value_cf       ld_sample_detai.fixed_charge_value_cf%TYPE,
                                  inurestruct_obligation_cf      ld_sample_detai.restructurated_obligation_cf%TYPE,
                                  inunumber_of_restructuring_cf  ld_sample_detai.number_of_restructuring_cf%TYPE,
                                  inunumber_of_retur_checks_cf   ld_sample_detai.number_of_returned_checks_cf%TYPE,
                                  inudays_of_portfolio_cf        ld_sample_detai.days_of_portfolio_cf%TYPE,
                                  isbthird_house_address_cf      ld_sample_detai.third_house_address_cf%TYPE,
                                  isbthird_home_phone_cf         ld_sample_detai.third_home_phone_cf%TYPE,
                                  inuevery_city_code_cf          ld_sample_detai.every_city_code_cf%TYPE,
                                  isbtown_house_party_cf         ld_sample_detai.town_house_party_cf%TYPE,
                                  inuhome_department_code_cf     ld_sample_detai.home_department_code_cf%TYPE,
                                  isbdepar_of_third_house_cf     ld_sample_detai.department_of_third_house_cf%TYPE,
                                  isbcompany_name_cf             ld_sample_detai.company_name_cf%TYPE,
                                  inucompany_phone_cf            ld_sample_detai.company_phone_cf%TYPE,
                                  inucity_code_cf                ld_sample_detai.city_code_cf%TYPE,
                                  isbnow_city_of_third_cf        ld_sample_detai.now_city_of_third_cf%TYPE,
                                  inudepartament_code_cf         ld_sample_detai.departament_code_cf%TYPE,
                                  isbthird_company_department_cf ld_sample_detai.third_company_department_cf%TYPE,
                                  inunat_restructuring_cf        ld_sample_detai.nat_restructuring_cf%TYPE,
                                  isblegal_nature                ld_sample_detai.legal_nature%TYPE,
                                  isbvalue_of_collateral         ld_sample_detai.value_of_collateral%TYPE,
                                  isbservice_category            ld_sample_detai.service_category%TYPE,
                                  inuspace_overdraft             ld_sample_detai.space_overdraft%TYPE,
                                  inuauthorized_days             ld_sample_detai.authorized_days%TYPE,
                                  isbcompany_address_cf          ld_sample_detai.company_address_cf%TYPE,
                                  inunumber_months_contract_cf   ld_sample_detai.number_months_contract_cf%TYPE,
                                  isbcredit_mode                 ld_sample_detai.credit_mode%TYPE) IS

    /******************************************************************
    Proposito:  Crear registro en la tabla LD_SAMPLE_DETAIL
    Historia de Modificaciones

    Fecha           IDEntrega

    21-11-2013      smunozSAO213793
    Se realizan los ajustes necesarios para evitar que los valores nulos se graben con
    ceros en la base de datos, ya que para CIFIN los valores nulos deben imprimirse
    en el reporte con espacios.  Para DATACREDITO no se realizan modificaciones.
    Se muestra el saldo inicial en miles.

    12-08-2013      smunozSAO213366
    Se llena el campo que indica si el registro es de diferido o producto.

    01-08-2013      smunozSAO213076
    Se aplican el formato de miles a los campos que muestran valores.

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

    -- Creacion de las variables para aplicar miles a las cifras. smunozSAO213076
    dbdebt_to_dc   ld_sample_detai.debt_to_dc%TYPE;
    dbvalue_delay  ld_sample_detai.value_delay%TYPE;
    dbmonthlyvalue ld_sample_detai.monthly_value%TYPE;

    -- Se muestra el saldo inicial en miles. smunozSAO223793
    dbvalue_available ld_sample_detai.value_available%TYPE;
    dbinitialvalue    ld_sample_detai.initial_values_dc%TYPE;

  BEGIN

    nuultimopasoejecutado := 180;

    -- Se aplica la funcion de convertir a miles antes de insertar en las tablas
    -- y estos valores se usan para insertar en la tabla para las columnas debt_to_dc
    -- y value_detai
    dbdebt_to_dc   := fnuvaluesinmil(nudebt);
    dbvalue_delay  := fnuvaluesinmil(inuvalue_delay);
    dbmonthlyvalue := fnuvaluesinmil(numontvalue);
    dbinitialvalue := fnuvaluesinmil(nuvalinici);
    -- Se muestra el saldo inicial en miles. smunozSAO223793
    dbvalue_available := fnuvaluesinmil(nuavaliblequote);

    nuultimopasoejecutado := 185;

    INSERT INTO ld_sample_detai
      (type_identification_dc,
       type_identification_cf,
       identification_number,
       record_type_id_cf,
       full_name,
       account_number,
       branch_office_cf,
       situation_holder_dc,
       opening_date,
       due_date_dc,
       responsible_dc,
       type_obligation_id_dc,
       mortgage_subsidy_dc,
       date_subsidy_dc,
       type_contract_id_cf,
       state_of_contract_cf,
       term_contract_cf,
       term_contract_dc,
       method_payment_id_cf,
       method_payment_id_dc,
       periodicity_id_dc,
       periodicity_id_cf,
       new_portfolio_id_dc,
       state_obligation_cf,
       situation_holder_cf,
       account_state_id_dc,
       date_status_origin,
       source_state_id,
       date_status_account,
       status_plastic_dc,
       date_status_plastic_dc,
       adjetive_dc,
       date_adjetive_dc,
       card_class_dc,
       franchise_dc,
       private_brand_name_dc,
       type_money_dc,
       type_warranty_dc,
       ratings_dc,
       probability_default_dc,
       mora_age,
       initial_values_dc,
       debt_to_dc,
       value_available,
       monthly_value,
       value_delay,
       total_shares,
       shares_canceled,
       shares_debt,
       clause_permanence_dc,
       date_clause_permanence_dc,
       payment_deadline_dc,
       payment_date,
       radication_office_dc,
       city_radication_office_dc,
       city_radi_offi_dane_cod_dc,
       residential_city_dc,
       city_resi_offi_dane_cod_dc,
       residential_department_dc,
       residential_address_dc,
       residential_phone_dc,
       city_work_dc,
       city_work_dane_code_dc,
       department_work_dc,
       address_work_dc,
       phone_work_dc,
       city_correspondence_dc,
       department_correspondence_dc,
       address_correspondence_dc,
       email_dc,
       destination_subscriber_dc,
       cel_phone_dc,
       city_correspondence_dane_code,
       filler,
       sample_id,
       reserved_cf,
       branch_code_cf,
       quality_cf,
       ratings_cf,
       state_cf,
       mora_years_cf,
       statement_date_cf,
       initial_issue_date_cf,
       termination_date_cf,
       due_date_cf,
       exticion_mode_id_cf,
       type_payment_cf,
       fixed_charge_value_cf,
       credit_line_cf,
       restructurated_obligation_cf,
       number_of_restructuring_cf,
       number_of_returned_checks_cf,
       term_cf,
       days_of_portfolio_cf,
       third_house_address_cf,
       third_home_phone_cf,
       every_city_code_cf,
       town_house_party_cf,
       home_department_code_cf,
       department_of_third_house_cf,
       company_name_cf,
       company_phone_cf,
       city_code_cf,
       now_city_of_third_cf,
       departament_code_cf,
       third_company_department_cf,
       nat_restructuring_cf,
       legal_nature,
       value_of_collateral,
       service_category,
       type_of_account,
       space_overdraft,
       authorized_days,
       default_mora_age_id_cf,
       type_portfolio_id_cf,
       state_status_holder_cf,
       company_address_cf,
       detail_sample_id,
       number_months_contract_cf,
       credit_mode,
       -- Se llena el campo que indica si el registro es de diferido o producto.
       -- smunozSAO213366.
       nivel,
       score)
    VALUES
      (ident_type_dc, -- type_identification_dc,
       ident_type_cf, -- type_identification_cf,
       inuidentification_number, -- identification_number,
       type_register_2, -- record_type_id_cf,
       sbfullname, -- full_name,
       isbaccount_number, -- account_number,
       v_code_of_subscriber, -- branch_office_cf,
       0, -- situation_holder_dc,
       nuopdt, -- opening_date,
       nuduedate, -- due_date_dc,
       nudeucodedt, -- responsible_dc,
       nutypobl, -- type_obligation_id_dc,
       0, -- mortgage_subsidy_dc,
       0, -- date_subsidy_dc,
       isbtype_contract_id_cf, -- type_contract_id_cf,
       inustate_of_contract_cf, -- state_of_contract_cf,
       nuterm_contract_cf, -- term_contract_cf,
       1, -- term_contract_dc,
       inumethod_payment_id_cf, -- method_payment_id_cf,
       numethpay, -- method_payment_id_dc,
       1, -- periodicity_id_dc,
       1, -- periodicity_id_cf,
       v_new_portfolio, -- new_portfolio_id_dc,
       nustatobl, -- state_obligation_cf,
       6, -- situation_holder_cf,
       inuaccount_state_id_dc, -- account_state_id_dc,
       nuopdt, -- date_status_origin,
       0, -- source_state_id,
       inudate_status_account, -- date_status_account,
       0, -- status_plastic_dc,
       0, -- date_status_plastic_dc,
       0, -- adjetive_dc,
       0, -- date_adjetive_dc,
       nucard_class_dc, -- card_class_dc, --Se llena el campo con la variable nuCard_Class_Dc. SAO223793
       0, -- franchise_dc,
       NULL, -- private_brand_name_dc,
       nutypemoney, -- type_money_dc,
       nutypewarr, -- type_warranty_dc,
       NULL, -- ratings_dc,
       0, -- probability_default_dc,
       nudiasdemora, -- mora_age,        2.31
       dbinitialvalue, -- initial_values_dc, 2.32
       dbdebt_to_dc, -- debt_to_dc,
       dbvalue_available, --value_available,  -- Se muestra el valor en miles. smunozSAO223793
       dbmonthlyvalue, -- monthly_value,
       dbvalue_delay, -- value_delay,
       nutotalshare, -- total_shares,
       nucuopag, -- shares_canceled,
       nucuomor, -- shares_debt,
       0, --clause_permanence_dc
       0, -- date_clause_permanence_dc,
       nufelipa, -- payment_deadline_dc,
       nufeulpa, -- payment_date,
       isbradication_office_dc, -- radication_office_dc,
       isbcity_radication_office_dc, -- city_radication_office_dc,
       inucity_radi_offi_dane_cod_dc, -- city_radi_offi_dane_cod_dc,
       isbresidential_city_dc, -- residential_city_dc,
       inucity_resi_offi_dane_cod_dc, -- city_resi_offi_dane_cod_dc,
       isbdept_correspondence_dc, -- residential_department_dc,
       isbresidential_address_dc, -- residential_address_dc,
       inuresidential_phone_dc, -- residential_phone_dc,
       isbresidential_city_dc, -- city_work_dc,
       inucity_resi_offi_dane_cod_dc, -- city_work_dane_code_dc,
       isbdepartment_work_dc, -- department_work_dc,
       isbaddress_work_dc, -- address_work_dc,
       inuphone_work_dc, -- phone_work_dc,
       isbcity_correspondence_dc, -- city_correspondence_dc,
       isbdept_correspondence_dc, -- department_correspondence_dc,
       isbaddress_correspondence_dc, -- address_correspondence_dc,
       isbemail_dc, -- email_dc,
       0, -- destination_subscriber_dc,
       inucel_phone_dc, -- cel_phone_dc,
       inucity_corresp_dane_code, -- city_correspondence_dane_code,
       isbfiller, -- filler,
       nusecuencia, -- sample_id,
       inureserved_cf, -- reserved_cf,
       isbbranch_code_cf, -- branch_code_cf,
       sbdeucodecf, -- quality_cf,
       isbratings_cf, -- ratings_cf,
       nustatobl, -- state_cf,
       inumora_years_cf, -- mora_years_cf,
       v_statement_date, -- statement_date_cf,
       nuinitial_issue_date_cf, -- initial_issue_date_cf,
       nutermination_date_cf, -- termination_date_cf,
       inudue_date_cf, -- due_date_cf,
       1, -- exticion_mode_id_cf,
       1, -- type_payment_cf,
       0, -- fixed_charge_value_cf,
       nulinecred, -- credit_line_cf,
       inurestruct_obligation_cf, -- restructurated_obligation_cf,
       inunumber_of_restructuring_cf, -- number_of_restructuring_cf,
       inunumber_of_retur_checks_cf, -- number_of_returned_checks_cf,
       nuterm_cf, -- smunozSAO223793 20-11-2013 Se envia el dato vacio a la tabla
       inudays_of_portfolio_cf, -- days_of_portfolio_cf,
       upper(isbresidential_address_dc), -- third_house_address_cf,
       inuresidential_phone_dc, -- third_home_phone_cf,***********
       inuevery_city_code_cf, -- every_city_code_cf,
       isbtown_house_party_cf, -- town_house_party_cf,
       inuhome_department_code_cf, -- home_department_code_cf,
       isbdepar_of_third_house_cf, -- department_of_third_house_cf,
       isbcompany_name_cf, -- company_name_cf,
       inucompany_phone_cf, -- company_phone_cf,
       inucity_code_cf, -- city_code_cf,
       isbnow_city_of_third_cf, -- now_city_of_third_cf,
       inudepartament_code_cf, -- departament_code_cf,
       isbthird_company_department_cf, -- third_company_department_cf,
       inunat_restructuring_cf, -- nat_restructuring_cf,
       isblegal_nature, -- legal_nature,
       isbvalue_of_collateral, -- value_of_collateral,
       sbservice_category, -- service_category,
       v_type_account, -- type_of_account,
       inuspace_overdraft, -- space_overdraft,
       inuauthorized_days, -- authorized_days,
       nuedamora, -- default_mora_age_id_cf,
       nutypeport, -- type_portfolio_id_cf,
       NULL, -- state_status_holder_cf,
       upper(isbresidential_address_dc), -- company_address_cf,
       nucount, -- detail_sample_id,
       nutotalshare, -- number_months_contract_cf,
       isbcredit_mode, -- credit_mode)
       -- Se llena el campo que indica si el registro es de diferido o producto.
       -- smunozSAO213366.
       v_sbdifoser,
       sbscore); -- Nivel
  EXCEPTION
    WHEN dup_val_on_index THEN
      -- Devolver contadores
      proregistrarerror(inutype_identification   => nvl(ident_type_dc,
                                                        ident_type_cf),
                        inuidentification_number => inuidentification_number,
                        isbaccount_number        => isbaccount_number);

    WHEN OTHERS THEN

      proregistrarerror(inutype_identification   => nvl(ident_type_dc,
                                                        ident_type_cf),
                        inuidentification_number => inuidentification_number,
                        isbaccount_number        => isbaccount_number);

  END proinsld_sample_detai;

  PROCEDURE prosample_detai(inuidentification_number       ld_sample_detai.identification_number%TYPE DEFAULT NULL,
                            isbaccount_number              ld_sample_detai.account_number%TYPE DEFAULT NULL,
                            isbtype_contract_id_cf         ld_sample_detai.type_contract_id_cf%TYPE DEFAULT NULL,
                            inustate_of_contract_cf        ld_sample_detai.state_of_contract_cf%TYPE DEFAULT NULL,
                            inuterm_contract_cf            ld_sample_detai.term_contract_cf%TYPE DEFAULT NULL,
                            inumethod_payment_id_cf        ld_sample_detai.method_payment_id_cf%TYPE DEFAULT NULL,
                            inuaccount_state_id_dc         ld_sample_detai.account_state_id_dc%TYPE DEFAULT NULL,
                            inudate_status_account         ld_sample_detai.date_status_account%TYPE DEFAULT NULL,
                            inuvalue_delay                 ld_sample_detai.value_delay%TYPE DEFAULT NULL,
                            isbradication_office_dc        ld_sample_detai.radication_office_dc%TYPE DEFAULT NULL,
                            isbcity_radication_office_dc   ld_sample_detai.city_radication_office_dc%TYPE DEFAULT NULL,
                            inucity_radi_offi_dane_cod_dc  ld_sample_detai.city_radi_offi_dane_cod_dc%TYPE DEFAULT NULL,
                            isbresidential_city_dc         ld_sample_detai.residential_city_dc%TYPE DEFAULT NULL,
                            inucity_resi_offi_dane_cod_dc  ld_sample_detai.city_resi_offi_dane_cod_dc%TYPE DEFAULT NULL,
                            isbresidential_address_dc      ld_sample_detai.residential_address_dc%TYPE DEFAULT NULL,
                            inuresidential_phone_dc        ld_sample_detai.residential_phone_dc%TYPE DEFAULT NULL,
                            isbdepartment_work_dc          ld_sample_detai.department_work_dc%TYPE DEFAULT NULL,
                            isbaddress_work_dc             ld_sample_detai.address_work_dc%TYPE DEFAULT NULL,
                            inuphone_work_dc               ld_sample_detai.phone_work_dc%TYPE DEFAULT NULL,
                            isbcity_correspondence_dc      ld_sample_detai.city_correspondence_dc%TYPE DEFAULT NULL,
                            isbdept_correspondence_dc      ld_sample_detai.department_correspondence_dc%TYPE DEFAULT NULL,
                            isbaddress_correspondence_dc   ld_sample_detai.address_correspondence_dc%TYPE DEFAULT NULL,
                            isbemail_dc                    ld_sample_detai.email_dc%TYPE DEFAULT NULL,
                            inucel_phone_dc                ld_sample_detai.cel_phone_dc%TYPE DEFAULT NULL,
                            inucity_corresp_dane_code      ld_sample_detai.city_correspondence_dane_code%TYPE DEFAULT NULL,
                            isbfiller                      ld_sample_detai.filler%TYPE DEFAULT NULL,
                            inureserved_cf                 ld_sample_detai.reserved_cf%TYPE DEFAULT NULL,
                            isbbranch_code_cf              ld_sample_detai.branch_code_cf%TYPE DEFAULT NULL,
                            isbratings_cf                  ld_sample_detai.ratings_cf%TYPE DEFAULT NULL,
                            inumora_years_cf               ld_sample_detai.mora_years_cf%TYPE DEFAULT NULL,
                            inuinitial_issue_date_cf       ld_sample_detai.initial_issue_date_cf%TYPE DEFAULT NULL,
                            inutermination_date_cf         ld_sample_detai.termination_date_cf%TYPE DEFAULT NULL,
                            inudue_date_cf                 ld_sample_detai.due_date_cf%TYPE DEFAULT NULL,
                            inutype_payment_cf             ld_sample_detai.type_payment_cf%TYPE DEFAULT NULL,
                            inufixed_charge_value_cf       ld_sample_detai.fixed_charge_value_cf%TYPE DEFAULT NULL,
                            inurestruct_obligation_cf      ld_sample_detai.restructurated_obligation_cf%TYPE DEFAULT NULL,
                            inunumber_of_restructuring_cf  ld_sample_detai.number_of_restructuring_cf%TYPE DEFAULT NULL,
                            inunumber_of_retur_checks_cf   ld_sample_detai.number_of_returned_checks_cf%TYPE DEFAULT NULL,
                            inudays_of_portfolio_cf        ld_sample_detai.days_of_portfolio_cf%TYPE DEFAULT NULL,
                            isbthird_house_address_cf      ld_sample_detai.third_house_address_cf%TYPE DEFAULT NULL,
                            isbthird_home_phone_cf         ld_sample_detai.third_home_phone_cf%TYPE DEFAULT NULL,
                            inuevery_city_code_cf          ld_sample_detai.every_city_code_cf%TYPE DEFAULT NULL,
                            isbtown_house_party_cf         ld_sample_detai.town_house_party_cf%TYPE DEFAULT NULL,
                            inuhome_department_code_cf     ld_sample_detai.home_department_code_cf%TYPE DEFAULT NULL,
                            isbdepar_of_third_house_cf     ld_sample_detai.department_of_third_house_cf%TYPE DEFAULT NULL,
                            isbcompany_name_cf             ld_sample_detai.company_name_cf%TYPE DEFAULT NULL,
                            inucompany_phone_cf            ld_sample_detai.company_phone_cf%TYPE DEFAULT NULL,
                            inucity_code_cf                ld_sample_detai.city_code_cf%TYPE DEFAULT NULL,
                            isbnow_city_of_third_cf        ld_sample_detai.now_city_of_third_cf%TYPE DEFAULT NULL,
                            inudepartament_code_cf         ld_sample_detai.departament_code_cf%TYPE DEFAULT NULL,
                            isbthird_company_department_cf ld_sample_detai.third_company_department_cf%TYPE DEFAULT NULL,
                            inunat_restructuring_cf        ld_sample_detai.nat_restructuring_cf%TYPE DEFAULT NULL,
                            isblegal_nature                ld_sample_detai.legal_nature%TYPE DEFAULT NULL,
                            isbvalue_of_collateral         ld_sample_detai.value_of_collateral%TYPE DEFAULT NULL,
                            isbservice_category            ld_sample_detai.service_category%TYPE DEFAULT NULL,
                            inuspace_overdraft             ld_sample_detai.space_overdraft%TYPE DEFAULT NULL,
                            inuauthorized_days             ld_sample_detai.authorized_days%TYPE DEFAULT NULL,
                            isbcompany_address_cf          ld_sample_detai.company_address_cf%TYPE DEFAULT NULL,
                            inunumber_months_contract_cf   ld_sample_detai.number_months_contract_cf%TYPE DEFAULT NULL,
                            isbcredit_mode                 ld_sample_detai.credit_mode%TYPE DEFAULT NULL,
                            ibscliecodeu                   VARCHAR2,
                            regsuscrib_ident_type_id       ge_subscriber.ident_type_id%TYPE,
                            inusesususc                    servsusc.sesususc%TYPE) IS

    /******************************************************************
    Proposito:  Insertar un registro en la tabla ld_random_sample_detail
                o ld_sample_detail dependiendo si se esta procesando una
                muestra o un reporte respectivamente.

    Historia de Modificaciones

    Fecha           IDEntrega

    03-07-2013      smunoz
    Graba cada 1000 registros.

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

    boinsdetail BOOLEAN;
    exerroralinsertar EXCEPTION; -- Error al insertar
    sbvalicalif BOOLEAN;

  BEGIN

    nuultimopasoejecutado := 200;
    nucount               := nucount + 1;
    v_sum_of_new          := v_sum_of_new + v_new_portfolio; --regsuscrib.sesunuse;

    -- Si es muestra inserta en ld_random_sample_detail
    IF isbrepomuestra = 'M' THEN

      proinsld_random_sample_detai(inuidentification_number       => inuidentification_number,
                                   isbaccount_number              => isbaccount_number,
                                   isbtype_contract_id_cf         => isbtype_contract_id_cf,
                                   inustate_of_contract_cf        => inustate_of_contract_cf,
                                   inuterm_contract_cf            => inuterm_contract_cf,
                                   inumethod_payment_id_cf        => inumethod_payment_id_cf,
                                   inuaccount_state_id_dc         => inuaccount_state_id_dc,
                                   inudate_status_account         => inudate_status_account,
                                   inuvalue_delay                 => inuvalue_delay,
                                   isbradication_office_dc        => isbradication_office_dc,
                                   isbcity_radication_office_dc   => isbcity_radication_office_dc,
                                   inucity_radi_offi_dane_cod_dc  => inucity_radi_offi_dane_cod_dc,
                                   isbresidential_city_dc         => isbresidential_city_dc,
                                   inucity_resi_offi_dane_cod_dc  => inucity_resi_offi_dane_cod_dc,
                                   isbresidential_address_dc      => isbresidential_address_dc,
                                   inuresidential_phone_dc        => inuresidential_phone_dc,
                                   isbdepartment_work_dc          => isbdepartment_work_dc,
                                   isbaddress_work_dc             => isbaddress_work_dc,
                                   inuphone_work_dc               => inuphone_work_dc,
                                   isbcity_correspondence_dc      => isbcity_correspondence_dc,
                                   isbdept_correspondence_dc      => isbdept_correspondence_dc,
                                   isbaddress_correspondence_dc   => isbaddress_correspondence_dc,
                                   isbemail_dc                    => isbemail_dc,
                                   inucel_phone_dc                => inucel_phone_dc,
                                   inucity_corresp_dane_code      => inucity_corresp_dane_code,
                                   isbfiller                      => isbfiller,
                                   inureserved_cf                 => inureserved_cf,
                                   isbbranch_code_cf              => isbbranch_code_cf,
                                   isbratings_cf                  => isbratings_cf,
                                   inumora_years_cf               => inumora_years_cf,
                                   inuinitial_issue_date_cf       => inuinitial_issue_date_cf,
                                   inutermination_date_cf         => inutermination_date_cf,
                                   inudue_date_cf                 => inudue_date_cf,
                                   inutype_payment_cf             => inutype_payment_cf,
                                   inufixed_charge_value_cf       => inufixed_charge_value_cf,
                                   inurestruct_obligation_cf      => inurestruct_obligation_cf,
                                   inunumber_of_restructuring_cf  => inunumber_of_restructuring_cf,
                                   inunumber_of_retur_checks_cf   => inunumber_of_retur_checks_cf,
                                   inudays_of_portfolio_cf        => inudays_of_portfolio_cf,
                                   isbthird_house_address_cf      => isbthird_house_address_cf,
                                   isbthird_home_phone_cf         => isbthird_home_phone_cf,
                                   inuevery_city_code_cf          => inuevery_city_code_cf,
                                   isbtown_house_party_cf         => isbtown_house_party_cf,
                                   inuhome_department_code_cf     => inuhome_department_code_cf,
                                   isbdepar_of_third_house_cf     => isbdepar_of_third_house_cf,
                                   isbcompany_name_cf             => isbcompany_name_cf,
                                   inucompany_phone_cf            => inucompany_phone_cf,
                                   inucity_code_cf                => inucity_code_cf,
                                   isbnow_city_of_third_cf        => isbnow_city_of_third_cf,
                                   inudepartament_code_cf         => inudepartament_code_cf,
                                   isbthird_company_department_cf => isbthird_company_department_cf,
                                   inunat_restructuring_cf        => inunat_restructuring_cf,
                                   isblegal_nature                => isblegal_nature,
                                   isbvalue_of_collateral         => isbvalue_of_collateral,
                                   isbservice_category            => isbservice_category,
                                   inuspace_overdraft             => inuspace_overdraft,
                                   inuauthorized_days             => inuauthorized_days,
                                   isbcompany_address_cf          => isbcompany_address_cf,
                                   inunumber_months_contract_cf   => inunumber_months_contract_cf,
                                   isbcredit_mode                 => isbcredit_mode);

      -- si es reporte inserta en ld_sample_detail
    ELSIF isbrepomuestra = 'R' THEN

      nuultimopasoejecutado := 210;

      proinsld_sample_detai(inuidentification_number       => inuidentification_number,
                            isbaccount_number              => isbaccount_number,
                            isbtype_contract_id_cf         => isbtype_contract_id_cf,
                            inustate_of_contract_cf        => inustate_of_contract_cf,
                            inuterm_contract_cf            => inuterm_contract_cf,
                            inumethod_payment_id_cf        => inumethod_payment_id_cf,
                            inuaccount_state_id_dc         => inuaccount_state_id_dc,
                            inudate_status_account         => inudate_status_account,
                            inuvalue_delay                 => inuvalue_delay,
                            isbradication_office_dc        => isbradication_office_dc,
                            isbcity_radication_office_dc   => isbcity_radication_office_dc,
                            inucity_radi_offi_dane_cod_dc  => inucity_radi_offi_dane_cod_dc,
                            isbresidential_city_dc         => isbresidential_city_dc,
                            inucity_resi_offi_dane_cod_dc  => inucity_resi_offi_dane_cod_dc,
                            isbresidential_address_dc      => isbresidential_address_dc,
                            inuresidential_phone_dc        => inuresidential_phone_dc,
                            isbdepartment_work_dc          => isbdepartment_work_dc,
                            isbaddress_work_dc             => isbaddress_work_dc,
                            inuphone_work_dc               => inuphone_work_dc,
                            isbcity_correspondence_dc      => isbcity_correspondence_dc,
                            isbdept_correspondence_dc      => isbdept_correspondence_dc,
                            isbaddress_correspondence_dc   => isbaddress_correspondence_dc,
                            isbemail_dc                    => isbemail_dc,
                            inucel_phone_dc                => inucel_phone_dc,
                            inucity_corresp_dane_code      => inucity_corresp_dane_code,
                            isbfiller                      => isbfiller,
                            inureserved_cf                 => inureserved_cf,
                            isbbranch_code_cf              => isbbranch_code_cf,
                            isbratings_cf                  => isbratings_cf,
                            inumora_years_cf               => inumora_years_cf,
                            inuinitial_issue_date_cf       => inuinitial_issue_date_cf,
                            inutermination_date_cf         => inutermination_date_cf,
                            inudue_date_cf                 => inudue_date_cf,
                            inutype_payment_cf             => inutype_payment_cf,
                            inufixed_charge_value_cf       => inufixed_charge_value_cf,
                            inurestruct_obligation_cf      => inurestruct_obligation_cf,
                            inunumber_of_restructuring_cf  => inunumber_of_restructuring_cf,
                            inunumber_of_retur_checks_cf   => inunumber_of_retur_checks_cf,
                            inudays_of_portfolio_cf        => inudays_of_portfolio_cf,
                            isbthird_house_address_cf      => isbthird_house_address_cf,
                            isbthird_home_phone_cf         => isbthird_home_phone_cf,
                            inuevery_city_code_cf          => inuevery_city_code_cf,
                            isbtown_house_party_cf         => isbtown_house_party_cf,
                            inuhome_department_code_cf     => inuhome_department_code_cf,
                            isbdepar_of_third_house_cf     => isbdepar_of_third_house_cf,
                            isbcompany_name_cf             => isbcompany_name_cf,
                            inucompany_phone_cf            => inucompany_phone_cf,
                            inucity_code_cf                => inucity_code_cf,
                            isbnow_city_of_third_cf        => isbnow_city_of_third_cf,
                            inudepartament_code_cf         => inudepartament_code_cf,
                            isbthird_company_department_cf => isbthird_company_department_cf,
                            inunat_restructuring_cf        => inunat_restructuring_cf,
                            isblegal_nature                => isblegal_nature,
                            isbvalue_of_collateral         => isbvalue_of_collateral,
                            isbservice_category            => isbservice_category,
                            inuspace_overdraft             => inuspace_overdraft,
                            inuauthorized_days             => inuauthorized_days,
                            isbcompany_address_cf          => isbcompany_address_cf,
                            inunumber_months_contract_cf   => inunumber_months_contract_cf,
                            isbcredit_mode                 => isbcredit_mode);

      -- Si se esta generando reporte, se debe generar notificacion
      --If isbrepomuestra = 'R' Then

      nuultimopasoejecutado := 220;
      -- Si se esta procesando diferidos o servicios se inserta en las tablas ld_reported_deferred
      -- o ld_reported_productos respectivamente
      IF v_sbdifoser = 'D' THEN

        nuultimopasoejecutado := 230;
        proinsertald_reported_deferred(isbaccount_number        => isbaccount_number,
                                       regsuscrib_ident_type_id => regsuscrib_ident_type_id,
                                       inuidentification_number => inuidentification_number);

      ELSIF v_sbdifoser = 'P' THEN

        nuultimopasoejecutado := 250;
        proinsertald_reported_products(inuproduct_id          => isbaccount_number,
                                       inuidentification_type => regsuscrib_ident_type_id,
                                       inuidentification      => inuidentification_number);
      END IF; -- If isbdifoser = 'D' Then

      /*nuultimopasoejecutado := 260;
      If ibscliecodeu = 'CLIENTE' Then

        nuultimopasoejecutado := 270;
        boinsdetail           := ld_bcconfigurationdetailnotif.fboinsertdetconfignotifi(ionunotificationid => nusecuencia,
                                                                                        ionudetailnotifiid => nucount,
                                                                                        idatenotification  => v_statement_date,
                                                                                        iageprotfolio      => nudiasdemora,
                                                                                        idocumnumber       => inusesususc,
                                                                                        isubsdocument      => inuidentification_number,
                                                                                        itypenotific       => 3,
                                                                                        isbaddress         => isbresidential_address_dc,
                                                                                        iobligation        => isbaccount_number);
      Elsif ibscliecodeu = 'CODEUDOR' Then

        nuultimopasoejecutado := 280;
        boinsdetail           := ld_bcconfigurationdetailnotif.fboinsertdetconfignotifi(ionunotificationid => nusecuencia,
                                                                                        ionudetailnotifiid => nucount,
                                                                                        idatenotification  => v_statement_date,
                                                                                        iageprotfolio      => nudiasdemora,
                                                                                        idocumnumber       => inusesususc,
                                                                                        isubsdocument      => inuidentification_number,
                                                                                        itypenotific       => 4,
                                                                                        isbaddress         => isbaddress_correspondence_dc,
                                                                                        iobligation        => isbaccount_number);

      End If; -- If isbrepomuestra = 'R' Then*/

    END IF; -- If isbrepomuestra = 'M'
    -- Se controla la excepcion para evitar que se pierdan consecutivos al insertar en
    -- ld_error_account.  smunoz. 11-08-2013
  EXCEPTION
    WHEN OTHERS THEN
      nucount      := nucount - 1;
      v_sum_of_new := v_sum_of_new - v_new_portfolio; --regsuscrib.sesunuse;
      proregistrarerror(inutype_identification   => regsuscrib_ident_type_id,
                        inuidentification_number => inuidentification_number,
                        isbaccount_number        => isbaccount_number);

  END prosample_detai;

  PROCEDURE proinsertald_sample_fin IS

    /******************************************************************
    Proposito:  Insertar un registro en la tabla LD_SAMPLE_FIN

    Historia de Modificaciones

    Fecha           IDEntrega

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

  BEGIN
    nuultimopasoejecutado := 290;

    INSERT INTO ld_sample_fin
      (id,
       sample_id,
       final_record_indicator,
       date_of_process,
       number_of_record,
       sum_of_new,
       filler,
       type_register,
       total_number_of_records,
       number_of_records2,
       number_of_records3,
       number_of_records4)
    VALUES
      (nusecuencia, --id,
       nusecuencia, --sample_id,
       v_final_record_indicator, --final_record_indicator,
       v_date_of_proccess, --date_of_process,
       nucount + 2, --number_of_record,
       v_sum_of_new, --sum_of_new,
       v_filler, --filler,
       type_register_9, --type_register,
       nucount + 2, --total_number_of_records,
       nucount, --number_of_records2,
       0, --number_of_records3,
       0); --number_of_records4)

  EXCEPTION
    WHEN dup_val_on_index THEN
      pkerrors.pop;
      RAISE login_denied;
    WHEN OTHERS THEN
      pkerrors.pop;
      pkerrors.geterrorvar(onuerrorcode, osberrormessage);
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  END proinsertald_sample_fin;

  PROCEDURE proinsertald_random_sample_fin IS
    /******************************************************************
    Proposito:  IInserta un registro en la tabla ld_random_sample_fin

    Historia de Modificaciones

    Fecha           IDEntrega

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

  BEGIN

    nuultimopasoejecutado := 300;
    INSERT INTO ld_random_sample_fin
      (id,
       random_sample_id,
       final_record_indicator,
       date_of_process,
       number_of_record,
       sum_of_new,
       filler,
       type_register,
       total_number_of_records,
       number_of_records2,
       number_of_records3,
       number_of_records4)
    VALUES
      (nusecuencia, --id,
       nusecuencia, --sample_id,
       v_final_record_indicator, --final_record_indicator,
       v_date_of_proccess, --date_of_process,
       nucount + 2, --number_of_record,
       v_sum_of_new, --sum_of_new,
       v_filler, --filler,
       type_register_9, --type_register,
       nucount + 2, --total_number_of_records,
       nucount, --number_of_records2,
       0, --number_of_records3,
       0); --number_of_records4)

  EXCEPTION
    WHEN dup_val_on_index THEN
      pkerrors.pop;
      RAISE login_denied;
    WHEN OTHERS THEN
      pkerrors.pop;
      pkerrors.geterrorvar(onuerrorcode, osberrormessage);
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  END proinsertald_random_sample_fin;

  PROCEDURE prosample_fin IS
    /******************************************************************
    Proposito:  Insertar un registro en la tabla ld_sample_fin o
                ld_random_sample_fin dependiendo si se esta generando
                un reporte o muna muestra respectivamente

    Historia de Modificaciones

    Fecha           IDEntrega

    08-08-2013      smunozSAO213862
    Se genera la muestra por sector y producto.

    27-07-2013      smunozSAO212457
    Se agregan las variables que permiten identificar la tabla y la
    operacion que se esta realizando para que si el programa llega
    a entrar en una excepcion sea posible saber hasta que punto se
    alcanzo a ejecutar. Si el programa se esta reanudando, es decir,
    se esta retomando un proceso anterior terminado con error, se
    evalua si esta seccion se alcanzo a ejecutar y se parte de este
    punto.

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

  BEGIN

    nuultimopasoejecutado := 310;

    g_table_name_trace := 'LD_SAMPLE_FIN';
    g_operation_trace  := 'INSERT';

    -- Si la central de riesgo es DataCredito
    IF (inucreditbereauid = cdatacredito) THEN

      nuultimopasoejecutado := 320;
      v_date_of_proccess    := v_statement_date;

      -- Si la central de riesgo es CIFIN
    ELSIF inucreditbereauid = ccifin THEN

      nuultimopasoejecutado    := 330;
      v_final_record_indicator := NULL;
      v_date_of_proccess       := NULL;
      v_sum_of_new             := NULL;
      v_filler                 := NULL;
    END IF; -- If (inucreditbereauid = 1) Then

    nuultimopasoejecutado := 350;

    -- Solo se toma la informacion de la iteracion si se proceso informacion
    IF isbrepomuestra = 'M' OR
       (isbrepomuestra = 'R' AND
       ((nvl(g_table_name_error, g_table_name_trace) = g_table_name_trace AND
       nvl(g_operation_error, g_operation_trace) = g_operation_trace) OR
       g_table_name_error = 'LD_SAMPLE' OR
       (g_table_name_error = 'LD_SAMPLE_CONT' AND
       (g_operation_error = 'INSERT' OR g_operation_error = 'UPDATE_1')))) THEN

      ionutotalrec := nucount;
      ionutotalnov := v_sum_of_new;
    END IF;

    nuultimopasoejecutado := 360;

    -- Si se esta generando el reporte o muestra y es la primra parte del proceso. smunozSAO213862
    IF insbtypegen = 'N' THEN

      nuultimopasoejecutado := 380;

      -- Se inserta el resultado del proceso en las tablas sample_fin y random_sample_fin
      IF isbrepomuestra = 'R' THEN

        nuultimopasoejecutado := 390;

        -- Se raliza el insert y el error ocurrio en alguna de las tablas que deben
        -- estar llenas antes de la tabla ld_sample_fin
        IF (nvl(g_table_name_error, g_table_name_trace) =
           g_table_name_trace AND
           nvl(g_operation_error, g_operation_trace) = g_operation_trace) OR
           g_table_name_error = 'LD_SAMPLE' OR
           (g_table_name_error = 'LD_SAMPLE_CONT' AND
           (g_operation_error = 'INSERT' OR g_operation_error = 'UPDATE_1')) THEN
          proinsertald_sample_fin;
          p_borra_trace;
        END IF;

      ELSIF isbrepomuestra = 'M' THEN

        nuultimopasoejecutado := 400;
        proinsertald_random_sample_fin;
      END IF; -- If isbrepomuestra = 'R' Then

      -- Si se esta generando la segunda parte del reporte, se toma el conteo que se llevaba antes
    ELSIF insbtypegen <> 'N' THEN

      IF isbrepomuestra = 'R' THEN

        nuultimopasoejecutado := 410;

        g_table_name_trace := 'LD_SAMPLE_FIN';
        g_operation_trace  := 'UPDATE';

        IF (nvl(g_table_name_error, g_table_name_trace) =
           g_table_name_trace AND
           nvl(g_operation_error, g_operation_trace) = g_operation_trace) OR
           g_table_name_error = 'LD_SAMPLE' OR
           (g_table_name_error = 'LD_SAMPLE_CONT' AND
           (g_operation_error = 'INSERT' OR g_operation_error = 'UPDATE_1')) THEN

          UPDATE ld_sample_fin
             SET number_of_record        = ionutotalrec + 2,
                 sum_of_new              = ionutotalnov,
                 total_number_of_records = ionutotalrec + 2,
                 number_of_records2      = nucount
           WHERE sample_id = nusecuencia;
          p_borra_trace;
        END IF;
      ELSIF isbrepomuestra = 'M' THEN
        UPDATE ld_random_sample_fin
           SET number_of_record        = ionutotalrec + 2,
               sum_of_new              = ionutotalnov,
               total_number_of_records = ionutotalrec + 2,
               number_of_records2      = nucount
         WHERE random_sample_id = nusecuencia;
      END IF;
    END IF; -- If (insbtypegen = 'N' And isbrepomuestra = 'R') Or isbrepomuestra = 'M' Then

  END prosample_fin;

  /*  Procedure proobtenerdiasmora(idtdfmven         In Out cuencobr.cucofeve%Type,
                               idtstatement_date Date,
                               inudiasdemora     In Out Number,
                               inuedamora        In Out Number,
                               inuvalidador      In Out Number) Is
    \******************************************************************
    Proposito:  Calcula dias y edad de mora

    Historia de Modificaciones

    Fecha           IDEntrega

    15-06-2013      smunoz
    Creacion.
    ******************************************************************\

  Begin

    nuultimopasoejecutado := 420;

    If (idtdfmven Is Null) Then
      idtdfmven := idtstatement_date;
    End If; -- If (idtdfmven Is Null) Then

    -- Obtener numero de dias en mora
    inudiasdemora := to_date(idtstatement_date, 'dd/mm/yyyy hh24:MI:SS') -
                     to_date(idtdfmven, 'dd/mm/yyyy hh24:MI:SS');
    If (inudiasdemora > 999) Then
      inudiasdemora := 999;
    End If; -- If (inudiasdemora > 999) Then
    nuultimopasoejecutado := 440;
    Begin
      Select t.default_age_id
        Into inuedamora
        From ld_default_age_cf t
       Where inudiasdemora Between t.min And t.max;
    Exception
      When Others Then
        inuvalidador := -1;
    End;

  End proobtenerdiasmora;*/

  FUNCTION fsbscore_dc(inuaccount_state_id ld_finan_status_dc.account_state_id%TYPE,
                       inunew_portolio_id  ld_finan_status_dc.new_portfolio_id%TYPE)
    RETURN VARCHAR2 IS
    isbscore ld_finan_status_dc.score%TYPE;

    /******************************************************************
    Proposito: Indica si el reporte es positivo o negativo

    Historia de Modificaciones

    Fecha           IDEntrega
    17-08-2013      smunozSAO213076
    Creacion
    ******************************************************************/

  BEGIN
    SELECT lfsd.score
      INTO isbscore
      FROM ld_finan_status_dc lfsd
     WHERE lfsd.account_state_id = inuaccount_state_id
       AND lfsd.new_portfolio_id = inunew_portolio_id;

    RETURN isbscore;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'P';
  END;

  FUNCTION fsbscore_cf(inumorage ld_sample_detai.mora_age%TYPE,
                       inucuomo  ld_sample_detai.shares_debt%TYPE)
    RETURN VARCHAR2 IS
    isbscore ld_sample_detai.score%TYPE;

    /******************************************************************
    Proposito: Indica si el reporte es positivo o negativo

    Historia de Modificaciones

    Fecha           IDEntrega
    17-08-2013      smunozSAO213076
    Creacion
    ******************************************************************/

  BEGIN

    IF inumorage > 0 AND inucuomo > 0 THEN
      isbscore := 'N';
    ELSE
      isbscore := 'P';
    END IF;

    RETURN isbscore;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'P';
  END;

  PROCEDURE proobtenerdatosdetail(regsuscrib_sesudepa      servsusc.sesudepa%TYPE,
                                  regsuscrib_sesuloca      servsusc.sesuloca%TYPE,
                                  regsuscrib_sesuesfn      servsusc.sesuesfn%TYPE,
                                  regsuscrib_sesuserv      servsusc.sesuserv%TYPE,
                                  regsuscrib_ident_type_id ge_subscriber.ident_type_id%TYPE,
                                  regsuscrib_sesunuse      servsusc.sesunuse%TYPE) IS

    /******************************************************************
    Proposito:  Obtiene nombre de departamento, nombre de localidad,
                parametros de la aplicacion almacenado en la tabla
                LD_BCEQUIVALE_REPORT, calculo de la variable new_portfolio

    Historia de Modificaciones

    Fecha           IDEntrega

    21-08-2013      smunozSAO213366
    Se obtiene la informacion para las variables dependiendo de la central que se este
    procesando

    03-07-2013      smunoz
    Obtiene el valor de la variable v_new_porfolio

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

    nuesco NUMBER;

  BEGIN

    nuultimopasoejecutado := 450;

    /* Obtener nombre del departamento */
    SELECT g.description
      INTO sbnomdepa
      FROM ge_geogra_location g
     WHERE g.geograp_location_id = regsuscrib_sesudepa;

    nuultimopasoejecutado := 460;

    /* Obrener nombre de la localidad */
    SELECT g.description
      INTO sbnomloca
      FROM ge_geogra_location g
     WHERE g.geograp_location_id = regsuscrib_sesuloca;

    nuultimopasoejecutado := 470;

    /*Obtiene estado de corte*/

    SELECT sesuesco
      INTO nuesco
      FROM servsusc
     WHERE sesunuse = regsuscrib_sesunuse;

    /* obtener datos del paquete LD_BCEQUIVALE_REPORT */
    numethpay          := ld_bcequivalreport.fnugetmethodpayment(regsuscrib_sesuesfn); --no aplica a gasplus
    nutypeport         := ld_bcequivalreport.fnugettypeportfol(regsuscrib_sesuserv);
    nulinecred         := ld_bcequivalreport.fnugetlinecredit(inutypesector);
    sbinfpack          := ld_bcequivalreport.fsbgetinfopackage(regsuscrib_sesuserv);
    sbtypcont          := ld_bcequivalreport.fsbgettypecontractsc(inutypesector);
    nustatobl          := ld_bcequivalreport.fnugetstateobligation(regsuscrib_sesuesfn,
                                                                   inutypesector,
                                                                   nuesco,
                                                                   fnuvaluesinmil(nudebt));
    nuterm_contract_cf := ld_bcequivalreport.fsbgettermcontractsc(inutypesector);

    -- Clase tarjeta. SAO223793
    IF inucreditbereauid = ccifin THEN
      nucard_class_dc := NULL;
    ELSIF inucreditbereauid = cdatacredito THEN
      nucard_class_dc := 0;
    END IF;

    sbservice_category := ld_bcequivalreport.fnugetservicecateg(inutypesector);

    nuultimopasoejecutado := 475;

    IF (nutypeport = -1) THEN
      nutypeport := NULL;
    END IF;
    IF (nulinecred = -1) THEN
      nulinecred := NULL;
    END IF;
    IF (sbtypcont = -1) THEN
      sbtypcont := NULL;
    END IF;

    -- Newportfolio
    IF inucreditbereauid = ccifin THEN
      v_new_portfolio := NULL;
      sbscore         := fsbscore_cf(nuvalmor, nucuomor);
    ELSIF inucreditbereauid = cdatacredito THEN
      BEGIN
        SELECT lnpd.new_portfolio_id
          INTO v_new_portfolio
          FROM ld_new_portfolio_dc lnpd
         WHERE nvl(nudiasdemora, 0) BETWEEN lnpd.mora_age_min AND
               lnpd.mora_age_max
           AND lnpd.financial_state =
               decode(regsuscrib_sesuesfn, 'C', 'C', -1);
      EXCEPTION
        WHEN OTHERS THEN
          v_new_portfolio := 0;
      END;
      sbscore := fsbscore_dc(sbaccstatdc, v_new_portfolio);
    END IF; -- If inucreditbereauid = ccifin Then

    -- Se obtiene la informacion para las variables dependiendo de la central que se este
    -- procesando. smunozSAO2013366
    IF inucreditbereauid = ccifin THEN
      ident_type_cf := ld_bcequivalreport.fnugetidentificationtypecf(regsuscrib_ident_type_id);
      sbaccstatcf   := ld_bcequivalreport.fsbgetaccountstatuscf(regsuscrib_sesuesfn);

      SELECT MAX(type_identificacion_id)
        INTO ident_type_dc
        FROM ld_type_identificat_dc;
      sbaccstatdc := NULL;

    ELSIF inucreditbereauid = cdatacredito THEN
      ident_type_dc := ld_bcequivalreport.fnugetidentificationtypedc(regsuscrib_ident_type_id);
      sbaccstatdc   := ld_bcequivalreport.fsbgetaccountstatusdc(v_new_portfolio);
      SELECT MAX(type_identificacion_id)
        INTO ident_type_cf
        FROM ld_type_identificat_cf;
      sbaccstatcf := NULL;

    END IF;

    -- nuTerm_cf.  smunozSAO223793 20-11-2013 Se crea una variable para manejar el
    -- llenar la variable que pobla el campo term_cf
    IF inucreditbereauid = ccifin THEN
      nuterm_cf := NULL;
    ELSIF inucreditbereauid = cdatacredito THEN
      nuterm_cf := 0;
    END IF;

    -- PAYMENT_DATE. smunozSAO223793 20-11-2013 Se envia null a cifin en el caso
    -- se se haya recuperado un 0 en la variable.
    IF inucreditbereauid = ccifin THEN
      IF nufeulpa = 0 THEN
        nufeulpa := NULL;
      END IF;
    END IF;

    nuultimopasoejecutado := 478;
  END proobtenerdatosdetail;

  FUNCTION fsbclientedioautorizparaenvio(inuident_type_id   ld_send_authorized.ident_type_id%TYPE,
                                         isbidentification  ld_send_authorized.identification%TYPE,
                                         isbTipoResponsable ld_send_authorized.tipo_responsable%TYPE -- Tipo responsable
                                 --        inuidproduct       ld_send_authorized.product_id%TYPE
                                         ) RETURN VARCHAR2

   IS

    /*******************************************************************************************
    Proposito: Identificar si un cliente ha autorizado su
               reporte a centrales de riesgo.

    Historia de Modificaciones

    Fecha           IDEntrega

    26-10-2016      CA200-792. Sandra Mu?oz
    Se agrega el par?metro isbTipoResponsable para usarlo al determinar si una persona ha
    autorizado su reporte a centrales de riesgo

    28-06-2013      smunoz
    Creacion.
    *******************************************************************************************/

    vsbauthorized ld_send_authorized.authorized%TYPE;

    -- Inicio CA 200-792.
    sbTipoResponsable ld_send_authorized.tipo_responsable%TYPE; -- Tipo de responsable
    -- Fin CA 200-792.

  BEGIN
    nuultimopasoejecutado := 489;

    -- Buscar el cliente en la tabla donde se almacenan los clientes que
    -- han dado o no su autorizacion para ser reportados a las centrales
    -- de riesgo
    SELECT lsa.authorized, lsa.tipo_responsable
      INTO vsbauthorized, sbTipoResponsable
      FROM ld_send_authorized lsa
     WHERE lsa.ident_type_id      = inuident_type_id
       AND lsa.identification     = isbidentification
  --     AND lsa.type_product_id    = decode(inutypeproductid,-1,lsa.type_product_id,inutypeproductid)
  --     AND nvl(lsa.product_id,-1) = nvl(inuidproduct,-1)
       AND lsa.type_product_id =
           decode(inutypeproductid,
                  -1,
                  lsa.type_product_id,
                  inutypeproductid);

    -- Inicio CA 200-792
    -- Si la persona est? registrada en la tabla ld_send_authorized pero no como el tipo de
    -- responsable que indica el par?metro ni est? marcado como A-Ambos se retorna que
    -- si est? autorizado para reportarse
    IF fblaplicaentrega(csbBSS_CAR_SMS_200792) THEN
      IF sbTipoResponsable NOT IN ('A', isbTipoResponsable) THEN
        RETURN 'S';
      END IF;
    END IF;
    -- Fin CA 200-792

    RETURN vsbauthorized;
  EXCEPTION
    WHEN OTHERS THEN
      -- Si el cliente no esta en esta tabla o si ocurre algun error al consultarla
      -- tabla se asume que tenemos su autorizacion para enviarlo en el reorte a
      -- las centrales de riesgo
      RETURN 'S';
  END fsbclientedioautorizparaenvio;

  FUNCTION fsbestadoinconsistencia(inusesunuse       servsusc.sesunuse%TYPE,
                                   inunivel          VARCHAR2, -- nivel a reportar, Producto o difeirdo
                                   isbidentification ge_subscriber.identification%TYPE)
    RETURN VARCHAR2 IS

    /******************************************************************
    Proposito: Buscar el estado de una inconsistencia

    Historia de Modificaciones

    Fecha           IDEntrega

    23-08-2013      smunozSAO213366
    Se completa con ceros a la derecha e izquierda para alcanzar
    la longitud que datacredito tiene para este tipo de archivos

    27-06-2013      smunoz
    Creacion.
    ******************************************************************/

    vsbestado_inconsistencia_cf ld_inconsistency_detai_cf.state_inconsistency%TYPE;
    vsbestado_inconsistencia_dc ld_inconsistency_detai_dc.state%TYPE;
  BEGIN

    nuultimopasoejecutado := 490;

    -- Si es datacredito
    IF inucreditbereauid = cdatacredito THEN

      nuultimopasoejecutado := 495;

      -- Se completa con ceros a la derecha e izquierda para alcanzar
      -- la longitud que datacredito tiene para este tipo de archivos
      -- smunozSAO213366
      BEGIN
        SELECT lidd.state
          INTO vsbestado_inconsistencia_dc
          FROM ld_inconsistency_detai_dc lidd
         WHERE lidd.number_account_reported = inusesunuse
           AND lidd.nivel = inunivel
           AND lidd.id_number = lpad(isbidentification, 11, '0')
           AND lidd.type_identif_reported = ident_type_dc
           AND lidd.state <> 'C';
      EXCEPTION
        WHEN no_data_found THEN
          vsbestado_inconsistencia_dc := 'C';
        WHEN too_many_rows THEN
          vsbestado_inconsistencia_dc := 'R';
        WHEN OTHERS THEN
          vsbestado_inconsistencia_dc := 'C';
      END;

      RETURN vsbestado_inconsistencia_dc;

      -- Si es cifin
    ELSIF inucreditbereauid = ccifin THEN

      -- Verificar si el usuario procesado tiene inconsistencias sin corregir
      nuultimopasoejecutado := 500;

      SELECT COUNT(1)
        INTO vnuinconsissincorregir
        FROM ld_inconsistency_detai_cf lidc
       WHERE lidc.type_identification = ident_type_cf
         AND lidc.number_identification = isbidentification
         AND lidc.state_inconsistency <> 'C';

      -- Si las inconsistencias que tiene estan corregidas
      IF vnuinconsissincorregir = 0 THEN
        RETURN 'C';

        -- Si las inconsistencias que tiene alguna esta sin corregir
      ELSIF vnuinconsissincorregir > 0 THEN
        RETURN NULL;
      END IF;

    END IF; -- If inucreditbereauid = 1 Then

  END fsbestadoinconsistencia;

  PROCEDURE proestacompletalainfo(regsuscrib_sesunuse       servsusc.sesunuse%TYPE,
                                  regsuscrib_identification ge_subscriber.identification%TYPE,
                                  regsuscrib_ident_type_id  ge_subscriber.ident_type_id%TYPE,
                                  isbTipoResponsable        ld_send_authorized.tipo_responsable%TYPE -- CA 200-792
                                  ) IS

    /*******************************************************************************************
    Proposito: Valida si un registro esta completo y es valido para
               registrarlo en la tabla ld_random_sample o ld_sample

    Historia de Modificaciones

    Fecha           IDEntrega

    26-10-2016      CA 200-792.  Sandra Mu?oz
    Se agrega el par?metro de entrada  isbTipoResponsable y se envia al procedimiento
    fsbClienteDioAutorizParaEnvio

    28-06-2013      smunoz
    Si el cliente no ha dado su autorizacion para que sea reportado
    a las centrales de riesgo no debe enviarse en el archivo

    27-06-2013      smunoz
    Si el cliente a insertar esta contenido en el el archivo de
    inconsistencias y esta no ha sido corregida, no se debe insertar el registro


    15-06-2013      smunoz
    Creacion.
    *******************************************************************************************/

    vsberror_message  ld_error_account.error_message%TYPE;
    vsbtipo_documento ld_random_sample_detai.type_identification_cf%TYPE;

  BEGIN

    nuultimopasoejecutado := 510;

    accoutn_error := 0;

    /* Validar campos obligatorios */
    IF regsuscrib_sesunuse IS NULL THEN
      accoutn_error    := accoutn_error + 1;
      vsberror_message := vsberror_message ||
                          'Falta numero de servicio (regsuscrib.sesunuse). ';
    END IF;

    nuultimopasoejecutado := 520;

    IF (v_code_of_subscriber IS NULL) THEN
      accoutn_error    := accoutn_error + 1;
      vsberror_message := vsberror_message ||
                          'Falta codigo de suscriptor (v_code_of_subscriber) ';
    END IF;

    nuultimopasoejecutado := 530;

    IF (sbfullname IS NULL) THEN
      accoutn_error    := accoutn_error + 1;
      vsberror_message := vsberror_message ||
                          'Falta nombre completo (sbfullname). ';
    END IF;

    nuultimopasoejecutado := 540;

    IF (regsuscrib_identification IS NULL) THEN
      accoutn_error    := accoutn_error + 1;
      vsberror_message := vsberror_message ||
                          'Falta numero de identificacion (regsuscrib.identification). ';
    END IF;

    nuultimopasoejecutado := 550;

    IF (nuedamora IS NULL) THEN
      accoutn_error    := accoutn_error + 1;
      vsberror_message := vsberror_message ||
                          'Falta edad de mora (nuedamora). ';
    END IF;

    nuultimopasoejecutado := 560;

    IF (nusecuencia IS NULL) THEN
      accoutn_error    := accoutn_error + 1;
      vsberror_message := vsberror_message ||
                          'Falta numero de muestra (nusecuencia). ';
    END IF;

    nuultimopasoejecutado := 570;

    IF (nustatobl IS NULL) THEN
      accoutn_error    := accoutn_error + 1;
      vsberror_message := vsberror_message ||
                          'Falta estado de la obligacion (nustatobl). ';
    END IF;

    nuultimopasoejecutado := 580;

    IF (nvl(ident_type_cf, 0) = 0) AND inucreditbereauid = ccifin THEN
      accoutn_error    := accoutn_error + 1;
      vsberror_message := vsberror_message ||
                          'Falta tipo de documento (ident_type_cf). ';
    END IF;

    nuultimopasoejecutado := 590;

    IF (nvl(ident_type_dc, 0) = 0) AND inucreditbereauid = cdatacredito THEN
      accoutn_error    := accoutn_error + 1;
      vsberror_message := vsberror_message ||
                          'Falta tipo de documento (ident_type_dc). ';
    END IF;

    nuultimopasoejecutado := 600;

    IF (nuvalmor IS NULL) THEN
      accoutn_error    := accoutn_error + 1;
      vsberror_message := vsberror_message ||
                          'Falta valor mora (nuvalmor). ';
    END IF;

    nuultimopasoejecutado := 610;

    IF nvl(fsbestadoinconsistencia(inusesunuse       => regsuscrib_sesunuse,
                                   inunivel          => v_sbdifoser,
                                   isbidentification => regsuscrib_identification),
           'X') <> 'C' THEN
      accoutn_error    := accoutn_error + 1;
      vsberror_message := vsberror_message ||
                          'El cliente tiene inconsistencias sin corregir. ';
    END IF; -- If nvl (fsbestadoinconsistencia, 'X') = 'C'

    nuultimopasoejecutado := 640;
    IF (accoutn_error > 0) THEN

      vsberror_message      := substr(vsberror_message, 1, 4000);
      nuultimopasoejecutado := 650;
      proinsertld_error_account(isbaccount_number        => regsuscrib_sesunuse,
                                inuidentification_number => regsuscrib_identification,
                                inutype_identification   => regsuscrib_ident_type_id,
                                isberror_message         => vsberror_message);

    END IF; --If (iaccoutn_error > 0) Then

    -- Evaluar si el cliente esta autorizado para ser enviado a las centrales de riesgo, no lo esta, se incrementa el
    -- codigo del error para indicar que no se puede insertar en el detail
    nuultimopasoejecutado := 620;
    IF inucreditbereauid = cdatacredito THEN

      vsbtipo_documento := ident_type_dc;

    ELSIF inucreditbereauid = ccifin THEN
      vsbtipo_documento := ident_type_cf;
    END IF;

    nuultimopasoejecutado := 630;

    IF fsbclientedioautorizparaenvio(inuident_type_id   => vsbtipo_documento,
                                     isbidentification  => regsuscrib_identification,
                                     isbtiporesponsable => isbTipoResponsable) = 'N' THEN
      accoutn_error := accoutn_error + 1;
    END IF; --     If fsbclientedioautorizparaenvio(inuident_type_id  => vsbtipo_documento,

    -- Verificar si el numero de documento es

  END proestacompletalainfo;

  PROCEDURE proobtieneparamgenerales IS

    /******************************************************************
    Proposito: Obtener valor de la tabla LD_GENERAL_PARAMEtERS mediante
               metodo ProvaPaTaPa

    Historia de Modificaciones

    Fecha           IDEntrega

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

  BEGIN

    nuultimopasoejecutado := 660;

    provapatapa('INITIAL_RECORD_IDENTIFIER',
                'S',
                respuesta,
                v_initial_record_identifier);

    nuultimopasoejecutado := 670;

    provapatapa('FINAL_RECORD_INDICATOR',
                'S',
                respuesta,
                v_final_record_indicator);

    nuultimopasoejecutado := 680;

    provapatapa('TYPE_ACCOUNT', 'N', v_type_account, respuesta);

    nuultimopasoejecutado := 690;

    provapatapa('ENLARGEMENT_GOALS', 'S', respuesta, v_enlargement_goals);

    nuultimopasoejecutado := 700;

    provapatapa('INDICATOR_VALUES_IN_MIL',
                'S',
                respuesta,
                v_indicator_values_in_mil);

    nuultimopasoejecutado := 710;

    provapatapa('INDICATOR_FROM', 'S', respuesta, v_indicator_from);

    nuultimopasoejecutado := 720;

    provapatapa('TYPE_OF_DELIVERY', 'S', respuesta, v_type_of_delivery);

    nuultimopasoejecutado := 730;

    provapatapa('FILLER', 'S', respuesta, v_filler);

    nuultimopasoejecutado := 740;

    provapatapa('TYPE_OF_RECORD', 'N', v_type_of_record, respuesta);

    nuultimopasoejecutado := 750;

    v_code_package := ld_bcequivalreport.fsbgetcodepackage(inutypesector);

    nuultimopasoejecutado := 760;

    provapatapa('ENTITY_TYPE', 'N', v_entity_type, respuesta);

    nuultimopasoejecutado := 770;

    provapatapa('TYPE_REPORT', 'N', v_type_report, respuesta);

    nuultimopasoejecutado := 790;

    provapatapa('TYPE_OBLIGATION_DT', 'N', nutypobl, respuesta);

    nuultimopasoejecutado := 800;

    provapatapa('REGISTRO_TIPO_1', 'N', type_register_1, respuesta);

    nuultimopasoejecutado := 810;

    provapatapa('REGISTRO_TIPO_2', 'N', type_register_2, respuesta);

    nuultimopasoejecutado := 820;

    provapatapa('REGISTRO_TIPO_9', 'N', type_register_9, respuesta);

    nuultimopasoejecutado := 830;

    provapatapa('REPORTAR_CODEUDOR_CENTRAL',
                'S',
                respuesta,
                g_reportar_codeudor_central);

    /* Si tipo de entrega es T */
    IF (v_type_of_delivery = 'T') THEN
      v_star_report_date := NULL;
      v_end_report_dat   := NULL;
    END IF;

    nuultimopasoejecutado := 840;

    --Obtener usuario que esta trabajando
    nuuser_id := pkld_fa_reglas_definidas.fnugetusers;

    nuultimopasoejecutado := 850;
    -- El numero de la secuencia se calcula en ld_report_generation.
    -- para muestras y reportes smunozSAO213862
    nusecuencia      := inusampleid;
    nucount          := ionutotalrec;
    nuerrorcount     := nuerrorcount;
    v_statement_date := idtfechgen;
    nuanogen         := to_number(to_char(idtfechgen, 'yyyy'));
    numesgen         := to_number(to_char(idtfechgen, 'mm'));

    -- Si la central de riesgo es DataCredito  se limpian las variables
    IF (inucreditbereauid = cdatacredito) THEN

      nuultimopasoejecutado := 870;
      v_code_package        := NULL;
      v_entity_type         := NULL;
      v_type_report         := NULL;
      v_entity_code         := NULL;
      type_register_1       := 0;
      type_register_2       := 0;
      type_register_9       := 0;
      nutypemoney           := 1;
      nutypewarr            := 2;
      provapatapa('CODIGO_DATACREDITO',
                  'N',
                  v_code_of_subscriber,
                  respuesta);

      -- Si al central de riesgo es CIFIN y de SECTOR REAL se limpian las variables
    ELSIF (inucreditbereauid = ccifin AND inutypesector = cdiferido) THEN

      nuultimopasoejecutado := 880;
      --brilla
      v_initial_record_identifier := NULL;
      v_type_account              := NULL;
      v_enlargement_goals         := NULL;
      v_indicator_values_in_mil   := NULL;
      v_type_of_delivery          := NULL;
      v_indicator_from            := NULL;
      v_filler                    := NULL;
      v_star_report_date          := NULL;
      v_end_report_dat            := NULL;
      v_final_record_indicator    := NULL;
      nutypemoney                 := NULL;
      nutypewarr                  := NULL;
      provapatapa('CODIGO_CIFIN', 'N', v_code_of_subscriber, respuesta);
      v_entity_code := v_code_of_subscriber;

      -- Si al central de riesgo es CIFIN y de SECTOR COMERCIAL se limpian las variables
    ELSIF (inucreditbereauid = ccifin AND inutypesector = cservicio) THEN

      nuultimopasoejecutado := 890;
      -- gas
      v_initial_record_identifier := NULL;
      v_type_account              := NULL;
      v_enlargement_goals         := NULL;
      v_indicator_values_in_mil   := NULL;
      v_type_of_delivery          := NULL;
      v_indicator_from            := NULL;
      v_filler                    := NULL;
      v_star_report_date          := NULL;
      v_end_report_dat            := NULL;
      v_final_record_indicator    := NULL;
      nutypemoney                 := NULL;
      nutypewarr                  := NULL;
      provapatapa('CODIGO_CIFIN', 'N', v_code_of_subscriber, respuesta);
      v_entity_code := v_code_of_subscriber;

    END IF; -- If (inucreditbereauid = 1) Then

    -- Oficina de radicacion
    BEGIN
      SELECT s.sistempr INTO sbradoff FROM sistema s WHERE sistcodi = 99;
    EXCEPTION
      WHEN OTHERS THEN
        sbradoff := NULL;
    END;

  END proobtieneparamgenerales;

  PROCEDURE provalidaparametrosobl IS
    /******************************************************************
    Proposito: Valida si los datos ingresados por parametro estan completos para poder
               ejecutar el procedimiento

    Historia de Modificaciones

    Fecha           IDEntrega

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/
  BEGIN
    nuultimopasoejecutado := 900;

    IF isbrepomuestra = 'M' THEN
      nuultimopasoejecutado := 910;
      IF sbsubscriber_number IS NULL THEN
        nuultimopasoejecutado := 920;
        onuerrorcode          := 10;
        osberrormessage       := 'Falta indicar el numero de suscriptores para la muestra';
        RAISE exparametrosincompletos;

      END IF; -- If sbsubscriber_number Is Null Then

    ELSIF isbrepomuestra = 'R' THEN
      nuultimopasoejecutado := 920;
      IF inusampleid IS NULL THEN
        nuultimopasoejecutado := 930;
        onuerrorcode          := 20;
        osberrormessage       := 'Falta indicar el numero del reporte';
        RAISE exparametrosincompletos;

      ELSIF insbtypegen IS NULL THEN
        nuultimopasoejecutado := 940;
        onuerrorcode          := 30;
        osberrormessage       := 'Falta indicar si es la primera parte de la ejecucion';
        RAISE exparametrosincompletos;

      ELSIF ionutotalrec IS NULL THEN
        nuultimopasoejecutado := 950;
        onuerrorcode          := 40;
        osberrormessage       := 'Falta indicar el numero de registros con que debe iniciar el conteo ';
        RAISE exparametrosincompletos;

      ELSIF ionutotalnov IS NULL THEN
        nuultimopasoejecutado := 960;
        onuerrorcode          := 50;
        osberrormessage       := 'Falta indicar el numero de novedades ';
        RAISE exparametrosincompletos;

      ELSIF idtfechgen IS NULL THEN
        nuultimopasoejecutado := 970;
        onuerrorcode          := 60;
        osberrormessage       := 'Falta indicar la fecha de generacion del proceso';
        RAISE exparametrosincompletos;

      END IF; -- If isbrepomuestra = 'M' Then

      nuultimopasoejecutado := 980;

    END IF; -- If isbrepomuestra = 'M' Then

    nuultimopasoejecutado := 990;
  END provalidaparametrosobl;

  PROCEDURE proobtienedatoscodeudor(recodeud_ident_type_id   ge_subscriber.ident_type_id%TYPE,
                                    recodeud_subscriber_name ge_subscriber.subscriber_name%TYPE,
                                    recodeud_subs_last_name  ge_subscriber.subs_last_name%TYPE) IS
    /******************************************************************
    Proposito: Obtiene los datos referentes al codeudor

    Historia de Modificaciones

    Fecha           IDEntrega

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

  BEGIN

    nuultimopasoejecutado := 1000;
    ident_type_dc         := ld_bcequivalreport.fnugetidentificationtypedc(recodeud_ident_type_id);
    ident_type_cf         := ld_bcequivalreport.fnugetidentificationtypedc(recodeud_ident_type_id);
    nudeucodedt           := 1;
    sbdeucodecf           := 'C';

    -- valor numerico debt to dc

    -- Si este valor es nulo, se debe enviar con ese valor a la bd en el caso que sea
    -- CIFIN. smunozSAO223793
    IF inucreditbereauid = cdatacredito THEN
      nudebttodc := nvl(nuvalpen, 0) + nvl(nuvalmor, 0) + nvl(nusalpen, 0);
    ELSIF inucreditbereauid = ccifin THEN
      nudebttodc := nuvalpen + nuvalmor + nusalpen;
    END IF;

    -- Full name
    IF inucreditbereauid = ccifin AND ident_type_cf IN (1, 3, 4, 5) THEN
      sbfullname := rpad(rpad(recodeud_subs_last_name, 15, ' ') ||
                         fsbname(recodeud_subscriber_name),
                         60,
                         ' ');

    ELSIF inucreditbereauid = cdatacredito THEN
      sbfullname := substr(recodeud_subscriber_name || ' ' ||
                           recodeud_subs_last_name,
                           0,
                           45);
    ELSE
      sbfullname := substr(recodeud_subscriber_name || ' ' ||
                           recodeud_subs_last_name,
                           0,
                           60);
    END IF;
    nuultimopasoejecutado := 1010;

  END proobtienedatoscodeudor;

  PROCEDURE proactualizaavance(p_sesunuse servsusc.sesunuse%TYPE) IS
    /******************************************************************
    Proposito: Actualiza el numero de registros procesados y cada 1%
               de actualiza el avance en la tabla estaprog

    Historia de Modificaciones

    Fecha           IDEntrega

    24-07-2013      smunoz
    Creacion.
    ******************************************************************/

    v_reg_commit NUMBER := 1;
  BEGIN
    xinsertfgrcr('estoy en proactualizaavance nuse='||to_char(p_sesunuse)||' g_rec_procesados='||to_char(g_rec_procesados)||' g_rec_a_procesar='||to_char(g_rec_a_procesar));
    nuultimopasoejecutado := 20020;
    g_rec_procesados      := g_rec_procesados + 1;
    v_reg_commit          := trunc(g_rec_a_procesar / 100);

    IF v_reg_commit < 1 THEN
      nuultimopasoejecutado := 20030;
      v_reg_commit          := 1;
    END IF;
    nuultimopasoejecutado := 20040;
    IF MOD(g_rec_procesados, v_reg_commit) = 0 THEN
      nuultimopasoejecutado := 20050;
       xinsertfgrcr('estoy en proactualizaavance ='||to_char(p_sesunuse)||' va a actualizar el avance');
      pkstatusexeprogrammgr.upstatusexeprogramat(isbprog       => g_program_id,
                                                 isbmens       => 'Ultimo numero de servicio procesado: ' ||
                                                                  p_sesunuse,
                                                 inutotalreg   => g_rec_a_procesar,
                                                 inucurrentreg => g_rec_procesados);
      nuultimopasoejecutado := 20060;
      COMMIT;
      nuultimopasoejecutado := 20070;
    END IF; -- If Mod(nucount, cregistrosparacommit) = 0 Then
    nuultimopasoejecutado := 20080;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;

  PROCEDURE proprocesadif(regsuscrib reg_suscrib_dif) IS

    /******************************************************************
    Proposito: Procesa la informacion del diferido y lo inserta en la tabla
               ld_sample_detail o ld_rancom_sample_detail dependiendo si es
               muestra o reporte

    Historia de Modificaciones

    Fecha           IDEntrega

    26-10-2016      CA 200-792. Sandra Mu?oz
    Se envia el par?metro isbTipoResponsable al procedimiento fsbClienteDioAutorizParaEnvio para
    deudores y codeudores

    15-04-2016      CarenBerdejo
    se calcula el cupo o valor disponible

    24-07-2013      smunozSAO212457
    Registra el avance del proceso

    22-07-2013      smunozSAO212457
    Se agregan las variables que permiten identificar la tabla y la
    operacion que se esta realizando para que si el programa llega
    a entrar en una excepcion sea posible saber hasta que punto se
    alcanzo a ejecutar. Si el programa se esta reanudando, es decir,
    se esta retomando un proceso anterior terminado con error, se
    evalua si esta seccion se alcanzo a ejecutar y se parte de este
    punto.


    10-07-2013      smunoz
    Se hace uso del parametro REPORTAR_CODEUDOR_CENTRAL al momento de
    procesar codeudores, si este parametro se encuentra con valorr S se procesan
    y reportan codeudores si es necesario, sino no se reportan codeudores.

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/
    nuvalicalif NUMBER;

  BEGIN

    nuultimopasoejecutado := 1030;
    -- se calcula el cupo o valor disponible
    ld_bononbankfinancing.allocatetotalquota(regsuscrib.sesususc,
                                             nuassignedquote);
    nuusedquote := ld_bononbankfinancing.fnugetusedquote(regsuscrib.sesususc);
    IF (nuassignedquote >= nuusedquote) THEN
      nuavaliblequote := nuassignedquote - nuusedquote;
    ELSE
      nuavaliblequote := 0;
    END IF;

    IF (isbrepomuestra = 'R' AND
       (g_table_name_error IS NULL OR g_table_name_error = 'LD_SAMPLE' OR
       (g_table_name_error = 'LD_SAMPLE_CONT' AND
       (g_operation_error = 'UPDATE_1' OR g_operation_error = 'INSERT')))) OR
       isbrepomuestra = 'M' THEN

      -- Abrir cursor cuotas en mora
      OPEN cuota_mora(regsuscrib.sesunuse, regsuscrib.difecodi);
      FETCH cuota_mora
        INTO nuvalmor, nucuomor; -- aqui

      IF cuota_mora%NOTFOUND THEN
        nuvalmor := 0;
        nucuomor := 0;
      END IF;
      CLOSE cuota_mora;

      nuultimopasoejecutado := 1040;
      --Abrir cursor cuotas pagas
      OPEN cuotas_pagas(regsuscrib.sesunuse, regsuscrib.difecodi);
      FETCH cuotas_pagas
        INTO nucuopag;
      IF cuotas_pagas%NOTFOUND THEN
        --nuvalpag := 0;
        nucuopag := 0;
      END IF;
      CLOSE cuotas_pagas;

      nuultimopasoejecutado := 1050;
      -- Abrir cursor Fecha de Pago
      OPEN cufechpago(regsuscrib.sesunuse, regsuscrib.difecodi);
      FETCH cufechpago
        INTO nufeulpa;
      IF cufechpago%NOTFOUND THEN
        nufeulpa := 0;
      END IF;
      CLOSE cufechpago;

      -- Abrir cursor Fecha de Vencimiento
      OPEN cufechvenc(regsuscrib.sesunuse, regsuscrib.difecodi);
      FETCH cufechvenc
        INTO nufelipa;
      IF cufechvenc%NOTFOUND THEN
        nufelipa := 0;
      END IF;
      CLOSE cufechvenc;

      nuultimopasoejecutado := 1060;
      -- Abrir cursor Edad de Mora
      OPEN cuedadmora(regsuscrib.sesunuse, regsuscrib.difecodi);
      FETCH cuedadmora
        INTO dtfemven;

      --Si no encuentra registros
      IF (dtfemven IS NULL) THEN
        dtfemven := idtfechgen; --Null;
      END IF;

      -- Obtener numero de dias en mora
      nudiasdemora := to_date(idtfechgen, 'dd/mm/yyyy hh24:MI:SS') -
                      to_date(dtfemven, 'dd/mm/yyyy hh24:MI:SS');

      nuyearmora := trunc(nudiasdemora / 365);

      nutotalshare := regsuscrib.difenucu;

      numontvalue := regsuscrib.difevacu;

      IF nudiasdemora > 990 THEN
        nudiasdemora := 990;
      END IF;

      BEGIN
        SELECT t.default_age_id
          INTO nuedamora
          FROM ld_default_age_cf t
         WHERE nudiasdemora BETWEEN t.min AND t.max;
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;

      -- Cerrar cursor edad de mora
      CLOSE cuedadmora;

      nuultimopasoejecutado := 1070;
      -- Obtiene departamento, localidad, account_number y datos del paquete LD_BCEQUIVALE_REPORT
      proobtenerdatosdetail(regsuscrib_sesudepa      => regsuscrib.geo_loca_father_id,
                            regsuscrib_sesuloca      => regsuscrib.geograp_location_id,
                            regsuscrib_sesuesfn      => regsuscrib.sesuesfn,
                            regsuscrib_sesuserv      => regsuscrib.sesuserv,
                            regsuscrib_ident_type_id => regsuscrib.ident_type_id,
                            regsuscrib_sesunuse      => regsuscrib.sesunuse);

      -- Obtener datos de cartera
      nudto := nvl(to_number(to_char(regsuscrib.difefein, 'yyyymmdd')), 0);

      nustorigin := nvl(to_number(to_char(regsuscrib.difefein, 'yyyymmdd')),
                        0);

      -- Si no se encuentra informacio'n en este campo, debe enviarse nulo a la tabla.
      -- smunozSAO223793
      IF inucreditbereauid = cdatacredito THEN
        nuinitial_issue_date_cf := nvl(to_number(to_char(regsuscrib.difefein,
                                                         'yyyymmdd')),
                                       0);
      ELSIF inucreditbereauid = ccifin THEN
        nuinitial_issue_date_cf := to_number(to_char(regsuscrib.difefein,
                                                     'yyyymmdd'));
      END IF;

      nutermination_date_cf := nvl(to_number(to_char(regsuscrib.difefein +
                                                     (regsuscrib.difenucu * 30),
                                                     'yyyymmdd')),
                                   0);

      -- Se muestra el valor en miles si asi esta configurado en el sistema. smunozSAO213076
      nudebt := nvl(regsuscrib.difesape, 0) + nvl(nuvalmor, 0);

      nuduedt := nvl(to_number(to_char(add_months(regsuscrib.difefein,
                                                  regsuscrib.difenucu),
                                       'yyyymmdd')),
                     0);

      IF inucreditbereauid = ccifin AND ident_type_cf IN (1, 3, 4, 5) THEN
        sbfullname := rpad(rpad(regsuscrib.subs_last_name, 15, ' ') ||
                           fsbname(regsuscrib.subscriber_name),
                           60,
                           ' ');

      ELSIF inucreditbereauid = cdatacredito THEN
        sbfullname := substr(regsuscrib.subscriber_name || ' ' ||
                             regsuscrib.subs_last_name,
                             0,
                             45);
      ELSE
        sbfullname := substr(regsuscrib.subscriber_name || ' ' ||
                             regsuscrib.subs_last_name,
                             0,
                             60);
      END IF;

      nuopdt := nvl(to_number(to_char(regsuscrib.difefein, 'yyyymmdd')), 0);

      nudeucodedt := 0;
      sbdeucodecf := 'P';

      nuultimopasoejecutado := 1080;
      -- Valida que toda la informacion obligatoria este completa
      proestacompletalainfo(regsuscrib_sesunuse       => regsuscrib.sesunuse,
                            regsuscrib_identification => regsuscrib.identification,
                            regsuscrib_ident_type_id  => regsuscrib.ident_type_id,
                            isbTipoResponsable        => 'D'); -- CA 200-792

      IF accoutn_error = 0 THEN
        -- Inserta en la tabla de detalle
        nuultimopasoejecutado := 1090;

        prosample_detai(isbaccount_number             => regsuscrib.difecodi,
                        inuaccount_state_id_dc        => sbaccstatdc,
                        isbaddress_correspondence_dc  => substr(regsuscrib.address,
                                                                0,
                                                                60),
                        isbaddress_work_dc            => substr(regsuscrib.address,
                                                                0,
                                                                60),
                        inucel_phone_dc               => fsbremovechars(regsuscrib.phone,
                                                                        12),
                        inucity_corresp_dane_code     => regsuscrib.geograp_location_id,
                        isbcity_correspondence_dc     => substr(sbnomloca,
                                                                0,
                                                                20),
                        inucity_radi_offi_dane_cod_dc => regsuscrib.geograp_location_id,
                        isbcity_radication_office_dc  => substr(sbnomloca,
                                                                0,
                                                                20),
                        inucity_resi_offi_dane_cod_dc => regsuscrib.geograp_location_id,
                        inudate_status_account        => to_number(to_char(v_statement_date,
                                                                           'yyyymmdd')),
                        isbdept_correspondence_dc     => substr(sbnomdepa,
                                                                0,
                                                                20),
                        isbdepartment_work_dc         => substr(sbdeprwordesc,
                                                                0,
                                                                20),
                        isbemail_dc                   => substr(regsuscrib.e_mail,
                                                                0,
                                                                60),
                        inuidentification_number      => regsuscrib.identification,
                        inuphone_work_dc              => fsbremovechars(regsuscrib.phone,
                                                                        12),
                        isbradication_office_dc       => substr(sbradoff,
                                                                0,
                                                                30),
                        isbresidential_address_dc     => substr(regsuscrib.address,
                                                                0,
                                                                60),
                        isbresidential_city_dc        => substr(sbnomloca,
                                                                0,
                                                                20),
                        inuresidential_phone_dc       => fsbremovechars(regsuscrib.phone,
                                                                        12),
                        isbservice_category           => NULL,
                        isbtype_contract_id_cf        => substr(sbtypcont,
                                                                0,
                                                                3),
                        inuvalue_delay                => nvl(nuvalmor, 0),
                        ibscliecodeu                  => 'CLIENTE',
                        inusesususc                   => regsuscrib.sesususc,
                        regsuscrib_ident_type_id      => regsuscrib.ident_type_id);
      END IF; -- If account_error = 0

      nuultimopasoejecutado := 1100;

      IF g_reportar_codeudor_central = 'Y' THEN

        FOR recodeud IN cu_codeudor_dif(regsuscrib.difecodi) LOOP

          BEGIN

            nuultimopasoejecutado := 1110;

            proobtienedatoscodeudor(recodeud_ident_type_id   => recodeud.ident_type_id,
                                    recodeud_subscriber_name => recodeud.debtorname,
                                    recodeud_subs_last_name  => recodeud.last_name);

            --Opening date
            nuopdt := nvl(to_number(to_char(regsuscrib.difefein, 'yyyymmdd')),
                          0);

            -- valor numerico date status origin
            nudtstatusorigin := nvl(to_number(to_char(regsuscrib.difefein,
                                                      'yyyymmdd')),
                                    0);

            nuultimopasoejecutado := 1120;
            -- Valida que toda la informacion requerida este completa
            proestacompletalainfo(regsuscrib_sesunuse       => regsuscrib.difecodi,
                                  regsuscrib_identification => recodeud.identification,
                                  regsuscrib_ident_type_id  => recodeud.ident_type_id,
                                  isbTipoResponsable        => 'C');

            BEGIN
              SELECT sample_id
                INTO nucodereport
                FROM ld_sample_detai lsd
               WHERE lsd.sample_id IN
                     (SELECT MAX(ls.sample_id)
                        FROM ld_sample         ls,
                             ld_sector_product lsp,
                             ld_type_sector    lts
                       WHERE lsp.sector_id = lts.type_id
                         AND decode(ls.type_sector,
                                    -1,
                                    lsp.sector_id,
                                    ls.type_sector) = lsp.sector_id
                         AND ls.flag = 'S'
                       GROUP BY ls.type_sector, ls.credit_bureau_id)
                 AND lsd.identification_number = recodeud.identification;
            EXCEPTION
              WHEN OTHERS THEN
                nucodereport := 0;
            END;

            nuvalicalif := fnc_validacalifcodeudor(recodeud.ident_type_id, -- Tipo de identificacion
                                                   recodeud.identification,
                                                   sbestatus, -- Estado (N: nuevo, V: viejo)
                                                   regsuscrib.sesuesfn, -- Esatdo financiero
                                                   nucodereport, -- identificador del reporte anterior
                                                   regsuscrib.difecodi);

            IF nuvalicalif = 2 THEN
              accoutn_error := 1;
            ELSIF nuvalicalif = 3 THEN
              pro_atrasa_cartera(inusampleid, NULL, regsuscrib.difecodi);
              accoutn_error := 1;
            END IF;

            IF accoutn_error = 0 THEN

              nuultimopasoejecutado := 1130;
              -- Inserta en la tabla de detalle
              prosample_detai(isbaccount_number            => regsuscrib.difecodi,
                              inuaccount_state_id_dc       => sbaccstatdc,
                              isbaddress_correspondence_dc => substr(recodeud.address,
                                                                     0,
                                                                     60),
                              isbaddress_work_dc           => substr(recodeud.address,
                                                                     0,
                                                                     60),

                              inucel_phone_dc => fsbremovechars(recodeud.phone1_id,
                                                                12),

                              inucity_corresp_dane_code     => regsuscrib.geograp_location_id,
                              isbcity_correspondence_dc     => substr(sbnomloca,
                                                                      0,
                                                                      20),
                              inucity_radi_offi_dane_cod_dc => regsuscrib.geograp_location_id,
                              isbcity_radication_office_dc  => substr(sbnomloca,
                                                                      0,
                                                                      20),
                              inucity_resi_offi_dane_cod_dc => regsuscrib.geograp_location_id,
                              inudate_status_account        => to_number(to_char(v_statement_date,
                                                                                 'yyyymmdd')),
                              isbdept_correspondence_dc     => substr(sbnomdepa,
                                                                      0,
                                                                      20),
                              isbdepartment_work_dc         => substr(sbnomdepa,
                                                                      0,
                                                                      20),
                              isbemail_dc                   => substr(recodeud.email,
                                                                      0,
                                                                      60),

                              inuidentification_number  => recodeud.identification,
                              inuphone_work_dc          => fsbremovechars(recodeud.phone1_id,
                                                                          12),
                              isbradication_office_dc   => substr(sbradoff,
                                                                  0,
                                                                  30),
                              isbresidential_address_dc => substr(recodeud.address,
                                                                  0,
                                                                  60),

                              isbresidential_city_dc   => substr(sbnomloca,
                                                                 0,
                                                                 20),
                              inuresidential_phone_dc  => fsbremovechars(recodeud.phone1_id,
                                                                         12),
                              isbservice_category      => NULL,
                              isbtype_contract_id_cf   => substr(sbtypcont,
                                                                 0,
                                                                 3),
                              inuvalue_delay           => nvl(nuvalmor, 0),
                              ibscliecodeu             => 'CODEUDOR',
                              inusesususc              => regsuscrib.sesususc,
                              regsuscrib_ident_type_id => regsuscrib.ident_type_id);
            END IF; -- If account_error = 0 Then
          EXCEPTION
            WHEN OTHERS THEN
              proregistrarerror(inutype_identification   => regsuscrib.ident_type_id,
                                inuidentification_number => recodeud.identification,
                                isbaccount_number        => regsuscrib.difecodi);
          END;
          proactualizaavance(p_sesunuse => regsuscrib.difecodi ||
                                           'Codeudor');
        END LOOP; -- For recodeud In cu_codeudor(regsuscrib.sesunuse) Loop

      END IF; --  If g_reportar_codeudor_central = 'S' Then

      nuultimopasoejecutado := 20010;

      proactualizaavance(p_sesunuse => regsuscrib.difecodi);
    END IF; --           If (isbrepomuestra = 'R' And g_table_name_error Is Null Or g_table_name_error = 'LD_SAMPLE' Or

  END proprocesadif;

  PROCEDURE proprocesaser(regsuscrib reg_suscrib_ser) IS

    /******************************************************************
    Proposito: Procesar la informacion de los servicios e ingresarlos en las
               tablas ld_random_sample_detai o ld_sample_detai dependiendo
               si es muestra o reporte

    Historia de Modificaciones

    Fecha           IDEntrega

     19-05-2017     jsilvera
    Se realiza modificaci?n del proceso para cumplir requerimiento:
    Restarte a la la edada de mora la cantidad de d?as que debe reportar
    basao en la configuraci?n del parametro. Este requerimiento es solicitado en el
    punto 1 del caso 200-981.

    26-10-2016      CA 200-792. Sandra Mu?oz
    Se envia el par?metro isbTipoResponsable al procedimiento fsbClienteDioAutorizParaEnvio para
    deudores y codeudores

    24-07-2013      smunozSAO212457
    Registra el avance del proceso

    22-07-2013      smunozSAO212457
    Se agregan las variables que permiten identificar la tabla y la
    operacion que se esta realizando para que si el programa llega
    a entrar en una excepcion sea posible saber hasta que punto se
    alcanzo a ejecutar. Si el programa se esta reanudando, es decir,
    se esta retomando un proceso anterior terminado con error, se
    evalua si esta seccion se alcanzo a ejecutar y se parte de este
    punto.

    10-07-2013      smunoz
    Se hace uso del parametro REPORTAR_CODEUDOR_CENTRAL al momento de
    procesar codeudores, si este parametro se encuentra con valorr S se procesan
    y reportan codeudores si es necesario, sino no se reportan codeudores.

    15-06-2013      smunoz
    Creacion.
    ******************************************************************/

    -- Cursor para obtener las Cuentas vencidas
    CURSOR cuentas_venci(nuservsu servsusc.sesunuse%TYPE) IS
      SELECT nvl(SUM(caccsape), 0) valor,
             COUNT(DISTINCT(cacccuco)) total,
             MIN(caccfeve)
        FROM ic_cartcoco_T
       WHERE caccfege = v_statement_date
         AND caccfeve < v_statement_date
         AND caccnuse = nuservsu
         AND caccnaca = 'N';

    -- Cuentas pendientes
    CURSOR cuentas_pend(nuservsu servsusc.sesunuse%TYPE) IS
      SELECT nvl(SUM(caccsape), 0) valor
        FROM ic_cartcoco_T
       WHERE caccfege = v_statement_date
         AND caccfeve >= v_statement_date
         AND caccnuse = nuservsu
         AND caccnaca = 'N';

    -- Cursor para obtener datos de diferidos
    CURSOR cuotas_pagas(nuservsu servsusc.sesunuse%TYPE) IS
      SELECT SUM(difecupa) difecupa, SUM(difenucu)
        FROM (SELECT difecupa, difenucu
                FROM ldc_osf_diferido_t
               WHERE difenuse = nuservsu
                 AND difeano = nuanogen
                 AND difemes = numesgen
               GROUP BY difecupa, difenucu);

    -- Cursor para obtener las fechas de pago
--    CURSOR cufechpago(nuservsu servsusc.sesunuse%TYPE) IS
--      SELECT nvl(to_number(to_char(MAX(cucofepa), 'yyyymmdd')), 0) fepa,
--             nvl(to_number(to_char(MAX(cucofeve), 'yyyymmdd')), 0) feve
--        FROM cuencobr, factura
--       WHERE cuconuse = nuservsu
--         AND cucofact = factcodi
--         AND factfege <= v_statement_date;

    -- cursor para obtener valores de diferidos
    CURSOR cusalpe(nuservsu servsusc.sesunuse%TYPE) IS
      SELECT nvl(SUM(difesape), 0),
             nvl(SUM(difevatd), 0),
             nvl(SUM(difevacu), 0)
        FROM ldc_osf_diferido_t
       WHERE difeano = nuanogen
         AND difemes = numesgen
         AND difenuse = nuservsu
         AND difesape > 0;

    nuvalicalif ld_sample_detai.score%TYPE;

    exSiguienteRegistro EXCEPTION; -- CA 200-792

    Cantdias NUMBER := 0;
  BEGIN
    xinsertfgrcr('estoy en procprocesaser con el usuario ='||to_char(regsuscrib.sesunuse));
    -- obetener la cantidad de d?as restar: -- Caos 200-981
    BEGIN
      SELECT ld_general_parameters.numercial_value
        INTO cantdias
        FROM ld_general_parameters
       WHERE ld_general_parameters.parameter_desc = 'DIAS_RESTA_EDAD_MORA';
    EXCEPTION
      WHEN OTHERS THEN
        cantdias := 30;
    END;
    IF (isbrepomuestra = 'R' AND
       (g_table_name_error IS NULL OR g_table_name_error = 'LD_SAMPLE' OR
       (g_table_name_error = 'LD_SAMPLE_CONT' AND
       (g_operation_error = 'UPDATE_1' OR g_operation_error = 'INSERT')

       ))) OR isbrepomuestra = 'M' THEN
      nuultimopasoejecutado := 1140;

      -- Abrir cursor cuentas vencidas
      OPEN cuentas_venci(regsuscrib.sesunuse);
      FETCH cuentas_venci
        INTO nuvalmor, nucuomor, dtfemven;

      -- Si no se obtiene registros
      IF cuentas_venci%NOTFOUND THEN
        nuvalmor := 0;
        nucuomor := 0;
      END IF;

      IF (nuvalmor IS NULL) THEN
        nuvalmor := 0;
      END IF;

      -- cerrar cursor de cuentas vencidas
      CLOSE cuentas_venci;
      IF (dtfemven IS NULL) THEN
        dtfemven := v_statement_date;
      END IF;

      nudiasdemora := regsuscrib.cuensald;

      -- Se quita el numero 30 para reemplazarlo por la variable
      -- Cantidias que tienen el cuenta el valor del parametro creado -- 200-981
      IF nudiasdemora - cantdias < 0 THEN
        nudiasdemora := 0;
      ELSE
        -- Se quita el numero 30 para reemplazarlo por la variable
        -- Cantidias que tienen el cuenta el valor del parametro creado -- 200-981
        nudiasdemora := nudiasdemora - cantdias;
      END IF;

      nuyearmora := trunc(nudiasdemora / 365);

      IF (nudiasdemora > 999) THEN
        nudiasdemora := 999;
      END IF;

      nuultimopasoejecutado := 1150;
      BEGIN
        SELECT t.default_age_id
          INTO nuedamora
          FROM ld_default_age_cf t
         WHERE nudiasdemora BETWEEN t.min AND t.max;
      EXCEPTION
        WHEN OTHERS THEN
          nuedamora := -1;
      END;

      IF nuedamora = 0 THEN
        nuvalmor := 0;
        nucuomor := 0;
      END IF;

      -- Si nivalmor es nulo

      begin
           select asigned_cuote into nuavaliblequote from ldc_cuotahistoricfgrcr where susccodi=regsuscrib.sesususc;
      exception
           when others then
                nuavaliblequote := 0;
      END;

      /*
      BEGIN
        SELECT assigned_quote
          INTO nuavaliblequote
          FROM (SELECT register_date, assigned_quote
                  FROM ld_quota_historic
                 WHERE subscription_id = regsuscrib.sesususc
                   AND register_date <= v_statement_date
                 ORDER BY register_date DESC)
         WHERE rownum = 1;
      EXCEPTION
        WHEN OTHERS THEN
          nuavaliblequote := 0;
      END; */

      -- Abrir cursor cuentas Pendientes
      OPEN cuentas_pend(regsuscrib.sesunuse);
      FETCH cuentas_pend
        INTO nuvalpen;

      -- Si no se obtiene registros
      IF cuentas_pend%NOTFOUND THEN
        nuvalpen := 0;
      END IF;

      -- cerrar cursor de cuentas pendientes
      CLOSE cuentas_pend;

      -- Abrir cursor de cuentas pagadas
      nuultimopasoejecutado := 1160;
      OPEN cuotas_pagas(regsuscrib.sesunuse);
      FETCH cuotas_pagas
        INTO nucuopag, nutotalshare;

      -- Cerrar cursor de cuotas pagas
      CLOSE cuotas_pagas;


      begin
         select feulpa into nufeulpa from ldc_datossesunusefgrcr WHERE NUSE=regsuscrib.sesunuse and rownum=1;
      exception
         when others then
              nufeulpa:=0;
      end;

     SELECT nvl(to_number(to_char(MIN(caccfeve), 'yyyymmdd')), 0) feve
        INTO nufelipa
        FROM ic_cartcoco_t
       WHERE caccfege = v_statement_date
         AND caccnuse = regsuscrib.sesunuse
         AND caccnaca = 'N';

/*
      SELECT nvl(to_number(to_char(MAX(cucofepa), 'yyyymmdd')), 0) fepa
        INTO nufeulpa
        FROM cuencobr, factura
       WHERE cuconuse = regsuscrib.sesunuse
         AND cucofact = factcodi
         AND factfege <= v_statement_date
         AND cucofepa <= v_statement_date;

      SELECT nvl(to_number(to_char(MAX(cucofeve), 'yyyymmdd')), 0) feve
        INTO nufelipa
        FROM cuencobr, factura
       WHERE cuconuse = regsuscrib.sesunuse
         AND cucofact = factcodi
         AND factfege <= v_statement_date; */

      IF nufeulpa IS NULL THEN
        nufeulpa := 0;
      END IF;

      IF nufelipa IS NULL THEN
        nufelipa := 0;
      END IF;

      nuultimopasoejecutado := 1170;
      /*-- Abrir cursor Fecha de Pago
      Open cufechpago(regsuscrib.sesunuse);
      Fetch cufechpago
        Into nufeulpa, nufelipa;

      -- Si nufeulpa es nulo
      If nufeulpa Is Null Then
        nufeulpa := 0;
      End If;

      -- Si no se obtiene registros
      If cufechpago%Notfound Then
        nufeulpa := 0;
        nufelipa := 0;
      End If;

      -- cerrar cursor de fechas de pago
      Close cufechpago;*/

      nuultimopasoejecutado := 1180;
      -- Abrir cursor Saldo diferido pendiente
      OPEN cusalpe(regsuscrib.sesunuse);
      FETCH cusalpe
        INTO nusalpen, nuvalinici, numontvalue;

      -- Si no se obtiene registros
      IF cusalpe%NOTFOUND THEN
        nusalpen    := 0;
        nuvalinici  := 0;
        numontvalue := 0;
      END IF;

      -- cerrar cursor de saldo pendientes
      CLOSE cusalpe;

      IF nuvalpen + nuvalmor > 0 AND nusalpen = 0 THEN
        --nuvalpag := 0;
        BEGIN
          SELECT SUM(difecupa) difecupa,
                 SUM(difenucu) difenucu,
                 SUM(difevatd) difevatd,
                 SUM(difevacu) difevacu
            INTO nucuopag, nutotalshare, nuvalinici, numontvalue
            FROM (SELECT difecupa,
                         difenucu,
                         SUM(difevatd) difevatd,
                         SUM(difevacu) difevacu
                    FROM diferido
                   WHERE difecodi IN
                         (SELECT DISTINCT substr((cargdoso),
                                                 '4',
                                                 length(cargdoso))
                            FROM cargos
                           WHERE cargdoso LIKE 'DF-%'
                             AND cargcuco IN
                                 (SELECT MAX(cucocodi)
                                    FROM cuencobr, factura, cargos
                                   WHERE cucofact = factcodi
                                     AND cargcuco = cucocodi
                                     AND factfege <= v_statement_date
                                     AND cuconuse = regsuscrib.sesunuse
                                     AND cargdoso LIKE 'DF-%'))
                   GROUP BY difecupa, difenucu);
        EXCEPTION
          WHEN OTHERS THEN

            nucuopag     := 0;
            nutotalshare := 0;
        END;

      END IF;

      nucuopag := nucuopag - nucuomor;

      nuultimopasoejecutado := 1190;
      -- Obtiene el departamento, localidad y otras variables del paquete LD_BCEQUIVALE_REPORT
      proobtenerdatosdetail(regsuscrib_sesudepa      => regsuscrib.geo_loca_father_id,
                            regsuscrib_sesuloca      => regsuscrib.geograp_location_id,
                            regsuscrib_sesuesfn      => regsuscrib.sesuesfn,
                            regsuscrib_sesuserv      => regsuscrib.sesuserv,
                            regsuscrib_ident_type_id => regsuscrib.ident_type_id,
                            regsuscrib_sesunuse      => regsuscrib.sesunuse);

      IF inucreditbereauid = ccifin AND ident_type_cf IN (1, 3, 4, 5) THEN
        sbfullname := rpad(rpad(regsuscrib.subs_last_name, 15, ' ') ||
                           rpad(regsuscrib.subs_second_last_name, 15, ' ') ||
                           fsbname(regsuscrib.subscriber_name),
                           60,
                           ' ');

      ELSIF inucreditbereauid = cdatacredito THEN
        sbfullname := substr(regsuscrib.subscriber_name || ' ' ||
                             regsuscrib.subs_last_name || ' ' ||
                             regsuscrib.subs_second_last_name,
                             0,
                             45);
      ELSE
        sbfullname := substr(regsuscrib.subscriber_name || ' ' ||
                             regsuscrib.subs_last_name || ' ' ||
                             regsuscrib.subs_second_last_name,
                             0,
                             60);
      END IF;
      nuopdt := nvl(to_number(to_char(regsuscrib.sesufein, 'yyyymmdd')), 0);

      SELECT MAX(nvl(to_number(to_char(add_months(difefein, difenucu),
                                       'yyyymmdd')),
                     0))
        INTO nuduedate
        FROM ldc_osf_diferido_t
       WHERE difeano = nuanogen
         AND difemes = numesgen
         AND difenuse = regsuscrib.sesunuse;

      -- Inicio CA 200-792. Si no se puede obtener la fecha de vencimiento se debe almacenar como un
      -- error y continuar procesando el siguiente registro
      IF nuDueDate IS NULL AND fblaplicaentrega(csbBSS_CAR_SMS_200792) THEN

        nuultimopasoejecutado := 1191;
        /*proregistrarerror(inutype_identification   => regsuscrib.ident_type_id,
        inuidentification_number => Regsuscrib.identification,
        isbaccount_number        => regsuscrib.sesunuse);*/

        proinsertld_error_account(isbaccount_number        => regsuscrib.sesunuse,
                                  inuidentification_number => Regsuscrib.identification,
                                  inutype_identification   => regsuscrib.ident_type_id,
                                  isberror_message         => 'No fue posible obtener una fecha de vencimiento para el a?o ' ||
                                                              nuanogen || ', ' ||
                                                              numesgen ||
                                                              ', producto ' ||
                                                              regsuscrib.sesunuse);

      ELSE
        -- Fin CA 200-792

        --nuduedate := nvl(to_number(to_char(regsuscrib.sesufein, 'yyyymmdd')), 0);
        /*nustorigin := nvl(to_number(to_char(regsuscrib.sesufein, 'yyyymmdd')),
        0);*/

        -- Si no se recupera informacion en este campo, debe enviarse vacio a la
        -- base de datos. smunozSAO223793
        IF inucreditbereauid = cdatacredito THEN

          nuinitial_issue_date_cf := nvl(to_number(to_char(regsuscrib.sesufein,
                                                           'yyyymmdd')),
                                         0);

        ELSIF inucreditbereauid = ccifin THEN

          nuinitial_issue_date_cf := to_number(to_char(regsuscrib.sesufein,
                                                       'yyyymmdd'));
        END IF;

        nutermination_date_cf := nvl(to_number(to_char(regsuscrib.retire_date,
                                                       'yyyymmdd')),
                                     0);
        nudebt                := nvl(nuvalpen, 0) + nvl(nuvalmor, 0) +
                                 nvl(nusalpen, 0);

        nudeucodedt := 0;
        sbdeucodecf := 'P';

        nuultimopasoejecutado := 1200;
        -- Valida que toda la informacion obligatoria este completa
        proestacompletalainfo(regsuscrib_sesunuse       => regsuscrib.sesunuse,
                              regsuscrib_identification => regsuscrib.identification,
                              regsuscrib_ident_type_id  => regsuscrib.ident_type_id,
                              isbTipoResponsable        => 'D');

        IF accoutn_error = 0 THEN

          nuultimopasoejecutado := 1210;
          -- Inserta en la tabla de detalle

          BEGIN

            prosample_detai(isbaccount_number             => regsuscrib.sesunuse,
                            inuaccount_state_id_dc        => sbaccstatdc,
                            isbaddress_correspondence_dc  => substr(regsuscrib.address,
                                                                    0,
                                                                    60),
                            isbaddress_work_dc            => substr(sbworkadrress,
                                                                    0,
                                                                    60),
                            inucel_phone_dc               => fsbremovechars(phone1_id,
                                                                            12),
                            inucity_corresp_dane_code     => nucityrescode,
                            isbcity_correspondence_dc     => substr(sbcityresdesc,
                                                                    0,
                                                                    20),
                            inucity_radi_offi_dane_cod_dc => regsuscrib.geograp_location_id,
                            isbcity_radication_office_dc  => substr(sbnomloca,
                                                                    0,
                                                                    20),
                            inucity_resi_offi_dane_cod_dc => regsuscrib.geograp_location_id,
                            inudate_status_account        => to_number(to_char(v_statement_date,
                                                                               'yyyymmdd')),
                            isbdept_correspondence_dc     => substr(sbdepresdesc,
                                                                    0,
                                                                    20),
                            isbdepartment_work_dc         => substr(sbdeprwordesc,
                                                                    0,
                                                                    20),
                            isbemail_dc                   => substr(regsuscrib.e_mail,
                                                                    0,
                                                                    60),
                            inuidentification_number      => regsuscrib.identification,
                            inuphone_work_dc              => fsbremovechars(phone1_id,
                                                                            12),
                            isbradication_office_dc       => substr(sbradoff,
                                                                    0,
                                                                    30),
                            isbresidential_address_dc     => substr(regsuscrib.address,
                                                                    0,
                                                                    60),
                            isbresidential_city_dc        => substr(sbnomloca,
                                                                    0,
                                                                    20),
                            inuresidential_phone_dc       => fsbremovechars(regsuscrib.phone,
                                                                            12),
                            isbservice_category           => NULL,
                            isbtype_contract_id_cf        => substr(sbtypcont,
                                                                    0,
                                                                    3),
                            inuvalue_delay                => nvl(nuvalmor, 0),
                            ibscliecodeu                  => 'CLIENTE',
                            inusesususc                   => regsuscrib.sesususc,
                            regsuscrib_ident_type_id      => regsuscrib.ident_type_id);
          END;
        END IF; -- If account_error = 0 Then

        nuultimopasoejecutado := 1220;

        IF g_reportar_codeudor_central = 'S' THEN
          FOR recodeud IN cu_codeudor_ser(nupackage,
                                          regsuscrib.identification) LOOP
            BEGIN
              nuultimopasoejecutado := 1230;
              proobtienedatoscodeudor(recodeud_ident_type_id   => recodeud.ident_type_id,
                                      recodeud_subscriber_name => recodeud.debtorname,
                                      recodeud_subs_last_name  => recodeud.last_name);

              -- valor numerico date status origin
              nudtstatusorigin := nvl(to_number(to_char(regsuscrib.sesufein,
                                                        'yyyymmdd')),
                                      0);

              --Opening date
              nuopdt := nvl(to_number(to_char(regsuscrib.sesufein,
                                              'yyyymmdd')),
                            0);

              nuultimopasoejecutado := 1240;

              -- Valida que toda la informacion requerida este completa
              proestacompletalainfo(regsuscrib_sesunuse       => regsuscrib.sesunuse,
                                    regsuscrib_identification => recodeud.identification,
                                    regsuscrib_ident_type_id  => recodeud.ident_type_id,
                                    isbTipoResponsable        => 'C'); -- CA 200-792

              BEGIN
                SELECT sample_id
                  INTO nucodereport
                  FROM ld_sample_detai lsd
                 WHERE lsd.sample_id IN
                       (SELECT MAX(ls.sample_id)
                          FROM ld_sample         ls,
                               ld_sector_product lsp,
                               ld_type_sector    lts
                         WHERE lsp.sector_id = lts.type_id
                           AND decode(ls.type_sector,
                                      -1,
                                      lsp.sector_id,
                                      ls.type_sector) = lsp.sector_id
                           AND ls.flag = 'S'
                         GROUP BY ls.type_sector, ls.credit_bureau_id)
                   AND lsd.identification_number = recodeud.identification;
              EXCEPTION
                WHEN OTHERS THEN
                  nucodereport := 0;
              END;

              nuvalicalif := fnc_validacalifcodeudor(recodeud.ident_type_id, -- Tipo de identificacion
                                                     recodeud.identification,
                                                     sbestatus, -- Estado (N: nuevo, V: viejo)
                                                     regsuscrib.sesuesfn, -- Esatdo financiero
                                                     nucodereport, -- identificador del reporte anterior
                                                     regsuscrib.sesunuse);

              IF nuvalicalif = 2 THEN
                accoutn_error := 1;
              ELSIF nuvalicalif = 3 THEN
                pro_atrasa_cartera(inusampleid, NULL, regsuscrib.sesunuse);
                accoutn_error := 1;
              END IF;

              nuultimopasoejecutado := 1250;
              IF accoutn_error = 0 THEN
                -- Inserta el detalle
                -- Inserta en la tabla de detalle
                nuultimopasoejecutado := 1260;
                prosample_detai(isbaccount_number            => regsuscrib.sesunuse,
                                inuaccount_state_id_dc       => sbaccstatdc,
                                isbaddress_correspondence_dc => substr(recodeud.address_id,
                                                                       0,
                                                                       60),
                                isbaddress_work_dc           => substr(recodeud.companyaddress_id,
                                                                       0,
                                                                       60),

                                inucel_phone_dc => fsbremovechars(recodeud.phone1_id,
                                                                  12),

                                inucity_corresp_dane_code     => recodeud.city,
                                isbcity_correspondence_dc     => substr(recodeud.city_desc,
                                                                        0,
                                                                        20),
                                inucity_radi_offi_dane_cod_dc => regsuscrib.geograp_location_id,
                                isbcity_radication_office_dc  => substr(sbnomloca,
                                                                        0,
                                                                        20),
                                inucity_resi_offi_dane_cod_dc => regsuscrib.geograp_location_id,
                                inudate_status_account        => to_number(to_char(v_statement_date,
                                                                                   'yyyymmdd')),
                                isbdept_correspondence_dc     => substr(recodeud.department_desc,
                                                                        0,
                                                                        20),
                                isbdepartment_work_dc         => substr(recodeud.departmentwork_desc,
                                                                        0,
                                                                        20),
                                isbemail_dc                   => substr(recodeud.email,
                                                                        0,
                                                                        60),
                                inuidentification_number      => recodeud.identification,
                                inuphone_work_dc              => fsbremovechars(recodeud.phone1_id,
                                                                                12),
                                isbradication_office_dc       => substr(sbradoff,
                                                                        0,
                                                                        30),
                                isbresidential_address_dc     => substr(recodeud.address_id,
                                                                        0,
                                                                        60),

                                isbresidential_city_dc   => substr(recodeud.city_desc,
                                                                   0,
                                                                   20),
                                inuresidential_phone_dc  => fsbremovechars(recodeud.phone1_id,
                                                                           12),
                                isbservice_category      => NULL,
                                isbtype_contract_id_cf   => substr(sbtypcont,
                                                                   0,
                                                                   3),
                                inuvalue_delay           => nvl(nuvalmor, 0),
                                ibscliecodeu             => 'CODEUDOR',
                                inusesususc              => regsuscrib.sesususc,
                                regsuscrib_ident_type_id => regsuscrib.ident_type_id);
              END IF; -- If account_error = 0 Then
            EXCEPTION
              WHEN OTHERS THEN
                proregistrarerror(inutype_identification   => regsuscrib.ident_type_id,
                                  inuidentification_number => recodeud.identification,
                                  isbaccount_number        => regsuscrib.sesunuse);
            END;
            proactualizaavance(regsuscrib.sesunuse || '(codeudor)');
          END LOOP; -- For recodeud In cu_codeudor(regsuscrib.sesunuse) Loop
        END IF; -- If g_reportar_codeudor_central = 'S' Then
      END IF; -- CA 200-792
      xinsertfgrcr('estoy en procprocesaser con el usuario ='||to_char(regsuscrib.sesunuse)||' va a actualizar avance');
      proactualizaavance(regsuscrib.sesunuse);
    END IF; -- If (isbrepomuestra = 'R' And g_table_name_error Is Null Or g_table_name_error = 'LD_SAMPLE' Or

  END;

  PROCEDURE proelimregistrosadicmuestra(inurandom_sample_id ld_random_sample.random_sample_id%TYPE,
                                        nutotalreg          ld_random_sample.subscriber_number%TYPE) IS
    /*****************************************************************************************
      Proposito: Luego de procesada la informacion de la muestra se elimina de la tabla los
      elementos sobrantes.

      Historia de Modificaciones
      Fecha           IDEntrega

      27-01-2014      slemusSAO226314
      Se modifica el procedimiento proelimregistrosadicmuestra debido a que por la instruccion dbms_random.value
      a veces tomaba, valores superiores a los solicitados en el cursor.


      17-12-2013      smunozSAO227685
      Creacion del procedimiento
    *****************************************************************************************/

    -- Variables numericas
    nuclientesmuestra   NUMBER; -- Total de clientes insertados en la tabla ld_random_sample
    nuclientesaeliminar NUMBER; -- Numero de clientes que se deben eliminar de la muestra
    nunroregistros      ld_random_sample_fin.number_of_record%TYPE; -- Numero de registros insertados en ld_random_sample_detai
    nunovedades         ld_random_sample_fin.sum_of_new%TYPE; -- Total novedades insertadas en ld_random_sample_detai

  BEGIN
    -- Buscar el numero de clientes que se incluyeron en la muestra
    BEGIN
      SELECT COUNT(1)
        INTO nuclientesmuestra
        FROM ld_random_sample_detai lrsd1
       WHERE lrsd1.random_sample_id = inurandom_sample_id
         AND lrsd1.responsible_dc = 0;
    EXCEPTION
      WHEN OTHERS THEN
        nuclientesmuestra := 0;
    END;

    -- Calcular el numero de clientes que sobran, esto frente a los solicitados por el usuario
    nuclientesaeliminar := nuclientesmuestra - nutotalreg;

    IF nuclientesaeliminar >= 1 THEN

      -- Borrar los registros restantes
      BEGIN
        DELETE ld_random_sample_detai lrsd
         WHERE lrsd.random_sample_id = inurandom_sample_id
           AND lrsd.account_number IN
               (SELECT lrsd1.account_number
                  FROM (SELECT lrsd2.account_number
                          FROM ld_random_sample_detai lrsd2
                         WHERE lrsd2.random_sample_id = inurandom_sample_id
                           AND lrsd2.responsible_dc = 0) lrsd1
                 WHERE rownum <= nuclientesaeliminar);

        -- Obtener el numero de registros insertados en la tabla ld_random_sample_detai
        SELECT COUNT(1), SUM(lrsd.new_portfolio_id_dc)
          INTO nunroregistros, nunovedades
          FROM ld_random_sample_detai lrsd
         WHERE lrsd.random_sample_id = inurandom_sample_id;

        -- Actualizar Ld_random_sample_fin
        UPDATE ld_random_sample_fin
           SET number_of_record        = nunroregistros + 2,
               sum_of_new              = nunovedades,
               total_number_of_records = nunroregistros + 2,
               number_of_records2      = nunroregistros
         WHERE random_sample_id = inurandom_sample_id;

      EXCEPTION
        WHEN OTHERS THEN
          pkerrors.pop;
          pkerrors.geterrorvar(onuerrorcode, osberrormessage);
          raise_application_error(pkconstante.nuerror_level2, gsberrmsg);

      END;

    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      pkerrors.pop;
      pkerrors.geterrorvar(onuerrorcode, osberrormessage);
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);

  END proelimregistrosadicmuestra;

  PROCEDURE pbogenerationdif(p_nucreditbereauid    ld_sample.credit_bureau_id%TYPE,
                             p_inutypesector       ld_sample.type_sector%TYPE,
                             p_inutypeproductid    ld_sample.type_product_id%TYPE,
                             p_innusampleid        ld_sample.sample_id%TYPE,
                             p_sbsubscriber_number ld_random_sample.subscriber_number%TYPE,
                             p_insbtypegen         VARCHAR2,
                             p_ionutotalrec        IN OUT ld_sample_fin.number_of_record%TYPE,
                             p_ionutotalerr        IN OUT NUMBER,
                             p_ionutotalnov        IN OUT ld_sample_fin.sum_of_new%TYPE,
                             p_idtfechgen          DATE,
                             p_onuerrorcode        OUT NUMBER,
                             p_osberrormessage     OUT VARCHAR2,
                             p_isbrepomuestra      VARCHAR2,
                             p_table_name_trace    OUT user_tables.table_name%TYPE,
                             p_operation_trace     OUT ld_trace_gen_report.operation%TYPE,
                             p_table_name_error    IN ld_trace_gen_report.table_name%TYPE,
                             p_operation_error     IN ld_trace_gen_report.operation%TYPE,
                             p_rec_procesados      IN OUT ld_trace_gen_report.operation%TYPE,
                             p_rec_a_procesar      IN NUMBER,
                             p_program_id          IN estaprog.esprprog%TYPE,
                             p_nucambiosector      IN VARCHAR2,
                             p_nucambioproducto    IN VARCHAR2) IS

    /*****************************************************************************************
    Proposito: Procesa la informacion de los diferidos

    Historia de Modificaciones

    Fecha           IDEntrega

    24-09-2013      slemusSAO217833
    Se crea cursor para tener en cuenta los criterios por categoria

    30-07-2013      smunozSAO212456
    Se ajusta el procedimiento para que retorne correctamente las variables
    de error y sea registrar el resultado del proceso en ge_error_log.

    24-07-2013      smunozSAO212457
    Registra el avance del proceso

    22-07-2013      smunozSAO212459
    Se agregan las variables que permiten identificar la tabla y la
    operacion que se esta realizando para que si el programa llega
    a entrar en una excepcion sea posible saber hasta que punto se
    alcanzo a ejecutar. Si el programa se esta reanudando, es decir,
    se esta retomando un proceso anterior terminado con error, se
    evalua si esta seccion se alcanzo a ejecutar y se parte de este
    punto.

    15-06-2013      smunoz
    Unificacion de la generacion de la muestra y el reporte en un mismo procedimiento, el cual
    contendra un parametro adicional que va a permitir identificar si el procedimiento se esta
    generando para muestra o para reporte completo
    *****************************************************************************************/

    -- Excepciones
    exparametrosincompletos EXCEPTION;

    regsuscrib reg_suscrib_dif;

  BEGIN

    nuultimopasoejecutado := 1270;

    g_table_name_trace := 'LD_SAMPLE';
    g_operation_trace  := 'INSERT';

    -- Se leen los parametros de entrada en variables para poder acceder a ellas en cualquier
    -- parte del paquete
    inucreditbereauid   := p_nucreditbereauid;
    inutypesector       := p_inutypesector;
    inutypeproductid    := p_inutypeproductid;
    inusampleid         := p_innusampleid;
    sbsubscriber_number := p_sbsubscriber_number;
    insbtypegen         := p_insbtypegen;
    ionutotalrec        := p_ionutotalrec;
    nuerrorcount        := p_ionutotalerr;
    ionutotalnov        := p_ionutotalnov;
    idtfechgen          := p_idtfechgen;
    onuerrorcode        := p_onuerrorcode;
    osberrormessage     := p_osberrormessage;
    isbrepomuestra      := p_isbrepomuestra;
    g_table_name_error  := p_table_name_error;
    g_operation_error   := p_operation_error;
    g_table_name_trace  := p_table_name_trace;
    g_operation_trace   := p_operation_trace;
    g_rec_procesados    := p_rec_procesados;
    g_rec_a_procesar    := p_rec_a_procesar;
    g_program_id        := p_program_id;
    g_nucambiosector    := p_nucambiosector;
    g_nucambioproducto  := p_nucambioproducto;

    -- Se indica que se van a procesar diferidos
    v_sbdifoser := 'D';

    nuultimopasoejecutado := 1280;

    pkerrors.push('ld_bcgenerationrandomsample.pbogenerationreportdif');
    onuerrorcode    := pkconstante.exito;
    osberrormessage := pkconstante.nullsb;

    -- Se debe obtener la informacion por sector. smunozSAO213862
    /*boencontrado := ld_bcselectioncriteria.fbogetselectioncriteriaid(inutypesector,
    inucreditbereauid,
    nuamount,
    nusubscribernumber,
    nuoverduebills,
    nucategory);*/
    --    If (boencontrado = True) Then
    nuultimopasoejecutado := 1300;
    proobtieneparamgenerales;

    -- Insertar en el encabezado en lm_sample o lm_random_sample
    nuultimopasoejecutado := 1310;
    prosample;

    -- Insertar en la tabla de control central LD_SAMPLE_CONT o LD_RANDOM_SAMPLE
    nuultimopasoejecutado := 1320;
    prosample_cont;

    nuultimopasoejecutado := 1330;

    --provalidaparametrosobl;

    nuultimopasoejecutado := 1350;
    IF isbrepomuestra = 'R' THEN

      FOR regselcrit IN cuselcrit(inutypesector, inucreditbereauid) LOOP

        nuamount := regselcrit.minimum_amount;
        -- No es necesario obtener el numero de suscriptores parametrizados para la
        -- central y sector, se debe tomar de la pantalla. SAO226523
        --nusubscribernumber := regselcrit.subscriber_number;
        nuoverduebills := regselcrit.overdue_bills;
        nucategory     := regselcrit.category;

        FOR regsuscrib1 IN cu_diferido(p_amount => nuamount,
                                       --
                                       p_subscriber_number => sbsubscriber_number,
                                       p_duebil            => nuoverduebills,
                                       p_category          => nucategory,
                                       p_typeproductid     => inutypeproductid,
                                       p_repomuestra       => isbrepomuestra,
                                       p_credit_bureau_id  => inucreditbereauid) LOOP
          BEGIN
            /*  \*obtdatosdeudorprom(regsuscrib1.sesunuse, \*subscriber_id,*\
                               ident_type_id,
                               identification,
                               name_complete,
                               last_name,
                               address,
                               geograp_location_id,
                               geo_loca_father_id,
                               phone1_id,
                               email,
                               movilphone_id);*\

            If identification Is Null Then
             Null;
              \*obtdatosdeudorsubs(regsuscrib1.sesunuse, \*subscriber_id,*\
                                 ident_type_id,
                                 identification,
                                 name_complete,
                                 name_complete,
                                 address,
                                 geograp_location_id,
                                 geo_loca_father_id,
                                 phone1_id,
                                 email,
                                 movilphone_id);*\
            End If;*/

            nuultimopasoejecutado := 1340;
            sbestatus             := 'V';
            /*--regsuscrib.subscriber_id       := subscriber_id;
            regsuscrib.ident_type_id       := ident_type_id;
            regsuscrib.identification      := identification;
            regsuscrib.difecodi            := regsuscrib1.difecodi;
            regsuscrib.subscriber_name     := name_complete;
            regsuscrib.subs_last_name      := last_name;
            regsuscrib.difefein            := regsuscrib1.difefein;
            regsuscrib.sesucate            := regsuscrib1.sesucate;
            regsuscrib.difevatd            := regsuscrib1.difevatd;
            regsuscrib.difesape            := regsuscrib1.difesape;
            regsuscrib.difenucu            := regsuscrib1.difenucu;
            regsuscrib.difevacu            := regsuscrib1.difevacu;
            regsuscrib.address             := address;
            regsuscrib.phone               := phone1_id;
            regsuscrib.e_mail              := email;
            regsuscrib.sesunuse            := regsuscrib1.sesunuse;
            regsuscrib.sesususc            := regsuscrib1.sesususc;
            regsuscrib.sesuesfn            := regsuscrib1.sesuesfn;
            regsuscrib.sesusuca            := regsuscrib1.sesusuca;
            regsuscrib.geo_loca_father_id  := geo_loca_father_id;
            regsuscrib.geograp_location_id := geograp_location_id;
            regsuscrib.cuensald            := regsuscrib1.cuensald;
            regsuscrib.sesuserv            := regsuscrib1.sesuserv;
            nuultimopasoejecutado          := 1380;*/

            proprocesadif(regsuscrib);
          EXCEPTION
            WHEN OTHERS THEN
              proregistrarerror(inutype_identification   => ident_type_id,
                                inuidentification_number => identification,
                                isbaccount_number        => regsuscrib1.difecodi);
          END;
        END LOOP; -- For regsuscrib In cu_diferido(nuamount => nuamount,

        FOR regsuscrib1 IN cu_diferido_not_exists(p_amount           => nuamount,
                                                  p_duebil           => nuoverduebills,
                                                  p_category         => nucategory,
                                                  p_typeproductid    => inutypeproductid,
                                                  p_credit_bureau_id => inucreditbereauid) LOOP
          BEGIN
            /*obtdatosdeudorprom(regsuscrib1.sesunuse, \*subscriber_id,*\
            ident_type_id,
            identification,
            name_complete,
            last_name,
            address,
            geograp_location_id,
            geo_loca_father_id,
            phone1_id,
            email,
            movilphone_id);*/

            /*If identification Is Null Then
              obtdatosdeudorsubs(regsuscrib1.sesunuse, \*subscriber_id,*\
                                 ident_type_id,
                                 identification,
                                 name_complete,
                                 last_name,
                                 address,
                                 geograp_location_id,
                                 geo_loca_father_id,
                                 phone1_id,
                                 email,
                                 movilphone_id);
            End If;*/

            nuultimopasoejecutado := 1360;
            sbestatus             := 'N';
            --regsuscrib.subscriber_id       := subscriber_id;
            /*regsuscrib.ident_type_id       := ident_type_id;
            regsuscrib.identification      := identification;
            regsuscrib.difecodi            := regsuscrib1.difecodi;
            regsuscrib.subscriber_name     := name_complete;
            regsuscrib.subs_last_name      := last_name;
            regsuscrib.difefein            := regsuscrib1.difefein;
            regsuscrib.sesucate            := regsuscrib1.sesucate;
            regsuscrib.difevatd            := regsuscrib1.difevatd;
            regsuscrib.difesape            := regsuscrib1.difesape;
            regsuscrib.difenucu            := regsuscrib1.difenucu;
            regsuscrib.difevacu            := regsuscrib1.difevacu;
            regsuscrib.address             := address;
            regsuscrib.phone               := phone1_id;
            regsuscrib.e_mail              := email;
            regsuscrib.sesunuse            := regsuscrib1.sesunuse;
            regsuscrib.sesususc            := regsuscrib1.sesususc;
            regsuscrib.sesuesfn            := regsuscrib1.sesuesfn;
            regsuscrib.sesusuca            := regsuscrib1.sesusuca;
            regsuscrib.geo_loca_father_id  := geo_loca_father_id;
            regsuscrib.geograp_location_id := geograp_location_id;
            regsuscrib.cuensald            := regsuscrib1.cuensald;
            regsuscrib.sesuserv            := regsuscrib1.sesuserv;*/
            nuultimopasoejecutado := 1370;

            proprocesadif(regsuscrib);
          EXCEPTION
            WHEN OTHERS THEN
              proregistrarerror(inutype_identification   => ident_type_id,
                                inuidentification_number => identification,
                                isbaccount_number        => regsuscrib1.difecodi);
          END;

        END LOOP; --       For regsuscrib1 In cu_diferido_not_exists(nuamount,

      END LOOP; --criterios
    ELSIF isbrepomuestra = 'M' THEN

      FOR regselcrit IN cuselcrit(inutypesector, inucreditbereauid) LOOP

        nuamount := regselcrit.minimum_amount;
        -- No es necesario obtener el numero de suscriptores parametrizados para la
        -- central y sector, se debe tomar de la pantalla. SAO226523
        --nusubscribernumber := regselcrit.subscriber_number;
        nuoverduebills := regselcrit.overdue_bills;
        nucategory     := regselcrit.category;

        FOR regsuscrib1 IN cu_diferido(p_amount => nuamount,
                                       -- Se realiza el proceso usando el numero de
                                       -- suscriptores tomados de la pantalla. SAO226523
                                       p_subscriber_number => sbsubscriber_number,
                                       p_duebil            => nuoverduebills,
                                       p_category          => nucategory,
                                       p_typeproductid     => inutypeproductid,
                                       p_repomuestra       => isbrepomuestra,
                                       p_credit_bureau_id  => inucreditbereauid) LOOP
          BEGIN
            sbfullname := NULL;

            /*obtdatosdeudorprom(regsuscrib1.sesunuse,
            ident_type_id,
            identification,
            name_complete,
            last_name,
            address,
            geograp_location_id,
            geo_loca_father_id,
            phone1_id,
            email,
            movilphone_id);*/
            /*If identification Is Null Then
              obtdatosdeudorsubs(regsuscrib1.sesunuse,
                                 ident_type_id,
                                 identification,
                                 name_complete,
                                 last_name,
                                 address,
                                 geograp_location_id,
                                 geo_loca_father_id,
                                 phone1_id,
                                 email,
                                 movilphone_id);
            End If;*/

            nuultimopasoejecutado := 1340;
            sbestatus             := 'V';
            --regsuscrib.subscriber_id       := subscriber_id;
            regsuscrib.ident_type_id  := ident_type_id;
            regsuscrib.identification := identification;
            regsuscrib.difecodi       := regsuscrib1.difecodi;
            /*regsuscrib.subscriber_name     := name_complete;
            regsuscrib.subs_last_name      := last_name;
            regsuscrib.difefein            := regsuscrib1.difefein;
            regsuscrib.sesucate            := regsuscrib1.sesucate;
            regsuscrib.difevatd            := regsuscrib1.difevatd;
            regsuscrib.difesape            := regsuscrib1.difesape;
            regsuscrib.difenucu            := regsuscrib1.difenucu;
            regsuscrib.difevacu            := regsuscrib1.difevacu;
            regsuscrib.address             := address;
            regsuscrib.phone               := phone1_id;
            regsuscrib.e_mail              := email;
            regsuscrib.sesunuse            := regsuscrib1.sesunuse;
            regsuscrib.sesususc            := regsuscrib1.sesususc;
            regsuscrib.sesuesfn            := regsuscrib1.sesuesfn;
            regsuscrib.sesusuca            := regsuscrib1.sesusuca;
            regsuscrib.geo_loca_father_id  := geo_loca_father_id;
            regsuscrib.geograp_location_id := geograp_location_id;
            regsuscrib.cuensald            := regsuscrib1.cuensald;
            regsuscrib.sesuserv            := regsuscrib1.sesuserv;*/
            nuultimopasoejecutado := 1380;

            proprocesadif(regsuscrib);
          EXCEPTION
            WHEN OTHERS THEN
              dbms_output.put_line('6');
              proregistrarerror(inutype_identification   => ident_type_id,
                                inuidentification_number => identification,
                                isbaccount_number        => regsuscrib1.difecodi);
          END;
        END LOOP; -- For regsuscrib In cu_diferido(nuamount => nuamount,
      END LOOP; --loop criterios

    END IF;
    -- Grabar el resumen del proceso

    nuultimopasoejecutado := 1390;
    prosample_fin;

    -- Grabar la fecha de finalizacion del reporte en la tabla de control
    proupdatesample_cont;

    /* Else
    \*      pkerrors.notifyerror(pkerrors.fsblastobject,
                               nuultimopasoejecutado ||
                               ' - No se encontraron criterios para ejecutar el proceso',
                               gsberrmsg);
    *\
    osberrormessage := 'No se encontraron criterios para ejecutar el proceso';
    pkerrors.pop;
    pkerrors.geterrorvar(onuerrorcode, osberrormessage);

    raise_application_error(pkconstante.nuerror_level2, gsberrmsg);*/
    --End If; -- If (boencontrado = True) Then

    nuultimopasoejecutado := 1400;
    p_ionutotalrec        := ionutotalrec;
    p_ionutotalerr        := nuerrorcount;
    p_ionutotalnov        := ionutotalnov;
    p_onuerrorcode        := onuerrorcode;
    p_osberrormessage     := osberrormessage;
    p_operation_trace     := g_operation_trace;
    p_table_name_trace    := g_table_name_trace;
    p_rec_procesados      := g_rec_procesados;
    nuultimopasoejecutado := 1440;

  EXCEPTION
    WHEN exparametrosincompletos THEN
      dbms_output.put_line('7');
      p_ionutotalrec     := ionutotalrec;
      p_ionutotalerr     := nuerrorcount;
      p_ionutotalnov     := ionutotalnov;
      p_onuerrorcode     := onuerrorcode;
      p_operation_trace  := g_operation_trace;
      p_table_name_trace := g_table_name_trace;
      p_rec_procesados   := g_rec_procesados;
      pkerrors.pop;
      onuerrorcode      := nuultimopasoejecutado;
      osberrormessage   := 'Error en ld_bcgenerationrandomsample.pbogenerationdif paso ' ||
                           nuultimopasoejecutado || ' - ' || SQLERRM;
      p_osberrormessage := substr(osberrormessage, 1, 950);
    WHEN OTHERS THEN

      p_ionutotalrec     := ionutotalrec;
      p_ionutotalerr     := nuerrorcount;
      p_ionutotalnov     := ionutotalnov;
      p_onuerrorcode     := onuerrorcode;
      p_operation_trace  := g_operation_trace;
      p_table_name_trace := g_table_name_trace;
      p_rec_procesados   := g_rec_procesados;
      onuerrorcode       := nuultimopasoejecutado;
      osberrormessage    := 'Error en ld_bcgenerationrandomsample.pbogenerationdif paso ' ||
                            nuultimopasoejecutado || ' - ' || SQLERRM;
      p_osberrormessage  := substr(osberrormessage, 1, 950);
      pkerrors.pop;

  END pbogenerationdif;

  PROCEDURE pbogenerationser(p_inucreditbereauid    ld_random_sample.credit_bureau_id%TYPE,
                             p_inutypesector        ld_random_sample.type_sector%TYPE,
                             p_inutypeproductid     ld_random_sample.type_product_id%TYPE,
                             p_isbsubscriber_number ld_random_sample.subscriber_number%TYPE DEFAULT NULL,
                             p_innusampleid         ld_sample.sample_id%TYPE DEFAULT NULL,
                             p_insbtypegen          VARCHAR2 DEFAULT NULL,
                             p_ionutotalrec         IN OUT ld_sample_fin.number_of_record%TYPE,
                             p_ionutotalerr         IN OUT NUMBER,
                             p_ionutotalnov         IN OUT ld_sample_fin.sum_of_new%TYPE,
                             p_idtfechgen           DATE DEFAULT NULL,
                             p_isbrepomuestra       VARCHAR2,
                             p_onuerrorcode         OUT NUMBER,
                             p_osberrormessage      OUT VARCHAR2,
                             p_table_name_trace     OUT user_tables.table_name%TYPE,
                             p_operation_trace      OUT ld_trace_gen_report.operation%TYPE,
                             p_table_name_error     IN ld_trace_gen_report.table_name%TYPE,
                             p_operation_error      IN ld_trace_gen_report.operation%TYPE,
                             p_rec_procesados       IN OUT ld_trace_gen_report.operation%TYPE,
                             p_rec_a_procesar       IN NUMBER,
                             p_program_id           IN estaprog.esprprog%TYPE,
                             p_nucambiosector       IN VARCHAR2,
                             p_nucambioproducto     IN VARCHAR2) IS
    /******************************************************************
    Proposito: Procesa la informacion de los servicios

    Historia de Modificaciones

    Fecha           IDEntrega


    14-10-2016      Sandra Mu?oz - CA 200-792.
    S?lo se reportan productos sin saldo en reclamo si la entrega est? aplicada

    30-07-2013      smunozSAO212456
    Se ajusta el procedimiento para que retorne correctamente las variables
    de error y sea registrar el resultado del proceso en ge_error_log.

    24-07-2013      smunozSAO212457
    Registra el avance del proceso

    22-07-2013      smunozSAO212459
    Se agregan las variables que permiten identificar la tabla y la
    operacion que se esta realizando para que si el programa llega
    a entrar en una excepcion sea posible saber hasta que punto se
    alcanzo a ejecutar. Si el programa se esta reanudando, es decir,
    se esta retomando un proceso anterior terminado con error, se
    evalua si esta seccion se alcanzo a ejecutar y se parte de este
    punto.


    15-06-2013      smunoz
    Unificacion de la generacion de la muestra y el reporte en un mismo
    procedimiento, el cual contendra un parametro adicional que va a
    permitir identificar si el procedimiento se esta
    generando para muestra o para reporte completo


    ******************************************************************/
    NumeroServ NUMBER;

  BEGIN
    xinsertfgrcr('ENTRE A ld_bcgenerationrandomsample.pbogenerationser CON TYPEPRODUCT='||TO_CHAR(p_inutypeproductid)||' y tipomuestra='||isbrepomuestra);
    nuultimopasoejecutado := 1410;

    g_table_name_trace := 'LD_SAMPLE';
    g_operation_trace  := 'INSERT';

    -- Se leen los parametros de entrada en variables para poder acceder a ellas en cualquier
    -- parte del paquete
    inucreditbereauid   := p_inucreditbereauid;
    inutypesector       := p_inutypesector;
    inutypeproductid    := p_inutypeproductid;
    inusampleid         := p_innusampleid;
    sbsubscriber_number := p_isbsubscriber_number;
    insbtypegen         := p_insbtypegen;
    ionutotalrec        := p_ionutotalrec;
    nuerrorcount        := p_ionutotalerr;
    ionutotalnov        := p_ionutotalnov;
    idtfechgen          := p_idtfechgen;
    onuerrorcode        := p_onuerrorcode;
    osberrormessage     := p_osberrormessage;
    isbrepomuestra      := p_isbrepomuestra;
    g_table_name_error  := p_table_name_error;
    g_operation_error   := p_operation_error;
    g_table_name_trace  := p_table_name_trace;
    g_operation_trace   := p_operation_trace;

    g_rec_procesados    := p_rec_procesados;
    xinsertfgrcr('ENTRE A ld_bcgenerationrandomsample.pbogenerationser el g_rec_procesados='||to_char(g_rec_procesados));
    g_rec_a_procesar    := p_rec_a_procesar;
    g_program_id        := p_program_id;
    g_nucambiosector    := p_nucambiosector;
    g_nucambioproducto  := p_nucambioproducto;

    nuultimopasoejecutado := 1420;
    -- Se indica que se van a procesar diferidos
    v_sbdifoser := 'P';

    ---------------------------------------------------------------------------------------------------
    -- Obtener valores para las variables que se usaran en el proceso
    ---------------------------------------------------------------------------------------------------
    pkerrors.push('ld_bcgenerationrandomsample.pbogenerationreportser');
    onuerrorcode    := pkconstante.exito;
    osberrormessage := pkconstante.nullsb;

    nuultimopasoejecutado := 1430;
    -- Se debe obtener la informacion por sector. smunozSAO213862
    /* boencontrado := ld_bcselectioncriteria.fbogetselectioncriteriaid(inutypesector,
    inucreditbereauid,
    nuamount,
    nusubscribernumber,
    nuoverduebills,
    nucategory);*/
    -- Si se obtuvieron criterios se continua con el proceso
    -- If (boencontrado = True) Then

    -- Verificar que se hayan ingresado todos los parametros al procedimiento
    -- provalidaparametrosobl;

    -- Obtener valor de la tabla LD_GENERAL_PARAMEtERS mediante metodo ProvaPaTaPa
    nuultimopasoejecutado := 1440;
    proobtieneparamgenerales;

    -- Insertar en el encabezado en lm_sample o lm_random_sample
    nuultimopasoejecutado := 1450;
    prosample;

    -- Insertar en la tabla de control central LD_SAMPLE_CONT o LD_RANDOM_SAMPLE
    nuultimopasoejecutado := 1460;
    prosample_cont;

    -- Se abre el cursor que permite listar los clientes reportados
    nuultimopasoejecutado := 1470;

    IF isbrepomuestra = 'R' THEN

      nuultimopasoejecutado := 1490;
      xinsertfgrcr('voy a recorrer cu_servicios');
      FOR regsuscrib IN cu_servicios(p_credit_bureau_id => inucreditbereauid,
                                     p_typesector       => inutypesector,
                                     p_typeproductid    => inutypeproductid,
                                     p_category         => nucategory,
                                     p_overduebills     => nuoverduebills,
                                     p_repomuestra      => isbrepomuestra,
                                     -- Se ejecuta el cursor con el numero de suscriptores
                                     -- selecionados en pantalla. SAO226523
                                     p_subscriber_number => sbsubscriber_number,
                                     p_nuano             => nuanogen,
                                     p_numes             => numesgen) LOOP
        BEGIN
          -- CA 200-792.  S?lo se obtiene la informaci?n del deudor para el servicio 7055
          -- y 7056 si la entrega no est? aplicada o si el producto tiene saldo en reclamo
          xinsertfgrcr('estoy en el usuario ='||to_char(regsuscrib.sesunuse));
          IF inutypeproductid IN (7055, 7056) THEN
            IF ((regsuscrib.valor_reclamo = 0 AND
               fblaplicaentrega(csbBSS_CAR_SMS_200792)) OR
               NOT fblaplicaentrega(csbBSS_CAR_SMS_200792)) THEN
              -- CA 200-792
              obtdatosdeudorprom(regsuscrib.sesunuse, /*subscriber_id,*/ -- Se cambia Id enviado
                                 nupackage,
                                 ident_type_id,
                                 identification,
                                 name_complete,
                                 last_name,
                                 sbcityresdesc,
                                 nucityrescode,
                                 sbdepresdesc,
                                 address,
                                 property_phone,
                                 sbcitywordesc,
                                 nucityworcode,
                                 sbdeprwordesc,
                                 sbworkadrress,
                                 phone1_id,
                                 email);
            END IF;
          ELSE

            obtdatosdeudorsubs(regsuscrib.sesunuse, -- Se cambia Id enviado
                               ident_type_id,
                               identification,
                               name_complete,
                               sbcityresdesc,
                               nucityrescode,
                               sbdepresdesc,
                               address,
                               property_phone,
                               sbcitywordesc,
                               nucityworcode,
                               sbdeprwordesc,
                               sbworkadrress,
                               phone1_id,
                               email);
          END IF;
        END;
        nuultimopasoejecutado := 1480;
        sbestatus             := 'V';

        -- INICIO CA200-792.
        -- No se reportan productos con valor en reclamo. Si la entrega no est? aplicada
        -- no se tiene en cuenta esta condici?n
        IF ((regsuscrib.valor_reclamo = 0 AND
           fblaplicaentrega(csbBSS_CAR_SMS_200792)) OR
           NOT fblaplicaentrega(csbBSS_CAR_SMS_200792)) THEN
          -- CA 200-792
          BEGIN
            regsuscrib.ident_type_id   := ident_type_id;
            regsuscrib.subscriber_name := name_complete;
            regsuscrib.subs_last_name  := last_name;
            regsuscrib.address         := address;
            regsuscrib.phone           := property_phone;
            regsuscrib.identification  := identification;
            xinsertfgrcr('estoy en el usuario ='||to_char(regsuscrib.sesunuse)||' va para proprocesaser');
            proprocesaser(regsuscrib);
            xinsertfgrcr('estoy en el usuario ='||to_char(regsuscrib.sesunuse)||' vine de proprocesaser');
          EXCEPTION
            WHEN OTHERS THEN
              proregistrarerror(inutype_identification   => regsuscrib.ident_type_id,
                                inuidentification_number => regsuscrib.identification,
                                isbaccount_number        => regsuscrib.sesunuse);
          END;
        END IF;
        -- FIN CA 200-792

      END LOOP;

      /* For regselcrit In cuselcrit(inutypesector, inucreditbereauid) Loop

        nuamount := regselcrit.minimum_amount;
        -- No es necesario obtener el numero de suscriptores a tener en cuenta en
        -- el proceso ya que debe obtenerse del parametro de entrada
        -- nusubscribernumber := regselcrit.subscriber_number;
        nuoverduebills := regselcrit.overdue_bills;
        nucategory     := regselcrit.category;

        For regsuscrib In cu_servicios_not_exists(p_credit_bureau_id => inucreditbereauid,
                                                  p_typeproductid    => inutypeproductid,
                                                  p_category         => nucategory,
                                                  p_overduebills     => nuoverduebills,
                                                  p_nuano            => nuanogen,
                                                  p_numes            => numesgen) Loop

          If inutypeproductid In (7055, 7056) Then
            obtdatosdeudorprom(regsuscrib.sesunuse, \*subscriber_id,*\
                               nupackage,
                               ident_type_id,
                               identification,
                               name_complete,
                               last_name,
                               sbcityresdesc,
                               nucityrescode,
                               sbdepresdesc,
                               address,
                               property_phone,
                               sbcitywordesc,
                               nucityworcode,
                               sbdeprwordesc,
                               sbworkadrress,
                               phone1_id,
                               email);
          Else
            obtdatosdeudorsubs(regsuscrib.sesunuse,
                               ident_type_id,
                               identification,
                               name_complete,
                               sbcityresdesc,
                               nucityrescode,
                               sbdepresdesc,
                               address,
                               property_phone,
                               sbcitywordesc,
                               nucityworcode,
                               sbdeprwordesc,
                               sbworkadrress,
                               phone1_id,
                               email);
          End If;
          nuultimopasoejecutado := 1500;
          sbestatus             := 'N';
          Begin

            regsuscrib.ident_type_id       := ident_type_id;
            regsuscrib.identification      := identification;
            regsuscrib.subscriber_name     := name_complete;
            regsuscrib.address             := address;
            regsuscrib.phone               := phone1_id;
            regsuscrib.e_mail              := email;

            proprocesaser(regsuscrib);

          Exception
            When Others Then

              proregistrarerror(inutype_identification   => regsuscrib.ident_type_id,
                                inuidentification_number => regsuscrib.identification,
                                isbaccount_number        => regsuscrib.sesunuse);
          End;

        End Loop;
      End Loop; --selection criteria*/

    ELSIF isbrepomuestra = 'M' THEN

      FOR regselcrit IN cuselcrit(inutypesector, inucreditbereauid) LOOP

        nuamount := regselcrit.minimum_amount;
        -- No es necesario obtener el numero de suscriptores a tener en cuenta
        -- ya que este viene por parametro.  SAO226523
        --nusubscribernumber := regselcrit.subscriber_number;
        nuoverduebills := regselcrit.overdue_bills;
        nucategory     := regselcrit.category;

        FOR regsuscrib IN cu_servicios(p_credit_bureau_id => inucreditbereauid,
                                       p_typesector       => inutypesector,
                                       p_typeproductid    => inutypeproductid,
                                       p_category         => nucategory,
                                       p_overduebills     => nuoverduebills,
                                       p_repomuestra      => isbrepomuestra,
                                       -- Usar para el proceso el numero de suscriptores
                                       -- que vienen por parametro. SAO226523
                                       p_subscriber_number => sbsubscriber_number,
                                       p_nuano             => nuanogen,
                                       p_numes             => numesgen) LOOP
          BEGIN
            -- CA 200-792.  S?lo se obtiene la informaci?n del deudor para el servicio 7055
            -- y 7056 si la entrega no est? aplicada o si el producto tiene saldo en reclamo
            IF inutypeproductid IN (7055, 7056) THEN
              IF ((regsuscrib.valor_reclamo = 0 AND
                 fblaplicaentrega(csbBSS_CAR_SMS_200792)) OR
                 NOT fblaplicaentrega(csbBSS_CAR_SMS_200792)) THEN
                -- CA 200-792

                /* Se agrega una condici?n hastes de buscar los datos del codeudor para saber si hubo traslado.
                Punto 4 del caso 200-981. Si hay traslado reportar el deudor origen*/

                obtdatosdeudorprom(regsuscrib.sesunuse, /*subscriber_id,*/
                                   nupackage,
                                   ident_type_id,
                                   identification,
                                   name_complete,
                                   last_name,
                                   sbcityresdesc,
                                   nucityrescode,
                                   sbdepresdesc,
                                   address,
                                   property_phone,
                                   sbcitywordesc,
                                   nucityworcode,
                                   sbdeprwordesc,
                                   sbworkadrress,
                                   phone1_id,
                                   email);
              END IF;
            ELSE

              /* Se agrega una condici?n hastes de buscar los datos del codeudor para saber si hubo traslado.
              Punto 4 del caso 200-981. Si hay traslado reportar el deudor origen*/

              obtdatosdeudorsubs(regsuscrib.sesunuse, -- Se cambia Id enviado
                                 ident_type_id,
                                 identification,
                                 name_complete,
                                 sbcityresdesc,
                                 nucityrescode,
                                 sbdepresdesc,
                                 address,
                                 property_phone,
                                 sbcitywordesc,
                                 nucityworcode,
                                 sbdeprwordesc,
                                 sbworkadrress,
                                 phone1_id,
                                 email);
            END IF;
          END;
          nuultimopasoejecutado := 1480;
          sbestatus             := 'V';

          IF ((regsuscrib.valor_reclamo > 0 AND
             fblaplicaentrega(csbBSS_CAR_SMS_200792)) OR
             NOT fblaplicaentrega(csbBSS_CAR_SMS_200792)) THEN

            BEGIN

              regsuscrib.ident_type_id   := ident_type_id;
              regsuscrib.identification  := identification;
              regsuscrib.subscriber_name := name_complete;
              regsuscrib.subs_last_name  := last_name;
              regsuscrib.address         := address;
              regsuscrib.phone           := phone1_id;
              regsuscrib.e_mail          := email;

              proprocesaser(regsuscrib);
            EXCEPTION
              WHEN OTHERS THEN
                proregistrarerror(inutype_identification   => regsuscrib.ident_type_id,
                                  inuidentification_number => regsuscrib.identification,
                                  isbaccount_number        => regsuscrib.sesunuse);
            END;
          END IF;

        END LOOP; -- For regsuscrib In cu_servicios(p_credit_bureau_id  => inucreditbereauid,

      END LOOP; -- For regselcrit In cuselcrit(inutypesector,

    END IF; -- If isbrepomuestra = 'R' Then

    nuultimopasoejecutado := 1510;

    -- Grabar el resumen del proceso
    prosample_fin;

    -- Grabar la fecha de finalizacion del reporte en la tabla de control
    proupdatesample_cont;

    --  End If; -- If (boencontrado = True) Then

    nuultimopasoejecutado := 1520;
    p_ionutotalrec        := ionutotalrec;
    p_ionutotalerr        := nuerrorcount;
    p_ionutotalnov        := ionutotalnov;
    p_onuerrorcode        := onuerrorcode;
    p_osberrormessage     := substr(osberrormessage, 1, 950);
    p_operation_trace     := g_operation_trace;
    p_table_name_trace    := g_table_name_trace;
    p_rec_procesados      := g_rec_procesados;

  EXCEPTION
    WHEN OTHERS THEN

      --      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      onuerrorcode    := nuultimopasoejecutado;
      osberrormessage := 'Error en ld_bcgenerationrandomsample.pbogenerationser paso ' ||
                         nuultimopasoejecutado || ' - ' || SQLERRM;

      p_ionutotalrec     := ionutotalrec;
      p_ionutotalerr     := nuerrorcount;
      p_ionutotalnov     := ionutotalnov;
      p_onuerrorcode     := onuerrorcode;
      p_osberrormessage  := substr(osberrormessage, 1, 950);
      p_operation_trace  := g_operation_trace;
      p_table_name_trace := g_table_name_trace;
      p_rec_procesados   := g_rec_procesados;

      pkerrors.pop;
  END pbogenerationser;

  FUNCTION fsbversion RETURN VARCHAR2 IS
  BEGIN
    --{
    -- Retorna el SAO con que se realizo la ultima entrega del paquete
    RETURN(csbversion);
    --}
  END fsbversion;

  PROCEDURE obtdatosdeudorprom(sesunuse       servsusc.sesunuse%TYPE,
                               nupackage_id   OUT ld_promissory.package_id%TYPE,
                               ident_type_id  OUT NUMBER,
                               identification OUT ld_promissory.identification%TYPE,
                               name_complete  OUT ld_promissory.debtorname%TYPE,
                               last_name      OUT ld_promissory.last_name%TYPE,
                               sbcityresdesc  OUT ge_geogra_location.description%TYPE,
                               nucityrescode  OUT ge_geogra_location.geograp_location_id%TYPE,
                               sbdepresdesc   OUT ge_geogra_location.description%TYPE,
                               address        OUT ab_address.address%TYPE,
                               property_phone OUT ld_promissory.propertyphone_id%TYPE,
                               sbcitywordesc  OUT ge_geogra_location.description%TYPE,
                               nucityworcode  OUT ge_geogra_location.geo_loca_father_id%TYPE,
                               sbdeprwordesc  OUT ge_geogra_location.description%TYPE,
                               sbworkadrress  OUT ab_address.address%TYPE,
                               phone1_id      OUT NUMBER,
                               email          OUT VARCHAR2) AS
    /******************************************************************
    Proposito: Consulta datos del deudor

    Historia de Modificaciones

    Fecha           IDEntrega
     22/05/2017      Jsilvera
    Se agrega una condici?n hastes de buscar los datos del codeudor para saber si hubo traslado.
    Punto 4 del caso 200-981. Si hay traslado reportar el deudor origen
    **********************************************************************/

    NumeroServ servsusc.sesunuse%TYPE;
  BEGIN
	
    /* Se agrega una condici?n hastes de buscar los datos del codeudor para saber si hubo traslado.
    Punto 4 del caso 200-981. Si hay traslado reportar el deudor origen*/
    BEGIN
		SELECT DISTINCT TCSESSFU
        INTO 	NumeroServ
        FROM    OPEN.TRCASESU, OPEN.CUENCOBR
		WHERE 	TCSESSDE = sesunuse
		AND     TCSECCGE = CUCOCODI
		AND     NVL(CUCOSACU, 0) > 0;
    EXCEPTION
      WHEN OTHERS THEN
        NumeroServ := sesunuse;
    END;

    SELECT vPACKAGE_ID ,
                     vIDENT_TYPE_ID ,
                     vIDENTIFICATION ,
                     vDEBTORNAME ,
                     vLAST_NAME ,
                     vCITY_DESC ,
                     vCITY ,
                     vDEPARTMENT_DESC ,
                     vADDRESS_ID ,
                     vPROPERTYPHONE_ID ,
                     vCITY_COMPANY_DESC ,
                     vCITY_COMPANY_ID ,
                     vDEPARTMENTCOMPANY_DESC ,
                     vCOMPANYADDRESS_ID  ,
                     vPHONE1_ID ,
                     vEMAIL INTO
                     nupackage_id,
           ident_type_id,
           identification,
           name_complete,
           last_name,
           sbcityresdesc,
           nucityrescode,
           sbdepresdesc,
           address,
           property_phone,
           sbcitywordesc,
           nucityworcode,
           sbdeprwordesc,
           sbworkadrress,
           phone1_id,
           email FROM LDC_datossesunusefgrcr WHERE NUSE=NumeroServ and rownum=1;


		--Si hubo traslado, traer los datos de direccion del nuevo producto
		IF (sesunuse <> NumeroServ) THEN

			SELECT 	a.address
			INTO	address
			FROM 	open.pr_product p, open.suscripc, open.ab_address a
			WHERE 	p.product_id = sesunuse
			AND		p.subscription_id = susccodi
			AND 	susciddi = a.address_id;

		END IF;

    /* SELECT p.package_id,
           p.ident_type_id,
           identification,
           debtorname nombre,
           last_name last_name,
           (SELECT ge_geogra_location.description
              FROM ab_address, ge_geogra_location
             WHERE ab_address.address_id = p.address_id
               AND ab_address.geograp_location_id =
                   ge_geogra_location.geograp_location_id) city_desc,
           (SELECT ge_geogra_location.geograp_location_id
              FROM ab_address, ge_geogra_location
             WHERE ab_address.address_id = p.address_id
               AND ab_address.geograp_location_id =
                   ge_geogra_location.geograp_location_id) city,
           (SELECT ge_geogra_location.description
              FROM ge_geogra_location
             WHERE geograp_location_id IN
                   (SELECT ge_geogra_location.geo_loca_father_id
                      FROM ab_address, ge_geogra_location
                     WHERE ab_address.address_id = p.address_id
                       AND ab_address.geograp_location_id =
                           ge_geogra_location.geograp_location_id)) department_desc,
           daab_address.fsbgetaddress(p.address_id, 0) address_id,
           propertyphone_id,
           (SELECT ge_geogra_location.description
              FROM ab_address, ge_geogra_location
             WHERE ab_address.address_id = p.companyaddress_id
               AND ab_address.geograp_location_id =
                   ge_geogra_location.geograp_location_id) city_company_desc,
           (SELECT ge_geogra_location.geograp_location_id
              FROM ab_address, ge_geogra_location
             WHERE ab_address.address_id = p.companyaddress_id
               AND ab_address.geograp_location_id =
                   ge_geogra_location.geograp_location_id) city_company_id,
           (SELECT ge_geogra_location.description
              FROM ge_geogra_location
             WHERE geograp_location_id IN
                   (SELECT ge_geogra_location.geo_loca_father_id
                      FROM ab_address, ge_geogra_location
                     WHERE ab_address.address_id = p.companyaddress_id
                       AND ab_address.geograp_location_id =
                           ge_geogra_location.geograp_location_id)) department_desc,
           (SELECT address
              FROM ab_address
             WHERE ab_address.address_id = p.companyaddress_id) companyaddress_id,
           phone1_id,
           p.email
      INTO nupackage_id,
           ident_type_id,
           identification,
           name_complete,
           last_name,
           sbcityresdesc,
           nucityrescode,
           sbdepresdesc,
           address,
           property_phone,
           sbcitywordesc,
           nucityworcode,
           sbdeprwordesc,
           sbworkadrress,
           phone1_id,
           email
      FROM ld_promissory p
     WHERE p.package_id =
           (SELECT MAX(pk.package_id)
              FROM mo_motive mo, mo_packages pk
             WHERE mo.package_id = pk.package_id
               AND mo.product_id = NumeroServ
               AND pk.package_type_id =
                   (SELECT numeric_value
                      FROM ld_parameter
                     WHERE parameter_id = 'TIPO_SOL_VENTA_FNB'))
       AND promissory_type = 'D'
       and rownum=1;
       */
  EXCEPTION
    WHEN no_data_found THEN
      nupackage_id   := NULL;
      ident_type_id  := NULL;
      identification := NULL;
      name_complete  := NULL;
      last_name      := NULL;
      sbcityresdesc  := NULL;
      nucityrescode  := NULL;
      sbdepresdesc   := NULL;
      address        := NULL;
      property_phone := NULL;
      sbcitywordesc  := NULL;
      nucityworcode  := NULL;
      sbdeprwordesc  := NULL;
      sbworkadrress  := NULL;
      phone1_id      := NULL;
      email          := NULL;

  END;

  PROCEDURE obtdatosdeudorsubs(sesunuse       servsusc.sesunuse%TYPE,
                               ident_type_id  OUT ld_promissory.ident_type_id%TYPE,
                               identification OUT ld_promissory.identification%TYPE,
                               name_complete  OUT ld_promissory.debtorname%TYPE,
                               sbcityresdesc  OUT ge_geogra_location.description%TYPE,
                               nucityrescode  OUT ge_geogra_location.geograp_location_id%TYPE,
                               sbdepresdesc   OUT ge_geogra_location.description%TYPE,
                               address        OUT ab_address.address%TYPE,
                               property_phone OUT ld_promissory.propertyphone_id%TYPE,
                               sbcitywordesc  OUT ge_geogra_location.description%TYPE,
                               nucityworcode  OUT ge_geogra_location.geo_loca_father_id%TYPE,
                               sbdeprwordesc  OUT ge_geogra_location.description%TYPE,
                               sbworkadrress  OUT ab_address.address%TYPE,
                               phone1_id      OUT NUMBER,
                               email          OUT VARCHAR2) AS
  BEGIN
    SELECT DISTINCT --p.subscriber_id,
                    p.ident_type_id,
                    p.identification,
                    p.subscriber_name || ' ' || p.subs_last_name,
                    (SELECT ge_geogra_location.description
                       FROM ab_address, ge_geogra_location
                      WHERE ab_address.address_id = a.address_id
                        AND ab_address.geograp_location_id =
                            ge_geogra_location.geograp_location_id) cty_desc,
                    (SELECT ge_geogra_location.geograp_location_id
                       FROM ab_address, ge_geogra_location
                      WHERE ab_address.address_id = a.address_id
                        AND ab_address.geograp_location_id =
                            ge_geogra_location.geograp_location_id) city,
                    (SELECT ge_geogra_location.description
                       FROM ge_geogra_location
                      WHERE geograp_location_id IN
                            (SELECT ge_geogra_location.geo_loca_father_id
                               FROM ab_address, ge_geogra_location
                              WHERE ab_address.address_id = a.address_id
                                AND ab_address.geograp_location_id =
                                    ge_geogra_location.geograp_location_id)) department_desc,
                    a.address,
                    p.phone,
                    '' city_company_desc,
                    0 city_company_id,
                    '' department_desc,
                    '' company_address,
                    0 phone_id,
                    '' email
      INTO ident_type_id,
           identification,
           name_complete,
           sbcityresdesc,
           nucityrescode,
           sbdepresdesc,
           address,
           property_phone,
           sbcitywordesc,
           nucityworcode,
           sbdeprwordesc,
           sbworkadrress,
           phone1_id,
           email
      FROM ge_subscriber      p,
           ab_address         a,
           ge_geogra_location g,
           pr_product         pr,
           suscripc           s
     WHERE s.susciddi = a.address_id
       AND a.geograp_location_id = g.geograp_location_id
       AND pr.subscription_id = s.susccodi
       AND s.suscclie = p.subscriber_id
       AND pr.product_id = sesunuse;
  EXCEPTION
    WHEN OTHERS THEN
      ident_type_id  := NULL;
      identification := NULL;
      name_complete  := NULL;
      sbcityresdesc  := NULL;
      nucityrescode  := NULL;
      sbdepresdesc   := NULL;
      address        := NULL;
      property_phone := NULL;
      sbcitywordesc  := NULL;
      nucityworcode  := NULL;
      sbdeprwordesc  := NULL;
      sbworkadrress  := NULL;
      phone1_id      := NULL;
      email          := NULL;
  END;

  FUNCTION fnuAplicaEntrega200_792 RETURN NUMBER IS

    /***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fnuAplicaEntrega200_792
    Descripci?n:        Esta funci?n se crea para poder validar entregas en sql

    Autor    : Sandra Mu?oz
    Fecha    : 31-08-2016 cA100-9314

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    31-08-2016   Sandra Mu?oz           Creaci?n
    ***********************************************************************************************/

  BEGIN
    IF fblAplicaEntrega(csbBSS_CAR_SMS_200792) THEN
      RETURN 1;
    END IF;

    RETURN 0;

  END fnuAplicaEntrega200_792;

  FUNCTION Fnc_EnvioNotificacion(IdMuestra NUMBER) RETURN BOOLEAN IS

    /***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: Fnc_EnvioNotificaci?n
    Descripci?n:        Esta funci?n se crea para poder validar entregas en sql

    Autor    : Jery Silvera
    Fecha    : 02/06/2017

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    02-06-2017   Jery Ann Silvera           Creaci?n
    ***********************************************************************************************/

    SbFlag VARCHAR2(2);
  BEGIN
    bEGIN
      SELECT nvl(d.notification, 'N')
        INTO SbFlag
        FROM ld_sample d
       WHERE d.sample_id = IdMuestra;
    EXCEPTION
      WHEN OTHERS THEN
        SBFlag := 'N';
    END;
    IF (SbFlag = 'N') THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;

  END Fnc_EnvioNotificacion;

  PROCEDURE PRO_MARCARUSUARIOS IS

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:  PRO_MARCARUSUARIOS
    Descripci?n:         Procesa el pb DE marcar deudores y codeudores a reportar a centrales de riesgos

    Autor    : Jery Ann silvera
    Fecha    : 01-06-2017

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    01-06-2017   Jery Ann silvera          Creaci?n
    ******************************************************************/
    sbProceso VARCHAR2(4000) := 'MDCCR';
    nuPaso    NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    sbError   VARCHAR2(4000);
    exError EXCEPTION; -- Error controlado

    sbsample_id             ge_boinstancecontrol.stysbvalue;
    sbE_MAIL                ge_boinstancecontrol.stysbvalue;
    sbFrom                  ld_parameter.value_chain%TYPE := open.dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER');
    sbMensaje               VARCHAR2(4000);
    csbBSS_CAR_JSI_200981_1 VARCHAR2(30) := 'BSS_CAR_JSI_200981_1';

    nutsess                 NUMBER;
    sbparuser               VARCHAR2(30);
    sbmensa                 VARCHAR2(1000);
    nuanoact                number;
    numesact                number;
    nuanoant                number;
    numesant                number;
    nucantsample            number :=0 ;
    nusample                number := 0;

    /*CURSOR PARA OBTENER LA INFORMACI?N*/
    CURSOR CurRegistros IS
      SELECT TYPE_IDENTIFICATION_DC TipoID,
             IDENTIFICATION_NUMBER NumeroID,
             FULL_NAME Nombrecompleto,
             '' Tipodecarta,
             '' Tipodeenvio,
             ACCOUNT_NUMBER NumObligacion,
             S.SESUSUSC Contrato,
             S.SESUSERV TipodeProducto,
             F.SERVDESC DescripciondelProducto,
             (VALUE_DELAY * 1000) Saldoenmora /*MULTIPLICARLO POR MIL PARA OBTENER EN MILES*/,
             (SELECT EDAD
                FROM LDC_OSF_SESUCIER_t
               WHERE PRODUCTO = s.sesunuse
                 AND (NUANO, numes) IN
                     (SELECT to_char(MAX(CICOFECH), 'yyyy'),
                             to_char(MAX(CICOFECH), 'mm')
                        FROM LDC_CIERCOME)) EdadMoraReal,
             MORA_AGE EdadDATACREDITO,
             to_char(to_date(PAYMENT_DEADLINE_DC, 'yyyymmdd'), 'dd/mm/yyyy') Fechadevencimiento, /*EN FORMATO DD/MM/YYYY */
             DECODE(RESPONSIBLE_DC, 0, 'DEUDOR', 'CODEUDOR') RespCalidaddeldeudor,
             RESIDENTIAL_ADDRESS_DC Direccion,
             RESIDENTIAL_CITY_DC Ciudad,
             RESIDENTIAL_DEPARTMENT_DC Departamento,
             EMAIL_DC correoElectronico
        FROM LD_SAMPLE_DETAI D, SERVSUSC S, SERVICIO f
       WHERE SAMPLE_ID = sbsample_id
         AND VALUE_DELAY >=
             (SELECT nvl(SUM(l.numercial_value), 30)
                FROM ld_general_parameters l
               WHERE l.parameter_desc = 'EDAD_MORA_NOTI')
         AND D.ACCOUNT_NUMBER = S.SESUNUSE
         AND S.SESUSERV = F.SERVCODI;

    /*MUESTRA ANTERIOR*/
    CURSOR CurRegistros2(Num_serv NUMBER, lD_SAMPLE_iD NUMBER) IS
      SELECT COUNT(1)
        FROM LD_SAMPLE_DETAI D, SERVSUSC S, SERVICIO f
       WHERE SAMPLE_ID = lD_SAMPLE_iD
         AND VALUE_DELAY >=
             (SELECT nvl(SUM(l.numercial_value), 30)
                FROM ld_general_parameters l
               WHERE l.parameter_desc = 'EDAD_MORA_NOTI')
         AND D.ACCOUNT_NUMBER = S.SESUNUSE
         AND S.SESUSERV = F.SERVCODI
         AND S.SESUNUSE = Num_serv;

    cadena    VARCHAR2(32767);
    file      UTL_FILE.FILE_TYPE;
    SbRuta    VARCHAR2(3000);
    SbnomRepo VARCHAR2(3000);

   cursor cuCuentaSample is
    select count(1) from (SELECT distinct t.generation_date
                     FROM open.LD_SAMPLE t);

   cursor cuSampleAnt (numes number, nuano number) is
    SELECT sample_id
        FROM open.LD_SAMPLE
       WHERE to_char(generation_date, 'mm') = numes
         AND to_char(generation_date, 'yyyy') = Nuano
         AND flag = 'S';

  BEGIN
    pkerrors.push('ld_bcgenerationrandomsample.PRO_MARCARUSUARIOS');

    ut_trace.trace('INICIO ' || '.' || sbProceso);

    /* IF NOT fblaplicaentrega(csbBSS_CAR_JSI_200981_1) THEN
        sbError := 'La entrega ' || csbBSS_CAR_JSI_200981_1 || ' no se encuentra aplicada';

        RAISE ex.Controlled_Error;
    END IF;*/

    -- INICIALIZAN VARIABLES SELECCIONADAS POR PANTALLA

    sbSAMPLE_ID := ge_boInstanceControl.fsbGetFieldValue('LD_SAMPLE',
                                                         'SAMPLE_ID');


    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    IF (sbSAMPLE_ID IS NULL) THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, 'Codigo de la Muestra');
      RAISE ex.CONTROLLED_ERROR;
    END IF;

    --- Validar si a la muestra ya se le gener? el proceso de notificaci?n:

    IF (Fnc_EnvioNotificacion(sbsample_id)) THEN
      errors.seterror(2741,
                      'La muestra ya se le gener? el proceso de marcar los deudores y codeudores a env?ar notificaciones.');
      RAISE ex.controlled_error;
    END IF;

    -- BUSCAR CORREO DE ENVPIO DE NOTIFICACI?N
    BEGIN
      SELECT d.text_value
        INTO sbE_MAIL
        FROM open.ld_general_parameters d
       WHERE d.parameter_desc = 'CORREOS_NOTI';
    EXCEPTION
      WHEN OTHERS THEN
        errors.seterror(2741,
                        'No se han configurado los correos para notificar si el proceso de marcar los usuairos a reportar a la central de riesgo. Revise el parametro: EDAD_MORA_NOTI');
        RAISE ex.controlled_error;
    END;

    -- Buscar Ruta de Generaci?n de Archivo:
    BEGIN
      SELECT d.text_value
        INTO SbRuta
        FROM open.ld_general_parameters d
       WHERE d.parameter_desc = 'RUTA_CARTA_CODEUDOR';
    EXCEPTION
      WHEN OTHERS THEN
        errors.seterror(2741,
                        'La ruta donde se guardar? el reporte no se encuentra configurqada. Revisar parametro RUTA_CARTA_CODEUDOR');
        RAISE ex.controlled_error;
    END;

    -- Valida que el mes anterior exista y/o tenga flag en S
     -- Halla ano mes del proceso
    SELECT to_char(generation_date, 'mm'), to_char(generation_date, 'yyyy')
      INTO Numesact, Nuanoact
      FROM open.LD_SAMPLE
     WHERE sample_id = sbsample_id;

    -- Halla ano mes anterior
    IF (Numesact = 1) THEN
      Numesant := 12;
      Nuanoant := Nuanoact - 1;
    ELSE
      Numesant := Numesact - 1;
      Nuanoant := Nuanoact;
    END IF;

    -- Cuenta para saber si es el primer proceso generado (si solo hay uno)
    -- y si es asi no debe buscar si el anterior tiene el flag en S
    open cuCuentaSample;
    fetch cuCuentaSample into nucantsample;
    if cuCuentaSample%notfound then
      nucantsample := 0;
    end if;
    close cuCuentaSample;

    if nucantsample > 1 then
      open cusampleant (numesant, nuanoant);
      fetch cusampleant into nusample;
      if cusampleant%notfound then
        nusample := 0;
      end if;
      close cusampleant;
    end if;

    if nucantsample > 1 and nusample = 0 then
      errors.seterror(2741,
                      'El Periodo Anterior no se ha generado o el Flag esta en N');
      RAISE ex.controlled_error;
    end if;



  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;

  END PRO_MARCARUSUARIOS;

  PROCEDURE PRO_MARCARUSUARIOS(sbSAMPLE_ID NUMBER) IS

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete:  PRO_MARCARUSUARIOS
    Descripci?n:         Procesa el pb DE marcar deudores y codeudores a reportar a centrales de riesgos

    Autor    : Jery Ann silvera
    Fecha    : 01-06-2017

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificaci?n
    -----------  -------------------    -------------------------------------
    01-06-2017   Jery Ann silvera          Creaci?n
    ******************************************************************/
    sbProceso VARCHAR2(4000) := 'MDCCR';
    nuPaso    NUMBER; -- ?ltimo paso ejecutado antes de ocurrir el error
    sbError   VARCHAR2(4000);
    exError EXCEPTION; -- Error controlado

    -- sbsample_id             ge_boinstancecontrol.stysbvalue;
    sbE_MAIL                ge_boinstancecontrol.stysbvalue;
    sbFrom                  ld_parameter.value_chain%TYPE := open.dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER');
    sbMensaje               VARCHAR2(4000);
    csbBSS_CAR_JSI_200981_1 VARCHAR2(30) := 'BSS_CAR_JSI_200981_1';

    /*CURSOR PARA OBTENER LA INFORMACI?N*/
    CURSOR CurRegistros  (cnumes number, cnuano number, cnuedmora number)  IS
      SELECT TYPE_IDENTIFICATION_DC TipoID,
             IDENTIFICATION_NUMBER NumeroID,
             FULL_NAME Nombrecompleto,
             '' Tipodecarta,
             '' Tipodeenvio,
             ACCOUNT_NUMBER NumObligacion,
             S.SESUSUSC Contrato,
             S.SESUSERV TipodeProducto,
             F.SERVDESC DescripciondelProducto,
             (VALUE_DELAY * 1000) Saldoenmora /*MULTIPLICARLO POR MIL PARA OBTENER EN MILES*/,
/*             (SELECT EDAD
                FROM LDC_OSF_SESUCIER_t
               WHERE PRODUCTO = s.sesunuse
                 AND (NUANO, numes) IN
                     (SELECT to_char(MAX(CICOFECH), 'yyyy'),
                             to_char(MAX(CICOFECH), 'mm')
                        FROM LDC_CIERCOME)) EdadMoraReal, */
             SC.EDAD EdadMoraReal,
             MORA_AGE EdadDATACREDITO,
             to_char(to_date(PAYMENT_DEADLINE_DC, 'yyyymmdd'), 'dd/mm/yyyy') Fechadevencimiento, /*EN FORMATO DD/MM/YYYY */
             DECODE(RESPONSIBLE_DC, 0, 'DEUDOR', 'CODEUDOR') RespCalidaddeldeudor,
             RESIDENTIAL_ADDRESS_DC Direccion,
             RESIDENTIAL_CITY_DC Ciudad,
             RESIDENTIAL_DEPARTMENT_DC Departamento,
             EMAIL_DC correoElectronico
        FROM LD_SAMPLE_DETAI D, SERVSUSC S, SERVICIO f, LDC_OSF_SESUCIER_t sc
       WHERE SAMPLE_ID = sbsample_id
       AND SC.PRODUCTO = s.sesunuse
         AND SC.NUANO = cnuano
         AND SC.NUMES = cnumes
        -- AND S.SESUSUSC = 1183670
         AND SC.EDAD >= cnuedmora
--         AND MORA_AGE >=
--             (SELECT nvl(SUM(l.numercial_value), 30)
--                FROM ld_general_parameters l
--               WHERE l.parameter_desc = 'EDAD_MORA_NOTI')
         AND D.ACCOUNT_NUMBER = S.SESUNUSE
         AND S.SESUSERV = F.SERVCODI;

    /*MUESTRA ANTERIOR*/
    CURSOR CurRegistros2(Num_serv NUMBER, lD_SAMPLE_iD NUMBER,  cnumes number, cnuano number, cnuedmora number) IS
      SELECT COUNT(1)
        FROM LD_SAMPLE_DETAI D, SERVSUSC S, SERVICIO f,  LDC_OSF_SESUCIER_t sc
       WHERE SAMPLE_ID = lD_SAMPLE_iD
         AND SC.PRODUCTO = s.sesunuse
         AND SC.NUANO = cnuano
         AND SC.NUMES = cnumes
         AND SC.EDAD >= cnuedmora

   --      AND VALUE_DELAY >=
   --          (SELECT nvl(SUM(l.numercial_value), 30)
   --             FROM ld_general_parameters l
   --            WHERE l.parameter_desc = 'EDAD_MORA_NOTI')
         AND D.ACCOUNT_NUMBER = S.SESUNUSE
         AND S.SESUSERV = F.SERVCODI
         AND S.SESUNUSE = Num_serv;

    cadena         VARCHAR2(32767);
    file           UTL_FILE.FILE_TYPE;
    SbRuta         VARCHAR2(3000);
    SbnomRepo      VARCHAR2(3000);
    ContadorCommit NUMBER := 0;
    Contado        NUMBER := 0;
    Numes          NUMBER := 0;
    Nuano          NUMBER := 0;
    Numes2         NUMBER := 0;
    Nuano2         NUMBER := 0;
    Nusample       NUMBER := 0;
    nuedmora       NUMBER := 0;
    nutsess        NUMBER;
    sbparuser      VARCHAR2(30);
    sbmensa        VARCHAR2(1000);
    nuleidos       number := 0;
  BEGIN
    pkerrors.push('ld_bcgenerationrandomsample.PRO_MARCARUSUARIOS');


    -- Halla usuario y sesion para Log
    SELECT userenv('SESSIONID')
           ,USER INTO nutsess,sbparuser
    FROM dual;

    -- Halla a?? mes del proceso
    SELECT to_char(generation_date, 'mm'), to_char(generation_date, 'yyyy')
      INTO Numes, Nuano
      FROM open.LD_SAMPLE
     WHERE sample_id = sbsample_id;

    ldc_proinsertaestaprog(Nuano,Numes,'MDCCR','Inicia',nutsess,sbparuser);

    ut_trace.trace('INICIO ' || '.' || sbProceso);
    -- borrado de las entidades:
    DELETE LD_NOTIFICATION_DC WHERE sample_id = sbsample_id;
    commit;
    /* IF NOT fblaplicaentrega(csbBSS_CAR_JSI_200981_1) THEN
        sbError := 'La entrega ' || csbBSS_CAR_JSI_200981_1 || ' no se encuentra aplicada';

        RAISE ex.Controlled_Error;
    END IF;*/

    -- INICIALIZAN VARIABLES SELECCIONADAS POR PANTALLA

    --  sbSAMPLE_ID := ge_boInstanceControl.fsbGetFieldValue ('LD_SAMPLE', 'SAMPLE_ID');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    /* if (sbSAMPLE_ID is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Codigo de la Muestra');
        raise ex.CONTROLLED_ERROR;
    end if;*/

    --- Validar si a la muestra ya se le gener? el proceso de notificaci?n:

    /*  IF (Fnc_EnvioNotificacion(sbsample_id)) THEN
        errors.seterror(2741, 'La muestra ya se le gener? el proceso de marcar los deudores y codeudores a enviar notificaciones.');
        RAISE ex.controlled_error;
    END IF;*/

    -- BUSCAR CORREO DE ENVPIO DE NOTIFICACI?N
    BEGIN
      SELECT d.text_value
        INTO sbE_MAIL
        FROM open.ld_general_parameters d
       WHERE d.parameter_desc = 'CORREOS_NOTI';
    EXCEPTION
      WHEN OTHERS THEN
        sbmensa       := 'No se han configurado los correos para notificar si el proceso de marcar los usuarios a reportar a la central de riesgo. Revise el parametro: EDAD_MORA_NOTI';
        ldc_proactualizaestaprog(nutsess,sbmensa,'MDCCR','Termino con Error');

        errors.seterror(2741,
                        'No se han configurado los correos para notificar si el proceso de marcar los usuairos a reportar a la central de riesgo. Revise el parametro: EDAD_MORA_NOTI');
        RAISE ex.controlled_error;
    END;

    -- Buscar Ruta de Generaci?n de Archivo:
    BEGIN
      SELECT d.text_value
        INTO SbRuta
        FROM open.ld_general_parameters d
       WHERE d.parameter_desc = 'RUTA_CARTA_CODEUDOR';
    EXCEPTION
      WHEN OTHERS THEN
        sbmensa       := 'La ruta donde se guardar? el reporte no se encuentra configurqada. Revisar parametro RUTA_CARTA_CODEUDOR';
        ldc_proactualizaestaprog(nutsess,sbmensa,'MDCCR','Termino con Error');
        errors.seterror(2741,
                        'La ruta donde se guardar? el reporte no se encuentra configurqada. Revisar parametro RUTA_CARTA_CODEUDOR');
        RAISE ex.controlled_error;
    END;
    -- inicialir nombre del reporte:

    SbnomRepo := 'REPORTE_DEUDOR_CODEUDOR_ID_REPORTE_' || sbsample_id || '_' ||
                 to_char(SYSDATE, 'dd_mm_yyyy_hh24miss') || '.csv';
    -- Abrir archivo
    file := UTL_FILE.FOPEN(SbRuta, SbnomRepo, 'W', 256);

    UTL_FILE.PUT(FiLE,
                 'Tipo ID,Numero ID, Nombre completo, Tipo Carta, Tipo Envio, Num Obligacion, Saldo en mora,Fecha de vencimiento,Direccion,Ciudad,Departamento,Correo electronico');
    UTL_FILE.FCLOSE(file);
    SELECT to_char(generation_date, 'mm'), to_char(generation_date, 'yyyy')
      INTO Numes, Nuano
      FROM open.LD_SAMPLE
     WHERE sample_id = sbsample_id;

    IF (Numes = 1) THEN
      Numes2 := 12;
      Nuano2 := Nuano - 1;
    ELSE
      Numes2 := Numes - 1;
      Nuano2 := Nuano;
    END IF;
    Begin
      SELECT sample_id
        INTO Nusample
        FROM open.LD_SAMPLE
       WHERE to_char(generation_date, 'mm') = numes2
         AND to_char(generation_date, 'yyyy') = Nuano2
         AND flag = 'S'
         and register_date =
             (select max(register_date)
                FROM open.LD_SAMPLE
               WHERE to_char(generation_date, 'mm') = numes2
                 AND to_char(generation_date, 'yyyy') = Nuano2
                 AND flag = 'S');
    exception
      when others then
        Nusample := -1;
    end;


        SELECT nvl(SUM(l.numercial_value), 30)
      INTO nuedmora
      FROM ld_general_parameters l
     WHERE l.parameter_desc = 'EDAD_MORA_NOTI';

     if nuedmora is null then
       nuedmora := 30;
     end if;

    sbmensa       := 'Inicia Loop';
    ldc_proactualizaestaprog(nutsess,sbmensa,'MDCCR','En Ejecucion');


    FOR RegDatos IN CurRegistros (NUMES, NUANO, nuedmora) LOOP
      nuleidos := nuleidos + 1;
      if mod(nuleidos,10000) = 0 then
        sbmensa       := 'Registros Procesados: ' || nuleidos;
        ldc_proactualizaestaprog(nutsess,sbmensa,'MDCCR','En Ejecucion');
      end if;

      OPEN CurRegistros2(RegDatos.Numobligacion, Nusample, NUMES, NUANO, nuedmora);
      FETCH CurRegistros2
        INTO Contado;

      IF (Contado > 0) THEN

        /*MARCAR USUARIO A NOTIFICAR*/
        UPDATE LD_SAMPLE_DETAI L
           SET L.NOTIFICATION = 'S'
         WHERE l.sample_id = sbsample_id
           AND L.ACCOUNT_NUMBER = RegDatos.NumObligacion;

        file := UTL_FILE.FOPEN(SbRuta, SbnomRepo, 'A', 256);
        UTL_FILE.PUT(FiLE,
                     '"' || RegDatos.Tipoid || '","' || RegDatos.NumeroId ||
                     '","' || RegDatos.Nombrecompleto || '","' ||
                     RegDatos.Tipodecarta || '","' || RegDatos.Tipodeenvio ||
                     '","' || RegDatos.Numobligacion || '","' ||
                     RegDatos.Saldoenmora || '","' ||
                     RegDatos.Fechadevencimiento || '","' ||
                     RegDatos.Direccion || '","' || RegDatos.Ciudad ||
                     '","' || RegDatos.Departamento || '","' ||
                     RegDatos.Correoelectronico);

        UTL_FILE.FCLOSE(file);
        contadorCommit := ContadorCommit + 1;
        IF (contadorCommit = 499) THEN
          COMMIT;
          contadorCommit := 0;
        END IF;

        IF (CurRegistros2%ISOPEN) THEN
          CLOSE CurRegistros2;
        END IF;
      ELSE

        /*MARCAR USUARIO A NOTIFICAR*/
        UPDATE LD_SAMPLE_DETAI L
           SET L.NOTIFICATION = 'N'
         WHERE l.sample_id = sbsample_id
           AND L.ACCOUNT_NUMBER = RegDatos.NumObligacion;
        /*
            INSERT INTO LD_NOTIFICATION_DC
                (SAMPLE_ID, TYPE_IDENTIFICATION_DC, IDENTIFICATION_NUMBER, FULL_NAME, ACCOUNT_NUMBER, VALUE_DELAY, PAYMENT_DEADLINE_DC, RESIDENTIAL_ADDRESS_DC, RESIDENTIAL_CITY_DC, RESIDENTIAL_DEPARTMENT_DC, NUM_CONTRATO, TYPE_PRODUCT, DESC_PRODUCT, RESPONSIBLE_DC, MORA_AGE, CIERRE_AGE)
            VALUES
                (sbsample_id, RegDatos.Tipoid, replace(RegDatos.Numeroid,'.',''), RegDatos.Nombrecompleto, RegDatos.Numobligacion, RegDatos.Saldoenmora, to_date(RegDatos.Fechadevencimiento,'dd/mm/yyyy'), RegDatos.Direccion, RegDatos.Ciudad, RegDatos.Departamento, RegDatos.Contrato, RegDatos.Tipodeproducto, RegDatos.Descripciondelproducto, RegDatos.Respcalidaddeldeudor, RegDatos.Edaddatacredito, RegDatos.Edadmorareal);
             contadorCommit := ContadorCommit + 1;
            IF (contadorCommit = 499) THEN
                COMMIT;
                contadorCommit := 0;
            END IF;;
        */
      END IF;

      IF (CurRegistros2%ISOPEN) THEN
        CLOSE CurRegistros2;
      END IF;

    END LOOP;
    --UTL_FILE.FCLOSE(file);
    -- se actualiza el env?o de lo notificaciones

    sbmensa       := 'Proceso Finalizado Ok';
    ldc_proactualizaestaprog(nutsess,sbmensa,'MDCCR','Termino Ok');

    UPDATE LD_SAMPLE L
       SET L.NOTIFICATION = 'S'
     WHERE l.sample_id = sbsample_id;

    sbMensaje := sbMensaje || 'Proceso finalizado: ' || SYSDATE ||
                 ' Revisar Reporte. en la ruta ' || SbRuta ||
                 ', bajo el nombre: ' || SbnomRepo;

    ldc_email.mail(sender     => sbFrom,
                   recipients => sbE_MAIL,
                   subject    => 'Finalizacion reporte de deudores y codeudores a reportar a la Central de Riesgo ' ||
                                 SbRuta || ' /' || SbnomRepo,
                   message    => sbMensaje);

    ut_trace.trace('FIN ' || '.' || sbProceso);

    COMMIT;

    -- null;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      sbmensa       := 'Termino con Error: ' || sqlerrm;
      ldc_proactualizaestaprog(nutsess,sbmensa,'MDCCR','Termino con Error');
      RAISE;
    WHEN OTHERS THEN
      sbMensaje := SQLERRM;
      sbmensa       := 'Termino con Error: ' || sqlerrm;
      ldc_proactualizaestaprog(nutsess,sbmensa,'MDCCR','Termino con Error');
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;

  END PRO_MARCARUSUARIOS;

END ld_bcgenerationrandomsample;
/
