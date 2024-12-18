using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Security;
using System.Windows.Forms;
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.Util;
using OpenSystems.Windows.Controls;
using SINCECOMP.CANCELLATION.BL;
using SINCECOMP.CANCELLATION.Entities;

namespace SINCECOMP.CANCELLATION.UI
{
    public partial class FNBCR : OpenForm
    {
        private static BasicDataFNBCR _dataFNBCR = new BasicDataFNBCR();
        private static BLFNBCR _blFNBCR = new BLFNBCR();
        BindingSource customerbinding = new BindingSource();
        String typeUser;
        String a = "Article";
        String b = "ArticleDescription";
        String c = "Address";
        String d = "Iva";
        String f = "UnitValue";
        String g = "TotalValue";
        String h = "Amount";
        String i = "CancelationAmount";
        String j = "Selection";        

        BLGENERAL general = new BLGENERAL();
        Boolean Start;
        private static List<ListSN> Lista = new List<ListSN>();
        DataFIFAP dataSubscriber = new DataFIFAP();
        Int64? CausalId = null;
        List<Int64?> recepTypes = new List<long?>();
        Int64? ContactId = null;            


        public FNBCR(Int64 saleRequestId)
        {
            InitializeComponent();
            tb_RequestSale.TextBoxValue = saleRequestId.ToString();
            Start = false;

            //Se carga la información del Origen
            LoadOrigin();
            
            cb_TypeId.DataSource = general.getComboList(BLConsultas.TipoDocumentoChar, "CODIGO", "DESCRIPCION");
            cb_TypeId.DisplayMember = "Descripcion";
            cb_TypeId.ValueMember = "Codigo";            

            String[] fieldReadOnly = new string[] { a, b, c, d, f, g, h };
            general.setColumnReadOnly(dgv_Register, fieldReadOnly);
            dgv_Register.DisplayLayout.Bands[0].Columns[i].CellAppearance.TextHAlign = HAlign.Right;
            //
            dgv_Register.DisplayLayout.Bands[0].Columns[a].Hidden = true;
            //dgv_Register.DisplayLayout.Bands[0].Columns[d].Hidden = true; KCienfuegos.NC3858 27-11-2014
            dgv_Register.DisplayLayout.Bands[0].Columns[d].Format = "$ #,##0.00";
            dgv_Register.DisplayLayout.Bands[0].Columns[g].Hidden = true;
            dgv_Register.DisplayLayout.Bands[0].Columns["proveedor"].Hidden = true;
            dgv_Register.DisplayLayout.Bands[0].Columns["activityId"].Hidden = true;            
            dgv_Register.DisplayLayout.Bands[0].Columns[f].Format = "$ #,##0.00";
            dgv_Register.DisplayLayout.Bands[0].Columns[g].Format = "$ #,##0.00";
            dgv_Register.DisplayLayout.Bands[0].Columns["returnValue"].Format = "$ #,##0.00";
            dgv_Register.DisplayLayout.Bands[0].Columns["accion"].Hidden = true;
            Start = true;
			generalCheck.Checked = false;
        }

        private void LoadRequestData(Int64? subscriberId)
        {
            RequestFBNCR requestFBNCR = _blFNBCR.getRequestData(subscriberId);

            // Inicializa interacción
            tbInteraction.TextBoxValue = requestFBNCR.InterationId.ToString();

            // Inicializa dirección de respuesta
            cpAddress.Address_id = OpenConvert.ToString(requestFBNCR.DeliveryAddressId);

            if (requestFBNCR.ContactId != null)
            {
                // Inicializa solicitante
                cb_TypeContactId.Value = requestFBNCR.IdentTypeContact;
                tb_ContactId.TextBoxValue = OpenConvert.ToString(requestFBNCR.IdentContact);
                tbNameSolicitante.Enabled = false;
                tbLastNameSolicitante.Enabled = false;
                ContactId = requestFBNCR.ContactId;
            }

            cpAddress.Address_id = OpenConvert.ToString(requestFBNCR.DeliveryAddressId);

            if (recepTypes.Contains(requestFBNCR.ReceptionTypeId))
                cbReceptionType.Value = requestFBNCR.ReceptionTypeId;            
        }

        private void LoadReceptionType()
        {
            Int64 ExternRecep = OpenSystems.Common.Resources.Parameter.prm.GetParameterNumber("EXTERN_RECEPTION");

            String RecepTypeSelect = "SELECT r.RECEPTION_TYPE_ID id, r.description FROM ge_reception_type r, or_ope_uni_rece_type o "
            + " WHERE r.RECEPTION_TYPE_ID <> " + ExternRecep
            + " AND r.reception_type_id = o.reception_type_id AND o.operating_unit_id = " + dataSubscriber.PointSaleId;

            DataTable lvReceptionType = general.getValueList(RecepTypeSelect);
            cbReceptionType.DataSource = lvReceptionType;
            cbReceptionType.ValueMember = "id";
            cbReceptionType.DisplayMember = "description";

            recepTypes = new List<long?>();

            foreach (DataRow row in lvReceptionType.Rows)
            {
                Int64? recep = OpenConvert.ToLongNullable(row[0]);
                recepTypes.Add(recep);
            }
        }

