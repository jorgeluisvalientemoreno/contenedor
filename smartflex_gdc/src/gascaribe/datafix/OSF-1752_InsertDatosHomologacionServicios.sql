column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-1752');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

contador Number;

begin

select count(1) into contador
from personalizaciones.homologacion_servicios;

if contador = 0 then
insert into homologacion_servicios values(	'OPEN','CONSTANTS.TYREFCURSOR','Cursor referenciado','PERSONALIZACIONES','CONSTANTS_PER.TYREFCURSOR',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER.FNUGETOPERATING_UNIT_ID','Consultar unidad operativa de una orden','ADM_PERSON','PKG_BCORDENES.FNUOBTIENEUNIDADOPERATIVA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER.FNUGETCAUSAL_ID','Consultar la causal de una orden','ADM_PERSON','PKG_BCORDENES.FNUOBTIENECAUSAL',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER.FNUGETTASK_TYPE_ID','Consultar el tipo de trabajo de una orden','ADM_PERSON','PKG_BCORDENES.FNUOBTIENETIPOTRABAJO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER.FNUGETORDER_STATUS_ID','Consultar el estado de una orden','ADM_PERSON','PKG_BCORDENES.FNUOBTIENEESTADO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER.FDTGETCREATED_DATE','Consultar la fecha de creacion de una orden','ADM_PERSON','PKG_BCORDENES.FDTOBTIENEFECHACREACION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER.FDTGETASSIGNED_DATE','Consultar la fecha de asignacion de una orden','ADM_PERSON','PKG_BCORDENES.FDTOBTIENEFECHAASIGNA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER.FDTGETLEGALIZATION_DATE','Consultar la fecha de legalizacion de una orden','ADM_PERSON','PKG_BCORDENES.FDTOBTIENEFECHALEGALIZA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER.FDTGETEXEC_INITIAL_DATE','Consultar la fecha de ejecucion inicial de una orden','ADM_PERSON','PKG_BCORDENES.FDTOBTIENEFECHAEJECUINI',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER.FDTGETEXECUTION_FINAL_DATE','Consultar la fecha de ejecucion final de una orden','ADM_PERSON','PKG_BCORDENES.FDTOBTIENEFECHAEJECUFIN',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER.FNUGETDEFINED_CONTRACT_ID','Consultar el contrato de constratista de una orden','ADM_PERSON','PKG_BCORDENES.FNUOBTIENECONTRATOCONTRATISTA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER.FNUGETOPERATING_SECTOR_ID','Consultar el sector operativo de una orden','ADM_PERSON','PKG_BCORDENES.FNUOBTIENESECTOROPERATIVO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER.FNUGETGEOGRAP_LOCATION_ID','Consultar la ubicación geografica de una orden','ADM_PERSON','PKG_BCORDENES.FNUOBTIENELOCALIDAD',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER.FSBGETIS_PENDING_LIQ','Consultar si la orden esta pendiente de liquidar','ADM_PERSON','PKG_BCORDENES.FSBOBTIENEPENDLIQUIDAR',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID','Consultar la clase de causal de una causal','ADM_PERSON','PKG_BCORDENES.FNUOBTIENECLASECAUSAL',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER_ACTIVITY.FNUGETACTIVITY_ID','Consultar el item de una actividad','ADM_PERSON','PKG_BCORDENES.FNUOBTIENEITEMACTIVIDAD',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER_ACTIVITY.FNUGETPRODUCT_ID','Consultar producto de una actividad','ADM_PERSON','PKG_BCORDENES.FNUOBTIENEPRODUCTO',NULL,'Se consulta a partir del id de la orden'	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER_ACTIVITY.FNUGETPACKAGE_ID','Consultar solicitud de una actividad','ADM_PERSON','PKG_BCORDENES.FNUOBTIENESOLICITUD',NULL,'Se consulta a partir del id de la orden'	);
insert into homologacion_servicios values(	'OPEN','DAOR_ORDER_ACTIVITY.FNUGETSUBSCRIPTION_ID','Consultar contrato de una actividad','ADM_PERSON','PKG_BCORDENES.FNUOBTIENECONTRATO',NULL,'Se consulta a partir del id de la orden'	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FNUGETSESUCATE','Consultar categoria del producto','ADM_PERSON','PKG_BCPRODUCTO.FNUCATEGORIA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FNUGETSESUSUCA','Consultar subcategoria del producto','ADM_PERSON','PKG_BCPRODUCTO.FNUSUBCATEGORIA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FNUGETSESUESCO','Consultar estado de corte del producto','ADM_PERSON','PKG_BCPRODUCTO.FNUESTADOCORTE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FNUGETSESUSAFA','Consultar saldo a favor del producto','ADM_PERSON','PKG_BCPRODUCTO.FNUSALDOAFAVOR',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FSBGETSESUEXCL','Consultar estado excluidos de suspension','ADM_PERSON','PKG_BCPRODUCTO.FSBESTADOSEXCLSUSPENSION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FSBGETSESUINCL','Consultar estado incluidos de suspension','ADM_PERSON','PKG_BCPRODUCTO.FSBESTADOSINCLSUSPENSION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FSBGETSESUESFN','Consultar estado financiero del producto','ADM_PERSON','PKG_BCPRODUCTO.FSBESTADOFINANCIERO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FDTGETSESUFECO','Consultar fecha de corte del producto','ADM_PERSON','PKG_BCPRODUCTO.FDTFECHASUSPPAGO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FNUGETSESUPLFA','Consultar plan de financiacion del producto','ADM_PERSON','PKG_BCPRODUCTO.FNUPLANFACTURACION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FNUGETSESUCICO','Consultar ciclo de consumo del producto','ADM_PERSON','PKG_BCPRODUCTO.FNUCICLOCONSUMO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FNUGETSESUCICL','Consultar ciclo de facturacion del producto','ADM_PERSON','PKG_BCPRODUCTO.FNUCICLOFACTURACION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FNUGETSESUSERV','Consultar tipo de producto','ADM_PERSON','PKG_BCPRODUCTO.FNUTIPOPRODUCTO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FNUGETSESUSUSC','Consultar contrato de un producto','ADM_PERSON','PKG_BCPRODUCTO.FNUCONTRATO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FDTGETSESUFEIN','Consultar fecha de instalacion de un producto','ADM_PERSON','PKG_BCPRODUCTO.FDTFECHAINSTALACION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FNUGETSESUMECV','Consultar metodo de variacion de un producto','ADM_PERSON','PKG_BCPRODUCTO.FNUMETODOVARIACION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAPR_PRODUCT.FNUGETPRODUCT_STATUS_ID','Consultar estado de producto de un producto','ADM_PERSON','PKG_BCPRODUCTO.FNUESTADOPRODUCTO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAPR_PRODUCT.FNUGETADDRESS_ID','Consultar direccion de instalacion de un producto','ADM_PERSON','PKG_BCPRODUCTO.FNUIDDIRECCINSTALACION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAPR_PRODUCT.FNUGETSUSPEN_ORD_ACT_ID','Consultar actividad de suspension del producto','ADM_PERSON','PKG_BCPRODUCTO.FNUIDACTIVORDENSUSP',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAPR_PRODUCT.FSBGETIS_PROVISIONAL','Consultar si un producto es provisional','ADM_PERSON','PKG_BCPRODUCTO.PRC_ESPROVISIONAL',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAPR_PRODUCT.FNUGETCLASS_PRODUCT','Consultar clase de producto','ADM_PERSON','PKG_BCPRODUCTO.PRC_CLASEPRODUCTO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAPR_PRODUCT.FBLEXISTS','Validar si un producto existe o no','ADM_PERSON','PKG_BCPRODUCTO.FSBEXISTEPRODUCTO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FBLEXISTS','Validar si un producto existe o no','ADM_PERSON','PKG_BCPRODUCTO.FSBEXISTEPRODUCTO',NULL,'Consulta en la tabla PR_PRODUCT'	);
insert into homologacion_servicios values(	'OPEN','GE_BOCONSTANTS.CSBNO','Constante con valor N','PERSONALIZACIONES','CONSTANTS_PER.CSBNO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','GE_BOCONSTANTS.CSBYES','Constante con valor Y','PERSONALIZACIONES','CONSTANTS_PER.CSBYES',NULL,''	);
insert into homologacion_servicios values(	'OPEN','EX.CONTROLLED_ERROR','Variable de error controlado','ADM_PERSON','PKG_ERROR.CONTROLLED_ERROR',NULL,''	);
insert into homologacion_servicios values(	'OPEN','ERRORS.SETERROR','Setear error','ADM_PERSON','PKG_ERROR.SETERROR',NULL,''	);
insert into homologacion_servicios values(	'OPEN','ERRORS.GETERROR','Obtener error','ADM_PERSON','PKG_ERROR.GETERROR',NULL,''	);
insert into homologacion_servicios values(	'OPEN','ERRORS.SETMESSAGE','Setear error con mensaje','ADM_PERSON','PKG_ERORR.SETERRORMESSAGE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','GE_BOERRORS.SETERRORCODE','Setear error','ADM_PERSON','PKG_ERROR.SETERROR',NULL,''	);
insert into homologacion_servicios values(	'OPEN','GE_BOERRORS.SETERRORCODEARGUMENT','Setear error con mensaje','ADM_PERSON','PKG_ERORR.SETERRORMESSAGE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OR_BOCONSTANTS.CNUORDER_STAT_PROGRAMMED','Constante estado de orden programada','PERSONALIZACIONES','PKG_GESTIONORDENES.CNUORDENPROGRAMADA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OR_BOCONSTANTS.CNUORDER_STAT_ASSIGNED','Constante estado de orden asignada','PERSONALIZACIONES','PKG_GESTIONORDENES.CNUORDENASIGNADA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OR_BOCONSTANTS.CNUORDER_STAT_REGISTERED','Constante estado de orden registrada','PERSONALIZACIONES','PKG_GESTIONORDENES.CNUORDENREGISTRADA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OR_BOCONSTANTS.CNUORDER_STAT_EXECUTING','Constante estado de orden ejecutada','PERSONALIZACIONES','PKG_GESTIONORDENES.CNUORDENENEJECUCION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OR_BOCONSTANTS.CNUORDER_STAT_MOVILIZING','Constante estado de orden movilizada','PERSONALIZACIONES','PKG_GESTIONORDENES.CNUORDENMOVILIZANDO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OR_BOCONSTANTS.CNUORDER_STAT_WAITING','Constante estado de orden en espera','PERSONALIZACIONES','PKG_GESTIONORDENES.CNUORDENENESPERA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OR_BOFWLOCKORDER.LOCKORDER','Bloquear orden','ADM_PERSON','API_LOCKORDER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OR_BOFWLOCKORDER.UNLOCKORDER','Desbloquear orden','ADM_PERSON','API_UNLOCKORDER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OR_BOPROCESSORDER.UNASSIGNORDER','Desasignar orden','ADM_PERSON','API_UNASSIGNORDER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OR_BOPROCESSORDER.UNPROGRAM','Desprogramar orden','ADM_PERSON','API_UNPROGRAMORDER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSUSCRIPC.FNUGETSUSCCLIE','Consultar cliente de un contrato','ADM_PERSON','PKG_BCCONTRATO.FNUIDCLIENTE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSUSCRIPC.FNUGETSUSCCICL','Consultar ciclo de un contrato','ADM_PERSON','PKG_BCCONTRATO.FNUCICLOFACTURACION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSUSCRIPC.FNUGETSUSCTISU','Consultar tipo de contrato','ADM_PERSON','PKG_BCCONTRATO.FNUTIPOCONTRATO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSUSCRIPC.FNUGETSUSCIDDI','Consultar direccion de reparto','ADM_PERSON','PKG_BCCONTRATO.FNUIDDIRECCREPARTO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSUSCRIPC.FNUGETSUSCSAFA','Consultar saldo a favor del contrato','ADM_PERSON','PKG_BCCONTRATO.FNUSALDOAFAVOR',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKTBLSUSCRIPC.FNUGETSUSCNUPR','Consultar proceso de facturacion del contrato','ADM_PERSON','PKG_BCCONTRATO.FNUCODIGOPROCFACTURACION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAGE_SUBSCRIBER.FNUIDENT_TYPE_ID','Consultar tipo de identificacion','ADM_PERSON','PKG_BCCLIENTE.FNUTIPOIDENTIFICACION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAGE_SUBSCRIBER.FSBIDENTIFICATION','Consultar numero de identificacion del cliente','ADM_PERSON','PKG_BCCLIENTE.FSBIDENTIFICACION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAGE_SUBSCRIBER.FNUSUBSCRIBER_TYPE_ID','Consultar tipo de cliente','ADM_PERSON','PKG_BCCLIENTE.FNUTIPOCLIENTE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAGE_SUBSCRIBER.FSBSUBSCRIBER_NAME','Consultar nombres del cliente','ADM_PERSON','PKG_BCCLIENTE.FSBNOMBRES',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAGE_SUBSCRIBER.FSBSUBS_LAST_NAME','Consultar apellidos del cliente','ADM_PERSON','PKG_BCCLIENTE.FSBAPELLIDOS',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAGE_SUBSCRIBER.FSBE_MAIL','Consultar correo del cliente','ADM_PERSON','PKG_BCCLIENTE.FSBCORREO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAGE_SUBSCRIBER.FNUECONOMIC_ACTIVITY_ID','Consultar actividad economica del cliente','ADM_PERSON','PKG_BCCLIENTE.FNUACTIVIDADECONOMICA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','UT_DATE.FSBDATE_FORMAT','Obtener formato de fecha','PERSONALIZACIONES','LDC_BOCONSGENERALES.FSBGETFORMATOFECHA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','UT_DATE.FDTSYSDATE','Obtener fecha actual','PERSONALIZACIONES','LDC_BOCONSGENERALES.FDTGETSYSDATE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','UT_TRACE.TRACE','Imprimir traza','ADM_PERSON','PKG_TRAZA.TRACE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAGE_PERSON.FNUGETUSER_ID','Obtener usuario id de la persona','ADM_PERSON','PKG_BOPERSONAL.FSBGETUSUARIO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','GE_BOPERSONAL.FNUGETPERSONID','Obtener person id','ADM_PERSON','PKG_BOPERSONAL.FNUGETPERSONAID',NULL,''	);
insert into homologacion_servicios values(	'OPEN','GE_BOPERSONAL.FNUGETCURRENTCHANNEL','Obtener punto de atencion de la persona','ADM_PERSON','PKG_BOPERSONAL.FNUGETPUNTOATENCIONID',NULL,''	);
insert into homologacion_servicios values(	'OPEN','GE_BOPERSONAL.VALIDIDENTIFICATION','Obtener person id por identificacion','ADM_PERSON','PKG_BOPERSONAL.FNUGETPERSONIDPORIDENTIF',NULL,''	);
insert into homologacion_servicios values(	'OPEN','GE_BOPERSONAL.REGISTER','Registrar persona','ADM_PERSON','PKG_BOPERSONAL.PRREGISTRAPERSONA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAMO_PACKAGES.FBLEXISTS','Validar si una solicitud existe o no','ADM_PERSON','PKG_BCSOLICITUDES.FBLEXISTE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAMO_PACKAGES.FDTATTENTION_DATE','Consultar fecha de atencion de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FDTGETFECHAATENCION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAMO_PACKAGES.FDTREQUEST_DATE','Consultar fecha de registro de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FDTGETFECHAREGISTRO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAMO_PACKAGES.FNUADDRESS_ID','Consultar direccion de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FNUGETDIRECCION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAMO_PACKAGES.FNUMOTIVE_STATUS_ID','Consultar estado de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FNUGETESTADO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAMO_PACKAGES.FNUOPERATING_UNIT_ID','Consultar unidad operativa de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FNUGETUNIDADOPERATIVA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAMO_PACKAGES.FNUPACKAGE_TYPE_ID','Consultar tipo de solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FNUGETTIPOSOLICITUD',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAMO_PACKAGES.FNUPOS_OPER_UNIT_ID','Consultar punto de venta de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FNUGETPUNTOVENTA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAMO_PACKAGES.FNUSUBSCRIBER_ID','Consultar cliente de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FNUGETCLIENTE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAMO_PACKAGES.FNUSUBSCRIPTION_ID','Consultar contrato de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FNUGETCONTRATO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAMO_PACKAGES.FNUPRODUCT_ID','Consultar producto de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FNUGETPRODUCTO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAMO_MOTIVE.FNUPACKAGE_ID','Consultar solicitud de un motivo','ADM_PERSON','PKG_BCSOLICITUDES.FNUGETSOLICITUDDELMOTIVO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','MO_BCDETALLEANULSOLICITUD.FNUGETANNULPACK','Consultar solicitud de anulacion de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FNUGETSOLICITUDANULACION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','MO_BOCAUSAL.FNUGETSUCCESS','Constante con causal de éxito','PERSONALIZACIONES','PKG_GESTIONORDENES.CNUCAUSALEXITO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','MO_BOCAUSAL.FNUGETFAIL','Constante con causal de fallo','PERSONALIZACIONES','PKG_GESTIONORDENES.CNUCAUSALFALLO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OR_BOLEGALIZEORDER.FNUGETCURRENTORDER','Obtener orden de la instancia','ADM_PERSON','PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL',NULL,''	);
insert into homologacion_servicios values(	'OPEN','CT_BONOVELTY.FSBISNOVELTYORDER','Validar si una orden es de novedad o no','ADM_PERSON','PKG_BCORDENES.FBLOBTENERESNOVEDAD',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PR_BOCONSTANTS.FNUGETACTIVEPRODUCT','Constante estado de producto activo','PERSONALIZACIONES','PKG_GESTION_PRODUCTO.CNUESTADO_ACTIVO_PRODUCTO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','SETERRORDESC','Setear error con mensaje','ADM_PERSON','PKG_ERROR.SETERRORMESSAGE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','GI_BOERRORS.SETERRORCODEARGUMENT','Setear error con mensaje','ADM_PERSON','PKG_ERROR.SETERRORMESSAGE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','SA_BOUSER.FNUGETUSERID','Consultar id del usuario','ADM_PERSON','PKG_SESSION.GETUSERID',NULL,'Combina sa_bouser.fnuGetUserId(ut_session.getuser)'	);
insert into homologacion_servicios values(	'OPEN','UT_SESSION.GETUSER','Consultar mascara del usuario conectado','ADM_PERSON','PKG_SESSION.GETUSER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','UT_SESSION.GETIP','Consultar IP de la sesion','ADM_PERSON','PKG_SESSION.GETIP',NULL,''	);
insert into homologacion_servicios values(	'OPEN','UT_SESSION.GETPROGRAM','Consultar programa de la sesion','ADM_PERSON','PKG_SESSION.GETPROGRAM',NULL,''	);
insert into homologacion_servicios values(	'OPEN','UT_SESSION.GETMODULE','Consultar modulo de la sesion','ADM_PERSON','PKG_SESSION.FSBOBTENERMODULO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','UT_SESSION.GETSESSIONID','Consultar identificador de la sesion','ADM_PERSON','PKG_SESSION.FNUGETSESION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKCONSTANTE.TYREFCURSOR','Cursor referenciado','PERSONALIZACIONES','CONSTANTS_PER.TYREFCURSOR',NULL,''	);
insert into homologacion_servicios values(	'OPEN','MO_BOANNULMENT.ANNULWFPLAN','Anular plan de workflow','ADM_PERSON','PKGMANEJOSOLICITUDES.PANNULPLANWORKFLOW',NULL,'Mediante la solicitud se consulta el plan y se llama al servicio de anular plan del workflow'	);
insert into homologacion_servicios values(	'OPEN','DAAB_ADDRESS.FBLEXISTS','Validar si existe una direccion','ADM_PERSON','PKG_BCDIRECCIONES.FBLEXISTE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAAB_ADDRESS.FSBGETESTATE_NUMBER','Consultar el numero del predio de una direccion','ADM_PERSON','PKG_BCDIRECCIONES.FNUGETPREDIO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID','Consultar localidad de una direccion','ADM_PERSON','PKG_BCDIRECCIONES.FNUGETLOCALIDAD',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAAB_ADDRESS.FNUGETNEIGHBORTHOOD_ID','Consultar el barrio de una direccion','ADM_PERSON','PKG_BCDIRECCIONES.FNUGETBARRIO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAAB_ADDRESS.FSBGETADDRESS','Consultar la direccion','ADM_PERSON','PKG_BCDIRECCIONES.FSBGETDIRECCION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAAB_ADDRESS.FSBGETADDRESS_PARSED','Consultar la direccion parseada','ADM_PERSON','PKG_BCDIRECCIONES.FSBGETDIRECCIONPARSEADA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION','Consultar la descripcion de una localidad','ADM_PERSON','PKG_BCDIRECCIONES.FSBGETDESCRIPCIONUBICAGEO',NULL,''	);
insert into homologacion_servicios values(	'OPEN','DAAB_ADDRESS.FNUGETGEO_LOCA_FATHER_ID','Consultar la localidad padre de una localidad','ADM_PERSON','PKG_BCDIRECCIONES.FNUGETUBICAGEOPADRE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTLOCALITY','Consultar localidad de la direccion de instalacion de un producto','ADM_PERSON','PKG_BCPRODUCTO.FNUOBTENERLOCALIDAD',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_GETBRANCHBYADDRESS','Consultar Puntos de Pago Más Cercanos Usando Dirección','ADM_PERSON','API_GETBRANCHBYADDRESS',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_REGISTERREQUESTWITHXML','Registrar Solicitud a través de XML','ADM_PERSON','API_REGISTERREQUESTBYXML',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_GETBASICDATAORDER','Consultar Datos de una Orden','ADM_PERSON','API_GETBASICDATAORDER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_GETORDERBYPACKAGE','Consultar Órdenes Asociadas a una Solicitud','ADM_PERSON','API_GETORDERBYPACKAGE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_UPDITEMPATT','Registro / Actualización de Ítem Patrón','ADM_PERSON','API_UPDITEMPATT',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_REGVARSFACTCORRECC','Registrar Variables para los Factores de Corrección','ADM_PERSON','API_REGVARSFACTCORRECC',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_GETSUBSCRIPBALANCE','Obtener Infomación de los Saldos Pendientes Asociados al Contrato','ADM_PERSON','API_GETSUBSCRIPBALANCE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_REGISTERNEWCHARGE','Registrar Novedad de Liquidación a Contratista','ADM_PERSON','API_REGISTERNOVELTY',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_UPDPAIDCERTIF','Actualizar el Acta a Pagada','ADM_PERSON','API_UPDPAIDCERTIF',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_SUBSCRIPTIONREGISTER','Registro Nuevo Contrato por Medio de Sistema Externo','ADM_PERSON','API_SUBSCRIPTIONREGISTER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_QUERYPRODDEBTBYCONC','Obtener Deuda Detallada por Concepto','ADM_PERSON','API_QUERYPRODDEBTBYCONC',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_CHARGETOBILL','Registar Cobros por Facturar','ADM_PERSON','API_CREACARGOS',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_REGISTERBILLINGNOTE','Realizar Registro de Notas','ADM_PERSON','API_REGISTRANOTAYDETALLE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_ATTENDFINANREQUEST','Atender Solicitud de Financiación','ADM_PERSON','API_ATTENDFINANREQUEST',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_REGISTERDEBTFINANCING','Registrar Financiación de Deuda','ADM_PERSON','API_REGISTERDEBTFINANCING',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_SETCOMMERCIALSEGMENT','Almacenar Información de un Segmento Comercial','ADM_PERSON','API_SETCOMMERCIALSEGMENT',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_CUSTOMERREGISTER','Registrar Nuevos Clientes','ADM_PERSON','API_CUSTOMERREGISTER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_CUSTOMERUPDATE','Actualizar Datos del Cliente','ADM_PERSON','API_CUSTOMERUPDATE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_GETCUSTOMERDATA','Retornar Información del Cliente','ADM_PERSON','API_GETCUSTOMERDATA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_SETCUSTWORKDATA','Adicionar Información Laboral a un Cliente','ADM_PERSON','API_SETCUSTWORKDATA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_ADDREQUESTADDRESS','Asociar Dirección a Solicitud','ADM_PERSON','API_ADDREQUESTADDRESS',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_ACCEPT_ITEM','Aceptar Ítems en Transito','ADM_PERSON','API_ACCEPT_ITEM',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_GET_ITEM','Consultar información básica de un ítem','ADM_PERSON','API_GET_ITEM',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_GET_TRANSIT_ITEM','Obtener Ítems en Transito','ADM_PERSON','API_GET_TRANSIT_ITEM',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_UPDATE_ITEM','Actualizar Ítems','ADM_PERSON','API_UPDATE_ITEM',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_LOADACCEPT_ITEMS','Realizar Carga y Aceptación de Ítems','ADM_PERSON','API_LOADACCEPT_ITEMS',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_REJECT_ITEM','Rechazar Ítems en Transito','ADM_PERSON','API_REJECT_ITEM',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_SET_NEWITEM','Registrar un nuevo ítem','ADM_PERSON','API_SET_NEWITEM',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_ADDORDERCOMMENT','Registrar Comentario a Órdenes','ADM_PERSON','API_ADDORDERCOMMENT',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_CREATEORDERACTIVITIES','Crear Órdenes de Trabajo','ADM_PERSON','API_CREATEORDER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_ASSIGN_ORDER','Asignar Orden de Trabajo','ADM_PERSON','API_ASSIGN_ORDER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_LOCKORDER','Bloquear Orden de Trabajo','ADM_PERSON','API_LOCKORDER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_RELATED_ORDER','Asociar Orden de Trabajo con Otra Orden','ADM_PERSON','API_RELATED_ORDER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_UNLOCKORDER','Desbloquear Orden de Trabajo','ADM_PERSON','API_UNLOCKORDER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_GETCUSTUSERSBYPROD','Consultar Información de Usuarios Asociados a un Producto','ADM_PERSON','API_GETCUSTUSERSBYPROD',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_GETPRODUCTDATA','Obtener Datos de Producto de Acuerdo a Criterios','ADM_PERSON','API_GETPRODUCTDATA',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_REGISTER_NTL','Registrar Posible Pérdida','ADM_PERSON','API_REGISTER_NTL',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_LOADFILETOREADING','Cargar Archivo a una Lectura','ADM_PERSON','API_LOADFILETOREADING',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_ADDITEMSORDER','Adicionar Ítems a Una Orden','ADM_PERSON','API_ADDITEMSORDER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_LEGALIZEORDERALLACTIVITIES','Legalizar orden de trabajo con todas sus actividades','ADM_PERSON','API_LEGALIZEORDERS',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_LEGALIZEORDERS','Legalizar Orden de Trabajo','ADM_PERSON','API_LEGALIZEORDERS',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_UPDINFOPREMISE','Modificar Datos Adicionales a un Predio','ADM_PERSON','API_UPDINFOPREMISE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_GETPERIODREVMAXDATE','Consultar Fecha Estimada de la Revisión Periódica','ADM_PERSON','API_GETPERIODREVMAXDATE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_BALANCETOPAY','Consultar Saldos Pendientes de Pago','ADM_PERSON','API_BALANCETOPAY',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_PAYMENTSQUERY','Consultar Histórico de Pagos','ADM_PERSON','API_PAYMENTSQUERY',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_COUPONGENERATION','Generar Cupón desde XML','ADM_PERSON','API_COUPONGENERATION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_PAYMENTSREGISTER','Registrar Pagos','ADM_PERSON','API_PAYMENTSREGISTER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_SET_REQUEST_CONF','Confirmar Solicitud','ADM_PERSON','API_SET_REQUEST_CONF',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_GET_REQUEST','Obtener Solicitudes Registradas','ADM_PERSON','API_GET_REQUEST',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_GET_REQUESTS_REG','Obtener Datos de la Solicitud','ADM_PERSON','API_GET_REQUESTS_REG',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_REGTELEMEASCONSUMPTION','Registrar Consumos Telemedidos','ADM_PERSON','API_REGTELEMEASCONSUMPTION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_UPDTELEMEASCONSUMPTION','Actualizar Información de Consumos Telemedidos','ADM_PERSON','API_UPDTELEMEASCONSUMPTION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OR_BOANULLORDER.ANULLORDERWITHOUTVAL','Anular Orden de Trabajo','ADM_PERSON','API_ANULLORDER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OR_BOORDERCOMMENT.ADDCOMMENT','Registrar Comentario a Órdenes','ADM_PERSON','API_ADDORDERCOMMENT',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKERRORS.SETAPPLICATION','Setear aplicacion que se esta ejecutando','ADM_PERSON','PKG_ERROR.SETAPPLICATION',NULL,''	);
insert into homologacion_servicios values(	'OPEN','GW_BOERRORS.CHECKERROR','Setear Error','ADM_PERSON','PKG_ERROR.SETERRORMESSAGE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','CM_BOORDERSUTIL.FNUGENERATE','Crear Órdenes de Trabajo','ADM_PERSON','API_CREATEORDER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_PEPRODSUITRCONNECTN','','ADM_PERSON','API_PEPRODSUITRCONNECTN',NULL,''	);
insert into homologacion_servicios values(	'OPEN','OS_PEGENCONTRACTOBLIGAT','genera actas a contratista','ADM_PERSON','API_PEGENCONTRACTOBLIGAT',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKBILLINGNOTEMGR.CREATEBILLINGNOTE','Crea notas de facturación y detalle','ADM_PERSON','API_REGISTRANOTAYDETALLE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','FA_BOBILLINGNOTES.DETAILREGISTER','Crea notas de facturación y detalle','ADM_PERSON','API_REGISTRANOTAYDETALLE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','ERRORS.INITIALIZE','Inicializa errores','ADM_PERSON','PKG_ERROR.INITIALIZE',NULL,''	);
insert into homologacion_servicios values(	'OPEN','PKG_SESSION.GETUSER','Retorna nombre de usuario conectado','ADM_PERSON','PKG_SESSION.GETUSER',NULL,''	);
insert into homologacion_servicios values(	'OPEN','SA_BOUSER.FNUGETUSERID(UT_SESSION.GETUSER)','Retorna id de usuario conectado','ADM_PERSON','PKG_SESSION.GETUSERID',NULL,''	);
  commit;
end if;

  dbms_output.put_line('Insertados datos en HOMOLOGACION_SERVICIOS ');

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/