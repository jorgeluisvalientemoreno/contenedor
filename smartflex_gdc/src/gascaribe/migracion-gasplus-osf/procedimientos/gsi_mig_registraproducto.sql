CREATE OR REPLACE PROCEDURE      "GSI_MIG_REGISTRAPRODUCTO" (
   ionuproduct_id          IN OUT pr_product.product_id%TYPE,
   inusubscription_id      IN     pr_product.subscription_id%TYPE,
   inuproduct_type_id      IN     pr_product.product_type_id%TYPE,
   inucategory_id                 pr_product.category_id%TYPE,
   inusubcategory_id              pr_product.subcategory_id%TYPE,
   inuprod_status          IN     pr_product.product_status_id%TYPE,
   isbservice_number       IN     pr_product.service_number%TYPE,
   idtcreationdate         IN     pr_product.creation_date%TYPE,
   idtretiredate           IN     pr_product.retire_date%TYPE,
   inucommercial_plan_id   IN     pr_product.commercial_plan_id%TYPE,
   inuperson_id            IN     pr_product.person_id%TYPE,
   inuorganizatarea        IN     pr_product.organizat_area_id%TYPE,
   inucontactphone         IN     pr_product.subs_phone_id%TYPE,
   inuaddress_id           IN     ab_address.address_id%TYPE,
   inusesucico             IN     servsusc.sesucico%TYPE,
   inusesumult             IN     servsusc.sesumult%TYPE,
   inusesucicl             IN     servsusc.sesucicl%TYPE,
   inuinstall_date         IN     servsusc.sesufein%TYPE,
   inubillplan             IN     servsusc.sesuplfa%TYPE DEFAULT NULL,
   inuconnectstatus        IN     servsusc.sesuesco%TYPE DEFAULT NULL,
   idtsupension_date       IN     servsusc.sesufeco%TYPE,
   idtlastsuscchangdat     IN     servsusc.sesufucc%TYPE,
   inuavgconnumber         IN     servsusc.sesunucp%TYPE,
   inutotalsanctiones      IN     servsusc.sesunusa%TYPE,
   inufraudprofile         IN     servsusc.sesuperf%TYPE,
   isbwarrantyrol          IN     servsusc.sesuroga%TYPE,
   inupositivebalance      IN     servsusc.sesusafa%TYPE,
   inulastbillperiodpaid   IN     servsusc.sesuupac%TYPE,
   isbcollect_distribute   IN     pr_product.collect_distribute%TYPE,
   isbsesuesfn             IN     servsusc.sesuesfn%TYPE,
   idtlast_update          IN     pr_subs_type_prod.last_update%TyPE,
   inurole_id              IN     pr_subs_type_prod.role_id%TyPE,
   onuerrorcode               OUT ge_message.message_id%TYPE,
   osberrormessage            OUT VARCHAR2)
IS
   /*
    Nombre objeto      gsi_mig_registraproducto
    Proposito          Creacion de cliente tabla ge_subscriber y satelites.
    Historial
    Fecha           Modificacion        Autor
    2012-01-31      Creacion            WOSPINA: Creacion de objeto de acuerdo a la version de esquema en 7.6
    2012-11-27      Modificacion        WOSPINA: Modifiacion de objeto por cambio en esquema.
                                                 Se modifica el API, para manejar los campos:
                                                 - pr_product.collect_distribute
                                                 - servsusc.sesuesfn
                                                 - pr_product.category_id
                                                 - pr_product.subcategory_id
                                                 Se eliminan el campo:
                                                 - pr_product.socioeco_stratum_id

    2013-04-02                          PDELAPENA: Se llena el  parametro de salida con la descripción del error de
                                                   oracle para el caso de errores no controlados osberrormessage:=SQLERRM;



   */
   -- Nulo para números en BSS
   cnunullnums   CONSTANT NUMBER
      := pkgeneralparametersmgr.fnugetnumberparameter ('NULLNUMS') ;
   gnudef_company_id      NUMBER := ge_boparameter.fnuget ('DEFAULT_COMPANY');

   -- Variables tipo registro.
   rcproduct              dapr_product.stypr_product;
   rcsubstype             dapr_subs_type_prod.stypr_subs_type_prod;
   nusesuplfa             servsusc.sesuplfa%TYPE;
