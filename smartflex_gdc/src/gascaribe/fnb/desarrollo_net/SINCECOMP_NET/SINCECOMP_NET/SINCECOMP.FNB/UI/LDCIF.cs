using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using OpenSystems.Common.Util;
//
using SINCECOMP.FNB.BL;
using SINCECOMP.FNB.Entities;
//
using SINCECOMP.FNB.DAL;
using SINCECOMP.FNB.Controls;

namespace SINCECOMP.FNB.UI
{
    public partial class LDCIF : OpenForm
    {
        private static DataFIFAP _dataFIFAP = new DataFIFAP();
        private static BLFIFAP _blFIFAP = new BLFIFAP();        
        private static List<ListOfVal> GenderList = new List<ListOfVal>();

        private Boolean isEditDebtEnabled = true;
        private Boolean isEditCoDebtEnabled = true;

        private List<ListOfVal> contractTypeList = new List<ListOfVal>();
        public string indepentOccupId = " ";
        public string employeeOccupId = " ";
        public string fnbOccupsIds = " ";
        private Boolean boIsContractPkg = false;
        private Boolean boIsEditable_FNB = false;
        DateTime dtCurrentBirthdayDebtor;

        private static Promissory _promissoryDeudor = new Promissory();
        private static Promissory _promissoryCodeudor = new Promissory();

        BLGENERAL general = new BLGENERAL();
        String promissorySearch;

