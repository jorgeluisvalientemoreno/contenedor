using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;

namespace SINCECOMP.CONSTRUCTIONUNITS.Controls
{
    public partial class DetailConsUnitValue : UserControl
    {
        public DetailConsUnitValue()
        {
            InitializeComponent();
        }

        private void dgDetailValue_AfterCellActivate(object sender, EventArgs e)
        {
            lblSelectedCell.Text = dgDetailValue.Rows[int.Parse(dgDetailValue.ActiveCell.Row.VisibleIndex.ToString())].Cells[1].Value.ToString().ToUpper();
        }

        private void dgDetailValue_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            Infragistics.Win.UltraWinCalcManager.UltraCalcManager calcManager;
            calcManager = new Infragistics.Win.UltraWinCalcManager.UltraCalcManager(this.Container);
            e.Layout.Grid.CalcManager = calcManager;

            /*Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/
            dgDetailValue.DisplayLayout.Bands[0].Columns["Executed"].CellAppearance.TextHAlign = HAlign.Right;
            dgDetailValue.DisplayLayout.Bands[0].Columns["Executed"].Width = 120;
            dgDetailValue.DisplayLayout.Bands[0].Columns["Executed"].Format = "#,##0.00";
            dgDetailValue.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgDetailValue.DisplayLayout.Bands[0].Columns["Executed"]);
            dgDetailValue.DisplayLayout.Bands[0].Summaries[0].Appearance.ForeColor = System.Drawing.Color.Black;
            dgDetailValue.DisplayLayout.Bands[0].Summaries[0].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgDetailValue.DisplayLayout.Bands[0].Summaries[0].Appearance.TextHAlign = HAlign.Right;
            dgDetailValue.DisplayLayout.Bands[0].SummaryFooterCaption = dgDetailValue.DisplayLayout.Bands[0].Columns["Executed"].Header.Caption;
            dgDetailValue.DisplayLayout.Bands[0].Summaries[0].DisplayFormat = "{0:N}";

            dgDetailValue.DisplayLayout.Bands[0].Columns["Budget"].CellAppearance.TextHAlign = HAlign.Right;
            dgDetailValue.DisplayLayout.Bands[0].Columns["Budget"].Width = 120;
            dgDetailValue.DisplayLayout.Bands[0].Columns["Budget"].Format = "#,##0.00";
            dgDetailValue.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgDetailValue.DisplayLayout.Bands[0].Columns["Budget"]);
            dgDetailValue.DisplayLayout.Bands[0].Summaries[1].Appearance.ForeColor = System.Drawing.Color.Black;
            dgDetailValue.DisplayLayout.Bands[0].Summaries[1].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgDetailValue.DisplayLayout.Bands[0].Summaries[1].Appearance.TextHAlign = HAlign.Right;
            dgDetailValue.DisplayLayout.Bands[0].SummaryFooterCaption = dgDetailValue.DisplayLayout.Bands[0].Columns["Budget"].Header.Caption;
            dgDetailValue.DisplayLayout.Bands[0].Summaries[1].DisplayFormat = "{0:N}";

            dgDetailValue.DisplayLayout.Bands[0].Columns["Difference"].CellAppearance.TextHAlign = HAlign.Right;
            dgDetailValue.DisplayLayout.Bands[0].Columns["Difference"].Width = 120;
            dgDetailValue.DisplayLayout.Bands[0].Columns["Difference"].Format = "#,##0.00";
            dgDetailValue.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgDetailValue.DisplayLayout.Bands[0].Columns["Difference"]);
            dgDetailValue.DisplayLayout.Bands[0].Summaries[2].Appearance.ForeColor = System.Drawing.Color.Black;
            dgDetailValue.DisplayLayout.Bands[0].Summaries[2].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgDetailValue.DisplayLayout.Bands[0].Summaries[2].Appearance.TextHAlign = HAlign.Right;
            dgDetailValue.DisplayLayout.Bands[0].SummaryFooterCaption = dgDetailValue.DisplayLayout.Bands[0].Columns["Difference"].Header.Caption;
            dgDetailValue.DisplayLayout.Bands[0].Summaries[2].DisplayFormat = "{0:N}";

            dgDetailValue.DisplayLayout.Bands[0].Columns["Percentage"].CellAppearance.TextHAlign = HAlign.Right;
            dgDetailValue.DisplayLayout.Bands[0].Columns["Percentage"].Width = 120;
            dgDetailValue.DisplayLayout.Bands[0].Columns["Percentage"].Format = "#,##0.00";
            //dgDetailValue.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Sum, dgDetailValue.DisplayLayout.Bands[0].Columns["Percentage"]);
            dgDetailValue.DisplayLayout.Bands[0].Summaries.Add(SummaryType.Formula, dgDetailValue.DisplayLayout.Bands[0].Columns["Percentage"], SummaryPosition.UseSummaryPositionColumn);
            dgDetailValue.DisplayLayout.Bands[0].Summaries[3].Formula = "if(sum([Budget])=0, 0, sum([Executed])/sum([Budget])*100 )";

            dgDetailValue.DisplayLayout.Bands[0].Summaries[3].Appearance.ForeColor = System.Drawing.Color.Black;
            dgDetailValue.DisplayLayout.Bands[0].Summaries[3].Appearance.BackColor = System.Drawing.SystemColors.ButtonFace;
            dgDetailValue.DisplayLayout.Bands[0].Summaries[3].Appearance.TextHAlign = HAlign.Right;
            dgDetailValue.DisplayLayout.Bands[0].SummaryFooterCaption = "Total";//this.dgDetailValue.DisplayLayout.Bands[0].Columns["Percentage"].Header.Caption;
            dgDetailValue.DisplayLayout.Bands[0].Summaries[3].DisplayFormat = "{0:N}";
            /*Fin Subtotal de ejecutado - presupuestado - Diferencia - Porcentaje*/

            e.Layout.Override.FormulaRowIndexSource = FormulaRowIndexSource.ListIndex;
        }      
    }
}