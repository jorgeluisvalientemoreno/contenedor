#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : FIHOS
 * Descripcion   : Forma de ayuda de venta
 * Autor         : 
 * Fecha         : 
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 09-Sep-2013  216609  lfernandez     1 - <FIHOS> Se adiciona asignación a genericArticles de el listado de
 *                                         artículos genéricos
 *                                     2 - <GetFIHOSData> Se reemplaza condición de si el artículo tiene
 *                                         valor mayor a cero por si es un artículo genérico. Se asigna al
 *                                         artículo el valor y si se permite modificar el valor
 * 07-Sep-2013  216582  lfernandez     1 - <contextMenuExportToExcel_ItemClicked> Se adiciona evento para
 *                                         poder exportar el flujo de cuotas del artículo a excel.
 *                                     2 - <Forma> Se adiciona click derecho al flujo de cuotas para poder
 *                                         exportar a excel
 * 05-Sep-2013  212246  lfernandez     1 - <ConvertToNominalRate> Se adiciona método para convertir el
 *                                         porcentaje a nominal
 *                                     2 - <Calcular> Se corrige cálculo de las cuotas, el seguro y los
 *                                         totales
 *                                     3 - <dgArticleSimulator_Click> Se elimina llamado a generar
 *                                     4 - <dgArticleSimulator_AfterEnterEditMode> Se elimina llamado a generar
 *                                     5 - <GetFIHOSData> Se adiciona método para obtener la lista de
 *                                         artículos seleccionados
 *                                     6 - <btnsale_Click> Se pasa el listado de artículos a FIFAP
 *                                     7 - <bindingNavigatorPosition1_TextChanged> Se elimina código interno
 *                                     8 - <dgArticleSimulator_AfterCellUpdate> Se adiciona evento
 *                                     9 - <dgArticleSimulator_Error> Se adiciona evento
 *                                     10 - <dgArticleSimulator_AfterRowActivate> Se adiciona evento
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
using SINCECOMP.FNB.BL;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;
using SINCECOMP.FNB.Entities;
using System.Data.Common;
using OpenSystems.Common.ComponentModel;
using Infragistics.Win.UltraWinEditors;
using OpenSystems.Common.ExceptionHandler;
using Infragistics.Win.UltraWinGrid.ExcelExport;
using OpenSystems.Common.Util;

namespace SINCECOMP.FNB.UI
{
    public partial class FIHOS : OpenForm
    {
        BindingSource customerbinding = new BindingSource();
        //
        private static DataFIFAP _dataFIFAP = new DataFIFAP();
        private static BLFIFAP _blFIFAP = new BLFIFAP();
        private static BLFIHOS _blFIHOS = new BLFIHOS();
        private List<ArticleValue2> _articleLOV = new List<ArticleValue2>();
        private List<ExtraQuote> _ListExtraQuote = new List<ExtraQuote>();
        private Int64 ValorInicial;
        //
        String Cliente;
        //Boolean start;
        private const String ARTICLE_ID = "ArticleId";
        String b = "SupplierName";
        private const String ARTICLE_VALUE = "ValueArticle";
        private const String AMOUNT = "Amount";
        private const String SUBTOTAL = "SubTotal";
        private const String FEEDS_NUMBER = "FeedsNumber";
        String g = "FirstDatePay";
        String h = "InterestValue";
        String i = "TaxValue";
        private const String CAP_MONTH_PAY_APROX_VAL = "VAAMC"; //Valor Aproximado Abono Mensual Capital
        private const String INT_MONTH_APROX_VAL = "VAIM";      //Valor Aproximado Interes Mensual
        private const String SECU_MONTH_APROX_VAL = "VAMS";     //Valor Aproximado Mensual Seguro
        private const String MONTH_QUOTA = "VACM";              //Valor Aproximado Cuota Mensual
        private const String CAP_TOTAL_APROX_VAL = "VATC";      //Valor Aproximado Total A Capital
        private const String INT_TOTAL_APROX_VAL = "VATI";      //Valor Aproximado Total Interes
        private const String SECU_TOTAL_APROX_VAL = "VATS";     //Valor Aproximado Total Seguro
        private const String PAY_TOTAL_APROX_VAL = "VATAP";     //Valor Aproximado Total A Pagar
        String r = "FinanPercent";
        String s = "FeedsNumberMin";
        String t = "FeedsNumberMax";
        //String u = "ArticleIdDescription";
        //
        private const String EXTRA_QUOTA = "ValueExtraQuote";
        private const String CAPITAL_BALANCE = "SaldoCapital";
        private const String CAPITAL_VALUE = "CapitalValue";
        private const String INTEREST_VALUE = "InterestValue";
        private const String SURE_VALUE = "SureValue";
        private const String TOTAL_VALUE = "TotalValue";
        private const String QUOTA_NUMBER = "NumberQuotePay";
        //
        BLGENERAL general = new BLGENERAL();
        Decimal Seguro;
        private DataTable tabla;
        private String genericArticles;
        Boolean cancelEvent = false;
        UltraGridRow activeRowToDelete;
        String sbCuotaFija; // Por defecto la variable esta en V, quiere decir que tomara tasa variable
        bool FLAG_VISUALIZAR_PLN_FIN = false;
        String sbYes = "Y";
        String sbNo = "N";
        UltraDropDown ocArticle;

