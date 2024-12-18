using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.CONSTRUCTIONUNITS.Entity;
using SINCECOMP.CONSTRUCTIONUNITS.DAL;
using SINCECOMP.CONSTRUCTIONUNITS.BL;
using OpenSystems.Security.ExecutableMgr;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;


namespace SINCECOMP.CONSTRUCTIONUNITS.UI
{
    public partial class LDBEX : OpenForm
    {
        public static Int64 nurdbTypeWeights;
        public static Int64 nuConstantYear;
        public static Int64 nuConstantMonth;
        public static Int64 nuWeightsYear;
        public static Int64 nuWeightsMonth;
        public static String sbLblSelected;
        public static String sbLblCategory;
        public static String sbLblSubCategory;

        public Int64 nuGirdSeleccion;
        public String nuWeights;
        public String nuBaseYear;

        public LDBEX()
        {
            InitializeComponent();

            DataTable TBDSLdRelevantMarket = DALLDBEX.DSLdRelevantMarket();

            this.cbRelevantMarket.DataSource = TBDSLdRelevantMarket;

            this.cbRelevantMarket.DisplayMember = "DESCRIPCION";

            this.cbRelevantMarket.ValueMember = "CODIGO";

            nuGirdSeleccion = 0;

            nuWeights = DALLDBEX.FsbRelMarRateYearMonth();

            if (String.IsNullOrEmpty(nuWeights) == true)
            {
                //nuWeights = DALLDBEX.FsbRelMarRateYearMonth();
            }
            else
            {
                this.rdbTypeWeights.Items[0].DisplayText = nuWeights.Substring(0, nuWeights.IndexOf("-"));

                nuWeightsMonth = Convert.ToInt64(nuWeights.Substring(nuWeights.IndexOf("-") + 1));

                nuWeightsYear = Convert.ToInt64(nuWeights.Substring(nuWeights.IndexOf("-") - 4, 4));

                this.cbRelevantMarket.Focus();
            }
            this.rdbTypeWeights.CheckedIndex = 0;
            this.rdbTypeQuery.CheckedIndex = 0;
        }

        #region "Declaraciones y Procedimientos"