        private void LoadCausal()
        {
            /* 01-09-2014 KCienfuegos.NC2047 Se agrega distinct a la consulta de la lista de valores*/
            String causalSelect = "SELECT distinct b.causal_id CODIGO, b.description DESCRIPCION FROM ps_package_causaltyp a, cc_causal b "

            + " WHERE a.PACKAGE_type_id in (100243, 100244) AND a.causal_type_id = b.causal_type_id order by codigo";

            DataTable lvCausal = general.getValueList(causalSelect);

            ocCausal.DataSource = lvCausal;
            ocCausal.ValueMember = "CODIGO";
            ocCausal.DisplayMember = "DESCRIPCION";
        }

        private void LoadOrigin()
        {
            Dictionary<string, string> Origen = new Dictionary<string, string>();

            Origen.Add("1", "Cliente");
            Origen.Add("2", "Area FNB");
            Origen.Add("3", "Grandes Superficies");
            Origen.Add("4", "Proveedor");
            Origen.Add("5", "Contratista de Venta"); 

            Int32 typeUserTemp = _blFNBCR.validateAreaOrga();

            typeUser = typeUserTemp.ToString();
            tb_origen.TextBoxValue = typeUser + " - " + Origen[typeUser];                

            tb_origen.ReadOnly = true;
            if (typeUser == "2")
            {
                uce_Move.Enabled = true;
                uce_PaymentSeller.Enabled = true;
            }
        }        

        private void btn_Search_Click(object sender, EventArgs e)
        {
            //LoadInformation();
        }

        private void LoadInformation()
        {

            if (tb_RequestSale.TextBoxValue != null)
            {
                dataSubscriber = _blFNBCR.getSubscriptionData(Convert.ToInt64(tb_RequestSale.TextBoxValue));                

                cb_TypeId.Value = dataSubscriber.IdentType;
                tb_ClientId.TextBoxValue = dataSubscriber.Identification;
                tb_contract.TextBoxValue = dataSubscriber.ContractId.ToString();
                tb_address.TextBoxValue = dataSubscriber.Address;
                tb_name.TextBoxValue = dataSubscriber.SubName;
                tb_lastname.TextBoxValue = dataSubscriber.SubLastname;
                tb_telephone.TextBoxValue = dataSubscriber.FullPhone;

                ostPuntoAtencion.TextBoxValue = dataSubscriber.PointSaleId + " - " + dataSubscriber.PointSaleName;

                ostSeller.TextBoxValue = dataSubscriber.SellerId + " - " + dataSubscriber.SellerName;

                // Inicializa fecha de registro
                tbRequestDate.TextBoxObjectValue = DateTime.Now;

                LoadReceptionType();

                LoadIdentType();

                LoadRequestData(dataSubscriber.SubscriberId);

                // Si no se obtuvo solicitante, inicializa con información del cliente
                if (String.IsNullOrEmpty(tbNameSolicitante.TextBoxValue))
                {
                    cb_TypeContactId.Value = dataSubscriber.IdentType;
                    tb_ContactId.TextBoxValue = dataSubscriber.Identification;

                                    // Obtiene información del cliente con el mismo tipo y número de identificación
                    RequestFBNCR subsInfo = _blFNBCR.Getsubscriber(Convert.ToInt64(cb_TypeContactId.Value), tb_ContactId.TextBoxValue);

                    if (subsInfo.ContactId != null)
                    {
                        tbNameSolicitante.TextBoxValue = subsInfo.NameContact;
                        tbLastNameSolicitante.TextBoxValue = subsInfo.LastNameContact;
                        tbNameSolicitante.Enabled = false;
                        tbLastNameSolicitante.Enabled = false;
                        ContactId = subsInfo.ContactId;
                    }
                    else
                    {
                        tbNameSolicitante.Enabled = true;
                        tbLastNameSolicitante.Enabled = true;
                        ContactId = null;
                    }

                }

                LoadCausal();

                //Carga información del cliente
                openHeaderTitles1.HeaderSubtitle1 = "Cliente: " + dataSubscriber.SubName + " " + dataSubscriber.SubLastname;

                List<ArticleSaleCancelation> ListFNBCR = new List<ArticleSaleCancelation>();
                customerbinding.DataSource = ListFNBCR;


                articleSaleCancelationBindingSource.DataSource = _blFNBCR.getSaleForCancelation(Convert.ToInt64(tb_RequestSale.TextBoxValue));//, Convert.ToInt64(cb_Order.Value));

                dgv_Register.DataSource = articleSaleCancelationBindingSource;

                if (Start)
                {
                    Start = false;
                    for (int filap = 0; filap <= dgv_Register.Rows.Count - 1; filap++)
                    {
                        dgv_Register.Rows[filap].ExpandAll();
                    }
                    Start = true;
                }
                //

                uce_PaymentSeller.Checked = false;
                tb_RequestSale.Focus();
            }
        }

        private void openButton1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void FNBCR_Load(object sender, EventArgs e)
        {
            tb_RequestSale.Focus();
            
            LoadInformation();            
        }