        public FIHOS(Int64 valueInitial)
        {
            InitializeComponent();
            ValorInicial = valueInitial;//.ToString()
            Seguro = Convert .ToDecimal(general.devolution("select numeric_value valor from ld_parameter where lower(parameter_id)='insurance_rate'", "valor"));
            cb_TypeId.DataSource = general.getValueList("select ident_type_id Codigo, description Descripcion from ge_identifica_type");
            cb_TypeId.DisplayMember = "Descripcion";
            cb_TypeId.ValueMember = "Codigo";
            Int64 subscriptionId = Convert.ToInt64(valueInitial);
            _dataFIFAP = _blFIHOS.getSubscriptionData(subscriptionId);
            DataTable query;
            query = general.getValueList("SELECT b.ident_type_id TIPO, b.subscriber_name || ' ' || b.subs_last_name NOMBRE, b.identification clientId FROM suscripc a, ge_subscriber b WHERE a.suscclie = b.subscriber_id and a.susccodi=" + valueInitial.ToString());
            tb_ClientId.Text = query.Rows[0]["clientId"].ToString();
            Cliente = tb_ClientId.Text;
            tbName.Text = query.Rows[0]["NOMBRE"].ToString();
            Int64 onususccodia, onuasignedquotea, onuusedquotea, onuavaliblequotea, typeId;
            onususccodia = subscriptionId;
            cb_TypeId.Value = Convert.ToInt64(query.Rows[0]["TIPO"].ToString());
            typeId = Convert.ToInt64(query.Rows[0]["TIPO"].ToString());

            //KCienfuegos.NC5002 Se coloca en comentario ya que no se debe buscar por id y tipo de id sino por contrato
            //BLFIHOS.CreditQuotaData(typeId, Cliente, out onususccodia, out onuasignedquotea, out onuusedquotea, out onuavaliblequotea);
            BLFIHOS.SubscriptionQuotaData(subscriptionId, out onuasignedquotea, out onuusedquotea, out onuavaliblequotea);
            //FIN NC5002

            // 25-09-2014 KCienfuegos.RNP198 Se obtiene la segmentación comercial del contrato.
            String osbCommercSegm;
            Int64 onuSegmId;
            BLFIHOS.GetCommercialSegment(valueInitial, out osbCommercSegm, out onuSegmId);
            tbCommercSegm.Text = osbCommercSegm;
            // FIN RNP198

            //******17-02-2015 Llozada[RQ 1841] INICIO******//
            //LISTA DE PLANES DE FINANCIACIÓN CUOTA FIJA
            DataTable sqlPlanFinanciacion = general.getValueList("SELECT column_value id, pktblplandife.fsbgetdescription(column_value) description" +
                " from table (ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('FNB_PLANFINAN_CF') ,','))");

            PlanFinanciacion.DataSource = sqlPlanFinanciacion;
            PlanFinanciacion.DisplayMember = "description";
            PlanFinanciacion.ValueMember = "ID";
            //******17-02-2015 Llozada[RQ 1841] FIN******//

            tbQuoteAssigned.Text = onuasignedquotea.ToString();
            tbQuoteUsed.Text = onuusedquotea.ToString();
            tbQuoteDisponible.Text = onuavaliblequotea.ToString();
            _ListExtraQuote = _blFIFAP.getExtraQuotes(onususccodia); 
            customerbinding.DataSource = _ListExtraQuote;
            dgExtraQuotaAssign.DataSource = customerbinding;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[SUBTOTAL].CellActivation = Activation.NoEdit;
            ocArticle = new UltraDropDown();

            FLAG_VISUALIZAR_PLN_FIN = sbYes.Equals((String)OpenConvert.ToString(general.getParam("FLAG_VISUALIZAR_PLN_FIN", "String")));

            // Pregunta si el flag no esta en Y 
            if (!FLAG_VISUALIZAR_PLN_FIN)
            {
                cuotaFijaCheck.Visible = false;
            }

            /* 
            * [13/10/2015] heiberb [SAO.334390 Cuota Fija]: 
            */
            sbCuotaFija = "V";
            _blFIHOS.getAvalibleArticles(
                Convert.ToInt64(_dataFIFAP.SupplierID),
                Convert.ToInt64(_dataFIFAP.DefaultchanelSaleId),
                Convert.ToInt64(_dataFIFAP.GeoLocation),
                Convert.ToInt64(_dataFIFAP.CategoryId),
                Convert.ToInt64(_dataFIFAP.SubcategoryId),
                ref _articleLOV,
                ref tabla,
                sbCuotaFija);            

            ocArticle.DataSource = _articleLOV;
            ocArticle.ValueMember = "ArticleId";
            ocArticle.DisplayMember = "ArticleDescription";
            ocArticle.AutoSize = false;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[ARTICLE_ID].ValueList = ocArticle;
            //general.mensajeOk("dgArticleSimulator.DisplayLayout.Bands[0].Columns[ARTICLE_ID].ValueList: " + dgArticleSimulator.DisplayLayout.Bands[0].Columns[ARTICLE_ID].ValueList.ItemCount + ", _articleLOV: " + _articleLOV.Count);
            if (ocArticle.Rows.Count == 0)
                general.mensajeERROR("No hay artículos disponibles para Simular");
            ////valor
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[ARTICLE_VALUE].MaxLength = 18;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[ARTICLE_VALUE].MaxValue = 999999999999999.99;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[ARTICLE_VALUE].Format = "#,##0.00";
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[ARTICLE_VALUE].CellAppearance.TextHAlign = HAlign.Right;
            //interes
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[r].MaskInput = "nn.nn"; //EVESAN
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[r].Format = "#,##0.00";
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[r].CellAppearance.TextHAlign = HAlign.Right;
            ////cantidad
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[AMOUNT].MaxLength = 3;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[AMOUNT].Format = "#,##0.00";
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[AMOUNT].CellAppearance.TextHAlign = HAlign.Right;
            ////total
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[SUBTOTAL].MaskInput = "nnnnnnnnnnnnn.nn"; //EVESAN
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[SUBTOTAL].Format = "#,##0.00";
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[SUBTOTAL].CellAppearance.TextHAlign = HAlign.Right;
            //
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[FEEDS_NUMBER].CellAppearance.TextHAlign = HAlign.Right;
            //sumatorias
            dgArticleSimulator.DisplayLayout.Bands[0].SummaryFooterCaption = "Totales";
            dgArticleSimulator.DisplayLayout.Bands[0].Summaries.Clear();
            String[] fieldsum = new string[] { ARTICLE_VALUE,AMOUNT,SUBTOTAL,CAP_MONTH_PAY_APROX_VAL,INT_MONTH_APROX_VAL,SECU_MONTH_APROX_VAL,MONTH_QUOTA,CAP_TOTAL_APROX_VAL,INT_TOTAL_APROX_VAL,SECU_TOTAL_APROX_VAL,PAY_TOTAL_APROX_VAL };
            int tl = 0;
            foreach (String column in fieldsum)
            {
                dgArticleSimulator.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgArticleSimulator.DisplayLayout.Bands[0].Columns[column]);
                dgArticleSimulator.DisplayLayout.Bands[0].Summaries[tl].Appearance.ForeColor = System.Drawing.Color.Black;
                dgArticleSimulator.DisplayLayout.Bands[0].Summaries[tl].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
                dgArticleSimulator.DisplayLayout.Bands[0].Summaries[tl].Appearance.TextHAlign = HAlign.Right;
                dgArticleSimulator.DisplayLayout.Bands[0].Summaries[tl].DisplayFormat = "{0:N}";
                tl++;
            }
            String[] fieldssimulator = new string[] { ARTICLE_ID, b, AMOUNT };
            general.setColumnRequiered(dgArticleSimulator, fieldssimulator);
            //
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[CAP_MONTH_PAY_APROX_VAL].Format = "#,##0.00";
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[CAP_MONTH_PAY_APROX_VAL].CellAppearance.TextHAlign = HAlign.Right;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[INT_MONTH_APROX_VAL].Format = "#,##0.00";
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[INT_MONTH_APROX_VAL].CellAppearance.TextHAlign = HAlign.Right;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[SECU_MONTH_APROX_VAL].Format = "#,##0.00";
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[SECU_MONTH_APROX_VAL].CellAppearance.TextHAlign = HAlign.Right;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[MONTH_QUOTA].Format = "#,##0.00";
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[MONTH_QUOTA].CellAppearance.TextHAlign = HAlign.Right;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[CAP_TOTAL_APROX_VAL].Format = "#,##0.00";
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[CAP_TOTAL_APROX_VAL].CellAppearance.TextHAlign = HAlign.Right;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[INT_TOTAL_APROX_VAL].Format = "#,##0.00";
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[INT_TOTAL_APROX_VAL].CellAppearance.TextHAlign = HAlign.Right;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[SECU_TOTAL_APROX_VAL].Format = "#,##0.00";
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[SECU_TOTAL_APROX_VAL].CellAppearance.TextHAlign = HAlign.Right;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[PAY_TOTAL_APROX_VAL].Format = "#,##0.00";
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[PAY_TOTAL_APROX_VAL].CellAppearance.TextHAlign = HAlign.Right;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[t].Hidden = true;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[s].Hidden = true;
            //
            //ArticleDescription
            dgArticleSimulator.DisplayLayout.Bands[0].Columns["ArticleDescription"].Hidden = true;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns["ArticleIdDescription"].Hidden = true;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[i].Hidden = true;
            dgFlowShare.DisplayLayout.Bands[0].Columns[EXTRA_QUOTA].Hidden = true;
            dgFlowShare.DisplayLayout.Bands[0].Columns[CAPITAL_BALANCE].Hidden = true;
            //
            dgFlowShare.DisplayLayout.Bands[0].Columns[QUOTA_NUMBER].CellAppearance.TextHAlign = HAlign.Right;

