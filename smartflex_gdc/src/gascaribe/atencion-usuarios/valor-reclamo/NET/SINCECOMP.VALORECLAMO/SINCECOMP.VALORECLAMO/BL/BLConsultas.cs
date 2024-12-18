using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.VALORECLAMO.BL
{
    class BLConsultas
    {
        #region A

        public static String ActualizarSolicitudReclamo = "LDC_PKVALORESRECLAMO.ProActualizainteraccion";

        /// <summary>
        /// Aparece en: LDVALREC, LDSUBSI, LDRECUS;
        /// Listado de los combos de las areas;
        /// Devuelve: ID, Descripción;
        /// Tablas: ld_article
        /// </summary>
        public static String AreasCausante = "select distinct p.causing_area_id ID, t.name_ Descripción from open.ps_package_areas p, open.GE_ORGANIZAT_AREA t where p.causing_area_id = t.organizat_area_id and p.causal_id = &causal&";

        /// <summary>
        /// Aparece en: LDVALREC, LDSUBSI, LDRECUS;
        /// Listado de los combos de las areas;
        /// Devuelve: ID, Descripción;
        /// Tablas: ld_article
        /// </summary>
        public static String AreasGestiona = "select distinct p.management_area_id ID, t.name_ Descripción from open.ps_package_areas p, open.GE_ORGANIZAT_AREA t where p.management_area_id = t.organizat_area_id and p.causing_area_id = &causante&";

        /// <summary>
        /// Aparece en: LDVALREC, LDSUBSI, LDRECUS;
        /// Areas de las Causales 
        /// </summary>
        public static String AreasCausales = "PS_BOListOfValues.GetCausingAreas";

        #endregion

        #region C

        /// <summary>
        /// Aparece en: LDVALREC, LDSUBSI, LDRECUS;
        /// Cargos asociados a la factura de un Contrato
        /// </summary>
        public static String CargosFacturas = "LDC_PKVALORESRECLAMO.getdatoscargos";

        /// <summary>
        /// Aparece en: LDRECUS;
        /// Listado de Cargos de los Reclamos de Solicitudes;
        /// Devuelve: Codigo, Descripcion;
        /// Observación: Diseñada para reemplazar el numero del contrato &reclamo&
        /// </summary>
        public static String CargosReclamo = "LDC_PKVALORESRECURSOSREPO.GetDatossolictud";
        //"select cucocodi, reproduct, reconcep || ' - ' || concdesc concepto, resbsig, valorcargo, recaucar, redocsop, recodosop, revaloreca, factcodi, reano, remes, resalpen, date_gencodi, revaltotal  from ldc_reclamos, concepto where Conccodi = reconcep and package_id = &reclamo& order by cucocodi, reano, remes";

        /// <summary>
        /// Aparece en: LDSUBSI;
        /// Listado de Cargos de los Reclamos de Solicitudes de Subsidio;
        /// Devuelve: Codigo, Descripcion;
        /// Observación: Diseñada para reemplazar el numero del contrato &reclamo&
        /// </summary>
        public static String CargosReclamoSubsidio = "LDC_pkrecursosreposubsape.GetDatossolictud";
        //"select cucocodi, reproduct, reconcep || ' - ' || concdesc concepto, resbsig, valorcargo, recaucar, redocsop, recodosop, revaloreca, factcodi, reano, remes, resalpen, date_gencodi, revaltotal  from ldc_reclamos, concepto where Conccodi = reconcep and PACKAGE_ID_RECU = &reclamo& order by cucocodi, reano, remes";

        /// <summary>
        /// Aparece en: LDVALREC;
        /// Listado de las Causales para Combos;
        /// Devuelve: Codigo, Descripcion;
        /// Tablas: cc_causal
        /// </summary>
        ///15.08.17 se cambio la consulta de las causales 
        ///public static String CausalesReclamo = "SELECT causal_id id, description FROM CC_CAUSAL cc WHERE causal_type_id in (select nvl(to_number(column_value), 0) from table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('TIPO_CAUSAL_FNB_DEUDOR',NULL),',')))  order by causal_id";
        public static String CausalesReclamo = "SELECT distinct cc.causal_id id, cc.description FROM CC_CAUSAL cc, ps_package_activities p WHERE cc.causal_id = p.causal_id and p.package_type_id = 100335 ORDER BY cc.description";

        /// <summary>
        /// Aparece en: LDRECUS;
        /// Listado de las Causales para Combos;
        /// Devuelve: Codigo, Descripcion;
        /// Tablas: cc_causal
        /// </summary>
        public static String CausalesReclamoReposicion = "SELECT distinct cc.causal_id id, cc.description FROM CC_CAUSAL cc, ps_package_activities p WHERE cc.causal_id = p.causal_id and p.package_type_id = 100337 ORDER BY cc.description";

        /// <summary>
        /// Aparece en: LDSUBSI;
        /// Listado de las Causales para Combos;
        /// Devuelve: Codigo, Descripcion;
        /// Tablas: cc_causal
        /// </summary>
        public static String CausalesReclamoApelacion = "SELECT distinct cc.causal_id id, cc.description FROM CC_CAUSAL cc, ps_package_activities p WHERE cc.causal_id = p.causal_id and p.package_type_id = 100338 ORDER BY cc.description";

        /// <summary>
        /// Aparece en: LDVALREC, LDSUBSI, LDRECUS;
        /// Define que conceptos son Subsidios
        /// Si es un Concepto de Subsidio retornara un 1, en cualquier otro caso otro valor
        /// </summary>
        public static String ConceptosdeConsumo = "LDC_PKVALORESRECLAMO.FNUGETVALCONCSUBS";

        /// <summary>
        /// Aparece en: LDVALREC, LDSUBSI, LDRECUS;
        /// Conceptos obligatorios cuando se marcan para el reclamo
        /// </summary>
        public static String ConceptosObligatorioValor = "LDC_PKVALORESRECLAMO.FNVCONCEPTOOBLIGATORIO";

        #endregion

        #region E

        public static String eliminarAnexos = "LDC_PKVALORESRECLAMO.proDelFile";

        /// <summary>
        /// Aparece en LDRECUS, LDSUBSI Y LDVALREC
        /// Determina los conceptos que no pueden ser reclamados y evitar que se agreguen al reclamo
        /// </summary>
        public static String excluyeconcepto = "LDC_PKVALORESRECLAMO.FNVEXCLUYECONCEPTO";

        /// <summary>
        /// Aparece en LDRECUS, LDSUBSI Y LDVALREC
        /// Determina las causales que no pueden ser reclamados y evitar que se agreguen al reclamo
        /// </summary>
        public static String excluyecausal = "LDC_PKVALORESRECLAMO.FNVEXCLUYECAUSAL";

        /// <summary>
        /// Aparece en LDVALREC
        /// Eliminar Registros del Reclamo con Repuesta inmediata
        /// </summary>
        public static String EliminarConRespuestaInmediata = "LDC_PKVALORESRECLAMO.proDelreclamos";

        #endregion

        #region F

        /// <summary>
        /// Aparece en: LDVALREC, LDSUBSI, LDRECUS;
        /// Facturas asociadas a un Contrato
        /// </summary>
        public static String FacturasRegistradas = "LDC_PKVALORESRECLAMO.getdatoscuentas";

        #endregion

        #region F

        /// <summary>
        /// Aparece en: LDVALREC, LDSUBSI, LDRECUS;
        /// Respuesta Inmediata
        /// </summary>
        public static String RespuestaInmediata = "LDC_PKVALORESRECLAMO.GetAnswer";

        #endregion

        #region M

        /// <summary>
        /// Aparece en: LDVALREC, LDSUBSI, LDRECUS;
        /// Medio de Recepcion
        /// </summary>
        public static String MedioRecepcion = "LDC_PKVALORESRECLAMO.GetReceptiontype";//"select reception_type_id CODIGO, description DESCRIPCION from GE_RECEPTION_TYPE t order by reception_type_id";

        #endregion

        #region R

        public static String reclamosCursor = "LDC_PKVALORESRECLAMO.GetCursorReclamo";

        public static String registerAnexos = "LDC_PKVALORESRECLAMO.proUpdFile";

        #endregion

        #region S

        /// <summary>
        /// Aparece en: LDVALREC, LDSUBSI, LDRECUS;
        /// Descripcion de los signos
        /// </summary>
        public static String signoDescripcion = "select signdesc from signo where signcodi = '&signo&'";

        /// <summary>
        /// Aparece en: LDRECUS;
        /// Listado de Solicitudes de reclamo aplicados a un contrato;
        /// Devuelve: Codigo, Descripcion;
        /// Observación: Diseñada para reemplazar el numero del contrato &subscripcion&
        /// </summary>
        //public static String SolicitudesReclamo = "select ldc_reclamos.package_id as CODIGO, ps_package_type.description as DESCRIPCION from servsusc, ldc_reclamos, mo_packages, ps_package_type where reproduct = sesunuse and sesususc = &subscripcion& and mo_packages.package_id = ldc_reclamos.package_id and ps_package_type.package_type_id = mo_packages.package_type_id group by ldc_reclamos.package_id, ps_package_type.description order by ldc_reclamos.package_id";
        public static String SolicitudesReclamo = "LDC_PKVALORESRECLAMO.GetDatosSolictud";

        /// <summary>
        /// Aparece en: LDSUBSI;
        /// Listado de Solicitudes de reclamo aplicados a un contrato;
        /// Devuelve: Codigo, Descripcion;
        /// Observación: Diseñada para reemplazar el numero del contrato &subscripcion&
        /// </summary>
        //public static String SolicitudesReclamoSubsidio = "select ldc_reclamos.package_id_RECU as CODIGO, ps_package_type.description as DESCRIPCION from servsusc, ldc_reclamos, mo_packages, ps_package_type where reproduct = sesunuse and sesususc = &subscripcion& and mo_packages.package_id = ldc_reclamos.package_id_RECU and ps_package_type.package_type_id = mo_packages.package_type_id group by ldc_reclamos.package_id_RECU , ps_package_type.description order by ldc_reclamos.package_id_RECU";
        public static String SolicitudesReclamoSubsidio = "LDC_PKVALORESRECLAMO.GetDatosSolictudApela";

        public static String SoporteInteraccion = "LDC_PKVALORESRECLAMO.GetInteraccion";

        #endregion

        #region T

        /// <summary>
        /// Aparece en: LDVALREC, LDSUBSI, LDRECUS;
        /// Listado de los Tipos de Documentos;
        /// Devuelve: Codigo, Descripcion;
        /// Tablas: ge_identifica_type
        /// </summary>
        public static String TipoDocumentoC = "select to_char(ident_type_id) Codigo, to_char(description) Descripcion from ge_identifica_type";

        #endregion

        #region U

        /// <summary>
        /// Aparece en: LDVALREC, LDSUBSI, LDRECUS;
        /// Actualiza los medios de recepcion del reclamo registrado;
        /// </summary>
        public static String UpdateReceptionType = "LDC_PKVALORESRECLAMO.ProActualizaReceptionType";

        #endregion

        #region V

        /// <summary>
        /// Aparece en: LDVALREC, LDSUBSI, LDRECUS;
        /// Cargos asociados a la factura de un Contrato
        /// </summary>
        public static String ValorAbonado = "LDC_PKVALORESRECLAMO.FNUGETVALABOCC";

        /// <summary>
        /// Aparece en: LDSUBSI, LDRECUS;
        /// Muestra los valores no reclamados en una solicitud
        /// </summary>
        public static String ValoresNoReclamados = "LDC_PKVALORESRECLAMO.GetCargosNoValre";

        /// <summary>
        /// Aparece en: frm_proyectar;
        /// Valores Pendientes de una factura
        /// </summary>
        public static String ValorPendiente = "LDC_PKVALORESRECLAMO.FNUGETCUCOSACU";

        #endregion

    }
}

