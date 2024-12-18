using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

using Infragistics.Win.UltraWinGrid;

namespace SINCECOMP.FNB.Controls
{
   internal class ListOfValues
   {
      internal ListOfValues()
      {
      }

      public TreeCombo GetTreeCombo( String sqlSelect, String attributeName)
      {

         TreeCombo treeCombo = new TreeCombo();
                  
         treeCombo.SqlSelect = sqlSelect;
         treeCombo.IsUsedInGrid = true;

         treeCombo.Caption = attributeName;
         return treeCombo;
      }

      public UltraCombo SetTreeLov(String sqlSelect,  String attributeName)
      {

         TreeCombo treeCombo = this.GetTreeCombo(   sqlSelect, attributeName);
         UltraCombo ultraCombo = treeCombo.Controls[0] as UltraCombo;

         Form frm = new Form();
         frm.Controls.Add(ultraCombo);

         treeCombo.OpenTreeCombo_Load(ultraCombo, EventArgs.Empty);
         //ultraCombo.Tag = gridCol;
         ultraCombo.ButtonsRight[0].Tag = treeCombo;
         //gridCol.EditorControl = ultraCombo;
         return ultraCombo;
         
      }

   }
}