-- procedimiento para registrar en hicaesco
   PROCEDURE registerhicaesco (
   inuproductid            IN pr_product.product_id%TYPE,
      inusubscription_id      IN pr_product.subscription_id%TYPE,
      inuproduct_type_id      IN pr_product.product_type_id%TYPE,
      idtinstall_date         IN servsusc.sesufein%TYPE
        
   )is
      rchicaesco        hicaesco%ROWTYPE;
   
   begin
   rchicaesco.hcecnuse:= inuproductid;
   rchicaesco.hcecsusc:=inusubscription_id;
   rchicaesco.hcecserv:=inuproduct_type_id;
   rchicaesco.hcececac:=96;
   rchicaesco.hcececan:=1;
   rchicaesco.hcecfech:=idtinstall_date;
   rchicaesco.hcecusua:='MIGRA';
   rchicaesco.hcecterm:='UNKNOWN';
   rchicaesco.hcecprog:='MIGRA';
   
   
      pktblhicaesco.insrecord (rchicaesco);
   
      ut_trace.trace ('Finaliza registerhicaesco', 5);
   end;
   
   -- Procedimiento encapsulado para el registro del producto en BSS
   PROCEDURE registerservsusc (
      inuproductid            IN pr_product.product_id%TYPE,
      inusubscription_id      IN pr_product.subscription_id%TYPE,
      inuproduct_type_id      IN pr_product.product_type_id%TYPE,
      inucategory_id             pr_product.category_id%TYPE,
      inusubcategory_id          pr_product.subcategory_id%TYPE,
      inubillingplan_id       IN servsusc.sesuplfa%TYPE,
      inuaddress_id           IN ab_address.address_id%TYPE,
      inuprodstatus           IN servsusc.sesuesco%TYPE,
      inusesucico             IN servsusc.sesucico%TYPE,
      inusesumult             IN servsusc.sesumult%TYPE,
      inusesubase             IN servsusc.sesusesb%TYPE,
      idtinstall_date         IN servsusc.sesufein%TYPE,
      inucompanyid            IN servsusc.sesusist%TYPE,
      inulimicred             IN servsusc.sesulicr%TYPE,
      inusesucicl             IN servsusc.sesucicl%TYPE,
      idtretire_date          IN servsusc.sesufere%TYPE,
      idtsupension_date       IN servsusc.sesufeco%TYPE,
      idtlastsuscchangdat     IN servsusc.sesufucc%TYPE,
      inuavgconnumber         IN servsusc.sesunucp%TYPE,
      inutotalsanctiones      IN servsusc.sesunusa%TYPE,
      inufraudprofile         IN servsusc.sesuperf%TYPE,
      isbwarrantyrol          IN servsusc.sesuroga%TYPE,
      inupositivebalance      IN servsusc.sesusafa%TYPE,
      inulastbillperiodpaid   IN servsusc.sesuupac%TYPE,
      isbsesuesfn             IN servsusc.sesuesfn%TYPE)
   IS
      dtsysdate         DATE := SYSDATE;
      rcservsusc        servsusc%ROWTYPE;
      nusesuplfa        servsusc.sesuplfa%TYPE;
      nusesudepa        servsusc.sesudepa%TYPE;
      nusesuloca        servsusc.sesuloca%TYPE;
      rcdatautilities   dapr_data_utilities.stypr_data_utilities;
      sbsesuimld        servsusc.sesuimld%TYPE;
      nuerrorcode       ge_error_log.error_log_id%TYPE;
      sberrormessage    ge_error_log.description%TYPE;
   BEGIN
      ut_trace.trace ('Inicia RegisterServSusc', 5);

      -- Se inicia proceso de registro de producto en BSS
      rcservsusc.sesunuse := inuproductid;                --Número de Producto
      rcservsusc.sesuboui := -1; --BOLSA DE UNIDADES INCLUIDAS (Definido por el cliente LDC: -1)
      rcservsusc.sesucaan := -1;                          --Categoría anterior
      rcservsusc.sesucain := NULL; --Carga instalada (Definido por el cliente LDC: Null)
      rcservsusc.sesucate := inucategory_id;                       --Categoría



      rcservsusc.sesucicl := inusesucicl;                              --Ciclo
      rcservsusc.sesucico := inusesucico;                   --Ciclo de consumo
      rcservsusc.sesuclpr := NULL; --Clase de producto (Definido por el cliente LDC: Null) inusesuclass
      rcservsusc.sesudete := 'N'; --Descargado por tercero (Definido por el cliente LDC: N)
      rcservsusc.sesudiad := -1; --Distribución Administrativa (Definido por el cliente LDC: -1)
      rcservsusc.sesuesco := inuprodstatus;                     --Estado corte
      rcservsusc.sesuexcl := NULL; --EXCLUSIONES DE CONEXION-DESCONEXION-RETIRO(Definido por el cliente LDC: Null)
      rcservsusc.sesuextl := NULL; --Extensión Limite De Credito (Definido por el cliente LDC: Null)
      rcservsusc.sesufeco := idtsupension_date;               --Fecha de corte
      rcservsusc.sesufein := idtinstall_date;              --Fecha instalación
      rcservsusc.sesufere := idtretire_date;                    --Fecha retiro
      rcservsusc.sesufevi := NULL; --Fecha vigencia de tarifas (Definido por el cliente LDC: Null)
      rcservsusc.sesufucb := NULL; --Sesufucb (Definido por el cliente LDC: Null)
      rcservsusc.sesufucc := idtlastsuscchangdat; --Fecha último cambio contrato
      rcservsusc.sesufucp := NULL; --Sesufucp (Definido por el cliente LDC: Null)
      rcservsusc.sesuimld := 'N'; --Imprime larga distancia (Definido por el cliente LDC: N)
      rcservsusc.sesuincl := NULL; --INCLUSIONES DE CONEXION-DESCONEXION-RETRO (Definido por el cliente LDC: Null)
      rcservsusc.sesulicr := inulimicred;                           --Sesulicr
      rcservsusc.sesulimp := 'N'; --Limpieza teléfono publico (Definido por el cliente LDC: N)
      rcservsusc.sesumecv := 1; --Método análisis variación consumo (Definido por el cliente LDC: 4)
      rcservsusc.sesumult := 1; --Multifamiliar (Definido por el cliente LDC: 1)     inusesumult
      rcservsusc.sesunucp := inuavgconnumber;  --Número veces consumo promedio
      rcservsusc.sesunusa := inutotalsanctiones;            --Número sanciones
      rcservsusc.sesuperf := inufraudprofile;            --Perfil Para Fraudes
      rcservsusc.sesuplfa := inubillingplan_id;          --Plan de facturación
      rcservsusc.sesurepr := NULL; --Proceso recarga de minutos (Definido por el cliente LDC: Null)
      rcservsusc.sesuroga := isbwarrantyrol;              --Rol en la garantía
      rcservsusc.sesusafa := inupositivebalance;               --Saldo a favor
      rcservsusc.sesuserv := inuproduct_type_id;               --Tipo servicio
      rcservsusc.sesusesb := NULL; --Servicio suscrito base (Definido por el cliente LDC: Null) inusesubase
      rcservsusc.sesusesg := NULL; --Servicio suscrito garante (Definido por el cliente LDC: Null)
      rcservsusc.sesusist := 99; --Empresa Prestadora Servicio (Definido por el cliente LDC: 99)
      rcservsusc.sesusuan := -1;                       --Subcategoría anterior
      rcservsusc.sesusuca := inusubcategory_id;                 --Subcategoría
      rcservsusc.sesususc := inusubscription_id;                    --Contrato
      rcservsusc.sesuupac := inulastbillperiodpaid;                 --Sesuupac
      rcservsusc.sesuesfn := isbsesuesfn;                 -- Estado financiero
      rcservsusc.sesuloca :=-1;
      rcservsusc.sesudepa :=-1;

      -- Se inserta servicio suscrito.
      pktblservsusc.insrecord (rcservsusc);

      ut_trace.trace ('Finaliza RegisterServSusc', 5);
   EXCEPTION
      WHEN ex.controlled_error
      THEN
         RAISE ex.controlled_error;
      WHEN OTHERS
      THEN
         errors.seterror;
         RAISE ex.controlled_error;
   END registerservsusc;
