using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
//
using SINCECOMP.CANCELLATION.BL;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;
using SINCECOMP.CANCELLATION.Entities;

namespace SINCECOMP.CANCELLATION.UI
{
    public partial class FNBIR : OpenForm
    {
        BindingSource customerbinding = new BindingSource();
        BindingSource customerbinding2 = new BindingSource();
        

        //Columna Grid Two
        String a2 = "Article";

        String c2 = "Deliver";
        String d2 = "Recib";
        String e2 = "UniqueValue";
        String f2 = "Value";
        String g2 = "IVA";
        //
        BLGENERAL general = new BLGENERAL();

        public FNBIR()
         {
            InitializeComponent();

            //lista de causal
            cb_causal.DataSource = general.getComboList("SELECT DISTINCT to_char(ct.causal_id) CODIGO, ct.description DESCRIPCION FROM ps_package_causaltyp pct, cc_causal ct WHERE pct.causal_type_id = ct.causal_type_id AND pct.package_type_id in (100244, 100243)", "CODIGO", "DESCRIPCION");
            cb_causal.DisplayMember = "DESCRIPCION";
            cb_causal.ValueMember = "CODIGO";
            //tipo de identificacion
            cb_TypeId.DataSource = general.getComboList("select to_char(ident_type_id) CODIGO, description DESCRIPCION from ge_identifica_type", "CODIGO", "DESCRIPCION");
            cb_TypeId.DisplayMember = "DESCRIPCION";
            cb_TypeId.ValueMember = "CODIGO";
            //
            //sumatorias
            dgv_GridDetailTwo.DisplayLayout.Bands[0].SummaryFooterCaption = "Totales";
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries.Clear();
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[c2]);
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.Color.Black;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "{0}";
            //
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[d2]);
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries[1].Appearance.ForeColor = System.Drawing.Color.Black;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries[1].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries[1].Appearance.TextHAlign = HAlign.Right;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries[1].DisplayFormat = "{0}";
            //
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[f2]);
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries[2].Appearance.ForeColor = System.Drawing.Color.Black;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries[2].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries[2].Appearance.TextHAlign = HAlign.Right;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Summaries[2].DisplayFormat = "{0:N}";
            //alineaciones y bloqueos
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[c2].CellAppearance.TextHAlign = HAlign.Right;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[d2].CellAppearance.TextHAlign = HAlign.Right;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[e2].CellAppearance.TextHAlign = HAlign.Right;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[g2].CellAppearance.TextHAlign = HAlign.Right;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[f2].CellAppearance.TextHAlign = HAlign.Right;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[a2].CellActivation = Activation.NoEdit;
            //dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[b2].CellActivation = Activation.NoEdit;            
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[c2].CellActivation = Activation.NoEdit;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[d2].CellActivation = Activation.AllowEdit;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[d2].MaskInput = "nnnnnnnnnnnnnnn";
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[e2].CellActivation = Activation.NoEdit;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[f2].CellActivation = Activation.NoEdit;
            dgv_GridDetailTwo.DisplayLayout.Bands[0].Columns[g2].CellActivation = Activation.NoEdit;
            openButton3.Enabled = false;

            dgv_GridDetailOne.DisplayLayout.Bands[0].Columns["OrderId"].CellActivation = Activation.NoEdit;
            dgv_GridDetailOne.DisplayLayout.Bands[0].Columns["TypeDenyDevolutionDesc"].CellActivation = Activation.NoEdit;
            dgv_GridDetailOne.DisplayLayout.Bands[0].Columns["SaleSolicite"].CellActivation = Activation.NoEdit;
            dgv_GridDetailOne.DisplayLayout.Bands[0].Columns["SaleDate"].CellActivation = Activation.NoEdit;
            dgv_GridDetailOne.DisplayLayout.Bands[0].Columns["DenyDate"].CellActivation = Activation.NoEdit;
            dgv_GridDetailOne.DisplayLayout.Bands[0].Columns["ContractId"].CellActivation = Activation.NoEdit;
            dgv_GridDetailOne.DisplayLayout.Bands[0].Columns["ClientId"].CellActivation = Activation.NoEdit;
            dgv_GridDetailOne.DisplayLayout.Bands[0].Columns["ClientName"].CellActivation = Activation.NoEdit;
            dgv_GridDetailOne.DisplayLayout.Bands[0].Columns["ClientAddress"].CellActivation = Activation.NoEdit;
            dgv_GridDetailOne.DisplayLayout.Bands[0].Columns["Origin"].CellActivation = Activation.NoEdit;
            dgv_GridDetailOne.DisplayLayout.Bands[0].Columns["Causal"].CellActivation = Activation.NoEdit;
            dgv_GridDetailOne.DisplayLayout.Bands[0].Columns["Identificador"].CellActivation = Activation.NoEdit;

        }

        private void btn_Search_Click(object sender, EventArgs e)
        {
            try
            {
                String inupackagesale = tb_SaleRequest.TextBoxValue;
                String inupackageannu = tb_requestanul.TextBoxValue;
                String inuorder = tb_order.TextBoxValue;
                String inucausal;
                
                if (cb_causal.Text.Trim()  == "")
                    inucausal = "";
                else
                    inucausal = cb_causal.Value.ToString();

                Nullable<DateTime> idtminsaledate = null;
                Nullable<DateTime> idtmaxsaledate = null;
                DateTime? idtmindateannu = null;
                Nullable<DateTime> idtmaxdateannu = new DateTime();

                if (dtp_mindatesale.Value.ToString().Trim() != "")
                    idtminsaledate = Convert.ToDateTime( dtp_mindatesale.Value );
                if (dtp_maxdatesale.Value.ToString().Trim() != "")
                    idtmaxsaledate = Convert.ToDateTime( dtp_maxdatesale.Value );
                if (dtp_mindateanul.Value.ToString().Trim() != "")
                    idtmindateannu = Convert.ToDateTime( dtp_mindateanul.Value);
                if (dtp_maxdateanul.Value.ToString().Trim() != "")
                    idtmaxdateannu = Convert.ToDateTime( dtp_maxdateanul.Value );
                
                String inuidenttype;
                if (cb_TypeId.Text.Trim()  == "")
                    inuidenttype = "";
                else
                    inuidenttype = cb_TypeId.Value.ToString();

                String isbindentific = tb_ClientId.TextBoxValue ;
                if (!String.IsNullOrEmpty(inuidenttype) && String.IsNullOrEmpty(isbindentific))
                {
                    general.mensajeOk("Si se ingresa un tipo de identificación se debe ingresar la identificación.");
                }
                if (String.IsNullOrEmpty(inuidenttype) && !String.IsNullOrEmpty(isbindentific))
                {
                    general.mensajeOk("Si se ingresa una identificación se debe ingresar un tipo de identificación.");
                }
                String inususccodi = tb_Contract.TextBoxValue;
                List<GridDetailOneFNBIR> ListFNBIR = new List<GridDetailOneFNBIR>();
                ListFNBIR = BLFNBIR.FcusearchReport(inupackagesale, inupackageannu, inuorder, inucausal, idtminsaledate, idtmaxsaledate, idtmindateannu, idtmaxdateannu, inuidenttype, isbindentific, inususccodi);
                customerbinding.DataSource = ListFNBIR;
                dgv_GridDetailOne.DataSource = customerbinding;
                if (dgv_GridDetailOne.Rows.Count < 1)
                    general.mensajeOk("No se encontró información relacionada a los parámetros ingresados.");
                if (customerbinding.Count == 0)
                {
                    start = false;
                    List<ResgisterFNBCR> ListFNBCR = new List<ResgisterFNBCR>();
                    customerbinding2.DataSource = ListFNBCR;
                    dgv_GridDetailTwo.DataSource = customerbinding2;
                    start = true;
                }
            }
            catch(Exception ex)
            {
                general.mensajeERROR("Error en la Consulta " + ex.ToString());
                limpiar();
            }
        }

        Boolean start = true;

        void limpiar()
        {
            start = false;
            List<GridDetailOneFNBIR> ListFNBIR1 = new List<GridDetailOneFNBIR>();
            customerbinding.DataSource = ListFNBIR1;
            dgv_GridDetailOne.DataSource = customerbinding;
            List<ResgisterFNBCR> ListFNBCR = new List<ResgisterFNBCR>();
            customerbinding2.DataSource = ListFNBCR;
            dgv_GridDetailTwo.DataSource = customerbinding2;
            start = true;
        }

        private void btn_Clean_Click(object sender, EventArgs e)
        {
            tb_ClientId.TextBoxValue = "";
            tb_Contract.TextBoxValue = "";
            tb_order.TextBoxValue = "";
            tb_requestanul.TextBoxValue = "";
            tb_SaleRequest.TextBoxValue = "";
            dtp_maxdateanul.Value = null;
            dtp_mindateanul.Value = null;
            dtp_maxdatesale.Value = null;            
            dtp_mindatesale.Value = null;
            cb_causal.Value = "";
            cb_TypeId.Value = "";
            limpiar();
        }

        private void dgv_GridDetailOne_AfterRowActivate(object sender, EventArgs e)
        {
            if (start)
            {
                GridDetailOneFNBIR currentOrder = (dgv_GridDetailOne.ActiveRow.ListObject as GridDetailOneFNBIR);

                if (currentOrder.ArticleList == null)
                {
                    List<ResgisterFNBCR> ListFNBCR = new List<ResgisterFNBCR>();
                    ListFNBCR = BLFNBCR.FcuFNBCR(Convert.ToInt64(dgv_GridDetailOne.ActiveRow.Cells["identificador"].Value.ToString()));
                    currentOrder.ArticleList = ListFNBCR;
                    customerbinding2.DataSource = ListFNBCR;
                }
                else
                {
                    customerbinding2.DataSource = currentOrder.ArticleList;
                }

                dgv_GridDetailTwo.DataSource = customerbinding2;               
                
            }
            if (Convert.ToInt64(dgv_GridDetailTwo.Rows.Count) > 0)
                openButton3.Enabled = true;
            else
                openButton3.Enabled = false;
        }

        private void dtp_mindatesale_ValueChanged(object sender, EventArgs e)
        {
            if (start)
            {
                if (dtp_mindatesale.Value.ToString().Trim() != "")
                {
                    DateTime fecIni = Convert.ToDateTime(dtp_mindatesale.Value);                    
                    DateTime fecAct = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy"));
                    
                    if (fecIni > fecAct)
                    {
                        general.mensajeERROR("Fecha mínima de venta no puede ser superior a la fecha actual");
                        start = false;
                        dtp_mindatesale.Value = DateTime.Now;
                        start = true;
                    }
                    else
                    if (dtp_maxdatesale.Value.ToString().Trim() != "")
                    {
                        DateTime fecFin = Convert.ToDateTime(dtp_maxdatesale.Value);
                        if (fecIni > fecFin )
                        {
                            general.mensajeERROR("Fecha mínima de venta no puede ser superior a la fecha máxima de venta");
                            start = false;
                            dtp_mindatesale.Value = dtp_maxdatesale.Value;
                            start = true;
                        }

                    }
                }
            }
        }

        private void dtp_maxdatesale_ValueChanged(object sender, EventArgs e)
        {
            if (start)
            {
                if (dtp_maxdatesale.Value.ToString().Trim() != "")
                {
                    DateTime fecFin = Convert.ToDateTime(dtp_maxdatesale.Value);
                    DateTime fecAct = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy"));

                    if (fecFin > fecAct)
                    {
                        general.mensajeERROR("Fecha máxima de venta no puede ser superior a la fecha actual");
                        start = false;
                        dtp_maxdatesale.Value = DateTime.Now;
                        start = true;
                    }
                    else
                    if (dtp_mindatesale.Value.ToString().Trim() != "")
                    {
                        DateTime fecIni = Convert.ToDateTime(dtp_mindatesale.Value);
                        if (fecFin < fecIni)
                        {
                            general.mensajeERROR("Fecha máxima de venta no puede ser inferior a la fecha mínima de venta");
                            start = false;
                            dtp_maxdatesale.Value = dtp_mindatesale.Value;
                            start = true;
                        }
                    }
                }
            }
        }

        private void dtp_mindateanul_ValueChanged(object sender, EventArgs e)
        {
            if (start)
            {
                if (dtp_mindateanul.Value.ToString().Trim() != "")
                {
                    DateTime fecIni = Convert.ToDateTime(dtp_mindateanul.Value);
                    DateTime fecAct = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy"));

                    if (fecIni > fecAct)
                    {
                        general.mensajeERROR("Fecha mínima de anulación no puede ser superior a la fecha actual");
                        start = false;
                        dtp_mindateanul.Value = DateTime.Now;
                        start = true;
                    }
                    else
                        if (dtp_maxdateanul.Value.ToString().Trim() != "")
                        {
                            DateTime fecFin = Convert.ToDateTime(dtp_maxdateanul.Value);
                            if (fecIni > fecFin)
                            {
                                general.mensajeERROR("Fecha mínima de anulación no puede ser superior a la fecha máxima de anulación");
                                start = false;
                                dtp_mindateanul.Value = dtp_maxdateanul.Value;
                                start = true;
                            }

                        }
                }
            }
        }

        private void dtp_maxdateanul_ValueChanged(object sender, EventArgs e)
        {
            if (start)
            {
                if (dtp_maxdateanul.Value.ToString().Trim() != "")
                {
                    DateTime fecFin = Convert.ToDateTime(dtp_maxdateanul.Value);
                    DateTime fecAct = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy"));

                    if (fecFin > fecAct)
                    {
                        general.mensajeERROR("Fecha máxima de anulación no puede ser superior a la fecha actual");
                        start = false;
                        dtp_maxdateanul.Value = DateTime.Now;
                        start = true;
                    }
                    else
                        if (dtp_mindateanul.Value.ToString().Trim() != "")
                        {
                            DateTime fecIni = Convert.ToDateTime(dtp_mindateanul.Value);
                            if (fecFin < fecIni)
                            {
                                general.mensajeERROR("Fecha máxima de anulación no puede ser inferior a la fecha mínima de anulación");
                                start = false;
                                dtp_maxdateanul.Value = dtp_mindateanul.Value;
                                start = true;
                            }
                        }
                }
            }
        }

        private void openButton1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        /***************************************************************************
        Historia de Modificaciones
        Fecha            Autor          Modificacion
        =========       =========       ====================
        25/09/2014      Llozada         Se agrega el campo de observaciones [ostbCommentfnbir] y se valida 
                                        que sea obliogatorio.
                                        Se modifican los métodos de anulación para que reciban la observación
        ***************************************************************************/
        private void openButton3_Click(object sender, EventArgs e)
        {
            
            Int64 opcion = 0;
            String LegaString = null;
            //1
            Int64 TASK_TYPE_REVE = Convert.ToInt64(general.getParam("TASK_TYPE_REVE", "Int64").ToString());
            //2
            Int64 TASK_TYPE_ACAN = Convert.ToInt64(general.getParam("TASK_TYPE_ACAN", "Int64").ToString());
            //3
            Int64 TASK_TYPE_APAN = Convert.ToInt64(general.getParam("TASK_TYPE_APAN", "Int64").ToString());

            Int64 countProcessed = 0;

            try
            {
                //25/09/2014 [Llozada]
                if (!String.IsNullOrEmpty(ostbCommentfnbir.TextBoxValue))
                {
                    foreach (GridDetailOneFNBIR currentOder in (List<GridDetailOneFNBIR>)((dgv_GridDetailOne.DataSource as BindingSource).List))
                    {
                        if (currentOder.Check)
                        {
                            LegaString = null;
                            opcion = 0;
                            if (currentOder.ArticleList.Count > 0)
                            {
                                foreach (ResgisterFNBCR currentArticle in currentOder.ArticleList)
                                {
                                    if (currentArticle.Recib > 0)
                                    {
                                        LegaString = LegaString + currentArticle.Activity + "|0|" + currentArticle.Recib + "|";
                                    }
                                    else
                                    {
                                        LegaString = LegaString + currentArticle.Activity + "|1|" + currentArticle.Recib + "|";
                                    }
                                }

                                if (TASK_TYPE_REVE == currentOder.TypeDenyDevolution)
                                    opcion = 1;
                                if (TASK_TYPE_ACAN == currentOder.TypeDenyDevolution)
                                    opcion = 2;
                                if (TASK_TYPE_APAN == currentOder.TypeDenyDevolution)
                                    opcion = 3;

                                //25/09/2014 [Llozada]
                                BLFNBIR.LegAnnulmentOrder(currentOder.OrderId, opcion, LegaString, ostbCommentfnbir.TextBoxValue);
                                countProcessed++;
                            }
                        }
                    }
                }
                else
                    general.mensajeERROR("Por favor ingrese la observación"); 

                if (countProcessed > 0)
                {
                    limpiar();
                    general.doCommit();
                    general.mensajeOk("El proceso terminó con exito.");
                }
                else
                {
                    general.mensajeOk("Debe seleccionar al menos una orden a procesar.");
                }
            }
            catch (Exception ex)
            {
                general.doRollback();
                general.mensajeERROR("Error al procesar la solicitud. Error: " + ex.Message);                
            }            
        }

        private void dgv_GridDetailTwo_AfterCellUpdate(object sender, CellEventArgs e)
        {
            if (Convert.ToInt64(dgv_GridDetailTwo.ActiveRow.Cells["recib"].Value) >
                    Convert.ToInt64(dgv_GridDetailTwo.ActiveRow.Cells["deliver"].Value)
                )
            {
                dgv_GridDetailTwo.ActiveRow.Cells["recib"].Value = 0;
                general.mensajeERROR("El numero de artículos recibidos, es mayor al de entregado, favor validar los datos ingresados");
            }   
                
        }
        private void dgv_GridDetailTwo_Error(object sender, ErrorEventArgs e)
        {
            if (e.ErrorType == ErrorType.Data)
                e.Cancel = true;
                dgv_GridDetailTwo.ActiveRow.Cells["recib"].Value = 0;
        }

        private void ultraGroupBox1_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void panel4_Paint(object sender, PaintEventArgs e)
        {

        }
     
    }
}