            dgFlowShare.DisplayLayout.Bands[0].Columns[CAPITAL_VALUE].Format = "#,##0.00";
            dgFlowShare.DisplayLayout.Bands[0].Columns[CAPITAL_VALUE].CellAppearance.TextHAlign = HAlign.Right;

            dgFlowShare.DisplayLayout.Bands[0].Columns[INTEREST_VALUE].Format = "#,##0.00";
            dgFlowShare.DisplayLayout.Bands[0].Columns[INTEREST_VALUE].CellAppearance.TextHAlign = HAlign.Right;

            dgFlowShare.DisplayLayout.Bands[0].Columns[SURE_VALUE].Format = "#,##0.00";
            dgFlowShare.DisplayLayout.Bands[0].Columns[SURE_VALUE].CellAppearance.TextHAlign = HAlign.Right;

            dgFlowShare.DisplayLayout.Bands[0].Columns[TOTAL_VALUE].Format = "#,##0.00";
            dgFlowShare.DisplayLayout.Bands[0].Columns[TOTAL_VALUE].CellAppearance.TextHAlign = HAlign.Right;
            //bloquear
            String[] fieldReadOnly = new string[] { SUBTOTAL, g, i, CAP_MONTH_PAY_APROX_VAL, INT_MONTH_APROX_VAL, SECU_MONTH_APROX_VAL, MONTH_QUOTA, CAP_TOTAL_APROX_VAL, INT_TOTAL_APROX_VAL, SECU_TOTAL_APROX_VAL, PAY_TOTAL_APROX_VAL, r, b };
            general.setColumnReadOnly(dgArticleSimulator, fieldReadOnly);
            //
            fieldReadOnly = new string[] { EXTRA_QUOTA, CAPITAL_BALANCE, CAPITAL_VALUE, INTEREST_VALUE, SURE_VALUE, TOTAL_VALUE, QUOTA_NUMBER };
            general.setColumnReadOnly(dgFlowShare, fieldReadOnly);

