using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.CONSTRUCTIONUNITS.Controls;
using SINCECOMP.CONSTRUCTIONUNITS.Entity;
using SINCECOMP.CONSTRUCTIONUNITS.BL;
using SINCECOMP.CONSTRUCTIONUNITS.UI;
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;

namespace SINCECOMP.CONSTRUCTIONUNITS.UI
{
    public partial class LDBEX_DETAIL : OpenForm
    {

        String Forma;
        Int64 NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, NuRelevantMarket, NuGeograpLocationId, NuConUniBudgetId, NuCateCodi, NuSuCaCodi, NuGirdSeleccion;

        public LDBEX_DETAIL(String forma, Int64 nuInitialYear, Int64 nuInitialMonth, Int64 nuFinalYear, Int64 nuFinalMonth, Int64 nuRelevantMarket, Int64 nuGeograpLocationId, Int64 nuConUniBudgetId, Int64 nuCateCodi, Int64 nuSuCaCodi, Int64 nuGirdSeleccion)
        {
            InitializeComponent();
            Forma = forma;
            NuInitialYear = nuInitialYear;
            NuInitialMonth = nuInitialMonth;
            NuFinalYear = nuFinalYear;
            NuFinalMonth = nuFinalMonth;
            NuRelevantMarket = nuRelevantMarket;
            NuGeograpLocationId = nuGeograpLocationId;
            NuConUniBudgetId = nuConUniBudgetId;
            NuCateCodi = nuCateCodi;
            NuSuCaCodi = nuSuCaCodi;
            NuGirdSeleccion = nuGirdSeleccion;
        }