        private void btnprocess_Click(object sender, EventArgs et)
        {
            try
            {
                Boolean EntradaA;
                Boolean EntradaD;

                Int64 cont = 0;
                Boolean process = false;

                Int64? packageId = null; 
                String packages = String.Empty;


                if (cbReceptionType.Value == null)
                {
                    general.raiseERROR("Por favor ingrese el Medio de Recepción");                   
                }

                CausalId = OpenConvert.ToLongNullable(ocCausal.Value);

                if (CausalId == null)
                {
                    general.raiseERROR("Por favor ingrese la Causal");                    
                }

                if (String.IsNullOrEmpty(OpenConvert.ToString(cb_TypeContactId.Value)) ||
                    String.IsNullOrEmpty(tb_ContactId.TextBoxValue) ||
                    String.IsNullOrEmpty(tbNameSolicitante.TextBoxValue) ||
                    String.IsNullOrEmpty(tbLastNameSolicitante.TextBoxValue))
                {
                    general.raiseERROR("Falta diligenciar información del solicitante.");
                } 


                if (String.IsNullOrEmpty(ostbComment.TextBoxValue))
                {
                    general.raiseERROR("Por favor ingrese el Comentario");                    
                }

                ////CASO 200-1164 
                ////Se coloca en comentario ezte codigo ya que el servicio fnuGetPackageCancel asociado a este proceso no existe en el paquete LD_BOcancellations
                //Int32 PackageId = _blFNBCR.validatePackageCancel(Convert.ToInt64(tb_RequestSale.TextBoxValue));

                ///*26-08-2015 Mgarcia [SAO 334713]: Condicional que valida si tiene una solicitud de anulación/devolución registrada para la venta FNB*/
                //if (PackageId != 0)
                //{
                //    general.raiseERROR("Ya existe una solicitud de anulación/devolución registrada [" + PackageId + "]");
                //}
                ////Fin CASO 200-1164 

                foreach (ArticleSaleCancelation article in articleSaleCancelationBindingSource)
                {
                    if (article.Selection)
                    {
                        process = true;
                        break;
                    }
                }

                if (process)
                {

                    String dateReq = OpenConvert.DateTimeToString(tbRequestDate.TextBoxObjectValue as DateTime?);

                    // Si aún no existe el contacto, se crea como cliente con estado "2 - En Potencia"
                    if (ContactId == null)
                    {
                        ContactId = _blFNBCR.validateAndCreateContact(ContactId, tbNameSolicitante.TextBoxValue, tbLastNameSolicitante.TextBoxValue, String.Empty, String.Empty, Convert.ToInt64(cb_TypeContactId.Value), tb_ContactId.TextBoxValue, 2, null);
                    }

                    //Caso 200-2389 DANVAL 03/04/2019
                    //validacion de la causal para seguro voluntario
                    //Ninguna Causal - 0
                    //SV solicitud del usuario - 1
                    //SV por siniestro - 2
                    //SV por mala información - 3
                    //Error en digitación - 4
                    Int64 aplicaCausalSV = _blFNBCR.fnu_CausalAplica(Int64.Parse(CausalId.ToString()));
                    //
                    //mod 28-05-19
                    if (aplicaCausalSV == 3)
                    {
                        Int64 aplicaDiferido = 0;
                        for (int index = 0; index <= dgv_Register.Rows.Count - 1; index++)
                        {
                            for (Int32 filah = 0; filah <= dgv_Register.Rows[index].ChildBands[0].Rows.Count - 1; filah++)
                            {
                                if (Convert.ToBoolean(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[j].Value))
                                {
                                    aplicaDiferido = _blFNBCR.fnu_DifSeguroVoluntario(Int64.Parse(tb_RequestSale.TextBoxValue), Int64.Parse(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[a].Value.ToString()));
                                }
                            }
                        }
                        if (aplicaDiferido == 1)
                        {
                            general.mensajeERROR("El SV posee un diferido que tiene más de " + general.getParam("PAR_NUM_MAX_DIF_SEGVOL", "Int64").ToString() + " días de haber sido creado");
                            return;
                        }
                    }
                    //

                    for (int index = 0; index <= dgv_Register.Rows.Count - 1; index++)
                    {

                        String XmlA = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>";
                        String XmlD = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>";

                        String group = ((Infragistics.Win.UltraWinGrid.UltraGridGroupByRow)dgv_Register.Rows[index]).Value.ToString();

                        Int32 countA = 1;

                        Int32 countD = 1;

                        String MaestroA = "";
                        String[] parameters = new string[] { 
                        "CONTRACT",                       
                        "INTERACCION",
                        "FECHA_SOLICITUD",
                        "ID",
                        "POS_OPER_UNIT_ID",
                        "RECEPTION_TYPE_ID",
                        "CONTACT_ID",
                        "ADDRESS_ID" ,
                        "COMMENT_" ,
                        "SOLICITUD_DE_VENTA" ,                         
                        "TIPO_DE_TRANSACCION_A_ANULACION_D_DEVOLUCION" , 
                        "ORIGEN_DE_ANULACION_DEVOLUCION" , 
                        "MOVIMIENTO_CARTERA_USUARIO" ,
                        "COBRO_A_VENDEDOR"};

                        string commentA = string.Empty;

                        commentA = SecurityElement.Escape(ostbComment.TextBoxValue);

                        String[] p2A = new string[] { 
                         general.ValidarTexto(tb_contract.TextBoxValue),                         
                         general.ValidarTexto(tbInteraction.TextBoxValue),
                         general.ValidarTexto(dateReq),
                         general.ValidarTexto(dataSubscriber.SellerId),
                         general.ValidarTexto(dataSubscriber.PointSaleId),
                         general.ValidarTexto(cbReceptionType.Value),
                         general.ValidarTexto(ContactId),                         
                         general.ValidarTexto(cpAddress.Address_id),                         
                         general.ValidarAscento(commentA), 
                         general.ValidarTexto(tb_RequestSale.TextBoxValue) ,                          
                         "A",
                         general.ValidarTexto(typeUser) , 
                         uce_Move.Checked ? "Y" : "N" ,
                         uce_PaymentSeller.Checked ? "Y" : "N" };

                        MaestroA = general.cadenaXML(14, parameters, p2A);

                        String MaestroD = "";

                        string commentD = string.Empty;

                        commentD = SecurityElement.Escape(ostbComment.TextBoxValue);
                       
                        String[] p2D = new string[] { 
                         general.ValidarTexto(tb_contract.TextBoxValue),                  
                         general.ValidarTexto(tbInteraction.TextBoxValue),
                         general.ValidarTexto(dateReq),
                         general.ValidarTexto(dataSubscriber.SellerId),
                         general.ValidarTexto(dataSubscriber.PointSaleId),
                         general.ValidarTexto(cbReceptionType.Value),
                         general.ValidarTexto(ContactId),                         
                         general.ValidarTexto(cpAddress.Address_id),                         
                         general.ValidarAscento(commentD), 
                         general.ValidarTexto(tb_RequestSale.TextBoxValue) ,                          
                         "D",
                         general.ValidarTexto(typeUser) , 
                         uce_Move.Checked ? "Y" : "N" ,
                         uce_PaymentSeller.Checked ? "Y" : "N" };

                        MaestroD = general.cadenaXML(14, parameters, p2D);

                        EntradaA = false;
                        EntradaD = false;

                        XmlD += "<P_DEVOLUCION_DE_ARTICULOS_A_PROVEEDOR_100243 ID_TIPOPAQUETE=\"100243\">" + MaestroD;

                        for (Int32 filah = 0; filah <= dgv_Register.Rows[index].ChildBands[0].Rows.Count - 1; filah++)
                        {
                            if (Convert.ToBoolean(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[j].Value))
                            {
                                //caso 200-2389
                                //validacion de las nuevas causales si es seguro voluntario
                                Int64 artSV = _blFNBCR.fnu_ArticuloSV(Int64.Parse(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[a].Value.ToString()));
                                //modificacion 04/06/19
                                //if ((artSV == 0 && dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["accion"].Value.Equals("Devolver")) || (artSV == 1 && (aplicaCausalSV == 1 || aplicaCausalSV == 3 || aplicaCausalSV == 4)))
                                if (dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["accion"].Value.Equals("Devolver"))
                                {

                                    //mod 04/06/19
                                    if (artSV == 1 && aplicaCausalSV == 2)
                                    {
                                        //no hacer nada
                                    }
                                    else
                                    {

                                        EntradaD = true;
                                        XmlD += "<GRUPO_MULTIREGISTRO GROUP=\"" + countD + "\">";
                                        parameters = new string[] { "ARTICULO", "CANTIDAD", "ACTIVIDAD_DE_ENTREGA" };
                                        p2D = new string[] { general.ValidarTexto(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[a].Value),                                    
                                                     general.ValidarTexto(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[i].Value), 
                                                    general.ValidarTexto(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["activityId"].Value)};
                                        XmlD += general.cadenaXML(3, parameters, p2D);
                                        XmlD += "</GRUPO_MULTIREGISTRO>";

                                        countD++;
                                    }

                                }
                            }
                        }

                        XmlD += "<M_INSTALACI_N_DE_SERVICIOS_FINANCIEROS_100224>";

                        XmlD += "<CAUSAL_ID>" + CausalId + "</CAUSAL_ID>";

                        XmlD += "</M_INSTALACI_N_DE_SERVICIOS_FINANCIEROS_100224>";

                        XmlD += "</P_DEVOLUCION_DE_ARTICULOS_A_PROVEEDOR_100243>";

                        //------------------------------------------------------------------------------------------------------------

                        XmlA += "<P_ANULACION_DE_FINANCIACION_DE_ARTICULOS_A_PROVEEDORES_100244 ID_TIPOPAQUETE=\"100244\">" + MaestroA;

                        for (int filah = 0; filah <= dgv_Register.Rows[index].ChildBands[0].Rows.Count - 1; filah++)
                        {
                            if (Convert.ToBoolean(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[j].Value))
                            {
                                //caso 200-2389
                                //validacion de las nuevas causales si es seguro voluntario
                                Int64 artSV = _blFNBCR.fnu_ArticuloSV(Int64.Parse(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[a].Value.ToString()));
                                //mod 04/06/19
                                if (dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["accion"].Value.Equals("Anular") || (artSV == 1 && aplicaCausalSV == 2))
                                //if ((artSV == 0 && dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["accion"].Value.Equals("Anular")) || (artSV == 1 && aplicaCausalSV == 2))
                                //if (dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["accion"].Value.Equals("Anular"))
                                {
                                    XmlA += "<GRUPO_MULTIREGISTRO GROUP=\"" + countA + "\">";
                                    EntradaA = true;
                                    parameters = new string[] { "ARTICULO", "CANTIDAD", "ACTIVIDAD_DE_ENTREGA" };
                                    p2A = new string[] { general.ValidarTexto(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[a].Value),                                    
                                                     general.ValidarTexto(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[i].Value), 
                                    general.ValidarTexto(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["activityId"].Value)};
                                    XmlA += general.cadenaXML(3, parameters, p2A);
                                    XmlA += "</GRUPO_MULTIREGISTRO>";
                                    countA++;
                                }
                            }
                        }

                        XmlA += "<M_INSTALACI_N_DE_SERVICIOS_FINANCIEROS_100225>";

                        XmlA += "<CAUSAL_ID>" + CausalId + "</CAUSAL_ID>";

                        XmlA += "</M_INSTALACI_N_DE_SERVICIOS_FINANCIEROS_100225>";

                        XmlA += "</P_ANULACION_DE_FINANCIACION_DE_ARTICULOS_A_PROVEEDORES_100244>";

                        if (EntradaA)
                        {
                            cont++;
                            packageId = _blFNBCR.registerXML(XmlA);
                            packages = packages + "[" + OpenConvert.ToString(packageId) + "]";

                            //CASO 200-1164
                            for (int filah = 0; filah <= dgv_Register.Rows[index].ChildBands[0].Rows.Count - 1; filah++)
                            {
                                if (Convert.ToBoolean(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[j].Value))
                                {
                                    //caso 200-2389
                                    //validacion de las nuevas causales si es seguro voluntario
                                    Int64 artSV = _blFNBCR.fnu_ArticuloSV(Int64.Parse(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[a].Value.ToString()));
                                    //mod 04/06/19
                                    if (dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["accion"].Value.Equals("Anular") || (artSV == 1 && aplicaCausalSV == 2))
                                    //if ((artSV == 0 && dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["accion"].Value.Equals("Anular")) || (artSV == 1 && aplicaCausalSV == 2))
                                    //if (dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["accion"].Value.Equals("Anular"))
                                    {
                                        //Validar si el articulo es de seguro voluntario para actualizar el nuevo estado
                                        ////////////////
                                        Int64 nuExisteCausal = 0;
                                        Int64 nuOrdenSeguroVolunatio = 0;
                                        Int64 nuActividad = 0;

                                        //general.mensajeOk("Paso 0.1");
                                        nuExisteCausal = _blFNBCR.FNUCAUSALANUDEV(Convert.ToInt64(ocCausal.Value));
                                        
                                        /////////////Buscar causal en parametro
                                        if (nuExisteCausal == -1 || nuExisteCausal == 0)
                                        {
                                            string searchWithinThis = general.getParam("CAUS_ANUL_DEVO_TOTAL_FNBCR", "String").ToString();
                                            string searchForThis = ocCausal.Value.ToString();
                                            nuExisteCausal = searchWithinThis.IndexOf(searchForThis);
                                        }
                                        //MessageBox.Show("nuExisteCausal[" + nuExisteCausal.ToString() + "]");
                                        //general.doRollback();
                                        //return;
                                        //////////////////////////////////////////////////////

                                        //////////////////////////
                                        nuActividad = Convert.ToInt64(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["activityId"].Value);
                                        nuOrdenSeguroVolunatio = _blFNBCR.FNUORDENSEGUROVOLUNTARIO(nuActividad);

                                        //general.mensajeOk("nuExisteCausal[" + nuExisteCausal + "] == 0 && nuOrdenSeguroVolunatio[" + nuOrdenSeguroVolunatio  + "]== 1");
                                        //if comentariado para cambiar la logica de causal para cambiar esta de seguro voluntario
                                        //este if estaba relacionado antes con nuExisteCausal = _blFNBCR.FNUCAUSALANUDEV(Convert.ToInt64(ocCausal.Value));
                                        //if (nuExisteCausal == 1 && nuOrdenSeguroVolunatio == 1)
                                        if (nuExisteCausal >= 0 && nuOrdenSeguroVolunatio == 1)
                                        //if (nuExisteCausal == 0 && _blFNBCR.FNUORDENSEGUROVOLUNTARIO(Convert.ToInt64(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["activityId"].Value)) == 1)
                                        {
                                            //general.mensajeOk("1");
                                            //general.mensajeOk("tb_RequestSale.TextBoxValue[" + tb_RequestSale.TextBoxValue + "] - AN - nuActividad[" + nuActividad + "]");
                                            _blFNBCR.PRACTUALIZAVENTASEGUROS(Convert.ToInt64(tb_RequestSale.TextBoxValue), "AN", nuActividad);
                                        }
                                        /////////////////////////////////////////////////
                                        
                                        //Fin validar estado de articulo de seguro voluntario                                        
                                    }
                                }
                            }
                            //FIN CASO 200-1164
                        }

                        if (EntradaD)
                        {
                            cont++;
                            packageId = _blFNBCR.registerXML(XmlD);
                            _blFNBCR.setArticlesDevGS(packageId);
                            packages = packages + "[" + OpenConvert.ToString(packageId) + "]";

                            //CASO 200-1164
                            for (int filah = 0; filah <= dgv_Register.Rows[index].ChildBands[0].Rows.Count - 1; filah++)
                            {
                                if (Convert.ToBoolean(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[j].Value))
                                {
                                    //caso 200-2389
                                    //validacion de las nuevas causales si es seguro voluntario
                                    Int64 artSV = _blFNBCR.fnu_ArticuloSV(Int64.Parse(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[a].Value.ToString()));
                                    //Mod 04/06/19
                                    //if ((artSV == 0 && dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["accion"].Value.Equals("Devolver")) || (artSV == 1 && (aplicaCausalSV == 1 || aplicaCausalSV == 3 || aplicaCausalSV == 4)))
                                    if (dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["accion"].Value.Equals("Devolver"))
                                    {

                                        //mod 04/06/19
                                        if (artSV == 1 && aplicaCausalSV == 2)
                                        {
                                            //no hacer nada
                                        }
                                        else
                                        {

                                            //Validar si el articulo es de seguro voluntario para actualizar el nuevo estado
                                            ////////////////
                                            Int64 nuExisteCausal = 0;
                                            Int64 nuOrdenSeguroVolunatio = 0;
                                            Int64 nuActividad = 0;

                                            //general.mensajeOk("Paso 0.1");
                                            nuExisteCausal = _blFNBCR.FNUCAUSALANUDEV(Convert.ToInt64(ocCausal.Value));

                                            /////////////Buscar causal en parametro
                                            if (nuExisteCausal == -1 || nuExisteCausal == 0)
                                            {
                                                string searchWithinThis = general.getParam("CAUS_ANUL_DEVO_TOTAL_FNBCR", "String").ToString();
                                                string searchForThis = ocCausal.Value.ToString();
                                                nuExisteCausal = searchWithinThis.IndexOf(searchForThis);
                                            }
                                            //MessageBox.Show("nuExisteCausal[" + nuExisteCausal.ToString() + "]");
                                            //general.doRollback();
                                            //return;
                                            //////////////////////////////////////////////////////

                                            //////////////////////////
                                            nuActividad = Convert.ToInt64(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["activityId"].Value);
                                            nuOrdenSeguroVolunatio = _blFNBCR.FNUORDENSEGUROVOLUNTARIO(nuActividad);

                                            //general.mensajeOk("nuExisteCausal[" + nuExisteCausal + "] == 0 && nuOrdenSeguroVolunatio[" + nuOrdenSeguroVolunatio  + "]== 1");
                                            //if comentariado para cambiar la logica de causal para cambiar esta de seguro voluntario
                                            //este if estaba relacionado antes con nuExisteCausal = _blFNBCR.FNUCAUSALANUDEV(Convert.ToInt64(ocCausal.Value));
                                            //if (nuExisteCausal == 1 && nuOrdenSeguroVolunatio == 1)
                                            if (nuExisteCausal >= 0 && nuOrdenSeguroVolunatio == 1)
                                            //if (nuExisteCausal == 0 && _blFNBCR.FNUORDENSEGUROVOLUNTARIO(Convert.ToInt64(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["activityId"].Value)) == 1)
                                            {
                                                //general.mensajeOk("1");
                                                //general.mensajeOk("tb_RequestSale.TextBoxValue[" + tb_RequestSale.TextBoxValue + "] - DE - nuActividad[" + nuActividad + "]");
                                                _blFNBCR.PRACTUALIZAVENTASEGUROS(Convert.ToInt64(tb_RequestSale.TextBoxValue), "DE", nuActividad);
                                            }
                                            /////////////////////////////////////////////////

                                            //Fin validar estado de articulo de seguro voluntario  

                                        }
                                    }
                                }
                            }
                            //FIN CASO 200-1164
                        }

                        general.doCommit();
                    }

                    if (cont > 0)
                    {
                        general.mensajeOk("El proceso terminó con éxito. Solicitud(es) registrada(s): " + packages);
                        this.Close();
                    }
                    else
                    {
                        general.doRollback();                        
                    }
                }
                else
                {
                    general.raiseERROR("No se ha seleccionado ningún Artículo.");
                }
            }
            catch(Exception)
            {
                throw;
            }
        }