        public LDCIF(Int64 valueInitial)
        {
            InitializeComponent();
            cargaLabCombo();

            //ABaldovino RQ 7447 19-05-2015
            //Obtiene el valor del parametro para validar si la venta es editable
            try
            {
                if ("S".Equals(string.IsNullOrEmpty(general.getParam("FLAG_SALE_EDITABLE_FNB", "String").ToString()) ?
                    "" :
                    general.getParam("FLAG_SALE_EDITABLE_FNB", "String").ToString()))
                {
                    boIsEditable_FNB = true;
                }
            }
            catch
            {
            }

            try
            {
                promissorySearch = valueInitial.ToString();

                //ABaldovino
                //Valida si el funcionario actual pertenece al mismo contratista con el que se genero la venta

                boIsContractPkg = BLLDCIF.fnuValidateContract(Convert.ToInt64(promissorySearch));
                
                if (boIsContractPkg && boIsEditable_FNB)
                {
                    obEditDeudor.Visible = true;
                    obSaveDeudor.Visible = true;
                }

                //llenado datos basicos

                //Porcentaje de seguro
                DataTable DSeguro = general.getValueList("select numeric_value parametro from ld_parameter where parameter_id='INSURANCE_RATE'");
                tbPercentSure.TextBoxValue = DSeguro.Rows[0]["parametro"].ToString();

                DataTable BasicDate = DALLDCIF.FtrfSaleFNB(promissorySearch);
                tbCodeRequest.TextBoxValue = BasicDate.Rows[0]["solicitud"].ToString();
                //Incio 200-854
                //general.mensajeERROR("Solicitud[" + tbCodeRequest.TextBoxValue.ToString() + "]");
                DataTable DSDATOSPAGAREUNICO = DALLDCIF.FRTDATOSPAGAREUNICO(Convert.ToInt64(tbCodeRequest.TextBoxValue.ToString()));
                if (DSDATOSPAGAREUNICO.Rows.Count > 0)
                {
                    ostbPUV.Visible = false;
                    if (!String.IsNullOrEmpty(DSDATOSPAGAREUNICO.Rows[0]["PAGARE_UNICO"].ToString()))
                    {
                        ostbPUV.Visible = true;
                        ostbPUV.TextBoxValue = DSDATOSPAGAREUNICO.Rows[0]["PAGARE_UNICO"].ToString() + " - " + DSDATOSPAGAREUNICO.Rows[0]["VOUVHER"].ToString();
                    }
                }
                //Fin 200-854
                tbAtencionVenta.TextBoxValue = BasicDate.Rows[0]["fatencion"].ToString();
                tbDateSale.TextBoxValue = BasicDate.Rows[0]["fventa"].ToString();
                tbRegisterDate.TextBoxValue = BasicDate.Rows[0]["fregistro"].ToString();
                tbComments.TextBoxValue = BasicDate.Rows[0]["sbObservaciones"].ToString();
                tbPackState.TextBoxValue = BasicDate.Rows[0]["estadoSol"].ToString();
                tbSaleChannel.TextBoxValue = BasicDate.Rows[0]["canal"].ToString();
                tbBranchOffice.TextBoxValue = BasicDate.Rows[0]["sucursal"].ToString();
                tbQuotaAvailable.TextBoxValue = BasicDate.Rows[0]["cupoDisponible"].ToString();
                tbValueIniShare.TextBoxValue = BasicDate.Rows[0]["InitQuota"].ToString();
                tbCreditPackage.TextBoxValue = BasicDate.Rows[0]["nuPagare"].ToString(); //Validar con SBlanco
                tbContractorSeller.TextBoxValue = BasicDate.Rows[0]["contratista"].ToString(); //Validar con SBlanco
                tbsaleman.TextBoxValue = BasicDate.Rows[0]["vendedor"].ToString(); //Validar con SBlanco
                tbSaleValue.TextBoxValue = BasicDate.Rows[0]["valorventa"].ToString(); //Validar con SBlanco
                tbPendingApproval.TextBoxValue = BasicDate.Rows[0]["flag_approval"].ToString();
                tbResConsult.TextBoxValue = BasicDate.Rows[0]["result_consult"].ToString();
                tbDeliverDate.TextBoxValue = BasicDate.Rows[0]["dtDeliverDate"].ToString(); //KCienfuegos.ARA5737 20-01-2015

                tbNumFirFact.TextBoxValue = BasicDate.Rows[0]["PrmPago"].ToString();
                tbNumSecFact.TextBoxValue = BasicDate.Rows[0]["SegPago"].ToString();
                tbDtFirFact.TextBoxValue = BasicDate.Rows[0]["dtPrmPago"].ToString();
                tbDtSecFact.TextBoxValue = BasicDate.Rows[0]["dtSegPago"].ToString();
                tbTrasCu.TextBoxValue = BasicDate.Rows[0]["TrasPunto"].ToString();
                tbEntPun.TextBoxValue = BasicDate.Rows[0]["EntrPunto"].ToString();
                tbTipPag.TextBoxValue = BasicDate.Rows[0]["TipoPagare"].ToString();
                //llenado deudor
                DataTable deudorSearch = BLLDCIF.deudorSearch(Convert.ToInt64(promissorySearch));
                
                if (deudorSearch.Rows.Count > 0)
                {
                    //primer bloque
                    tbNameDebtor.TextBoxValue = deudorSearch.Rows[0]["debtorname"].ToString();
                    tbDateExpIdDebtor.TextBoxValue = Convert.ToDateTime(deudorSearch.Rows[0]["forwardingdate"].ToString()).ToString("dd/MM/yyyy");
                    tbBirthDateDebtor.TextBoxValue = Convert.ToDateTime(deudorSearch.Rows[0]["birthdaydate"].ToString()).ToString("dd/MM/yyyy");
                    tbNeighborhoodDebtor.TextBoxValue = deudorSearch.Rows[0]["neighborthood_id"].ToString();
                    tbTelephoneDebtor.TextBoxValue = deudorSearch.Rows[0]["propertyphone_id"].ToString();
                    tbAntHouseDebtor.TextBoxValue = deudorSearch.Rows[0]["housingmonth"].ToString();
                    tbNumberPersDebtor.TextBoxValue = deudorSearch.Rows[0]["dependentsnumber"].ToString();

                    tbTyIdDebtor.TextBoxValue = deudorSearch.Rows[0]["ident_type_id"].ToString();
                    tbIdDebtor.TextBoxValue = deudorSearch.Rows[0]["identification"].ToString();
                    ocDeudorGender.Text = deudorSearch.Rows[0]["gender"].ToString();
                    ocDeudorDegreeSchool.Text = deudorSearch.Rows[0]["school_degree_"].ToString();
                    tbCityDebtor.TextBoxValue = deudorSearch.Rows[0]["city"].ToString();
                    ocDeudorHouseType.Text = deudorSearch.Rows[0]["housingtype"].ToString();
                    
                    tbPlaceDebtorId.TextBoxValue = deudorSearch.Rows[0]["forwardingplace"].ToString();
                    ocDeudorCivilState.Text = deudorSearch.Rows[0]["civil_state_id"].ToString();
                    oadAddressDebtor.TextBoxValue = deudorSearch.Rows[0]["address_id"].ToString();
                    tbDepartDebtor.TextBoxValue = deudorSearch.Rows[0]["department"].ToString();
                    tbEstratDebtor.TextBoxValue = deudorSearch.Rows[0]["subcategoria"].ToString();
                    cbRelationTitDebtor.Value = deudorSearch.Rows[0]["holderrelation"].ToString();
                    
                    //segundo bloque
                    ocOccupationDeb.Text = deudorSearch.Rows[0]["occupation"].ToString();
                    oadEnterpAddDebtor.TextBoxValue = deudorSearch.Rows[0]["companyaddress_id"].ToString();
                    tbTelTwoEntrDebtor.TextBoxValue = deudorSearch.Rows[0]["phone2_id"].ToString();
                    tbAntLabDebtor.TextBoxValue = deudorSearch.Rows[0]["oldlabor"].ToString();
                    
                    tbNameEnterpDebtor.TextBoxValue = deudorSearch.Rows[0]["companyname"].ToString();
                    
                    tbTelCelEntrDebtor.TextBoxValue = deudorSearch.Rows[0]["movilphone_id"].ToString();
                    tbIngMensDebtor.TextBoxValue = deudorSearch.Rows[0]["monthlyincome"].ToString();
                    
                    tbEmailDebtor.TextBoxValue = deudorSearch.Rows[0]["email"].ToString();
                    tbTelOneEntrDebtor.TextBoxValue = deudorSearch.Rows[0]["phone1_id"].ToString();
                    tbActDebtor.TextBoxValue = deudorSearch.Rows[0]["activity"].ToString();
                    
                    //tercer bloque
                    tbRefFamDebtor.TextBoxValue = deudorSearch.Rows[0]["familiarreference"].ToString();
                    tbRefPersDebtor.TextBoxValue = deudorSearch.Rows[0]["personalreference"].ToString();
                    tbRefComDebtor.TextBoxValue = deudorSearch.Rows[0]["commerreference"].ToString();

                    oadAddrFamDebtor.TextBoxValue = deudorSearch.Rows[0]["addressfamirefe"].ToString();
                    oadAddrPersDebtor.TextBoxValue = deudorSearch.Rows[0]["addresspersrefe"].ToString();
                    oadAddrComDebtor.TextBoxValue = deudorSearch.Rows[0]["addresscommrefe"].ToString();
                    
                    tbTelFamDebtor.TextBoxValue = deudorSearch.Rows[0]["phonefamirefe"].ToString();
                    tbTelPersDebtor.TextBoxValue = deudorSearch.Rows[0]["phonepersrefe"].ToString();
                    tbTelComDebtor.TextBoxValue = deudorSearch.Rows[0]["phonecommrefe"].ToString();
                    
                    tbCelFamDebtor.TextBoxValue = deudorSearch.Rows[0]["movilphofamirefe"].ToString();
                    tbCelPersDebtor.TextBoxValue = deudorSearch.Rows[0]["movilphopersrefe"].ToString();
                    tbCelComDebtor.TextBoxValue = deudorSearch.Rows[0]["movilphocommrefe"].ToString();

                    tbGastMensDebtor.TextBoxValue = deudorSearch.Rows[0]["expensesincome"].ToString();
                    ocContractTypeDeb.Text = deudorSearch.Rows[0]["contract_type_id"].ToString();

                    dtCurrentBirthdayDebtor = (DateTime)tbBirthDateDebtor.TextBoxObjectValue; //SAO.317297

                    if (deudorSearch.Rows[0]["holder_bill"].ToString() == "Y")
                    {
                        chkTitularFactDebtor.Checked = true;
                    }
                    else
                    {
                        chkTitularFactDebtor.Checked = false;
                    }
                }

                //llenado Codeudor
                Int64 NuCantidadRowCodeudor = 0;
                DataTable codeudorSearch = BLLDCIF.codeudorSearch(Convert.ToInt64(promissorySearch));
                NuCantidadRowCodeudor = codeudorSearch.Rows.Count;
                if (codeudorSearch.Rows.Count > 0)
                {

                    if (boIsContractPkg && boIsEditable_FNB) {
                        obEditCodeudor.Visible = true;
                        obSaveCodeudor.Visible = true;
                    }

                    //primer bloque
                    tbNameCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["debtorname"].ToString();
                    tbDateExpIdCoDebtor.TextBoxValue = Convert.ToDateTime(codeudorSearch.Rows[0]["forwardingdate"].ToString()).ToString("dd/MM/yyyy");
                    tbBirthDateCoDebtor.TextBoxValue = Convert.ToDateTime(codeudorSearch.Rows[0]["birthdaydate"].ToString()).ToString("dd/MM/yyyy");
                    tbNeighborhoodCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["neighborthood_id"].ToString();
                    tbTelephoneCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["propertyphone_id"].ToString();
                    tbAntHouseCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["housingmonth"].ToString();
                    tbNumberPersCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["dependentsnumber"].ToString();

                    tbTyIdCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["ident_type_id"].ToString();
                    tbIdCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["identification"].ToString();
                    ocCodeudorGender.Text = codeudorSearch.Rows[0]["gender"].ToString();
                    ocCodeudorDegreeSchool.Text = codeudorSearch.Rows[0]["school_degree_"].ToString();
                    tbCityCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["city"].ToString();
                    ocCodeudorHouseType.Text = codeudorSearch.Rows[0]["housingtype"].ToString();
                    //chkTitularFactCoDebtor.Checked = false;
                    //
                    tbPlaceCoDebtorId.TextBoxValue = codeudorSearch.Rows[0]["forwardingplace"].ToString();
                    ocCodeudorCivilState.Text = codeudorSearch.Rows[0]["civil_state_id"].ToString();
                    oadAddressCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["address_id"].ToString();
                    tbDeparCoDebtor.TextBoxValue = deudorSearch.Rows[0]["department"].ToString();
                    tbEstratCoDebtor.TextBoxValue = deudorSearch.Rows[0]["subcategoria"].ToString();
                    cbRelationTitCoDebtor.Value = codeudorSearch.Rows[0]["holderrelation"].ToString();

                    //segundo bloque
                    ocOccupationCoDeb.Text = codeudorSearch.Rows[0]["occupation"].ToString();
                    oadEnterpAddCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["companyaddress_id"].ToString();
                    tbTelTwoEntrCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["phone2_id"].ToString();
                    tbAntLabCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["oldlabor"].ToString();
                    //
                    tbNameEnterpCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["companyname"].ToString();
                    ocContractTypeCoDeb.Text = codeudorSearch.Rows[0]["contract_type_id"].ToString();
                    tbTelCelEntrCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["movilphone_id"].ToString();
                    tbIngMensCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["monthlyincome"].ToString();
                    //
                    //tbEmailCoDebtor.TextBoxValue = deudorSearch.Rows[0]["email"].ToString();
                    tbTelOneEntrCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["phone1_id"].ToString();
                    tbActCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["activity"].ToString();
                    tbGastMensCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["expensesincome"].ToString();

                    //tercer bloque
                    tbRefFamCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["familiarreference"].ToString();
                    tbRefPersCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["personalreference"].ToString();
                    tbRefComCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["commerreference"].ToString();
                    //
                    oadAddrFamCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["addressfamirefe"].ToString();
                    oadAddrPersCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["addresspersrefe"].ToString();
                    oadAddrComCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["addresscommrefe"].ToString();
                    //
                    tbTelFamCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["phonefamirefe"].ToString();
                    tbTelPersCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["phonepersrefe"].ToString();
                    tbTelComCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["phonecommrefe"].ToString();
                    //
                    tbCelFamCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["movilphofamirefe"].ToString();
                    tbCelPersCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["movilphopersrefe"].ToString();
                    tbCelComCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["movilphocommrefe"].ToString();

                    tbGastMensCoDebtor.TextBoxValue = codeudorSearch.Rows[0]["expensesincome"].ToString();

                    if (codeudorSearch.Rows[0]["holder_bill"].ToString() == "Y")
                    {
                        chkTitularFacCoDebtor.Checked = true;
                    }
                    else
                    {
                        chkTitularFacCoDebtor.Checked = false;
                    }
                }


                ////Comentariado hasta que se soliciten reaplicar 200-310
                ////Incio 200-310 - Activado por el CASO 200-1880
                DataTable DatosCodeudor = DALLDCIF.FRTCODEUDORACTUALIZADO(promissorySearch);
                if (DatosCodeudor.Rows.Count > 0)
                {
                    if (NuCantidadRowCodeudor > 0)
                    {
                        if (!String.IsNullOrEmpty(DatosCodeudor.Rows[0]["Nombre"].ToString()))
                        {
                            tbNameCoDebtor.TextBoxValue = DatosCodeudor.Rows[0]["Nombre"].ToString();
                            //general.mensajeERROR("Nombre[" + tbNameCoDebtor.TextBoxValue.ToString() + "]");
                        }
                        if (!String.IsNullOrEmpty(DatosCodeudor.Rows[0]["ident"].ToString()))
                        {
                            tbIdCoDebtor.TextBoxValue = DatosCodeudor.Rows[0]["ident"].ToString();
                            //general.mensajeERROR("Nombre[" + tbNameCoDebtor.TextBoxValue.ToString() + "]");
                        }
                    }
                    if (!String.IsNullOrEmpty(DatosCodeudor.Rows[0]["USED_EXTRA_QUOTE"].ToString()))
                    {
                        tbUSED_EXTRA_QUOTE.TextBoxValue = DatosCodeudor.Rows[0]["USED_EXTRA_QUOTE"].ToString();
                        //general.mensajeERROR("Nombre[" + tbNameCoDebtor.TextBoxValue.ToString() + "]");
                    }
                    //general.mensajeERROR("Cupo Manual Usado [" + DatosCodeudor.Rows[0]["MANUAL_QUOTA_USED"].ToString() + "]");
                    if (!String.IsNullOrEmpty(DatosCodeudor.Rows[0]["MANUAL_QUOTA_USED"].ToString()))
                    {
                        tbMANUAL_QUOTA_USED.TextBoxValue = DatosCodeudor.Rows[0]["MANUAL_QUOTA_USED"].ToString();
                        //general.mensajeERROR("Nombre[" + tbNameCoDebtor.TextBoxValue.ToString() + "]");
                    }
                    //general.mensajeERROR("Deudor Solidario [" + DatosCodeudor.Rows[0]["solidarity_debtor"].ToString() + "]");
                    if ((DatosCodeudor.Rows[0]["solidarity_debtor"].ToString() == "N") || (String.IsNullOrEmpty(DatosCodeudor.Rows[0]["solidarity_debtor"].ToString())))
                    {
                        deudorSolCheck.Checked = false;
                    }
                    else
                    {
                        deudorSolCheck.Checked = true;
                        if (!String.IsNullOrEmpty(DatosCodeudor.Rows[0]["causal_id"].ToString()))
                        {
                            CausalDeudorSol.TextBoxValue = DatosCodeudor.Rows[0]["causal_id"].ToString();
                            //general.mensajeERROR("Nombre[" + tbNameCoDebtor.TextBoxValue.ToString() + "]");
                        }

                    }
                }
                ////Fin 200-310 - Activado por el CASO 200-1880

                //llenado articulos
                List<ArticleLDCIF> ListArticle = new List<ArticleLDCIF>();
                foreach (DataRow row in BasicDate.Rows)
                {
                    ArticleLDCIF vArticle = new ArticleLDCIF(row);
                    ListArticle.Add(vArticle);
                }
                BindingSource customerbinding = new BindingSource();
                customerbinding.DataSource = ListArticle;
                dgArticle.DataSource = customerbinding;             
            }
            catch (Exception e)
            {
                //MessageBox.Show( "Error en: " + e.Message);
            }
        }

