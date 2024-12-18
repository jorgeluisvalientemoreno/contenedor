using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;

namespace SINCECOMP.CONSTRUCTIONUNITS.Controls
{
    public partial class GasDemandServiceDetail : UserControl
    {
        public GasDemandServiceDetail(String titulo)
        {
            InitializeComponent();
            ohtTitle.HeaderTitle = titulo;
            ohtTitle.HeaderSubtitle1 = titulo;
        }

        private void dgDemansServiceDetail_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            Infragistics.Win.UltraWinCalcManager.UltraCalcManager calcManager;
            calcManager = new Infragistics.Win.UltraWinCalcManager.UltraCalcManager(this.Container);
            e.Layout.Grid.CalcManager = calcManager;

            dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["GeograpLocationId"].CellAppearance.TextHAlign = HAlign.Right;

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["ExecutedAmount"].CellAppearance.TextHAlign = HAlign.Right;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["ExecutedAmount"].Width = 120;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["ExecutedAmount"].Format = "#,##0.00";
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["ExecutedAmount"]);
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.Color.Black;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            dgDemansServiceDetail.DisplayLayout.Bands[0].SummaryFooterCaption = dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["ExecutedAmount"].Header.Caption;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "{0:N}";

            dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["BudgetAmount"].CellAppearance.TextHAlign = HAlign.Right;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["BudgetAmount"].Width = 120;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["BudgetAmount"].Format = "#,##0.00";
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["BudgetAmount"]);
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[1].Appearance.ForeColor = System.Drawing.Color.Black;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[1].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[1].Appearance.TextHAlign = HAlign.Right;
            dgDemansServiceDetail.DisplayLayout.Bands[0].SummaryFooterCaption = dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["BudgetAmount"].Header.Caption;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[1].DisplayFormat = "{0:N}";

            dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Difference"].Width = 120;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00";
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Difference"]);
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[2].Appearance.ForeColor = System.Drawing.Color.Black;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[2].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[2].Appearance.TextHAlign = HAlign.Right;
            dgDemansServiceDetail.DisplayLayout.Bands[0].SummaryFooterCaption = dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Difference"].Header.Caption;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[2].DisplayFormat = "{0:N}";

            dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Percentage"].Width = 120;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";
            //dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Percentage"]);
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Formula, dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Percentage"], SummaryPosition.UseSummaryPositionColumn);
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[3].Formula = "if(sum([BudgetAmount])=0, 0, sum([ExecutedAmount])/sum([BudgetAmount])*100 )";
            
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[3].Appearance.ForeColor = System.Drawing.Color.Black;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[3].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[3].Appearance.TextHAlign = HAlign.Right;
            dgDemansServiceDetail.DisplayLayout.Bands[0].SummaryFooterCaption = "Total";//this.dgDemansServiceDetail.DisplayLayout.Bands[0].Columns["Percentage"].Header.Caption;
            dgDemansServiceDetail.DisplayLayout.Bands[0].Summaries[3].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            e.Layout.Override.FormulaRowIndexSource = FormulaRowIndexSource.ListIndex;
        }
    }
}