        private void dgv_Register_CellChange(object sender, CellEventArgs et)
        {
            if (Start)
            {
                if (et.Cell.Column.Key == i)
                {
                    if (dgv_Register.ActiveCell.Text == "")
                        dgv_Register.ActiveCell.Value = 1;
                }
            }
        }

        private void dgv_Register_Error(object sender, ErrorEventArgs et)
        {

            if (et.ErrorType == ErrorType.Data)
            {

                et.Cancel = true;

            }
        }

        private void LoadIdentType()
        {
            String IdentTypeSelect = "SELECT  a.ident_type_id Código, a.description Descripción FROM ge_identifica_type a";

            DataTable lvIdentType = general.getValueList(IdentTypeSelect);
            cb_TypeContactId.DataSource = lvIdentType;
            cb_TypeContactId.ValueMember = "Código";
            cb_TypeContactId.DisplayMember = "Descripción";

            List<long?> identTypes = new List<long?>();

            foreach (DataRow row in lvIdentType.Rows)
            {
                Int64? identT = OpenConvert.ToLongNullable(row[0]);
                identTypes.Add(identT);
            }
        }

        private void tb_ContactId_Validating(object sender, CancelEventArgs e)
        {
            // Reinicia el nombre y apellido del solicitante
            tbNameSolicitante.TextBoxValue = String.Empty;
            tbLastNameSolicitante.TextBoxValue = String.Empty;

            if (cb_TypeContactId.Value != null)
            {
                // Obtiene información del cliente con el mismo tipo y número de identificación
                RequestFBNCR subsInfo = _blFNBCR.Getsubscriber(Convert.ToInt64(cb_TypeContactId.Value), tb_ContactId.TextBoxValue);

                if (subsInfo.ContactId != null)
                {
                    tbNameSolicitante.TextBoxValue = subsInfo.NameContact;
                    tbLastNameSolicitante.TextBoxValue = subsInfo.LastNameContact;
                    tbNameSolicitante.Enabled = false;
                    tbLastNameSolicitante.Enabled = false;
                    ContactId = subsInfo.ContactId;
                }
                else
                {
                    tbNameSolicitante.Enabled = true;
                    tbLastNameSolicitante.Enabled = true;
                    ContactId = null;
                }
            }
        }