        private void dgArticle_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {

        }

        private void tbIdDebtor_Load(object sender, EventArgs e)
        {

        }

        private void obEditDeudor_Click(object sender, EventArgs e)
        {
            
            //ABaldovino RQ 7447 19-05-2015
            //Se verifica el parametro que indica si la fecha de nacimiento es editable

            Boolean isBtDateEditable = false;
            try
            {
                if ("S".Equals(string.IsNullOrEmpty(general.getParam("ISBTEDITABLE_FNB", "String").ToString()) ?
                                                    "" :
                                                    general.getParam("ISBTEDITABLE_FNB", "String").ToString())) {
                                                        
                    isBtDateEditable = true;
                }
            }
            catch
            {
                isBtDateEditable = false;
            }

            if (isEditDebtEnabled)
            {
                ocDeudorGender.Required = 'Y';
                ocDeudorGender.ReadOnly = false;
                tbDateExpIdDebtor.Required = 'Y';
                tbDateExpIdDebtor.ReadOnly = false;

                //ABaldovino RQ 7447 19-05-2015
                if (isBtDateEditable)
                {
                    tbBirthDateDebtor.Required = 'Y';
                    tbBirthDateDebtor.ReadOnly = false;
                }

                tbTelephoneDebtor.Required = 'Y';
                tbTelephoneDebtor.ReadOnly = false;
                tbAntHouseDebtor.Required = 'Y';
                tbAntHouseDebtor.ReadOnly = false;
                tbNumberPersDebtor.Required = 'Y';
                tbNumberPersDebtor.ReadOnly = false;
                ocDeudorDegreeSchool.Required = 'Y';
                ocDeudorDegreeSchool.ReadOnly = false;
                ocDeudorHouseType.Required = 'Y';
                ocDeudorHouseType.ReadOnly = false;
                ocDeudorCivilState.Required = 'Y';
                ocDeudorCivilState.ReadOnly = false;
                //oadAddressDebtor.ReadOnly = false;
                ocOccupationDeb.Required = 'Y';
                ocOccupationDeb.ReadOnly = false;
                //oadEnterpAddDebtor.ReadOnly = false;
                tbTelTwoEntrDebtor.ReadOnly = false;
                tbAntLabDebtor.ReadOnly = false;
                tbNameEnterpDebtor.ReadOnly = false;
                ocContractTypeDeb.ReadOnly = false;
                tbTelCelEntrDebtor.ReadOnly = false;
                tbIngMensDebtor.Required = 'Y';
                tbIngMensDebtor.ReadOnly = false;
                tbEmailDebtor.ReadOnly = false;
                tbTelOneEntrDebtor.ReadOnly = false;
                tbActDebtor.ReadOnly = false;
                tbGastMensDebtor.Required = 'Y';
                tbGastMensDebtor.ReadOnly = false;
                tbRefFamDebtor.Required = 'Y';
                tbRefFamDebtor.ReadOnly = false;
                tbRefPersDebtor.ReadOnly = false;
                tbRefComDebtor.ReadOnly = false;
                //oadAddrFamDebtor.ReadOnly = false;
                //oadAddrPersDebtor.ReadOnly = false;
                //oadAddrComDebtor.ReadOnly = false;
                tbTelFamDebtor.ReadOnly = false;
                tbTelPersDebtor.ReadOnly = false;
                tbTelComDebtor.ReadOnly = false;
                tbCelFamDebtor.ReadOnly = false;
                tbCelPersDebtor.ReadOnly = false;
                tbCelComDebtor.ReadOnly = false;

                obSaveDeudor.Enabled = true;
                obEditDeudor.Text = "Cancelar";
                isEditDebtEnabled = false;
            }
            else {
                this.Close();             
            }            

            /*Inicio SAO.317297 KCienfuegos*/
            if (!isEditDebtEnabled)
            {
                if (OpenConvert.ToString(ocOccupationDeb.Value).Equals(indepentOccupId))
                {
                    tbNameEnterpDebtor.Required = 'N';
                    tbNameEnterpDebtor.ReadOnly = true;
                    tbNameEnterpDebtor.TextBoxValue = " ";

                    ocContractTypeDeb.Required = 'N';
                    ocContractTypeDeb.Text = "";
                    ocContractTypeDeb.Value = null;
                    ocContractTypeDeb.ReadOnly = true;

                    tbActDebtor.Required = 'Y';
                    tbActDebtor.ReadOnly = false;

                    tbAntLabDebtor.ReadOnly = true;
                    tbAntLabDebtor.TextBoxValue = "";
                    tbAntLabDebtor.Required = 'N';
                }
                else if (OpenConvert.ToString(ocOccupationDeb.Value).Equals(employeeOccupId))
                {
                    tbNameEnterpDebtor.Required = 'Y';
                    tbNameEnterpDebtor.ReadOnly = false;

                    ocContractTypeDeb.Required = 'Y';
                    ocContractTypeDeb.ReadOnly = false;

                    tbActDebtor.Required = 'N';
                    tbActDebtor.ReadOnly = true;
                    tbActDebtor.TextBoxValue = " ";

                    tbAntLabDebtor.ReadOnly = false;
                    tbAntLabDebtor.Required = 'Y';
                }
                else
                {
                    tbNameEnterpDebtor.Required = 'N';
                    tbNameEnterpDebtor.ReadOnly = true;
                    tbNameEnterpDebtor.TextBoxValue = " ";

                    ocContractTypeDeb.Required = 'N';
                    ocContractTypeDeb.Value = null;
                    ocContractTypeDeb.ReadOnly = true;

                    tbActDebtor.Required = 'N';
                    tbActDebtor.ReadOnly = true;
                    tbActDebtor.TextBoxValue = " ";

                    tbAntLabDebtor.ReadOnly = true;
                    tbAntLabDebtor.TextBoxValue = "";
                    tbAntLabDebtor.Required = 'N';
                }
            }
            /*Fin SAO.317297*/
           
        }

