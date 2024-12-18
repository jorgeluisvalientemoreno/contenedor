#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : FIFAP
 * Descripcion   : Financiación de Articulos de Proveedor
 * Autor         : Sidecom
 * Fecha         : -
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 
 * 
 * 29-Nov-2013  225385  hjgomez         Se cambia la grilla de validacion de cedula por un ultragrid para que
 *                                      no se permita modificar
 * 20-Nov-2013  223765  SGomez          1 - Se modifica forma de obtención de secuencia para pagaré digital. 
 *                                          Ahora se invoca modelo de numeración autorizada / distribución
 *                                          consecutivos y se utiliza el parámetro <VOUCHER_TYPE_DIGITAL_PROM_NOTE>
 *                                          para identificar el tipo de comprobante de pagaré digital.
 * 
 * 15-Nov-2013  223401  LDiuza         1 - Se modifica el proceso de calculo de valores totales para solucionar errores relacionados
 *                                         con proceso de union y traslado.
 * 29-Oct-2013  221194  LDiuza         1 - Se modifican los metodos <loadData> y <obArticle_Click> para implementacion de funcionalidad
 *                                          cupo extra.
 * 21-Oct-2013  220742  LDiuza         1 - Se activa el evento <BeforePerformAction> asociando el metodo <ogArticles_BeforePerformAction>
 * 15-Oct-2013  219648  LDiuza         1 - Se crea metodo <GetPendTransfQuota> usado para definir el monto pendiente por transferir
 *                                         luego de hacer uso de cupo extra.
 *                                     2 - Se modifica el metodo <obArticle_Click> para verificar si existe monto a transferir antes de
 *                                         abrir la funcionalidad de Union y Translado.
 * 11-Oct-2013  220010  jrobayo        1 - Se habilita el llamado al evento del componente oabCosignerAddress
 *                                     2 - Se garantiza que al ingresar un contrato para la búsqueda de datos del codeudor, la
 *                                         identificación no sea modificable en el evento <ostbCosignerIdentification_TextBoxValueChanged>.
 * 10-Oct-2013  219290  jrobayo        1 - Se modifica el evento del botón openButton1_Click para garantizar que la identificación
 *                                         ingresada en la consulta a DataCrédito sea la misma para la cual se registrará la venta
 *                                         como deudor.
 *                                     2 - Se realiza cambio en el campo identificación del titular, para que no sea modificada.
 *                                     3 - Se realiza el cambio de posición del campo correspondiente a la identificación del 
 *                                         deudor y del codeudor.
 * 08-Oct-2013  219165  LDiuza         1 - Se modifica el metodo <ogArticles_AfterCellUpdate> para asignar el identificador
 *                                         del articulo en su respectiva celda cuando se escoga un item diferente en la lista
 *                                         de articulos.
 * 27-Sep-2013  217871  jcarrillo      1 - <ogArticles_BeforePerformAction> Se adiciona el método para permitir la 
 *                                         busqueda de articulos por código
 * 27-Sep-2013  217614  lfernandez     1 - <loadData> Se elimina asignación al valor del pago inicial el valo mínimo de
 *                                         pago cuando no es gran superficie
 *                                     2 - <obDeudor_Click> Se adiciona condición que pase a la pestaña de codeudor si
 *                                         hay transferencia de cupo
 *                                     3 - <obRegister_Click> Se registra el cupo extra independiente si hubo
 *                                         transferencia de cupo
 *                                     4 - <obSaveSaleDate_Click> Se elimina validación del valor de la cuota inicial
 *                                     5 - <obArticle_Click> Para mostrar el mensaje de pregunta de traslado se
 *                                         reemplaza uso de messageBox por ExceptionHandler. Se le envía a FIUTC los
 *                                         artículos y los cupos extra para que esta haga la distribución de los cupos
 *                                         extra sobre los artículos
 *                                     6 - <ogArticles_AfterCellUpdate> Se asigna a validateValueUnits verdadero cuando
 *                                         entra al método como falso porque no se estaba asignando a verdadero. Cuando
 *                                         hay transferencia de cupo también se le asigna al bindingSource el artículo
 *                                         ingresado
 *                                     7 - <GetExtraQuote> Se pasa método a BLFIFAP
 *                                     8 - <validateExtraQuota> Ahora se llama a GetExtraQuote que está en BLFIFAP y se
 *                                         elimina asingación a falso para permitir transferencia de cupo
 *                                     9 - <ostbCosignerBirthDate_Leave> Se adiciona condición que valide cuando el
 *                                         campo no sea nulo
 *                                     10 - <SetBillSlope> Se adiciona método para asignar la factura pendiente y
 *                                          deshabilitar el campo entrega en punto si tiene factura pendiente
 * 25-Sep-2013  217737  lfernandez     1 - <loadData> Se elimina llamado a loadDeudorData, ya que el evento de cambio
 *                                         en el check de uceBillHolder lo hace internamente
 *                                     2 - <uceBillHolder_CheckedChanged> Se reemplaza validación del campo
 *                                         CheckedValue por Checked, no se envía parámetro a loadDeudorData y se le
 *                                         envía true a ClearDebtorInfo para que limpie el tipo de identificación y la
 *                                         identificación
 *                                     3 - <ClearDebtorInfo> Se adiciona parámetro para saber si debe limpiar el tipo
 *                                         de identificación y la identificación
 *                                     4 - <loadDeudorData> Se elimina parámetro ya que todos los que lo llamaban le
 *                                         enviaban true
 *                                     5 - <chargePromissoryDeudor> Se le envía true a ClearDebtorInfo para que limpie
 *                                         el tipo de identificación y la identificación en el if y se le envía false
 *                                         en el else
 *                                     6 - <obRegister_Click> Se le envía el cliente a RegisterDeudor
 * 24-Sep-2013  217585  lfernandez     1 - <loadData> Se carga la información del deudor sin depender del parámetro
 *                                         VALI_TITU_VENT, se asigna campo chequeado a uceBillHolder y el estrato y la
 *                                         dirección se fijan de solo lectura
 *                                     2 - <ClearDebtorInfo> Se asigna a la dirección la dirección del contrato y al
 *                                         estrato la subcategoría del contrato
 *                                     3 - <loadDeudorData> Se elimina asignación de solo lectura a la dirección y al
 *                                         estrato ya que siempre están como solo lectura
 * 16-Sep-2013  217227  jsflorez       1 - <ogArticles_AfterCellUpdate> Para los articulos del proveedor establecido 
 *                                         en el parametro 'CODI_CUAD_EXITO' se fija el campo cantidad como no editable
 * 10-Sep-2013  216757  lfernandez     1 - <ogArticles_AfterCellUpdate> Se asignan los valores por defecto
 *                                         cuando se adiciona/actualiza una fila
 * 10-Sep-2013  216609  lfernandez     1 - <SetFIHOSArticles> Se adiciona llamado a la instrucción 
 *                                         ogArticles.DataBind
 * 09-Sep-2013  216609  lfernandez     1 - <ogArticles_AfterCellUpdate> Se adciona manejo de la variable
 *                                         validateValueUnits: Cuando se devuelve el valor de la celda al
 *                                         valor original se establece en falso, para que no se quede en un
 *                                         loop infinito
 *                                     2 - <SetFIHOSArticles> Se establece como no activo el valor si no se
 *                                         puede modificar
 * 09-Sep-2013  213877  LDiuza         1 - Se modifica el metodo <opcChanelSale_ValueChanged> para que no haga cambios.
 *                                          automaticos la escoger el canal de venta "Rutero/PAP".
 *                                     2 - Se modifica el metodo <obSaveSaleDate_Click> para validar que no permita escoger
 *                                          el tipo de pagare Digital y el canal de venta "Rutero/PAP"
 * 07-Sep-2013  212252  mmira          1 - <ogArticles_AfterCellUpdate> Se modifica para conservar valores y cantidades
 *                                      cuando se cancela el proceso de unión/traslado de cupo.
 * 07-09-2013   ADICIO  llopez         1 - Se modifica el evento clic (openButton1_Click) del botón consultar de 
 *                                         la segunda pestaña para mostrar la información de DataCredito luego de 
 *                                         ejecutar el plug-in de validación de DataCredito.
 * 06-Sep-2013  214235  lfernandez     1 - <ogArticles_AfterCellUpdate> Copia la descripción del artículo a
 *                                         la lista, ya que cuando se selecciona en la grilla se actualiza
 *                                         por el código del artículo
 * 05-Sep-2013  212246  lfernandez     1 - <articleAlreadySel> Se adiciona método para validar si el artículo ya
 *                                         está en la lista
 *                                     2 - <SetFIHOSArticles> Se adiciona método para establecer desde FIHOS la lista
 *                                         de artículos seleccionados
 * 05-Sep-2013  214195  mmira          1 - <obRegister_Click> Se invierten las fechas enviadas como fecha de venta 
 *                                          y fecha de solicitud.
 *                                     2 - <obSaveSaleDate_Click> Se obtiene la lista de artículos con la fecha de venta 
 * 24-Jun-2013  213462  jaricapa       1 - Se implementa Pago de Contado.
 * 03-Sep-2013  214114  lfernandez     1 - <GetSafeTotalValue> Se adiciona método
 *                                     2 - <obArticle_Click> Se calcula el valor de la cuota mensual con la
 *                                         función pmt y el valor del seguro con GetSafeTotalValue
 * 24-Jun-2013  211812  jaricapa       1 - Se inicializan los campos de codeudor al ingresar el contrato. 
 *                                     2 - Si el contrato no existe, muestra error.
 * 31-Ago-2013  211811  lfernandez     1 - <obArticle_Click> Se corrige cálculo de la cuota mensual y cuota
 *                                         mensual seguro, se convierte porcentaje a nominal
 * 31-Ago-2013  214523  lfernandez     1 - <ocArticle> Se modifica para que no sea de tipo UltraDropDown sino
 *                                         OpenGridDropDow
 *                                     2 - <DropDownListsMaker> Se adiciona método para crear lista de valores
 *                                     3 - <obSaveSaleDate_Click> Se modifica la forma de crear la lista de 
 *                                         valores para ocArticle llamando a DropDownListsMaker
 *                                     4 - <ocArticle_RowSelected> Se pasa la lógica a 
 *                                         ogArticles_AfterCellUpdate y sólo se obtiene el artículo
 *                                         seleccionado
 *                                     5 - <ocArticle_ItemNotInList> Se elimina método
 *                                     6 - <ogArticles_AfterCellUpdate> Se adiciona lógica para cuando se
 *                                         modifica la celda ArticleIdDescription
 *                                     7 - <ogArticles_AfterCellListCloseUp> Se elimina método
 *                                     8 - <ogArticles_InitializeLayout> Se elimina método
 *                                     9 - <ogArticles_BeforePerformAction> Se elimina método
 *                                     10 - <ogArticles_Error> Se adiciona evento
 *                                     11 - <ogArticles_Layout> Se elimina método
 * 30-Ago-2013  211609  lfernandez     1 - <ostbBillDate2_Leave> Sólo se llama a validateBill si el valor del
 *                                         campo cambia y no es nulo
 *                                     2 - <ostbBillId2_Leave> Sólo se llama a validateBill si el valor del
 *                                         campo cambia y no es nulo
 *                                     3 - <ostbBillId1_Leave> Sólo se llama a validateBill si el valor del
 *                                         campo cambia y no es nulo
 *                                     4 - <ostbBillDate1_Leave> Sólo se llama a validateBill si el valor del
 *                                         campo cambia y no es nulo
 *                                     5 - <validateBill> Se envía a validateBill el valor de los campos 
 *                                         respetando si son nulos
 * 30-Ago-2013  215374  jaricapa       1 - Se modifica «obRegister_Click» validando el resultado de la actualización de datos en ge_subscriber.
 * 29-Ago-2013  214417  jaricapa       1 - Se actualiza el tamaño de los campos.
 * 29-Ago-2013  211609  lfernandez     1 - <validateBill> Se modifica para mostrar mensajes de error cuando
 *                                         los valores ingresados en las facturas son inválidos
 * 28-Ago-2013  211794  jaricapa       1 - Se utiliza el cupo extra al vender un artículo.
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.BL;
using SINCECOMP.FNB.DAL;
using SINCECOMP.FNB.Controls;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.ExceptionHandler;
using System.Net;
using System.IO;
using System.CodeDom;
using System.CodeDom.Compiler;
using System.Web.Services;
using System.Web.Services.Description;
using System.Xml.Serialization;
using System.Reflection;
using System.Xml;
using Infragistics.Win;
using System.Collections;
using OpenSystems.Common.Util;
using OpenSystems.Common.ComponentModel.Extended;
using Microsoft.Reporting.WinForms;
using OpenSystems.ExtractAndMix.Api;
using OpenSystems.Report;
using OpenSystems.Common.Data;
using System.Data.Common;
using System.Text.RegularExpressions;
using System.Threading;

namespace SINCECOMP.FNB.UI
{
    /// <summary>
    /// Financiación de Articulos de Proveedor
    /// </summary>
    public partial class LDCSPU : OpenForm
    {
        #region DatosPrivados

        private static DALLDCSPU _DALLDCSPU = new DALLDCSPU();
       
        private static DataFIFAP _dataFIFAP = new DataFIFAP();
        private static Promissory _promissoryDeudor = new Promissory();
        private static Promissory Cosigner = new Promissory();
        private static Boolean ValidaCodeudor;
        private static BLFIFAP _blFIFAP = new BLFIFAP();
        private static List<ListOfVal> PromissoryList = new List<ListOfVal>();
        private static List<ListOfVal> GenderList = new List<ListOfVal>();
        private static List<ListOfVal> HolderRelation = new List<ListOfVal>();
        private ctrlLaborInfo cliDeudorInfo = new ctrlLaborInfo();
        private ctrlReference crDeudorInfo = new ctrlReference();
        private ctrlLaborInfo cliCosignerInfo = new ctrlLaborInfo();
        private ctrlReference crCosignerInfo = new ctrlReference();
        private List<ArticleValue> _articleLOV = new List<ArticleValue>();
        private List<String> _articleDescription = new List<String>();
        private static Int64? _digitalPromisoryId;
        private MethodInfo[] methodInfo;
        private ParameterInfo[] param;
        private Type service;
        private Type[] paramTypes;
        private string finanServ = "";
        private string MethodName = "";
        private string SdName = "";
        private string operat = "";
        private string resultado = "";
        private Double totalTransfer = 0;
        private Int64 _subscriptionId;
        FIUTC frm;
        Boolean haveParcial;
        private String[] parcialLine;
        private String parcialLineDescription;
        public Int64 billSlope;
        private String autoTransfer;
        private String selectPointSale;
        private Int64 doorTodoorChanel;
        private Int64 callCenterChanel;
        private Int64 OrderTransferId;
        private List<ExtraQuote> _extraQuota;

        private String oldCosignerSubsc = String.Empty;
        private String oldCosignerTypeId = String.Empty;
        private String oldCosignerIdent = String.Empty;

        private Int64? bill1;
        private Int64? bill2;
        private DateTime? genDate1;
        private DateTime? genDate2;
        private String typeUser;
        private String osbCommercialSegm;
        private Int64 onuSegmentId;

        BLGENERAL general = new BLGENERAL();

        Boolean correcto = true;
        Boolean blRegisterCosigner = false;
        private Int64? resConsId = null;

        private OpenGridDropDown ocArticle = null;
        private ArticleValue articleValue = null;

        private Double? intiPaymentTmp = null;

        /// <summary>
        /// Indica si el pago es de contado.
        /// </summary>
        private bool isCashPayment = false;
        private Double? usedValExtraQuota = 0;

        private bool validateValueUnits = true;
        private List<TransferQuota> lstTransQuota = new List<TransferQuota>();

        String updCosignerName;
        String updDebtorName;
        bool VALI_TITU_VENT = false;

        private List<OpenPropertyByControlBase> SublinesAppliedToPartialQuota;
        private double TotalSale;

        //KCienfuegos.RNP1179 14-10-2014
        private int nuGasAppliance = 0;

        /*Llozada [RQ 1218]: Se usa para validar cuando es valido el Codeudor*/
        private Boolean blValidCosigner = true;

        /*Llozada [RQ 1218]: Es para valida que no genere error la causal de deudor solidario*/
        private int nuErrorDeudorSol = 0;

        Double yearsParameter = 0;
        int years;

        bool ValidInvoices = false; //4820
        bool blValFactOpc = false;

        /*jhinestroza [3743]*/
        String chanelSale = "";

        /*jhinestroza [3821,3822,3823]: indica si las cadenas son similares o no*/
        bool cambioId = false;
        /*jhinestroza [3821,3822,3823]: Se usa para validar si hubo cambio en el nombre del titular del contrato*/
        bool cambioNombre = false;
        /*jhinestroza [3821,3822,3823]: varibales para validar que contiene VALI_TITU_VENT en la Base de datos*/
        String sbYes = "Y";
        String sbNo = "N";
        Int64 porcenTolerancia;
        String cadena_A;
        String cadena_B;
        double numCaracteres;     // edwardh: se usa si la validacion se requiere por numero de caracteres
        double porcenSimilaridad; // edwardh: se usa si la validacion se requiere por porcentaje (%)
        bool ventaTitular = false;// edwardh: Flag para validar que tipo de venta se esta realizando cuando Valitituven = N
        bool cargarDataTitular = false;// edwardh: Flag para validar que datos tiene que consultar (titular o inquilino)

        Boolean DeudorRollover = false; /* HAltamiranda: Variable que indica si el Deudor es Rollover */

        /* [03/08/2015] edwardh [SAO.334390 Cuota Fija]*/
        bool FLAG_VISUALIZAR_PLN_FIN = false;
        String sbCuotaFija = "V"; // Por defecto la variable esta en V, quiere decir que tomara tasa variable

        //Agordillo Caso.6853 04-10-2015
        IFIFAP ififap_;


        //Incioi Variable CASO 200-85
        bool cambioNombreCodeudor = false;
        bool cambioApellidoCodeudor = false;
        bool cambioIdentificacionCodeudor = false;
        Boolean BLAplicaParaGDC = false;
        Boolean BLAplicaParaEfigas = false;
        String isbIdentification_old;
        String isbIdentification_new;
        Int64 onuSubscriberId_old;
        Int64 onuSubscriberId_new;
        Int64 onuCodigoError;
        String osbMensajeError;
        Boolean BLActualizaCODEUDOR = false;
        //Fin Variable CASO 200-85

        //Inicio Variables CASO 200-1880
        Double DeudoryearsParameter = 0;
        int Deudoryears;
        //Fin Variables CASO 200-1880

        #endregion

        #region Inicialización

        public LDCSPU(Int64 subscriptionId, DataFIFAP dataFifap)
        {
            InitializeComponent();
            _digitalPromisoryId = null;
            _dataFIFAP = dataFifap;
            //formulario FIUTC            
            _subscriptionId = subscriptionId;
            frm = new FIUTC(_subscriptionId, 0);
                    

            if (!frm.correcto)
                correcto = false;
            updCosignerName = general.getParam("UPDATE_COSIGNER_NAME", "String").ToString();
            updDebtorName = Convert.ToString(general.getParam("UPDATE_DEBTOR_NAME", "String"));
            //LISTADO DE TIPOS DE DOCUMENTOS
            cbTypeDocument.DataSource = general.getValueList(BLConsultas.TiposDocumentos);
            cbTypeDocument.DisplayMember = "Descripcion";
            cbTypeDocument.ValueMember = "Codigo";
            //
            oabCosignerAddress.Required = 'Y';
            oabDeudorAddress.Required = 'Y';
            //PARAMETRO FINANCIER_SERV

            autoTransfer = general.getParam("TRANSFER_QUOTA_AUTO", "String").ToString();

            doorTodoorChanel = Int64.Parse(general.getParam("SALE_DODO", "Int64").ToString());
            callCenterChanel = Int64.Parse(general.getParam("SALE_CALL_CENT", "Int64").ToString());
            selectPointSale = general.getParam("SELECCIONA_SUCURSAL","String").ToString();

            try
            {
                finanServ = general.getParam("FINANCIER_SERV", "String").ToString(); //_blFIFAP.getParam("FINANCIER_SERV");
            }
            catch
            {
                correcto = false;
            }
            //TIPOS DE PAGARE
            List<ListOfVal> PromissoryList = new List<ListOfVal>();
            PromissoryList.Add(new ListOfVal("D", "Digital"));
            PromissoryList.Add(new ListOfVal("I", "Impreso"));
            opcPromissoryType.DataSource = PromissoryList;
            opcPromissoryType.ValueMember = "id";
            opcPromissoryType.DisplayMember = "description";

            opcTipoPagare.DataSource = PromissoryList;
            opcTipoPagare.ValueMember = "id";
            opcTipoPagare.DisplayMember = "description";            

            //aecheverry
            GenderList.Clear();
            //LISTA DE GENERO
            GenderList.Add(new ListOfVal("M", "Masculino"));
            GenderList.Add(new ListOfVal("F", "Femenino"));

            //GENERO DE DEUDOR
            ocDeudorGender.DataSource = GenderList;
            ocDeudorGender.ValueMember = "id";
            ocDeudorGender.DisplayMember = "description";

            //GENERO DE CODEUDOR
            ocCosignerGender.DataSource = GenderList;
            ocCosignerGender.ValueMember = "id";
            ocCosignerGender.DisplayMember = "description";

            //aecheverry
            HolderRelation.Clear();
            //LISTA DE RELACIONES CON EL TITULAR
            //HolderRelation.Add(new ListOfVal(" ", " ")); 04-11-2014 Llozada [NC 3293, 3294, 3295]: Se elimina el esapcio vacío
            HolderRelation.Add(new ListOfVal("1", "1 - Conyuge"));
            HolderRelation.Add(new ListOfVal("2", "2 - Hijo"));
            HolderRelation.Add(new ListOfVal("3", "3 - Padre/madre"));
            HolderRelation.Add(new ListOfVal("4", "4 - Familiar"));
            HolderRelation.Add(new ListOfVal("5", "5 - Arrendatario"));
            HolderRelation.Add(new ListOfVal("6", "6 - Amigo"));
            HolderRelation.Add(new ListOfVal("7", "7 - Otro"));
            //RELACION DEL DEUDOR CON EL TITULAR
            ocDeudorHolderRelation.DataSource = HolderRelation;
            ocDeudorHolderRelation.ValueMember = "id";
            ocDeudorHolderRelation.DisplayMember = "description";

            //RELACION DEL CODEUDOR CON EL TITULAR
            ocCosignerHolderRelation.DataSource = HolderRelation;
            ocCosignerHolderRelation.ValueMember = "id";
            ocCosignerHolderRelation.DisplayMember = "description";

            //NIVEL DE ESTUDIOS DEL DEUDOR
            DataTable degreeSchool = general.getValueList(BLConsultas.NivelEstudios);
            ocDeudorDegreeSchool.DataSource = degreeSchool;
            ocDeudorDegreeSchool.ValueMember = "id";
            ocDeudorDegreeSchool.DisplayMember = "descripción";

            //LISTADO DE TIPOS DE DOCUMENTOS
            DataTable identType = general.getValueList(BLConsultas.TipoDocumentoC);//"select ident_type_id id, description description from ge_identifica_type");
            ocDeudorIdentType.DataSource = identType;
            ocDeudorIdentType.ValueMember = "CODIGO";//"id";
            ocDeudorIdentType.DisplayMember = "DESCRIPCION";//"description";

            ocIdenType.DataSource = identType;
            ocIdenType.ValueMember = "CODIGO";//"id";
            ocIdenType.DisplayMember = "DESCRIPCION";//"description";

            ocCosignerIdentType.DataSource = identType;
            ocCosignerIdentType.ValueMember = "CODIGO";//"id";
            ocCosignerIdentType.DisplayMember = "DESCRIPCION";//"description";

            //NIVEL DE ESTUDIOS CODEUDOR
            ocCosignerDegreeSchool.DataSource = degreeSchool;
            ocCosignerDegreeSchool.ValueMember = "id";
            ocCosignerDegreeSchool.DisplayMember = "descripción";

            //ESTADO CIVIL
            DataTable civilState = general.getValueList(BLConsultas.CivilState);
            //ESTADO CIVIL DEUDOR
            ocDeudorCivilState.DataSource = civilState;
            ocDeudorCivilState.ValueMember = "id";
            ocDeudorCivilState.DisplayMember = "descripcion";

            //ESTADO CIVIL CODEUDOR
            ocCosignerCivilState.DataSource = civilState;
            ocCosignerCivilState.ValueMember = "id";
            ocCosignerCivilState.DisplayMember = "descripcion";

            //ESTRATOS SOCIALES
            DataTable estratums = general.valuelist(BLConsultas.SubCategoria + " where sucacate = 1");
            //ESTRATO DEUDOR
            ocDeudorEstratum.DataSource = estratums;
            ocDeudorEstratum.ValueMember = "CODIGO";//"id";
            ocDeudorEstratum.DisplayMember = "DESCRIPCION";//"descripción";

            //ESTRATO CODEUDOR
            ocCosignerEstratum.DataSource = estratums;
            ocCosignerEstratum.ValueMember = "CODIGO";//"id";
            ocCosignerEstratum.DisplayMember = "DESCRIPCION";//"descripción";

            //TIPO DE CASA
            DataTable houseType = general.getValueList(BLConsultas.TipoCasa);
            //TIPO DE CASA DEUDOR
            ocDeudorHouseType.DataSource = houseType;
            ocDeudorHouseType.ValueMember = "id";
            ocDeudorHouseType.DisplayMember = "descripcion";

            //TIPO DE CASA CODEUDOR
            ocCosignerHouseType.DataSource = houseType;
            ocCosignerHouseType.ValueMember = "id";
            ocCosignerHouseType.DisplayMember = "descripcion";

            //LISTA PESADA DE UBICACION DEL DEUDOR
            ohlbDeudorIssuePlace.Select_Statement = string.Join(string.Empty, new string[]{
                " select   ge_geogra_location.geograp_location_id ID, ",
                "   ge_geogra_location.display_description Description  ",
                " from ge_geogra_location ",
                "@WHERE @",
                "@ge_geogra_location.geog_loca_area_type = ab_boConstants.fnuObtTipoUbicacionLoc @",
                "@geograp_location_id like :id @ ",
                "@upper(display_description) like :description @ "});
            //LISTA PESADA DE UBICACION DEL CODEUDOR
            ohlbCosignerIssuePlace.Select_Statement = string.Join(string.Empty, new string[]{
                " select   ge_geogra_location.geograp_location_id ID, ",
                "   ge_geogra_location.display_description Description  ",
                " from ge_geogra_location ",
                "@WHERE @",
                "@ge_geogra_location.geog_loca_area_type = ab_boConstants.fnuObtTipoUbicacionLoc @",
                "@geograp_location_id like :id @ ",
                "@upper(display_description) like :description @ "});
            //CARGAR CONTROLES DE REFERENCIA
            //Labor Info deudor
            opDeudorLaborInfo.Location = new Point(0, 0);
            opDeudorLaborInfo.Controls.Add(cliDeudorInfo);
            opDeudorLaborInfo.Dock = System.Windows.Forms.DockStyle.Fill;
            //Referencia deudor
            opDeudorReference.Location = new Point(0, 0);
            opDeudorReference.Controls.Add(crDeudorInfo);
            opDeudorReference.Dock = System.Windows.Forms.DockStyle.Fill;
            //Labor Info codeudor
            opCosignerLaborInfo.Location = new Point(0, 0);
            opCosignerLaborInfo.Controls.Add(cliCosignerInfo);
            opCosignerLaborInfo.Dock = System.Windows.Forms.DockStyle.Fill;
            //Referencia codeudor
            opCosignerReferenceInfo.Location = new Point(0, 0);
            opCosignerReferenceInfo.Controls.Add(crCosignerInfo);
            opCosignerReferenceInfo.Dock = System.Windows.Forms.DockStyle.Fill;

            typeUser = Convert.ToString(general.valueReturn(BLConsultas.TipoUsuarioConectado, "String"));

            tbSubscription.TextBoxValue = subscriptionId.ToString();
            tbSubscription.ReadOnly = true;

            SublinesAppliedToPartialQuota = new List<OpenPropertyByControlBase>();

            _subscriptionId = subscriptionId;
            loadData(subscriptionId);

            //Establece el tamaño de los Opentitles SAO 226337
            openTitle7.Size = new Size(1010, 23); //Cliente
            openTitle5.Size = new Size(1010, 17); //Informacion Proveedor Contratista
            openTitle6.Size = new Size(1010, 16); //Solicitud de Venta

            openTitle13.Size = new Size(1010, 24); //Datos Generales Deudor
            openTitle8.Size = new Size(1010, 22); //Datos Generales Codeudor

            //Inicio Desarrollo CASO 200-85
            //logica para ocultar los objetos
            BLAplicaParaGDC = _blFIFAP.BLFBLAplicaParaGDC("FNB_BR_JLVM_CA_200_85");
            BLAplicaParaEfigas = _blFIFAP.BLFBLAplicaParaEfigas("FNB_BR_JLVM_CA_200_85");
            //if (!(BLAplicaParaGDC) || !(BLAplicaParaEfigas))
            //ostbNewCosignerName.Enabled = false;
            //ostbNewCosignerLastName.Enabled = false;
            //ostbNewCosignerIdentification.Enabled = false;
            //ostbNewCosignerName.Visible = false;
            //ostbNewCosignerLastName.Visible = false;
            //ostbNewCosignerIdentification.Visible = false;

            //if ((BLAplicaParaGDC) || (BLAplicaParaEfigas))
            //{
                ostbNewCosignerName.Enabled = true;
                ostbNewCosignerLastName.Enabled = true;
                ostbNewCosignerIdentification.Enabled = true;
                ostbNewCosignerName.Visible = true;
                ostbNewCosignerLastName.Visible = true;
                ostbNewCosignerIdentification.Visible = true;
            //}


            //if ((BLAplicaParaGDC))
            //{
            //    //ostbCosignerName.Location = new Point(150, 45);
            //    //ostbCosignerLastName.Location = new Point(491, 45);
            //    //ostbCosignerIdentification.Location = new Point(810, 45);

            //    txtCosignerContract.Location = new Point(150, 45);
            //    ultraLabel35.Location = new Point(386, 45);
            //    ocCosignerIdentType.Location = new Point(491, 45);
            //    ostbCosignerIdentification.Location = new Point(560, 45);
            //    ohlbCosignerIssuePlace.Location = new Point(810, 45);

            //    ostbNewCosignerName.Visible = false;
            //    ostbNewCosignerLastName.Visible = false;
            //    ostbNewCosignerIdentification.Visible = false;
            //}
            //Fin Desarrollo CASO 200-85

            //Incio 200-854
            tcPpal.Tabs[0].Visible = false;
            tcPpal.Tabs[1].Visible = true;
            tcPpal.Tabs[1].Enabled = true;
            tcPpal.Tabs[2].Visible = true;
            tcPpal.Tabs[2].Enabled = false;
            tcPpal.Tabs[3].Visible = true;
            tcPpal.Tabs[3].Enabled = false;
            tcPpal.Tabs[4].Visible = false;
            tcPpal.Tabs[5].Visible = false;
            obGuardarSPU.Enabled = false;

            //Colocar referencia familiar como dato opcional en Deudor
            crDeudorInfo.ostbPersonalName.Required = 'Y';
            crDeudorInfo.ostbFamiliarName.Required = 'N';
            //Colocar referencia familiar como dato opcional en CoDeudor
            crCosignerInfo.ostbPersonalName.Required = 'Y';
            crCosignerInfo.ostbFamiliarName.Required = 'N';
            /////////////////////////////////////////////////////

            //Fin 200-854

        }