        private void btnBack_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void LDBEX_DETAIL_Load(object sender, EventArgs e)
        {
            switch (Forma)
            {
                case "DetailConsUnitValue":
                    {
                        this.Text = "Consulta Detallada por Valor";
                        if (NuGirdSeleccion == 1)
                        {
                            if (LDBEX.nurdbTypeWeights == 0)
                            {
                                /*Detalle de Unidades Constrcutivas ejecutadas consultadas por valor*/
                                List<ContructionUnitsValue> listCULDVCP = new List<ContructionUnitsValue>();

                                listCULDVCP = BLLDBEX.FlistCULDVCP(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, LDBEX.nuWeightsYear, LDBEX.nuWeightsMonth, NuGeograpLocationId, NuRelevantMarket);

                                DetailConsUnitValue oControl = new DetailConsUnitValue();

                                oControl.dgDetailValue.DataSource = listCULDVCP;

                                oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                oControl.Location = new Point(0, 0);
                                opPpal.Controls.Add(oControl);
                                setLayoutGridValue(oControl);
                            }
                            else
                            {
                                if (LDBEX.nurdbTypeWeights == 1)
                                {
                                    /*Detalle de Unidades Constrcutivas ejecutadas consultadas por valor*/
                                    List<ContructionUnitsValue> listCULDEV = new List<ContructionUnitsValue>();

                                    listCULDEV = BLLDBEX.FlistCULDEV(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, NuGeograpLocationId, NuRelevantMarket);

                                    DetailConsUnitValue oControl = new DetailConsUnitValue();

                                    oControl.dgDetailValue.DataSource = listCULDEV;

                                    oControl.lblSelected.Text = LDBEX.sbLblSelected;
                                    
                                    oControl.Location = new Point(0, 0);
                                    opPpal.Controls.Add(oControl);
                                    setLayoutGridValue(oControl);
                                }
                                else
                                {

                                    if (LDBEX.nurdbTypeWeights == 2)
                                    {
                                        /*Detalle de Unidades Constrcutivas ejecutadas consultadas por valor*/
                                        List<ContructionUnitsValue> listCULDVCP = new List<ContructionUnitsValue>();

                                        listCULDVCP = BLLDBEX.FlistCULDVCP(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, LDBEX.nuConstantYear, LDBEX.nuConstantMonth, NuGeograpLocationId, NuRelevantMarket);

                                        DetailConsUnitValue oControl = new DetailConsUnitValue();

                                        oControl.dgDetailValue.DataSource = listCULDVCP;

                                        oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                        oControl.Location = new Point(0, 0);
                                        opPpal.Controls.Add(oControl);
                                        setLayoutGridValue(oControl);
                                    }
                                }
                            }
                        }
                        else
                        {
                            if (NuGirdSeleccion == 2)
                            {
                                if (LDBEX.nurdbTypeWeights == 0)
                                {
                                    /*Detalle de Unidades Constrcutivas ejecutadas consultadas por valor*/
                                    List<ContructionUnitsValue> listCULDVNDCP = new List<ContructionUnitsValue>();

                                    listCULDVNDCP = BLLDBEX.FlistCULDVNDCP(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, LDBEX.nuWeightsYear, LDBEX.nuWeightsMonth, NuGeograpLocationId, NuRelevantMarket);

                                    DetailConsUnitValue oControl = new DetailConsUnitValue();

                                    oControl.dgDetailValue.DataSource = listCULDVNDCP;

                                    oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                    oControl.Location = new Point(0, 0);
                                    opPpal.Controls.Add(oControl);
                                    setLayoutGridValue(oControl);
                                }
                                else
                                {
                                    if (LDBEX.nurdbTypeWeights == 1)
                                    {/*Detalle de Unidades Constrcutivas ejecutadas consultadas por valor*/
                                        List<ContructionUnitsValue> listCULDENDV = new List<ContructionUnitsValue>();

                                        listCULDENDV = BLLDBEX.FlistCULDENDV(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, NuGeograpLocationId, NuRelevantMarket);

                                        DetailConsUnitValue oControl = new DetailConsUnitValue();

                                        oControl.dgDetailValue.DataSource = listCULDENDV;

                                        oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                        oControl.Location = new Point(0, 0);
                                        opPpal.Controls.Add(oControl);
                                        setLayoutGridValue(oControl);
                                    }
                                    else
                                    {

                                        if (LDBEX.nurdbTypeWeights == 2)
                                        {
                                            /*Detalle de Unidades Constrcutivas ejecutadas consultadas por valor*/
                                            List<ContructionUnitsLocationValue> listCULDVNDCP = new List<ContructionUnitsLocationValue>();

                                            listCULDVNDCP = BLLDBEX.FlistCUDVNDCP(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, LDBEX.nuConstantYear, LDBEX.nuConstantMonth, NuGeograpLocationId, NuRelevantMarket);

                                            DetailConsUnitValue oControl = new DetailConsUnitValue();

                                            oControl.dgDetailValue.DataSource = listCULDVNDCP;

                                            oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                            oControl.Location = new Point(0, 0);
                                            opPpal.Controls.Add(oControl);
                                            setLayoutGridValue(oControl);
                                        }
                                    }
                                }
                            }
                            else
                            {
                                if (NuGirdSeleccion == 3)
                                {

                                    if (LDBEX.nurdbTypeWeights == 0)
                                    {
                                        /*Detalle de Unidades Constrcutivas ejecutadas consultadas por valor*/
                                        List<ContructionUnitsLocationValue> listCUDVCP = new List<ContructionUnitsLocationValue>();

                                        listCUDVCP = BLLDBEX.FlistCUDVCP(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, LDBEX.nuWeightsYear, LDBEX.nuWeightsMonth, NuConUniBudgetId, NuRelevantMarket);

                                        DetailConsUnitValue oControl = new DetailConsUnitValue();

                                        oControl.dgDetailValue.DataSource = listCUDVCP;

                                        oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                        oControl.Location = new Point(0, 0);
                                        opPpal.Controls.Add(oControl);
                                        setLayoutGridValue(oControl);
                                    }
                                    else
                                    {
                                        if (LDBEX.nurdbTypeWeights == 1)
                                        {
                                            /*Detalle de localidades ejecutadas consultadas por valor*/
                                            List<ContructionUnitsLocationValue> listCUDEV = new List<ContructionUnitsLocationValue>();

                                            listCUDEV = BLLDBEX.FlistCUDEV(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, NuConUniBudgetId, NuRelevantMarket);

                                            DetailConsUnitValue oControl = new DetailConsUnitValue();

                                            oControl.dgDetailValue.DataSource = listCUDEV;

                                            oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                            oControl.Location = new Point(0, 0);
                                            opPpal.Controls.Add(oControl);
                                            setLayoutGridValue(oControl);
                                        }
                                        else
                                        {
                                            if (LDBEX.nurdbTypeWeights == 2)
                                            {
                                                /*Detalle de Unidades Constrcutivas ejecutadas consultadas por valor*/
                                                List<ContructionUnitsLocationValue> listCUDVCP = new List<ContructionUnitsLocationValue>();

                                                listCUDVCP = BLLDBEX.FlistCUDVCP(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, LDBEX.nuConstantYear, LDBEX.nuConstantMonth, NuConUniBudgetId, NuRelevantMarket);

                                                DetailConsUnitValue oControl = new DetailConsUnitValue();

                                                oControl.dgDetailValue.DataSource = listCUDVCP;

                                                oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                                oControl.Location = new Point(0, 0);
                                                opPpal.Controls.Add(oControl);
                                                setLayoutGridValue(oControl);
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    if (NuGirdSeleccion == 4)
                                    {

                                        if (LDBEX.nurdbTypeWeights == 0)
                                        {
                                            /*Detalle de Unidades Constrcutivas ejecutadas consultadas por valor*/
                                            List<ContructionUnitsLocationValue> listCUDVNDCP = new List<ContructionUnitsLocationValue>();

                                            listCUDVNDCP = BLLDBEX.FlistCUDVNDCP(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, LDBEX.nuWeightsYear, LDBEX.nuWeightsMonth, NuConUniBudgetId, NuRelevantMarket);
                                            DetailConsUnitValue oControl = new DetailConsUnitValue();

                                            oControl.dgDetailValue.DataSource = listCUDVNDCP;

                                            oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                            oControl.Location = new Point(0, 0);
                                            opPpal.Controls.Add(oControl);
                                            setLayoutGridValue(oControl);
                                        }
                                        else
                                        {
                                            if (LDBEX.nurdbTypeWeights == 1)
                                            {
                                                /*Detalle de localidades ejecutadas consultadas por valor*/
                                                List<ContructionUnitsLocationValue> listCUDENDV = new List<ContructionUnitsLocationValue>();

                                                listCUDENDV = BLLDBEX.FlistCUDENDV(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, NuConUniBudgetId, NuRelevantMarket);

                                                DetailConsUnitValue oControl = new DetailConsUnitValue();

                                                oControl.dgDetailValue.DataSource = listCUDENDV;

                                                oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                                oControl.Location = new Point(0, 0);
                                                opPpal.Controls.Add(oControl);
                                                setLayoutGridValue(oControl);
                                            }
                                            else
                                            {
                                                if (LDBEX.nurdbTypeWeights == 2)
                                                {
                                                    /*Detalle de Unidades Constrcutivas ejecutadas consultadas por valor*/
                                                    List<ContructionUnitsLocationValue> listCUDVNDCP = new List<ContructionUnitsLocationValue>();

                                                    listCUDVNDCP = BLLDBEX.FlistCUDVNDCP(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, LDBEX.nuConstantYear, LDBEX.nuConstantMonth, NuConUniBudgetId, NuRelevantMarket);
                                                    DetailConsUnitValue oControl = new DetailConsUnitValue();

                                                    oControl.dgDetailValue.DataSource = listCUDVNDCP;

                                                    oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                                    oControl.Location = new Point(0, 0);
                                                    opPpal.Controls.Add(oControl);
                                                    setLayoutGridValue(oControl);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }                        
                    }
                    break;
                case "DetailConsUnitAmount":
                    {
                        this.Text = "Consulta Detallada por Cantidad";
                        if (NuGirdSeleccion == 1)
                        {
                            /*Detalle de Unidades Constrcutivas ejecutadas consultadas por cantidad*/
                            List<ContructionUnitsAmount> listCULDEA = new List<ContructionUnitsAmount>();

                            listCULDEA = BLLDBEX.FlistCULDEA(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, NuGeograpLocationId, NuRelevantMarket);

                            DetailConsUnitAmount oControl = new DetailConsUnitAmount();

                            oControl.dgDetailAmount.DataSource = listCULDEA;

                            oControl.lblSelected.Text = LDBEX.sbLblSelected;

                            oControl.Location = new Point(0, 0);
                            opPpal.Controls.Add(oControl);
                            setLayoutGridAmount(oControl);
                        }
                        else
                        {
                            if (NuGirdSeleccion == 2)
                            {
                                /*Detalle de Unidades Constrcutivas ejecutadas consultadas por cantidad*/
                                List<ContructionUnitsAmount> listCULDENDA = new List<ContructionUnitsAmount>();

                                listCULDENDA = BLLDBEX.FlistCULDENDA(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, NuGeograpLocationId, NuRelevantMarket);

                                DetailConsUnitAmount oControl = new DetailConsUnitAmount();

                                oControl.dgDetailAmount.DataSource = listCULDENDA;

                                oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                oControl.Location = new Point(0, 0);
                                opPpal.Controls.Add(oControl);
                                setLayoutGridAmount(oControl);
                            }
                            else
                            {
                                if (NuGirdSeleccion == 3)
                                {
                                    /*Detalle de Unidades Constrcutivas ejecutadas consultadas por valor*/
                                    List<ContructionUnitsLocationAmount> listCUDEA = new List<ContructionUnitsLocationAmount>();

                                    listCUDEA = BLLDBEX.FlistCUDEA(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, NuConUniBudgetId, NuRelevantMarket);

                                    DetailConsUnitAmount oControl = new DetailConsUnitAmount();

                                    oControl.dgDetailAmount.DataSource = listCUDEA;

                                    oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                    oControl.Location = new Point(0, 0);
                                    opPpal.Controls.Add(oControl);
                                    setLayoutGridAmount(oControl);
                                }
                                else
                                {
                                    if (NuGirdSeleccion == 4)
                                    {
                                        /*Detalle de Unidades Constrcutivas ejecutadas consultadas por valor no presupuestadas*/
                                        List<ContructionUnitsLocationAmount> listCUDENDA = new List<ContructionUnitsLocationAmount>();

                                        listCUDENDA = BLLDBEX.FlistCUDENDA(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, NuConUniBudgetId, NuRelevantMarket);

                                        DetailConsUnitAmount oControl = new DetailConsUnitAmount();

                                        oControl.dgDetailAmount.DataSource = listCUDENDA;

                                        oControl.lblSelected.Text = LDBEX.sbLblSelected;

                                        oControl.Location = new Point(0, 0);
                                        opPpal.Controls.Add(oControl);
                                        setLayoutGridAmount(oControl);
                                    }
                                }
                            }
                        }
                    }
                    break;
                case "gasdemand":
                    {
                        this.Text = "Demanda de Gas";
                        /*Detalle Demanda de Gas*/
                        List<GasDemandServiceDetails> listGDDE = new List<GasDemandServiceDetails>();

                        listGDDE = BLLDBEX.FlistGDDE(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, NuRelevantMarket, NuCateCodi, NuSuCaCodi);

                        GasDemandServiceDetail oControl = new GasDemandServiceDetail("Demanda de Gas");

                        oControl.dgDemansServiceDetail.DataSource = listGDDE;

                        oControl.lblCategory.Text = LDBEX.sbLblCategory.ToUpper();
                        oControl.lblSubCategory.Text = LDBEX.sbLblSubCategory.ToUpper();

                        oControl.Location = new Point(0, 0);
                        opPpal.Controls.Add(oControl);
                        setLayoutGridDemandService(oControl);
                    }
                    break;
                case "gasservice":
                    {
                        this.Text = "Servicio de Gas";
                        /*Detalle Servicio de Gas*/
                        List<GasDemandServiceDetails> listGSDE = new List<GasDemandServiceDetails>();

                        //MessageBox.Show(" AÑO INI " + NuInitialYear + " - MES INI " + NuInitialMonth + " - AÑO FIN " + NuFinalYear + " - MES FIN " + NuFinalMonth + " - MER. REL. " + NuRelevantMarket + " - CATECODI " + NuCateCodi + " - SUCACODI " + NuSuCaCodi);

                        listGSDE = BLLDBEX.FlistGSDE(NuInitialYear, NuInitialMonth, NuFinalYear, NuFinalMonth, NuRelevantMarket, NuCateCodi, NuSuCaCodi);

                        GasDemandServiceDetail oControl = new GasDemandServiceDetail("Servicio de Gas");

                        oControl.dgDemansServiceDetail.DataSource = listGSDE;

                        oControl.lblCategory.Text = LDBEX.sbLblCategory.ToUpper();
                        oControl.lblSubCategory.Text = LDBEX.sbLblSubCategory.ToUpper();

                        oControl.Location = new Point(0, 0);
                        opPpal.Controls.Add(oControl);
                        setLayoutGridDemandService(oControl);
                    }
                    break;
            }
        }

        private void setLayoutGridValue(DetailConsUnitValue oControl)
        {

            //Double nuSubTotal;

            /*dgDetailValue*/
            
            if (NuGirdSeleccion == 1 || NuGirdSeleccion == 2)
            {
                oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["ConstructUnitId"].CellAppearance.TextHAlign = HAlign.Right;
                oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].CellAppearance.TextHAlign = HAlign.Right;
                oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].Format = "#,##0.00";
                oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].CellAppearance.TextHAlign = HAlign.Right;
                oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].Format = "#,##0.00";
            }
            else
            {
                oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["GeograpLocationId"].CellAppearance.TextHAlign = HAlign.Right;
                oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].Hidden = true;
                oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].Hidden = true;
            }

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Executed"].CellAppearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Executed"].Width = 120;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Executed"].Format = "#,##0.00";
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Executed"]);
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.Color.Black;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].SummaryFooterCaption = oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Executed"].Header.Caption;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "{0:N}";

            //oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Budget"].CellAppearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Budget"].Width = 120;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Budget"].Format = "#,##0.00";
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Budget"]);
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[1].Appearance.ForeColor = System.Drawing.Color.Black;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[1].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[1].Appearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].SummaryFooterCaption = oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Budget"].Header.Caption;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[1].DisplayFormat = "{0:N}";

            //oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Difference"].Width = 120;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00";
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Difference"]);
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[2].Appearance.ForeColor = System.Drawing.Color.Black;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[2].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[2].Appearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].SummaryFooterCaption = oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Difference"].Header.Caption;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[2].DisplayFormat = "{0:N}";