        private void cb_TypeContactId_Validating(object sender, CancelEventArgs e)
        {
            // Reinicia identificación, nombre y apellido del solicitante
            tb_ContactId.TextBoxValue = String.Empty;
            tbNameSolicitante.TextBoxValue = String.Empty;
            tbLastNameSolicitante.TextBoxValue = String.Empty;
            tbNameSolicitante.Enabled = true;
            tbLastNameSolicitante.Enabled = true;
            ContactId = null;
        }

        private void dgv_Register_AfterCellActivate(object sender, EventArgs e)
        {

        }

        private void ultraGroupBox1_Click(object sender, EventArgs e)
        {

        }

        private void generalCheck_CheckedChanged(object sender, EventArgs e)
        {

            ////////////////
            Int64 nuExisteCausal = 0;
            Int64 nuOrdenSeguroVolunatio = 0;
            Int64 nuActividad = 0;

            //general.mensajeOk("Causal[" + Convert.ToInt64(ocCausal.Value) + "]");
            if (Convert.ToInt64(ocCausal.Value) == 0 || generalCheck.Checked == false)
            {
                //general.mensajeOk("Paso 0");
                nuExisteCausal = -1;
            }
            else
            {
                //general.mensajeOk("Paso 0.1");
                nuExisteCausal = _blFNBCR.FNUCAUSALANUDEV(Convert.ToInt64(ocCausal.Value));
            }

            if (nuExisteCausal == -1)
            {
                //general.mensajeOk("Paso 0.2");
                List<ArticleSaleCancelation> src = (List<SINCECOMP.CANCELLATION.Entities.ArticleSaleCancelation>)(dgv_Register.DataSource as BindingSource).List;
                foreach (ArticleSaleCancelation row in src)
                {
                    row.Selection = generalCheck.Checked;
                }
            //dgv_Register.Refresh();
            }
            else
            {
                //general.mensajeOk("Paso 0.3");
                List<ArticleSaleCancelation> src = (List<SINCECOMP.CANCELLATION.Entities.ArticleSaleCancelation>)(dgv_Register.DataSource as BindingSource).List;
                foreach (ArticleSaleCancelation row in src)
                {
                    //////////////////////////
                    nuActividad = row.ActivityId;
                    nuOrdenSeguroVolunatio = _blFNBCR.FNUORDENSEGUROVOLUNTARIO(nuActividad);

                    //general.mensajeOk("nuExisteCausal[" + nuExisteCausal + "] == 0 && nuOrdenSeguroVolunatio[" + nuOrdenSeguroVolunatio  + "]== 1");
                    row.Selection = true;
                    if (nuExisteCausal == 0 && nuOrdenSeguroVolunatio == 1)
                    //if (nuExisteCausal == 0 && _blFNBCR.FNUORDENSEGUROVOLUNTARIO(Convert.ToInt64(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["activityId"].Value)) == 1)
                    {
                        //general.mensajeOk("1");
                        row.Selection = false;
                    }
                    if (nuExisteCausal == 1 && nuOrdenSeguroVolunatio == 0)
                    //if (nuExisteCausal == 1 && _blFNBCR.FNUORDENSEGUROVOLUNTARIO(Convert.ToInt64(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["activityId"].Value)) == 0)
                    {
                        //general.mensajeOk("2");
                        row.Selection = false;
                    }
                    /////////////////////////////////////////////////
                    //row.Selection = generalCheck.Checked;
                }
            }
            dgv_Register.Refresh();
            
        }
        private void ultraLabel14_Click(object sender, EventArgs e)
        {

        }