        private void loadData(Int64 subscriptionId)
        {
            //DATOS DE CUPOS EXTRAS

            _extraQuota = _blFIFAP.getExtraQuotes(subscriptionId);
            dgExtraQuotasAllocated.DataSource = _extraQuota;

            //******01-10-2014 Llozada[RQ 1218] INICIO******//
            //LISTA DE CAUSALES PARA DEUDOR SOLIDARIO
            DataTable causalDeudorSol = general.getValueList("SELECT causal_id id, description " +
                " FROM ge_causal" +
                " WHERE causal_type_id = dald_parameter.fnuGetNumeric_Value('FNB_CAUSAL_DEUDOR_SOL')");

            CausalDeudorSol.DataSource = causalDeudorSol;
            CausalDeudorSol.DisplayMember = "description";
            CausalDeudorSol.ValueMember = "ID";

            ocCausalDeudorSolidario.DataSource = causalDeudorSol;
            ocCausalDeudorSolidario.DisplayMember = "description";
            ocCausalDeudorSolidario.ValueMember = "ID";

            //******01-10-2014 Llozada[RQ 1218] FIN******//

            //******17-02-2015 Llozada[RQ 1841] INICIO******//
            //LISTA DE PLANES DE FINANCIACIÓN CUOTA FIJA
            //******13-10-2015 heiberb[334390] se comenta la forma de obtener los planes del párametro******//
            //DataTable sqlPlanFinanciacion = general.getValueList("SELECT column_value id, pktblplandife.fsbgetdescription(column_value) description" +
            //    " from table (ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('FNB_PLANFINAN_CF') ,','))");

            //PlanFinanciacion.DataSource = sqlPlanFinanciacion;
            //PlanFinanciacion.DisplayMember = "description";
            //PlanFinanciacion.ValueMember = "ID";
            //******17-02-2015 Llozada[RQ 1841] FIN******//

            /* [03/08/2015] edwardh [SAO.334390 Cuota Fija]: si el flag FLAG_VISUALIZAR_PLN_FIN esta en N no muestra el combo
             */
            FLAG_VISUALIZAR_PLN_FIN = sbYes.Equals((String)OpenConvert.ToString(general.getParam("FLAG_VISUALIZAR_PLN_FIN", "String")));

            // Pregunta si el flag no esta en Y 
            if (!FLAG_VISUALIZAR_PLN_FIN)
            {
                cuotaFijaCheck.Visible = false;
            }

            //******08-09-2014 KCienfuegos.RNP192******//
            //LISTA DE PUNTOS DE VENTA
            DataTable pointSales = general.getValueList("SELECT TO_CHAR(OP.OPERATING_UNIT_ID) ID, OP.NAME description " +
                " FROM OR_OPERATING_UNIT OP" +
                " WHERE OP.CONTRACTOR_ID = " + _dataFIFAP.SupplierID +
                " AND OP.OPER_UNIT_CLASSIF_ID IN(DALD_PARAMETER.FNUGETNUMERIC_VALUE('SUPPLIER_FNB'), DALD_PARAMETER.FNUGETNUMERIC_VALUE('CONTRACTOR_SALES_FNB'))" +
                " ORDER BY OP.OPERATING_UNIT_ID");

            opcPointSale.DataSource = pointSales;
            opcPointSale.DisplayMember = "description";
            opcPointSale.ValueMember = "ID";

            if (selectPointSale == "Y")
            {
                opcPointSale.Value = _dataFIFAP.PointSaleId;
                opcPointSale.Enabled = true;
                opcPointSale.ReadOnly = false;
            }
            else
            {
                opcPointSale.Value = _dataFIFAP.PointSaleId;
                opcPointSale.Enabled = false;
            }
            //******************************************//

            //******08-11-2014 Llozada [RQ 122]******//
            //general.mensajeOk("FNB_PAGO_CONTADO "+general.getParam("FNB_PAGO_CONTADO", "String").ToString());
            if (general.getParam("FNB_PAGO_CONTADO", "String").ToString() == "N")
            {
                this.pagoContadoCheck.Visible = false;
            }
            //******************************************//

            //LISTA DE CANALES DE VENTA
            DataTable chanelSales = general.getValueList("select to_char(r.reception_type_id) ID, r.description Descripción " +
                " from GE_RECEPTION_TYPE r, or_ope_uni_rece_type o" +
                " WHERE r.RECEPTION_TYPE_ID <> GE_BOPARAMETER.fnuGet('EXTERN_RECEPTION') " +
                " AND r.reception_type_id = o.reception_type_id " +
                " AND o.operating_unit_id =  " + opcPointSale.Value +
                " and REGEXP_INSTR(dald_parameter.fsbGetValue_Chain('SALES_CHANNEL_FNB'), '(\\W|^)'|| r.reception_type_id ||'(\\W|$)') > 0 Order By r.reception_type_id");
            opcChanelSale.DataSource = chanelSales;
            opcChanelSale.DisplayMember = "Descripción";
            opcChanelSale.ValueMember = "ID";

            //EVESAN 03/Julio/2013
            if (_dataFIFAP.SelectChanelSale)
                opcChanelSale.Enabled = true;
            else
            {
                opcChanelSale.Value = _dataFIFAP.DefaultchanelSaleId;
                opcChanelSale.Enabled = false;
            }

            Int64 CallCenterId = _blFIFAP.getCallCenterId(subscriptionId);

            if (CallCenterId != 0)
            {
                opcChanelSale.Value = CallCenterId;
                opcChanelSale.Enabled = false;
            }
            else
            {
                opcChanelSale.Value = _dataFIFAP.DefaultchanelSaleId;
            }

            ostbDepartament.TextBoxValue = _dataFIFAP.Departament;
            ostbLocation.TextBoxValue = _dataFIFAP.Location;

            //LISTA DE VENDEDORES
            DataTable sellerList = general.getValueList(" select ge_person.person_id id, name_ description " +
                "from ge_person, or_oper_unit_persons " +
                "where  ge_person.person_id = or_oper_unit_persons.person_id " +
                "and or_oper_unit_persons.operating_unit_id = " + opcPointSale.Value);
            opcSeller.DataSource = sellerList;
            opcSeller.ValueMember = "id";
            opcSeller.DisplayMember = "description";
            //CARGA DE DATOS DE LA FORMA
            //jhinestroza
            tbSubsNewName.TextBoxValue = _dataFIFAP.SubName;
            tbSubsLastName.TextBoxValue = _dataFIFAP.SubLastname;

            //Agregar datos a la pestaña VALIDAR CEDULA - DATACREDITO
            cbTypeDocument.Value = _dataFIFAP.IdentType;
            //cbTypeDocument.Enabled = false;
            tbNumberDocument.TextBoxValue = _dataFIFAP.Identification;
            //tbNumberDocument.Enabled = false;
            //tbLastName.TextBoxValue = _dataFIFAP.SubLastname;
            ////////////////////////////////////////////////////////////

            tbSubsName.TextBoxValue = _dataFIFAP.SubName + " " + _dataFIFAP.SubLastname;
            tbSubsTelefone.TextBoxValue = _dataFIFAP.FullPhone;
            tbSubsAddress.TextBoxValue = _dataFIFAP.AddressId + " - " + _dataFIFAP.Address;
            ocIdenType.Value = _dataFIFAP.IdentType;
            tbSubsId.TextBoxValue = _dataFIFAP.Identification;
            cbTypeDocument.Value =ocIdenType.Value;
            tbNumberDocument.TextBoxValue = tbSubsId.TextBoxValue;
            ocDeudorIdentType.Value = ocIdenType.Value;
            ostbDeudorIdentification.TextBoxValue = tbSubsId.TextBoxValue;
            tbCategory.TextBoxValue = _dataFIFAP.Category;
            tbSubcategory.TextBoxValue = _dataFIFAP.SubCategory;
            tbNetworkBalance.TextBoxValue = _dataFIFAP.Balance.ToString();
            tbQuotaAllocated.TextBoxValue = _dataFIFAP.AssignedQuote;
            tbQuotaAvailable.TextBoxValue = _dataFIFAP.AvalibleQuota;

            tbQuotaUsed.TextBoxValue = _dataFIFAP.UsedQuote;
            ostbSupplier.TextBoxValue = _dataFIFAP.SupplierID + " - " + _dataFIFAP.SupplierName;
            //ostbPointSale.TextBoxValue = _dataFIFAP.PointSaleId + " - " + _dataFIFAP.PointSaleName;
            
            //25-09-2014 KCienfuegos.RNP198 Se obtiene la segmentación comercial del contrato.
            BLFIFAP.GetCommercialSegment(subscriptionId, out osbCommercialSegm, out onuSegmentId);
            
            tbCommercialSegm.TextBoxValue = osbCommercialSegm;
            // FIN RNP198

            ///////////////////////////////////////////////
            //EVESAN 04/Julio/2013
            if (_dataFIFAP.TransferQuota)
            {
                uceTransferQuota.Enabled = true;
            }
            else
            {
                uceTransferQuota.Enabled = false;
            }
            ///////////////////////////////////////////////

            
            // 14-10-2014 KCienfuegos.RNP1179 Se valida si la instalación por proveedor está habilitada
            if (_blFIFAP.getParam("USA_INSTALAC_PROVEEDOR_FNB") == "Y")
            {
                //Se valida si el proveedor está habilitado para instalación de gasodomésticos
                if (_blFIFAP.isActiveForInstalling(Convert.ToInt32(_dataFIFAP.SupplierID)))
                {
                    ucSaleInstallation.Enabled = true;
                }
            }
            ////////////////////RNP1179////////////////////////////

            
            // 27-10-2014 KCienfuegos.RNP1808 Se valida si la venta empaquetada está activa
            if (_blFIFAP.getParam("ACTIVA_VTA_EMPAQUETADA") == "Y")
            {
                //Se valida si existe solicitud de venta empaquetada vigente
                if (_blFIFAP.fblValidInstallDate(_subscriptionId))
                {
                    cbxVentaEmpaq.Enabled = true;
                    cbxVentaEmpaq.Visible = true;
                }
            }
            ////////////////////RNP1808////////////////////////////

            // 20-01-2015 KCienfuegos.ARA5737 Se valida si se debe visualizar fecha de entrega
            if (_blFIFAP.getParam("CAMPO_FECHA_ENTREGA") == "Y")
            {
                dtDeliverDate.Visible = true;
                ultraLabel5.Visible = true;
                
            }
            ////////////////////ARA5737////////////////////////////

            //general.mensajeOk("PASO 5. !_dataFIFAP.ValidateBill --> " + _dataFIFAP.ValidateBill.ToString());
            if (!_dataFIFAP.ValidateBill)
            {
                ostbBillDate1.Enabled = false;
                ostbBillDate2.Enabled = false;
                ostbBillId1.Enabled = false;
                ostbBillId2.Enabled = false;
                enableBill();

            }
            else
            {
                //KCienfuegos.NC4820 03-02-2015
                //Validar si tiene el número de facturas mínimas.
                 ValidFacts();
                //FIN NC4820 03-02-2015 --KKK
            }

            opcPromissoryType.Enabled = false;

            //typeUser == "CV" 
            if (_dataFIFAP.PromissoryType.Equals("I"))
            {
                opcPromissoryType.Value = "I";
                _dataFIFAP.PromissoryType = "I";
            }
            else if (_dataFIFAP.PromissoryType.Equals("D"))
            {
                opcPromissoryType.Value = "D";
            }
            else
            {
                opcPromissoryType.Enabled = true;                
                opcPromissoryType.Value = "I";
                _dataFIFAP.PromissoryType = "I";

                opcTipoPagare.Enabled = true;
                opcTipoPagare.Value = "I";

            }

            opcTipoPagare.Enabled = true;
            //opcPromissoryType.Value = "D";
            //_dataFIFAP.PromissoryType = "D";

            ostbPayment.ReadOnly = false;

            string paramTitular = Convert.ToString(general.getParam("VALI_TITU_VENT", "String"));

            if (paramTitular == "Y")
            {
                VALI_TITU_VENT = true;
            }
            else
            {
                VALI_TITU_VENT = false;
            }

            if (!VALI_TITU_VENT)
            {
                uceBillHolder.Checked = true;

                if (_dataFIFAP.RequiresCosigner)
                {
                    loadLastCosigner();
                }
            }
            
            //general.mensajeOk("PASO 6. Double.Parse(_dataFIFAP.AvalibleQuota) <= 0, _dataFIFAP.AvalibleQuota: " + _dataFIFAP.AvalibleQuota);
            if (Double.Parse(_dataFIFAP.AvalibleQuota) <= 0)
            {
                //Validacion de cupo parcial
                haveParcial = _blFIFAP.GetPartialQuotaValidation(_subscriptionId);
                // Se obtienen las sublineas a las que deben pertenecer como minimo un articulo para poder aplicar cupo parcial
                SublinesAppliedToPartialQuota = _blFIFAP.GetSublinesAppliedToPartialQuota();              
                
                ////Si aplica cupo parcial y como minimo hay una sublinea que aplica para cupo parcial
                //if (haveParcial && SublinesAppliedToPartialQuota.Count >= 1)
                //{
                //    //general.mensajeOk("PASO 7. APLICA CUPO PARCIAL");
                //    string partialQuotaMessage = string.Empty;

                //    foreach (OpenPropertyByControlBase item in SublinesAppliedToPartialQuota)
                //    {
                //        partialQuotaMessage += "[" + item.Key + " - " + item.Text + "] ";
                //    }

                //    general.mensajeOk("Podrá utilizar cupo si vende al menos un artículo de las siguientes sublíneas: " + partialQuotaMessage);

                //}
                //else
                //{
                //    //general.mensajeOk("PASO 8. _blFIFAP.fblValidInstallDate(_subscriptionId)");
                //    //Valida si existe una venta empaquetada vigente - KCienfuegos.RNP1808 27/10/2014
                //    if (_blFIFAP.fblValidInstallDate(_subscriptionId))
                //    {                        
                //        general.mensajeOk("Podrá realizar venta, sólo con los artículos permitidos para una venta empaquetada");
                //    }
                //    else
                //    {

                //        if (Convert.ToDouble(_dataFIFAP.AssignedQuote) <= 0 && Convert.ToDouble(_blFIFAP.getTotalExtraQuote(_subscriptionId)) <= 0)
                //        {
                //            general.mensajeOk("El cliente no posee cupo de crédito asignado. Sin embargo, se puede registrar la Solicitud de Pagare Unico.");
                //            SetStatusCashPayment();
                //        }
                //    }
                //}

            }
          

            //general.mensajeOk("PASO 20. FIN");

           
        }

        #endregion

        #region ManejoPagares

        private void validateBill()
        {
            Boolean _validateBill;

            //  Si se ingresa alguna de las dos facturas
            if (!String.IsNullOrEmpty(ostbBillId1.TextBoxValue) || !String.IsNullOrEmpty(ostbBillId2.TextBoxValue))
            {
                //  Si las facturas son iguales
                if (ostbBillId1.TextBoxValue == ostbBillId2.TextBoxValue)
                {
                    ExceptionHandler.DisplayError(2741, new string[] { "La primera y segunda factura son iguales" });
                    ValidInvoices = false; //NC4820
                }
                else
                {
                    try
                    {
                        _validateBill = _blFIFAP.validateBill(
                            Convert.ToInt64(tbSubscription.TextBoxValue),
                            OpenConvert.ToInt64Nullable(ostbBillId1.TextBoxValue),
                            OpenConvert.ToInt64Nullable(ostbBillId2.TextBoxValue),
                            OpenConvert.ToDateTimeNullable(ostbBillDate1.TextBoxValue),
                            OpenConvert.ToDateTimeNullable(ostbBillDate2.TextBoxValue));

                        if (_validateBill)
                        {
                            ValidInvoices = true; //NC4820
                            enableBill();
                        }
                    }
                    catch (Exception ex)
                    {
                        GlobalExceptionProcessing.ShowErrorException(ex);

                        /*18-11-2014 Llozada [NC 3380, 3381, 3382]: Cuando se presente una excepción, el sistema no debe
                                                                    inhabilitar los campos*/
                        opcChanelSale.ReadOnly = true;
                        //opcPromissoryType.ReadOnly = true;
                        opcChanelSale.ReadOnly = true;
                        //opcPromissoryType.ReadOnly = true;
                        opcSeller.ReadOnly = true;
                        obSaveSaleDate.Enabled = false;
                        ValidInvoices = false; //NC4820
                    }
                }

                _dataFIFAP.BillId1 = Convert.ToInt64(ostbBillId1.TextBoxValue);
                _dataFIFAP.BillId2 = Convert.ToInt64(ostbBillId2.TextBoxValue);
                _dataFIFAP.BillDate1 = Convert.ToDateTime(ostbBillDate1.TextBoxValue);
                _dataFIFAP.BillDate2 = Convert.ToDateTime(ostbBillDate2.TextBoxValue);
            }
        }

        /// <summary>
        /// Valida de nuevo el codeudor. Maneja excepciones
        /// </summary>
        private void validateCosignerAux()
        {
            if (!String.IsNullOrEmpty(ostbCosignerIdentification.TextBoxValue) && !String.IsNullOrEmpty(ocCosignerIdentType.Value.ToString()))
            {
                Boolean validCos = true;
                Boolean deudorSolidario = true;
                Boolean validCodeudor;
                Boolean PrioridadDeudorSol = true;

                try
                {
                    //general.mensajeOk("INICIA validateCosignerAux");
                    /*Llozada [RQ 1218]: Siempre debe inicializar en TRUE para que no generen errrores las modificaciones de kathe*/
                    blValidCosigner = true;
                                      

                    //21-11-2014 Llozada [RQ 1218]: Si viene como inquilino o mayor de 76 se valida cupo
                    if (tbSubsId.TextBoxValue != tbNumberDocument.TextBoxValue || cbTypeDocument.Text != ocIdenType.Text || yearsParameter <= years)
                    {                        
                        //if (!String.IsNullOrEmpty(txtCosignerContract.TextBoxValue))
                        //{
                            PrioridadDeudorSol = false;
                        //}
                    }

                    /*02-10-2014 Llozada [RQ 1218]: Si es seleccionado el flag de deudor solidario.
                                                    En caso de que sea seleccionado el flag de traslado de cupo,
                                                    el proceso continua como traslado de cupo y No como deudor solidario*/
                    if (deudorSolCheck.Checked && !uceTransferQuota.Checked && PrioridadDeudorSol)
                    {                        
                        deudorSolidario = _blFIFAP.validateCosigner(ostbCosignerIdentification.TextBoxValue, Int32.Parse(Convert.ToString(ocCosignerIdentType.Value)));

                        if (deudorSolidario)
                        {
                            ClearCosignerInfo(true);

                            /*Llozada [RQ 1218]: Indica que No es valido el codeudor*/
                            blValidCosigner = false;
                            //general.mensajeOk("blValidCosigner: " + blValidCosigner);
                            general.mensajeERROR("No puede ser DEUDOR SOLIDARIO ya que actualmente es CODEUDOR de financiaciones con deuda o "+
                                                 "tiene una solicitud en proceso de gestión, para continuar anule esa solicitud. Recuerde que un "+
                                                 "DEUDOR SOLIDARIO solo puede ser CODEUDOR de una sola financiación.");                            
                        }
                    }                   
                    else 
                    {
                        deudorSolCheck.Checked = false;                        

                        /*HAltamiranda - Validacion Deudor Rollover*/
                        if (!DeudorRollover)                        {                            
                            
                            //general.mensajeOk("validateCosigner");
                            validCos = _blFIFAP.validateCosigner(Convert.ToInt64(_dataFIFAP.SupplierID), ostbCosignerIdentification.TextBoxValue, Int32.Parse(Convert.ToString(ocCosignerIdentType.Value)));
                            //general.mensajeOk("OK, validCos" + validCos);
                        }

                        if (!validCos)
                        {
                            blValidCosigner = false;
                            ClearCosignerInfo(true);
                        }                    
                        else
                        {
                            String trasladoCupo = "N";

                            if (uceTransferQuota.Checked)
                            {
                                trasladoCupo = "Y";
                            }

                            /*04-10-2014 Llozada [RQ 1218]: Se valida el codeudor con el nuevo modelo*/
                            validCodeudor = _blFIFAP.validateCosigner(ostbCosignerIdentification.TextBoxValue, Int32.Parse(Convert.ToString(ocCosignerIdentType.Value)),
                                                                      tbSubsId.TextBoxValue, Int32.Parse(Convert.ToString(ocIdenType.Value)), trasladoCupo);                                                

                            if (validCodeudor) 
                            {
                                if (!string.IsNullOrEmpty(txtCosignerContract.TextBoxValue))
                                {
                                    //CASO 200-1880
                                    //CASO 5 Validar CUPO del CODEUDOR si esta seleccionado DEUDOR SOLIDARIO
                                    bool validContract = true;
                                    //if ((cbDeudorSolidario.Checked == false) && (yearsParameter < years) && (DeudorRollover))
                                    //general.mensajeERROR("cbDeudorSolidario.Checked[" + cbDeudorSolidario.Checked.ToString() + "]");
                                    years = DateTime.Today.Year - ((DateTime)ostbDeudorBirthDate.TextBoxObjectValue).Year;
                                    //aecheverry se obtiene correctamente la edad del  deudor
                                    if ((DateTime.Today.Month < ((DateTime)ostbDeudorBirthDate.TextBoxObjectValue).Month)
                                        || (DateTime.Today.Month == ((DateTime)ostbDeudorBirthDate.TextBoxObjectValue).Month
                                            && DateTime.Today.Day < ((DateTime)ostbDeudorBirthDate.TextBoxObjectValue).Day))
                                    {
                                        years = years - 1;
                                    }
                                    //general.mensajeERROR("years[" + years + "] > yearsParameter[" + yearsParameter + "]");
                                    //general.mensajeERROR("DeudorRollover[" + DeudorRollover.ToString() + "]");
                                    if ((cbDeudorSolidario.Checked == true) && (years > yearsParameter) && (DeudorRollover))
                                    {
                                        validContract = true;
                                    }
                                    else
                                    {
                                        //05-11-2014 Llozada [RQ 1218]: Se valida que el contracto tenga cupo asignado
                                        validContract = _blFIFAP.validateQuotaContract(Convert.ToInt64(txtCosignerContract.TextBoxValue));
                                    }
 
                                    //general.mensajeOk("OK, validCodeudor" + validCodeudor);
                                    
                                    if (!validContract)
                                    {
                                        blValidCosigner = false;
                                        ClearCosignerInfo(true);
                                    }
                                }
                            }
                        }
                    }                    
                }
                catch (Exception e1)
                {
                    txtCosignerContract.TextBoxValue = string.Empty;
                    ClearCosignerInfo(true);

                    throw e1;
                }
            }
        }

        #endregion

        #region Otros

        private void enableBill()
        {

            //
            if (_dataFIFAP.SelectChanelSale)
                opcChanelSale.ReadOnly = false;

            opcChanelSale.ReadOnly = false;


            opcSeller.ReadOnly = false;

            //vhurtadoSAO213189, se habilita el campo Entrega en Punto, según lo configurado en FICBS
            ucePointDelivery.Enabled = _dataFIFAP.EditPointDel;
            ucePointDelivery.Checked = _dataFIFAP.PointDelivery;
            //
            if (_dataFIFAP.AllowTransferQuota && !isCashPayment)
            {
                uceTransferQuota.Enabled = true;
            }
            //
            ostbPayment.ReadOnly = false;
            ostbSaleDate.Enabled = true;
            ostbRegisterDate.TextBoxObjectValue = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();
            ostbSaleDate.TextBoxObjectValue = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();
            ostbDeliveryAddress.TextBoxValue = _dataFIFAP.Address;
            obSaveSaleDate.Enabled = true;
        }

        private void dgExtraQuotasAllocated_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            //
            List<ExtraQuote> tmpList = new List<ExtraQuote>();
            //
            if (!tmpList.Count.Equals(0))
            {
                dgExtraQuotasAllocated.DataSource = tmpList;
            }
        }

        /// <summary>
        /// Crea la lista de valores para los artículos
        /// </summary>
        /// <returns>Lista de valores</returns>
        private OpenGridDropDown DropDownListsMaker(List<ArticleValue> articleList)
        {
            // Conecta el dropdown con el dataset y define la tabla y columnas a usar
            OpenGridDropDown dropdown = new OpenGridDropDown();

            dropdown.DataSource = articleList;
            dropdown.DisplayMember = "ArticleDescription";
            dropdown.ValueMember = "ArticleId";

            //  Copia la columna de descripciones a una nueva lista
            for (int index = 0; index < articleList.Count; index++)
            {
                _articleDescription.Add(articleList[index].ArticleDescription);
            }

            //Hace no visibles las columnas que no son requeridas
            ColumnsCollection cols = dropdown.DisplayLayout.Bands[0].Columns;

            //Coloca los titulos del DropDown
            cols[dropdown.ValueMember].Header.Caption = "Código";
            cols[dropdown.DisplayMember].Header.Caption =
                this.ogArticles.DisplayLayout.Bands[0].Columns["ArticleIdDescription"].Header.Caption;
            cols[dropdown.ValueMember].SortIndicator = SortIndicator.Ascending;

            //Activa el scrollbar
            dropdown.DisplayLayout.Scrollbars = Scrollbars.Automatic;
            dropdown.DisplayLayout.Bands[0].Columns[dropdown.ValueMember].PerformAutoResize(PerformAutoSizeType.AllRowsInBand);
            dropdown.DisplayLayout.Bands[0].Columns[dropdown.DisplayMember].PerformAutoResize(PerformAutoSizeType.AllRowsInBand);
            if ((Screen.PrimaryScreen.WorkingArea.Width / 3) <= dropdown.DisplayLayout.Bands[0].Columns[dropdown.DisplayMember].Width + dropdown.DisplayLayout.Bands[0].Columns[dropdown.ValueMember].Width)
            {
                dropdown.DisplayLayout.Bands[0].Columns[dropdown.DisplayMember].Width = (Screen.PrimaryScreen.WorkingArea.Width / 3) -
                dropdown.DisplayLayout.Bands[0].Columns[dropdown.ValueMember].Width;

            }
            return dropdown;
        }

        /// <summary>
        /// Indica los estados de la forma cuando el pago es de contado.
        /// </summary>
        private void SetStatusCashPayment()
        {
            this.uceTransferQuota.Checked = false;
            this.uceGracePeriod.Checked = false;

            this.uceTransferQuota.Enabled = false;
            this.uceGracePeriod.Enabled = false;

            //El valor inicial se toma del total de la venta, por ser pago de contado.
            ostbPayment.TextBoxValue = "0";
            ostbPayment.Enabled = false;
            this.isCashPayment = true;
        }

        /// <summary>
        /// 02-10-2014 Llozada [RQ 1218]: Indica los estados de la forma cuando el pago NO es de contado.
        /// </summary>     
        private void SetStatusCashPaymentchanged()
        {
            //20-10-2014 Llozada [RQ 1172]: Se comenta para evitar problemas 
            //this.uceTransferQuota.Checked = true;
            //this.uceGracePeriod.Checked = true;

            this.uceTransferQuota.Enabled = true;
            this.uceGracePeriod.Enabled = true;

            //El valor inicial se toma del total de la venta, por ser pago de contado.
            ostbPayment.TextBoxValue = "0";
            ostbPayment.Enabled = true;
            this.isCashPayment = false;
        }

        void ocArticle_RowSelected(object sender, RowSelectedEventArgs e)
        {
            if (!(sender == null))
            {
                UltraDropDown a = ((UltraDropDown)sender);
                if (a.SelectedRow != null)
                {
                    articleValue =
                        _articleLOV.Find(delegate(ArticleValue ar)
                        { return ar.ArticleId == Convert.ToInt64(a.SelectedRow.Cells[0].Value); });
                }
            }
        }

        private void bindingNavigatorAddNewItem_Click(object sender, EventArgs e)
        {
            this.bindingNavigator1.Focus();

            if (ValidRow(true))
            {
                articleBindingSource.AddNew();
            }
        }

        /// <summary>
        /// Convierte el porcentaje enviado a nominal
        /// Basado en el método de financiaciones: pkEffectiveInterestRateMgr.ToNominalRate
        /// </summary>
        /// <param name="percentage">Porcentaje a convertir</param>
        /// <returns>Porcentaje convertido</returns>
        private Double ConvertToNominalRate(Double percentage)
        {
            //  Math.Pow(12,-1) = 1 / 12 (se hace así, para que no convierta a entero)
            return Math.Pow((percentage / 100) + 1, Math.Pow(12, -1)) - 1;
        }

        /// <summary>
        /// Obtiene el valor total del seguro.
        /// Para cada mes va calculando el saldo de la financiación y a este le aplica el
        /// porcentaje del seguro
        /// </summary>
        /// <param name="articleValue">Valor del artículo</param>
        /// <param name="feedsNumber">Número de cuotas</param>
        /// <param name="interestPercentage">Porcentaje de interés</param>
        /// <param name="safePercentage">Porcentaje del seguro</param>
        /// <param name="monthQuota">Valor de la cuota del mes</param>
        /// <returns>Valor total del seguro</returns>
        private Double GetSafeTotalValue(
            Double articleValue,
            Int64 feedsNumber,
            Double interestPercentage,
            Double safePercentage,
            Double monthQuota)
        {
            //general.mensajeOk("INICIO GetSafeTotalValue");
            //general.mensajeOk("Variables de entrada: " + " articleValue: " + articleValue + " feedsNumber: " + feedsNumber + " interestPercentage: " + interestPercentage + " safePercentage: " + safePercentage + " monthQuota: " + monthQuota);
            Double interest;
            Double capital;
            Double safeValue = 0;
            
            for (Int32 index = 1; index <= feedsNumber; index++)
            {
                //general.mensajeOk("INICIO FOR");
                //  Calcula el valor del seguro para el saldo
                safeValue = safeValue + articleValue * safePercentage;
                //general.mensajeOk("Calcula el valor del seguro para el saldo => [safeValue = safeValue + articleValue * safePercentage ] => " + safeValue);
                
                //  Calcula el porcentaje de interés
                interest = articleValue * interestPercentage;
                //general.mensajeOk("Calcula el porcentaje de interés => [interest = articleValue * interestPercentage ] => " + interest);

                //  Disminuye el valor del capital
                capital = monthQuota - interest;
                //general.mensajeOk("Disminuye el valor del capital => [capital = monthQuota - interest ] => " + capital);

                //  Disminuye el saldo de la financiación
                articleValue = articleValue - capital;
                //general.mensajeOk("Disminuye el saldo de la financiación => [articleValue = articleValue - capital ] => " + articleValue);
            }
            //general.mensajeOk("FIN FOR");

             //general.mensajeOk("FIN GetSafeTotalValue  ---- VALOR A RETORNAR DE LA FUNCION => [" + safeValue + "]");
            return safeValue;
        }

        

        //15-Oct-2013:LDiuza.SAO219648:1
        /// <summary>
        /// Obtiene el saldo pendiente de cupo a transferir
        /// </summary>
        /// <param name="totalSale">Total de la venta menos el pago inicial</param>
        /// <param name="availableQuota">Cupo disponible</param>
        /// <param name="salesChannel">Canal de ventas</param>
        /// <param name="articles">Lista de artículos de la venta</param>
        /// <param name="extraQuotas">Cuotas extra</param>
        /// <returns></returns>
        private Double GetPendTransfQuota(Double totalSale, Double availableQuota, Int64? salesChannel, List<Article> articles, List<ExtraQuote> extraQuotas)
        {
            Double diference;
            ExtraQuote extraQuoteObj;

            //Se calcula la diferencia a cubrir con cuota extra como: total venta - cupo disponible
            diference = totalSale - availableQuota;

            // Inicializa las cuotas usadas como el valor completo de la cuota
            foreach (ExtraQuote extQuote in extraQuotas)
            {
                extQuote.UsedQuote = extQuote.Quote;
            }

            //Se iteran los articulos para ir disminuyendo el valor de la venta.
            foreach (Article article in articles)
            {
                //  Obtiene el cupo extra que aplica para el articulo
                extraQuoteObj = _blFIFAP.GetExtraQuote(article, extraQuotas, salesChannel);

                //  Si encontró cupo
                if (extraQuoteObj != null)
                {
                    //Si la diferencia es menor que el cupo extra (El cupo extra cubre toda la diferencia)
                    if (diference <= extraQuoteObj.UsedQuote)
                    {
                        //Se resta a la cuota extra la diferencia (Cubre toda la diferencia)
                        extraQuoteObj.UsedQuote = extraQuoteObj.UsedQuote - diference;

                        //Se asigna al articulo el valor usado de la cuota extra (Para este caso es toda la diferencia)
                        article.UsedExtraQuota = diference;

                        //Se asigna al articulo el id de la cuota extra que aplicó y el valor usado
                        article.ExtraQuotaId = extraQuoteObj.ExtraQuotaId;

                        //La diferencia ya es cero
                        diference = 0;

                        //No hay necesidad de seguir buscando cupos, la difererncia esta cubierta
                        break;
                    }
                    //Si la diferencia es mayor  que la cuota extra (La diferencia es cubierta parcialmente)
                    else
                    {
                        //Se resta a la diferencia lo cubierto por el cupo
                        diference = diference - extraQuoteObj.UsedQuote;

                        //Se asigna al articulo el valor usado de la cuota extra (Para este caso es lo disponible de la cuota)
                        article.UsedExtraQuota = extraQuoteObj.UsedQuote;

                        //Se asigna al articulo el id de la cuota extra que aplicó y el valor usado
                        article.ExtraQuotaId = extraQuoteObj.ExtraQuotaId;

                        //Se usa todo el cupo 
                        extraQuoteObj.UsedQuote = 0;
                    }
                }
            }

            return Math.Round(diference, 2);
        }

        

        #region Dynamic Invocation WSDL file
        private void parameters()
        {
            if (operat != null)
            {
                MethodName = operat;
                param = methodInfo[0].GetParameters();/*parametros [0] int1, [1] int2*/
                //myProperty = new properties(param.Length);
                // Get the Parameters Type
                paramTypes = new Type[param.Length];
                for (int i = 0; i < paramTypes.Length; i++)
                    paramTypes[i] = param[i].ParameterType;/*[0]name = "String" Fullname="System.String" [1]name = "String" Fullname="System.String"*/
            }
        }