        private void unitstructural()
        {
            if (rdbTypeQuery.CheckedIndex >= 0)
            {
                if (rdbTypeQuery.CheckedIndex == 0)
                {
                    if (nuGirdSeleccion == 1)
                    {
                        LDBEX_DETAIL formad = new LDBEX_DETAIL("DetailConsUnitValue", Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value), Convert.ToInt64(this.dgExecConsUnitWithLocalBudg.Rows[int.Parse(dgExecConsUnitWithLocalBudg.ActiveCell.Row.VisibleIndex.ToString())].Cells[0].Value.ToString()), 0, 0, 0, nuGirdSeleccion);
                        formad.ShowDialog();
                    }
                    else
                    {
                        if (nuGirdSeleccion == 3)
                        {
                            LDBEX_DETAIL formad = new LDBEX_DETAIL("DetailConsUnitValue", Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value), 0, Convert.ToInt64(this.dgExecConsUnitWithBudg.Rows[int.Parse(dgExecConsUnitWithBudg.ActiveCell.Row.VisibleIndex.ToString())].Cells[0].Value.ToString()), 0, 0, nuGirdSeleccion);
                            formad.ShowDialog();
                        }
                        else
                        {
                            if (nuGirdSeleccion == 2)
                            {
                                LDBEX_DETAIL formad = new LDBEX_DETAIL("DetailConsUnitValue", Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value), Convert.ToInt64(this.dgConsUnitExecWithoutLocaBudg.Rows[int.Parse(dgConsUnitExecWithoutLocaBudg.ActiveCell.Row.VisibleIndex.ToString())].Cells[0].Value.ToString()), 0, 0, 0, nuGirdSeleccion);
                                formad.ShowDialog();
                            }
                            else
                            {
                                if (nuGirdSeleccion == 4)
                                {
                                    LDBEX_DETAIL formad = new LDBEX_DETAIL("DetailConsUnitValue", Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value), 0, Convert.ToInt64(this.dgExecConsUnitWithoutBudg.Rows[int.Parse(dgExecConsUnitWithoutBudg.ActiveCell.Row.VisibleIndex.ToString())].Cells[0].Value.ToString()), 0, 0, nuGirdSeleccion);
                                    formad.ShowDialog();
                                }
                            }
                        }
                    }
                }
                else
                {
                    if (nuGirdSeleccion == 1)
                    {

                        LDBEX_DETAIL formad = new LDBEX_DETAIL("DetailConsUnitAmount", Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value), Convert.ToInt64(this.dgExecConsUnitWithLocalBudg.Rows[int.Parse(dgExecConsUnitWithLocalBudg.ActiveCell.Row.VisibleIndex.ToString())].Cells[0].Value.ToString()), 0, 0, 0, nuGirdSeleccion);
                        formad.ShowDialog();
                    }
                    else
                    {
                        if (nuGirdSeleccion == 3)
                        {

                            LDBEX_DETAIL formad = new LDBEX_DETAIL("DetailConsUnitAmount", Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value), 0, Convert.ToInt64(this.dgExecConsUnitWithBudg.Rows[int.Parse(dgExecConsUnitWithBudg.ActiveCell.Row.VisibleIndex.ToString())].Cells[0].Value.ToString()), 0, 0, nuGirdSeleccion);
                            formad.ShowDialog();
                        }
                        else
                        {
                            if (nuGirdSeleccion == 2)
                            {
                                LDBEX_DETAIL formad = new LDBEX_DETAIL("DetailConsUnitAmount", Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value), Convert.ToInt64(this.dgConsUnitExecWithoutLocaBudg.Rows[int.Parse(dgConsUnitExecWithoutLocaBudg.ActiveCell.Row.VisibleIndex.ToString())].Cells[0].Value.ToString()), 0, 0, 0, nuGirdSeleccion);
                                formad.ShowDialog();
                            }
                            else
                            {
                                if (nuGirdSeleccion == 4)
                                {
                                    LDBEX_DETAIL formad = new LDBEX_DETAIL("DetailConsUnitAmount", Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value), 0, Convert.ToInt64(this.dgExecConsUnitWithoutBudg.Rows[int.Parse(dgExecConsUnitWithoutBudg.ActiveCell.Row.VisibleIndex.ToString())].Cells[0].Value.ToString()), 0, 0, nuGirdSeleccion);
                                    formad.ShowDialog();
                                }
                            }
                        }
                    }

                }
            }
            else
                MessageBox.Show("Debe seleccionar un tipo de Consulta (Valor - Cantidad)", "Falto Selecccionar");
        }

        #endregion

        #region "Eventos y rutinas"

        private void LDBEX_Load(object sender, EventArgs e)
        {

        }

        //cambio de pestañas
        private void tcStructuralunit_SelectedTabChanged(object sender, Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs e)
        {
            if (String.IsNullOrEmpty(this.cbRelevantMarket.Text) == false)
            {
                switch (e.Tab.VisibleIndex)
                {
                    case 0:
                        {
                            opInformation.Visible = true;
                        }
                        break;
                    case 1:
                        {
                            opInformation.Visible = true;

                        }
                        break;
                    case 2:
                        {
                            /*Demanda de Gas*/
                            List<GasDemandService> listGDE = new List<GasDemandService>();

                            listGDE = BLLDBEX.FlistGDE(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                            this.dgGasDemand.DataSource = listGDE;
                            /*Fin Demanda de Gas*/

                            opInformation.Visible = false;
                            lblSelected.Text = "";
                        }
                        break;
                    case 3:
                        {
                            /*Servicio de Gas*/
                            List<GasDemandService> listGSE = new List<GasDemandService>();

                            listGSE = BLLDBEX.FlistGSE(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                            this.dgGasService.DataSource = listGSE;
                            /*Fin Servicio de Gas*/

                            opInformation.Visible = false;
                            lblSelected.Text = "";
                        }
                        break;
                    case 4:
                        {
                            /*GASTOS DE DISTRIBUCION*/
                            List<MarketingDistributionExpenses> listDEB = new List<MarketingDistributionExpenses>();

                            listDEB = BLLDBEX.FlistDEB(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                            this.dgDistributionExpenses.DisplayLayout.Bands[0].Summaries.Clear();
                            this.dgDistributionExpenses.DisplayLayout.Bands[0].Columns["Executed"].CellAppearance.TextHAlign = HAlign.Right;
                            this.dgDistributionExpenses.DisplayLayout.Bands[0].Columns["Executed"].Width = 150;
                            this.dgDistributionExpenses.DisplayLayout.Bands[0].Columns["Executed"].Format = "#,##0.00";
                            this.dgDistributionExpenses.DisplayLayout.Bands[0].Columns["Budget"].CellAppearance.TextHAlign = HAlign.Right;
                            this.dgDistributionExpenses.DisplayLayout.Bands[0].Columns["Budget"].Width = 150;
                            this.dgDistributionExpenses.DisplayLayout.Bands[0].Columns["Budget"].Format = "#,##0.00";
                            this.dgDistributionExpenses.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
                            this.dgDistributionExpenses.DisplayLayout.Bands[0].Columns["Difference"].Width = 150;
                            this.dgDistributionExpenses.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00";
                            this.dgDistributionExpenses.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
                            this.dgDistributionExpenses.DisplayLayout.Bands[0].Columns["Percentage"].Width = 150;
                            this.dgDistributionExpenses.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";

                            this.dgDistributionExpenses.DataSource = listDEB;
                            /*FIN GASTOS DE DISTRIBUCION*/

                            /*GASTOS DE COMERCIALIZACION*/
                            List<MarketingDistributionExpenses> listMEB = new List<MarketingDistributionExpenses>();

                            listMEB = BLLDBEX.FlistMEB(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                            this.dgMarketingExpenses.DisplayLayout.Bands[0].Summaries.Clear();
                            this.dgMarketingExpenses.DisplayLayout.Bands[0].Columns["Executed"].CellAppearance.TextHAlign = HAlign.Right;
                            this.dgMarketingExpenses.DisplayLayout.Bands[0].Columns["Executed"].Width = 150;
                            this.dgMarketingExpenses.DisplayLayout.Bands[0].Columns["Executed"].Format = "#,##0.00";
                            this.dgMarketingExpenses.DisplayLayout.Bands[0].Columns["Budget"].CellAppearance.TextHAlign = HAlign.Right;
                            this.dgMarketingExpenses.DisplayLayout.Bands[0].Columns["Budget"].Width = 150;
                            this.dgMarketingExpenses.DisplayLayout.Bands[0].Columns["Budget"].Format = "#,##0.00";
                            this.dgMarketingExpenses.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
                            this.dgMarketingExpenses.DisplayLayout.Bands[0].Columns["Difference"].Width = 150;
                            this.dgMarketingExpenses.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00";
                            this.dgMarketingExpenses.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
                            this.dgMarketingExpenses.DisplayLayout.Bands[0].Columns["Percentage"].Width = 150;
                            this.dgMarketingExpenses.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";

                            this.dgMarketingExpenses.DataSource = listMEB;
                            /*FIN GASTOS DE COMERCIALIZACION*/

                            opInformation.Visible = false;
                            lblSelected.Text = "";
                        }
                        break;
                }

                setLayoutGrid();
            }

            opInformation.Visible = true;
        }

        //booton en grillas
        private void dgExecConsUnitWithLocalBudg_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            Infragistics.Win.UltraWinGrid.UltraGridLayout layout = e.Layout;
            Infragistics.Win.UltraWinGrid.UltraGridBand band = layout.Bands[0];
            //total de las columnas grilla +1, debe verificarse en todas las grillas
            if (band.Columns.Count < 9)
            {
                Infragistics.Win.UltraWinGrid.UltraGridColumn buttonColumn = band.Columns.Add("Consultar");
                buttonColumn.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
            }
        }

        //*
        private void dgExecConsUnitWithLocalBudg_InitializeRow(object sender, Infragistics.Win.UltraWinGrid.InitializeRowEventArgs e)
        {
            if (e.ReInitialize == false)
            {
                e.Row.Cells["Consultar"].Value = "Detallar";
            }
        }

        private void dgConsUnitExecWithoutLocaBudg_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            Infragistics.Win.UltraWinGrid.UltraGridLayout layout = e.Layout;
            Infragistics.Win.UltraWinGrid.UltraGridBand band = layout.Bands[0];
            if (band.Columns.Count < 9)
            {
                Infragistics.Win.UltraWinGrid.UltraGridColumn buttonColumn = band.Columns.Add("Consultar");
                buttonColumn.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
            }
        }

        private void dgConsUnitExecWithoutLocaBudg_InitializeRow(object sender, Infragistics.Win.UltraWinGrid.InitializeRowEventArgs e)
        {
            if (e.ReInitialize == false)
            {
                e.Row.Cells["Consultar"].Value = "Detallar";
            }
        }

        private void dgGasservice_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            Infragistics.Win.UltraWinGrid.UltraGridLayout layout = e.Layout;
            Infragistics.Win.UltraWinGrid.UltraGridBand band = layout.Bands[0];
            if (band.Columns.Count < 9)
            {
                Infragistics.Win.UltraWinGrid.UltraGridColumn buttonColumn = band.Columns.Add("Consultar");
                buttonColumn.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
            }
        }

        private void dgGasservice_InitializeRow(object sender, Infragistics.Win.UltraWinGrid.InitializeRowEventArgs e)
        {
            if (e.ReInitialize == false)
            {
                e.Row.Cells["Consultar"].Value = "Detallar";
            }
        }

        private void dgExecConsUnitWithBudg_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            Infragistics.Win.UltraWinGrid.UltraGridLayout layout = e.Layout;
            Infragistics.Win.UltraWinGrid.UltraGridBand band = layout.Bands[0];
            if (band.Columns.Count < 9)
            {
                Infragistics.Win.UltraWinGrid.UltraGridColumn buttonColumn = band.Columns.Add("Consultar");
                buttonColumn.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
            }
        }

        private void dgExecConsUnitWithBudg_InitializeRow(object sender, Infragistics.Win.UltraWinGrid.InitializeRowEventArgs e)
        {
            if (e.ReInitialize == false)
            {
                e.Row.Cells["Consultar"].Value = "Detallar";
            }
        }

        private void dgExecConsUnitWithoutBudg_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            Infragistics.Win.UltraWinGrid.UltraGridLayout layout = e.Layout;
            Infragistics.Win.UltraWinGrid.UltraGridBand band = layout.Bands[0];
            if (band.Columns.Count < 9)
            {
                Infragistics.Win.UltraWinGrid.UltraGridColumn buttonColumn = band.Columns.Add("Consultar");
                buttonColumn.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
            }
        }

        private void dgExecConsUnitWithoutBudg_InitializeRow(object sender, Infragistics.Win.UltraWinGrid.InitializeRowEventArgs e)
        {
            if (e.ReInitialize == false)
            {
                e.Row.Cells["Consultar"].Value = "Detallar";
            }
        }

        private void dgGasDemand_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            Infragistics.Win.UltraWinGrid.UltraGridLayout layout = e.Layout;
            Infragistics.Win.UltraWinGrid.UltraGridBand band = layout.Bands[0];
            if (band.Columns.Count < 9)
            {
                Infragistics.Win.UltraWinGrid.UltraGridColumn buttonColumn = band.Columns.Add("Consultar");
                buttonColumn.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
            }
        }

        private void dgGasDemand_InitializeRow(object sender, Infragistics.Win.UltraWinGrid.InitializeRowEventArgs e)
        {
            if (e.ReInitialize == false)
            {
                e.Row.Cells["Consultar"].Value = "Detallar";
            }
        }

        //fin de proceso agregar botones

        private void dgExecConsUnitWithLocalBudg_ClickCellButton(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            nuGirdSeleccion = 1;
            unitstructural();
        }

        private void dgConsUnitExecWithoutLocaBudg_ClickCellButton(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            nuGirdSeleccion = 2;
            unitstructural();
        }

        private void dgExecConsUnitWithBudg_ClickCellButton(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            nuGirdSeleccion = 3;
            unitstructural();
        }

        private void dgExecConsUnitWithoutBudg_ClickCellButton(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            nuGirdSeleccion = 4;
            unitstructural();
        }

        private void dgGasDemand_ClickCellButton(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            LDBEX_DETAIL formad = new LDBEX_DETAIL("gasdemand", Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value), 0, 0, Convert.ToInt64(this.dgGasDemand.Rows[int.Parse(dgGasDemand.ActiveCell.Row.VisibleIndex.ToString())].Cells[0].Value.ToString()), Convert.ToInt64(this.dgGasDemand.Rows[int.Parse(dgGasDemand.ActiveCell.Row.VisibleIndex.ToString())].Cells[2].Value.ToString()), 0);
            formad.ShowDialog();
        }

        private void dgGasservice_ClickCellButton(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            LDBEX_DETAIL formad = new LDBEX_DETAIL("gasservice", Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value), 0, 0, Convert.ToInt64(this.dgGasService.Rows[int.Parse(dgGasService.ActiveCell.Row.VisibleIndex.ToString())].Cells[0].Value.ToString()), Convert.ToInt64(this.dgGasService.Rows[int.Parse(dgGasService.ActiveCell.Row.VisibleIndex.ToString())].Cells[2].Value.ToString()), 0);
            formad.ShowDialog();
        }
        //*/
        #endregion

        private void rdbTypeQuery_ValueChanged(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(this.cbRelevantMarket.Text) == false)
            {
                weights();
                //hvera
                DemandServiceExpenses();
                setLayoutGrid();
            }
        }

        private void btnreport_Click(object sender, EventArgs e)
        {
            Dictionary<string, object> parametersTemp = new Dictionary<string, object>();

            OpenSystems.Security.ExecutableMgr.ExecutableMaster.LaunchDynamicLibraryApplication("LDRUC", parametersTemp, true);
        }

        private void rdbTypeWeights_ValueChanged(object sender, EventArgs e)
        {
            if (rdbTypeWeights.CheckedIndex == 2 && (String.IsNullOrEmpty(this.tbConstantYear.TextBoxValue) == true || String.IsNullOrEmpty(this.tbConstantMonth.TextBoxValue) == true))
            {
                this.dgExecConsUnitWithLocalBudg.DataSource = null;
                this.dgConsUnitExecWithoutLocaBudg.DataSource = null;
                this.dgExecConsUnitWithBudg.DataSource = null;
                this.dgExecConsUnitWithoutBudg.DataSource = null;
                this.tbTotalExecutedConUniLoc.TextBoxValue = "0";
                this.tbTotalBudgetConUniLoc.TextBoxValue = "0";
                this.tbTotalDifferenceConUniLoc.TextBoxValue = "0";
                this.tbTotalPercentageConUniLoc.TextBoxValue = "0";
                this.tbTotalExecutedConUni.TextBoxValue = "0";
                this.tbTotalBudgetConUni.TextBoxValue = "0";
                this.tbTotalDifferenceConUni.TextBoxValue = "0";
                this.tbTotalPercentageConUni.TextBoxValue = "0";
            }
            else
            {
                if (String.IsNullOrEmpty(this.cbRelevantMarket.Text) == false)
                {
                    weights();
                    //hvera
                    DemandServiceExpenses();
                    setLayoutGrid();
                }
            }
        }

        public void DemandServiceExpenses()
        {
            /*Demanda de Gas*/
            List<GasDemandService> listGDE = new List<GasDemandService>();

            listGDE = BLLDBEX.FlistGDE(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

            this.dgGasDemand.DataSource = listGDE;
            /*Fin Demanda de Gas*/

            opInformation.Visible = false;
            lblSelected.Text = "";

            /*Servicio de Gas*/
            List<GasDemandService> listGSE = new List<GasDemandService>();

            listGSE = BLLDBEX.FlistGSE(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

            this.dgGasService.DataSource = listGSE;
            /*Fin Servicio de Gas*/

            opInformation.Visible = false;
            lblSelected.Text = "";

            /*GASTOS DE DISTRIBUCION*/
            List<MarketingDistributionExpenses> listDEB = new List<MarketingDistributionExpenses>();

            listDEB = BLLDBEX.FlistDEB(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

            this.dgDistributionExpenses.DataSource = listDEB;
            /*FIN GASTOS DE DISTRIBUCION*/

            /*GASTOS DE COMERCIALIZACION*/
            List<MarketingDistributionExpenses> listMEB = new List<MarketingDistributionExpenses>();

            listMEB = BLLDBEX.FlistMEB(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

            this.dgMarketingExpenses.DataSource = listMEB;
            /*FIN GASTOS DE COMERCIALIZACION*/

            opInformation.Visible = true;
            lblSelected.Text = "";
        }

        public void weights()
        {
            if (Convert.ToInt64(this.rdbTypeQuery.CheckedIndex.ToString()) == 0)
            {

                if (rdbTypeWeights.CheckedIndex == 0)
                {
                    nurdbTypeWeights = 0;
                    /*Unidades Constructiva agrupadas por localidad*/

                    /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR LOCALIDAD EJECUTADAS 
                     CON PRESUPUESTOS*/
                    List<ContructionUnitsLocationValue> listCULVCP = new List<ContructionUnitsLocationValue>();

                    listCULVCP = BLLDBEX.FlistCULVCP(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), nuWeightsYear, nuWeightsMonth, Convert.ToInt64(this.cbRelevantMarket.Value));

                    this.dgExecConsUnitWithLocalBudg.DataSource = listCULVCP;

                    /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR LOCALIDAD EJECUTADAS 
                     SIN PRESUPUESTOS*/

                    List<ContructionUnitsLocationValue> listCULDVNDCP = new List<ContructionUnitsLocationValue>();

                    listCULDVNDCP = BLLDBEX.FlistCULVNDCP(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), nuWeightsYear, nuWeightsMonth, Convert.ToInt64(this.cbRelevantMarket.Value));

                    this.dgConsUnitExecWithoutLocaBudg.DataSource = listCULDVNDCP;

                    /*Fin Unidades Constructiva agrupadas por localidad*/

                    /*Unidades Constructiva agrupadas por Unidades Constructivas*/

                    /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR UNIDADES CONSTRCUTIVAS EJECUTADAS 
                     CON PRESUPUESTOS*/

                    List<ContructionUnitsValue> listCUVCP = new List<ContructionUnitsValue>();

                    listCUVCP = BLLDBEX.FlistCUVCP(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), nuWeightsYear, nuWeightsMonth, Convert.ToInt64(this.cbRelevantMarket.Value));

                    this.dgExecConsUnitWithBudg.DataSource = listCUVCP;

                    /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR UNIDADES CONSTRCUTIVAS EJECUTADAS 
                     SIN PRESUPUESTOS*/
                    List<ContructionUnitsValue> listCUVNDCP = new List<ContructionUnitsValue>();

                    listCUVNDCP = BLLDBEX.FlistCUVNDCP(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), nuWeightsYear, nuWeightsMonth, Convert.ToInt64(this.cbRelevantMarket.Value));

                    this.dgExecConsUnitWithoutBudg.DataSource = listCUVNDCP;

                    /*Fin Unidades Constructiva agrupadas por Unidades Constructivas*/

                }
                else
                {
                    if (rdbTypeWeights.CheckedIndex == 1)
                    {
                        nurdbTypeWeights = 1;
                        /*Unidades Constructiva agrupadas por localidad*/

                        /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR LOCALIDAD EJECUTADAS 
                         CON PRESUPUESTOS*/
                        List<ContructionUnitsLocationValue> listCULEV = new List<ContructionUnitsLocationValue>();

                        listCULEV = BLLDBEX.FlistCULEV(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                        this.dgExecConsUnitWithLocalBudg.DataSource = listCULEV;

                        /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR LOCALIDAD EJECUTADAS 
                         SIN PRESUPUESTOS*/

                        List<ContructionUnitsLocationValue> listCULENDV = new List<ContructionUnitsLocationValue>();

                        listCULENDV = BLLDBEX.FlistCULENDV(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                        this.dgConsUnitExecWithoutLocaBudg.DataSource = listCULENDV;

                        /*Fin Unidades Constructiva agrupadas por localidad*/

                        /*Unidades Constructiva agrupadas por Unidades Constructivas*/

                        /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR UNIDADES CONSTRCUTIVAS EJECUTADAS 
                         CON PRESUPUESTOS*/

                        List<ContructionUnitsValue> listCUEV = new List<ContructionUnitsValue>();

                        listCUEV = BLLDBEX.FlistCUEV(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                        this.dgExecConsUnitWithBudg.DataSource = listCUEV;

                        /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR UNIDADES CONSTRCUTIVAS EJECUTADAS 
                         SIN PRESUPUESTOS*/
                        List<ContructionUnitsValue> listCUENDV = new List<ContructionUnitsValue>();

                        listCUENDV = BLLDBEX.FlistCUENDV(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                        this.dgExecConsUnitWithoutBudg.DataSource = listCUENDV;

                        /*Fin Unidades Constructiva agrupadas por Unidades Constructivas*/
                    }
                    else
                    {
                        if (rdbTypeWeights.CheckedIndex == 2)
                        {
                            nurdbTypeWeights = 2;
                            nuConstantYear = Convert.ToInt64(this.tbConstantYear.TextBoxValue);
                            nuConstantMonth = Convert.ToInt64(this.tbConstantMonth.TextBoxValue);
                            /*Unidades Constructiva agrupadas por localidad*/

                            /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR LOCALIDAD EJECUTADAS 
                             CON PRESUPUESTOS*/
                            List<ContructionUnitsLocationValue> listCULVCP = new List<ContructionUnitsLocationValue>();

                            listCULVCP = BLLDBEX.FlistCULVCP(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.tbConstantYear.TextBoxValue), Convert.ToInt64(this.tbConstantMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                            this.dgExecConsUnitWithLocalBudg.DataSource = listCULVCP;

                            /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR LOCALIDAD EJECUTADAS 
                             SIN PRESUPUESTOS*/

                            List<ContructionUnitsLocationValue> listCULDVNDCP = new List<ContructionUnitsLocationValue>();

                            listCULDVNDCP = BLLDBEX.FlistCULVNDCP(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.tbConstantYear.TextBoxValue), Convert.ToInt64(this.tbConstantMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                            this.dgConsUnitExecWithoutLocaBudg.DataSource = listCULDVNDCP;

                            /*Fin Unidades Constructiva agrupadas por localidad*/

                            /*Unidades Constructiva agrupadas por Unidades Constructivas*/

                            /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR UNIDADES CONSTRCUTIVAS EJECUTADAS 
                             CON PRESUPUESTOS*/

                            List<ContructionUnitsValue> listCUVCP = new List<ContructionUnitsValue>();

                            listCUVCP = BLLDBEX.FlistCUVCP(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.tbConstantYear.TextBoxValue), Convert.ToInt64(this.tbConstantMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                            this.dgExecConsUnitWithBudg.DataSource = listCUVCP;

                            /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR UNIDADES CONSTRCUTIVAS EJECUTADAS 
                             SIN PRESUPUESTOS*/
                            List<ContructionUnitsValue> listCUVNDCP = new List<ContructionUnitsValue>();

                            listCUVNDCP = BLLDBEX.FlistCUVNDCP(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.tbConstantYear.TextBoxValue), Convert.ToInt64(this.tbConstantMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                            this.dgExecConsUnitWithoutBudg.DataSource = listCUVNDCP;

                            /*Fin Unidades Constructiva agrupadas por Unidades Constructivas*/
                        }
                    }
                }
            }
            else
            {

                /*Unidades Constructiva agrupadas por localidad*/

                /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR LOCALIDAD EJECUTADAS 
                 CON PRESUPUESTOS*/
                List<ContructionUnitsLocationAmount> listCULEA = new List<ContructionUnitsLocationAmount>();

                listCULEA = BLLDBEX.FlistCULEA(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                this.dgExecConsUnitWithLocalBudg.DataSource = listCULEA;

                /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR LOCALIDAD EJECUTADAS 
                 SIN PRESUPUESTOS*/

                List<ContructionUnitsLocationAmount> listCULENDA = new List<ContructionUnitsLocationAmount>();

                listCULENDA = BLLDBEX.FlistCULENDA(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                this.dgConsUnitExecWithoutLocaBudg.DataSource = listCULENDA;

                /*Fin Unidades Constructiva agrupadas por localidad*/

                /*Unidades Constructiva agrupadas por Unidades Constructivas*/

                /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR LOCALIDAD EJECUTADAS 
                 CON PRESUPUESTOS*/
                List<ContructionUnitsAmount> listCUEA = new List<ContructionUnitsAmount>();

                listCUEA = BLLDBEX.FlistCUEA(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                this.dgExecConsUnitWithBudg.DataSource = listCUEA;

                /*UNIDADES CONSTRUCTIVAS AGRUPADAS POR LOCALIDAD EJECUTADAS 
                 SIN PRESUPUESTOS*/

                List<ContructionUnitsAmount> listCUENDA = new List<ContructionUnitsAmount>();

                listCUENDA = BLLDBEX.FlistCUENDA(Convert.ToInt64(this.tbInitialYear.TextBoxValue), Convert.ToInt64(this.tbInitialMonth.TextBoxValue), Convert.ToInt64(this.tbFinalYear.TextBoxValue), Convert.ToInt64(this.tbFinalMonth.TextBoxValue), Convert.ToInt64(this.cbRelevantMarket.Value));

                this.dgExecConsUnitWithoutBudg.DataSource = listCUENDA;

                /*Fin Unidades Constructiva agrupadas por Unidades Constructivas*/
            }
        }

        private void setLayoutGrid()
        {

            Double nuSubTotal;
            Double nuEjecutado;
            Double nuPresupuestado;
            String sbSubTotal;
            String NewLine = char.ConvertFromUtf32(13) + char.ConvertFromUtf32(10);

            Refresh();

            /*dgExecConsUnitWithLocalBudg*/
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries.Clear();
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["GeograpLocationId"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].Format = "#,##0.00";
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].Hidden = true;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].Format = "#,##0.00";
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].Hidden = true;

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Executed"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Executed"].Width = 120;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Executed"].Format = "#,##0.00";
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Executed"]);
            //*
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace; //Color.Black;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Executed"].Header.Caption;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "{0:N}";
            //*/

            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Budget"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Budget"].Width = 120;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Budget"].Format = "#,##0.00";
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Budget"]);
            //*
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[1].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace; //.Color.Black;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[1].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[1].Appearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Budget"].Header.Caption;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[1].DisplayFormat = "{0:N}";
            //*/

            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Difference"].Width = 120;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00";
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Difference"]);
            //*
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[2].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace; //.Color.Black;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[2].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[2].Appearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Difference"].Header.Caption;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[2].DisplayFormat = "{0:N}";
            //*/

            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Percentage"].Width = 120;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";
            //*  
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Columns["Percentage"]);
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[3].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace; //.Color.Black;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[3].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[3].Appearance.TextHAlign = HAlign.Right;
            //* Determinar la variacion
            nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithLocalBudg.DisplayLayout.Rows.SummaryValues[0].Value);
            nuEjecutado = nuSubTotal;
            nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithLocalBudg.DisplayLayout.Rows.SummaryValues[1].Value);
            nuPresupuestado = nuSubTotal;
            nuSubTotal = 0;
            if (nuPresupuestado > 0)
            {
                nuSubTotal = (nuEjecutado * 100) / nuPresupuestado;
            }
            //*/

            sbSubTotal = "Subtotal Ejecutado: [" + Convert.ToString(String.Format("{0,-25:#,##0.00}", nuEjecutado));
            sbSubTotal = sbSubTotal + "] Subtotal Presupuestado: [" + Convert.ToString(String.Format("{0,-25:#,##0.00}", nuPresupuestado));
            sbSubTotal = sbSubTotal + "] Subtotal Variación: " + Convert.ToString(String.Format("{0:#,##0.00}", nuSubTotal));
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].SummaryFooterCaption = sbSubTotal;// this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Percentage"].Header.Caption;
            this.dgExecConsUnitWithLocalBudg.DisplayLayout.Bands[0].Summaries[3].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            /*Fin dgExecConsUnitWithLocalBudg*/

            /*dgExecConsUnitWithLocalBudg*/
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries.Clear();
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["GeograpLocationId"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].Format = "#,##0.00";
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].Hidden = true;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].Format = "#,##0.00";
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].Hidden = true;

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Executed"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Executed"].Width = 120;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Executed"].Format = "#,##0.00";
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Executed"]);
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace;//.Color.Black;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Executed"].Header.Caption;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "{0:N}";

            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Budget"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Budget"].Width = 120;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Budget"].Format = "#,##0.00";
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Budget"]);
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[1].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace;//.Color.Black;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[1].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[1].Appearance.TextHAlign = HAlign.Right;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Budget"].Header.Caption;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[1].DisplayFormat = "{0:N}";

            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Difference"].Width = 120;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00";
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Difference"]);
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[2].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace;//.Color.Black;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[2].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[2].Appearance.TextHAlign = HAlign.Right;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Difference"].Header.Caption;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[2].DisplayFormat = "{0:N}";

            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Percentage"].Width = 120;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";
            //*
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Percentage"]);
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[3].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace; //.Color.Black;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[3].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[3].Appearance.TextHAlign = HAlign.Right;
            nuSubTotal = Convert.ToDouble(this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Rows.SummaryValues[0].Value);
            nuEjecutado = nuSubTotal;
            nuSubTotal = Convert.ToDouble(this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Rows.SummaryValues[1].Value);
            nuPresupuestado = nuSubTotal;
            nuSubTotal = 0;
            if (nuPresupuestado > 0)
            {
                nuSubTotal = (nuEjecutado * 100) / nuPresupuestado;
            }
            sbSubTotal = "Subtotal Ejecutado: [" + Convert.ToString(String.Format("{0,-25:#,##0.00}", nuEjecutado));
            sbSubTotal = sbSubTotal + "] Subtotal Presupuestado: [" + Convert.ToString(String.Format("{0,-25:#,##0.00}", nuPresupuestado));
            sbSubTotal = sbSubTotal + "] Subtotal Variación: " + Convert.ToString(String.Format("{0:#,##0.00}", nuSubTotal));
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].SummaryFooterCaption = sbSubTotal;// "SubTotal";// this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Columns["Percentage"].Header.Caption;
            this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Bands[0].Summaries[3].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            /*Total de unidades constrcutivas por localidad*/
            nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithLocalBudg.DisplayLayout.Rows.SummaryValues[0].Value) + Convert.ToDouble(this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Rows.SummaryValues[0].Value);
            nuEjecutado = nuSubTotal;
            this.tbTotalExecutedConUniLoc.TextBoxValue = nuSubTotal.ToString("#,##0.00"); //Convert.ToString(nuSubTotal);
            nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithLocalBudg.DisplayLayout.Rows.SummaryValues[1].Value) + Convert.ToDouble(this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Rows.SummaryValues[1].Value);
            nuPresupuestado = nuSubTotal;
            this.tbTotalBudgetConUniLoc.TextBoxValue = nuSubTotal.ToString("#,##0.00");
            nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithLocalBudg.DisplayLayout.Rows.SummaryValues[2].Value) + Convert.ToDouble(this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Rows.SummaryValues[2].Value);
            this.tbTotalDifferenceConUniLoc.TextBoxValue = nuSubTotal.ToString("#,##0.00");
            //nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithLocalBudg.DisplayLayout.Rows.SummaryValues[3].Value) + Convert.ToDouble(this.dgConsUnitExecWithoutLocaBudg.DisplayLayout.Rows.SummaryValues[3].Value);
            nuSubTotal = 0;
            if (nuPresupuestado > 0)
            {
                nuSubTotal = (nuEjecutado * 100) / nuPresupuestado;
            }
            this.tbTotalPercentageConUniLoc.TextBoxValue = nuSubTotal.ToString("#,##0.00");
            /*Fin Total de unidades constrcutivas por localidad*/


            /*Fin dgConsUnitExecWithoutLocaBudg*/

            /*dgExecConsUnitWithBudg*/
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries.Clear();
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["ConstructUnitId"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].Format = "#,##0.00";
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].Format = "#,##0.00";

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Executed"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Executed"].Width = 120;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Executed"].Format = "#,##0.00";
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Executed"]);
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace; //.Color.Black;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Executed"].Header.Caption;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "{0:N}";

            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Budget"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Budget"].Width = 120;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Budget"].Format = "#,##0.00";
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Budget"]);
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[1].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace; //.Color.Black;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[1].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[1].Appearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Budget"].Header.Caption;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[1].DisplayFormat = "{0:N}";

            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Difference"].Width = 120;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00";
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Difference"]);
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[2].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace; //.Color.Black;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[2].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[2].Appearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Difference"].Header.Caption;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[2].DisplayFormat = "{0:N}";

            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Percentage"].Width = 120;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Percentage"]);
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[3].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace; //.Color.Black;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[3].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[3].Appearance.TextHAlign = HAlign.Right;
            nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithBudg.DisplayLayout.Rows.SummaryValues[0].Value);
            nuEjecutado = nuSubTotal;
            nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithBudg.DisplayLayout.Rows.SummaryValues[1].Value);
            nuPresupuestado = nuSubTotal;
            nuSubTotal = 0;
            if (nuPresupuestado > 0)
            {
                nuSubTotal = (nuEjecutado * 100) / nuPresupuestado;
            }
            sbSubTotal = "Subtotal Ejecutado: [" + Convert.ToString(String.Format("{0,-25:#,##0.00}", nuEjecutado));
            sbSubTotal = sbSubTotal + "] Subtotal Presupuestado: [" + Convert.ToString(String.Format("{0,-25:#,##0.00}", nuPresupuestado));
            sbSubTotal = sbSubTotal + "] Subtotal Variación: " + Convert.ToString(String.Format("{0:#,##0.00}", nuSubTotal));
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].SummaryFooterCaption = sbSubTotal; // "SubTotal";// this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Columns["Percentage"].Header.Caption;
            this.dgExecConsUnitWithBudg.DisplayLayout.Bands[0].Summaries[3].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            /*Fin dgExecConsUnitWithBudg*/

            /*dgExecConsUnitWithoutBudg*/
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries.Clear();
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["ConstructUnitId"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].Format = "#,##0.00";
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].Format = "#,##0.00";

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Executed"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Executed"].Width = 120;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Executed"].Format = "#,##0.00";
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Executed"]);
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace; //.Color.Black;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Executed"].Header.Caption;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "{0:N}";

            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Budget"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Budget"].Width = 120;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Budget"].Format = "#,##0.00";
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Budget"]);
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[1].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace; //.Color.Black;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[1].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[1].Appearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Budget"].Header.Caption;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[1].DisplayFormat = "{0:N}";

            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Difference"].Width = 120;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00";
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Difference"]);
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[2].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace; //.Color.Black;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[2].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[2].Appearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Difference"].Header.Caption;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[2].DisplayFormat = "{0:N}";

            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Percentage"].Width = 120;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Percentage"]);
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[3].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace; //.Color.Black;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[3].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[3].Appearance.TextHAlign = HAlign.Right;
            nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithoutBudg.DisplayLayout.Rows.SummaryValues[0].Value);
            nuEjecutado = nuSubTotal;
            nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithoutBudg.DisplayLayout.Rows.SummaryValues[1].Value);
            nuPresupuestado = nuSubTotal;
            nuSubTotal = 0;
            if (nuPresupuestado > 0)
            {
                nuSubTotal = (nuEjecutado * 100) / nuPresupuestado;
            }
            sbSubTotal = "Subtotal Ejecutado: [" + Convert.ToString(String.Format("{0,-25:#,##0.00}", nuEjecutado));
            sbSubTotal = sbSubTotal + "] Subtotal Presupuestado: [" + Convert.ToString(String.Format("{0,-25:#,##0.00}", nuPresupuestado));
            sbSubTotal = sbSubTotal + "] Subtotal Variación: " + Convert.ToString(String.Format("{0:#,##0.00}", nuSubTotal));
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].SummaryFooterCaption = sbSubTotal; //"SubTotal";// this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Columns["Percentage"].Header.Caption;
            this.dgExecConsUnitWithoutBudg.DisplayLayout.Bands[0].Summaries[3].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            /*Total de unidades constrcutivas por localidad*/
            nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithBudg.DisplayLayout.Rows.SummaryValues[0].Value) + Convert.ToDouble(this.dgExecConsUnitWithoutBudg.DisplayLayout.Rows.SummaryValues[0].Value);
            nuEjecutado = nuSubTotal;
            this.tbTotalExecutedConUni.TextBoxValue = nuSubTotal.ToString("#,##0.00");
            nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithBudg.DisplayLayout.Rows.SummaryValues[1].Value) + Convert.ToDouble(this.dgExecConsUnitWithoutBudg.DisplayLayout.Rows.SummaryValues[1].Value);
            nuPresupuestado = nuSubTotal;
            this.tbTotalBudgetConUni.TextBoxValue = nuSubTotal.ToString("#,##0.00");
            nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithBudg.DisplayLayout.Rows.SummaryValues[2].Value) + Convert.ToDouble(this.dgExecConsUnitWithoutBudg.DisplayLayout.Rows.SummaryValues[2].Value);
            this.tbTotalDifferenceConUni.TextBoxValue = nuSubTotal.ToString("#,##0.00");
            //nuSubTotal = Convert.ToDouble(this.dgExecConsUnitWithBudg.DisplayLayout.Rows.SummaryValues[3].Value) + Convert.ToDouble(this.dgExecConsUnitWithoutBudg.DisplayLayout.Rows.SummaryValues[3].Value);
            nuSubTotal = 0;
            if (nuPresupuestado > 0)
            {
                nuSubTotal = (nuEjecutado * 100) / nuPresupuestado;
            }
            this.tbTotalPercentageConUni.TextBoxValue = nuSubTotal.ToString("#,##0.00");
            /*Fin Total de unidades constrcutivas por localidad*/


            /*Fin dgExecConsUnitWithoutBudg*/


            /*dgGasDemand*/
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries.Clear();
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["CateCodi"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["SucaCodi"].CellAppearance.TextHAlign = HAlign.Right;

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["ExecutedAmount"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["ExecutedAmount"].Width = 120;
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["ExecutedAmount"].Format = "#,##0.00";
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgGasDemand.DisplayLayout.Bands[0].Columns["ExecutedAmount"]);
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace;//.Color.Black;
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            this.dgGasDemand.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgGasDemand.DisplayLayout.Bands[0].Columns["ExecutedAmount"].Header.Caption;
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["BudgetAmount"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["BudgetAmount"].Width = 120;
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["BudgetAmount"].Format = "#,##0.00";
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgGasDemand.DisplayLayout.Bands[0].Columns["BudgetAmount"]);
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[1].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace;//.Color.Black;
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[1].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[1].Appearance.TextHAlign = HAlign.Right;
            this.dgGasDemand.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgGasDemand.DisplayLayout.Bands[0].Columns["BudgetAmount"].Header.Caption;
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[1].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["Difference"].Width = 120;
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00";
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgGasDemand.DisplayLayout.Bands[0].Columns["Difference"]);
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[2].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace;//.Color.Black;
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[2].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[2].Appearance.TextHAlign = HAlign.Right;
            this.dgGasDemand.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgGasDemand.DisplayLayout.Bands[0].Columns["Difference"].Header.Caption;
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[2].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["Percentage"].Width = 120;
            this.dgGasDemand.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgGasDemand.DisplayLayout.Bands[0].Columns["Percentage"]);
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[3].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace;//.Color.Black;
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[3].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[3].Appearance.TextHAlign = HAlign.Right;
            nuSubTotal = Convert.ToDouble(this.dgGasDemand.DisplayLayout.Rows.SummaryValues[0].Value);
            nuEjecutado = nuSubTotal;
            nuSubTotal = Convert.ToDouble(this.dgGasDemand.DisplayLayout.Rows.SummaryValues[1].Value);
            nuPresupuestado = nuSubTotal;
            nuSubTotal = 0;
            if (nuPresupuestado > 0)
            {
                nuSubTotal = (nuEjecutado * 100) / nuPresupuestado;
            }
            sbSubTotal = "Total Ejecutado: [" + Convert.ToString(String.Format("{0,-25:#,##0.00}", nuEjecutado));
            sbSubTotal = sbSubTotal + "] Total Presupuestado: [" + Convert.ToString(String.Format("{0,-25:#,##0.00}", nuPresupuestado));
            sbSubTotal = sbSubTotal + "] Total Variación: " + Convert.ToString(String.Format("{0:#,##0.00}", nuSubTotal));
            this.dgGasDemand.DisplayLayout.Bands[0].SummaryFooterCaption = sbSubTotal; // "Total";//this.dgGasDemand.DisplayLayout.Bands[0].Columns["Percentage"].Header.Caption;
            this.dgGasDemand.DisplayLayout.Bands[0].Summaries[3].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            /*Fin dgGasDemand*/

            /*dgGasService*/
            this.dgGasService.DisplayLayout.Bands[0].Summaries.Clear();
            this.dgGasService.DisplayLayout.Bands[0].Columns["CateCodi"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgGasService.DisplayLayout.Bands[0].Columns["SucaCodi"].CellAppearance.TextHAlign = HAlign.Right;

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            this.dgGasService.DisplayLayout.Bands[0].Columns["ExecutedAmount"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgGasService.DisplayLayout.Bands[0].Columns["ExecutedAmount"].Width = 120;
            this.dgGasService.DisplayLayout.Bands[0].Columns["ExecutedAmount"].Format = "#,##0.00";
            this.dgGasService.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgGasService.DisplayLayout.Bands[0].Columns["ExecutedAmount"]);
            this.dgGasService.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace;//.Color.Black;
            this.dgGasService.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgGasService.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            this.dgGasService.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgGasService.DisplayLayout.Bands[0].Columns["ExecutedAmount"].Header.Caption;
            this.dgGasService.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            this.dgGasService.DisplayLayout.Bands[0].Columns["BudgetAmount"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgGasService.DisplayLayout.Bands[0].Columns["BudgetAmount"].Width = 120;
            this.dgGasService.DisplayLayout.Bands[0].Columns["BudgetAmount"].Format = "#,##0.00";
            this.dgGasService.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgGasService.DisplayLayout.Bands[0].Columns["BudgetAmount"]);
            this.dgGasService.DisplayLayout.Bands[0].Summaries[1].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace;//.Color.Black;
            this.dgGasService.DisplayLayout.Bands[0].Summaries[1].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgGasService.DisplayLayout.Bands[0].Summaries[1].Appearance.TextHAlign = HAlign.Right;
            this.dgGasService.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgGasService.DisplayLayout.Bands[0].Columns["BudgetAmount"].Header.Caption;
            this.dgGasService.DisplayLayout.Bands[0].Summaries[1].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            this.dgGasService.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgGasService.DisplayLayout.Bands[0].Columns["Difference"].Width = 120;
            this.dgGasService.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00";
            this.dgGasService.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgGasService.DisplayLayout.Bands[0].Columns["Difference"]);
            this.dgGasService.DisplayLayout.Bands[0].Summaries[2].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace;//.Color.Black;
            this.dgGasService.DisplayLayout.Bands[0].Summaries[2].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgGasService.DisplayLayout.Bands[0].Summaries[2].Appearance.TextHAlign = HAlign.Right;
            this.dgGasService.DisplayLayout.Bands[0].SummaryFooterCaption = this.dgGasService.DisplayLayout.Bands[0].Columns["Difference"].Header.Caption;
            this.dgGasService.DisplayLayout.Bands[0].Summaries[2].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            this.dgGasService.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
            this.dgGasService.DisplayLayout.Bands[0].Columns["Percentage"].Width = 120;
            this.dgGasService.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";
            this.dgGasService.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, this.dgGasService.DisplayLayout.Bands[0].Columns["Percentage"]);
            this.dgGasService.DisplayLayout.Bands[0].Summaries[3].Appearance.ForeColor = System.Drawing.SystemColors.ButtonFace;//.Color.Black;
            this.dgGasService.DisplayLayout.Bands[0].Summaries[3].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.dgGasService.DisplayLayout.Bands[0].Summaries[3].Appearance.TextHAlign = HAlign.Right;
            nuSubTotal = Convert.ToDouble(this.dgGasService.DisplayLayout.Rows.SummaryValues[0].Value);
            nuEjecutado = nuSubTotal;
            nuSubTotal = Convert.ToDouble(this.dgGasService.DisplayLayout.Rows.SummaryValues[1].Value);
            nuPresupuestado = nuSubTotal;
            nuSubTotal = 0;
            if (nuPresupuestado > 0)
            {
                nuSubTotal = (nuEjecutado * 100) / nuPresupuestado;
            }
            sbSubTotal = "Total Ejecutado: [" + Convert.ToString(String.Format("{0,-25:#,##0.00}", nuEjecutado));
            sbSubTotal = sbSubTotal + "] Total Presupuestado: [" + Convert.ToString(String.Format("{0,-25:#,##0.00}", nuPresupuestado));
            sbSubTotal = sbSubTotal + "] Total Variación: " + Convert.ToString(String.Format("{0:#,##0.00}", nuSubTotal));
            this.dgGasService.DisplayLayout.Bands[0].SummaryFooterCaption = sbSubTotal; // "Total";// this.dgGasService.DisplayLayout.Bands[0].Columns["Percentage"].Header.Caption;
            this.dgGasService.DisplayLayout.Bands[0].Summaries[3].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            /*Fin dgGasService*/

            Refresh();
        }

        private void cbRelevantMarket_ValueChanged(object sender, EventArgs e)
        {
            nuBaseYear = Convert.ToString(DALLDBEX.FsbRelMarkRateBaseYear(Convert.ToInt64(this.cbRelevantMarket.Value)));

            if (Convert.ToInt64(nuBaseYear) != -1)
            {
                this.tbYearBase.TextBoxValue = nuBaseYear.Substring(0, 4);

                this.tbMonthBase.TextBoxValue = nuBaseYear.Substring(4, 2);
            }
            else
            {
                this.tbYearBase.TextBoxValue = null;
                this.tbMonthBase.TextBoxValue = null;
            }

            if (String.IsNullOrEmpty(this.cbRelevantMarket.Text) == false)
            {
                weights();
                DemandServiceExpenses();
                opInformation.Visible = true;
                setLayoutGrid();
            }
        }

        /*Mostrar cual es la fila seleccionada de cada grilla*/
        private void dgExecConsUnitWithLocalBudg_AfterCellActivate(object sender, EventArgs e)
        {
            lblSelected.Text = dgExecConsUnitWithLocalBudg.Rows[int.Parse(dgExecConsUnitWithLocalBudg.ActiveCell.Row.VisibleIndex.ToString())].Cells[1].Value.ToString().ToUpper();
            sbLblSelected = lblSelected.Text;
        }
        private void dgConsUnitExecWithoutLocaBudg_AfterCellActivate(object sender, EventArgs e)
        {
            lblSelected.Text = dgConsUnitExecWithoutLocaBudg.Rows[int.Parse(dgConsUnitExecWithoutLocaBudg.ActiveCell.Row.VisibleIndex.ToString())].Cells[1].Value.ToString().ToUpper();
            sbLblSelected = lblSelected.Text;
        }
        private void dgExecConsUnitWithBudg_AfterCellActivate(object sender, EventArgs e)
        {
            lblSelected.Text = dgExecConsUnitWithBudg.Rows[int.Parse(dgExecConsUnitWithBudg.ActiveCell.Row.VisibleIndex.ToString())].Cells[1].Value.ToString().ToUpper();
            sbLblSelected = lblSelected.Text;
        }
        private void dgExecConsUnitWithoutBudg_AfterCellActivate(object sender, EventArgs e)
        {
            lblSelected.Text = dgExecConsUnitWithoutBudg.Rows[int.Parse(dgExecConsUnitWithoutBudg.ActiveCell.Row.VisibleIndex.ToString())].Cells[1].Value.ToString().ToUpper();
            sbLblSelected = lblSelected.Text;
        }
        private void dgGasDemand_AfterCellActivate(object sender, EventArgs e)
        {
            sbLblCategory = dgGasDemand.Rows[int.Parse(dgGasDemand.ActiveCell.Row.VisibleIndex.ToString())].Cells[1].Value.ToString().ToUpper();
            sbLblSubCategory = dgGasDemand.Rows[int.Parse(dgGasDemand.ActiveCell.Row.VisibleIndex.ToString())].Cells[3].Value.ToString().ToUpper();
        }
        private void dgGasService_AfterCellActivate(object sender, EventArgs e)
        {
            sbLblCategory = dgGasService.Rows[int.Parse(dgGasService.ActiveCell.Row.VisibleIndex.ToString())].Cells[1].Value.ToString().ToUpper();
            sbLblSubCategory = dgGasService.Rows[int.Parse(dgGasService.ActiveCell.Row.VisibleIndex.ToString())].Cells[3].Value.ToString().ToUpper();
        }

        /*Fin mostrar cual es la fila seleccionada de cada grilla*/

        /*Validacion de Año y Mes*/

        private void tbInitialYear_Validating(object sender, CancelEventArgs e)
        {
            if (this.tbInitialYear.TextBoxValue == null)
            {
                MessageBox.Show("Digite Año Inicial.", "Año Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.tbInitialYear.Focus();
            }
            else
            {
                if (String.IsNullOrEmpty(this.tbInitialYear.TextBoxValue.ToString()))
                {
                    MessageBox.Show("Digite Año Inicial.", "Año Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.tbInitialYear.Focus();
                }
                else
                {
                    if (Convert.ToInt64(this.tbInitialYear.TextBoxValue) > Convert.ToInt64(DateTime.Now.Year.ToString()))
                    {
                        MessageBox.Show("Año Inicial no debe ser mayor al Año Actual.", "Año Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.tbInitialYear.TextBoxValue = null;
                        this.tbInitialYear.Focus();
                    }
                    else
                    {
                        if (String.IsNullOrEmpty(this.tbFinalYear.TextBoxValue) == false)
                        {
                            if (Convert.ToInt64(this.tbInitialYear.TextBoxValue) > Convert.ToInt64(this.tbFinalYear.TextBoxValue))
                            {
                                MessageBox.Show("Año Inicial no debe ser mayor al Año Final.", "Año Inicial - Año Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                this.tbInitialYear.TextBoxValue = null;
                                this.tbInitialYear.Focus();
                            }
                        }
                        else
                        {
                            //setLayoutGrid(); 
                        }
                    }
                }
            }
        }

        private void tbFinalYear_Validating(object sender, CancelEventArgs e)
        {
            if (this.tbFinalYear.TextBoxValue == null)
            {
                MessageBox.Show("Digite Año Final.", "Año Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.tbFinalYear.Focus();
            }
            else
            {
                if (String.IsNullOrEmpty(this.tbFinalYear.TextBoxValue.ToString()))
                {
                    MessageBox.Show("Digite Año Final.", "Año Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.tbFinalYear.Focus();
                }
                else
                {
                    if (Convert.ToInt64(this.tbFinalYear.TextBoxValue) > Convert.ToInt64(DateTime.Now.Year.ToString()))
                    {
                        MessageBox.Show("Año Final no debe ser mayor al Año Actual.", "Año Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.tbFinalYear.TextBoxValue = null;
                        this.tbFinalYear.Focus();
                    }
                    else
                    {
                        if (String.IsNullOrEmpty(this.tbInitialYear.TextBoxValue) == false)
                        {

                            if (Convert.ToInt64(this.tbFinalYear.TextBoxValue) < Convert.ToInt64(this.tbInitialYear.TextBoxValue))
                            {
                                MessageBox.Show("Año Final no debe ser menor al Año Inicial.", "Año Inicial - Año Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                this.tbFinalYear.TextBoxValue = null;
                                this.tbFinalYear.Focus();
                            }
                        }
                        else
                        {
                            //setLayoutGrid(); 
                        }

                    }
                }
            }
        }

        private void tbInitialMonth_Validating(object sender, CancelEventArgs e)
        {
            if (this.tbInitialMonth.TextBoxValue == null)
            {
                MessageBox.Show("Digite Mes Inicial.", "Mes Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.tbInitialMonth.Focus();
            }
            else
            {
                if (String.IsNullOrEmpty(this.tbInitialMonth.TextBoxValue.ToString()))
                {
                    MessageBox.Show("Digite Mes Inicial.", "Mes Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.tbInitialMonth.Focus();
                }
                else
                {
                    if (Convert.ToInt64(this.tbInitialMonth.TextBoxValue) < 1 || Convert.ToInt64(this.tbInitialMonth.TextBoxValue) > 12)
                    {
                        MessageBox.Show("Digite Mes Valido.", "Mes Inicial", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.tbInitialMonth.TextBoxValue = null;
                        this.tbInitialMonth.Focus();
                    }
                    else
                    {
                        if (String.IsNullOrEmpty(this.tbFinalMonth.TextBoxValue) == false)
                        {
                            if (Convert.ToInt64(this.tbInitialMonth.TextBoxValue) > Convert.ToInt64(this.tbFinalMonth.TextBoxValue))
                            {
                                MessageBox.Show("Mes Inicial no debe ser mayor al Mes Final.", "Mes Inicial - Mes Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                this.tbInitialMonth.TextBoxValue = null;
                                this.tbInitialMonth.Focus();
                            }
                        }
                        else
                        {
                            //setLayoutGrid(); 
                        }
                    }
                }
            }
        }

        private void tbFinalMonth_Validating(object sender, CancelEventArgs e)
        {
            if (this.tbFinalMonth.TextBoxValue == null)
            {
                MessageBox.Show("Digite Mes Final.", "Mes Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.tbFinalMonth.Focus();
            }
            else
            {
                if (String.IsNullOrEmpty(this.tbFinalMonth.TextBoxValue.ToString()))
                {
                    MessageBox.Show("Digite Mes Final.", "Mes Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.tbFinalMonth.Focus();
                }
                else
                {
                    if (Convert.ToInt64(this.tbFinalMonth.TextBoxValue) < 1 || Convert.ToInt64(this.tbFinalMonth.TextBoxValue) > 12)
                    {
                        MessageBox.Show("Digite Mes Valido.", "Mes Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.tbFinalMonth.TextBoxValue = null;
                        this.tbFinalMonth.Focus();
                    }
                    else
                    {
                        if (String.IsNullOrEmpty(this.tbInitialMonth.TextBoxValue) == false)
                        {
                            if (Convert.ToInt64(this.tbFinalMonth.TextBoxValue) < Convert.ToInt64(this.tbInitialMonth.TextBoxValue))
                            {
                                MessageBox.Show("Mes Final no debe ser menor al Mes Inicial.", "Mes Inicial - Mes Final", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                this.tbFinalMonth.TextBoxValue = null;
                                this.tbFinalMonth.Focus();
                            }
                            else
                            {
                                weights();
                                //hvera
                                DemandServiceExpenses();
                                setLayoutGrid();
                                //MessageBox.Show("paseeeeeeeee.......");
                            }
                        }
                    }
                }
            }
        }

        private void tbConstantYear_Validating(object sender, CancelEventArgs e)
        {
            if (this.tbConstantYear.TextBoxValue == null)
            {
                MessageBox.Show("Digite Año Constante.", "Año Constante", MessageBoxButtons.OK, MessageBoxIcon.Information);
                //this.tbConstantYear.Focus();
            }
            else
            {
                if (String.IsNullOrEmpty(this.tbConstantYear.TextBoxValue.ToString()))
                {
                    MessageBox.Show("Digite Año Constante.", "Año Constante", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    //this.tbConstantYear.Focus();
                }
                else
                {
                    if (Convert.ToInt64(this.tbConstantYear.TextBoxValue) < 1)
                    {
                        MessageBox.Show("Año Constante no debe ser negativo.", "Año Constante", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.tbConstantYear.TextBoxValue = null;
                    }
                    else
                    {
                        if (Convert.ToInt64(this.tbConstantYear.TextBoxValue) > Convert.ToInt64(DateTime.Now.Year.ToString()))
                        {
                            MessageBox.Show("Año Constante no debe ser mayor al Año Actual.", "Año Constante", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            this.tbConstantYear.TextBoxValue = null;
                            //this.tbConstantYear.Focus();
                        }
                        else
                        {
                            this.rdbTypeWeights.CheckedIndex = 2;

                            weights();
                            //hvera
                            DemandServiceExpenses();
                            setLayoutGrid();
                        }
                    }
                }
            }
        }

        private void tbConstantMonth_Validating(object sender, CancelEventArgs e)
        {
            if (this.tbConstantMonth.TextBoxValue == null)
            {
                MessageBox.Show("Digite Mes Constante.", "Mes Constante", MessageBoxButtons.OK, MessageBoxIcon.Information);
                //this.tbConstantMonth.Focus();
            }
            else
            {
                if (String.IsNullOrEmpty(this.tbConstantMonth.TextBoxValue.ToString()))
                {
                    MessageBox.Show("Digite Mes Constante.", "Mes Constante", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    //this.tbConstantMonth.Focus();
                }
                else
                {
                    if (Convert.ToInt64(this.tbConstantMonth.TextBoxValue) < 1 || Convert.ToInt64(this.tbConstantMonth.TextBoxValue) > 12)
                    {
                        MessageBox.Show("Digite Mes Valido.", "Mes Constante", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.tbConstantMonth.TextBoxValue = null;
                        //this.tbConstantMonth.Focus();
                    }
                    else
                    {
                        if (this.tbConstantYear.TextBoxValue == null)
                        {
                            MessageBox.Show("Digite Año Constante.", "Año Constante", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            //this.tbConstantYear.Focus();
                        }
                        else
                        {
                            if (String.IsNullOrEmpty(this.tbConstantYear.TextBoxValue.ToString()))
                            {
                                MessageBox.Show("Digite Año Constante.", "Año Constante", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                //this.tbConstantYear.Focus();
                            }
                            else
                            {
                                if (Convert.ToInt64(this.tbConstantYear.TextBoxValue) > Convert.ToInt64(DateTime.Now.Year.ToString()))
                                {
                                    MessageBox.Show("Año Constante no debe ser mayor al Año Actual.", "Año Constante", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                    this.tbConstantYear.TextBoxValue = null;
                                    //this.tbConstantYear.Focus();
                                }
                                else
                                {
                                    this.rdbTypeWeights.CheckedIndex = 2;

                                    weights();
                                    //hvera
                                    DemandServiceExpenses();
                                    setLayoutGrid();
                                    //MessageBox.Show("paseeeeeeeeeeeee.....");
                                }
                            }
                        }
                    }
                }
            }
        }

        private void tbFinalYear_Load(object sender, EventArgs e)
        {

        }

        private void cbRelevantMarket_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {

        }

        private void tbFinalMonth_Leave(object sender, EventArgs e)
        {
            //setLayoutGrid();
        }

        private void tbFinalMonth_Layout(object sender, LayoutEventArgs e)
        {
            //weights();
            //setLayoutGrid();
        }

        private void tbFinalMonth_Validated(object sender, EventArgs e)
        {
            weights();
            setLayoutGrid();
        }

        /*Fin Valiedacion de Año y Mes*/



    }
}