        private void tb_origen_TextBoxValueChanged(object sender, EventArgs e)
        {
            //typeUser = tb_origen.TextBoxValue;
        }

        //INICIO NC 618 CRM-BRI-LA DEVOLCUION DE ARTICULOS DE BRILLA PERMITE ACTIVAR LOS DOS FLAG DE DESCUENTO
        //El sistema solo permitira qeu uno de los 2 cuadros de chequeo este activo por solucitud del funcionario de BRILLA
        //        Autor         Fecha 
        //  Jorge Valiente   16-Agosto-2014
        //
        private void uce_PaymentSeller_CheckedValueChanged(object sender, EventArgs e)
        {
            if (uce_PaymentSeller.Checked == true)
            {
                uce_Move.Checked = false;
            }
        }

        private void uce_Move_CheckedValueChanged(object sender, EventArgs e)
        {
            if (uce_Move.Checked == true)
            {
                uce_PaymentSeller.Checked = false;
            }
        }

        //FIN NC 618
        //CASO 200-1164
        private void ocCausal_TextChanged(object sender, EventArgs e)
        {
            Int64 nuExisteCausal = 0;
            Int64 nuOrdenSeguroVolunatio = 0;
            Int64 nuActividad = 0;

            //general.mensajeOk("Causal[" + Convert.ToInt64(ocCausal.Value) + "]");

            nuExisteCausal = _blFNBCR.FNUCAUSALANUDEV(Convert.ToInt64(ocCausal.Value));

            //general.mensajeOk("nuExisteCausal[" + nuExisteCausal + "]");

            generalCheck.Checked = false;

            //Caso 200-2389
            //Validacion de activacion por Causal Mala Información
            //Ninguna Causal - 0
            //SV solicitud del usuario - 1
            //SV por siniestro - 2
            //SV por mala información - 3
            //Error en digitación - 4
            Int64 aplicaCausalSV = _blFNBCR.fnu_CausalAplica(Int64.Parse(ocCausal.Value.ToString()));

            for (int index = 0; index <= dgv_Register.Rows.Count - 1; index++)
            {
                for (Int32 filah = 0; filah <= dgv_Register.Rows[index].ChildBands[0].Rows.Count - 1; filah++)
                {
                    //general.mensajeOk("Actividad[" + dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["activityId"].Value + "] - Proveedor[" + dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["proveedor"].Value + "]");
                    //general.mensajeOk("Proveedor[" + dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["proveedor"].Value + "]");
                    dgv_Register.Rows[index].ChildBands[0].Rows[filah].Activation = Activation.AllowEdit;

                    nuActividad = Convert.ToInt64(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["activityId"].Value);
                    //nuOrdenSeguroVolunatio = _blFNBCR.FNUORDENSEGUROVOLUNTARIO(Convert.ToInt64(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["activityId"].Value));

                    //general.mensajeOk("Actividad[" + nuActividad + "]");
                    nuOrdenSeguroVolunatio = _blFNBCR.FNUORDENSEGUROVOLUNTARIO(nuActividad);
                    //general.mensajeOk("nuOrdenSeguroVolunatio[" + nuOrdenSeguroVolunatio + "]");


                    //general.mensajeOk("nuExisteCausal[" + nuExisteCausal + "] == 0 && nuOrdenSeguroVolunatio[" + nuOrdenSeguroVolunatio  + "]== 1");
                    
                    if (nuExisteCausal == 0 && nuOrdenSeguroVolunatio == 1)
                    //if (nuExisteCausal == 0 && _blFNBCR.FNUORDENSEGUROVOLUNTARIO(Convert.ToInt64(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["activityId"].Value)) == 1)
                    {
                        //general.mensajeOk("1");
                        dgv_Register.Rows[index].ChildBands[0].Rows[filah].Activation = Activation.NoEdit;
                        dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["Selection"].Value = false;
                    }
                    if (nuExisteCausal == 1 && nuOrdenSeguroVolunatio == 0)
                    //if (nuExisteCausal == 1 && _blFNBCR.FNUORDENSEGUROVOLUNTARIO(Convert.ToInt64(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["activityId"].Value)) == 0)
                    {
                        //general.mensajeOk("2");
                        dgv_Register.Rows[index].ChildBands[0].Rows[filah].Activation = Activation.NoEdit;
                        dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["Selection"].Value = false;
                    }

                    //Caso 200-2389
                    //Validacion de activacion por Causal de SV
                    //se bloquearan los articulos que no sean SV
                    if (aplicaCausalSV > 0)
                    {
                        Int64 artSV = _blFNBCR.fnu_ArticuloSV(Int64.Parse(dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells[a].Value.ToString()));
                        if (artSV == 0)
                        {
                            dgv_Register.Rows[index].ChildBands[0].Rows[filah].Activation = Activation.NoEdit;
                            dgv_Register.Rows[index].ChildBands[0].Rows[filah].Cells["Selection"].Value = false;
                        }
                        else
                        {
                            dgv_Register.Rows[index].ChildBands[0].Rows[filah].Activation = Activation.AllowEdit;
                        }
                    }
                    //
                }
            }
            
        }
        //CASO 200-1164
    }
}