            //oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Percentage"].Width = 120;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, oControl.dgDetailValue.DisplayLayout.Bands[0].Columns["Percentage"]);
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[3].Appearance.ForeColor = System.Drawing.Color.Black;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[3].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[3].Appearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].SummaryFooterCaption = "Total";//this.dgDetailValue.DisplayLayout.Bands[0].Columns["Percentage"].Header.Caption;
            //oControl.dgDetailValue.DisplayLayout.Bands[0].Summaries[3].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
        }

        private void setLayoutGridAmount(DetailConsUnitAmount oControl)
        {
            ////Double nuSubTotal;

            ///*dgDetailAmount*/
            ////oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries.Clear();
            if (NuGirdSeleccion == 1 || NuGirdSeleccion == 2)
            {
                oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["ConstructUnitId"].CellAppearance.TextHAlign = HAlign.Right;
                oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].CellAppearance.TextHAlign = HAlign.Right;
                oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].Format = "#,##0.00";
                oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].CellAppearance.TextHAlign = HAlign.Right;
                oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].Format = "#,##0.00";
            }
            else
            {
                oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["GeograpLocationId"].CellAppearance.TextHAlign = HAlign.Right;
                oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["ExecutedUnitCost"].Hidden = true;
                oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["BudgetUnitCost"].Hidden = true;
            }

            ///*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Executed"].CellAppearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Executed"].Width = 120;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Executed"].Format = "#,##0.00";
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Executed"]);
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.Color.Black;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].SummaryFooterCaption = oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Executed"].Header.Caption;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "{0:N}";

            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Budget"].CellAppearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Budget"].Width = 120;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Budget"].Format = "#,##0.00";
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Budget"]);
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[1].Appearance.ForeColor = System.Drawing.Color.Black;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[1].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[1].Appearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].SummaryFooterCaption = oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Budget"].Header.Caption;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[1].DisplayFormat = "{0:N}";

            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Difference"].Width = 120;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00";
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Difference"]);
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[2].Appearance.ForeColor = System.Drawing.Color.Black;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[2].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[2].Appearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].SummaryFooterCaption = oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Difference"].Header.Caption;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[2].DisplayFormat = "{0:N}";

            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Percentage"].Width = 120;
            //oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";            
            ////oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries.Add("Total_Percentage", "sum([Budget])/sum([Executed])*100");
            ////oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Percentage"]);
            ////oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Formula, oControl.dgDetailAmount.DisplayLayout.Bands[0].Columns["Percentage"], SummaryPosition.UseSummaryPositionColumn);
            ////oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[3].Formula = "sum( [Budget] )";
            ////oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[3].Appearance.ForeColor = System.Drawing.Color.Black;
            ////oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[3].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            ////oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[3].Appearance.TextHAlign = HAlign.Right;            
            ////oControl.dgDetailAmount.DisplayLayout.Bands[0].Summaries[3].DisplayFormat = "{0:N}";

            //oControl.dgDetailAmount.DisplayLayout.Bands[0].SummaryFooterCaption = "Total";//this.dgDetailAmount.DisplayLayout.Bands[0].Columns["Percentage"].Header.Caption;
            ///*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
        }

        private void setLayoutGridDemandService(GasDemandServiceDetail oControl)
        {

            //Double nuSubTotal;

            /*dgDemansServiceDetail*/
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries.Clear();
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["GeograpLocationId"].CellAppearance.TextHAlign = HAlign.Right;

            ///*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["ExecutedAmount"].CellAppearance.TextHAlign = HAlign.Right;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["ExecutedAmount"].Width = 120;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["ExecutedAmount"].Format = "#,##0.00";
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["ExecutedAmount"]);
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.Color.Black;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].SummaryFooterCaption = oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["ExecutedAmount"].Header.Caption;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "{0:N}";

            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["BudgetAmount"].CellAppearance.TextHAlign = HAlign.Right;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["BudgetAmount"].Width = 120;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["BudgetAmount"].Format = "#,##0.00";
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["BudgetAmount"]);
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[1].Appearance.ForeColor = System.Drawing.Color.Black;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[1].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[1].Appearance.TextHAlign = HAlign.Right;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].SummaryFooterCaption = oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["BudgetAmount"].Header.Caption;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[1].DisplayFormat = "{0:N}";

            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Difference"].Width = 120;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00"; 
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Difference"]);
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[2].Appearance.ForeColor = System.Drawing.Color.Black;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[2].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[2].Appearance.TextHAlign = HAlign.Right;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].SummaryFooterCaption = oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Difference"].Header.Caption;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[2].DisplayFormat = "{0:N}";

            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Percentage"].Width = 120;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Percentage"]);
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[3].Appearance.ForeColor = System.Drawing.Color.Black;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[3].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[3].Appearance.TextHAlign = HAlign.Right;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].SummaryFooterCaption = "Total";//this.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Percentage"].Header.Caption;
            //oControl.dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[3].DisplayFormat = "{0:N}";
            ///*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
        }
    }
}