BEGIN

    ut_trace.trace ('Inserto en Pr_Product [' || ionuproduct_id || ']', 6);

   IF (inucommercial_plan_id IS NULL)
   THEN
      nusesuplfa := inubillplan;
   ELSE
      nusesuplfa :=
         dacc_commercial_plan.fnugetbilling_plan (inucommercial_plan_id);
   END IF;

   -- Se inicia proceso de registro de producto en BSS
   registerservsusc (ionuproduct_id,
                     inusubscription_id,
                     inuproduct_type_id,
                     inucategory_id,
                     inusubcategory_id,
                     nusesuplfa,
                     rcproduct.address_id,
                     inuconnectstatus,
                     inusesucico,
                     inusesumult,
                     NULL,
                     inuinstall_date,
                     rcproduct.company_id,
                     rcproduct.credit_limit,
                     inusesucicl,
                     idtretiredate,
                     idtsupension_date,
                     idtlastsuscchangdat,
                     inuavgconnumber,
                     inutotalsanctiones,
                     inufraudprofile,
                     isbwarrantyrol,
                     inupositivebalance,
                     inulastbillperiodpaid,
                     isbsesuesfn);
                     
   -- Se valida que el ID de producto recibido no sea nulo
   IF (ionuproduct_id IS NULL)
   THEN
      ionuproduct_id := pr_bosequence.getproductid;
   END IF;

   -- Valores predefinidos con el cliente
   rcproduct.distribut_admin_id := -1;          -- DISTRIBUCIÿN ADMINISTRATIVA
   rcproduct.is_provisional := 'N'; -- INDICA SI ES O NO PROVISIONAL Y:[SI], N:[NO]
   rcproduct.provisional_end_date := NULL; -- FECHA FINAL DE SERVICIO PROVISIONAL
   rcproduct.provisional_beg_date := NULL; -- FECHA INICIAL DE SERVICIO PROVISIONAL
   rcproduct.is_private := 'N';            -- FLAG DE PRIVACIDAD YES[Y], NO[N]
   rcproduct.class_product := NULL; -- CLASE DE PRODUCTO. C:[SUBSIDIADO] S:[PATROCINADOR]
   rcproduct.role_warranty := NULL; -- ROL QUE JUEGA EL PRODUCTO EN UNA GARANTÍA. R:[ARRENDATARIO] O:[PROPIETARIO]
   rcproduct.credit_limit := 0;                 -- VALOR DEL LÍMITE DE CRÿ�DITO
   rcproduct.expiration_of_plan := NULL;       -- FECHA DE EXPIRACIÿN DEL PLAN
   rcproduct.included_id := NULL;                 -- IDENTIFICADOR DE INCLUIDO
   rcproduct.company_id := 99; -- CÿDIGO DE LA EMPRESA PRESTADORA DEL SERVICIO.
   rcproduct.permanence := NULL;                 -- DÍAS DE PERMANENCIA MÍNIMA


   rcproduct.product_id := ionuproduct_id;
   rcproduct.subscription_id := inusubscription_id;
   rcproduct.product_type_id := inuproduct_type_id;
   --rcproduct.socioecono_strat_id := inusocioecono_strat_id;
   rcproduct.category_id := inucategory_id;
   rcproduct.subcategory_id := inusubcategory_id;
   --------------

   rcproduct.organizat_area_id := inuorganizatarea;
   rcproduct.subs_phone_id := inucontactphone;

   IF (inuprod_status IS NULL)
   THEN
      rcproduct.product_status_id := pr_boparameter.fnugetprodacti;
   ELSE
      rcproduct.product_status_id := inuprod_status;
   END IF;

   rcproduct.service_number := NVL (isbservice_number, ionuproduct_id);
   rcproduct.creation_date := idtcreationdate;
   rcproduct.retire_date := idtretiredate;
   rcproduct.commercial_plan_id := inucommercial_plan_id;
   rcproduct.person_id := inuperson_id;
   rcproduct.collect_distribute := isbcollect_distribute;

   -- Se asigna la dirección de instalación del producto
   rcproduct.address_id := inuaddress_id;
   ut_trace.trace ('address_id= [' || rcproduct.address_id || ']', 5);
   -- Se asigna el código de la empresa prestadora del servicio
   ut_trace.trace ('company_id = [' || rcproduct.company_id || ']', 10);
  
   if inuconnectstatus=96 then
    registerhicaesco(ionuproduct_id,inusubscription_id,inuproduct_type_id,inuinstall_date);
   end if;
   
   -- Se adiciona registro.
   dapr_product.insrecord (rcproduct);
   ut_trace.trace ('Inserto producto [' || ionuproduct_id || ']', 7);

   -- Se adiciona tipo de cliente para el producto (usuario del servicio)
   rcsubstype.subs_type_prod_id := pr_bosequence.getsubs_type_prodid;

   --rcsubstype.subscriber_type_id := cc_boconstants.cnuservice_client_type;  -- se elimino
   rcsubstype.product_id := ionuproduct_id;
   rcsubstype.subscriber_id :=
      pktblsuscripc.fnugetcustomer (inusubscription_id);
   rcsubstype.role_id := inurole_id;
   rcsubstype.last_update := idtlast_update;
   dapr_subs_type_prod.insrecord (rcsubstype);



   ut_trace.trace (
      'Inserto en pr_subs_type_prod [' || rcsubstype.subs_type_prod_id || ']',
      7);


   ut_trace.trace ('Finaliza Register', 5);
EXCEPTION
   WHEN ex.controlled_error
   THEN
      errors.geterror (onuerrorcode, osberrormessage);
   WHEN OTHERS
   THEN
      errors.seterror;
      errors.geterror (onuerrorcode, osberrormessage);
      osberrormessage:=SQLERRM;
END; 
/