        private void DynamicInvocation()
        {
            try
            {
                string url = _blFIFAP.getParam("LD_URL_WSDL_DATACRED");
                string methodName = _blFIFAP.getParam("WEB_METHOD_DATACRED");
                Uri uri = new Uri(url.ToString());
                WebRequest webRequest = WebRequest.Create(uri);
                System.IO.Stream requestStream = webRequest.GetResponse().GetResponseStream();
                // Get a WSDL file describing a service
                ServiceDescription sd = ServiceDescription.Read(requestStream);
                SdName = sd.Services[0].Name;
                /*Nombre del servicio <service name=""> */
                // Initialize a service description servImport
                ServiceDescriptionImporter servImport = new ServiceDescriptionImporter();
                servImport.AddServiceDescription(sd, String.Empty, String.Empty);
                servImport.ProtocolName = "Soap";
                servImport.CodeGenerationOptions = CodeGenerationOptions.GenerateProperties;
                CodeNamespace nameSpace = new CodeNamespace();
                CodeCompileUnit codeCompileUnit = new CodeCompileUnit();
                codeCompileUnit.Namespaces.Add(nameSpace);
                // Set Warnings
                ServiceDescriptionImportWarnings warnings = servImport.Import(nameSpace, codeCompileUnit);
                if (warnings == 0)
                {
                    StringWriter stringWriter = new StringWriter(System.Globalization.CultureInfo.CurrentCulture);
                    Microsoft.CSharp.CSharpCodeProvider prov = new Microsoft.CSharp.CSharpCodeProvider();
                    prov.GenerateCodeFromNamespace(nameSpace, stringWriter, new CodeGeneratorOptions());
                    // Compile the assembly with the appropriate references
                    string[] assemblyReferences = new string[2] { "System.Web.Services.dll", "System.Xml.dll" };
                    CompilerParameters param = new CompilerParameters(assemblyReferences);
                    param.GenerateExecutable = false;
                    param.GenerateInMemory = true;
                    param.TreatWarningsAsErrors = false;
                    param.WarningLevel = 4;
                    CompilerResults results = new CompilerResults(new TempFileCollection());
                    results = prov.CompileAssemblyFromDom(param, codeCompileUnit);
                    Assembly assembly = results.CompiledAssembly;
                    service = assembly.GetType(SdName);
                    methodInfo = service.GetMethods(BindingFlags.Instance | BindingFlags.Public | BindingFlags.DeclaredOnly);
                    foreach (MethodInfo t in methodInfo)
                    {
                        if (t.Name == "Discover")
                            break;
                        /*Operacion  <operation name="">*/
                        if (t.Name == methodName) //cambiar la operación por consultar
                            operat = t.Name;
                    }
                }
                else
                    MessageBox.Show(" " + warnings);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + " " + ex.ToString());
            }
        }
        private void consumeService()
        {
            object[] param1 = new object[param.Length];
            try
            {
                param1[0] = _blFIFAP.getParam("WS_USER_DATACRED"); //idsus 
                param1[1] = _blFIFAP.getParam("WS_PASSW_DATACRED");//clasus 
                //param1[2] = openSimpleTextBox2.Text;//tipoid
                param1[2] = cbTypeDocument.Value;
                //
                param1[3] = tbNumberDocument.Text;//id
                param1[4] = tbLastName.Text;//papellido
                /*param1[0] = openSimpleTextBox2.TextBoxValue;//tipoid
                param1[1] = openSimpleTextBox1.TextBoxValue;//id*/
                //for (int i = 0; i < param.Length; i++)
                //{
                //    param1[i] = Convert.ChangeType(myProperty.MyValue[i], myProperty.TypeParameter[i]);/*Valores y tipo de los parametros*/
                //}
                foreach (MethodInfo t in methodInfo)
                {
                    if ((t.Name == MethodName) && (MethodName == operat))
                    {
                        //Invoke Method
                        Object obj = Activator.CreateInstance(service);
                        Object response = t.Invoke(obj, param1);
                        if (response != null)
                            resultado = response.ToString();
                        break;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Warning", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        #endregion

        private Double calTotal()
        {
            Double total = 0;
            Double payment = 0;

            foreach (Article x in this.articleBindingSource)
            {
                total = total + x.SubTotal + x.TaxValue;
            }

            Double.TryParse(_dataFIFAP.Payment.ToString(), out payment);

            return total - payment;
        }

        /// <summary>
        /// Valida si el artículo ya fue seleccionado
        /// </summary>
        /// <param name="articleNew">Artículo a adicionar a la lista</param>
        /// <returns>Índice del artículo en la lista. -1 si no encuentra</returns>
        private int articleAlreadySel(Article articleNew)
        {
            Article articleSel;

            for (int index = 0; index < articleBindingSource.Count; index++)
            {
                articleSel = (Article)articleBindingSource[index];
                if (articleNew.ArticleId == articleSel.ArticleId)
                {
                    return index;
                }
            }
            return -1;
        }

        private void FIFAP_Load(object sender, EventArgs e)
        {
            if (!correcto)
            {
                Close();
            }
        }

        private void uceTransferQuota_CheckedChanged(object sender, EventArgs e)
        {
            if (autoTransfer == "N")
            {
                if (uceTransferQuota.Checked == true)
                {
                    ucePointDelivery.Enabled = false;
                    ucePointDelivery.Checked = false;
                    ostbCosignerIdentification.Enabled = false;
                    ocCosignerIdentType.Enabled = false;
                }
                else
                {
                    ostbCosignerIdentification.Enabled = true;
                    ocCosignerIdentType.Enabled = true;
                    //vhurtadoSAO213189, se habilita el campo Entrega en Punto, según lo configurado en FICBS
                    ucePointDelivery.Enabled = _dataFIFAP.EditPointDel;
                    if (_dataFIFAP.LegalizeOrder)
                    {
                        ucePointDelivery.Checked = _dataFIFAP.PointDelivery;
                    }
                    else
                    {
                        ucePointDelivery.Checked = _dataFIFAP.PointDelivery;
                    }
                }
            }
        }

        private void opcChanelSale_ValueChanged(object sender, EventArgs e)
        {
            opcPromissoryType.ReadOnly = false;

            if (String.IsNullOrEmpty(Convert.ToString(opcChanelSale.Value)))
            {
                opcPromissoryType.ReadOnly = false;
            }
            /*else if (Int64.Parse(Convert.ToString(opcChanelSale.Value)) == doorTodoorChanel)
            {
                opcPromissoryType.Value = "I";
                opcPromissoryType.ReadOnly = true;
            }*/
        }

        private void ostbSaleDate_TextBoxValueChanged(object sender, EventArgs e)
        {

        }

        private void tbSubcategory_Load(object sender, EventArgs e)
        {

        }

        private void tbSubsAddress_Load(object sender, EventArgs e)
        {

        }

        private void ogArticles_AfterEnterEditMode(object sender, EventArgs e)
        {
            UltraGrid grid = sender as UltraGrid;
            UltraGridCell cell = grid.ActiveCell;
            if (cell != null
               && cell.IsInEditMode
               && (cell.ValueListResolved is UltraDropDownBase
               || cell.EditorControlResolved is UltraDropDownBase)
                )
            {
                grid.PerformAction(UltraGridAction.ToggleDropdown);
                grid.PerformAction(UltraGridAction.CloseDropdown);
                grid.PerformAction(UltraGridAction.EnterEditModeAndDropdown);
            }
        }

        /// <summary>
        /// Ecento cuando hay error en la celda
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ogArticles_Error(object sender, Infragistics.Win.UltraWinGrid.ErrorEventArgs e)
        {
            e.Cancel = true;
        }

        /// <summary>
        /// Setea la lista de artículos en el bindingSource enviados desde FIHOS
        /// </summary>
        /// <param name="articles">Lista de artículos</param>
        internal void SetFIHOSArticles(List<ArticleValue> articles)
        {
            //general.mensajeOk("Paso 1. SE PASAN LOS ARTICULOS: "+articles.Count);
            Int32 position;
            foreach (ArticleValue article in articles)
            {
                //general.mensajeOk("Paso 2. dentro del for");
                articleBindingSource.AddNew();
                position = articleBindingSource.Position;
                articleBindingSource[position] = article.ArticleObject;

                //  Si se puede modificar el valor
                if (!article.ArticleObject.EditValue)
                {
                    //general.mensajeOk("Paso 3. Se Pudo modificar");
                    ogArticles.DataBind();
                    ogArticles.Rows[position].Cells["ValueArticle"].Activation = Activation.NoEdit;
                }
                /*else
                {
                    general.mensajeOk("Paso 4. No se pudo modificar");
                }*/
            }
        }

        /// <summary>
        /// Setea la lista de artículos en el bindingSource enviados desde FIHOS
        /// </summary>
        /// <param name="articles">Lista de artículos</param>
        //internal void SetFIHOSPlanFinan(long nuIdPlanFinan)
        //{
        //    if (nuIdPlanFinan > 0)
        //        PlanFinanciacion.Value = nuIdPlanFinan;
        //    else
        //        PlanFinanciacion.Value = null;
            
        //}

        internal void SetFIHOSPlanFinan(String vaCuotaFija)
        {

            if (vaCuotaFija == "F")
            {
                cuotaFijaCheck.Checked = true;
                cuotaFijaCheck.Enabled = false;
            }
            else 
            {
                cuotaFijaCheck.Checked = false;
                cuotaFijaCheck.Enabled = false;
            }
        }

        /// <summary>
        /// Establece la factura pendiente
        /// </summary>
        /// <param name="pendingBill">Factura pendiente</param>
        public void SetBillSlope(Int64 pendingBill)
        {
            this.billSlope = pendingBill;

            //  Si tiene facturas pendientes
            if (this.billSlope > 0)
            {
                //  Se deshabilita flag entrega en punto y se asigna como desseleccionado
                _dataFIFAP.EditPointDel = false;
                _dataFIFAP.PointDelivery = false;
                ucePointDelivery.Checked = _dataFIFAP.PointDelivery;
                ucePointDelivery.Enabled = _dataFIFAP.EditPointDel;
            }
        }

        private void ogArticles_BeforePerformAction(object sender, BeforeUltraGridPerformActionEventArgs e)
        {
            ogArticles.EventManager.SetEnabled(GridEventIds.BeforePerformAction, false);

            try
            {
                //Verifica que exista una grilla, que haya una celda activa y a su vez que haya habido un cambio en ella
                if (this.ogArticles == null || this.ogArticles.ActiveCell == null || !this.ogArticles.ActiveCell.DataChanged)
                {
                    return;
                }

                //Verifica si la celda es una lista de valores y ademas si se se presiona la tecla de ir a la proxima celda o la de ir a la anterior celda
                if (this.ogArticles.ActiveCell.Column.Style == Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate &&
                    this.ogArticles.ActiveCell.EditorResolved.IsInEditMode && //Verifica que esta en modo de edicion para poder realizar alguna validar
                    (e.UltraGridAction == UltraGridAction.NextCellByTab || e.UltraGridAction == UltraGridAction.PrevCellByTab))
                {
                    this.ogArticles.ActiveCell.EditorResolved.DropDown();//Se selecciona el item en la lista de valores
                }
            }
            catch
            {
                //Este error sucede porque pierde alguna propiedad interna el editor para evitar que se genere una cola de errores se prefiere devolver al
                //valor original que tenia la celda
                if (!this.ogArticles.ActiveCell.EditorResolved.IsValid)//Si el valor no es valido
                {
                    this.ogArticles.ActiveCell.CancelUpdate();//devuelve al valor original que tenia la celda
                }
            }
            finally
            {
                ogArticles.EventManager.SetEnabled(GridEventIds.BeforePerformAction, true);
            }
        }

        private void tcPpal_ActiveTabChanged(object sender, Infragistics.Win.UltraWinTabControl.ActiveTabChangedEventArgs e)
        {
            if (e.PreviousActiveTab != null && e.PreviousActiveTab.Index == 5)
            {
                e.PreviousActiveTab.Enabled = false;
            }
        }

        private bool ValidRow(bool raiseError)
        {
            bool isValid = true;

            if (this.ogArticles.ActiveRow != null)
            {
                if (OpenConvert.ToDouble(this.ogArticles.ActiveRow.Cells["ValueArticle"].Value) == 0.0)
                {
                    if (raiseError)
                    {
                        general.mensajeERROR("El valor Unitario del Artículo no puede ser cero");
                    }
                    isValid = false;

                }
            }
            return isValid;
        }

        private void ogArticles_BeforeRowDeactivate(object sender, CancelEventArgs e)
        {
            if (!ValidRow(false))
            {
                e.Cancel = true;
            }
        }

        #endregion

        #region Eventos

        #region Deudor

        /// <summary>
        /// Evento para CheckBox de titular de la factura
        /// </summary>
        /// <param name="sender">Objeto que lanza el evento</param>
        /// <param name="e">Evento</param>
        private void uceBillHolder_CheckedChanged(object sender, EventArgs e)
        {
            /*
            //SE VERIFICA SI SE SOPORTA QUE ES EL TITULAR DE LA FACTURA
            if (uceBillHolder.Checked)
            {
                ocDeudorHolderRelation.ReadOnly = true;
            }
            else
            {
                //SI NO SE ES TITULAR SE LIMPIAN LOS CAMPOS
                ClearDebtorInfo(true);
            }*/


            //consulta con los datos del titular
            LoadDebtorData(Convert.ToString(ocIdenType.Value), tbSubsId.TextBoxValue);


            //if (uceBillHolder.Checked) //Cuando SELECCIONAN EL FLAG
            //{


            //    /*jhinestroza: se bloque el campo relacion con el titular y se asigna 7-otros*/
            //    ocDeudorHolderRelation.ReadOnly = true;
            //    ocDeudorHolderRelation.Value = "7";

            //    //Se carga el nuevo nombre y nuevo apellido en la informacion del deudor
            //    ostbDeudorName.TextBoxValue = tbSubsNewName.TextBoxValue;
            //    ostbDeudorLastName.TextBoxValue = tbSubsLastName.TextBoxValue;

            //    // Se bloquean los campos ostbDeudorName, ostbDeudorLastName
            //    ostbDeudorName.ReadOnly = true;
            //    ostbDeudorLastName.ReadOnly = true;
            //}
            //else
            //{
            //    // Se limpia la infomracion
            //    //ClearDebtorInfo(true);


            //    //Puede editar el campo relacion con el titular
            //    ocDeudorHolderRelation.ReadOnly = false;
                
            //    if (cambioId ) //cargarDataTitular)
            //    {
            //        //consulta con los datos del titular
            //        LoadDebtorData(Convert.ToString(ocIdenType.Value), tbSubsId.TextBoxValue);

            //        //se asigna la identificacion consultada en data credito
            //        ocDeudorIdentType.Value = ocIdenType.Value;
            //        ostbDeudorIdentification.TextBoxValue = tbNumberDocument.TextBoxValue;
            //    }
            //    else
            //    {
            //        //consulta con los datos ingresados
            //        LoadDebtorData(Convert.ToString(cbTypeDocument.Value), tbNumberDocument.TextBoxValue);

            //        ocDeudorIdentType.Value = cbTypeDocument.Value;
            //        ostbDeudorIdentification.TextBoxValue = tbNumberDocument.TextBoxValue;

            //    }

            //    //21-07-2015 Llozada[Ara 8195]: Se desbloquean los campos ostbDeudorName, ostbDeudorLastName
            //    ostbDeudorName.ReadOnly = false;
            //    ostbDeudorLastName.ReadOnly = false;
            //}
            
        }

        /***********************************************************************************
        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========     ===================   ===============================================
        04-10-2014    Llozada               RQ 1218: Se envía en el campo deudor solidario N.
        ***********************************************************************************/
        private void obDeudor_Click(object sender, EventArgs e)
        {
            //CASO 200-1564
            Boolean cambioNombreDeudor = false;
            //Fin CASO 200-1564
            
            Boolean person = true;
            Boolean comer = true;
            if (cbDeudorSolidario.Checked)
            {
                if (String.IsNullOrEmpty(ocCausalDeudorSolidario.Text.ToString()))
                {
                    comer = false;
                    general.mensajeERROR("Faltan datos requeridos, No ha seleccioado la causal para Deudor Solidario");
                    return;
                }
            }
            if (String.IsNullOrEmpty(ostbDeudorName.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre del deudor");
            }
            else if (String.IsNullOrEmpty(ostbDeudorLastName.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el apellido del deudor");
            }
            else if (String.IsNullOrEmpty(ostbDeudorDependentPerson.TextBoxValue) || (Convert.ToInt64(ostbDeudorDependentPerson.TextBoxValue) < 0))
            {
                comer = false;

                general.mensajeERROR("Faltan datos requeridos, no ha digitado el número de personas a cargo del deudor");
            }
            else if (String.IsNullOrEmpty(Convert.ToString(ohlbDeudorIssuePlace.Value)))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el lugar de expedición de la cédula del deudor");
            }
            else if (ostbDeudorIssueDate.TextBoxObjectValue == null)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado la fecha de expedición de la cédula del deudor");
            }
            else if (!(Convert.ToInt64(ocDeudorIdentType.Value) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el tipo de identificación");
            }
            else if (String.IsNullOrEmpty(ostbDeudorIdentification.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado la identificación");
            }
            else if (String.IsNullOrEmpty(Convert.ToString(ocDeudorCivilState.Value)))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el estado civil del deudor");
            }
            else if (ostbDeudorBirthDate.TextBoxObjectValue == null)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado la fecha de nacimiento");
            }
            else if (String.IsNullOrEmpty(Convert.ToString(ocDeudorGender.Value)))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el genero");
            }
            else if (String.IsNullOrEmpty(oabDeudorAddress.Address_id))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado la dirección");
            }
            else if (String.IsNullOrEmpty(ostbDeudorPhone.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no digitado el teléfono");
            }
            else if (!(Convert.ToInt64(ocDeudorDegreeSchool.Value) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el nivel de educación");
            }
            else if (!(Convert.ToInt64(ocDeudorEstratum.Value) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el estrato");
            }
            else if (String.IsNullOrEmpty(ostbDeudorOldHouse.TextBoxValue) || (Convert.ToInt64(ostbDeudorOldHouse.TextBoxValue) < 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado la antiguedad de la vivienda (meses)");
            }
            else if (!(OpenConvert.ToLong(ocDeudorHouseType.Value) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el tipo de vivienda");
            }
            else if (uceBillHolder.Checked == false && !(OpenConvert.ToLong(ocDeudorHolderRelation.Value) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado la relación con el titular de la factura");
            }
            //07-11-2014 Llozada [RQ 122]: Información Laboral No obligatoria en venta de contado
            else if (String.IsNullOrEmpty(Convert.ToString(cliDeudorInfo.ocOccupation.Value)) && !pagoContadoCheck.Checked)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado la ocupación");
            }
            //07-11-2014 Llozada [RQ 122]: Información Laboral No obligatoria en venta de contado
            else if ((Convert.ToString(cliDeudorInfo.ocOccupation.Value).Equals(cliDeudorInfo.employeeOccupId)) && String.IsNullOrEmpty(cliDeudorInfo.opstbCompanyName.TextBoxValue) && !pagoContadoCheck.Checked)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre de la empresa donde trabaja");
            }
            //07-11-2014 Llozada [RQ 122]: Información Laboral No obligatoria en venta de contado
            else if ((Convert.ToString(cliDeudorInfo.ocOccupation.Value).Equals(cliDeudorInfo.employeeOccupId)) && String.IsNullOrEmpty(cliDeudorInfo.oabCompanyAddress.Address_id) && !pagoContadoCheck.Checked)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado la dirección de la empresa donde trabaja");
            }
            //07-11-2014 Llozada [RQ 122]: Información Laboral No obligatoria en venta de contado
            else if (Convert.ToString(cliDeudorInfo.ocOccupation.Value).Equals(cliDeudorInfo.employeeOccupId) && cliDeudorInfo.ocContractType.Value == null && !pagoContadoCheck.Checked)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el tipo de contrato");
            }
            //07-11-2014 Llozada [RQ 122]: Información Laboral No obligatoria en venta de contado
            else if (Convert.ToString(cliDeudorInfo.ocOccupation.Value).Equals(cliDeudorInfo.indepentOccupId) && String.IsNullOrEmpty(cliDeudorInfo.ostbActivity.TextBoxValue) && !pagoContadoCheck.Checked)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado una actividad");
            }
            //07-11-2014 Llozada [RQ 122]: Información Laboral No obligatoria en venta de contado
            else if (Convert.ToString(cliDeudorInfo.ocOccupation.Value).Equals(cliDeudorInfo.employeeOccupId) && !(Convert.ToInt64(cliDeudorInfo.ostbOldLabor.TextBoxValue) > 0) && !pagoContadoCheck.Checked)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no digitado la antiguedad laboral");
            }
            //07-11-2014 Llozada [RQ 122]: Información Laboral No obligatoria en venta de contado
            else if (!(Convert.ToDouble(cliDeudorInfo.ostbMonthlyIncome.TextBoxValue) > 0) && !pagoContadoCheck.Checked)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado los ingresos mensuales");
            }
            //07-11-2014 Llozada [RQ 122]: Información Laboral No obligatoria en venta de contado
            else if (!(Convert.ToDouble(cliDeudorInfo.ostbMonthlyExpenses.TextBoxValue) > 0) && !pagoContadoCheck.Checked)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado los gastos mensuales");
            }
            else if (String.IsNullOrEmpty(ostbPagare.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan codigo de consecutivo de venta");
                return;
            }

            ////CASO 200-1564
            ////Validacion de referencia personla en PU del DEUDOR
            if (String.IsNullOrEmpty(crDeudorInfo.ostbPersonalName.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre de la referencia personal");
                return;
            }
            if (String.IsNullOrEmpty(crDeudorInfo.ostbPersonalPhone.TextBoxValue) && String.IsNullOrEmpty(crDeudorInfo.ostbPersonalCelPhone.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, se debe digitar un teléfono fijo o un teléfono celular para la referencia personal");
                return;
            }
            /////////////////////////////////////////////////////////

            if (_dataFIFAP.PromissoryType.Equals("I"))
            {
                _blFIFAP.validateNumberFNB(Convert.ToInt64(ostbSaleIdentification.TextBoxValue.ToString()), Convert.ToInt64(opcPointSale.Value.ToString()), 7055);
            }


            if (uceBillHolder.Checked) // Pregunta si el FLAG "Es titular" esta seleccionado
            {
                
                //Inicio CASO 200-85
                //Se adiciona codigo para validar identificacion cuando seleccionamos flag del TITULAR

                //varibale que contiene el porcentaje o cantidad de erroes que se puede tolerar
                porcenTolerancia = (Int64)OpenConvert.ToInt64Nullable(general.getParam("PORCENTAJE_TOLERANCIA_ERROR", "Int64"));

                cadena_A = tbSubsId.TextBoxValue;//identificacion de datosbasicos
                cadena_B = ostbDeudorIdentification.TextBoxValue;//identificacion ingresada

                //jhinestroza [3821,3822,3823]: compara la identificacion
                numCaracteres = _blFIFAP.fnuComparacionCadenas(cadena_A, cadena_B, out porcenSimilaridad);
                //Fin CASO 200-85

                //Valida si son los mismos tipos de identificacion
                if (Convert.ToString(cbTypeDocument.Value).Equals(Convert.ToString(ocIdenType.Value)))
                {
                    if ((100 - (porcenSimilaridad * 100)) == 100)
                    {
                        cambioId = false;
                    }
                    else
                    {
                        // valida si el cambio de identificacion esta dentro de lo tolerable
                        if ((100 - (porcenSimilaridad * 100)) < porcenTolerancia)
                        {
                            general.mensajeERROR("La Venta Se Ha Marcardo Como Venta a Titular, Pero La identificación ingresada no corresponde a la del titular del contrato");
                            return;
                        }
                        if ((100 - (porcenSimilaridad * 100)) > porcenTolerancia)
                        {
                            cambioId = true;
                        }
                    }
                }
                else
                {
                    //cambioId = false;
                    //cambioNombre = false; // NO se registra el cambio de nombre
                    // Los tipos de identificaion no corresponden
                    general.mensajeERROR("La Venta Se Ha Marcardo Como Venta a Titular, Pero el tipo de identificación ingresado no corresponde al titular del contrato");
                    return;
                }

                //CASO 200-1564
                //Validacoin del nuevo nombre y apellido que no fuero obetenidos de DATACREDITO
                //if (String.IsNullOrEmpty(tbSubsNewName.TextBoxValue) && String.IsNullOrEmpty(tbSubsLastName.TextBoxValue))//no hay cambios
                //{
                //    cambioNombre = false;
                //}
                //else
                //{
                cadena_A = ostbDeudorName.TextBoxValue + " " + ostbDeudorLastName;// Nombre de datosbasicos             
                cadena_B = tbNewNameDeudor.TextBoxValue + " " + tbNewLastNameDeudor.TextBoxValue;// Nombre ingresado + Apellido ingresado

                //compara los nombres
                numCaracteres = _blFIFAP.fnuComparacionCadenas(cadena_A, cadena_B, out porcenSimilaridad);
                if ((100 - (porcenSimilaridad * 100)) != 100)
                {
                    cambioNombreDeudor = true;
                    //general.mensajeERROR("cambioNombre = " + true);
                }
                else
                {
                    cambioNombreDeudor = false;
                    //general.mensajeERROR("cambioNombre = " + false);
                }
                //}
                //Fin CASO 200-1564


            }
            else
            {
                // NO Realiza ningun cambio
                cambioId = false;
                cambioNombre = false; // NO se registra el cambio de nombre

                /*
                // jhinestroza: Valida si realiza el cambio de nombre o Identificacion
                if (Convert.ToString(ocDeudorIdentType.Value).Equals(Convert.ToString(ocIdenType.Value)) && uceBillHolder.Checked)
                {
                    //varibale que contiene el porcentaje o cantidad de erroes que se puede tolerar
                    porcenTolerancia = (Int64)OpenConvert.ToInt64Nullable(general.getParam("PORCENTAJE_TOLERANCIA_ERROR", "Int64"));
                    cadena_A = tbSubsId.TextBoxValue;//identificacion de datosbasicos
                    cadena_B = ostbDeudorIdentification.TextBoxValue;//identificacion deudor
                    numCaracteres = _blFIFAP.fnuComparacionCadenas(cadena_A, cadena_B, out porcenSimilaridad);

                    if ((100 - (porcenSimilaridad * 100)) >= porcenTolerancia)
                    {
                        if ((100 - (porcenSimilaridad * 100)) == 100)// es la misma identificacion
                        {
                            cambioId = false;
                        }
                        else
                        {
                            cambioId = true; // Identificacion similar
                        }
                    }
                    else // es menor al porcentaje, por ende no realiza el cambio de identificacion
                    {
                        cambioId = false;
                    }
                }
                else
                {
                    cambioId = false;
                    cambioNombre = false; // NO se registra el cambio de nombre
                }*/
            }

            //string ReferenceValidation = crDeudorInfo.validateFields();

            ////07-11-2014 Llozada [RQ 122]: Información de Referencia No obligatoria en venta de contado
            //if (!string.IsNullOrEmpty(ReferenceValidation) && !pagoContadoCheck.Checked)
            //{
            //    comer = false;
            //    person = false;
            //    general.mensajeERROR(ReferenceValidation);
            //}
            
            if (comer == true && person == true)
            {
                if (cambioNombreDeudor)
                {
                    _promissoryDeudor.DebtorName = tbNewNameDeudor.TextBoxValue;
                    _promissoryDeudor.DebtorLastName = tbNewLastNameDeudor.TextBoxValue;
                }
                else
                {
                    _promissoryDeudor.DebtorName = ostbDeudorName.TextBoxValue;
                    _promissoryDeudor.DebtorLastName = ostbDeudorLastName.TextBoxValue;
                }
                _promissoryDeudor.BirthdayDate = Convert.ToDateTime(ostbDeudorBirthDate.TextBoxValue);
                _promissoryDeudor.IdentType = Convert.ToString(ocDeudorIdentType.Value);

                ///_promissoryDeudor.Identification = ostbDeudorIdentification.TextBoxValue;
                // jhinestroza [3821,3822,3823]: se valida si el deudor crea un cliente nuevo o se llena con los datos que se ingresaron
                if (cambioId)//identificacion del titular = identificacion del deudor
                {
                    // al deudor se le asigna la identificacion del deudor
                    //_promissoryDeudor.Identification = tbSubsId.TextBoxValue;
                    _promissoryDeudor.Identification = ostbDeudorIdentification.TextBoxValue;
                }
                else
                {
                    //
                    _promissoryDeudor.Identification = ostbDeudorIdentification.TextBoxValue;
                }

                _promissoryDeudor.Gender = Convert.ToString(ocDeudorGender.Value);
                _promissoryDeudor.ForwardingPlace = Convert.ToInt64(ohlbDeudorIssuePlace.Value);
                _promissoryDeudor.CivilStateId = Convert.ToInt64(ocDeudorCivilState.Value);
                _promissoryDeudor.PropertyPhone = ostbDeudorPhone.TextBoxValue;
                _promissoryDeudor.DependentsNumber = Convert.ToInt64(ostbDeudorDependentPerson.TextBoxValue);
                _promissoryDeudor.HousingType = Convert.ToInt64(ocDeudorHouseType.Value);
                _promissoryDeudor.HolderRelation = Convert.ToInt64(ocDeudorHolderRelation.Value);
                _promissoryDeudor.MovilPhone = cliDeudorInfo.ostbCelPhone.TextBoxValue;
                _promissoryDeudor.MonthlyIncome = Convert.ToDouble(cliDeudorInfo.ostbMonthlyIncome.TextBoxValue);
                _promissoryDeudor.ExpensesIncome = Convert.ToDouble(cliDeudorInfo.ostbMonthlyExpenses.TextBoxValue);
                if (string.IsNullOrEmpty(cliDeudorInfo.ocContractType.Value as string))
                {
                    _promissoryDeudor.ContractType = null;
                }
                else
                {
                    _promissoryDeudor.ContractType = Convert.ToInt64(cliDeudorInfo.ocContractType.Value);
                }
                
                _promissoryDeudor.CategoryId = _dataFIFAP.CategoryId;
                _promissoryDeudor.SubcategoryId = Convert.ToInt64(ocDeudorEstratum.Value);

                //aecheverry
                _promissoryDeudor.ForwardingDate = (DateTime)ostbDeudorIssueDate.TextBoxObjectValue;
                
                //if (uceBillHolder.Checked)
                //_promissoryDeudor.HolderBill = "Y";
                //else
                //    _promissoryDeudor.HolderBill = "N";                

                /*Se debe cambiar cuando deudor es diferente*/
                //
                _promissoryDeudor.SubscriberId = _dataFIFAP.SubscriberId;
                //aecheverry
                _promissoryDeudor.HousingType = Convert.ToInt64(ocDeudorHouseType.Value);
                _promissoryDeudor.SchoolDegree = Convert.ToInt64(ocDeudorDegreeSchool.Value);
                _promissoryDeudor.HousingMonth = Convert.ToInt64(ostbDeudorOldHouse.TextBoxValue);
                _promissoryDeudor.AddressId = Convert.ToInt64(oabDeudorAddress.Address_id);
                _promissoryDeudor.PropertyPhone = ostbDeudorPhone.TextBoxValue;
                _promissoryDeudor.Email = cliDeudorInfo.ostbEmail.TextBoxValue;
                if (!String.IsNullOrEmpty(cliDeudorInfo.oabCompanyAddress.Address_id))
                    _promissoryDeudor.CompanyAddressId = Convert.ToInt64(cliDeudorInfo.oabCompanyAddress.Address_id);
                _promissoryDeudor.CompanyName = cliDeudorInfo.opstbCompanyName.TextBoxValue;
                _promissoryDeudor.Activity = cliDeudorInfo.ostbActivity.TextBoxValue;
                _promissoryDeudor.Phone1 = cliDeudorInfo.ostbPhone.TextBoxValue;
                _promissoryDeudor.Phone2 = cliDeudorInfo.ostbPhone2.TextBoxValue;
                _promissoryDeudor.Occupation = Convert.ToString(cliDeudorInfo.ocOccupation.Value);
                _promissoryDeudor.OldLabor = OpenConvert.ToInt64Nullable(cliDeudorInfo.ostbOldLabor.TextBoxValue);
                _promissoryDeudor.FamiliarReference = crDeudorInfo.ostbFamiliarName.TextBoxValue;
                _promissoryDeudor.PhoneFamiRefe = crDeudorInfo.ostbFamiliarPhone.TextBoxValue;
                _promissoryDeudor.MovilPhoFamiRefe = crDeudorInfo.ostbFamiliarCelPhone.TextBoxValue;
                if (!String.IsNullOrEmpty(crDeudorInfo.oabFamiliarAddress.Address_id))
                    _promissoryDeudor.AddressFamiRef = Int64.Parse(crDeudorInfo.oabFamiliarAddress.Address_id);
                _promissoryDeudor.PromissoryType = "D";

                _promissoryDeudor.PersonalReference = crDeudorInfo.ostbPersonalName.TextBoxValue;
                _promissoryDeudor.PhonePersRefe = crDeudorInfo.ostbPersonalPhone.TextBoxValue;
                _promissoryDeudor.MovilPhoPersRefe = crDeudorInfo.ostbPersonalCelPhone.TextBoxValue;

                Int64 addressIdPersonal;

                if (Int64.TryParse(crDeudorInfo.oabPersonalAddress.Address_id, out addressIdPersonal))
                {
                    _promissoryDeudor.AddressPersRef = addressIdPersonal;
                }

                _promissoryDeudor.CommercialReference = crDeudorInfo.ostbCommercialName.TextBoxValue;
                _promissoryDeudor.PhoneCommRefe = crDeudorInfo.ostbCommercialPhone.TextBoxValue;
                _promissoryDeudor.MovilPhoCommRefe = crDeudorInfo.ostbComercialCelPhone.TextBoxValue;
                /*04-10-2014 Llozada [RQ 1218]: El deudor siempre tiene el flag deudor solidario en N*/
                _promissoryDeudor.FlagDeudorSolidario = "N";
                _promissoryDeudor.Causal = -1;

                Int64 addressIdCommercial;

                if (Int64.TryParse(crDeudorInfo.oabCommercialAddress.Address_id, out addressIdCommercial))
                {
                    _promissoryDeudor.AddressCommRef = addressIdCommercial;
                }

                yearsParameter = 0;
                try
                {
                    yearsParameter = Convert.ToDouble(general.getParam("MAX_YEARS_DEUDOR", "Int64"));
                }
                catch
                {
                    yearsParameter = 65;
                }

                years = DateTime.Today.Year - ((DateTime)ostbDeudorBirthDate.TextBoxObjectValue).Year;


                //aecheverry se obtiene correctamente la edad del  deudor
                if ( ( DateTime.Today.Month < ((DateTime)ostbDeudorBirthDate.TextBoxObjectValue).Month)
                    || ( DateTime.Today.Month == ((DateTime)ostbDeudorBirthDate.TextBoxObjectValue).Month
                        && DateTime.Today.Day < ((DateTime)ostbDeudorBirthDate.TextBoxObjectValue).Day ) )
                {
                    years = years - 1;
                }

                DeudoryearsParameter = yearsParameter;
                Deudoryears = years;

                //Boolean NoRequiereCodeudor = _blFIFAP.validateNoCosigner(Int32.Parse(Convert.ToString(ocDeudorIdentType.Value)),
                //            Convert.ToString(ostbDeudorIdentification.TextBoxValue),
                //            Convert.ToInt64(tbSubscription.TextBoxValue));

                //if (NoRequiereCodeudor)
                //{
                //    //general.mensajeOk("Existe una configuración para el cliente [Tipo Identificación: "+ocDeudorIdentType.Value+", Identificación: " + ostbDeudorIdentification.TextBoxValue + 
                //    //                  "], en LDC_NOCODE - "+"Configuración de clientes que NO requieren Codeudor.");

                //    //tcPpal.Tabs[3].Enabled = true;
                //    //tcPpal.Tabs[4].Enabled = true;
                //    //tcPpal.SelectedTab = tcPpal.Tabs[4];
                //    obGuardarSPU.Enabled = true;
                //}
                //else if (isCashPayment)
                //{
                //    //tcPpal.Tabs[3].Enabled = true;
                //    //tcPpal.Tabs[4].Enabled = true;
                //    //tcPpal.SelectedTab = tcPpal.Tabs[3];
                //    obGuardarSPU.Enabled = true;
                //}
                /*Se valida si el codeudor es obligatorio*/
                /*else if (_dataFIFAP.RequiresCosigner
                    || yearsParameter <= years
                    || (!uceBillHolder.Checked && !(tbSubsId.TextBoxValue.Equals(ostbDeudorIdentification.TextBoxValue)))//edwarh
                    || uceTransferQuota.Checked
                    || deudorSolCheck.Checked)*/
                if ((yearsParameter <= years) || (deudorSolCheck.Checked))
                {
                    tcPpal.Tabs[3].Enabled = true;
                    //tcPpal.Tabs[4].Enabled = false;
                    tcPpal.SelectedTab = tcPpal.Tabs[3];
                    obGuardarSPU.Enabled = false;                    
                }
                else
                {
                    //tcPpal.Tabs[3].Enabled = true;
                    //tcPpal.Tabs[4].Enabled = true;
                    //tcPpal.SelectedTab = tcPpal.Tabs[2];
                    blRegisterCosigner = false;
                    obGuardarSPU.Enabled = true;
                }
                ///*HAltamiranda - Validar si Deudor tiene ventas previas */                
                //if (!uceTransferQuota.Checked)
                //{
                DeudorRollover = _blFIFAP.validateSalesDebtor(ostbDeudorIdentification.TextBoxValue, Int32.Parse(Convert.ToString(ocDeudorIdentType.Value)));
                //    if (DeudorRollover)
                //    {
                //        //general.mensajeOk("Deudor Rollover");
                //    }
                //    if ((!DeudorRollover) && (yearsParameter <= years))
                //    {
                //        ocCosignerIdentType.Enabled = false;
                //        ostbCosignerIdentification.Enabled = false;
                //    }                    
                //}
            }

            //ostbNewCosignerName.Enabled = false;
            //ostbNewCosignerLastName.Enabled = false;
            //ostbNewCosignerIdentification.Enabled = false;
            //ostbNewCosignerName.Visible = false;
            //ostbNewCosignerLastName.Visible = false;
            //ostbNewCosignerIdentification.Visible = false;

        }

        private void ostbDeudorIdentification_Validating(object sender, CancelEventArgs e)
        {

        }

        private void ostbDeudorIssueDate_Validating(object sender, CancelEventArgs e)
        {
            //
            if (ostbDeudorIssueDate == null || ostbDeudorIssueDate.TextBoxObjectValue == null)
                general.mensajeERROR("Se debe definir una fecha valida");
            else
            {
                //
                if ((DateTime)ostbDeudorIssueDate.TextBoxObjectValue > DateTime.Today)
                {
                    ostbDeudorIssueDate.TextBoxObjectValue = DateTime.Today;
                    general.mensajeERROR("La fecha no puede ser mayor a la fecha actual");
                }
            }
        }

        private void ostbDeudorBirthDate_Validating(object sender, CancelEventArgs e)
        {
            //
            if (ostbDeudorBirthDate == null || ostbDeudorBirthDate.TextBoxObjectValue == null)
                general.mensajeERROR("Se debe definir una fecha valida");
            else
            {
                //
                int years = DateTime.Today.Year - ((DateTime)ostbDeudorBirthDate.TextBoxObjectValue).Year;
                if (years < 18)
                {
                    ostbDeudorBirthDate.TextBoxObjectValue = null;
                    general.mensajeERROR("El deudor debe tener mas de 18 años");
                }
            }
        }

        private void ostbDeudorDependentPerson_KeyUp(object sender, KeyEventArgs e)
        {
            //
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void ostbDeudorPhone_KeyUp(object sender, KeyEventArgs e)
        {
            //
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void ostbDeudorOldHouse_KeyUp(object sender, KeyEventArgs e)
        {
            //
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void oabDeudorAddress_ValueChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(oabDeudorAddress.Address_id))
            {
                ocDeudorEstratum.Value = null;
                ocDeudorEstratum.ReadOnly = false;
            }
            else
            {
                long? subcategory = _blFIFAP.getSubcategory(Convert.ToInt64(oabDeudorAddress.Address_id));
                
                if (subcategory.HasValue)
                {
                    ocDeudorEstratum.Value = Convert.ToString(subcategory);
                    ocDeudorEstratum.ReadOnly = true;
                }
                else
                {
                    ocDeudorEstratum.Value = null;
                    ocDeudorEstratum.ReadOnly = false;
                }
            }
        }

        #endregion

        #region Codeudor

        private void txtCosignerContract_Validating(object sender, CancelEventArgs e)
        {
            string CosignerSusc = txtCosignerContract.TextBoxValue;

            string saleSusc = Convert.ToString(_subscriptionId);

           // general.mensajeOk("CosignerSusc: " + CosignerSusc + ", oldCosignerSubsc: " + oldCosignerSubsc);

            String sbDuenoPredio = Convert.ToString(general.getParam("FNB_DUENO_PREDIO_CODEUDOR", "String"));
            String sbEsInquilino = "N";
            Int16 nuError = 0;

            if (tbSubsId.TextBoxValue != tbNumberDocument.TextBoxValue || cbTypeDocument.Text != ocIdenType.Text)
            {
                sbEsInquilino = "Y";
            }

            if (CosignerSusc != oldCosignerSubsc)
            {
                //18-11-2014 Llozada [RQ 1218]: La validación del predio como codeudor se realiza en LDC_CODEUDORES
                if (CosignerSusc != saleSusc)
                {
                     loadCosignerBySubsc();
                     oldCosignerSubsc = CosignerSusc;
                     //Inicio CASO 200-1880
                     if (deudorSolCheck.Checked)
                     {
                         Int64 nuBLFNUDEUDORSOLIDARIO = 0;
                         ////////////////////////////////////BLFNUVALIDAPAGAREUNICO(String isbIdentification, Int64 inuIdentType, String isbIdenDeudor, Int64 inuIdenTypeDeudor)
                         nuBLFNUDEUDORSOLIDARIO = _blFIFAP.BLFNUDEUDORSOLIDARIO(ostbCosignerIdentification.TextBoxValue, Convert.ToInt64(ocCosignerIdentType.Value), ostbDeudorIdentification.TextBoxValue, Convert.ToInt64(ocDeudorIdentType.Value));
                         if (nuBLFNUDEUDORSOLIDARIO == 0)
                         {
                             general.mensajeOk("El CODEUDOR ya es DEUDOR SOLIDARIO de otro DEUDOR");
                             ClearCosignerInfo(true);
                             return;
                         }
                     }
                    //Fin CASO 200-1880            
                }
                else
                {
                    if (sbEsInquilino == "Y")
                    {
                        if (sbDuenoPredio == "Y")
                        {
                            loadCosignerBySubsc();
                            oldCosignerSubsc = CosignerSusc;
                            nuError = 1;
                            //Inicio CASO 200-1880
                            if (deudorSolCheck.Checked)
                            {
                                Int64 nuBLFNUDEUDORSOLIDARIO = 0;
                                ////////////////////////////////////BLFNUVALIDAPAGAREUNICO(String isbIdentification, Int64 inuIdentType, String isbIdenDeudor, Int64 inuIdenTypeDeudor)
                                nuBLFNUDEUDORSOLIDARIO = _blFIFAP.BLFNUDEUDORSOLIDARIO(ostbCosignerIdentification.TextBoxValue, Convert.ToInt64(ocCosignerIdentType.Value), ostbDeudorIdentification.TextBoxValue, Convert.ToInt64(ocDeudorIdentType.Value));
                                if (nuBLFNUDEUDORSOLIDARIO == 0)
                                {
                                    general.mensajeOk("El CODEUDOR ya es DEUDOR SOLIDARIO de otro DEUDOR");
                                    ClearCosignerInfo(true);
                                    return;
                                }
                            }
                            //Fin CASO 200-1880
                        }
                    }

                    if (nuError == 0)
                    {
                        general.mensajeERROR("No se puede seleccionar el mismo contrato como codeudor");
                        e.Cancel = true;
                    }                  
                    
                }
            }
        }

        private void ocCosigner_Validating(object sender, CancelEventArgs e)
        {
            Int64 nuError = 0;
            //general.mensajeOk("INICIO VALIDACION");

            //Inicio CASO 200-1880
            //if (deudorSolCheck.Checked)
            //{
                Int64 nuBLFNUDEUDORSOLIDARIO = 0;
                ////////////////////////////////////BLFNUVALIDAPAGAREUNICO(String isbIdentification, Int64 inuIdentType, String isbIdenDeudor, Int64 inuIdenTypeDeudor)
                nuBLFNUDEUDORSOLIDARIO = _blFIFAP.BLFNUDEUDORSOLIDARIO(ostbCosignerIdentification.TextBoxValue, Convert.ToInt64(ocCosignerIdentType.Value), ostbDeudorIdentification.TextBoxValue, Convert.ToInt64(ocDeudorIdentType.Value));
                if (nuBLFNUDEUDORSOLIDARIO == 0)
                {
                    general.mensajeOk("El CODEUDOR ya es DEUDOR SOLIDARIO de otro DEUDOR");
                    ClearCosignerInfo(true);
                    return;
                }
            //}
            //Fin CASO 200-1880

            //22-06-2015 ABaldovino ARA 7498
            //Valida que la identificacion ingresada no se encuentre en lista negra
            //general.mensajeOk("Tipo identificacion = " + ocCosignerIdentType.Value + " Cedula = " + ostbCosignerIdentification.TextBoxValue);
            Boolean subscriberBlocked = _blFIFAP.isSubscriberBlocked(Convert.ToInt64(ocCosignerIdentType.Value), ostbCosignerIdentification.TextBoxValue);

            if (subscriberBlocked)
            {
                //KCienfuegos.ARA7498 se corrige el número de identificación que se debe mostrar
                general.mensajeERROR("El cliente con identificación " + ostbCosignerIdentification.TextBoxValue + " se encuentra bloqueado en el sistema. No es posible seguir con la creacion de solicitud de Pagare Unico.");
                nuError = 1;
                ClearCosignerInfo(true);
                return;
            }

            if (string.IsNullOrEmpty(txtCosignerContract.TextBoxValue))
            {
                //general.mensajeOk("   PASO 1   : if (string.IsNullOrEmpty(txtCosignerContract.TextBoxValue)) --->: " + (string.IsNullOrEmpty(txtCosignerContract.TextBoxValue)));
                if (ostbCosignerIdentification.TextBoxValue != oldCosignerIdent || Convert.ToString(ocCosignerIdentType.Value) != oldCosignerTypeId)
                {
                    //general.mensajeOk("   PASO 2   : ostbCosignerIdentification.TextBoxValue: " + ostbCosignerIdentification.TextBoxValue + " != " + " oldCosignerIdent: " + oldCosignerIdent);
                    if (!String.IsNullOrEmpty(ostbCosignerIdentification.TextBoxValue) && !String.IsNullOrEmpty(Convert.ToString(ocCosignerIdentType.Value)))
                    {
                        //general.mensajeOk("   PASO 3   : IF: !String.IsNullOrEmpty(ostbCosignerIdentification.TextBoxValue)-->: " + !String.IsNullOrEmpty(ostbCosignerIdentification.TextBoxValue) + "  !String.IsNullOrEmpty(Convert.ToString(ocCosignerIdentType.Value))-->: " + !String.IsNullOrEmpty(Convert.ToString(ocCosignerIdentType.Value)));
                        //general.mensajeOk("n: " + Convert.ToString(ocCosignerIdentType.Value).Equals(Convert.ToString(ocIdenType.Value)));
                        if (Convert.ToString(ostbCosignerIdentification.TextBoxValue).Equals(Convert.ToString(tbSubsId.TextBoxValue)) && Convert.ToString(ocCosignerIdentType.Value).Equals(Convert.ToString(ocIdenType.Value)))
                        {
                            nuError = 1;
                            ClearCosignerInfo(true);
                            general.mensajeERROR("El dueño de predio como codeudor requiere un contrato con cupo y solo aplica para plan inquilino");                                                            
                        }

                        if (nuError == 0)
                        {
                            /*HAltamiranda - Validacion Deudor Rollover*/
                            Boolean vc = true;                            
                            if (!DeudorRollover)
                            {
                                //general.mensajeOk("   PASO 4   : _dataFIFAP.SupplierID: " + _dataFIFAP.SupplierID + ", ostbCosignerIdentification.TextBoxValue: " + ostbCosignerIdentification.TextBoxValue + ", ocCosignerIdentType.Value: " + ocCosignerIdentType.Value);
                                if (!_blFIFAP.validateCosigner(Convert.ToInt64(_dataFIFAP.SupplierID), ostbCosignerIdentification.TextBoxValue, Int32.Parse(Convert.ToString(ocCosignerIdentType.Value))))
                                {
                                    //general.mensajeOk("   PASO 5   : IF--> " + " txtCosignerContract.ReadOnly = false; Y ClearCosignerInfo(true);");
                                    txtCosignerContract.ReadOnly = false;
                                    ClearCosignerInfo(true);
                                }
                                else { vc = true; }
                            }

                            if (vc)
                            {
                                //general.mensajeOk("   PASO 5   : ELSE-->  validateCosignerAux();");
                                //general.mensajeOk("antes de validateCosignerAux");
                                //18-11-2014 llozada [RQ 1218]: Se debe validar también cuando se ingresa la identificación
                                //validateCosignerAux();
                                //general.mensajeOk("despues de validateCosignerAux");

                                if (blValidCosigner)
                                {
                                    //general.mensajeOk("   PASO 6   :  if (blValidCosigner)-->: " + (blValidCosigner));
                                    //general.mensajeOk("   PASO 6   :  ANTES DE LoadCosignerById(false);");
                                    LoadCosignerById(false);
                                    //general.mensajeOk("   PASO 6   :  DESPUES DE LoadCosignerById(false);");
                                }
                            }

                            
                        }
                    }
                    //general.mensajeOk("   PASO 7   :  FIN :   if (!String.IsNullOrEmpty(ostbCosignerIdentification.TextBoxValue) && !String.IsNullOrEmpty(Convert.ToString(ocCosignerIdentType.Value)))");
                    if (String.IsNullOrEmpty(ostbCosignerIdentification.TextBoxValue) && String.IsNullOrEmpty(Convert.ToString(ocCosignerIdentType.Value)))
                    {
                        //general.mensajeOk("   PASO 8   :  INICIO");
                        txtCosignerContract.ReadOnly = false;
                        ClearCosignerInfo(false);
                    }
                    //general.mensajeOk("   PASO 9   :  ostbCosignerIdentification.TextBoxValue + Convert.ToString(ocCosignerIdentType.Value)");
                    oldCosignerIdent = ostbCosignerIdentification.TextBoxValue;
                    oldCosignerTypeId = Convert.ToString(ocCosignerIdentType.Value);
                }
            }
            //general.mensajeOk("   PASO 7   :  FIN ");
        }

        private void ostbCosignerBirthDate_Validating(object sender, CancelEventArgs e)
        {
            if (ostbCosignerBirthDate.TextBoxObjectValue != null)
            {
                DateTime birthdate = (DateTime)ostbCosignerBirthDate.TextBoxObjectValue;
                if (birthdate > DateTime.Now.AddYears(-18))
                {
                    ostbCosignerBirthDate.TextBoxValue = null;
                    general.mensajeERROR("El codeudor debe ser mayor de edad");
                }
            }
        }

        private void ostbCosignerDependentPerson_KeyUp(object sender, KeyEventArgs e)
        {
            //
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void ostbCosignerPhone_KeyUp(object sender, KeyEventArgs e)
        {
            //
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void ostbCosignerOldHouse_KeyUp(object sender, KeyEventArgs e)
        {
            //
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void oabCosignerAddress_ValueChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Convert.ToString(oabCosignerAddress.Address_id)))
            {
                ocCosignerEstratum.Value = null;
                ocCosignerEstratum.ReadOnly = false;
            }
            else
            {

                //CASO 200-1880
                //Validar Si el codigo de la direccion existe en al parametro
                bool BlDirCodExiste = false;
                String sbCodigoDireccionCodeudor = oabCosignerAddress.Address_id;
                String sbCOD_DIR_GEN_FIFAP = Convert.ToString(general.getParam("COD_DIR_GEN_FIFAP", "String"));
                String sbSubCadena = string.Empty;
                //int NuposicionCadena = 0;
                for (int Nuposicion = 0; Nuposicion < sbCOD_DIR_GEN_FIFAP.Length; Nuposicion++)
                {
                    if (sbCOD_DIR_GEN_FIFAP.Substring(Nuposicion, 1) == ",")
                    {
                        if (sbSubCadena == sbCodigoDireccionCodeudor)
                        {
                            BlDirCodExiste = true;
                        }
                        sbSubCadena = string.Empty;

                    }
                    else
                    {
                        sbSubCadena = sbSubCadena + sbCOD_DIR_GEN_FIFAP.Substring(Nuposicion, 1);
                    }
                }

                //MessageBox.Show("sbSubCadena[" + sbSubCadena + "] == sbCodigoDireccionCodeudor[" + sbCodigoDireccionCodeudor + "]");

                if (sbSubCadena == sbCodigoDireccionCodeudor)
                {
                    BlDirCodExiste = true;
                }
                //Fin variables y comparacion

                long? subcategory = _blFIFAP.getSubcategory(Convert.ToInt64(oabCosignerAddress.Address_id));

                if (subcategory.HasValue)
                {
                    //CASO 200-1880
                    if (BlDirCodExiste)
                    {
                        ocCosignerEstratum.Value = 1;
                        ocCosignerEstratum.ReadOnly = true;
                    }
                    //Fin CASO 200-1880
                    else
                    {
                        ocCosignerEstratum.Value = Convert.ToString(subcategory);
                        ocCosignerEstratum.ReadOnly = true;
                    }
                }
                else
                {
                    ocCosignerEstratum.Value = null;
                    ocCosignerEstratum.ReadOnly = false;
                }
                
            }
        }

        /***********************************************************************************
        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========     ===================   ===============================================
        04-10-2014    Llozada               RQ 1218: Se valida si el flag de deudor solidario
                                                     se ha seleccionado
        ***********************************************************************************/
        private void obCosigner_Click(object sender, EventArgs e)
        {
            
            //CASO 200-1880 El Codeudor NO tiene cupo
            //Validacion Deudor Rollover
            //MessageBox.Show("DeudorRollover[" + DeudorRollover + "]");
            if (Deudoryears >= DeudoryearsParameter)
            {
                if (!DeudorRollover)
                {
                    /*05-10-2014 Llozada [1218]: EN caso de que el codeudor no pueda respaldar la deuda, el PL levanta los mensajes de error*/
                    Boolean validCodeudor = false;

                    validCodeudor = _blFIFAP.validateQuotaCosigner(ostbCosignerIdentification.TextBoxValue, Int32.Parse(Convert.ToString(ocCosignerIdentType.Value)), calTotal());

                    if (!validCodeudor)
                    {
                        return;
                    }
                }
            }
            /////////////////////
            
            blRegisterCosigner = false;
            Boolean person = true;
            Boolean comer = true;
            if (String.IsNullOrEmpty(ostbCosignerName.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre del codeudor");
            }
            else if (String.IsNullOrEmpty(ostbCosignerLastName.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el apellido del codeudor");
            }
            else if (String.IsNullOrEmpty(ostbCosignerDependentPerson.TextBoxValue) || (Convert.ToInt64(ostbCosignerDependentPerson.TextBoxValue) < 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el número de personas a cargo del codeudor");
            }
            else if (String.IsNullOrEmpty(Convert.ToString(ohlbCosignerIssuePlace.Value)))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el lugar de expedición de la cédula del codeudor");
            }
            else if (ostbCosignerIssueDate.TextBoxObjectValue == null)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado la fecha de expedición de la cédula del codeudor");
            }
            else if (!(Convert.ToInt64(ocCosignerIdentType.Value) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el tipo de identificación");
            }
            else if (String.IsNullOrEmpty(ostbCosignerIdentification.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado la identificación");
            }
            else if (String.IsNullOrEmpty(Convert.ToString(ocCosignerCivilState.Value)))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el estado civil del codeudor");
            }
            else if (ostbCosignerBirthDate.TextBoxObjectValue == null)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado la fecha de nacimiento");
            }
            else if (String.IsNullOrEmpty(Convert.ToString(ocCosignerGender.Value)))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el genero");
            }
            else if (String.IsNullOrEmpty(oabCosignerAddress.Address_id))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado la dirección");
            }
            else if (String.IsNullOrEmpty(ostbCosignerPhone.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no digitado el teléfono");
            }
            else if (!(Convert.ToInt64(ocCosignerDegreeSchool.Value) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el nivel de educación");
            }
            else if (!(Convert.ToInt64(ocCosignerEstratum.Value) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el estrato");
            }
            else if (String.IsNullOrEmpty(ostbCosignerOldHouse.TextBoxValue) || (Convert.ToInt64(ostbCosignerOldHouse.TextBoxValue) < 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado antiguedad en la vivienda (meses)");
            }
            else if (!(Convert.ToInt64(ocCosignerHouseType.Value) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el tipo de vivienda");
            }
            else if (uceBillHolder.Checked == false && !(Convert.ToInt64(ocCosignerHolderRelation.Value) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado la relación con el titular de la factura");
            }
            else if (String.IsNullOrEmpty(Convert.ToString(cliCosignerInfo.ocOccupation.Value)))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado la ocupación");
            }
            else if ((Convert.ToString(cliCosignerInfo.ocOccupation.Value).Equals(cliCosignerInfo.employeeOccupId)) && String.IsNullOrEmpty(cliCosignerInfo.opstbCompanyName.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre de la empresa donde trabaja");
            }
            else if ((Convert.ToString(cliCosignerInfo.ocOccupation.Value).Equals(cliCosignerInfo.employeeOccupId)) && String.IsNullOrEmpty(cliCosignerInfo.oabCompanyAddress.Address_id))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado la dirección de la empresa donde trabaja");
            }
            else if (Convert.ToString(cliCosignerInfo.ocOccupation.Value).Equals(cliCosignerInfo.employeeOccupId) && cliCosignerInfo.ocContractType.Value == null)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el tipo de contrato");
            }
            else if (Convert.ToString(cliCosignerInfo.ocOccupation.Value).Equals(cliCosignerInfo.indepentOccupId) && String.IsNullOrEmpty(cliCosignerInfo.ostbActivity.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado una actividad");
            }
            else if (Convert.ToString(cliCosignerInfo.ocOccupation.Value).Equals(cliCosignerInfo.employeeOccupId) && !(Convert.ToInt64(cliCosignerInfo.ostbOldLabor.TextBoxValue) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no digitado la antiguedad laboral");
            }
            else if (!(Convert.ToDouble(cliCosignerInfo.ostbMonthlyIncome.TextBoxValue) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado los ingresos mensuales");
            }
            else if (!(Convert.ToDouble(cliCosignerInfo.ostbMonthlyExpenses.TextBoxValue) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado los gastos mensuales");
            }

            //CASO 200-1564
            //Se coloca en comentario para ser validado por codigo
            //string ReferenceValidation = crCosignerInfo.validateFields();

            //if (!string.IsNullOrEmpty(ReferenceValidation))
            //{
            //    comer = false;
            //    person = false;
            //    general.mensajeERROR(ReferenceValidation);
            //}
            ////CASO 200-1564
            ////Validacion de referencia personla en PU del DEUDOR
            if (String.IsNullOrEmpty(crCosignerInfo.ostbPersonalName.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre de la referencia personal");
                return;
            }
            if (String.IsNullOrEmpty(crCosignerInfo.ostbPersonalPhone.TextBoxValue) && String.IsNullOrEmpty(crCosignerInfo.ostbPersonalCelPhone.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, se debe digitar un teléfono fijo o un teléfono celular para la referencia personal");
                return;
            }
            /////////////////////////////////////////////////////////

            //////////////////////////////////////////////////////

            //vhurtadoSAO214117
            //validateCosignerAux();

            if (comer == true && person == true)
            {
                //19-06-2015 ABaldovino ARA 7498
                //Valida que la identificacion ingresada no se encuentre en lista negra
                Boolean subscriberBlocked = _blFIFAP.isSubscriberBlocked( (Convert.ToInt64(ocCosignerIdentType.Value)), 
                                                                          ostbCosignerIdentification.TextBoxValue);

                if (subscriberBlocked)
                {
                    //KCienfuegos.ARA7498 se corrige el número de identificación que se debe mostrar
                    general.mensajeERROR("El codeudor con identificación " + ostbCosignerIdentification.TextBoxValue + " se encuentra bloqueado en el sistema. No es posible realizar la venta.");
                    comer = false;
                    return;
                }

                if (ostbCosignerName.TextBoxValue == ostbNewCosignerName.TextBoxValue)
                {
                    Cosigner.DebtorName = ostbCosignerName.TextBoxValue;
                }
                else
                {
                    if (String.IsNullOrEmpty(ostbNewCosignerName.TextBoxValue))
                    {
                        Cosigner.DebtorName = ostbCosignerName.TextBoxValue;
                    }
                    else
                    {
                        Cosigner.DebtorName = ostbNewCosignerName.TextBoxValue;
                    }
                }

                if (ostbCosignerLastName.TextBoxValue == ostbNewCosignerLastName.TextBoxValue)
                {
                    Cosigner.DebtorLastName = ostbCosignerLastName.TextBoxValue;
                }
                else
                {
                    if (String.IsNullOrEmpty(ostbNewCosignerLastName.TextBoxValue))
                    {
                        Cosigner.DebtorLastName = ostbCosignerLastName.TextBoxValue;
                    }
                    else
                    {
                        Cosigner.DebtorLastName = ostbNewCosignerLastName.TextBoxValue;
                    }                    
                }                

                Cosigner.BirthdayDate = Convert.ToDateTime(ostbCosignerBirthDate.TextBoxValue);
                Cosigner.IdentType = Convert.ToString(ocCosignerIdentType.Value);
                if (ostbCosignerIdentification.TextBoxValue == ostbNewCosignerIdentification.TextBoxValue)
                {
                    Cosigner.Identification = ostbCosignerIdentification.TextBoxValue;
                }
                else
                {
                    if (String.IsNullOrEmpty(ostbNewCosignerIdentification.TextBoxValue))
                    {
                        Cosigner.Identification = ostbCosignerIdentification.TextBoxValue;
                    }
                    else
                    {
                        Cosigner.Identification = ostbNewCosignerIdentification.TextBoxValue;
                    }
                }
                Cosigner.Gender = Convert.ToString(ocCosignerGender.Value);
                Cosigner.ForwardingPlace = Convert.ToInt64(ohlbCosignerIssuePlace.Value);
                Cosigner.ForwardingDate = (DateTime)ostbCosignerIssueDate.TextBoxObjectValue;
                Cosigner.CivilStateId = Convert.ToInt64(ocCosignerCivilState.Value);
                Cosigner.PropertyPhone = ostbCosignerPhone.TextBoxValue;
                Cosigner.DependentsNumber = OpenConvert.ToInt64Nullable(ostbCosignerDependentPerson.TextBoxValue);

                Cosigner.HolderRelation = Convert.ToInt64(ocCosignerHolderRelation.Value);
                Cosigner.MovilPhone = cliCosignerInfo.ostbCelPhone.TextBoxValue;
                Cosigner.MonthlyIncome = Convert.ToDouble(cliCosignerInfo.ostbMonthlyIncome.TextBoxValue);
                Cosigner.ExpensesIncome = Convert.ToDouble(cliCosignerInfo.ostbMonthlyExpenses.TextBoxValue);
                Cosigner.ContractType = Convert.ToInt64(cliCosignerInfo.ocContractType.Value);
                Cosigner.CategoryId = _dataFIFAP.CategoryId;
                Cosigner.SubcategoryId = Convert.ToInt64(ocDeudorEstratum.Value);

                Cosigner.HolderBill = "N";
                /*Se debe cambiar cuando Cosigner es diferente*/
                //
                Cosigner.SubscriberId = _dataFIFAP.SubscriberId;
                Cosigner.HousingType = Convert.ToInt64(ocCosignerHouseType.Value);
                Cosigner.SchoolDegree = Convert.ToInt64(ocCosignerDegreeSchool.Value);
                Cosigner.HousingMonth = Convert.ToInt64(ostbCosignerOldHouse.TextBoxValue);


                Cosigner.AddressId = Convert.ToInt64(oabCosignerAddress.Address_id);
                Cosigner.PropertyPhone = ostbCosignerPhone.TextBoxValue;
                Cosigner.Email = cliCosignerInfo.ostbEmail.TextBoxValue;
                if (!String.IsNullOrEmpty(cliCosignerInfo.oabCompanyAddress.Address_id))
                {
                    Cosigner.CompanyAddressId = Convert.ToInt64(cliCosignerInfo.oabCompanyAddress.Address_id);
                }
                Cosigner.CompanyName = cliCosignerInfo.opstbCompanyName.TextBoxValue;
                Cosigner.Activity = cliCosignerInfo.ostbActivity.TextBoxValue;
                Cosigner.Phone1 = cliCosignerInfo.ostbPhone.TextBoxValue;
                Cosigner.Phone2 = cliCosignerInfo.ostbPhone2.TextBoxValue;
                Cosigner.Occupation = Convert.ToString(cliCosignerInfo.ocOccupation.Value);
                Cosigner.OldLabor = OpenConvert.ToInt64Nullable(cliCosignerInfo.ostbOldLabor.TextBoxValue);
                Cosigner.FamiliarReference = crCosignerInfo.ostbFamiliarName.TextBoxValue;
                Cosigner.PhoneFamiRefe = crCosignerInfo.ostbFamiliarPhone.TextBoxValue;
                Cosigner.MovilPhoFamiRefe = crCosignerInfo.ostbFamiliarCelPhone.TextBoxValue;
                if (!String.IsNullOrEmpty(crCosignerInfo.oabFamiliarAddress.Address_id))
                {
                    Cosigner.AddressFamiRef = Int64.Parse(crCosignerInfo.oabFamiliarAddress.Address_id);
                }

                Cosigner.PersonalReference = crCosignerInfo.ostbPersonalName.TextBoxValue;
                Cosigner.PhonePersRefe = crCosignerInfo.ostbPersonalPhone.TextBoxValue;
                Cosigner.MovilPhoPersRefe = crCosignerInfo.ostbPersonalCelPhone.TextBoxValue;

                Int64 addressIdPersonal;

                if (Int64.TryParse(crCosignerInfo.oabPersonalAddress.Address_id, out addressIdPersonal))
                {
                    Cosigner.AddressPersRef = addressIdPersonal;
                }

                Cosigner.CommercialReference = crCosignerInfo.ostbCommercialName.TextBoxValue;
                Cosigner.PhoneCommRefe = crCosignerInfo.ostbCommercialPhone.TextBoxValue;
                Cosigner.MovilPhoCommRefe = crCosignerInfo.ostbComercialCelPhone.TextBoxValue;

                /**04-10-2014 Llozada [RQ 1218]: Se inicializa el flag deudor solidario*/
                //if (deudorSolCheck.Checked && !uceTransferQuota.Checked)
                if (cbDeudorSolidario.Checked)
                {
                    Cosigner.FlagDeudorSolidario = "Y";
                    //Cosigner.Causal = Convert.ToInt32(CausalDeudorSol.Value);
                    Cosigner.Causal = Convert.ToInt32(ocCausalDeudorSolidario.Value);
                }
                else
                {
                    Cosigner.FlagDeudorSolidario = "N";
                    Cosigner.Causal = -1;
                }

                Int64 addressIdComercial;

                if (Int64.TryParse(crCosignerInfo.oabCommercialAddress.Address_id, out addressIdComercial))
                {
                    Cosigner.AddressCommRef = addressIdComercial;
                }

                Double yearsParameter = 0;
                try
                {
                    yearsParameter = Convert.ToDouble(general.getParam("MANDATORY_COSIGNER_AGE", "Int64"));
                }
                catch
                {
                    general.mensajeERROR("No se pudo obtener el parámetro MANDATORY_COSIGNER_AGE");
                    this.Close();
                }

                int years = DateTime.Today.Year - ((DateTime)ostbCosignerBirthDate.TextBoxObjectValue).Year;

                Cosigner.PromissoryType = "C";

                if (yearsParameter <= years)
                {
                    //tcPpal.Tabs[4].Enabled = false;
                    //tcPpal.Tabs[5].Enabled = false;
                    tcPpal.SelectedTab = tcPpal.Tabs[3];
                    comer = false;
                    general.mensajeERROR("El codeudor supera la edad máxima permitida");
                    return;
                }
                else
                {
                    Int64 minimumAge = 0;
                    try
                    {
                        minimumAge = Convert.ToInt64(general.getParam("COD_DATE_MIN", "Int64"));
                    }
                    catch
                    {
                        general.mensajeERROR("No se pudo obtener el parámetro COD_DATE_MIN");
                        this.Close();
                    }
                    if (years < minimumAge)
                    {
                        general.mensajeERROR("El codeudor no tiene la edad mínima permitida");
                        return;
                    }
                    else
                    {
                        //tcPpal.Tabs[4].Enabled = true;
                        tcPpal.SelectedTab = tcPpal.Tabs[3];
                    }
                }                               

                blRegisterCosigner = true;
                obGuardarSPU.Enabled = true;
            }
        }

        #endregion

        #region Otros

        private void ostbBillId2_Leave(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(ostbBillId2.TextBoxValue) &&
                OpenConvert.ToInt64Nullable(ostbBillId2.TextBoxValue) != bill2)
            {
                bill2 = OpenConvert.ToInt64Nullable(ostbBillId2.TextBoxValue);
                validateBill();
            }
        }

        private void ostbBillId1_Leave(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(ostbBillId1.TextBoxValue) &&
                OpenConvert.ToInt64Nullable(ostbBillId1.TextBoxValue) != bill1)
            {
                bill1 = OpenConvert.ToInt64Nullable(ostbBillId1.TextBoxValue);
                validateBill();
            }
        }

        private void ostbBillDate1_Leave(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(ostbBillDate1.TextBoxValue) &&
                OpenConvert.ToDateTimeNullable(ostbBillDate1.TextBoxValue) != genDate1)
            {
                genDate1 = OpenConvert.ToDateTimeNullable(ostbBillDate1.TextBoxValue);
                validateBill();
            }
        }

        private void openButton1_Click(object sender, EventArgs e)
        {
            
            /////////////////////////////////////
            //Inicio CASO 200-85
            //Se adiciona codigo para validar identificacion cuando seleccionamos flag del TITULAR

            //varibale que contiene el porcentaje o cantidad de erroes que se puede tolerar
            porcenTolerancia = (Int64)OpenConvert.ToInt64Nullable(general.getParam("PORCENTAJE_TOLERANCIA_ERROR", "Int64"));

            cadena_A = tbSubsId.TextBoxValue;//identificacion de datosbasicos
            cadena_B = tbNumberDocument.TextBoxValue;//identificacion ingresada

            //jhinestroza [3821,3822,3823]: compara la identificacion
            numCaracteres = _blFIFAP.fnuComparacionCadenas(cadena_A, cadena_B, out porcenSimilaridad);
            //Fin CASO 200-85

            //Valida si son los mismos tipos de identificacion
            if (Convert.ToString(cbTypeDocument.Value).Equals(Convert.ToString(ocIdenType.Value)))
            {
                if ((100 - (porcenSimilaridad * 100)) == 100)
                {
                    cambioId = false;
                }
                else
                {
                    // valida si el cambio de identificacion esta dentro de lo tolerable
                    if ((100 - (porcenSimilaridad * 100)) < porcenTolerancia)
                    {
                        general.mensajeERROR("La identificación ingresada no corresponde a la del titular del contrato");
                        return;
                    }
                    if ((100 - (porcenSimilaridad * 100)) > porcenTolerancia)
                    {
                        cambioId = true;
                    }
                }
            }
            else
            {
                //cambioId = false;
                //cambioNombre = false; // NO se registra el cambio de nombre
                // Los tipos de identificaion no corresponden
                general.mensajeERROR("El tipo de identificación ingresado no corresponde al titular del contrato");
                return;
            }
            /////////////////////////////////////
            
            /*jhinestroza [3821,3822,3823]*/
            VALI_TITU_VENT = sbYes.Equals((String)OpenConvert.ToString(general.getParam("VALI_TITU_VENT", "String")));
            Int64 docType;

            tcPpal.Tabs[3].Enabled = false;
            tcPpal.Tabs[4].Enabled = false;
            tcPpal.Tabs[5].Enabled = false;
            if (cbTypeDocument.Value != null)
            {
                if (!String.IsNullOrEmpty(tbNumberDocument.TextBoxValue))
                {

                    if (!String.IsNullOrEmpty(tbLastName.TextBoxValue))
                    {
                        //varibale que contiene el porcentaje o cantidad de erroes que se puede tolerar
                        porcenTolerancia = (Int64)OpenConvert.ToInt64Nullable(general.getParam("PORCENTAJE_TOLERANCIA_ERROR", "Int64"));

                        cadena_A = tbSubsId.TextBoxValue;//identificacion de datosbasicos
                        cadena_B = tbNumberDocument.TextBoxValue;//identificacion ingresada

                        //jhinestroza [3821,3822,3823]: compara la identificacion
                        numCaracteres = _blFIFAP.fnuComparacionCadenas(cadena_A, cadena_B, out porcenSimilaridad);

                        // jhinestroza [3821,3822,3823]: Valida si es una venta a titular
                        if (VALI_TITU_VENT)
                        //jrobayo
                        //if (VALI_TITU_VENT && (tbSubsId.TextBoxValue != tbNumberDocument.TextBoxValue || cbTypeDocument.Text != ocIdenType.Text))
                        {
                            ventaTitular = true; // Se marcha el tipo de venta como venta a titular

                            if (Convert.ToString(cbTypeDocument.Value).Equals(Convert.ToString(ocIdenType.Value)))
                            {

                                if ((100 - (porcenSimilaridad * 100)) == 100)
                                {
                                    uceBillHolder.Checked = true; // selecciona el flag ¿Es Titular de la Factura?
                                    uceBillHolder.Enabled = false;// no permite editarlo
                                    cambioId = false;
                                    cargarDataTitular = true;
                                }
                                else 
                                {
                                    if ((100 - (porcenSimilaridad * 100)) < porcenTolerancia)
                                    {
                                        general.mensajeERROR("La identificación ingresada no corresponde al titular del contrato");
                                        tcPpal.Tabs[2].Enabled = false;
                                        tcPpal.Tabs[3].Enabled = false;
                                        tcPpal.Tabs[4].Enabled = false;
                                        tcPpal.Tabs[5].Enabled = false;
                                        return;
                                    }
                                    if ((100 - (porcenSimilaridad * 100)) >= porcenTolerancia)
                                    {
                                        uceBillHolder.Checked = true; // selecciona el flag ¿Es Titular de la Factura?
                                        uceBillHolder.Enabled = false;// no permite editarlo
                                        cambioId = true;
                                        cargarDataTitular = true;
                                    }
                                }
                            }
                            else
                            {
                                //se genera notifica que las identificaion ingresada no es la del titular o esta por debajo del procentaje de similaridad
                                general.mensajeERROR("La identificación ingresada no corresponde al titular del contrato");

                                tcPpal.Tabs[2].Enabled = false;
                                tcPpal.Tabs[3].Enabled = false;
                                tcPpal.Tabs[4].Enabled = false;
                                tcPpal.Tabs[5].Enabled = false;
                                return;
                            }
                        }
                        else// venta a inquilino o titular
                        {
                            /* jhinestroza [3821,3822,3823]: 
                            * Se valida que la venta sea al titular de factura, CASO 1
                            */
                            if (Convert.ToString(cbTypeDocument.Value).Equals(Convert.ToString(ocIdenType.Value))) //Valida mismo tipo de identificacion
                            {
                                if ((100 - (porcenSimilaridad * 100)) >= porcenTolerancia)// si la diferencia es mayor o iguala a valor soportado en el parametro
                                {
                                    uceBillHolder.Checked = false;// true;  // selecciona el flag ¿Es Titular de la Factura?
                                    uceBillHolder.Enabled = true;//false; // si permite editarlo

                                    ventaTitular = true; // se marca la venta como venta a titular
                                    cargarDataTitular = true;

                                    if ((100 - (porcenSimilaridad * 100)) == 100)// No se presentan, es la misma identificacion
                                    {
                                        cambioId = false;
                                    }
                                    else
                                    {
                                        cambioId = true; // Identificacion similar
                                    }
                                    
                                }
                                else // La identificacion ingresada corresponde a una cedula distinta
                                {
                                    ventaTitular = false; // venta con plan inquilino

                                    uceBillHolder.Checked = false; // NO selecciona el flag ¿Es Titular de la Factura?
                                    uceBillHolder.Enabled = true;//false; // Si permite editarlo
                                    cambioId = false;
                                }
                            }
                            else // Los tipos de documentos no son similares
                            {
                                ventaTitular = false; // venta con plan inquilino

                                uceBillHolder.Checked = false; // NO selecciona el flag ¿Es Titular de la Factura?
                                uceBillHolder.Enabled = true;//false; // SI permite editarlo
                                cambioId = false;
                            }

                        }

                        docType = Convert.ToInt64(_blFIFAP.getDocumentType(Convert.ToInt64(cbTypeDocument.Value)));

                        //18-06-2015 ABAldovino ARA 7498
                        //Valida que la identificacion ingresada no se encuentre en lista negra
                        Boolean subscriberBlocked = _blFIFAP.isSubscriberBlocked(docType, tbNumberDocument.TextBoxValue);

                        if (subscriberBlocked)
                        {
                            general.mensajeERROR("El cliente con identificación " + tbNumberDocument.TextBoxValue + " se encuentra bloqueado en el sistema. No es posible realizar la venta.");
                            return;
                        }

                        
                        Boolean validSale = _blFIFAP.isValidForSaleFNB(docType, tbNumberDocument.TextBoxValue, tbLastName.TextBoxValue);

                        string resp = string.Empty;

                        if (!validSale)
                        {
                            resp = _blFIFAP.processResponseWS(Convert.ToString(tbLastName.TextBoxValue), docType, tbNumberDocument.TextBoxValue, out resConsId);
                            if (resp == "OK")
                            {
                                validSale = true;
                            }
                        }

                        //ogValidateDocument.DataSource = BLFIFAP.ValidateDocument(docType, Convert.ToString(tbNumberDocument.TextBoxValue), Convert.ToString(tbLastName.TextBoxValue));
                        ugValidaCedula.DataSource = BLFIFAP.ValidateDocument(docType, Convert.ToString(tbNumberDocument.TextBoxValue), Convert.ToString(tbLastName.TextBoxValue));

                        //07-11-2014 Llozada [RQ 122]: Si el pago es de contado debe omitirse la validación de data crédito.
                        if (validSale || pagoContadoCheck.Checked)
                        {
                            //tcPpal.Tabs[2].Enabled = true;

                            /*
                             * 28-01-2015 edwardh [Team 3822]: No es necesaria esta validacion
                             * 
                            //Obtiene el numero de cliente a partir de la cédula ingresada en la validación
                            if (tbSubsId.TextBoxValue != tbNumberDocument.TextBoxValue || cbTypeDocument.Text != ocIdenType.Text)
                            {
                                uceBillHolder.Checked = false;
                            }
                            else
                            {
                                uceBillHolder.Checked = true;
                            }
                             */

                            // 28-01-2015 edwardh [Team 3822]: valida si la diferencia entre las identificaciones estan dentro del parametro permitido
                            //if (Convert.ToString(cbTypeDocument.Value).Equals(Convert.ToString(ocIdenType.Value)) && (100 - (porcenSimilaridad * 100)) >= porcenTolerancia)
                            if(cambioId)
                            {
                                //consulta con los datos del titular
                                LoadDebtorData(Convert.ToString(ocIdenType.Value), tbSubsId.TextBoxValue);

                                //se asigna la identificacion consultada en data credito
                                ocDeudorIdentType.Value = ocIdenType.Value;
                                ostbDeudorIdentification.TextBoxValue = tbNumberDocument.TextBoxValue;

                                //21-07-2015 Llozada[Ara 8195]: Se desbloquean los campos ostbDeudorName, ostbDeudorLastName
                                ostbDeudorName.ReadOnly = false;
                                ostbDeudorLastName.ReadOnly = false;

                            }
                            else // No hubo cambio de Identificacion
                            {
                                //consulta con los datos ingresados
                                LoadDebtorData(Convert.ToString(cbTypeDocument.Value), tbNumberDocument.TextBoxValue);

                                ocDeudorIdentType.Value = cbTypeDocument.Value;
                                ostbDeudorIdentification.TextBoxValue = tbNumberDocument.TextBoxValue;

                                //Valida si cambio el nombre y es una venta a titular
                                /*
                                if (cambioNombre && ventaTitular)
                                {
                                    ostbDeudorName.TextBoxValue     = tbSubsNewName.TextBoxValue;
                                    ostbDeudorLastName.TextBoxValue = tbSubsLastName.TextBoxValue;
                                }*/

                            }

                            /* edwardh: Para inicializar los nombres */

                            //Se valida si la venta es a titular 
                            if (VALI_TITU_VENT)
                            {
                                //Valida si se presento cambio del nombre 
                                if (cambioNombre)
                                {
                                    //Se carga el nuevo nombre y nuevo apellido en la informacion del deudor
                                    ostbDeudorName.TextBoxValue = tbSubsNewName.TextBoxValue;
                                    ostbDeudorLastName.TextBoxValue = tbSubsLastName.TextBoxValue;
                                }

                            }
                            else // Venta a inquilino o titular
                            {
                                //Valida si se presento cambio del nombre y es una venta a titular
                                if (cambioNombre && ventaTitular)
                                {

                                    //Se carga el nuevo nombre y nuevo apellido en la informacion del deudor
                                    
                                    /* No es necesario cargar la informacion */
                                    // ostbDeudorName.TextBoxValue = tbSubsNewName.TextBoxValue;
                                    // ostbDeudorLastName.TextBoxValue = tbSubsLastName.TextBoxValue;
                                }
                            }




                            /*
                             * edwardh: se carga la data dependiendo de la validadcion de similaridad
                             * LoadDebtorData(Convert.ToString(cbTypeDocument.Value), tbNumberDocument.TextBoxValue);

                             * ocDeudorIdentType.Value = cbTypeDocument.Value;
                             * ostbDeudorIdentification.TextBoxValue = tbNumberDocument.TextBoxValue;
                             */
                            if (!pagoContadoCheck.Checked)
                            {
                                general.mensajeOk("Habilitado para la venta");
                                tcPpal.Tabs[1].Enabled = false;
                                tcPpal.Tabs[2].Enabled = true;
                                tcPpal.Tabs[2].Selected = true;
                            }
                        }
                        else
                        {
                            general.mensajeERROR("No válido para la venta [" + resp + "]");
                            tcPpal.Tabs[2].Enabled = false;
                        }
                        //}//CIERRE TMP- PRUEBAS

                        //general.mensajeERROR("ugValidaCedula.Rows[0].Cells[2].ToString()[" + ugValidaCedula.Rows[0].Cells[2].ToString() + "]");
                        //general.mensajeERROR("ugValidaCedula.Rows[0].Cells[3].ToString()[" + ugValidaCedula.Rows[0].Cells[3].ToString() + "]");
                        //general.mensajeERROR("ugValidaCedula.Rows[0].Cells[8].ToString()[" + ugValidaCedula.Rows[0].Cells[8].ToString() + "]");
                        
                        //Inicio Datos del DEUDOR obtenidos de DATACREDITO
                        DataTable DSDATOSVALIDACEDULA = BLFIFAP.ValidateDocument(docType, Convert.ToString(tbNumberDocument.TextBoxValue), Convert.ToString(tbLastName.TextBoxValue));
                        if (DSDATOSVALIDACEDULA.Rows.Count > 0)
                        {
                            if (!String.IsNullOrEmpty(DSDATOSVALIDACEDULA.Rows[0]["Nombre"].ToString()))
                            {
                                ostbDeudorName.TextBoxValue = DSDATOSVALIDACEDULA.Rows[0]["Nombre"].ToString();
                                tbNewNameDeudor.TextBoxValue = ostbDeudorName.TextBoxValue;
                                if (!String.IsNullOrEmpty(DSDATOSVALIDACEDULA.Rows[0]["Primer apellido"].ToString()))
                                {
                                    ostbDeudorLastName.TextBoxValue = DSDATOSVALIDACEDULA.Rows[0]["Primer apellido"].ToString() + " " + DSDATOSVALIDACEDULA.Rows[0]["Segundo apellido"].ToString();
                                    tbNewLastNameDeudor.TextBoxValue = ostbDeudorLastName.TextBoxValue;
                                }
                                //Nuevo NOmbre y Apellido se quedaran como editables 
                                //Cambio solicitado por la funcionaria Julia Gonzales
                                //tbNewNameDeudor.ReadOnly = true;
                                //tbNewLastNameDeudor.ReadOnly = true;
                                //
                            }
                            else 
                            {
                                //Se carga el nuevo nombre y nuevo apellido en la informacion del deudor
                                //ostbDeudorName.TextBoxValue = tbSubsNewName.TextBoxValue;
                                tbNewNameDeudor.TextBoxValue = _dataFIFAP.SubName;
                                tbNewLastNameDeudor.TextBoxValue = _dataFIFAP.SubLastname;
                                tbNewNameDeudor.ReadOnly = false;
                                tbNewLastNameDeudor.ReadOnly = false;
                            }                            
                            
                            //else
                            //{
                            //    ostbDeudorLastName.TextBoxValue = tbSubsLastName.TextBoxValue;
                            //}                            
                            //if (!String.IsNullOrEmpty(DSDATOSVALIDACEDULA.Rows[0]["Fecha expedicion"].ToString()))
                            //{
                            //    ostbDeudorIssueDate.TextBoxObjectValue = DSDATOSVALIDACEDULA.Rows[0]["Fecha expedicion"].ToString();
                            //}                           
                        }
                        else
                        {
                            if (string.IsNullOrEmpty(ostbDeudorName.TextBoxValue))
                            {
                                tbNewNameDeudor.TextBoxValue = _dataFIFAP.SubName;
                                tbNewLastNameDeudor.TextBoxValue = _dataFIFAP.SubLastname;
                            }
                        }

                        //Fin Datos del DEUDOR obtenidos del DATACREDITO
                        ostbDeudorName.ReadOnly = true;
                        ostbDeudorLastName.ReadOnly = true;
                        //ostbDeudorIssueDate.ReadOnly = true;

                        ocDeudorHolderRelation.ReadOnly = true;
                        ocDeudorHolderRelation.Value = "7";

                        uceBillHolder.Checked = true;

                        //CASO 200-1564
                        //Para que siempre coloque la identificacion digitada en el DEUDOR.
                        //Tenga o no datos en DATACREDITO
                        ocDeudorIdentType.Value = cbTypeDocument.Value;
                        ostbDeudorIdentification.TextBoxValue = tbNumberDocument.TextBoxValue;
                        //////////////////////////////////////////////////////////

                    }
                    else
                    {
                        general.mensajeERROR("Digite el primer apellido");
                    }
                }
                else
                {
                    general.mensajeERROR("Digite una identificación");
                }
            }
            else
            {
                general.mensajeERROR("Digite un tipo de identificación");
            }
        }

        private void ostbSaleIdentification_Leave(object sender, EventArgs e)
        {
            //
            _dataFIFAP.SaleId = Convert.ToInt64(ostbSaleIdentification.TextBoxValue);
        }

        private void opcPromissoryType_TextChanged(object sender, EventArgs e)
        {
            //
            if (opcPromissoryType.SelectedRow != null)
            {
                //
                if (Convert.ToString(opcPromissoryType.Value) == "D")
                {
                    //
                    ostbSaleIdentification.ReadOnly = true;
                    ostbSaleDate.ReadOnly = true;

                    ostbPagare.ReadOnly = true;
                    

                    ostbRegisterDate.TextBoxObjectValue = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();
                    ostbSaleDate.TextBoxObjectValue = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();

                    _dataFIFAP.PromissoryType = "D";
                    //
                    if (_digitalPromisoryId.HasValue)
                    {
                        //
                        _dataFIFAP.SaleId = (Int64)_digitalPromisoryId;
                        ostbSaleIdentification.TextBoxValue = _digitalPromisoryId.ToString();
                        ostbPagare.TextBoxValue = _digitalPromisoryId.ToString();
                    }
                    else
                    {
                        // Obtiene Tipo Comprobante parametrizado para Pagaré Digital
                        _dataFIFAP.VoucherType = OpenConvert.ToInt64Nullable(general.getParam("VOUCHER_TYPE_DIGITAL_PROM_NOTE", "Int64"));

                        if (_dataFIFAP.VoucherType == null)
                        {
                            this.Close();
                            return;
                        }                        

                        if (/*_dataFIFAP.PointSaleId*/ opcPointSale.Value != null)
                            _digitalPromisoryId = _blFIFAP.getDigitalPromisoryId(_dataFIFAP.VoucherType, Convert.ToInt64(opcPointSale.Value));
                        else
                        {
                            general.mensajeERROR("La Unidad Operativa debe tener valor");
                            this.Close();
                            return;
                        }

                        _dataFIFAP.SaleId = (Int64)_digitalPromisoryId;
                        ostbSaleIdentification.TextBoxValue = _digitalPromisoryId.ToString();
                        ostbPagare.TextBoxValue = _digitalPromisoryId.ToString();

                        /*Procedimiento para evitar la duplicidad de consecutivos*/
                        _blFIFAP.UpRequestVoucherFNB(
                            Convert.ToInt64(_dataFIFAP.VoucherType),
                            /*Convert.ToInt64(_dataFIFAP.PointSaleId)*/Convert.ToInt64(opcPointSale.Value),
                            Convert.ToInt64(_dataFIFAP.SaleId));
                    }
                }
                else
                {
                    //
                    _dataFIFAP.PromissoryType = "I";
                    ostbSaleIdentification.TextBoxValue = "";
                    ostbSaleIdentification.ReadOnly = false;
                    ostbSaleDate.ReadOnly = false;

                    ostbPagare.TextBoxValue = "";
                    ostbPagare.ReadOnly = false;
                }
            }
        }

        private void Validate_Phone(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "Número de teléfono inválido");
                    e.Cancel = true;
                }
            }
        }

        private void Validate_CellPhone(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000000 || valor > 9999999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "Número de teléfono celular inválido");
                    e.Cancel = true;
                }
            }
        }

        private void ostbBillDate2_Leave(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(ostbBillDate2.TextBoxValue) &&
                OpenConvert.ToDateTimeNullable(ostbBillDate2.TextBoxValue) != genDate2)
            {
                genDate2 = OpenConvert.ToDateTimeNullable(ostbBillDate2.TextBoxValue);
                validateBill();
            }
        }

        private void obRegister_Click(object sender, EventArgs e)
        {


            ultraCheckEditor1.Enabled = false;
            //PROCESO PARA REGISTRAR EL XML
            string gracePeriod;
            string pointDelivery;
            string allowTransferQuota;
            String delivOrder;
            long nuIdPlanFinan;

            gracePeriod = "N";

            if (ultraCheckEditor1.Checked)
            {
                gracePeriod = "Y";
            }

            if (_dataFIFAP.AllowTransferQuota)
            {
                allowTransferQuota = "Y";
            }
            else
            {
                allowTransferQuota = "N";
            }

            if (_dataFIFAP.PointDelivery)
            {
                if (_dataFIFAP.MinValue.HasValue)
                {
                    if (Convert.ToDouble(ostbFinancingValue.TextBoxValue) <= _dataFIFAP.MinValue)
                    {
                        pointDelivery = "Y";
                    }
                    else
                    {
                        pointDelivery = "N";
                    }
                }
                else
                {
                    pointDelivery = "Y";
                }

            }
            else
            {
                pointDelivery = "N";
            }
            //DISEÑO PARA GENERAR EL XML
            String XmlRegister = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>" +  //KCienfuegos.NC4822 Se agrega el formato ISO para que permita el ingreso de carácteres especiales. Este formato no permite el &
                "<P_VENTA_FNB_100264 ID_TIPOPAQUETE=\"100264\">" +
                "<CONTRACT>" + tbSubscription.TextBoxValue + "</CONTRACT>" +
                "<IDENTIFICADOR_DEL_CLIENTE>" + _dataFIFAP.SubscriberId + "</IDENTIFICADOR_DEL_CLIENTE>" +
                "<CUPO_DE_CREDITO > " + _dataFIFAP.AvalibleQuota + "</CUPO_DE_CREDITO>" +
                "<CUPO_USADO >" + _dataFIFAP.UsedQuote + "</CUPO_USADO>" +
                "<EXTRA_CUPO_USADO >" + usedValExtraQuota + " </EXTRA_CUPO_USADO>" +
                "<CUPO_MANUAL_USADO > 0 </CUPO_MANUAL_USADO>" +
                "<IDENTIFICADOR_DE_LA_PRIMERA_FACTURA >" + _dataFIFAP.BillId1 + "</IDENTIFICADOR_DE_LA_PRIMERA_FACTURA>" +
                "<IDENTIFICADOR_DE_LA_SEGUNDA_FACTURA >" + _dataFIFAP.BillId2 + "</IDENTIFICADOR_DE_LA_SEGUNDA_FACTURA>" +
                "<OPERATING_UNIT_ID >" + _dataFIFAP.PointSaleId + "</OPERATING_UNIT_ID>" +
                "<SALE_CHANNEL_ID>" + _dataFIFAP.DefaultchanelSaleId + "</SALE_CHANNEL_ID >" +
                "<ID>" + _dataFIFAP.SellerId + "</ID>" +
                "<VENDEDOR >" + _dataFIFAP.SellerId + "</VENDEDOR>" +
                "<FECHA_DE_VENTA>" + Convert.ToDateTime(_dataFIFAP.SaleDate.ToString()).ToString("dd-MM-yyyy HH:mm:ss") + "</FECHA_DE_VENTA>" +
                "<FECHA_DE_SOLICITUD>" + Convert.ToDateTime(_dataFIFAP.RegisterDate.ToString()).ToString("dd-MM-yyyy HH:mm:ss") + "</FECHA_DE_SOLICITUD>";
            if (_dataFIFAP.PromissoryType.Equals("I"))
            {
                XmlRegister += "<ID_DEL_CONSECUTIVO_PAGARE_DIGITAL/>" +
                    "<ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL>" + _dataFIFAP.SaleId.ToString() + "</ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL>";
            }
            else if (_dataFIFAP.PromissoryType.Equals("D"))
            {
                XmlRegister += "<ID_DEL_CONSECUTIVO_PAGARE_DIGITAL>" + _dataFIFAP.SaleId.ToString() + " </ID_DEL_CONSECUTIVO_PAGARE_DIGITAL>" +
                    "<ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL/>";
            }
            XmlRegister += "<RECEPTION_TYPE_ID>" + _dataFIFAP.DefaultchanelSaleId + "</RECEPTION_TYPE_ID>" +
                "<CONTACT_ID >" + _dataFIFAP.SubscriberId + "</CONTACT_ID>" +
                "<ADDRESS_ID>" + _dataFIFAP.AddressId + "</ADDRESS_ID>" +
                "<TOMO_EL_PERIODO_DE_GRACIA>" + gracePeriod + "</TOMO_EL_PERIODO_DE_GRACIA>" +
                "<ENTREGA_EN_PUNTO>" + pointDelivery + "</ENTREGA_EN_PUNTO>" +
                "<CUOTA_INICIAL>" + _dataFIFAP.Payment + "</CUOTA_INICIAL>" +
                "<COMMENT_>" + "[FIFAP] " + tb_Observation.TextBoxValue.ToString() + "</COMMENT_>" +
                "<USUARIO_DEL_SERVICIO>" + _dataFIFAP.SubscriberId + "</USUARIO_DEL_SERVICIO>";
            foreach (Article article in articleBindingSource)
            {

                if (article.ArticleId != 0)
                {
                    //si no se utiliza periodo de gracia la fecha de primera cuota es la fecha actual o la fecha de la proxima facturación
                    if (!ultraCheckEditor1.Checked)
                    {
                        article.FirstFeedDate = _blFIFAP.FirstFeeDate(_subscriptionId, DateTime.Now);
                    }

                    /*17-02-2015 Llozada [ARA 1841]: Se toma el plan de financiación seleccionado por el funcional, y si 
                                                     este no se ha seleccionado en FIFAP, se toma el plan configurado en GECPA*/
                    /*13-10-2015 heiberb [SAO 334390]: se comentan las lineas ya que siempre se toma el plan configurado en GECPA*/
                    //if (!String.IsNullOrEmpty(OpenConvert.ToString(PlanFinanciacion.Value)))
                    //    nuIdPlanFinan = Convert.ToInt32(PlanFinanciacion.Value);
                    //else
                    nuIdPlanFinan = article.FinancingPlan;

                    XmlRegister += "<M_INSTALACION_DE_GAS_100271>" +
                        "<IDENTIFICADOR_DEL_MOTIVO />" +
                        "<ID_DE_LA_SOLICITUD_DE_FINANCIACION_NO_BANCARIA />" +
                        "<IDENTIFICADOR_DEL_ARTICULO>" + article.ArticleId + "</IDENTIFICADOR_DEL_ARTICULO>" +
                        "<VALOR_UNITARIO>" + Math.Round(article.ValueArticle, 2) + "</VALOR_UNITARIO>" + //KCienfuegos.NC4826 Se coloca el Math.round
                        "<CANTIDAD_DE_ARTICULOS>" + article.Amount + "</CANTIDAD_DE_ARTICULOS>" +
                        "<NUMERO_DE_CUOTAS>" + article.FeedsNumber + "</NUMERO_DE_CUOTAS>" +
                        "<FECHA_DE_PRIMERA_CUOTA>" + article.FirstFeedDate.ToString("dd-MM-yyy") + "</FECHA_DE_PRIMERA_CUOTA>" +
                        "<CODIGO_DEL_PLAN_DE_DIFERIDO>" + nuIdPlanFinan + "</CODIGO_DEL_PLAN_DE_DIFERIDO>" +
                        "<IVA>" + Math.Round(article.ValueArticle * (article.Tax / 100), 2) + "</IVA>" + //KCienfuegos.NC4826 Se coloca el Math.round
                        "</M_INSTALACION_DE_GAS_100271>";

                    _blFIFAP.RegisterExtraQuotaFNB(article.ExtraQuotaId, tbSubscription.TextBoxValue, article.UsedExtraQuota);
                }
            }
            XmlRegister += "</P_VENTA_FNB_100264>";

            Int64 packageId = 0;
            packageId = _blFIFAP.RegisterSale(XmlRegister);
            if (packageId != 0)
            {
                try
                {
                    //Llamar el metodo que registra por solicitud LD_BOQUOTATRANSFER.registerQuotaTransfer;
                    _blFIFAP.registerQuotaTransfer(packageId);
                    if (resConsId.HasValue)
                    {
                        _blFIFAP.setConsultSale(resConsId, packageId);
                    }

                    //Informacion adicional de la FNB
                    _blFIFAP.RegisterAdditionalFNBInformation(packageId, OpenConvert.ToInt64Nullable(txtCosignerContract.TextBoxValue), OpenConvert.ToDoubleNullable(ostbFeedMonthSafeTotal.TextBoxValue));

                    DateTime var = new DateTime();
                    DateTime.TryParse(ostbDeudorBirthDate.TextBoxValue, out var);

                    //KCienfuegos.RNP1179 14-10-2014 
                    if (ucSaleInstallation.Checked && nuGasAppliance > 0)
                    {
                        _blFIFAP.registerSaleInstall(Convert.ToInt64(packageId), _subscriptionId, Convert.ToInt64(_dataFIFAP.SupplierID));
                    }

                    //KCienfuegos.RNP1808 28-10-2014
                    if (cbxVentaEmpaq.Checked)
                    {
                        _blFIFAP.UpdateGasFNBSale(_subscriptionId, Convert.ToInt64(packageId), "Y");
                    }

                    //KCienfuegos.ARA5737 20-01-2014
                    if (dtDeliverDate.Visible & !String.IsNullOrEmpty(dtDeliverDate.Value.ToString()))
                    {
                        _blFIFAP.registerDelivDate(Convert.ToInt64(packageId), OpenConvert.DateTimeToString(Convert.ToDateTime(dtDeliverDate.Value)));
                    }


                    //Edwardh : si es una venta a titular no debe crear un cliente nuevo con la informacion del deudor
                    bool successful = true;
                    if (!ventaTitular)
                    {

                        //general.mensajeOk("saveDeudorData:  cliDeudorInfo.ocOccupation.Value" + cliDeudorInfo.ocOccupation.Value);
                        successful = _blFIFAP.saveDeudorData(
                                                                Convert.ToInt32(_promissoryDeudor.IdentType),
                                                                Convert.ToString(ostbDeudorIdentification.TextBoxValue),
                                                                Convert.ToString(ostbDeudorPhone.TextBoxValue),
                                                                Convert.ToString(ostbDeudorName.TextBoxValue),
                                                                Convert.ToString(ostbDeudorLastName.TextBoxValue),
                                                                Convert.ToString(cliDeudorInfo.ostbEmail.TextBoxValue),
                                                                Convert.ToInt32(oabDeudorAddress.Address_id),
                                                                var, //Convert.ToDateTime(ostbDeudorBirthDate.),
                                                                Convert.ToString(ocDeudorGender.Value),
                                                                Convert.ToInt32(ocDeudorCivilState.Value),
                                                                Convert.ToInt32(ocDeudorDegreeSchool.Value),
                                                                Convert.ToInt32(cliDeudorInfo.ocOccupation.Value),
                                                                "D");
                    }

                    if (!successful)
                    {
                        general.doRollback();
                        return;
                    }

                    Cosigner.PackageId = packageId;
                    _promissoryDeudor.PackageId = packageId;
                    _blFIFAP.RegisterDeudor(_dataFIFAP.SubscriberId, _promissoryDeudor);
                    //
                    if (blRegisterCosigner || _dataFIFAP.RequiresCosigner)
                    {
                        DateTime var2 = new DateTime();
                        DateTime.TryParse(ostbCosignerBirthDate.TextBoxValue, out var2);

                        bool sucessful = _blFIFAP.saveDeudorData(
                            Int32.Parse(Cosigner.IdentType),
                            Convert.ToString(ostbCosignerIdentification.TextBoxValue),
                            Convert.ToString(ostbCosignerPhone.TextBoxValue),
                            Convert.ToString(ostbCosignerName.TextBoxValue),
                            Convert.ToString(ostbCosignerLastName.TextBoxValue),
                            Convert.ToString(cliCosignerInfo.ostbEmail.TextBoxValue),
                            Convert.ToInt32(oabCosignerAddress.Address_id),
                            var2,//Convert.ToDateTime(ostbCosignerBirthDate),
                            Convert.ToString(ocCosignerGender.Value),
                            Convert.ToInt32(ocCosignerCivilState.Value),
                            Convert.ToInt32(ocCosignerDegreeSchool.Value),
                            Convert.ToInt32(cliCosignerInfo.ocOccupation.Value),
                            "C");

                        if (sucessful)
                        {
                            _blFIFAP.RegisterCosigner(Cosigner);
                            //general.mensajeOk("OK se registra el codeudor. uceTransferQuota.Checked: " + uceTransferQuota.Checked);
                            if (uceTransferQuota.Checked)
                            {
                                String hash_deudor = Int64.Parse(Convert.ToString(ocIdenType.Value)) + "-" + tbSubsId.TextBoxValue;
                                String hash_codeudor = Int64.Parse(Convert.ToString(ocCosignerIdentType.Value)) + "-" + ostbCosignerIdentification.TextBoxValue;

                                /*general.mensajeOk("hash_deudor.Equals(hash_codeudor). " + hash_deudor.Equals(hash_codeudor) +
                                    ". hash_deudor: " + hash_deudor + ", hash_codeudor: " + hash_codeudor);*/

                                /*04-10-2014 Llozada [RQ 1218]: Cuando es traslado de cupo a mismo contrato No se guarda
                                                                en LDC_CODEUDOR*/
                                if (!hash_deudor.Equals(hash_codeudor))
                                {
                                    /*04-10-2014 Llozada [RQ 1218]: Se insertan los nuevos datos de codeudor y deudor en ldc_codeudor*/
                                    _blFIFAP.RegisterCosigner(Cosigner.IdentType, Cosigner.Identification, Cosigner.FlagDeudorSolidario,
                                                              Cosigner.PackageId, Convert.ToString(ocIdenType.Value), tbSubsId.TextBoxValue);
                                }
                            }
                            else
                            {
                                /*04-10-2014 Llozada [RQ 1218]: Se insertan los nuevos datos de codeudor y deudor en ldc_codeudor*/
                                _blFIFAP.RegisterCosigner(Cosigner.IdentType, Cosigner.Identification, Cosigner.FlagDeudorSolidario,
                                                          Cosigner.PackageId, Convert.ToString(ocIdenType.Value), tbSubsId.TextBoxValue);
                            }
                        }
                        else
                        {
                            general.doRollback();
                            return;
                        }
                    }

                    if (OrderTransferId > 0)
                    {
                        _blFIFAP.UpdateOrderActivityPack(packageId, OrderTransferId);
                    }

                    if (billSlope > 0)
                    {
                        _blFIFAP.saveBillSlope(billSlope, packageId);
                    }
                    //EveSan 18/Julio/2013
                    //Servicio Pl/sql "LD_BONONBANKFINANCING.UpdAditionalDataSaleFNB"
                    _blFIFAP.UpdateAditionalValuesSalesFNB(
                          packageId,
                          Convert.ToDouble(ostbFeedMonthSaleTotal.TextBoxValue),
                          Convert.ToDouble(ostbSafeTotal.TextBoxValue),
                          Convert.ToDouble(ostbTotalSale.TextBoxValue),
                          allowTransferQuota
                          );


                    //Inicio Desarrollo CASO 200-85
                    BLAplicaParaGDC = _blFIFAP.BLFBLAplicaParaGDC("FNB_BR_JLVM_CA_200_85");
                    BLAplicaParaEfigas = _blFIFAP.BLFBLAplicaParaEfigas("FNB_BR_JLVM_CA_200_85");
                    String stNombreCodeudor = String.Empty;
                    String stApellidoCodeudor = String.Empty;
                    String stIdentificacionCodeudor = String.Empty;
                    Int64 nuContratoCodeudor = 0;

                    //general.mensajeOk("BLAplicaParaGDC[" + BLAplicaParaGDC.ToString() + "]");
                    //general.mensajeOk("BLAplicaParaEfigas[" + BLAplicaParaEfigas.ToString() + "]");

                    if ((BLAplicaParaGDC) || (BLAplicaParaEfigas))
                    {
                        //general.mensajeOk("Antes de Ingreso.... ");
                        if (BLActualizaCODEUDOR)
                        {
                            //general.mensajeOk("Ingreso.... ");
                            if ((cambioNombreCodeudor) || (cambioApellidoCodeudor) || (cambioIdentificacionCodeudor))
                            {
                                if (cambioNombreCodeudor)
                                {
                                    stNombreCodeudor = ostbNewCosignerName.TextBoxValue;
                                }
                                else
                                {
                                    stNombreCodeudor = ostbCosignerName.TextBoxValue;
                                }

                                if (cambioApellidoCodeudor)
                                {
                                    stApellidoCodeudor = ostbNewCosignerLastName.TextBoxValue;
                                }
                                else
                                {
                                    stApellidoCodeudor = ostbCosignerLastName.TextBoxValue;
                                }

                                if (cambioIdentificacionCodeudor)
                                {
                                    stIdentificacionCodeudor = ostbNewCosignerIdentification.TextBoxValue;
                                }
                                else
                                {
                                    stIdentificacionCodeudor = ostbCosignerIdentification.TextBoxValue;
                                }

                                if (String.IsNullOrEmpty(txtCosignerContract.TextBoxValue))
                                {
                                    nuContratoCodeudor = 0;
                                }
                                else
                                {
                                    nuContratoCodeudor = Convert.ToInt64(txtCosignerContract.TextBoxValue);
                                }

                                _blFIFAP.guardarDatosActualizar(packageId,
                                                                ostbCosignerName.TextBoxValue,//old name
                                                                stNombreCodeudor,//new name
                                                                ostbCosignerLastName.TextBoxValue,//old_lastname
                                                                stApellidoCodeudor,//new_lastname
                                                                stIdentificacionCodeudor,//new_ident
                                                                ostbCosignerIdentification.TextBoxValue,//old_ident
                                                                "Nombre y/o ID",//tipo_cambio
                                                                "P_ACTUALIZACION_DE_DATOS_DE_CLIENTE_100216",//tagname
                                                                "M_DATOS_DEL_CLIENTE_100231",//tagnamemot
                                                                "100216",//packtypeid
                                                                onuSubscriberId_old + "",//idcliente
                                                                nuContratoCodeudor//idcontato
                                                                );

                            }
                        }
                    }
                    //Fin Desarrollo CASO 200-85

                    if (_dataFIFAP.PromissoryType == "D")
                    {
                        Article a = (Article)(articleBindingSource.List[0]);

                        _blFIFAP.UpRequestNumberFNB
                            (
                                Convert.ToInt64(packageId),
                                Convert.ToInt64(_dataFIFAP.VoucherType),
                                Convert.ToInt64(_dataFIFAP.PointSaleId),
                                Convert.ToInt64(_digitalPromisoryId)
                            );

                        //aecheverry
                        _blFIFAP.doCommit();

                        general.mensajeOk("Se registró la solicitud de venta brilla número " + packageId + " ; se imprimira el pagaré");
                        obRegister.Enabled = false;

                        if (_blFIFAP.getParam("GENERATE_CUSTOM_PAGARE") == "N")
                        {

                            LDPAGARE WindowPagare = new LDPAGARE(packageId, "1|Original");
                            WindowPagare.Show();

                            LDPAGARE WindowPagareCl = new LDPAGARE(packageId, "1|Copia Cliente");
                            WindowPagareCl.Show();

                            LDPAGARE WindowPagareCo = new LDPAGARE(packageId, "1|Copia Contratista");
                            WindowPagareCo.Show();
                        }
                        LDSALEREPORT Windowreport = new LDSALEREPORT(packageId.ToString());
                        Windowreport.Show();

                        //08-10-2014 KCienfuegos.RNP1111 - Se valida si se debe imprimir el pagaré posterior a la venta
                        if (_blFIFAP.getParam("IMPRIME_PAGARE_POST_VENTA") == "Y" && _dataFIFAP.PromissoryType.Equals("D") && !String.IsNullOrEmpty(Convert.ToString(_dataFIFAP.SaleId)))
                        {
                            LDRPAGARE Windowpagare = new LDRPAGARE(packageId.ToString());
                            Windowpagare.Show();
                        }

                    }
                    else
                    {
                        Article a = (Article)(articleBindingSource.List[0]);
                        _blFIFAP.UpRequestSetNumberFNB(packageId, Convert.ToInt64(_dataFIFAP.SaleId.ToString()), Convert.ToInt64(_dataFIFAP.PointSaleId.ToString()), a.FinancierId);
                        //aecheverry
                        _blFIFAP.doCommit();
                        general.mensajeOk("Se registró la solicitud de venta brilla número " + packageId);
                        obRegister.Enabled = false;
                    }

                    //Limpia Cache
                    _blFIFAP.clearCache();
                    //aecheverry
                    _blFIFAP.doCommit();
                    _digitalPromisoryId = null;

                    //08-10-2014 KCienfuegos.RNP1111 Se valida si se debe imprimir el BIN/EAN posterior a la venta.
                    if (_blFIFAP.getParam("IMPRIME_BIN_EAN_POST_VENTA") == "Y")
                    {
                        if (_blFIFAP.isProvExito(Convert.ToInt64(_dataFIFAP.SupplierID)) || _blFIFAP.isProvOlimpica(Convert.ToInt64(_dataFIFAP.SupplierID)))
                        {
                            using (LDIBO frm = new LDIBO(packageId))
                            {
                                frm.ShowDialog();
                            }
                        }
                    }

                    this.Close();
                }
                catch (Exception ex)//aecheverry
                {
                    general.doRollback();
                    general.mensajeERROR(ex.Message.ToString());
                }


                //jhinestroza [3821,3822,3823] : valida si se produjo algun cambio
                if (cambioId)
                {
                    _blFIFAP.guardarDatosActualizar(
                                                    packageId,
                                                    null,
                                                    null,
                                                    null,//old_lastname
                                                    null,//new_lastname
                                                    tbNumberDocument.TextBoxValue,//new_ident
                                                    tbSubsId.TextBoxValue,//old_ident
                                                    "identificacion",//tipo_cambio
                                                    "P_ACTUALIZACION_DE_DATOS_DE_CLIENTE_100216",//tagname
                                                    "M_DATOS_DEL_CLIENTE_100231",//tagnamemot
                                                    "100216",//packtypeid
                                                    _dataFIFAP.SubscriberId + "",//idcliente
                                                    Convert.ToInt64(tbSubscription.TextBoxValue)//idcontato
                                                    );
                }
                if (cambioNombre)
                {
                    _blFIFAP.guardarDatosActualizar(
                                                    packageId,
                                                    _dataFIFAP.SubName,
                                                    tbSubsNewName.TextBoxValue,
                                                    _dataFIFAP.SubLastname,//old_lastname
                                                    tbSubsLastName.TextBoxValue,//new_lastname
                                                    null,//new_ident
                                                    null,//old_ident
                                                    "nombre",//tipo_cambio
                                                    "P_ACTUALIZACION_DE_DATOS_DE_CLIENTE_100216",//tagname
                                                    "M_DATOS_DEL_CLIENTE_100231",//tagnamemot
                                                    "100216",//packtypeid
                                                    _dataFIFAP.SubscriberId + "",//idcliente
                                                    Convert.ToInt64(tbSubscription.TextBoxValue)//idcontato
                                                    );
                }

            } 

        }
         
        private void obSaveSaleDate_Click(object sender, EventArgs e)
        {
            oabCosignerAddress.AutonomusTransaction = true;
            oabDeudorAddress.AutonomusTransaction = true;

            if (!_blFIFAP.fblValidCanFact(_subscriptionId))
            {
                general.mensajeERROR("El contrato NO tiene la cantidad de facturas generadas validas para realizar una venta en FIFAP");
            }
            else if (!(Convert.ToInt64(opcSeller.Value) > 0))
            {
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado un Ejecutivo de Venta");
            }
            else if (String.IsNullOrEmpty(tbSubsNewName.TextBoxValue))// valida que el nuevo nombre no este null
            {
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el nuevo nombre");
            }
            else if (String.IsNullOrEmpty(tbSubsLastName.TextBoxValue))// valida que el nuevo Apellido no este null
            {
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el nuevo apellido");
            }
            else if (String.IsNullOrEmpty(ostbSaleIdentification.TextBoxValue))
            {
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el identificador de venta");
            }
            else if (String.IsNullOrEmpty(Convert.ToString(opcChanelSale.Value)))
            {
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado canal de venta");
            }
            else if (OpenConvert.ToString(opcPromissoryType.Value).Equals("D") && OpenConvert.ToLong(opcChanelSale.Value) == doorTodoorChanel)
            {
                general.mensajeERROR("Para el Canal de Venta [Rutero/PAP] no se puede asignar Tipo de Pagare [Digital]");
            } 
            else
            {
                //01-10-2014 Llozada [RQ 1218]: Se adiciona la validación para la causal de Deudor Solidario
                if (deudorSolCheck.Checked)
                {
                    if (String.IsNullOrEmpty(OpenConvert.ToString(CausalDeudorSol.Value)))
                    {
                        nuErrorDeudorSol = -1;
                        general.mensajeERROR("Cuando seleccione el flag Deudor Solidario, debe ingresar una causal obligatoria");
                    }
                    else
                    {
                        nuErrorDeudorSol = 0;
                    }
                }

                /*Llozada [RQ 1218]: Siempre que sea CERO es porque no genero error el deudor solidario*/
                if (nuErrorDeudorSol == 0) 
                {
                    Decimal Anticipo = OpenConvert.ToDecimal(ostbPayment.TextBoxObjectValue);

                    if (Anticipo > 0)
                    {
                        _blFIFAP.ValidateValueToPay(_subscriptionId, Anticipo);
                    }
                    // jhinestroza [3743]: valida si el canal de venta es 14 Stand - Brilla
                    if (Convert.ToInt64(opcChanelSale.Value) == 14)
                    {
                        chanelSale = Convert.ToInt64(opcChanelSale.Value) + "";
                    }
                    // jhinestroza [3743]:
                    if (_blFIFAP.fblValAvailable(_subscriptionId, _dataFIFAP.AddressId, Convert.ToDateTime(ostbSaleDate.TextBoxValue), chanelSale))
                    {

                        if (!String.IsNullOrEmpty(Convert.ToString(_dataFIFAP.BillingDate)))
                        {
                            _dataFIFAP.Payment = Convert.ToDouble(ostbPayment.TextBoxValue);
                            intiPaymentTmp = _dataFIFAP.Payment;
                            _dataFIFAP.ChanelSaleName = Convert.ToString(opcPromissoryType.Value);
                            _dataFIFAP.SellerId = Convert.ToInt64(opcSeller.Value);
                            _dataFIFAP.PointSaleId = Convert.ToInt64(opcPointSale.Value);
                            _dataFIFAP.PromissoryType = Convert.ToString(opcPromissoryType.Value);
                            _dataFIFAP.PointDelivery = ucePointDelivery.Checked;
                            _dataFIFAP.RegisterDate = Convert.ToDateTime(ostbRegisterDate.TextBoxValue);
                            _dataFIFAP.SaleDate = Convert.ToDateTime(ostbSaleDate.TextBoxValue);
                            _dataFIFAP.AllowTransferQuota = uceTransferQuota.Checked;
                            _dataFIFAP.GracePeriod = uceGracePeriod.Checked;
                            _dataFIFAP.SaleId = Convert.ToInt64(ostbSaleIdentification.TextBoxValue);
                            _dataFIFAP.DefaultchanelSaleId = Convert.ToInt64(opcChanelSale.Value);
                            tcPpal.Tabs[1].Enabled = true;
                            tcPpal.SelectedTab = tcPpal.Tabs[1];

                            //27-10-2014 KCienfuegos.RNP1808 Se valida si es venta empaquetada
                            if (cbxVentaEmpaq.Checked)
                            {
                                //Obtiene los artículos válidos para Venta Empaquetada
                                _articleLOV = _blFIFAP.getArticlesGasApplSale(
                                    Convert.ToInt64(_dataFIFAP.SupplierID.ToString()),
                                    Convert.ToInt64(_dataFIFAP.DefaultchanelSaleId.ToString()),
                                    Convert.ToInt64(_dataFIFAP.GeoLocation.ToString()),
                                    Convert.ToInt64(_dataFIFAP.CategoryId.ToString()),
                                    Convert.ToInt64(_dataFIFAP.SubcategoryId.ToString()),
                                    _dataFIFAP.GracePeriod,
                                    Convert.ToDateTime(_dataFIFAP.BillingDate.ToString()),
                                    Convert.ToDateTime(_dataFIFAP.SaleDate.ToString()));
                            }
                            else
                            {
                                /* 
                                 * [03/08/2015] edwardh [SAO.334390 Cuota Fija]: 
                                 */
                                if (cuotaFijaCheck.Checked)
                                {
                                    sbCuotaFija = "F";
                                }
                                else
                                {
                                    sbCuotaFija = "V";
                                }

                       
                                //Agordillo Caso.6853 04-10-2015
                                //Setea la instnacia de IFIFAP
                                _blFIFAP.setIfifap(ififap_);
                                
                                /* Grilla de articulos */
                                _articleLOV = _blFIFAP.getAvalibleArticles(
                                    Convert.ToInt64(_dataFIFAP.SupplierID.ToString()),
                                    Convert.ToInt64(_dataFIFAP.DefaultchanelSaleId.ToString()),
                                    Convert.ToInt64(_dataFIFAP.GeoLocation.ToString()),
                                    Convert.ToInt64(_dataFIFAP.CategoryId.ToString()),
                                    Convert.ToInt64(_dataFIFAP.SubcategoryId.ToString()),
                                    _dataFIFAP.GracePeriod,
                                    Convert.ToDateTime(_dataFIFAP.BillingDate.ToString()),
                                    Convert.ToDateTime(_dataFIFAP.SaleDate.ToString()),
                                    sbCuotaFija);
                            }

                            //***************************************************//
                            ocArticle = this.DropDownListsMaker(_articleLOV);
                            //***************************************************//
                            ocArticle.SetDataBinding(_articleLOV, null);

                            ocArticle.RowSelected += new RowSelectedEventHandler(ocArticle_RowSelected);

                            ogArticles.DisplayLayout.Bands[0].Columns["ArticleIdDescription"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
                            ogArticles.DisplayLayout.Bands[0].Columns["ArticleIdDescription"].AutoEdit = true;
                            ogArticles.DisplayLayout.Bands[0].Columns["ArticleIdDescription"].AutoSizeMode = ColumnAutoSizeMode.AllRowsInBand;
                            ogArticles.DisplayLayout.Bands[0].Columns["ArticleIdDescription"].AllowGroupBy = Infragistics.Win.DefaultableBoolean.True;
                            ogArticles.DisplayLayout.Bands[0].Columns["ArticleIdDescription"].CellAppearance.TextHAlign = Infragistics.Win.HAlign.Left;
                            ogArticles.DisplayLayout.Bands[0].Columns["ArticleIdDescription"].PromptChar = ' ';
                            ogArticles.DisplayLayout.Bands[0].Columns["ArticleIdDescription"].PerformAutoResize();
                            ogArticles.DisplayLayout.Bands[0].Columns["ArticleIdDescription"].ValueList = ocArticle;

                            //ogArticles.DisplayLayout.Bands[0].Columns["ValueArticle"].MaskInput = "nnnnnnnnnnnnnnn";
                            ogArticles.DisplayLayout.Bands[0].Columns["FirstFeedDate"].CellActivation = Activation.NoEdit;
                            ogArticles.DisplayLayout.Bands[0].Columns["FirstFeedDate"].Hidden = true;
                            ogArticles.DisplayLayout.Bands[0].Columns["SupplierName"].CellActivation = Activation.NoEdit;
                            ogArticles.DisplayLayout.Bands[0].Columns["SubTotal"].CellActivation = Activation.NoEdit;
                            ogArticles.DisplayLayout.Bands[0].Columns["ArticleId"].CellActivation = Activation.NoEdit;
                            ogArticles.DisplayLayout.Bands[0].Columns["ValueArticle"].Format = "##0.00"; //KCienfuegos.NC4826 02/03/2015 Se agrega formato al campo
                            ogArticles.DisplayLayout.Bands[0].Columns["TaxValue"].Format = "##0.00";  //KCienfuegos.NC4826 02/03/2015 Se agrega formato al campo

                            if (isCashPayment)
                            {
                                // Si el pago es de contado, solo se permite una cuota.
                                ogArticles.DisplayLayout.Bands[0].Columns["FeedsNumber"].CellActivation = Activation.NoEdit;
                            }


                            String[] fieldsproperty = new string[] { "ValueArticle", "ArticleId", "SupplierName", "ValueArticle", "Amount", "FirstFeedDate" };
                            general.setColumnRequiered(ogArticles, fieldsproperty);
                            ogArticles.PerformLayout();
                        }
                        else
                        {
                            general.mensajeERROR("No se ha definido fecha de facturación para el ciclo asociado al cliente");
                        }
                    }
                }

                /*jhinestroza [3821,3822,3823]*/
                // validacion para ver el cambio de nombre
                // bool cambioNombre = false
                if (String.IsNullOrEmpty(tbSubsNewName.TextBoxValue) && String.IsNullOrEmpty(tbSubsLastName.TextBoxValue))//no hay cambios
                {
                    cambioNombre = false;
                }
                else
                {
                    cadena_A = tbSubsName.TextBoxValue;// Nombre de datosbasicos             
                    cadena_B = tbSubsNewName.TextBoxValue + " " + tbSubsLastName.TextBoxValue;// Nombre ingresado + Apellido ingresado
                    
                    //compara los nombres
                    numCaracteres = _blFIFAP.fnuComparacionCadenas(cadena_A, cadena_B, out porcenSimilaridad);
                    if ((100 - (porcenSimilaridad * 100)) != 100)
                    {
                        cambioNombre = true;
                        //general.mensajeERROR("cambioNombre = " + true);
                    }
                    else
                    {
                        cambioNombre = false;
                        //general.mensajeERROR("cambioNombre = " + false);
                    }
                }
            }
        }

        private void ogArticles_AfterCellUpdate(object sender, CellEventArgs e)
        {
            //  Si no se debe validar valor/unidades (cuando al campo se le asigna originValue)
            if (!validateValueUnits)
            {
                validateValueUnits = true;
                return;
            }

            //Se limpian los datos de cota extra, ya que cuando en el evento  
            //del boton "siguiente" de las pestaña articulos se volveran a calcular
            (e.Cell.Row.ListObject as Article).UsedExtraQuota = null;
            (e.Cell.Row.ListObject as Article).ExtraQuotaId = null;

            //  Asigna que debe validar valor/unidades
            validateValueUnits = true;

            if (e.Cell.Column.Key == "ArticleIdDescription")
            {
                int exist = articleAlreadySel(articleValue.ArticleObject);

                //Agordillo Cambio.6853 05-10-2015
                //Se valida si se ingresa mas de un articulo
                if (ififap_.VentaMateriales)
                {
                    if (e.Cell.Row.Index == 1)
                    {
                        general.mensajeERROR("La venta es tipo Materiales y solo puede seleccionar un articulo");
                        articleBindingSource.RemoveCurrent();
                        return;
                    }
                }              
              
                if (exist != -1 && exist != e.Cell.Row.Index)
                {
                    general.mensajeERROR("Este artículo ya existe en la lista");
                    articleBindingSource.RemoveCurrent();
                    return;
                }

                Int32 x = articleBindingSource.Position;
                if ((x - 1) < 0)
                {
                    //  Asigna la cantidad por defecto
                    articleValue.ArticleObject.Amount = 1;

                    // Se valida el proveedor 
                    if (_blFIFAP.isProvExito(Convert.ToInt64(_dataFIFAP.SupplierID)) && _blFIFAP.getParam("USA_ITEM_GENERIC_EXITO") == "Y")
                    {
                        // Se inahibilita la modificación de la cantidad del articulo
                        ogArticles.ActiveRow.Cells["Amount"].Activation = Activation.NoEdit;
                    }

                    //Agordillo Caso.6853
                    // Valida si la venta es de materiales , deshabilite el campo Cantidad. Por defecto solo debe ser cantidad 1
                    if (ififap_.VentaMateriales)
                    {
                        // Se inahibilita la modificación de la cantidad del articulo
                        ogArticles.ActiveRow.Cells["Amount"].Activation = Activation.NoEdit;
                    }
                    
                    //  Asigna el número de cuotas
                    if (articleValue.ArticleObject.FeedsNumberMin <= 0)
                        articleValue.ArticleObject.FeedsNumber = 1;
                    else
                        articleValue.ArticleObject.FeedsNumber = articleValue.ArticleObject.FeedsNumberMin;

                    //  Asigna el valor
                    if (articleValue.ArticleObject.EditValue)
                    {
                        articleValue.ArticleObject.ValueArticle = 0;
                    }

                    //articleValue.ArticleObject.FirstFeedDate = _blFIFAP.FirstFeeDate(_subscriptionId,articleValue.ArticleObject.FirstFeedDate);

                    articleBindingSource[x] = articleValue.ArticleObject;
                    (articleBindingSource[x] as Article).ArticleIdDescription = articleValue.ArticleObject.ArticleId.ToString();
                    articleBindingSource.EndEdit();
                }
                else
                {
                    Article temp = (Article)articleBindingSource[x - 1];
                    if (temp.FinancierId == articleValue.ArticleObject.FinancierId)
                    {
                        //  Asigna la cantidad por defecto
                        articleValue.ArticleObject.Amount = 1;

                        // Se valida el proveedor 
                        if (_blFIFAP.isProvExito(Convert.ToInt64(_dataFIFAP.SupplierID)) && _blFIFAP.getParam("USA_ITEM_GENERIC_EXITO") == "Y")
                        {
                            // Se inahibilita la modificación de la cantidad del articulo
                            ogArticles.ActiveRow.Cells["Amount"].Activation = Activation.NoEdit;
                        }

                        //  Asigna el número de cuotas
                        if (articleValue.ArticleObject.FeedsNumberMin <= 0)
                            articleValue.ArticleObject.FeedsNumber = 1;
                        else
                            articleValue.ArticleObject.FeedsNumber = articleValue.ArticleObject.FeedsNumberMin;

                        //  Asigna el valor
                        if (articleValue.ArticleObject.EditValue)
                        {
                            articleValue.ArticleObject.ValueArticle = 0;
                        }

                        //articleValue.ArticleObject.FirstFeedDate = _blFIFAP.FirstFeeDate(_subscriptionId, articleValue.ArticleObject.FirstFeedDate);

                        articleBindingSource[x] = articleValue.ArticleObject;
                        (articleBindingSource[x] as Article).ArticleIdDescription = articleValue.ArticleObject.ArticleId.ToString();
                        articleBindingSource.EndEdit();
                    }
                    else
                    {
                        general.mensajeERROR("Solo puede seleccionar artículos del mismo financiador");
                    }
                }

                if (Convert.ToInt64(ogArticles.ActiveRow.Cells["ValueArticle"].Value) == 0)
                {
                    ogArticles.ActiveRow.Cells["ValueArticle"].Activation = Activation.AllowEdit;
                }
                else
                {
                    ogArticles.ActiveRow.Cells["ValueArticle"].Activation = Activation.NoEdit;
                }
            }

        }

        private void ostbSaleDate_Leave(object sender, EventArgs e)
        {
            try
            {
                if (DateTime.Parse(ostbSaleDate.TextBoxValue) > DateTime.Parse(ostbRegisterDate.TextBoxValue))
                {
                    ostbSaleDate.TextBoxObjectValue = DateTime.Today;
                    general.mensajeERROR("La fecha no puede ser posterior a la del registro.");
                }
            }
            catch
            {
                general.mensajeERROR("Formato de fecha incorrecto");
                ostbSaleDate.Focus();
            }
        }

        private void tbSubscription_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((e.KeyChar == 61))
                e.Handled = false;
            else
                e.Handled = true;
        }

        private void ostbBillId1_KeyPress(object sender, KeyPressEventArgs e)
        {
            //
            if ((e.KeyChar == 61))
                e.Handled = false;
            else
                e.Handled = true;
        }

        private void ostbBillId1_KeyDown(object sender, KeyEventArgs e)
        {
            //
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                e.Handled = false;
            else
                e.Handled = true;
        }

        private void ostbBillId1_KeyUp(object sender, KeyEventArgs e)
        {
            //
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void ostbBillId2_KeyUp(object sender, KeyEventArgs e)
        {
            //
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void ostbPayment_KeyUp(object sender, KeyEventArgs e)
        {
            if (Convert.ToInt64(ostbPayment.TextBoxValue) < 0)
                if ((e.KeyValue == 189) || (e.KeyValue == 109))
                    ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void ostbSaleIdentification_KeyUp(object sender, KeyEventArgs e)
        {
            //
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }
        
        /// <summary>
        /// Evento al hacer click en el botón de los artículos
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void obArticle_Click(object sender, EventArgs e)
        {
            if (!ValidRow(true))
            {
                return;
            }

            /* 
             * [03/08/2015] edwardh [SAO.334390 Cuota Fija]: 
             * Se oculta la seleccion del plan de financiacion Cuota fija, ya que se elige 
             * desde la pestaña datos basicos con el check "cuotaFijaCheck"
             * 
             *   //17-02-2015 Llozada [ARA 1841]: Se muestra mensaje de confirmación para indicarle al usuario el plan de financiación que se planea utilizar en el proceso
            if (String.IsNullOrEmpty(OpenConvert.ToString(PlanFinanciacion.Value)))
            {
                if (MessageBox.Show("Desea continuar con el plan de financiación tasa variable?", "Mensaje Confirmación", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No)
                {
                    return;
                }
            }
             *[03/08/2015] edwardh [SAO.334390 Cuota Fija] 
             */

            /*Se setea a cero el número de artículos de gasodoméstico*/
            nuGasAppliance = 0;

            //Limpia Cache
            _blFIFAP.clearCache();

            ultraCheckEditor1.Enabled = false;
            ultraCheckEditor1.Checked = false;
            validateValueUnits = true;
            Double pendTransf;


            if (articleBindingSource.Count > 0)
            {
                if (_dataFIFAP.PromissoryType.Equals("I"))
                {
                    Article a = (Article)(articleBindingSource.List[0]);

                    if (_dataFIFAP.SaleId != 0)
                    {
                        _blFIFAP.validateNumberFNB(Convert.ToInt64(_dataFIFAP.SaleId.ToString()), Convert.ToInt64(_dataFIFAP.PointSaleId.ToString()), a.FinancierId);
                    }
                    else
                    {
                        general.mensajeERROR("No ha digitado el identificador de venta");
                    }
                }
                
                Article art = new Article();
                art = (Article)(articleBindingSource.List[0]);
                Boolean isGracePeriod = false;

                if (!(articleBindingSource.Count == 1 && art.ArticleId == 0))
                {
                    Double totalSale = 0;
                    Double monthlyFeed = 0;
                    Double totalSafe = 0;
                    Double monthlyFeedSafe = 0;
                    //Aecheverry jul12
                    Double initialParcialPay = 0;
                    Double promedio_cuotas = 0;
                    Int64 cantidad_articulos = 0;
                    Double porcentaje_seguro;

                    Double articleValue;
                    Double proportion;
                    Double articlePayment;
                    Double articleWithPay;
                    Double totalSaleTmp;
                    Double monthQuota;
                    Double safeTotalValue;
                    Double Tem;
                    Boolean partialQuotaEvaluation = false;
                    Double availableQuota;
                    Double totalExtraQuote;
                    Double Anticipo = OpenConvert.ToDouble(ostbPayment.TextBoxObjectValue);

                    //  Recorre los artículos para calcular los totales
                    foreach (Article article in articleBindingSource)
                    {
                        //[03/08/2015] edwardh [SAO.334390 Cuota Fija]
                        // si el numero de cuotas ingresado es mayor al numero de cuotas que tiene el articulo: generea mensaje de error
                        if ( Convert.ToDouble(article.FeedsNumber.ToString()) > _blFIFAP.fnuGetMaxNumberFees(article.FinancingPlan) )
                        {
                            general.mensajeERROR("El Número de Cuotas ingresado para el Articulo: "+ article.ArticleId +" Supera el Maximo permitido");
                        }

                        promedio_cuotas = promedio_cuotas + Convert.ToDouble(article.FeedsNumber.ToString());

                        cantidad_articulos = cantidad_articulos + 1;
                        totalSale = totalSale + article.SubTotal + article.TaxValue;

                        if (_blFIFAP.ValidateArticlesLine(Convert.ToInt32(article.LineId)))
                        {
                            nuGasAppliance++;
                        }

                        if (article.GracePeriod)
                        {
                            isGracePeriod = true;
                        }

                        //Evaluación de cupo parcial: Se evalua cuando aplique cupo parcial y mientras no se ecuentre 
                        //ningun articulo que cumpla con las sublineas obtenidas por parametrización, ya que solo se 
                        //necesita uno de los articulos que cumpla con esta condicion.
                        if (haveParcial && partialQuotaEvaluation == false)
                        {
                            //general.mensajeOk("Articulo de la sublinea");
                            partialQuotaEvaluation = EvaluatePartialQuota(article);
                        } 
                    }

                    //general.mensajeOk("haveParcial: " + haveParcial + ", partialQuotaEvaluation: " + partialQuotaEvaluation);

                    // Si aplica cupo parcial & Hay como minimo un articulo con una de las sublineas parammetrizadas para cupo parcial
                    if (haveParcial && partialQuotaEvaluation)
                    {
                        availableQuota = _blFIFAP.GetPartialQuota(_subscriptionId);
                        //general.mensajeOk("Articulo de la sublinea, availableQuota: " + availableQuota);
                        isCashPayment = false;
                        _dataFIFAP.Payment = intiPaymentTmp;
                        ostbPaymentTotal.TextBoxValue = Convert.ToString(_dataFIFAP.Payment);
                    }
                    else 
                    {
                        availableQuota = Convert.ToDouble(_dataFIFAP.AvalibleQuota) /*totalTransfer*/;
                        totalExtraQuote = _blFIFAP.getTotalExtraQuote(_subscriptionId);

                        //Valida si será venta empaquetada
                        if (cbxVentaEmpaq.Checked && _blFIFAP.fblValidInstallDate(_subscriptionId))
                        {
                            general.mensajeOk("Se realizará venta empaquetada");
                        }
                        else
                        {
                            //general.mensajeOk("availableQuota: " + availableQuota + ", isCashPayment: " + isCashPayment+
                            //    ", _dataFIFAP.AllowTransferQuota: " + _dataFIFAP.AllowTransferQuota + ", totalExtraQuote: " + totalExtraQuote);
                            
                            //Se define estado para pago de contado
                            //08-11-2014 Llozada [RQ 122]: Se adiciona la validación de la cuota inicial con el total de la venta
                            if (Anticipo == totalSale && availableQuota <= 0 && !isCashPayment && !_dataFIFAP.AllowTransferQuota && totalExtraQuote <= 0)
                            {
                                SetStatusCashPayment();
                                general.mensajeOk("La venta se realiza con pago de contado.");
                            }
                        }
                    }

                    if (!ucSaleInstallation.Checked && nuGasAppliance > 0 && _blFIFAP.getParam("USA_INSTALAC_PROVEEDOR_FNB") == "Y" && !cbxVentaEmpaq.Checked)
                    {
                        general.mensajeOk("Tenga en cuenta que seleccionó artículos de gasodomésticos y el flag de venta con instalación no está activo.");
                    }

                    //Si es pago de contado
                    if (isCashPayment)
                    {
                        // Pago de Contado = Total Venta
                        _dataFIFAP.Payment = totalSale;
                        ostbPaymentTotal.TextBoxValue = Convert.ToString(_dataFIFAP.Payment);
                        //  Asigna el pago inicial
                        initialParcialPay = Convert.ToDouble(_dataFIFAP.Payment);
                        //  Asigna el porcentaje del seguro
                        porcentaje_seguro = 0;
                        //general.mensajeOk("cliDeudorInfo.ocOccupation.Value: " + cliDeudorInfo.ocOccupation.Value);
                        
                        if (string.IsNullOrEmpty(Convert.ToString(cliDeudorInfo.ocOccupation.Value)))
                        {
                            cliDeudorInfo.ocOccupation.Value = -1; 
                        }
                    }
                    else
                    {
                        ostbPaymentTotal.TextBoxValue = Convert.ToString(_dataFIFAP.Payment);

                        //  Asigna el pago inicial
                        initialParcialPay = Convert.ToDouble(_dataFIFAP.Payment);

                        //  Asigna el porcentaje del seguro
                        porcentaje_seguro = Convert.ToDouble(_dataFIFAP.InsuranceRate.ToString()) / 100;
                    }

                    //  Saca copia al total de la venta
                    totalSaleTmp = totalSale;
                    Double? valExtraQuota = 0;

                    foreach (Article article in articleBindingSource)
                    {
                        if (article.ArticleId != 0)
                        {
                            // Asigna el valor del artículo por la cantidad
                            articleValue = (article.ValueArticle * article.Amount) + article.TaxValue;
                            //  Calcula la proporción del artículo contra el total de la venta
                            if (totalSaleTmp > 0)
                                proportion = articleValue / totalSaleTmp;
                            else
                                proportion = 0;

                            //  Calcula la proporción del abono que le corresponde al artículo
                            articlePayment = Math.Round(initialParcialPay * proportion, 2);

                            //  Calcula el valor del artículo aplicándole la porción del pago
                            articleWithPay = Math.Round(articleValue - articlePayment);

                            //  Disminuye al total de la venta el artículo
                            totalSaleTmp = totalSaleTmp - articleValue;

                            //  Se le disminuye al valor del abono el valor aplicado
                            initialParcialPay = initialParcialPay - articlePayment;

                            //  Obtener la tasa efectiva mensual para el artículo
                            Tem = ConvertToNominalRate(article.FinanPercent);

                            //  Calcula el valor de la cuota fija mensual
                            monthQuota = -Microsoft.VisualBasic.Financial.Pmt(
                                Tem, article.FeedsNumber, articleWithPay, 0, Microsoft.VisualBasic.DueDate.EndOfPeriod);

                            //  Acumual el valor de la cuota mensual
                            monthlyFeed = monthlyFeed + monthQuota;

                            //  Obtiene el total del seguro
                            safeTotalValue = GetSafeTotalValue(
                                articleWithPay, article.FeedsNumber, Tem, porcentaje_seguro, monthQuota);

                            //  Acumula el valor del seguro mensual
                            monthlyFeedSafe = monthlyFeedSafe + safeTotalValue / article.FeedsNumber;

                            // Acumula el valor total del seguro
                            totalSafe = totalSafe + safeTotalValue;

                            if (article.UsedExtraQuota != null && article.UsedExtraQuota > 0)
                            {
                                valExtraQuota = valExtraQuota + article.UsedExtraQuota;
                            }                           
                        }
                    }
 
                    //Si cuota inicial es menor o igual que el total de la venta
                    if (_dataFIFAP.Payment <= totalSale)
                    {
                        //Gestión de traslado de cupo   
                        if (calTotal() > availableQuota)
                        {
                            List<Article> articles = new List<Article>();

                            foreach (Article article in articleBindingSource)
                            {
                                articles.Add(article);
                            }

                            //15-Oct-2013:LDiuza.SAO219648:2
                            //  Obtiene el cupo pendiente a transferir haciendo distribución de cupo extra entre los artículos
                            pendTransf = GetPendTransfQuota(calTotal(), availableQuota, _dataFIFAP.DefaultchanelSaleId, articles, _extraQuota);
                            
                            if (pendTransf >= 1)
                            {
                                if (_dataFIFAP.AllowTransferQuota)
                                {
                                    DialogResult transferResult = ExceptionHandler.DisplayMessage(
                                    2741,
                                    "Superó el cupo máximo. ¿Desea trasladar cupo?",
                                    MessageBoxButtons.YesNo,
                                    MessageBoxIcon.Question);

                                    if (transferResult == DialogResult.Yes)
                                    {
                                        if (blRegisterCosigner)
                                        {
                                            if (TotalSale != calTotal())
                                            {
                                                lstTransQuota.Clear();
                                                totalTransfer = 0;
                                            }

                                            DialogResult res = frm.ShowDialog(
                                                _subscriptionId,
                                                Math.Round(totalTransfer, 0), //KCienfuegos.NC4826 02/03/2015 Se agrega el Math.Round
                                                txtCosignerContract.TextBoxValue,
                                                Cosigner.IdentType,
                                                Cosigner.Identification,
                                                lstTransQuota,
                                                Math.Round(pendTransf, 0), //KCienfuegos.NC4826 02/03/2015 Se agrega el Math.Round
                                                //Incio 200-854
                                                //0,
                                                //0,
                                                //0,
                                                false
                                                //Fin 200-854
                                            );
                                            //15-Nov-2013:LDiuza:223401:1  
                                            TotalSale = calTotal();

                                            if (res == DialogResult.OK)
                                            {
                                                OrderTransferId = frm.OrderId;
                                                totalTransfer = frm.TransferQuota;

                                                lstTransQuota = frm.LstTransferQuota;
                                            }
                                            else
                                            {
                                                validateValueUnits = false;
                                                totalTransfer = 0;
                                            }
                                        }
                                        else
                                        {
                                            validateValueUnits = false;
                                            general.mensajeERROR("No se ha registrado un codeudor");
                                        }
                                    }
                                    else
                                    {
                                        validateValueUnits = false;
                                    }
                                }
                                else
                                {
                                    if (!cbxVentaEmpaq.Checked)
                                    {
                                        validateValueUnits = false;
                                        general.mensajeERROR("El valor de la venta es superior al cupo disponible");
                                    }
                                }
                            }
                        }
                        //Fin Traslado

                        if (pagoContadoCheck.Checked)
                        {             

                            if (Anticipo < totalSale)
                            {
                                validateValueUnits = false;
                                general.mensajeERROR("El flag de pago de contado está activo, pero el valor de la cuota inicial es menor " +
                                                     "al total del valor de los articulos a comprar. No se puede realizar la venta " +
                                                     "por favor valide la información.");
                            }
                        }

                        if (validateValueUnits)
                        {
                            /*05-10-2014 Llozada [1218]: Se valida el cupo cuando no sea traslado de cupo y cuando NO sea deudor solidario*/
                            if (blRegisterCosigner && !_dataFIFAP.AllowTransferQuota && !deudorSolCheck.Checked)
                            {
                                /*HAltamiranda - Validacion Deudor Rollover*/
                                if (!DeudorRollover)
                                {
                                    /*05-10-2014 Llozada [1218]: EN caso de que el codeudor no pueda respaldar la deuda, el PL levanta los mensajes de error*/
                                    Boolean validCodeudor = _blFIFAP.validateQuotaCosigner(ostbCosignerIdentification.TextBoxValue, Int32.Parse(Convert.ToString(ocCosignerIdentType.Value)),
                                                                                           calTotal());
                                }
                            }                           

                            promedio_cuotas = promedio_cuotas / cantidad_articulos;
                            ostbPaymentTotal.TextBoxValue = Convert.ToString(_dataFIFAP.Payment);
                            //Valor a financiar
                            ostbFinancingValue.TextBoxValue = Convert.ToString(totalSale - _dataFIFAP.Payment);

                            //Valor total del seguro
                            ostbSafeTotal.TextBoxValue = Convert.ToString(totalSafe);

                            //Valor aproximado cuota mensual
                            ostbFeedMonthSaleTotal.TextBoxValue = Convert.ToString(monthlyFeed);

                            //Valor total de la venta
                            ostbTotalSale.TextBoxValue = Convert.ToString(totalSale);

                            //Valor aproximado del seguro mensual
                            ostbFeedMonthSafeTotal.TextBoxValue = Convert.ToString(monthlyFeedSafe);

                            tcPpal.Tabs[5].Enabled = true;
                            tcPpal.SelectedTab = tcPpal.Tabs[5];

                            //Si es pago de contado, no se habilita periodo de gracia.
                            if (isGracePeriod & !isCashPayment)
                            {
                                ultraCheckEditor1.Enabled = true;
                                ultraCheckEditor1.Checked = false;
                            }
                        }

                    }
                    else
                    {
                        general.mensajeERROR("La cuota inicial es mayor al total");
                    }
                }
                else
                {
                    general.mensajeERROR("No ha seleccionado ningun artículo");
                }
            }
            else
            {
                general.mensajeERROR("No ha seleccionado ningun artículo");
            }

            /*KCienfuegos.ARA5737 */
            if (ucePointDelivery.Checked & dtDeliverDate.Visible)
            {
                dtDeliverDate.Enabled = false;
                dtDeliverDate.Value = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();
                
            }
            else if (!ucePointDelivery.Checked & dtDeliverDate.Visible)
            {
                dtDeliverDate.Enabled = true;
                dtDeliverDate.Value = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();
                dtDeliverDate.Focus();
                dtDeliverDate.Value = String.Empty;
            }

            /*Fin ARA5737*/
        }

        /// <summary>
        /// Evalua un articulo para saber si la venta aplica cupo parcial
        /// </summary>
        /// <param name="article">Articulo evaluado</param>
        /// <returns>Verdadero si el articulo pertenece a una de las sublineas configuradas para cupo parcial, falso de lo contrario</returns>
        public Boolean EvaluatePartialQuota(Article article)
        {
            Boolean evaluation = false;

            foreach (OpenPropertyByControlBase subline in SublinesAppliedToPartialQuota)
            {
                if (article.SublineId == Convert.ToInt64(subline.Key))
                {
                    evaluation = true;
                    break;
                }
            }
            return evaluation;
        }

        private void FIFAP_FormClosed(object sender, FormClosedEventArgs e)
        {
            // si el pagare es digital se debe anular el consecutivo
            if (_digitalPromisoryId.HasValue)
            {                                 
                /*Procedimiento para anular consecutivo digital (TransAutonoma)*/
                _blFIFAP.AnnulReqVoucherFNB(
                    Convert.ToInt64(_dataFIFAP.VoucherType),
                    Convert.ToInt64(_digitalPromisoryId));
            }

            general.doRollback();
        }

        #endregion

        #endregion

        #region Validaciones_Deudor_Codeudor

        #region CargaDeDatos

        /// <summary>
        /// Valida que el codeudor no sea igual al deudor
        /// </summary>
        /// <returns>Verdadero si el codeudor es diferente al deudor, de lo contrario falso</returns>
        private bool validateCosigner(string IdentType, string Identification)
        {
            if (IdentType == Convert.ToString(ocDeudorIdentType.Value)
               && Identification == ostbDeudorIdentification.TextBoxValue)
            {
                general.mensajeERROR("El Codeudor no puede ser igual al deudor");
                return false;
            }
            return true;
        }

        
        /// <summary>
        /// Carga la información del deudor a partir de su identificación
        /// </summary>
        /// <param name="IdentType">Tipo de identificación</param>
        /// <param name="Identification">Identificación</param>
        private void LoadDebtorData(string IdentType, string Identification)
        {
            Promissory promissory;

            if (string.IsNullOrEmpty(Convert.ToString(_subscriptionId)) || Identification != tbSubsId.TextBoxValue)
            {
                promissory = _blFIFAP.getRecentPromissoryInfo(OpenConvert.ToLong(IdentType), Identification);
            }
            else
            {
                /* 03-09-2014 KCienfuegos.NC1920 */
                promissory = _blFIFAP.getRecentPromissoryInfoBySusc(OpenConvert.ToLong(IdentType), Identification, Convert.ToInt64(_subscriptionId));
            }

                ClearDebtorInfo(true);
                if (!string.IsNullOrEmpty(promissory.Identification))
                {
                    FillDebtorData(promissory);
                }

                oabDeudorAddress.Address_id = Convert.ToString(_dataFIFAP.AddressId);
                ocDeudorEstratum.Value = Convert.ToString(_dataFIFAP.SubcategoryId);
                oabDeudorAddress.ReadOnly = true;            
        }

        /// <summary>
        /// Carga la información de un cliente promisorio
        /// </summary>
        /// <param name="QueryBySusc">Indica si se permite editar la identificación</param>
        private void LoadCosignerById(bool QueryBySusc)
        {
            Promissory promissory = new Promissory();
                        
            //general.mensajeOk("Antes de traer la data del codeudor");
            promissory = _blFIFAP.getRecentPromissoryInfo(Int64.Parse(Convert.ToString(ocCosignerIdentType.Value)), ostbCosignerIdentification.TextBoxValue);
            //general.mensajeOk("DESPUES de traer la data del codeudor");
            
            //Si tiene direccion y la subcategoria es nula, se consulta la subcategoria a partir de la direccion
            if (!string.IsNullOrEmpty(promissory.AddressId.ToString()) && string.IsNullOrEmpty(promissory.SubcategoryId.ToString()))
            {
                long? subcategory = _blFIFAP.getSubcategory(Convert.ToInt64(promissory.AddressId.ToString()));


                if (subcategory == 0)
                {
                    //Solcitiud de la funcionario Julia Gonzales. Para que al momento de no encontrar subcategoria 
                    //para la direcion a validar asignara 1 por defecto
                    promissory.SubcategoryId = 1;
                }
                else
                {
                    promissory.SubcategoryId = subcategory;
                }                

                //if (subcategory.HasValue)
                //{
                //    promissory.SubcategoryId = subcategory;
                //}
            }

            if (!String.IsNullOrEmpty(promissory.Identification))
            {
                ClearCosignerInfo(!QueryBySusc);

                if (!QueryBySusc && !validateCosigner(promissory.IdentType, promissory.Identification))
                {
                    txtCosignerContract.TextBoxValue = string.Empty;
                    ClearCosignerInfo(true);
                    ostbCosignerIdentification.Select();                    
                }
                else
                {
                    if (promissory.IdentType == _promissoryDeudor.IdentType && promissory.Identification ==_promissoryDeudor.Identification)
                    {
                        promissory = _promissoryDeudor;
                    }
                    try
                    {
                        /*HAltamiranda - Validacion Deudor Rollover*/
                        if (!DeudorRollover)
                        {
                            //Validamos el codeudor con las configuraciones del proveedor --> "LD_BONONBANKFINANCING.validateCosigner"
                            ValidaCodeudor = _blFIFAP.validateCosigner(
                                                Convert.ToInt64(_dataFIFAP.SupplierID),
                                                 promissory.Identification,
                                                Int32.Parse(Convert.ToString(promissory.IdentType)));
                            if (!ValidaCodeudor)
                            {
                               // general.mensajeERROR("No se puede usar este contrato como codeudor");
                                return;
                            }
                        }
                    }
                    catch (Exception exc)
                    {
                        //general.mensajeOk("Exception CODEUDOR");
                        txtCosignerContract.Select();
                        general.messageErrorException(exc);
                        return;
                    }
                    //general.mensajeOk("Antes de llenar la data del codeudor");
                    FillCosignerData(promissory);
                    //general.mensajeOk("DESPUES de llenar la data del codeudor");
                }
            }
            else
            {
                ClearCosignerInfo(false);
            }
        }

        /// <summary>
        /// Obtiene los datos del codeudor a partir del contrato
        /// </summary>
        private void loadCosignerBySubsc()
        {
            if (!String.IsNullOrEmpty(txtCosignerContract.TextBoxValue))
            {
                long CosignerSusc = Convert.ToInt64(txtCosignerContract.TextBoxValue);

                //18-11-2014 Llozada [RQ 1218]: La validación del predio como codeudor se realiza en LDC_CODEUDORES
                //if (CosignerSusc != _subscriptionId)
                {
                   // general.mensajeOk("Antes de getCosignerBySusc");
                    Cosigner = _blFIFAP.getCosignerBySusc(CosignerSusc);
                    //general.mensajeOk("DESPUÉS de getCosignerBySusc");

                    if (string.IsNullOrEmpty(Cosigner.Identification))
                    {
                        //general.mensajeOk("IF IsNullOrEmpty");
                        txtCosignerContract.TextBoxValue = string.Empty;
                        txtCosignerContract.Select();
                        ClearCosignerInfo(true);
                    }
                    else
                    {
                        //general.mensajeOk("ELSE IsNullOrEmpty");

                        //Se llenan estos dos campos para que el servicio validateCosignerAux funcione correctamente
                        ocCosignerIdentType.Value = Convert.ToString(Cosigner.IdentType);
                        ostbCosignerIdentification.TextBoxValue = Cosigner.Identification;

                        //general.mensajeOk("ocCosignerIdentType.Value: " + ocCosignerIdentType.Value + ", ostbCosignerIdentification.TextBoxValue: " + ostbCosignerIdentification.TextBoxValue);

                        //jrobayo
                        validateCosignerAux();
                        //general.mensajeOk("Después de validateCosignerAux: blValidCosigner: " + blValidCosigner);

                        if (blValidCosigner)
                        {                     
                            //Cargo la información más reciente
                            //LoadCosignerById(true); 03-09-2014 KCienfuegos.NC1920
                            LoadInfoCosignerBySusc(true);
                        }
                    }
                }
            }
            else
            {
                ClearCosignerInfo(true);
            }
        }


        /// <summary>
        /// Carga la info del codeudor teniendo en cuenta el contrato
        /// 03-09-2014  KCienfuegos.NC1920
        /// </summary>
        private void LoadInfoCosignerBySusc(bool QueryBySusc)
        {
            Promissory promissory = new Promissory();

            promissory = _blFIFAP.getRecentPromissoryInfoBySusc(Int64.Parse(Convert.ToString(ocCosignerIdentType.Value)), ostbCosignerIdentification.TextBoxValue, Convert.ToInt64(txtCosignerContract.TextBoxValue));

            //Si tiene direccion y la subcategoria es nula, se consulta la subcategoria a partir de la direccion
            if (!string.IsNullOrEmpty(promissory.AddressId.ToString()) && string.IsNullOrEmpty(promissory.SubcategoryId.ToString()))
            {
                long? subcategory = _blFIFAP.getSubcategory(Convert.ToInt64(promissory.AddressId.ToString()));

                if (subcategory.HasValue)
                {
                    promissory.SubcategoryId = subcategory;
                }
            }

            if (!String.IsNullOrEmpty(promissory.Identification))
            {
                ClearCosignerInfo(!QueryBySusc);

                if (!QueryBySusc && !validateCosigner(promissory.IdentType, promissory.Identification))
                {
                    txtCosignerContract.TextBoxValue = string.Empty;
                    ClearCosignerInfo(true);
                    ostbCosignerIdentification.Select();
                }
                else
                {
                    if (promissory.IdentType == _promissoryDeudor.IdentType && promissory.Identification == _promissoryDeudor.Identification)
                    {
                        promissory = _promissoryDeudor;
                    }
                    try
                    {
                        /*HAltamiranda - Validacion Deudor Rollover*/
                        if (!DeudorRollover)
                        {
                            //Validamos el codeudor con las configuraciones del proveedor --> "LD_BONONBANKFINANCING.validateCosigner"
                            ValidaCodeudor = _blFIFAP.validateCosigner(
                                                Convert.ToInt64(_dataFIFAP.SupplierID),
                                                 promissory.Identification,
                                                Int32.Parse(Convert.ToString(promissory.IdentType)));
                            if (!ValidaCodeudor)
                            {
                                general.mensajeERROR("No se puede usar este contrato como codeudor");
                                return;
                            }
                        }
                    }
                    catch (Exception exc)
                    {
                        txtCosignerContract.Select();
                        general.messageErrorException(exc);
                        return;
                    }

                    FillCosignerData(promissory);
                }
            }
            else
            {
                ClearCosignerInfo(false);
            }
        }

        /// <summary>
        /// Carga los datos del último codeudor del contrato
        /// </summary>
        private void loadLastCosigner()
        {
            ClearCosignerInfo(true);
            Promissory promissory = _blFIFAP.getLastCosigner(OpenConvert.ToLong(_dataFIFAP.IdentType), _dataFIFAP.Identification);
            if (!string.IsNullOrEmpty(promissory.Identification))
            {
                FillCosignerData(promissory);
            }
        }

        #endregion

        #region GestionarCampos

        #region LlenarCampos

        /// <summary>
        /// Completa el formulario del deudor
        /// </summary>
        /// <param name="promissory">Datos del deudor</param>
        private void FillDebtorData(Promissory promissory)
        {
            ocDeudorIdentType.Value = promissory.IdentType;
            ostbDeudorIdentification.TextBoxValue = promissory.Identification;
            ostbDeudorName.TextBoxValue = promissory.DebtorName;
            ostbDeudorLastName.TextBoxValue = promissory.DebtorLastName;
            if (!promissory.BirthdayDate.Equals(DateTime.MinValue))
            {
                ostbDeudorBirthDate.TextBoxObjectValue = promissory.BirthdayDate;
            }
            else
            {
                ostbDeudorBirthDate.TextBoxObjectValue = null;
            }

            ocDeudorIdentType.Value = promissory.IdentType;
            ostbDeudorIdentification.TextBoxValue = promissory.Identification;
            ocDeudorGender.Value = promissory.Gender;
            ohlbDeudorIssuePlace.Value = promissory.ForwardingPlace;
            ocDeudorCivilState.Value = promissory.CivilStateId;
            ostbDeudorPhone.TextBoxValue = promissory.PropertyPhone;

            ostbDeudorDependentPerson.TextBoxValue = Convert.ToString(promissory.DependentsNumber);
            ocDeudorHouseType.Value = promissory.HousingType;

            if (uceBillHolder.Checked)
            {
                ocDeudorHolderRelation.Value = "7";
            }
            else if (promissory.HolderRelation.HasValue)
            {
                ocDeudorHolderRelation.Value = Convert.ToString(promissory.HolderRelation);
            }
            else
            {
                ocDeudorHolderRelation.Value = null;
            }

            ocDeudorEstratum.Value = promissory.SubcategoryId;

            ocDeudorDegreeSchool.Value = promissory.SchoolDegree;
            ostbDeudorOldHouse.TextBoxValue = Convert.ToString(promissory.HousingMonth);

            oabDeudorAddress.Address_id = Convert.ToString(_dataFIFAP.AddressId);

            if (!string.IsNullOrEmpty(oabDeudorAddress.Address_id))
            {
                long? subcategory = _blFIFAP.getSubcategory(Convert.ToInt64(oabDeudorAddress.Address_id));

                if (subcategory.HasValue)
                {
                    ocDeudorEstratum.Value = Convert.ToString(subcategory);
                }
                else
                {
                    ocDeudorEstratum.Value = null;
                }
            }
            
            if (!promissory.ForwardingDate.Equals(DateTime.MinValue))
            {
                ostbDeudorIssueDate.TextBoxObjectValue = promissory.ForwardingDate;
            }
            else
            {
                ostbDeudorIssueDate.TextBoxObjectValue = null;
            }

            FillDeudorAdditionalData(promissory);

            ManageDebtorFields();
        }

        /// <summary>
        /// Completa el formulario de Codeudor
        /// </summary>
        /// <param name="promissory">Datos del codeudor</param>
        private void FillCosignerData(Promissory promissory)
        {
           // general.mensajeOk("FillCosignerData, antes de traer promissory_datos,ostbCosignerIdentification.TextBoxValue: " + ostbCosignerIdentification.TextBoxValue + ", promissory.Identification: " + promissory.Identification);
            /*llozada [RQ 1218]: Se deben traer datos de LD_PROMISSORY*/
            Promissory promissory_datos = _blFIFAP.getLastCosigner(Int64.Parse(promissory.IdentType), promissory.Identification);

           // general.mensajeOk("FillCosignerData, DESPUES de traer promissory_datos");
            /*general.mensajeOk("OK, trajo datos de ld_promossory: " + promissory_datos.BirthdayDate+
                                ", CivilStateId: " + promissory_datos.CivilStateId +
                                ", Convert.ToString(ocCosignerIdentType.Value): " + Convert.ToString(ocCosignerIdentType.Value)+
                                ", ostbCosignerIdentification.TextBoxValue: " + ostbCosignerIdentification.TextBoxValue+
                                ", tbSubscription.TextBoxValue: " + tbSubscription.TextBoxValue);*/

            ostbCosignerName.TextBoxValue = promissory.DebtorName;
            ostbCosignerLastName.TextBoxValue = promissory.DebtorLastName;

            //Inicio Desarrollo CASO 200-85
            BLAplicaParaGDC = _blFIFAP.BLFBLAplicaParaGDC("FNB_BR_JLVM_CA_200_85");
            BLAplicaParaEfigas = _blFIFAP.BLFBLAplicaParaEfigas("FNB_BR_JLVM_CA_200_85");
            if ((BLAplicaParaGDC) || (BLAplicaParaEfigas))
            {
                ValidarNuevoCodeudor(1, promissory.DebtorName, promissory.DebtorLastName, promissory.Identification);
                //general.mensajeERROR("ID Cliente[" + promissory.SubscriberId.ToString() + "]");                
            }
            //Fin Desarrollo CASO 200-85
            
            ostbCosignerDependentPerson.TextBoxValue = Convert.ToString(promissory_datos.DependentsNumber); //Convert.ToString(promissory.DependentsNumber);
            ohlbCosignerIssuePlace.Value = promissory_datos.ForwardingPlace; //promissory.ForwardingPlace;

            //if (!promissory.ForwardingDate.Equals(DateTime.MinValue))
            if (!promissory_datos.ForwardingDate.Equals(DateTime.MinValue))
            {
                ostbCosignerIssueDate.TextBoxObjectValue = promissory_datos.ForwardingDate; //promissory.ForwardingDate;
            }

            ocCosignerIdentType.Value = promissory.IdentType;
            ostbCosignerIdentification.TextBoxValue = promissory.Identification;
            ocCosignerCivilState.Value = promissory_datos.CivilStateId; //promissory.CivilStateId;
           
            //if (!promissory.BirthdayDate.Equals(DateTime.MinValue))
            if (!promissory_datos.BirthdayDate.Equals(DateTime.MinValue))
            {                    
                ostbCosignerBirthDate.TextBoxObjectValue = promissory_datos.BirthdayDate.ToString(); //promissory.BirthdayDate.ToString();
            }

            ocCosignerGender.Value = promissory_datos.Gender; //promissory.Gender;
            oabCosignerAddress.Address_id = Convert.ToString(promissory.AddressId);
            ostbCosignerPhone.TextBoxValue = promissory_datos.PropertyPhone; //promissory.PropertyPhone;
            ocCosignerDegreeSchool.Value = promissory_datos.SchoolDegree; //promissory.SchoolDegree;
            ocCosignerEstratum.Value = promissory.SubcategoryId;
            ocCosignerHolderRelation.Value = promissory_datos.HolderRelation; //promissory.HolderRelation;
            ocCosignerHouseType.Value = Convert.ToString(promissory_datos.HousingType); //Convert.ToString(promissory.HousingType);
            ostbCosignerOldHouse.TextBoxValue = Convert.ToString(promissory_datos.HousingMonth); //Convert.ToString(promissory.HousingMonth);

            /////Inicio CASO 200-1880
            //CASO 200-1880
            //Validar Si el codigo de la direccion existe en al parametro
            bool BlDirCodExiste = false;
            String sbCodigoDireccionCodeudor = oabCosignerAddress.Address_id;
            String sbCOD_DIR_GEN_FIFAP = Convert.ToString(general.getParam("COD_DIR_GEN_FIFAP", "String"));
            String sbSubCadena = string.Empty;
            //int NuposicionCadena = 0;
            for (int Nuposicion = 0; Nuposicion < sbCOD_DIR_GEN_FIFAP.Length; Nuposicion++)
            {
                if (sbCOD_DIR_GEN_FIFAP.Substring(Nuposicion, 1) == ",")
                {
                    if (sbSubCadena == sbCodigoDireccionCodeudor)
                    {
                        BlDirCodExiste = true;
                    }
                    sbSubCadena = string.Empty;

                }
                else
                {
                    sbSubCadena = sbSubCadena + sbCOD_DIR_GEN_FIFAP.Substring(Nuposicion, 1);
                }
            }

            //MessageBox.Show("sbSubCadena[" + sbSubCadena + "] == sbCodigoDireccionCodeudor[" + sbCodigoDireccionCodeudor + "]");

            if (sbSubCadena == sbCodigoDireccionCodeudor)
            {
                BlDirCodExiste = true;
            }
            //CASO 200-1880
            if (BlDirCodExiste)
            {
                ocCosignerEstratum.Value = 1;
                ocCosignerEstratum.ReadOnly = true;
            }
            /////Fin CASO 200-1880


           // general.mensajeOk("FillCosignerData, antes de validar la direccion");
            oabCosignerAddress.Validate();

            //general.mensajeOk("FillCosignerData, antes de traer la data adicional");
            FillCosignerAdditionalData(promissory_datos);
            //FillCosignerAdditionalData(promissory);

            //general.mensajeOk("FillCosignerData, antes de antes de ManageCosignerFields");
            ManageCosignerFields();
            //general.mensajeOk("FillCosignerData, despues de antes de ManageCosignerFields");

        }

        /// <summary>
        /// Asigna datos laborales y referencias del deudor
        /// </summary>
        /// <param name="promissory">Datos del deudor</param>
        private void FillDeudorAdditionalData(Promissory promissory)
        {
            //Se carga la información laboral
            FillLaborInfo(cliDeudorInfo, promissory);

            //Se carga la información de referencias
            FillReferenceInfo(crDeudorInfo, promissory);
        }

        /// <summary>
        /// Asigna datos laborales y referencias del codeudor
        /// </summary>
        /// <param name="promissory">Datos del codeudor</param>
        private void FillCosignerAdditionalData(Promissory promissory)
        {
            //Se Carga la información laboral del codeudor
            FillLaborInfo(cliCosignerInfo, promissory);

            //Se carga las referencias del codeudor
            FillReferenceInfo(crCosignerInfo, promissory);
        }

        /// <summary>
        /// Completa los campos de información laboral
        /// </summary>
        /// <param name="control">Control a completar</param>
        /// <param name="promissory">Datos a ingresar</param>
        private void FillLaborInfo(ctrlLaborInfo control, Promissory promissory)
        {
            control.ocOccupation.Value = promissory.Occupation;            
            control.opstbCompanyName.TextBoxValue = Convert.ToString(promissory.CompanyName);
            control.ostbEmail.TextBoxValue = promissory.Email;
            control.oabCompanyAddress.Address_id = Convert.ToString(promissory.CompanyAddressId);
            control.ocContractType.Value = promissory.ContractType;
            control.ostbPhone.TextBoxValue = promissory.Phone1;
            control.ostbPhone2.TextBoxValue = promissory.Phone2;
            control.ostbCelPhone.TextBoxValue = promissory.MovilPhone;
            control.ostbMonthlyIncome.TextBoxValue = Convert.ToString(promissory.MonthlyIncome);
            control.ostbMonthlyExpenses.TextBoxValue = Convert.ToString(promissory.ExpensesIncome);
            control.ostbActivity.TextBoxValue = promissory.Activity;
            control.ostbOldLabor.TextBoxValue = Convert.ToString(promissory.OldLabor);

            /*02-10-2014 Llozada [RQ 1218]: Si el pago es de contado, la información laboral no debe
                                            ser obligatoria*/
            if (isCashPayment)
            {
                control.ocOccupation.Required = 'N';
                control.ostbMonthlyIncome.Required = 'N';
                control.ostbMonthlyExpenses.Required = 'N';
            }
        }

        private String validaCaracteres(String cadena)
        {

            cadena.Replace(",",null);
            cadena.Replace(";",null);
            cadena.Replace(".",null);
            cadena.Replace(":",null);
            cadena.Replace("-",null);
            cadena.Replace("_",null);
            cadena.Replace("}",null);
            cadena.Replace("?",null);
            cadena.Replace("+",null);
            cadena.Replace("*",null);

            return cadena;
        }

        /// <summary>
        /// Completa los campos de referencia de deudor o codeudor
        /// </summary>
        /// <param name="control">Control a completar</param>
        /// <param name="promissory">Datos a ingresar</param>
        private void FillReferenceInfo(ctrlReference control, Promissory promissory)
        {

            //general.mensajeERROR("promissory.FamiliarReference: " + promissory.FamiliarReference);
            control.ostbFamiliarName.TextBoxValue = promissory.FamiliarReference;           // OK

            //general.mensajeERROR("Con Caracteres especiales promissory.PhoneFamiRefe: " + promissory.PhoneFamiRefe);            
            //general.mensajeERROR("Sin Caracteres especiales promissory.PhoneFamiRefe: " + validaCaracteres(promissory.PhoneFamiRefe));
            //control.ostbFamiliarPhone.TextBoxValue = validaCaracteres(promissory.PhoneFamiRefe);   // FALLA

            //general.mensajeERROR("promissory.MovilPhoFamiRefe: " + promissory.MovilPhoFamiRefe);
            control.ostbFamiliarCelPhone.TextBoxValue = promissory.MovilPhoFamiRefe;        // OK

            //general.mensajeERROR("promissory.AddressFamiRef: " + promissory.AddressFamiRef); 
            control.oabFamiliarAddress.Address_id = Convert.ToString(promissory.AddressFamiRef);

            //general.mensajeERROR("promissory.PersonalReference: " + promissory.PersonalReference);
            control.ostbPersonalName.TextBoxValue = promissory.PersonalReference;

            //general.mensajeERROR("promissory.PhonePersRefe: " + promissory.PhonePersRefe);
            control.ostbPersonalPhone.TextBoxValue = promissory.PhonePersRefe;

            //general.mensajeERROR("promissory.MovilPhoPersRefe: " + promissory.MovilPhoPersRefe);
            control.ostbPersonalCelPhone.TextBoxValue = promissory.MovilPhoPersRefe;

            //general.mensajeERROR("Convert.ToString(promissory.AddressPersRef): " + Convert.ToString(promissory.AddressPersRef));
            control.oabPersonalAddress.Address_id = Convert.ToString(promissory.AddressPersRef);


            //general.mensajeERROR("promissory.CommercialReference: " + promissory.CommercialReference);
            control.ostbCommercialName.TextBoxValue = promissory.CommercialReference;

            //general.mensajeERROR("promissory.PhoneCommRefe: " + promissory.PhoneCommRefe);
            control.ostbCommercialPhone.TextBoxValue = promissory.PhoneCommRefe;

            //general.mensajeERROR("promissory.MovilPhoCommRefe: " + promissory.MovilPhoCommRefe);
            control.ostbComercialCelPhone.TextBoxValue = promissory.MovilPhoCommRefe;

            //general.mensajeERROR("Convert.ToString(promissory.AddressCommRef: " + Convert.ToString(promissory.AddressCommRef));
            control.oabCommercialAddress.Address_id = Convert.ToString(promissory.AddressCommRef);
            
            /*02-10-2014 Llozada [RQ 1218]: Si el pago es de contado, las referencias no deben
                                            ser obligatoria*/
            if (isCashPayment)
            {
                control.ostbFamiliarName.Required = 'N';
            }
        }

        #endregion

        #region LimpiarCampos

        /// <summary>
        /// Limpiar los campos de la pestaña deudor
        /// </summary>
        /// <param name="clearIdentType">Limpiar identificación y tipo de identificación?</param>
        private void ClearDebtorInfo(bool clearIdentType)
        {
            oabDeudorAddress.Address_id = string.Empty;

            ocDeudorEstratum.Value = null;

            ostbDeudorName.TextBoxValue = string.Empty;
            ostbDeudorName.ReadOnly = false;

            ostbDeudorLastName.TextBoxValue = string.Empty;
            ostbDeudorLastName.ReadOnly = false;

            ostbDeudorDependentPerson.TextBoxObjectValue = null;
            ostbDeudorDependentPerson.ReadOnly = false;

            if (clearIdentType)
            {
                ostbDeudorIdentification.TextBoxValue = string.Empty;
                ocDeudorIdentType.Value = null;
            }

            if (!uceBillHolder.Checked)
            {
                ocDeudorHolderRelation.ReadOnly = false;
                ocDeudorHolderRelation.Value = null;
            }

            ostbDeudorPhone.TextBoxValue = string.Empty;
            ostbDeudorPhone.ReadOnly = false;

            ostbDeudorBirthDate.TextBoxValue = string.Empty;
            ostbDeudorBirthDate.ReadOnly = false;

            ocDeudorGender.Value = null;
            ocDeudorGender.ReadOnly = false;

            ohlbDeudorIssuePlace.Value = null;
            ohlbDeudorIssuePlace.Enabled = true;

            ostbDeudorIssueDate.TextBoxObjectValue = null;
            ostbDeudorIssueDate.ReadOnly = false;

            ocDeudorCivilState.Value = null;

            ostbDeudorOldHouse.TextBoxObjectValue = null;
            ocDeudorDegreeSchool.Value = null;
            ocDeudorHouseType.Value = null;
            

            cliDeudorInfo.ClearData();

            crDeudorInfo.ClearData();
        }

        /// <summary>
        /// Limpia el formulario de codeudor
        /// </summary>
        /// <param name="ClearIdent">Define si borrar la identificación del codeudor</param>
        private void ClearCosignerInfo(bool ClearIdent)
        {
            ostbCosignerName.TextBoxValue = string.Empty;
            ostbCosignerName.ReadOnly = false;

            ostbCosignerLastName.TextBoxValue = string.Empty;
            ostbCosignerLastName.ReadOnly = false;

            ostbCosignerDependentPerson.TextBoxValue = null;
            ostbCosignerDependentPerson.ReadOnly = false;

            ohlbCosignerIssuePlace.Value = null;
            ohlbCosignerIssuePlace.Enabled = true;

            ostbCosignerIssueDate.TextBoxValue = string.Empty;
            ostbCosignerIssueDate.ReadOnly = false;

            if (ClearIdent)
            {
                ocCosignerIdentType.Value = null;
                ocCosignerIdentType.ReadOnly = false;

                ostbCosignerIdentification.TextBoxValue = string.Empty;
                ostbCosignerIdentification.ReadOnly = false;
            }
            
            ocCosignerCivilState.Value = null;
            ocCosignerCivilState.ReadOnly = false;

            ostbCosignerBirthDate.TextBoxValue = string.Empty;
            ostbCosignerBirthDate.ReadOnly = false;

            ocCosignerGender.Value = null;
            ocCosignerGender.ReadOnly = false;

            oabCosignerAddress.Address_id = null;
            oabCosignerAddress.ReadOnly = false;

            ostbCosignerPhone.TextBoxValue = string.Empty;
            ostbCosignerPhone.ReadOnly = false;

            ocCosignerDegreeSchool.Value = null;
            ocCosignerDegreeSchool.ReadOnly = false;

            ocCosignerEstratum.Value = null;
            ocCosignerEstratum.ReadOnly = false;

            ostbCosignerPhone.TextBoxValue = string.Empty;
            ostbCosignerPhone.ReadOnly = false;

            ocCosignerHolderRelation.Value = null;
            ocCosignerHolderRelation.ReadOnly = false;

            ocCosignerHouseType.Value = null;
            ocCosignerHouseType.ReadOnly = false;

            ostbCosignerOldHouse.TextBoxValue = null;
            ostbCosignerOldHouse.ReadOnly = false;

            cliCosignerInfo.ClearData();

            crCosignerInfo.ClearData();

            //Inicio Desarrollo CASO 200-85
            BLAplicaParaGDC = _blFIFAP.BLFBLAplicaParaGDC("FNB_BR_JLVM_CA_200_85");
            BLAplicaParaEfigas = _blFIFAP.BLFBLAplicaParaEfigas("FNB_BR_JLVM_CA_200_85");
            if ((BLAplicaParaGDC) || (BLAplicaParaEfigas))
            {
                ValidarNuevoCodeudor(2, string.Empty, string.Empty, string.Empty);
            }
            //Fin Desarrollo CASO 200-85

        }

        #endregion

        #region ActivacionCampos

        /// <summary>
        /// Inhabilita los campos de la pestaña deudor que no deben modificarse
        /// </summary>
        private void ManageDebtorFields()
        {
            if (uceBillHolder.Checked && !uceBillHolder.Enabled)
            {
                ocDeudorIdentType.ReadOnly = true;
                ostbDeudorIdentification.ReadOnly = true;
            }
            
            if (!string.IsNullOrEmpty(Convert.ToString(ocDeudorGender.Value)))
            {
                ocDeudorGender.ReadOnly = true;
            }

            if (!string.IsNullOrEmpty(Convert.ToString(oabDeudorAddress.Address_id)))
            {
                oabDeudorAddress.ReadOnly = true;
            }

            if (!string.IsNullOrEmpty(Convert.ToString(ocDeudorEstratum.Value)))
            {
                ocDeudorEstratum.ReadOnly = true;
            }
            else
            {
                ocDeudorEstratum.ReadOnly = false;
            }

            if (updDebtorName != "Y")
            {
                if (!string.IsNullOrEmpty(ostbDeudorName.TextBoxValue))
                {
                    ostbDeudorName.ReadOnly = true;
                }
                if (!string.IsNullOrEmpty(ostbDeudorLastName.TextBoxValue))
                {
                    ostbDeudorLastName.ReadOnly = true;
                }

                /* 03-09-2014 KCienfuegos.NC1920 */
                if (_blFIFAP.SeveralsSubsWithSameId(ostbDeudorIdentification.TextBoxValue, Convert.ToInt32(ocDeudorIdentType.Value)) && ostbDeudorIdentification.TextBoxValue != tbSubsId.TextBoxValue)
                {
                    ostbDeudorName.ReadOnly = false;
                    ostbDeudorLastName.ReadOnly = false;
                    ocDeudorGender.ReadOnly = false;
                }
            }
        }

        /// <summary>
        /// Inhabilita los campos de codeudor cuyo valor haya sido cargado teniendo en cuenta
        /// los parámetros de actualización de datos
        /// </summary>
        private void ManageCosignerFields()
        {
            if (!string.IsNullOrEmpty(txtCosignerContract.TextBoxValue))
            {
                if (!string.IsNullOrEmpty(ostbCosignerIdentification.TextBoxValue))
                {
                    ocCosignerIdentType.ReadOnly = true;
                    ostbCosignerIdentification.ReadOnly = true;
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(ostbCosignerIdentification.TextBoxValue))
                {
                    txtCosignerContract.ReadOnly = true;
                }
            }

            if (!string.IsNullOrEmpty(Convert.ToString(ocCosignerGender.Value)))
            {
                ocCosignerGender.ReadOnly = true;
            }

            if (!string.IsNullOrEmpty(Convert.ToString(oabCosignerAddress.Address_id)))
            {
                oabCosignerAddress.ReadOnly = true;
            }

            if (!string.IsNullOrEmpty(Convert.ToString(ocCosignerEstratum.Value)))
            {
                ocCosignerEstratum.ReadOnly = true;
            }
            else
            {
                ocCosignerEstratum.ReadOnly = false;
            }

            if (updCosignerName != "Y")
            {
                if (!string.IsNullOrEmpty(ostbCosignerName.TextBoxValue))
                {
                    //ostbCosignerName.ReadOnly = true;
                    ostbCosignerName.ReadOnly = false;
                }
                if (!string.IsNullOrEmpty(ostbCosignerLastName.TextBoxValue))
                {
                    //ostbCosignerLastName.ReadOnly = true;
                    ostbCosignerLastName.ReadOnly = false;
                }

                /* 03-09-2014 KCienfuegos.NC1920 */
                if (_blFIFAP.SeveralsSubsWithSameId(Convert.ToString(ostbCosignerIdentification.TextBoxValue), Convert.ToInt32(ocIdenType.Value)) && string.IsNullOrEmpty(txtCosignerContract.TextBoxValue))
                {
                    ostbCosignerLastName.ReadOnly = false;
                    ostbCosignerName.ReadOnly = false;
                    ocCosignerGender.ReadOnly = false;
                }
            }

        }

        #endregion

        private void ostbPayment_Validating(object sender, CancelEventArgs e)
        {
            Decimal Anticipo = OpenConvert.ToDecimal(ostbPayment.TextBoxObjectValue);

            if (Anticipo > 0)
            {
                _blFIFAP.ValidateValueToPay(_subscriptionId, Anticipo);
            }
        }


        #endregion

        private void opcPointSale_ValueChanged(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Convert.ToString(opcPointSale.Value)))
            {
                opcSeller.Value = null;
                //LISTA DE VENDEDORES
                DataTable sellerList = general.getValueList(" select ge_person.person_id id, name_ description " +
                    "from ge_person, or_oper_unit_persons " +
                    "where  ge_person.person_id = or_oper_unit_persons.person_id " +
                    "and or_oper_unit_persons.operating_unit_id = " + opcPointSale.Value);
                opcSeller.DataSource = sellerList;
                opcSeller.ValueMember = "ID";
                opcSeller.DisplayMember = "DESCRIPTION";
            }
        }

        #endregion

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            /*01-10-2014 Llozada [RQ 1218]: Si se selecciona el flag Deudor Solidario, se debe mostrar o no 
                                            la causal */
            if (deudorSolCheck.Checked)
            {
                CausalDeudorSol.Visible = true;
                CausalDeudorSol.Required = 'Y';
                txtCosignerContract.Required = 'N';
            }
            else
            {
                CausalDeudorSol.Visible = false;
                CausalDeudorSol.Required = 'N';
                CausalDeudorSol.Text = String.Empty;
                nuErrorDeudorSol = 0;
                //txtCosignerContract.Required = 'Y';
            }
        }

        private void opCosignerLaborInfo_Paint(object sender, PaintEventArgs e)
        {

        }

        private void pagoContadoCheck_CheckedChanged(object sender, EventArgs e)
        {
            /*02-10-2014 Llozada [RQ 1218]: Si el pago es de contado, se inicializa la variable
                                            isCashPayment*/
            blValFactOpc = false;
            if (pagoContadoCheck.Checked)
            {
                this.uceTransferQuota.Checked = false;
                this.uceGracePeriod.Checked = false;

                this.uceTransferQuota.Enabled = false;
                this.uceGracePeriod.Enabled = false;

                //ostbPayment.Enabled = false;
                this.isCashPayment = true;

                //KCienfuegos.NC4820 03-02-2015
                ValFactOpc();
                //FIN NC4820
            }    //SetStatusCashPayment();
            else
            {
                SetStatusCashPaymentchanged();

                //KCienfuegos.NC4820 03-02-2015
                if (_dataFIFAP.ValidateBill)
                {
                    ValidFacts();
                }
                //FIN NC4820
            }

        }


        private void ostbDeudorIdentification_Load(object sender, EventArgs e)
        {

        }

        private void CausalDeudorSol_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            
        }

        private void ucSaleInstallation_CheckedChanged(object sender, EventArgs e)
        {
            if (ucSaleInstallation.Checked)
            {
                cbxVentaEmpaq.Enabled = false;
            }
            else
            {
                if (_blFIFAP.getParam("ACTIVA_VTA_EMPAQUETADA") == "Y")
                {
                    //Se valida si existe solicitud de venta empaquetada vigente
                    if (_blFIFAP.fblValidInstallDate(_subscriptionId))
                    {
                        cbxVentaEmpaq.Enabled = true;
                        cbxVentaEmpaq.Visible = true;
                        
                    }
                }
            }

            
        }

        private void cbxVentaEmpaq_CheckedChanged(object sender, EventArgs e)
        {
            if (cbxVentaEmpaq.Checked)
            {
                ucSaleInstallation.Enabled = false;
            }
            else
            {
                if (_blFIFAP.getParam("USA_INSTALAC_PROVEEDOR_FNB") == "Y")
                {
                    //Se valida si el proveedor está habilitado para instalación de gasodomésticos
                    if (_blFIFAP.isActiveForInstalling(Convert.ToInt32(_dataFIFAP.SupplierID)))
                    {
                        ucSaleInstallation.Enabled = true;
                    }
                }
            }
        }

        private void ocDeudorHolderRelation_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {

        }

        private void tcPpal_SelectedTabChanged(object sender, Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs e)
        {
        }

        private void tbSubsId_Load(object sender, EventArgs e)
        {

        }

        private void dtDeliverDate_ValueChanged(object sender, EventArgs e)
        {
            /*Validar si la fecha ingresada es válida KCienfuegos.ARA5737*/
            //if (String.IsNullOrEmpty(dtDeliverDate.Value.ToString()))
            //{
            //    dtDeliverDate.Focus();
            //    general.mensajeERROR("La fecha de entrega no puede ser nula");
            //    return;
            //}
            //else 
            //if (Convert.ToDateTime(dtDeliverDate.Value).Date < DateTime.UtcNow.Date)
            //{ //DateTime.Compare(Convert.ToDateTime(uc_datemax.Text), Convert.ToDateTime(uc_datemin.Text)
            //    dtDeliverDate.Focus();
            //    general.mensajeERROR("La fecha de entrega no puede ser menor a la fecha de hoy");
            //    //dtDeliverDate.Value = dtDeliverDate.NullDateLabel;
            //    return;
            //}
            int a = 1;
        }

        private void dtDeliverDate_Leave(object sender, EventArgs e)
        {
            /*Validar si la fecha ingresada es válida KCienfuegos.ARA5737*/
            if (String.IsNullOrEmpty(dtDeliverDate.Value.ToString()))
            {
                if (_blFIFAP.getParam("FECHA_ENTREGA_OBLIGATORIA") == "Y") /*KCienfuegos.ARA5737 31-03-2015*/
                {
                    dtDeliverDate.Focus();
                    general.mensajeERROR("La fecha de entrega no puede ser nula");
                    return;
                }
            }
            else if (Convert.ToDateTime(dtDeliverDate.Value).Date < DateTime.UtcNow.Date)
            { //DateTime.Compare(Convert.ToDateTime(uc_datemax.Text), Convert.ToDateTime(uc_datemin.Text)
                dtDeliverDate.Focus();
                general.mensajeERROR("La fecha de entrega no puede ser menor a la fecha de hoy");
                //dtDeliverDate.Value = dtDeliverDate.NullDateLabel;
                return;
            }
        }

        /// <summary>
        /// Valida si debe habilitar o no los campos para la venta, de acuerdo al resultado
        /// de la validación del número mínimo de facturas.
        /// </summary> 
        /// <param name="subscriptionId">id del contrato</param>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor               Modificacion	
        /// =========   =========           =====================================
        /// 03-02-2015  KCienfuegos.NC4820  1 - creación        
        ///                                 
        /// </changelog>
        private void ValidFacts()
        {
            if (!_blFIFAP.fblValidNumFactMin(_subscriptionId))
            {
                ostbBillId1.TextBoxValue = "-1";
                ostbBillId2.TextBoxValue = "-1";
                _dataFIFAP.BillId1 = -1;
                _dataFIFAP.BillId2 = -1;
                ostbBillId1.Enabled = false;
                ostbBillId2.Enabled = false;
                ostbBillDate1.Enabled = false;
                ostbBillDate2.Enabled = false;
                enableBill();

            }
            else
            {
                ostbBillId1.Enabled = true;
                ostbBillId2.Enabled = true;
                ostbBillDate1.Enabled = true;
                ostbBillDate2.Enabled = true;

                if (ValidInvoices)
                {
                    obSaveSaleDate.Enabled = true;
                }
                else
                {
                    obSaveSaleDate.Enabled = false;
                }
            }
        }

        private void ValFactOpc()
        {
            if (_dataFIFAP.ValidateBill & _blFIFAP.getParam("VALID_FACT_VENTASCONTADO") == "N") //& pagoContadoCheck.Checked
            {
                if (!_blFIFAP.fblValidNumFactMin(_subscriptionId))
                {
                    ostbBillId1.TextBoxValue = "-1";
                    ostbBillId2.TextBoxValue = "-1";
                    _dataFIFAP.BillId1 = -1;
                    _dataFIFAP.BillId2 = -1;
                    ostbBillId1.Enabled = false;
                    ostbBillId2.Enabled = false;
                    ostbBillDate1.Enabled = false;
                    ostbBillDate2.Enabled = false;
                    enableBill();
                }
                else
                {
                    if (!ValidInvoices)
                    {
                        ostbBillId1.TextBoxValue = "";
                        ostbBillId2.TextBoxValue = "";
                        ostbBillDate1.TextBoxValue = "";
                        ostbBillDate2.TextBoxValue = "";
                        ValidInvoices = false;
                    }
                    
                    blValFactOpc = true;
                    bill1 = null;
                    bill2 = null;
                    genDate1 = null;
                    genDate2 = null;
                    enableBill();
                }
            }
            
        }

        private void ostbCosignerIdentification_Load(object sender, EventArgs e)
        {

        }

        private void ogArticles_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {

        }

        private void extraQuoteBindingSource_CurrentChanged(object sender, EventArgs e)
        {

        }

        //Agordillo Caso.6853 05-10-2015
        //Setea la instancia de IFIFAP
        public void setIfifap(IFIFAP clase)
        {
            this.ififap_ = clase;
        }

        private void ucePointDelivery_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void opcChanelSale_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {

        }

        private void opcPromissoryType_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {

        }

        //Inicio Desarrollo CASO 200-85
        private void ValidarNuevoCodeudor(Double inuaccion, String isbCosignerName, String isbuCosignerLastName, String isbIdentification)
        {
            if (inuaccion == 1) //& pagoContadoCheck.Checked
            {
                ostbNewCosignerName.TextBoxValue = isbCosignerName;
                ostbNewCosignerLastName.TextBoxValue = isbuCosignerLastName;
                ostbNewCosignerIdentification.TextBoxValue = isbIdentification;

                ostbNewCosignerName.ReadOnly = false;
                ostbNewCosignerLastName.ReadOnly = false;
                ostbNewCosignerIdentification.ReadOnly = false;

                BLActualizaCODEUDOR = true;
            }
            else
            {
                ostbNewCosignerName.TextBoxValue = string.Empty;
                ostbNewCosignerLastName.TextBoxValue = string.Empty;
                ostbNewCosignerIdentification.TextBoxValue = string.Empty;

                ostbNewCosignerName.ReadOnly = true;
                ostbNewCosignerLastName.ReadOnly = true;
                ostbNewCosignerIdentification.ReadOnly = true;

                BLActualizaCODEUDOR = false;
            }

        }

        private void ostbNewCosignerName_Validating(object sender, CancelEventArgs e)
        {
            //if (String.IsNullOrEmpty(ostbNewCosignerName.TextBoxValue))//no hay cambios
            //{
            //    general.mensajeERROR("Debe Digitar Nuevo Nombre al Codeudor");
            //    cambioNombreCodeudor = false;
            //}
            //else
            //{
            //    cadena_A = ostbCosignerName.TextBoxValue;// Nombre de datosbasicos             
            //    cadena_B = ostbNewCosignerName.TextBoxValue;// Nombre ingresado + Apellido ingresado

            //    //compara los nombres
            //    numCaracteres = _blFIFAP.fnuComparacionCadenas(cadena_A, cadena_B, out porcenSimilaridad);

            //    if ((100 - (porcenSimilaridad * 100)) != 100)
            //    {
            //        cambioNombreCodeudor = true;
            //    }
            //    else
            //    {
            //        cambioNombreCodeudor = false;
            //    }

            //}

            //Por solicitud de la funcionaria Julia Gonzalez solicito siempre actualizar datos del CODEUDOR cambie o no el nombre
            if (ostbCosignerName.TextBoxValue != ostbNewCosignerName.TextBoxValue)
            {
                cambioNombreCodeudor = true;
            }
            else
            {
                cambioNombreCodeudor = false;
            }

        }

        private void ostbNewCosignerLastName_Validating(object sender, CancelEventArgs e)
        {
            //if (String.IsNullOrEmpty(ostbNewCosignerLastName.TextBoxValue))//no hay cambios
            //{
            //    general.mensajeERROR("Debe Digitar Nuevo Apellido al Codeudor");
            //    cambioApellidoCodeudor = false;
            //}
            //else
            //{
            //    cadena_A = ostbCosignerLastName.TextBoxValue;// Nombre de datosbasicos             
            //    cadena_B = ostbNewCosignerLastName.TextBoxValue;// Nombre ingresado + Apellido ingresado

            //    //compara los apellidos
            //    numCaracteres = _blFIFAP.fnuComparacionCadenas(cadena_A, cadena_B, out porcenSimilaridad);

            //    if ((100 - (porcenSimilaridad * 100)) != 100)
            //    {
            //        cambioApellidoCodeudor = true;
            //    }
            //    else
            //    {
            //        cambioApellidoCodeudor = false;
            //    }
            //}

            //Por solicitud de la funcionaria Julia Gonzalez solicito siempre actualizar datos del CODEUDOR cambie o no el nombre            
            if (ostbCosignerLastName.TextBoxValue != ostbNewCosignerLastName.TextBoxValue)
            {
                cambioApellidoCodeudor = true;
            }
            else
            {
                cambioApellidoCodeudor = false;
            }

        }

        private void ostbNewCosignerIdentification_Validating(object sender, CancelEventArgs e)
        {
            //varibale que contiene el porcentaje o cantidad de erroes que se puede tolerar
            porcenTolerancia = (Int64)OpenConvert.ToInt64Nullable(general.getParam("PORCENTAJE_TOLERANCIA_CODEUDOR", "Int64"));

            // bool cambioNombre = false
            if (ostbNewCosignerName.ReadOnly == false)
            {
                if (String.IsNullOrEmpty(ostbNewCosignerIdentification.TextBoxValue))//no hay cambios
                {
                    general.mensajeERROR("Debe Digitar Nueva Identificacion al Codeudor");
                    cambioIdentificacionCodeudor = false;
                }
                else
                {
                    cadena_A = ostbCosignerIdentification.TextBoxValue;// Nombre de datosbasicos             
                    cadena_B = ostbNewCosignerIdentification.TextBoxValue;// Nombre ingresado + Apellido ingresado

                    //compara las identificaciones
                    numCaracteres = _blFIFAP.fnuComparacionCadenas(cadena_A, cadena_B, out porcenSimilaridad);

                    Double Dbprocentaje = (100 - (porcenSimilaridad * 100));

                    if ((100 - (porcenSimilaridad * 100)) == 100)
                    {
                        cambioIdentificacionCodeudor = false;
                    }
                    else
                    {
                        if ((100 - (porcenSimilaridad * 100)) < porcenTolerancia)
                        {
                            general.mensajeERROR("El porcentaje de tolerancia es mayor a la diferencia entre la identificación anterior y la nueva");
                            cambioIdentificacionCodeudor = false;
                            ostbNewCosignerIdentification.TextBoxValue = ostbCosignerIdentification.TextBoxValue;
                        }
                        if ((100 - (porcenSimilaridad * 100)) >= porcenTolerancia)
                        {

                            //validar la nueva identificacion utilizada por el funcionario en la venta FIFAP
                            BLFIFAP.PRGETINFOCODEUDOR(ostbCosignerIdentification.TextBoxValue, ostbNewCosignerIdentification.TextBoxValue, out onuSubscriberId_old, out onuSubscriberId_new, out onuCodigoError, out osbMensajeError);

                            if (onuCodigoError == 0)
                            {
                                //general.mensajeERROR("La identificación ingresada no corresponde al titular del contrato");
                                cambioIdentificacionCodeudor = true;
                            }
                            else
                            {
                                //general.mensajeERROR(osbMensajeError);
                                ostbNewCosignerIdentification.TextBoxValue = ostbCosignerIdentification.TextBoxValue;
                                cambioIdentificacionCodeudor = false;
                            }


                        }
                        //general.mensajeERROR("Porcentaje " + Dbprocentaje.ToString() + " - Tolerancia " + porcenTolerancia.ToString() + " - Boolean " + cambioIdentificacionCodeudor.ToString());

                    }
                    //general.mensajeERROR("Porcentaje " + Dbprocentaje.ToString() + " - Tolerancia " + porcenTolerancia.ToString() + " - Boolean " + cambioIdentificacionCodeudor.ToString());
                }
            }
            //general.mensajeERROR("Codigo cliente OLD[" + onuSubscriberId_old + "] - Codigo cliente nuevo[" + onuSubscriberId_new + "] - Error[" + onuCodigoError + " - " + osbMensajeError + "]");
        }

        private void obGuardarSPU_Click(object sender, EventArgs e)
        {

            //Inicio 200-1564
            string SBPU;
            //Fin variables 200-1564
            
            //validar si ya existe pagare unico - EN PROCESO asociado al contrato.
            //
            Int64 nuBLFNUPAGAREUNICO = 0;
            nuBLFNUPAGAREUNICO = _blFIFAP.BLFNUPAGAREUNICO(Convert.ToInt64(tbSubscription.TextBoxValue));
            if (nuBLFNUPAGAREUNICO > 0)
            {
                general.mensajeOk("El contrato ya tiene asociada una solicitud de PAGARE UNICO - EN PROCESO");
                obGuardarSPU.Enabled = false;
                return;
            }
            //

            ultraCheckEditor1.Enabled = false;
            //PROCESO PARA REGISTRAR EL XML
            string pointDelivery;
            string allowTransferQuota;
            String delivOrder;
            long nuIdPlanFinan;

            Int64 NUESTADO_DE_PAGARE = 0;
            NUESTADO_DE_PAGARE = Convert.ToInt64(general.getParam("COD_EST_EN_PRO_PAG_UNI", "Int64"));

            //DISEÑO PARA GENERAR EL XML
            String XmlRegister = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>" +
                "<P_LDC_SOLICITUD_PAGARE_UNICO_100279 ID_TIPOPAQUETE=\"100279\">" +
                "<RECEPTION_TYPE_ID>" + Convert.ToInt64(opcChanelSale.Value) + "</RECEPTION_TYPE_ID>" +
                "<CONTACT_ID >" + _dataFIFAP.SubscriberId + "</CONTACT_ID>" +
                "<ADDRESS_ID>" + Convert.ToInt64(oabDeudorAddress.Address_id) + "</ADDRESS_ID>" +
                "<COMMENT_>GENERACION SOLICITUD DE PAGARE UNICO LDCSPU</COMMENT_>" +
                //"<CONTACT_ID />" +
                //"<ADDRESS_ID />" +
                //"<COMMENT_ />" +
                "<CONTRATO_PENDIENTE>" + Convert.ToInt64(tbSubscription.TextBoxValue) + "</CONTRATO_PENDIENTE>" +
                "<M_SERVICIOS_FINANCIEROS_100275>" +
                    "<CONSECUTIVO_DEL_PAGAR>" + Convert.ToInt64(ostbSaleIdentification.TextBoxValue) + "</CONSECUTIVO_DEL_PAGAR>" +
                    "<ESTADO_DE_PAGARE>" + NUESTADO_DE_PAGARE + "</ESTADO_DE_PAGARE>" +
                    "<ID_PRODUCTO />" +
                "</M_SERVICIOS_FINANCIEROS_100275>" +
                "</P_LDC_SOLICITUD_PAGARE_UNICO_100279>";
            //String XmlRegister = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>" +  //KCienfuegos.NC4822 Se agrega el formato ISO para que permita el ingreso de carácteres especiales. Este formato no permite el &
            //    "<P_VENTA_FNB_100264 ID_TIPOPAQUETE=\"100264\">" +
            //    "<CONTRACT>" + tbSubscription.TextBoxValue + "</CONTRACT>" +
            //    "<IDENTIFICADOR_DEL_CLIENTE>" + _dataFIFAP.SubscriberId + "</IDENTIFICADOR_DEL_CLIENTE>" +
            //    "<CUPO_DE_CREDITO > " + _dataFIFAP.AvalibleQuota + "</CUPO_DE_CREDITO>" +
            //    "<CUPO_USADO >" + _dataFIFAP.UsedQuote + "</CUPO_USADO>" +
            //    "<EXTRA_CUPO_USADO >" + usedValExtraQuota + " </EXTRA_CUPO_USADO>" +
            //    "<CUPO_MANUAL_USADO > 0 </CUPO_MANUAL_USADO>" +
            //    "<IDENTIFICADOR_DE_LA_PRIMERA_FACTURA >" + _dataFIFAP.BillId1 + "</IDENTIFICADOR_DE_LA_PRIMERA_FACTURA>" +
            //    "<IDENTIFICADOR_DE_LA_SEGUNDA_FACTURA >" + _dataFIFAP.BillId2 + "</IDENTIFICADOR_DE_LA_SEGUNDA_FACTURA>" +
            //    "<OPERATING_UNIT_ID >" + _dataFIFAP.PointSaleId + "</OPERATING_UNIT_ID>" +
            //    "<SALE_CHANNEL_ID>" + _dataFIFAP.DefaultchanelSaleId + "</SALE_CHANNEL_ID >" +
            //    "<ID>" + _dataFIFAP.SellerId + "</ID>" +
            //    "<VENDEDOR >" + _dataFIFAP.SellerId + "</VENDEDOR>" +
            //    "<FECHA_DE_VENTA>" + Convert.ToDateTime(_dataFIFAP.SaleDate.ToString()).ToString("dd-MM-yyyy HH:mm:ss") + "</FECHA_DE_VENTA>" +
            //    "<FECHA_DE_SOLICITUD>" + Convert.ToDateTime(_dataFIFAP.RegisterDate.ToString()).ToString("dd-MM-yyyy HH:mm:ss") + "</FECHA_DE_SOLICITUD>";
            //if (_dataFIFAP.PromissoryType.Equals("I"))
            //{
            //    XmlRegister += "<ID_DEL_CONSECUTIVO_PAGARE_DIGITAL/>" +
            //        "<ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL>" + _dataFIFAP.SaleId.ToString() + "</ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL>";
            //}
            //else if (_dataFIFAP.PromissoryType.Equals("D"))
            //{
            //    XmlRegister += "<ID_DEL_CONSECUTIVO_PAGARE_DIGITAL>" + _dataFIFAP.SaleId.ToString() + " </ID_DEL_CONSECUTIVO_PAGARE_DIGITAL>" +
            //        "<ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL/>";
            //}
            //XmlRegister += "</P_VENTA_FNB_100264>";

            //general.mensajeERROR(XmlRegister.ToString());

            Int64 packageId = 0;
            packageId = _blFIFAP.RegisterSale(XmlRegister);
            //packageId = 123456;
            if (packageId != 0)
            {
                try
                {   
                    //Registrar datos del DEUDOR
                    Cosigner.PackageId = packageId;
                    _promissoryDeudor.PackageId = packageId;
                    _promissoryDeudor.HolderBill = "Y";
                    _DALLDCSPU.RegisterDeudor(_dataFIFAP.SubscriberId, _promissoryDeudor);

                    ////Obtener codigo de PAGARE UNICO
                    ////
                    //ostbSaleIdentification.ReadOnly = true;
                    //ostbSaleDate.ReadOnly = true;

                    //ostbRegisterDate.TextBoxObjectValue = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();
                    //ostbSaleDate.TextBoxObjectValue = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();

                    //_dataFIFAP.PromissoryType = "D";
                    ////
                    //if (_digitalPromisoryId.HasValue)
                    //{
                    //    //
                    //    _dataFIFAP.SaleId = (Int64)_digitalPromisoryId;
                    //    ostbSaleIdentification.TextBoxValue = _digitalPromisoryId.ToString();
                    //}
                    //else
                    //{
                    //    // Obtiene Tipo Comprobante parametrizado para Pagaré Digital
                    //    _dataFIFAP.VoucherType = OpenConvert.ToInt64Nullable(general.getParam("VOUCHER_TYPE_DIGITAL_PROM_NOTE", "Int64"));

                    //    if (_dataFIFAP.VoucherType == null)
                    //    {
                    //        this.Close();
                    //        return;
                    //    }

                    //    if (/*_dataFIFAP.PointSaleId*/ opcPointSale.Value != null)
                    //        _digitalPromisoryId = _blFIFAP.getDigitalPromisoryId(_dataFIFAP.VoucherType, Convert.ToInt64(opcPointSale.Value));
                    //    else
                    //    {
                    //        general.mensajeERROR("La Unidad Operativa debe tener valor");
                    //        this.Close();
                    //        return;
                    //    }

                    //    _dataFIFAP.SaleId = (Int64)_digitalPromisoryId;
                    //    ostbSaleIdentification.TextBoxValue = _digitalPromisoryId.ToString();

                    //    /*Procedimiento para evitar la duplicidad de consecutivos*/
                    //    _blFIFAP.UpRequestVoucherFNB(
                    //        Convert.ToInt64(_dataFIFAP.VoucherType),
                    //        /*Convert.ToInt64(_dataFIFAP.PointSaleId)*/Convert.ToInt64(opcPointSale.Value),
                    //        Convert.ToInt64(_dataFIFAP.SaleId));
                    //}
                    ////

                    //Registrar solicitud de PAGARE UNICO con el CODIGO DEL PARAGARE y contrato
                    //_DALLDCSPU.RegisterSPUContrato(Int64? inupackage_id, Int64? inupagare_id, Int64? inususcription_id ,Int64? inuproduct_id)
                    //_DALLDCSPU.RegisterSPUContrato(packageId, Convert.ToInt64(ostbSaleIdentification.TextBoxValue), Convert.ToInt64(tbSubscription.TextBoxValue), -1);

                    //Registrar datos del CODEUDOR

                    Int64 inucontratocodeudor = 0;

                    if (String.IsNullOrEmpty(txtCosignerContract.TextBoxValue))
                    {
                        inucontratocodeudor = -1;
                    }
                    else
                    {
                        inucontratocodeudor = Convert.ToInt64(txtCosignerContract.TextBoxValue);
                    }

                    if (blRegisterCosigner)
                    {
                        Cosigner.HolderBill = "N";
                        _DALLDCSPU.RegisterCosigner(Cosigner);
                        _DALLDCSPU.RegisterSPUCodeudor(packageId, Convert.ToInt64(ostbSaleIdentification.TextBoxValue), Convert.ToInt64(tbSubscription.TextBoxValue), inucontratocodeudor, ostbCosignerIdentification.TextBoxValue, ostbNewCosignerIdentification.TextBoxValue);
                    }

                    //aecheverry
                    _blFIFAP.doCommit();

                    general.mensajeOk("Solicitud de PAGARE UNICO [" + packageId + "] - Codigo PAGARE UNICO [" + ostbSaleIdentification.TextBoxValue + "]");

                    //08-10-2014 KCienfuegos.RNP1111 - Se valida si se debe imprimir el pagaré posterior a la venta
                    //if (_blFIFAP.getParam("IMPRIME_PAGARE_POST_VENTA") == "Y" && _dataFIFAP.PromissoryType.Equals("D") && !String.IsNullOrEmpty(Convert.ToString(_dataFIFAP.SaleId)))
                    //if (_blFIFAP.getParam("IMPRIME_PAGARE_POST_VENTA") == "Y" && _dataFIFAP.PromissoryType.Equals("D"))
                    //{
                    SBPU = general.getParam("ACT_REP_PAGUNI_LDCSPU", "String").ToString();

                    //modificacion para voucher en .NET
                    //Ing. Jorge Vaaliente, Ing. Daniel Valiente - Caso 200-1860 - 05/04/2018

                    Thread.Sleep(2000);

                    if (SBPU == "LDCPU_GDC")
                    {
                        LDCPU_GDC Windowpagare = new LDCPU_GDC(packageId.ToString());
                        Thread.Sleep(3000);
                        Windowpagare.Show();

                    }
                    else
                    {

                        //LDRPU Windowpagare = new LDRPU(packageId.ToString(), Convert.ToInt64(ostbSaleIdentification.TextBoxValue));
                        LDRPU Windowpagare = new LDRPU(packageId.ToString());
                        Windowpagare.Show();
                    }
                    //}

                    //Limpia Cache
                    _blFIFAP.clearCache();
                    //aecheverry
                    //_blFIFAP.doCommit();
                    _digitalPromisoryId = null;

                    this.Close();
                }
                catch (Exception ex)//aecheverry
                {
                    general.doRollback();
                    general.mensajeERROR(ex.Message.ToString());
                }
            }
            else
            {
                general.mensajeERROR("No se pudo generar la solicitud de PAGARE UNICO. Validar con el Administrador del sistema");
                general.doRollback();
            }
        }

        private void cbDeudorSolidario_CheckedChanged(object sender, EventArgs e)
        {
            /*01-10-2014 Llozada [RQ 1218]: Si se selecciona el flag Deudor Solidario, se debe mostrar o no 
                                            la causal */
            if (cbDeudorSolidario.Checked)
            {
                deudorSolCheck.Checked = true;
                //CausalDeudorSol.Visible = true;
                ocCausalDeudorSolidario.Visible = true;
                //CausalDeudorSol.Required = 'Y';
                ocCausalDeudorSolidario.Required = 'Y';
                txtCosignerContract.Required = 'N';

                //CASO 200-1880
                //Controlar cuando se retire el DEUDOR SOLIDARIO
                blRegisterCosigner = false;
                //ClearCosignerInfo(true);
                tcPpal.Tabs[3].Enabled = false;
                //tcPpal.Tabs[4].Enabled = false;                
                obGuardarSPU.Enabled = false;
                /////

            }
            else
            {
                deudorSolCheck.Checked = false;
                //CausalDeudorSol.Visible = false;
                ocCausalDeudorSolidario.Visible = false;
                //CausalDeudorSol.Required = 'N';
                ocCausalDeudorSolidario.Required = 'N';
                //CausalDeudorSol.Text = String.Empty;
                ocCausalDeudorSolidario.Text = String.Empty;
                nuErrorDeudorSol = 0;
                //txtCosignerContract.Required = 'Y';

                //CASO 200-1880
                //Controlar cuando se retire el DEUDOR SOLIDARIO
                blRegisterCosigner = false;
                //ClearCosignerInfo(true);
                tcPpal.Tabs[3].Enabled = false;
                //tcPpal.Tabs[4].Enabled = false;                
                obGuardarSPU.Enabled = false;    
                /////
            }
        }

        private void ocCausalDeudorSolidario_TextChanged(object sender, EventArgs e)
        {
            //
            //
            //CausalDeudorSol.Value = ocCausalDeudorSolidario.Value;
            if (ocCausalDeudorSolidario.SelectedRow != null)
            {
                CausalDeudorSol.Value = ocCausalDeudorSolidario.Value;
            }
                
        }

        private void opcTipoPagare_TextChanged(object sender, EventArgs e)
        {

            //
            if (opcTipoPagare.SelectedRow != null)
            {
                //
                if (Convert.ToString(opcTipoPagare.Value) == "D")
                {
                    //
                    opcPromissoryType.Value = "D";
                }
                else
                {
                    opcPromissoryType.Value = "I";
                }
            }

        }

        private void ostbPagare_Validating(object sender, CancelEventArgs e)
        {

            Int64 NuValidarPU = 0;
            NuValidarPU = _blFIFAP.BLFNUVALIDAPAGAREUNICO(Convert.ToInt64(ostbPagare.TextBoxValue));
            if (NuValidarPU == 1)
            {
                general.mensajeOk("El Consecutivo de Venta " + ostbSaleIdentification.TextBoxValue + " esta registrado como PAGARE UNICO");
                //ostbSaleIdentification.TextBoxValue = "";
                ostbPagare.TextBoxValue = "";
                return;
            }

            if (Convert.ToString(opcTipoPagare.Value) == "I")
            {
                ostbSaleIdentification.TextBoxValue = ostbPagare.TextBoxValue;
            }

        }

        private void BtnTestReporte_Click(object sender, EventArgs e)
        {
            Int64 packageId = 15670525;
            ostbSaleIdentification.TextBoxValue = "5423565";
            general.mensajeOk("Solicitud de PAGARE UNICO [" + packageId + "] - Codigo PAGARE UNICO [" + ostbSaleIdentification.TextBoxValue + "]");

            //08-10-2014 KCienfuegos.RNP1111 - Se valida si se debe imprimir el pagaré posterior a la venta
            //if (_blFIFAP.getParam("IMPRIME_PAGARE_POST_VENTA") == "Y" && _dataFIFAP.PromissoryType.Equals("D") && !String.IsNullOrEmpty(Convert.ToString(_dataFIFAP.SaleId)))
            //LDRPU Windowpagare = new LDRPU(packageId.ToString(), Convert.ToInt64(ostbSaleIdentification.TextBoxValue));
            LDRPU Windowpagare = new LDRPU(packageId.ToString());
            Windowpagare.Show();

        }        
    }
}