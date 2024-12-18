using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;

namespace SINCECOMP.CONSTRUCTIONUNITS.Controls
{
    public partial class DetailConsUnitAmount : UserControl
    {
        public DetailConsUnitAmount()
        {
            InitializeComponent();
        }

        private void dgDetailConsUnit_AfterCellActivate(object sender, EventArgs e)
        {
            lblSelectedCell.Text = dgDetailAmount.Rows[int.Parse(dgDetailAmount.ActiveCell.Row.VisibleIndex.ToString())].Cells[1].Value.ToString().ToUpper();
        }

        private void dgDetailAmount_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {

            Infragistics.Win.UltraWinCalcManager.UltraCalcManager calcManager;
            calcManager = new Infragistics.Win.UltraWinCalcManager.UltraCalcManager(this.Container);
            e.Layout.Grid.CalcManager = calcManager;

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            dgDetailAmount.DisplayLayout.Bands[0].Columns["Executed"].CellAppearance.TextHAlign = HAlign.Right;
            dgDetailAmount.DisplayLayout.Bands[0].Columns["Executed"].Width = 120;
            dgDetailAmount.DisplayLayout.Bands[0].Columns["Executed"].Format = "#,##0.00";
            dgDetailAmount.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgDetailAmount.DisplayLayout.Bands[0].Columns["Executed"]);
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.Color.Black;
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            dgDetailAmount.DisplayLayout.Bands[0].SummaryFooterCaption = dgDetailAmount.DisplayLayout.Bands[0].Columns["Executed"].Header.Caption;
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "{0:N}";

            dgDetailAmount.DisplayLayout.Bands[0].Columns["Budget"].CellAppearance.TextHAlign = HAlign.Right;
            dgDetailAmount.DisplayLayout.Bands[0].Columns["Budget"].Width = 120;
            dgDetailAmount.DisplayLayout.Bands[0].Columns["Budget"].Format = "#,##0.00";
            dgDetailAmount.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgDetailAmount.DisplayLayout.Bands[0].Columns["Budget"]);
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[1].Appearance.ForeColor = System.Drawing.Color.Black;
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[1].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[1].Appearance.TextHAlign = HAlign.Right;
            dgDetailAmount.DisplayLayout.Bands[0].SummaryFooterCaption = dgDetailAmount.DisplayLayout.Bands[0].Columns["Budget"].Header.Caption;
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[1].DisplayFormat = "{0:N}";

            dgDetailAmount.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
            dgDetailAmount.DisplayLayout.Bands[0].Columns["Difference"].Width = 120;
            dgDetailAmount.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00";
            dgDetailAmount.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgDetailAmount.DisplayLayout.Bands[0].Columns["Difference"]);
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[2].Appearance.ForeColor = System.Drawing.Color.Black;
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[2].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[2].Appearance.TextHAlign = HAlign.Right;
            dgDetailAmount.DisplayLayout.Bands[0].SummaryFooterCaption = dgDetailAmount.DisplayLayout.Bands[0].Columns["Difference"].Header.Caption;
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[2].DisplayFormat = "{0:N}";

            dgDetailAmount.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
            dgDetailAmount.DisplayLayout.Bands[0].Columns["Percentage"].Width = 120;
            dgDetailAmount.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";
            
            dgDetailAmount.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Formula, dgDetailAmount.DisplayLayout.Bands[0].Columns["Percentage"], SummaryPosition.UseSummaryPositionColumn);
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[3].Formula = "if(sum([Budget])=0, 0, sum([Executed])/sum([Budget])*100 )";
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[3].Appearance.ForeColor = System.Drawing.Color.Black;
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[3].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[3].Appearance.TextHAlign = HAlign.Right;            
            dgDetailAmount.DisplayLayout.Bands[0].Summaries[3].DisplayFormat = "{0:N}";

            dgDetailAmount.DisplayLayout.Bands[0].SummaryFooterCaption = "Total";//this.dgDetailAmount.DisplayLayout.Bands[0].Columns["Percentage"].Header.Caption;
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            e.Layout.Override.FormulaRowIndexSource = FormulaRowIndexSource.ListIndex;
        }

    }
}