            //  Obtiene la lista de ids de artículos genéricos
            genericArticles = _blFIFAP.getParam("COD_GENERIC_ITEMS");
            //  Le adiciona los separadores
            genericArticles = "," + genericArticles + ",";
        }

        private void bindingNavigatorAddNewItem1_Click(object sender, EventArgs e)
        {
            bnSimulator.BindingSource.AddNew();
            flowShareFIHOSBindingSource.Clear();
        }

        private void bindingNavigatorDeleteItem1_Click(object sender, EventArgs et)
        {
            if (dgArticleSimulator.ActiveRow != null)
            {
                dgArticleSimulator.ActiveRow.Delete(false);
            }
        }

        private void dgArticleSimulator_CellChange(object sender, CellEventArgs et)
        {
            String[] tmpFinanInfo;

            if (et.Cell.Column.Key == ARTICLE_ID)
            {
                dgArticleSimulator.ActiveRow.Cells[ARTICLE_VALUE].Activated = true;
                if (Convert.ToInt64(dgArticleSimulator.ActiveRow.Cells[ARTICLE_VALUE].Value) == 0)
                {
                    dgArticleSimulator.ActiveRow.Cells[ARTICLE_VALUE].Activation = Activation.AllowEdit;
                }
                else
                {
                    dgArticleSimulator.ActiveRow.Cells[ARTICLE_VALUE].Activation = Activation.NoEdit;
                }

                if (dgArticleSimulator.ActiveRow.Cells[ARTICLE_ID].Value.ToString() == "")
                {
                    dgArticleSimulator.ActiveRow.Cells[r].Value = 0;
                    dgArticleSimulator.ActiveRow.Cells[g].Value = DateTime.Now;
                }
                else
                {
                    DataRow[] row = tabla.Select("ARTICLE_ID=" + dgArticleSimulator.ActiveRow.Cells[ARTICLE_ID].Value);
                    dgArticleSimulator.ActiveRow.Cells[b].Value = Convert.ToString(row[0]["NOMBRE_PROVEEDOR"]);

                    dgArticleSimulator.ActiveRow.Cells[ARTICLE_VALUE].Value = Convert.ToString(row[0]["PRICE"]);
                    if (Convert.ToInt64(dgArticleSimulator.ActiveRow.Cells[ARTICLE_VALUE].Value) == 0)
                    {
                        dgArticleSimulator.ActiveRow.Cells[ARTICLE_VALUE].Activation = Activation.AllowEdit;
                    }
                    else
                    {
                        dgArticleSimulator.ActiveRow.Cells[ARTICLE_VALUE].Activation = Activation.NoEdit;
                    }                                      

                    /*18-02-2015 Llozada [ARA 1841]: Se valida si se ha seleccionado un plan de cuota fija en la simulación*/
                    //if (String.IsNullOrEmpty(Convert.ToString(PlanFinanciacion.Value)))
                    //{
                        //Si no se selecciona plan, se toma el plan configurado en GECPA
                        tmpFinanInfo = row[0][5].ToString().Split('|');
                        //general.mensajeOk("Plan TASA VARIABLE");
                    //}
                    /*else 
                    {
                        //De lo contrario se traen los datos del plan seleccionado en la simulación
                        String planCF = _blFIHOS.getPlanFinanCF(Convert.ToInt32(PlanFinanciacion.Value));
                        //general.mensajeOk("Plan Cuota FIJA: " + planCF);
                        tmpFinanInfo = planCF.ToString().Split('|');
                    }*/

                    dgArticleSimulator.ActiveRow.Cells[t].Value = Convert.ToInt64(tmpFinanInfo[2].ToString());
                    dgArticleSimulator.ActiveRow.Cells[s].Value = Convert.ToInt64(tmpFinanInfo[1].ToString());

                    dgArticleSimulator.ActiveRow.Cells[r].Value = Convert.ToDouble(tmpFinanInfo[3].ToString());
                    dgArticleSimulator.ActiveRow.Cells[g].Value = DateTime.Now.AddDays(Convert.ToDouble(tmpFinanInfo[4].ToString()));
                 
                }
            }
            if (et.Cell.Column.Key == AMOUNT || et.Cell.Column.Key == FEEDS_NUMBER && !cancelEvent)
            {
                if (dgArticleSimulator.ActiveRow.Cells[et.Cell.Column.Key].Text == "")
                    dgArticleSimulator.ActiveRow.Cells[et.Cell.Column.Key].Value = 0;
            }

            /******KCienfuegos.SAO316006 12-05-2015****/
            if (cancelEvent)
            {
                if (activeRowToDelete != null)
                {
                    cancelEvent = false;
                    activeRowToDelete.Delete(false);
                }
            }

            /**********FIN SAO316006********/
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

        void Calcular(Int64 NQuotes, Double capitalBalance, Double interestPercentage, int filagrid)
        {
            if (NQuotes > 0)
            {
                int fila = 0;
                Double capitalValue;
                Double interestValue;
                Double secureValue;
                Double monthQuota;
                Double interestTotal = 0;
                Double secureTotal = 0;
                Double balanceTotal = 0;

                flowShareFIHOSBindingSource.Clear();

                //  Asigna el valor mensual aproximado que se va a capital
                dgArticleSimulator.Rows[filagrid].Cells[CAP_MONTH_PAY_APROX_VAL].Value = capitalBalance / NQuotes;

                //  Asigna el total capital
                dgArticleSimulator.Rows[filagrid].Cells[CAP_TOTAL_APROX_VAL].Value = capitalBalance;

                //  Obtener la tasa a nominal
                interestPercentage = ConvertToNominalRate(Convert.ToDouble(interestPercentage));

                //  Calcula el valor de la cuota fija mensual
                monthQuota = -Microsoft.VisualBasic.Financial.Pmt(
                    interestPercentage,
                    NQuotes,
                    capitalBalance,
                    0,
                    Microsoft.VisualBasic.DueDate.EndOfPeriod);

                //  Crea las cuotas
                for (int i = 1; i <= NQuotes; i++)
                {
                    flowShareFIHOSBindingSource.AddNew();

                    dgFlowShare.Rows[fila].Cells[QUOTA_NUMBER].Value = i;

                    //  Valor del seguro
                    secureValue = capitalBalance * Convert.ToDouble(Seguro) / 100;
                    dgFlowShare.Rows[fila].Cells[SURE_VALUE].Value = secureValue;

                    //  Valor del interés
                    interestValue = capitalBalance * interestPercentage;
                    dgFlowShare.Rows[fila].Cells[INTEREST_VALUE].Value = interestValue;

                    //  Valor del capital
                    capitalValue = monthQuota - interestValue;
                    dgFlowShare.Rows[fila].Cells[CAPITAL_VALUE].Value = capitalValue;

                    //  Valor total de la cuota
                    dgFlowShare.Rows[fila].Cells[TOTAL_VALUE].Value = capitalValue + interestValue + secureValue;

                    //  Actualiza saldo capital
                    capitalBalance = capitalBalance - capitalValue;
                    dgFlowShare.Rows[fila].Cells[CAPITAL_BALANCE].Value = capitalBalance;

                    //  Acumula el total del interés
                    interestTotal = interestTotal + interestValue;

                    //  Acumula el total del seguro
                    secureTotal = secureTotal + secureValue;

                    balanceTotal = balanceTotal + capitalValue + interestValue + secureValue;
                    
                    fila++;
                }

                //  Asigna el interés aproximado mensual
                dgArticleSimulator.Rows[filagrid].Cells[INT_MONTH_APROX_VAL].Value = interestTotal / NQuotes;

                //  Asigna el seguro aproximado mensual
                dgArticleSimulator.Rows[filagrid].Cells[SECU_MONTH_APROX_VAL].Value = secureTotal / NQuotes;

                //  Asigna el valor mensual de la cuota
                dgArticleSimulator.Rows[filagrid].Cells[MONTH_QUOTA].Value = monthQuota;

                //  Asigna el interés total
                dgArticleSimulator.Rows[filagrid].Cells[INT_TOTAL_APROX_VAL].Value = interestTotal;

                //  Asigna el seguro total
                dgArticleSimulator.Rows[filagrid].Cells[SECU_TOTAL_APROX_VAL].Value = secureTotal;

                //  Asigna el total a pagar por la venta
                dgArticleSimulator.Rows[filagrid].Cells[PAY_TOTAL_APROX_VAL].Value = balanceTotal;
            }
            if (NQuotes ==0)
                flowShareFIHOSBindingSource.Clear();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        void generar()
        {
            try
            {
                Double subtotal;
                subtotal =
                    Convert.ToDouble(dgArticleSimulator.ActiveRow.Cells[ARTICLE_VALUE].Text) *
                    Convert.ToDouble(dgArticleSimulator.ActiveRow.Cells[AMOUNT].Text);

                Calcular(Convert.ToInt64(dgArticleSimulator.ActiveRow.Cells[FEEDS_NUMBER].Value),
                    subtotal,
                    Convert.ToDouble(dgArticleSimulator.ActiveRow.Cells[r].Value),
                    dgArticleSimulator.ActiveRow.Index);
            }
            catch { }   
        }

        private void dgArticleSimulator_Click(object sender, EventArgs et)
        {
        }

        private void dgArticleSimulator_AfterEnterEditMode(object sender, EventArgs et)
        {
        }

        /// <summary>
        /// Obtiene los artículos seleccionados en la forma
        /// </summary>
        /// <param name="articleList">Lista de artículos seleccionados</param>
        private void GetFIHOSData(ref List<ArticleValue> articleList)
        {
            DataRow row;
            Article article;
            String[] tmpFinanInfo;
            Double percent;
            Int32 days;
            DateTime dateBillGrace;

            foreach (UltraGridRow gridRow in dgArticleSimulator.Rows)
            {
                row = tabla.Select("ARTICLE_ID=" + gridRow.Cells[ARTICLE_ID].Value)[0];

                //  Si no es un artículo genérico
                if (!genericArticles.Contains("," + row[0].ToString() + ","))
                {
                    tmpFinanInfo = row[5].ToString().Split('|');

                    days = Int32.Parse(tmpFinanInfo[4]);

                    if (days > 0)
                    {
                        dateBillGrace = DateTime.Now.AddDays(days);
                    }
                    else
                    {
                        dateBillGrace = DateTime.Now;
                    }

                    if (tmpFinanInfo[3] == null)
                    {
                        percent = 0;
                    }
                    else
                    {
                        percent = Double.Parse(tmpFinanInfo[3].ToString());
                    }

                    article = new Article(
                        Convert.ToInt64(row[0]),
                        row[1].ToString(),
                        row[3].ToString(),
                        Convert.ToDouble(row[4]),
                        Convert.ToDouble(row[6]),
                        Convert.ToInt32(tmpFinanInfo[1]),
                        Convert.ToInt32(tmpFinanInfo[2]),
                        Convert.ToInt32(tmpFinanInfo[0]),
                        dateBillGrace,
                        percent,
                        Convert.ToInt64(row[7]),
                        Convert.ToInt64(row[8]),
                        Convert.ToInt64(row[9]),
                        Convert.ToInt64(row[10]));

                    article.Amount = Convert.ToInt32(gridRow.Cells[AMOUNT].Value);
                    article.FeedsNumber = Convert.ToInt32(gridRow.Cells[FEEDS_NUMBER].Value);
                    article.ValueArticle = Convert.ToDouble(gridRow.Cells[ARTICLE_VALUE].Value);
                    article.EditValue = Convert.ToDouble(row[4]) == 0;

                    articleList.Add(new ArticleValue(article.ArticleId, article.ArticleDescription, article));
                }
            }
        }

        private void btnsale_Click(object sender, EventArgs e)
        {
            /*25-02-2015 SPacheco [NC 4904]: Se coloca en comentario para llamar a servicio de validacion de factura*/
            //List<ArticleValue> articleList = new List<ArticleValue>();

            //DataFIFAP dataFIFAP = _blFIFAP.getSubscriptionData(ValorInicial);
            //FIFAP Forma = new FIFAP(ValorInicial, dataFIFAP);

            ////  Obtiene la información de los artículos en la grilla
            //GetFIHOSData(ref articleList);

            ////  Pasa la lista de artículos a la forma FIFAP
            //Forma.SetFIHOSArticles(articleList);

            ///*17-02-2015 Llozada [ARA 1841]: Se envia el plan de financiación seleccionado a FIFAP*/
            //Forma.SetFIHOSPlanFinan(Convert.ToInt32(PlanFinanciacion.Value));

            //Forma.ShowDialog();


            /*25-02-2015 Samuel Pacheco [NC 4904]: Se Adiciona codigo de validación de facturas vencida */
            Int64 SubscriptionId = 0;

            SINCECOMP.FNB.BL.BLFIFAP _blFIFAP = new SINCECOMP.FNB.BL.BLFIFAP();

            SINCECOMP.FNB.BL.BLGENERAL general = new SINCECOMP.FNB.BL.BLGENERAL();

            SubscriptionId = ValorInicial;

            if (_blFIFAP.GetLock(SubscriptionId))
            {
                //CONSULTA DE RESGITROS SEGUN EL NUMERO DE LA SUBSCRIPCION
                SINCECOMP.FNB.Entities.DataFIFAP _dataFIFAP = _blFIFAP.getSubscriptionData(SubscriptionId);

                int validateBill = _blFIFAP.numberBill(SubscriptionId);


                if (_dataFIFAP.isGranSuperficie())
                {
                    if (validateBill == -1 || validateBill != 0)
                    {
                        general.mensajeERROR("Posee facturas vencidas, no se realizara venta");
                    }
                    else
                    {
                        using (FIFAP frm = new FIFAP(SubscriptionId, _dataFIFAP))
                        {
                            frm.SetBillSlope(validateBill);
                            //frm.ShowDialog();
                            List<ArticleValue> articleList = new List<ArticleValue>();

                            //DataFIFAP dataFIFAP = _blFIFAP.getSubscriptionData(ValorInicial);
                            //FIFAP Forma = new FIFAP(ValorInicial, dataFIFAP);

                            //  Obtiene la información de los artículos en la grilla
                            GetFIHOSData(ref articleList);

                            //  Pasa la lista de artículos a la forma FIFAP
                            frm.SetFIHOSArticles(articleList);

                            /*17-02-2015 Llozada [ARA 1841]: Se envia el plan de financiación seleccionado a FIFAP*/
                            //frm.SetFIHOSPlanFinan(Convert.ToInt32(PlanFinanciacion.Value));
                            /*14-10-2015 heiberb SAO 334390 Se envia la variable para indicar si va con cuota fija o no*/
                            frm.SetFIHOSPlanFinan(Convert.ToString(sbCuotaFija));

                            frm.ShowDialog();
                        }
                    }
                }
                else
                {
                    if (validateBill == -1)
                    {
                        general.mensajeERROR("Posee facturas vencidas. No se realizará venta");
                    }
                    else
                    {
                        if (validateBill != 0)
                        {
                            general.mensajeERROR("Posee facturas vencidas. Sin embargo, se realizará la venta aunque no será legalizada hasta que se realice el pago, a menos que el pago sea de contado.");
                            using (FIFAP frm = new FIFAP(SubscriptionId, _dataFIFAP))
                            {
                                frm.SetBillSlope(validateBill);
                          
                                //frm.ShowDialog();
                                List<ArticleValue> articleList = new List<ArticleValue>();

                                //DataFIFAP dataFIFAP = _blFIFAP.getSubscriptionData(ValorInicial);
                                //FIFAP Forma = new FIFAP(ValorInicial, dataFIFAP);

                                //  Obtiene la información de los artículos en la grilla
                                GetFIHOSData(ref articleList);

                                //  Pasa la lista de artículos a la forma FIFAP
                                frm.SetFIHOSArticles(articleList);

                                /*17-02-2015 Llozada [ARA 1841]: Se envia el plan de financiación seleccionado a FIFAP*/
                                //frm.SetFIHOSPlanFinan(Convert.ToInt32(PlanFinanciacion.Value));
                                /*14-10-2015 heiberb SAO 334390 Se envia la variable para indicar si va con cuota fija o no*/
                                frm.SetFIHOSPlanFinan(Convert.ToString(sbCuotaFija));

                                frm.ShowDialog();

                            }
                        }
                        else
                        {
                            using (FIFAP frm = new FIFAP(SubscriptionId, _dataFIFAP))
                            {
                                frm.SetBillSlope(validateBill);
                                //frm.ShowDialog();
                                List<ArticleValue> articleList = new List<ArticleValue>();

                                //DataFIFAP dataFIFAP = _blFIFAP.getSubscriptionData(ValorInicial);
                                //FIFAP Forma = new FIFAP(ValorInicial, dataFIFAP);

                                //  Obtiene la información de los artículos en la grilla
                                GetFIHOSData(ref articleList);

                                //  Pasa la lista de artículos a la forma FIFAP
                                frm.SetFIHOSArticles(articleList);

                                /*17-02-2015 Llozada [ARA 1841]: Se envia el plan de financiación seleccionado a FIFAP*/
                                //frm.SetFIHOSPlanFinan(Convert.ToInt32(PlanFinanciacion.Value));
                                /*14-10-2015 heiberb SAO 334390 Se envia la variable para indicar si va con cuota fija o no*/
                                frm.SetFIHOSPlanFinan(Convert.ToString(sbCuotaFija));

                                frm.ShowDialog();

                            }
                        }
                    }
                }
                _blFIFAP.ReleaseLock(SubscriptionId);
            }
            else
            {
                general.mensajeERROR("En este momento otro usuario está registrando una venta FNB para este contrato. No se puede proceder hasta que dicha venta finalice");
            }
            this.Close();
        }

        private void bindingNavigatorPosition1_TextChanged(object sender, EventArgs et)
        {            
        }

        private void dgArticleSimulator_AfterCellUpdate(object sender, CellEventArgs e)
        {

            int IDarticulovalidar = 0;//contador de registro de articulo (SamuelP ARA 142395 )
            

            if (e.Cell.Column.Key == "ArticleId" ||
                e.Cell.Column.Key == "ValueArticle" ||
                e.Cell.Column.Key == "Amount" ||
                e.Cell.Column.Key == "FeedsNumber")
            {
                ////////////si se adiciono articulo A LA FORMA 
                //if (e.Cell.Column.Key == "ArticleId")
                //{

                    //// recorro ultragrid para validar duplicidad de registro

                    foreach (UltraGridRow row in this.dgArticleSimulator.Rows)
                    {
                       
                        if (row != null)
                        {
                            //se valida registro adicionado con registro de grilla (SamuelP ARA 142395 )
                            if (Convert.ToDouble(dgArticleSimulator.ActiveRow.Cells[ARTICLE_ID].Value.ToString()) == Convert.ToDouble(row.Cells[9].Value))
                            {
                                IDarticulovalidar++;

                                if (IDarticulovalidar > 1)
                                {
                                    

                                    /******KCienfuegos.SAO316006 12-05-2015****/
                                    activeRowToDelete = this.dgArticleSimulator.ActiveRow;
                                    cancelEvent = true;

                                    if (e.Cell.Column.Key == "ArticleId")
                                    {
                                        general.mensajeERROR("Este artículo ya existe en la lista");
                                    }
                                    /*********Fin SAO316006*********/
                                    return;

                                }

                            }
                            generar();


                        }

                    }


               // }


            }


        }

        private void dgArticleSimulator_Error(object sender, ErrorEventArgs e)
        {
            e.Cancel = true;
        }

        private void dgArticleSimulator_AfterRowActivate(object sender, EventArgs e)
        {
            generar();
        }

        private void contextMenuExportToExcel_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            if (e.ClickedItem.Name.ToString() == "ExportToExcel")
            {
                const String FILE_PREFIX = "CUOTAS_";
                FolderBrowserDialog fbd = new FolderBrowserDialog();
                String fileName;
                Int64 currentArticle;
                UltraGridExcelExporter excelExporter = new UltraGridExcelExporter();

                fbd.Description = "Seleccione el folder donde se guardará el flujo de cuotas: ";

                if (fbd.ShowDialog() != DialogResult.OK)
                {
                    return;
                }

                currentArticle = Convert.ToInt64(dgArticleSimulator.ActiveRow.Cells[ARTICLE_ID].Value);

                fileName = 
                    fbd.SelectedPath + 
                    "\\" + 
                    FILE_PREFIX + 
                    ValorInicial.ToString() + 
                    "_" + 
                    currentArticle.ToString() + 
                    ".xls";

                try
                {
                    excelExporter.Export(dgFlowShare, fileName);
                    //Se exportó los datos a %s1
                    ExceptionHandler.DisplayMessage(
                        2783,
                        new String[] { fileName },
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Information);
                }
                catch
                {
                    //No fue posible crear archivo %s1
                    ExceptionHandler.Raise(2866, new String[] { fileName });
                }
            }
        }

        private void ultraTabControl1_SelectedTabChanged(object sender, Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs e)
        {

        }

        private void cuotaFijaCheck_CheckedChanged(object sender, EventArgs e)
        {
            /* 
* [13/10/2015] heiberb [SAO.334390 Cuota Fija]: 
*/
            if (cuotaFijaCheck.Checked)
            {
                sbCuotaFija = "F";
            }
            else
            {
                sbCuotaFija = "V";
            }

           // general.mensajeOk("El Valor del flag es en FIHOS sbCuotaFija: " + sbCuotaFija);
            _blFIHOS.getAvalibleArticles(
                Convert.ToInt64(_dataFIFAP.SupplierID),
                Convert.ToInt64(_dataFIFAP.DefaultchanelSaleId),
                Convert.ToInt64(_dataFIFAP.GeoLocation),
                Convert.ToInt64(_dataFIFAP.CategoryId),
                Convert.ToInt64(_dataFIFAP.SubcategoryId),
                ref _articleLOV,
                ref tabla,
                sbCuotaFija);
            
           // general.mensajeOk("El Valor del flag es en FIHOS : " + sbCuotaFija);
            //ocArticle = new UltraDropDown();
            ocArticle.DataSource = _articleLOV;
            ocArticle.ValueMember = "ArticleId";
            ocArticle.DisplayMember = "ArticleDescription";
            ocArticle.AutoSize = false;
            dgArticleSimulator.DisplayLayout.Bands[0].Columns[ARTICLE_ID].ValueList = ocArticle;
            if (ocArticle.Rows.Count == 0)
                general.mensajeERROR("No hay artículos disponibles para Simular");
        }

    }
}