        private void obSaveDeudor_Click(object sender, EventArgs e)
        {
            Boolean comer = true;
            Double  yearsParameter = 0;
            int     years;
            
            if (String.IsNullOrEmpty(tbTelephoneDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el telefono del deudor");
            }
            else if (String.IsNullOrEmpty(tbAntHouseDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado la antiguedad de la vivienda del deudor");
            }

            else if (String.IsNullOrEmpty(tbNumberPersDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el numero de personas a cargo del deudor");
            }

            else if (String.IsNullOrEmpty(Convert.ToString(ocDeudorDegreeSchool.Value)))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha selecccionado el nivel de estudios del deudor");
            }

            else if (String.IsNullOrEmpty(Convert.ToString(ocDeudorHouseType.Value)))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el tipo de vivienda del deudor");
            }

            else if (String.IsNullOrEmpty(tbAntHouseDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el estado civil del deudor");
            }

            else if (String.IsNullOrEmpty(Convert.ToString(ocOccupationDeb.Value)))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado la ocupacion del deudor");
            }

            else if ((Convert.ToString(ocOccupationDeb.Value).Equals(employeeOccupId)) && String.IsNullOrEmpty(tbNameEnterpDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre de la empresa donde trabaja");
            }

            else if (Convert.ToString(ocOccupationDeb.Value).Equals(employeeOccupId) && ocContractTypeDeb.Value == null)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el tipo de contrato");
            }
            else if (Convert.ToString(ocOccupationDeb.Value).Equals(indepentOccupId) && String.IsNullOrEmpty(tbActDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado una actividad");
            }
            else if (Convert.ToString(ocOccupationDeb.Value).Equals(employeeOccupId) && !(OpenConvert.ToInt64Nullable(tbAntLabDebtor.TextBoxValue) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no digitado la antiguedad laboral");
            }      
            
            else if (String.IsNullOrEmpty(tbIngMensDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado los ingresos mensuales");
            }
            else if (String.IsNullOrEmpty(tbGastMensDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado los gastos mensuales");
            }
            /*SAO.317297*/
            else if (string.IsNullOrEmpty(tbRefFamDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre de la referencia familiar");
            }
            else if (string.IsNullOrEmpty(tbTelFamDebtor.TextBoxValue) && string.IsNullOrEmpty(tbCelFamDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, se debe digitar un tel�fono fijo o un tel�fono celular para la referencia familiar");
            }

            if (!string.IsNullOrEmpty(tbRefPersDebtor.TextBoxValue) ||
                !string.IsNullOrEmpty(oadAddrPersDebtor.TextBoxValue) ||
                !string.IsNullOrEmpty(tbTelPersDebtor.TextBoxValue) ||
                !string.IsNullOrEmpty(tbCelPersDebtor.TextBoxValue))
            {
                if (string.IsNullOrEmpty(tbRefPersDebtor.TextBoxValue))
                {
                    comer = false;
                    general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre de la referencia personal");
                }
                else if (string.IsNullOrEmpty(tbTelPersDebtor.TextBoxValue) && string.IsNullOrEmpty(tbCelPersDebtor.TextBoxValue))
                {
                    comer = false;
                    general.mensajeERROR("Faltan datos requeridos, se debe digitar un tel�fono o un tel�fono celular para la referencia personal");
                }
            }

            if (!string.IsNullOrEmpty(tbRefComDebtor.TextBoxValue) ||
                !string.IsNullOrEmpty(oadAddrComDebtor.TextBoxValue) ||
                !string.IsNullOrEmpty(tbTelComDebtor.TextBoxValue) ||
                !string.IsNullOrEmpty(tbCelComDebtor.TextBoxValue))
            {
                if (string.IsNullOrEmpty(tbRefComDebtor.TextBoxValue))
                {
                    comer = false;
                    general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre de la referencia comercial");
                }
                else if (string.IsNullOrEmpty(tbTelComDebtor.TextBoxValue) && string.IsNullOrEmpty(tbCelComDebtor.TextBoxValue))
                {
                    comer = false;
                    general.mensajeERROR("Faltan datos requeridos, se debe digitar un tel�fono o un tel�fono celular para la referencia comercial");
                }
            }
            /*Fin SAO.317297*/
        
            yearsParameter = 0;
            try
            {
                yearsParameter = Convert.ToDouble(general.getParam("MAX_YEARS_DEUDOR", "Int64"));
            }
            catch
            {
                yearsParameter = 65;
            }

            years = DateTime.Today.Year - ((DateTime)tbBirthDateDebtor.TextBoxObjectValue).Year;

            if ((DateTime.Today.Month < ((DateTime)tbBirthDateDebtor.TextBoxObjectValue).Month)
                || (DateTime.Today.Month == ((DateTime)tbBirthDateDebtor.TextBoxObjectValue).Month
                    && DateTime.Today.Day < ((DateTime)tbBirthDateDebtor.TextBoxObjectValue).Day))
            {
                years = years - 1;
            }

            //SAO.317297 Se agrega la validaci�n en el condicional si la fecha de nacimiento del deudor fue modificada
            if (years > yearsParameter && !obEditCodeudor.Visible && dtCurrentBirthdayDebtor != (DateTime)tbBirthDateDebtor.TextBoxObjectValue)
            {
                comer = false;
                general.mensajeERROR("La edad supera el limite establecido para venta sin codeudor.");
            }
            //FIN SAO.317297

            try {

                setPromissoryDeudor();

                if (comer)
                {
                    BLLDCIF.EditPromissory(Convert.ToInt64(promissorySearch), _promissoryDeudor);
                    general.mensajeOk("Informacion actualizada con exito!");

                    obSaveDeudor.Enabled = false;
                    obEditDeudor.Text = "Editar";
                    isEditDebtEnabled = true;

                    ocDeudorGender.ReadOnly = true;
                    ocDeudorGender.Required = 'N';
                    tbDateExpIdDebtor.ReadOnly = true;
                    tbDateExpIdDebtor.Required = 'N';
                    tbBirthDateDebtor.ReadOnly = true;
                    tbBirthDateDebtor.Required = 'N';
                    tbTelephoneDebtor.ReadOnly = true;
                    tbTelephoneDebtor.Required = 'N';
                    tbAntHouseDebtor.ReadOnly = true;
                    tbAntHouseDebtor.Required = 'N';
                    tbNumberPersDebtor.ReadOnly = true;
                    tbNumberPersDebtor.Required = 'N';
                    ocDeudorDegreeSchool.ReadOnly = true;
                    ocDeudorDegreeSchool.Required = 'N';
                    ocDeudorHouseType.ReadOnly = true;
                    ocDeudorHouseType.Required = 'N';
                    ocDeudorCivilState.ReadOnly = true;
                    ocDeudorCivilState.Required = 'N';
                    ocOccupationDeb.ReadOnly = true;
                    ocOccupationDeb.Required = 'N';
                    tbTelTwoEntrDebtor.ReadOnly = true;
                    tbAntLabDebtor.ReadOnly = true;
                    tbNameEnterpDebtor.ReadOnly = true;
                    ocContractTypeDeb.ReadOnly = true;
                    tbTelCelEntrDebtor.ReadOnly = true;
                    tbIngMensDebtor.ReadOnly = true;
                    tbIngMensDebtor.Required = 'N';
                    tbEmailDebtor.ReadOnly = true;
                    tbTelOneEntrDebtor.ReadOnly = true;
                    tbActDebtor.ReadOnly = true;
                    tbGastMensDebtor.ReadOnly = true;
                    tbGastMensDebtor.Required = 'N';
                    tbRefFamDebtor.ReadOnly = true;
                    tbRefFamDebtor.Required = 'N';
                    tbRefPersDebtor.ReadOnly = true;
                    tbRefComDebtor.ReadOnly = true;
                    tbTelFamDebtor.ReadOnly = true;
                    tbTelPersDebtor.ReadOnly = true;
                    tbTelComDebtor.ReadOnly = true;
                    tbCelFamDebtor.ReadOnly = true;
                    tbCelPersDebtor.ReadOnly = true;
                    tbCelComDebtor.ReadOnly = true;

                }
            }
            catch (Exception ex)
            {
                general.doRollback();
                general.mensajeERROR(ex.Message.ToString());
            }

        }

        private void setPromissoryDeudor() {

            _promissoryDeudor.ForwardingDate = Convert.ToDateTime(tbDateExpIdDebtor.TextBoxValue);
            _promissoryDeudor.BirthdayDate = Convert.ToDateTime(tbBirthDateDebtor.TextBoxValue);           
            _promissoryDeudor.Gender = Convert.ToString(ocDeudorGender.Value);
            _promissoryDeudor.CivilStateId = Convert.ToInt64(ocDeudorCivilState.Value);
            _promissoryDeudor.PropertyPhone = tbTelephoneDebtor.TextBoxValue;
            _promissoryDeudor.DependentsNumber = Convert.ToInt64(tbNumberPersDebtor.TextBoxValue);
            _promissoryDeudor.HousingType = Convert.ToInt64(ocDeudorHouseType.Value);
            _promissoryDeudor.SchoolDegree = Convert.ToInt64(ocDeudorDegreeSchool.Value);
            _promissoryDeudor.HousingMonth = Convert.ToInt64(tbAntHouseDebtor.TextBoxValue);

            _promissoryDeudor.Occupation = Convert.ToString(ocOccupationDeb.Value);
            _promissoryDeudor.CompanyName = tbNameEnterpDebtor.TextBoxValue;
            _promissoryDeudor.Email = tbEmailDebtor.TextBoxValue;
           
            if (string.IsNullOrEmpty(ocContractTypeDeb.Value as string))
            {
                _promissoryDeudor.ContractType = null;
            }
            else
            {
                _promissoryDeudor.ContractType = Convert.ToInt64(ocContractTypeDeb.Value);
            }
            
            _promissoryDeudor.Phone1 = tbTelOneEntrDebtor.TextBoxValue;
            _promissoryDeudor.Phone2 =tbTelTwoEntrDebtor.TextBoxValue;
            _promissoryDeudor.MovilPhone = tbTelCelEntrDebtor.TextBoxValue;
            _promissoryDeudor.Activity = tbActDebtor.TextBoxValue;

            _promissoryDeudor.OldLabor = OpenConvert.ToInt64Nullable(tbAntLabDebtor.TextBoxValue);
            _promissoryDeudor.MonthlyIncome = Convert.ToDouble(tbIngMensDebtor.TextBoxValue);
            _promissoryDeudor.ExpensesIncome = Convert.ToDouble(tbGastMensDebtor.TextBoxValue);

            _promissoryDeudor.FamiliarReference = tbRefFamDebtor.TextBoxValue;
            _promissoryDeudor.PhoneFamiRefe = tbTelFamDebtor.TextBoxValue;
            _promissoryDeudor.MovilPhoFamiRefe = tbCelFamDebtor.TextBoxValue;
            _promissoryDeudor.PromissoryType = "D";

            _promissoryDeudor.PersonalReference = tbRefPersDebtor.TextBoxValue;
            _promissoryDeudor.PhonePersRefe = tbTelPersDebtor.TextBoxValue;
            _promissoryDeudor.MovilPhoPersRefe = tbCelPersDebtor.TextBoxValue;
            _promissoryDeudor.CommercialReference = tbRefComDebtor.TextBoxValue;
            _promissoryDeudor.PhoneCommRefe = tbTelComDebtor.TextBoxValue;
            _promissoryDeudor.MovilPhoCommRefe = tbCelComDebtor.TextBoxValue;        
        }

        private void setPromissoryCodeudor()
        {
            _promissoryCodeudor.ForwardingDate = Convert.ToDateTime(tbDateExpIdCoDebtor.TextBoxValue);
            _promissoryCodeudor.BirthdayDate = Convert.ToDateTime(tbBirthDateCoDebtor.TextBoxValue);
            _promissoryCodeudor.Gender = Convert.ToString(ocCodeudorGender.Value);
            _promissoryCodeudor.CivilStateId = Convert.ToInt64(ocCodeudorCivilState.Value);
            _promissoryCodeudor.PropertyPhone = tbTelephoneCoDebtor.TextBoxValue;
            _promissoryCodeudor.DependentsNumber = Convert.ToInt64(tbNumberPersCoDebtor.TextBoxValue);
            _promissoryCodeudor.HousingType = Convert.ToInt64(ocCodeudorHouseType.Value);
            _promissoryCodeudor.SchoolDegree = Convert.ToInt64(ocCodeudorDegreeSchool.Value);
            _promissoryCodeudor.HousingMonth = Convert.ToInt64(tbAntHouseCoDebtor.TextBoxValue);

            _promissoryCodeudor.Occupation = Convert.ToString(ocOccupationCoDeb.Value);
            _promissoryCodeudor.CompanyName = tbNameEnterpCoDebtor.TextBoxValue;
            _promissoryCodeudor.Email = "";

            if (string.IsNullOrEmpty(ocContractTypeCoDeb.Value as string))
            {
                _promissoryCodeudor.ContractType = null;
            }
            else
            {
                _promissoryCodeudor.ContractType = Convert.ToInt64(ocContractTypeCoDeb.Value);
            }

            _promissoryCodeudor.Phone1 = tbTelOneEntrCoDebtor.TextBoxValue;
            _promissoryCodeudor.Phone2 = tbTelTwoEntrCoDebtor.TextBoxValue;
            _promissoryCodeudor.MovilPhone = tbTelCelEntrCoDebtor.TextBoxValue;
            _promissoryCodeudor.Activity = tbActCoDebtor.TextBoxValue;

            _promissoryCodeudor.OldLabor = OpenConvert.ToInt64Nullable(tbAntLabCoDebtor.TextBoxValue);
            _promissoryCodeudor.MonthlyIncome = Convert.ToDouble(tbIngMensCoDebtor.TextBoxValue);
            _promissoryCodeudor.ExpensesIncome = Convert.ToDouble(tbGastMensCoDebtor.TextBoxValue);

            _promissoryCodeudor.FamiliarReference = tbRefFamCoDebtor.TextBoxValue;
            _promissoryCodeudor.PhoneFamiRefe = tbTelFamCoDebtor.TextBoxValue;
            _promissoryCodeudor.MovilPhoFamiRefe = tbCelFamCoDebtor.TextBoxValue;

            _promissoryCodeudor.PromissoryType = "C";
            _promissoryCodeudor.PersonalReference = tbRefPersCoDebtor.TextBoxValue;
            _promissoryCodeudor.PhonePersRefe = tbTelPersCoDebtor.TextBoxValue;
            _promissoryCodeudor.MovilPhoPersRefe = tbCelPersCoDebtor.TextBoxValue;
            _promissoryCodeudor.CommercialReference = tbRefComCoDebtor.TextBoxValue;
            _promissoryCodeudor.PhoneCommRefe = tbTelComCoDebtor.TextBoxValue;
            _promissoryCodeudor.MovilPhoCommRefe = tbCelComCoDebtor.TextBoxValue;
        }

        private void cargaLabCombo() {

            // CREACION DE LISTAS //

            //Lista de genero
            GenderList.Clear();
            GenderList.Add(new ListOfVal("M", "Masculino"));
            GenderList.Add(new ListOfVal("F", "Femenino"));

            ////Genero del deudor
            ocDeudorGender.DataSource = GenderList;
            ocDeudorGender.ValueMember = "id";
            ocDeudorGender.DisplayMember = "description";

            ////Genero del codeudor
            ocCodeudorGender.DataSource = GenderList;
            ocCodeudorGender.ValueMember = "id";
            ocCodeudorGender.DisplayMember = "description";

            DataTable degreeSchool = general.getValueList(BLConsultas.NivelEstudios);

            //Nivel de estudios del deudor
            ocDeudorDegreeSchool.DataSource = degreeSchool;
            ocDeudorDegreeSchool.ValueMember = "id";
            ocDeudorDegreeSchool.DisplayMember = "descripci�n";

            //Nivel de estudios del codeudor
            ocCodeudorDegreeSchool.DataSource = degreeSchool;
            ocCodeudorDegreeSchool.ValueMember = "id";
            ocCodeudorDegreeSchool.DisplayMember = "descripci�n";

            //Estado civil
            DataTable civilState = general.getValueList(BLConsultas.CivilState);

            //Estado civil deudor
            ocDeudorCivilState.DataSource = civilState;
            ocDeudorCivilState.ValueMember = "id";
            ocDeudorCivilState.DisplayMember = "descripcion";

            //Estado civil codeudor
            ocCodeudorCivilState.DataSource = civilState;
            ocCodeudorCivilState.ValueMember = "id";
            ocCodeudorCivilState.DisplayMember = "descripcion";

            //Tipo de casa
            DataTable houseType = general.getValueList(BLConsultas.TipoCasa);

            ////Tipo de casa deudor
            ocDeudorHouseType.DataSource = houseType;
            ocDeudorHouseType.ValueMember = "id";
            ocDeudorHouseType.DisplayMember = "descripcion";

            ////Tipo de casa codeudor
            ocCodeudorHouseType.DataSource = houseType;
            ocCodeudorHouseType.ValueMember = "id";
            ocCodeudorHouseType.DisplayMember = "descripcion";

            indepentOccupId = general.getParam("INDEPENDENT_OCCUPATION_ID", "String").ToString(); //_blFIFAP.getParam("INDEPENDENT_OCCUPATION_ID");

            try
            {
                employeeOccupId = general.getParam("EMPLOYEE_OCCUPATION_ID", "String").ToString(); //_blFIFAP.getParam("INDEPENDENT_OCCUPATION_ID");
                
                ocOccupationDeb.DataSource = general.getValueList("select profession_id Id, description description from ge_profession WHERE REGEXP_INSTR(dald_parameter.fsbGetValue_Chain('FNB_OCCUPATIONS_IDS'), '(\\W|^)'|| profession_id ||'(\\W|$)') > 0 Order By profession_id");
                ocOccupationCoDeb.DataSource = general.getValueList("select profession_id Id, description description from ge_profession WHERE REGEXP_INSTR(dald_parameter.fsbGetValue_Chain('FNB_OCCUPATIONS_IDS'), '(\\W|^)'|| profession_id ||'(\\W|$)') > 0 Order By profession_id");
            }
            catch
            {

            }
            //Ocupacion deudor
            ocOccupationDeb.DisplayMember = "description";
            ocOccupationDeb.ValueMember = "id";

            //Ocupacion codeudor
            ocOccupationCoDeb.DisplayMember = "description";
            ocOccupationCoDeb.ValueMember = "id";

            //tipo de contrato
            contractTypeList.Add(new ListOfVal("1", "1 - Indefinido"));
            contractTypeList.Add(new ListOfVal("2", "2 - Temporal"));
            contractTypeList.Add(new ListOfVal("3", "3 - Fijo"));
            contractTypeList.Add(new ListOfVal("4", "4 - Otro"));

            //Tipo de contrato deudor
            ocContractTypeDeb.DataSource = contractTypeList;
            ocContractTypeDeb.ValueMember = "id";
            ocContractTypeDeb.DisplayMember = "description";

            //Tipo de contrato codeudor
            ocContractTypeCoDeb.DataSource = contractTypeList;
            ocContractTypeCoDeb.ValueMember = "id";
            ocContractTypeCoDeb.DisplayMember = "description";           
        }

        private void obEditCodeudor_Click(object sender, EventArgs e)
        {
            //ABaldovino RQ 7447 19-05-2015
            //Se verifica el parametro que indica si la fecha de nacimiento es editable

            Boolean isBtDateEditable = false;
            try
            {
                if ("S".Equals(string.IsNullOrEmpty(general.getParam("ISBTEDITABLE_FNB", "String").ToString()) ?
                                                    "" :
                                                    general.getParam("ISBTEDITABLE_FNB", "String").ToString()))
                {

                    isBtDateEditable = true;
                }
            }
            catch
            {
                isBtDateEditable = false;
            }
            
            if (isEditCoDebtEnabled)
            {
                tbDateExpIdCoDebtor.Required = 'Y';
                tbDateExpIdCoDebtor.ReadOnly = false;
                ocCodeudorGender.Required = 'Y';
                ocCodeudorGender.ReadOnly = false;
                ocCodeudorCivilState.Required = 'Y';
                ocCodeudorCivilState.ReadOnly = false;

                //ABaldovino RQ 7447 19-05-2015
                if (isBtDateEditable)
                {
                    tbBirthDateCoDebtor.ReadOnly = false;
                    tbBirthDateCoDebtor.Required = 'Y';
                }

                ocCodeudorDegreeSchool.Required = 'Y';
                ocCodeudorDegreeSchool.ReadOnly = false;
                tbTelephoneCoDebtor.Required = 'Y';
                tbTelephoneCoDebtor.ReadOnly = false;

                ocCodeudorHouseType.Required = 'Y';
                ocCodeudorHouseType.ReadOnly = false;
                tbAntHouseCoDebtor.Required = 'Y';
                tbAntHouseCoDebtor.ReadOnly = false;
                tbNumberPersCoDebtor.Required = 'Y';
                tbNumberPersCoDebtor.ReadOnly = false;

                ocOccupationCoDeb.Required = 'Y';
                ocOccupationCoDeb.ReadOnly = false;
                tbNameEnterpCoDebtor.ReadOnly = false;
                ocContractTypeCoDeb.ReadOnly = false;
                tbTelOneEntrCoDebtor.ReadOnly = false;
                tbTelTwoEntrCoDebtor.ReadOnly = false;
                tbTelCelEntrCoDebtor.ReadOnly = false;
                tbActCoDebtor.ReadOnly = false;
                tbAntLabCoDebtor.ReadOnly = false;
                tbIngMensCoDebtor.Required = 'Y';
                tbIngMensCoDebtor.ReadOnly = false;
                tbGastMensCoDebtor.Required = 'Y';
                tbGastMensCoDebtor.ReadOnly = false;
                tbRefFamCoDebtor.Required = 'Y';
                tbRefFamCoDebtor.ReadOnly = false;
                tbTelFamCoDebtor.ReadOnly = false;
                tbCelFamCoDebtor.ReadOnly = false;
                tbRefPersCoDebtor.ReadOnly = false;
                tbTelPersCoDebtor.ReadOnly = false;
                tbCelPersCoDebtor.ReadOnly = false;
                tbRefComCoDebtor.ReadOnly = false;
                tbTelComCoDebtor.ReadOnly = false;
                tbCelComCoDebtor.ReadOnly = false;

                obSaveCodeudor.Enabled = true;
                obEditCodeudor.Text = "Cancelar";
                isEditCoDebtEnabled = false;
            }
            else {
                this.Close();
            }

            /*Inicio SAO.317297 KCienfuegos*/
            if (!isEditCoDebtEnabled)
            {
                if (OpenConvert.ToString(ocOccupationCoDeb.Value).Equals(indepentOccupId))
                {
                    tbNameEnterpCoDebtor.Required = 'N';
                    tbNameEnterpCoDebtor.ReadOnly = true;
                    tbNameEnterpCoDebtor.TextBoxValue = " ";

                    ocContractTypeCoDeb.Required = 'N';
                    ocContractTypeCoDeb.Text = "";
                    ocContractTypeCoDeb.Value = null;
                    ocContractTypeCoDeb.ReadOnly = true;

                    tbActCoDebtor.Required = 'Y';
                    tbActCoDebtor.ReadOnly = false;

                    tbAntLabCoDebtor.ReadOnly = true;
                    tbAntLabCoDebtor.TextBoxValue = "";
                    tbAntLabCoDebtor.Required = 'N';
                }
                else if (OpenConvert.ToString(ocOccupationCoDeb.Value).Equals(employeeOccupId))
                {
                    tbNameEnterpCoDebtor.Required = 'Y';
                    tbNameEnterpCoDebtor.ReadOnly = false;

                    ocContractTypeCoDeb.Required = 'Y';
                    ocContractTypeCoDeb.ReadOnly = false;

                    tbActCoDebtor.Required = 'N';
                    tbActCoDebtor.ReadOnly = true;
                    tbActCoDebtor.TextBoxValue = " ";

                    tbAntLabCoDebtor.ReadOnly = false;
                    tbAntLabCoDebtor.Required = 'Y';
                }
                else
                {
                    tbNameEnterpCoDebtor.Required = 'N';
                    tbNameEnterpCoDebtor.ReadOnly = true;
                    tbNameEnterpCoDebtor.TextBoxValue = " ";

                    ocContractTypeCoDeb.Required = 'N';
                    ocContractTypeCoDeb.Value = null;
                    ocContractTypeCoDeb.ReadOnly = true;

                    tbActCoDebtor.Required = 'N';
                    tbActCoDebtor.ReadOnly = true;
                    tbActCoDebtor.TextBoxValue = " ";

                    tbAntLabCoDebtor.ReadOnly = true;
                    tbAntLabCoDebtor.TextBoxValue = "";
                    tbAntLabCoDebtor.Required = 'N';
                }
            }
            /*Fin SAO.317297*/
        }

        private void obSaveCodeudor_Click(object sender, EventArgs e)
        {
            Boolean comer = true;

            if (String.IsNullOrEmpty(tbTelephoneCoDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el telefono del codeudor");
            }
            else if (String.IsNullOrEmpty(tbAntHouseCoDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado la antiguedad de la vivienda del codeudor");
            }

            else if (String.IsNullOrEmpty(tbNumberPersCoDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el numero de personas a cargo del codeudor");
            }

            else if (String.IsNullOrEmpty(Convert.ToString(ocCodeudorDegreeSchool.Value)))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha selecccionado el nivel de estudios del codeudor");
            }

            else if (String.IsNullOrEmpty(Convert.ToString(ocCodeudorHouseType.Value)))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el tipo de vivienda del codeudor");
            }

            else if (String.IsNullOrEmpty(tbAntHouseCoDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el estado civil del codeudor");
            }

            else if (String.IsNullOrEmpty(Convert.ToString(ocOccupationCoDeb.Value)))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado la ocupacion del codeudor");
            }

            else if ((Convert.ToString(ocOccupationCoDeb.Value).Equals(employeeOccupId)) && String.IsNullOrEmpty(tbNameEnterpCoDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre de la empresa donde trabaja");
            }

            else if (Convert.ToString(ocOccupationCoDeb.Value).Equals(employeeOccupId) && ocContractTypeCoDeb.Value == null)
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha seleccionado el tipo de contrato");
            }
            else if (Convert.ToString(ocOccupationCoDeb.Value).Equals(indepentOccupId) && String.IsNullOrEmpty(tbActCoDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado una actividad");
            }
            else if (Convert.ToString(ocOccupationCoDeb.Value).Equals(employeeOccupId) && !(OpenConvert.ToInt64Nullable(tbAntLabCoDebtor.TextBoxValue) > 0))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no digitado la antiguedad laboral");
            }      
            
            else if (String.IsNullOrEmpty(tbIngMensCoDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado los ingresos mensuales del codeudor");
            }
            else if (String.IsNullOrEmpty(tbGastMensCoDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado los gastos mensuales del codeudor");
            }
            else if (string.IsNullOrEmpty(tbRefFamCoDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre de la referencia familiar");
            }
            else if (string.IsNullOrEmpty(tbTelFamCoDebtor.TextBoxValue) && string.IsNullOrEmpty(tbCelFamCoDebtor.TextBoxValue))
            {
                comer = false;
                general.mensajeERROR("Faltan datos requeridos, se debe digitar un tel�fono fijo o un tel�fono celular para la referencia familiar");
            }

            if (!string.IsNullOrEmpty(tbRefPersCoDebtor.TextBoxValue) ||
                !string.IsNullOrEmpty(oadAddrPersCoDebtor.TextBoxValue) ||
                !string.IsNullOrEmpty(tbTelPersCoDebtor.TextBoxValue) ||
                !string.IsNullOrEmpty(tbCelPersCoDebtor.TextBoxValue))
            {
                if (string.IsNullOrEmpty(tbRefPersCoDebtor.TextBoxValue))
                {
                    comer = false;
                    general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre de la referencia personal");
                }
                else if (string.IsNullOrEmpty(tbTelPersCoDebtor.TextBoxValue) && string.IsNullOrEmpty(tbCelPersCoDebtor.TextBoxValue))
                {
                    comer = false;
                    general.mensajeERROR("Faltan datos requeridos, se debe digitar un tel�fono o un tel�fono celular para la referencia personal");
                }
            }

            if (!string.IsNullOrEmpty(tbRefComCoDebtor.TextBoxValue) ||
                !string.IsNullOrEmpty(oadAddrComCoDebtor.TextBoxValue) ||
                !string.IsNullOrEmpty(tbTelComCoDebtor.TextBoxValue) ||
                !string.IsNullOrEmpty(tbCelComCoDebtor.TextBoxValue))
            {
                if (string.IsNullOrEmpty(tbRefComCoDebtor.TextBoxValue))
                {
                    comer = false;
                    general.mensajeERROR("Faltan datos requeridos, no ha digitado el nombre de la referencia comercial");
                }
                else if (string.IsNullOrEmpty(tbTelComCoDebtor.TextBoxValue) && string.IsNullOrEmpty(tbCelComCoDebtor.TextBoxValue))
                {
                    comer = false;
                    general.mensajeERROR("Faltan datos requeridos, se debe digitar un tel�fono o un tel�fono celular para la referencia comercial");
                }
            }
            /*Fin SAO.317297*/

            try {

                setPromissoryCodeudor();
               
                if (comer)
                {
                    BLLDCIF.EditPromissory(Convert.ToInt64(promissorySearch), _promissoryCodeudor);
                    general.mensajeOk("Informacion actualizada con exito!");

                    tbDateExpIdCoDebtor.ReadOnly = true;
                    tbDateExpIdCoDebtor.Required = 'N';
                    ocCodeudorGender.ReadOnly = true;
                    ocCodeudorGender.Required = 'N';
                    ocCodeudorCivilState.ReadOnly = true;
                    ocCodeudorCivilState.Required = 'N';
                    tbBirthDateCoDebtor.ReadOnly = true;
                    tbBirthDateCoDebtor.Required = 'N';
                    ocCodeudorDegreeSchool.ReadOnly = true;
                    ocCodeudorDegreeSchool.Required = 'N';
                    tbTelephoneCoDebtor.ReadOnly = true;
                    tbTelephoneCoDebtor.Required = 'N';

                    ocCodeudorHouseType.ReadOnly = true;
                    tbAntHouseCoDebtor.Required = 'N';
                    tbAntHouseCoDebtor.ReadOnly = true;
                    tbNumberPersCoDebtor.Required = 'N';
                    tbNumberPersCoDebtor.ReadOnly = true;

                    ocOccupationCoDeb.Required = 'N';
                    ocOccupationCoDeb.ReadOnly = true;
                    tbNameEnterpCoDebtor.ReadOnly = true;
                    ocContractTypeCoDeb.ReadOnly = true;
                    tbTelOneEntrCoDebtor.ReadOnly = true;
                    tbTelTwoEntrCoDebtor.ReadOnly = true;
                    tbTelCelEntrCoDebtor.ReadOnly = true;
                    tbActCoDebtor.ReadOnly = true;
                    tbAntLabCoDebtor.ReadOnly = true;
                    tbIngMensCoDebtor.Required = 'N';
                    tbIngMensCoDebtor.ReadOnly = true;
                    tbGastMensCoDebtor.Required = 'N';
                    tbGastMensCoDebtor.ReadOnly = true;
                    tbRefFamCoDebtor.Required = 'N';
                    tbRefFamCoDebtor.ReadOnly = true;
                    tbTelFamCoDebtor.ReadOnly = true;
                    tbCelFamCoDebtor.ReadOnly = true;
                    tbRefPersCoDebtor.ReadOnly = true;
                    tbTelPersCoDebtor.ReadOnly = true;
                    tbCelPersCoDebtor.ReadOnly = true;
                    tbRefComCoDebtor.ReadOnly = true;
                    tbTelComCoDebtor.ReadOnly = true;
                    tbCelComCoDebtor.ReadOnly = true;

                    obSaveCodeudor.Enabled = false;
                    obEditCodeudor.Text = "Editar";
                    isEditCoDebtEnabled = true;
                }
            }
            catch (Exception ex)
            {
                general.doRollback();
                general.mensajeERROR(ex.Message.ToString());
            }
            
            
        }

        private void ocOccupationDeb_ValueChanged(object sender, EventArgs e)
        {
            if (OpenConvert.ToString(ocOccupationDeb.Value).Equals(indepentOccupId) && !isEditDebtEnabled)
            {
                tbNameEnterpDebtor.Required = 'N';
                tbNameEnterpDebtor.ReadOnly = true;
                tbNameEnterpDebtor.TextBoxValue = " ";

                ocContractTypeDeb.Required = 'N';
                ocContractTypeDeb.Text = "";
                ocContractTypeDeb.Value = null;
                ocContractTypeDeb.ReadOnly = true;

                tbActDebtor.Required = 'Y';
                tbActDebtor.ReadOnly = false;

                tbAntLabDebtor.ReadOnly = true;
                tbAntLabDebtor.TextBoxValue = "";
                tbAntLabDebtor.Required = 'N';
            }
            else if (OpenConvert.ToString(ocOccupationDeb.Value).Equals(employeeOccupId) && !isEditDebtEnabled)
            {
                ocContractTypeDeb.Required = 'Y';
                ocContractTypeDeb.ReadOnly = false;

                tbNameEnterpDebtor.Required = 'Y';
                tbNameEnterpDebtor.ReadOnly = false;

                tbActDebtor.Required = 'N';
                tbActDebtor.ReadOnly = true;
                tbActDebtor.TextBoxValue = " ";

                tbAntLabDebtor.ReadOnly = false;
                tbAntLabDebtor.Required = 'Y';
            }
            else
            {
                if (!isEditDebtEnabled)
                {
                    tbActDebtor.Required = 'N';
                    tbActDebtor.ReadOnly = true;
                    tbActDebtor.TextBoxValue = " ";

                    tbNameEnterpDebtor.Required = 'N';
                    tbNameEnterpDebtor.ReadOnly = true;
                    tbNameEnterpDebtor.TextBoxValue = " ";

                    ocContractTypeDeb.Required = 'N';
                    ocContractTypeDeb.Text = "";
                    ocContractTypeDeb.Value = null;
                    ocContractTypeDeb.ReadOnly = true;

                    tbAntLabDebtor.ReadOnly = true;
                    tbAntLabDebtor.TextBoxValue = "";
                    tbAntLabDebtor.Required = 'N';
                }
            }
        }

        private void tbDateExpIdDebtor_Validating(object sender, CancelEventArgs e)
        {
            //
            if (tbDateExpIdDebtor == null || tbDateExpIdDebtor.TextBoxObjectValue == null)
                general.mensajeERROR("Se debe definir una fecha valida");
            else
            {
                //
                if ((DateTime)tbDateExpIdDebtor.TextBoxObjectValue > DateTime.Today)
                {
                    tbDateExpIdDebtor.TextBoxObjectValue = DateTime.Today;
                    general.mensajeERROR("La fecha no puede ser mayor a la fecha actual");
                }
            }
        }

        private void tbDateExpIdCoDebtor_Validating(object sender, CancelEventArgs e)
        {
            //
            if (tbDateExpIdCoDebtor == null || tbDateExpIdCoDebtor.TextBoxObjectValue == null)
                general.mensajeERROR("Se debe definir una fecha valida");
            else
            {
                //
                if ((DateTime)tbDateExpIdCoDebtor.TextBoxObjectValue > DateTime.Today)
                {
                    tbDateExpIdCoDebtor.TextBoxObjectValue = DateTime.Today;
                    general.mensajeERROR("La fecha no puede ser mayor a la fecha actual");
                }
            }

        }

        private void tbBirthDateDebtor_Validating(object sender, CancelEventArgs e)
        {
            //
            if (tbBirthDateDebtor == null || tbBirthDateDebtor.TextBoxObjectValue == null)
                general.mensajeERROR("Se debe definir una fecha valida");
            else
            {
                //
                int years = DateTime.Today.Year - ((DateTime)tbBirthDateDebtor.TextBoxObjectValue).Year;
                if (years < 18)
                {
                    tbBirthDateDebtor.TextBoxObjectValue = null;
                    general.mensajeERROR("El deudor debe tener mas de 18 a�os");
                }
            }
        }

        private void tbBirthDateCoDebtor_Validating(object sender, CancelEventArgs e)
        {
            //
            if (tbBirthDateCoDebtor == null || tbBirthDateCoDebtor.TextBoxObjectValue == null)
                general.mensajeERROR("Se debe definir una fecha valida");
            else
            {
                //
                int years = DateTime.Today.Year - ((DateTime)tbBirthDateCoDebtor.TextBoxObjectValue).Year;
                if (years < 18)
                {
                    tbBirthDateCoDebtor.TextBoxObjectValue = null;
                    general.mensajeERROR("El codeudor debe tener mas de 18 a�os");
                }
            }
        }

        private void tbTelephoneDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            //
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbTelephoneDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono inv�lido");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelephoneCoDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono inv�lido");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelephoneCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            //
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbAntHouseCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbAntHouseDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbNumberPersDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbNumberPersCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void ocOccupationCoDeb_ValueChanged(object sender, EventArgs e)
        {
            if (OpenConvert.ToString(ocOccupationCoDeb.Value).Equals(indepentOccupId) && !isEditCoDebtEnabled)
            {
                tbNameEnterpCoDebtor.Required = 'N';
                tbNameEnterpCoDebtor.ReadOnly = true;
                tbNameEnterpCoDebtor.TextBoxValue = " ";

                ocContractTypeCoDeb.Required = 'N';
                ocContractTypeCoDeb.Text = "";
                ocContractTypeCoDeb.Value = null;
                ocContractTypeCoDeb.ReadOnly = true;

                tbActCoDebtor.Required = 'Y';
                tbActCoDebtor.ReadOnly = false;

                tbAntLabCoDebtor.ReadOnly = true;
                tbAntLabCoDebtor.TextBoxValue = "";
                tbAntLabCoDebtor.Required = 'N';
            }
            else if (OpenConvert.ToString(ocOccupationCoDeb.Value).Equals(employeeOccupId) && !isEditCoDebtEnabled)
            {
                ocContractTypeCoDeb.Required = 'Y';
                ocContractTypeCoDeb.ReadOnly = false;

                tbNameEnterpCoDebtor.Required = 'Y';
                tbNameEnterpCoDebtor.ReadOnly = false;

                tbActCoDebtor.Required = 'N';
                tbActCoDebtor.ReadOnly = true;
                tbActCoDebtor.TextBoxValue = " ";

                tbAntLabCoDebtor.ReadOnly = false;
                tbAntLabCoDebtor.Required = 'Y';
            }
            else
            {
                if (!isEditCoDebtEnabled)
                {
                    tbActCoDebtor.Required = 'N';
                    tbActCoDebtor.ReadOnly = true;
                    tbActCoDebtor.TextBoxValue = " ";

                    tbNameEnterpCoDebtor.Required = 'N';
                    tbNameEnterpCoDebtor.ReadOnly = true;
                    tbNameEnterpCoDebtor.TextBoxValue = " ";

                    ocContractTypeCoDeb.Required = 'N';
                    ocContractTypeCoDeb.Text = "";
                    ocContractTypeCoDeb.Value = null;
                    ocContractTypeCoDeb.ReadOnly = true;

                    tbAntLabCoDebtor.ReadOnly = true;
                    tbAntLabCoDebtor.TextBoxValue = "";
                    tbAntLabCoDebtor.Required = 'N';
                }
            }
        }

        private void tbTelOneEntrDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbTelTwoEntrDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbTelFamDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbTelPersDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbTelComDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbCelFamDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbCelPersDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbCelComDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbIngMensDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbGastMensDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbTelCelEntrDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbIngMensCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbGastMensCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbTelCelEntrCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbTelOneEntrCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbTelTwoEntrCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbAntLabCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbTelCelEntrDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000000 || valor > 9999999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono celular debe tener 10 d�gitos");
                    e.Cancel = true;
                }
            }
        }

        private void tbCelFamDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000000 || valor > 9999999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono celular debe tener 10 d�gitos");
                    e.Cancel = true;
                }
            }
        }

        private void tbCelPersDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000000 || valor > 9999999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono celular debe tener 10 d�gitos");
                    e.Cancel = true;
                }
            }
        }

        private void tbCelComDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000000 || valor > 9999999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono celular debe tener 10 d�gitos");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelCelEntrCoDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000000 || valor > 9999999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono celular debe tener 10 d�gitos");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelTwoEntrDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono inv�lido");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelOneEntrDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono inv�lido");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelFamDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono inv�lido");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelPersDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono inv�lido");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelComDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono inv�lido");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelFamCoDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono inv�lido");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelPersCoDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono inv�lido");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelComCoDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono inv�lido");
                    e.Cancel = true;
                }
            }
        }

        private void tbCelFamCoDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000000 || valor > 9999999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono celular debe tener 10 d�gitos");
                    e.Cancel = true;
                }
            }
        }

        private void tbCelPersCoDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000000 || valor > 9999999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono celular debe tener 10 d�gitos");
                    e.Cancel = true;
                }
            }
        }

        private void tbCelComCoDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000000 || valor > 9999999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono celular debe tener 10 d�gitos");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelOneEntrCoDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono inv�lido");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelTwoEntrCoDebtor_Validating(object sender, CancelEventArgs e)
        {
            if (((OpenSimpleTextBox)sender).Required == 'Y' || ((OpenSimpleTextBox)sender).TextBoxValue != null)
            {
                Int64 valor = Convert.ToInt64(((OpenSimpleTextBox)sender).TextBoxValue);
                if (valor < 1000000 || valor > 9999999)
                {
                    ((OpenSimpleTextBox)sender).error.SetError(((OpenSimpleTextBox)sender), "N�mero de tel�fono inv�lido");
                    e.Cancel = true;
                }
            }
        }

        private void tbTelFamCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbTelPersCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbTelComCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbCelFamCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbCelPersCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }

        private void tbAntLabDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
            {
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
            }
        }

        private void tbCelComCoDebtor_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue == 189) || (e.KeyValue == 109))
                ((OpenSimpleTextBox)sender).TextBoxValue = ((OpenSimpleTextBox)sender).TextBoxValue.Replace("-", "");
        }      
                   
    }
}