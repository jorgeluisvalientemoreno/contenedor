using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Windows.Controls;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;

namespace Ludycom.CommercialSale.Entities
{
    public class GridDropDownFilter
    {
        private OpenGridDropDown gridDropDown;

        private String keyColumn;

        public GridDropDownFilter(OpenGridDropDown gridDropDown, String keyColumn)
        {
            this.gridDropDown = gridDropDown;
            this.keyColumn = keyColumn;
            this.gridDropDown.KeyUp += new System.Windows.Forms.KeyEventHandler(gridDropDown_KeyUp);
            this.gridDropDown.AfterCloseUp += new Infragistics.Win.UltraWinGrid.DropDownEventHandler(gridDropDown_AfterCloseUp);
            this.gridDropDown.TextChanged += new EventHandler(gridDropDown_TextChanged);
            this.gridDropDown.BeforeDropDown += new System.ComponentModel.CancelEventHandler(gridDropDown_BeforeDropDown);
        }

        private void gridDropDown_BeforeDropDown(object sender, System.ComponentModel.CancelEventArgs e)
        {
            clearFilter();
        }

        private void gridDropDown_TextChanged(object sender, EventArgs e)
        {
            if (this.gridDropDown.Text =="")
            {
                clearFilter();
            }
        }

        private void gridDropDown_AfterCloseUp(object sender, Infragistics.Win.UltraWinGrid.DropDownEventArgs e)
        {
            clearFilter();
        }

        private void gridDropDown_KeyUp(object sender, System.Windows.Forms.KeyEventArgs e)
        {
            List<Keys> notValidKeys = new List<Keys>();
            notValidKeys.Add(Keys.Up);
            notValidKeys.Add(Keys.Down);
            notValidKeys.Add(Keys.Left);
            notValidKeys.Add(Keys.Right);
            notValidKeys.Add(Keys.Enter);
            notValidKeys.Add(Keys.Escape);
            notValidKeys.Add(Keys.Shift);

            if (!notValidKeys.Contains(e.KeyCode) )
            {
                //UltraCombo u = new UltraCombo();

                if (this.gridDropDown.IsDroppedDown)
                {
                    //this.gridDropDown.
                }

                setFilter();
            }
        }

        private void clearFilter()
        {
            this.gridDropDown.DisplayLayout.Bands[0].ColumnFilters.ClearAllFilters();

        }

        private void setFilter()
        {
            clearFilter();
            this.gridDropDown.DisplayLayout.Bands[0].ColumnFilters[keyColumn].FilterConditions.Add(Infragistics.Win.UltraWinGrid.FilterComparisionOperator.Like, "*" + this.gridDropDown.Text + "*");
        }

    }
}
