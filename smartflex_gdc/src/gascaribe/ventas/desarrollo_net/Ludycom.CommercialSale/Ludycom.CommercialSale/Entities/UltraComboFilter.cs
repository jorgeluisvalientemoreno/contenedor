using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Windows.Controls;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;

namespace Ludycom.CommercialSale.Entities
{
    public class UltraComboFilter
    {
        private UltraCombo gridDropDown;

        private String keyColumn;

        public UltraComboFilter(UltraCombo gridDropDown, String keyColumn)
        {
            this.gridDropDown = gridDropDown;
            this.keyColumn = keyColumn;
            this.gridDropDown.KeyUp += new System.Windows.Forms.KeyEventHandler(gridDropDown_KeyUp);
            this.gridDropDown.KeyPress += new KeyPressEventHandler(gridDropDown_KeyPress);
            this.gridDropDown.KeyDown += new KeyEventHandler(gridDropDown_KeyDown);
            this.gridDropDown.AfterCloseUp += new EventHandler(gridDropDown_AfterCloseUp);
            this.gridDropDown.TextChanged +=new EventHandler(gridDropDown_TextChanged);
            this.gridDropDown.BeforeDropDown += new System.ComponentModel.CancelEventHandler(gridDropDown_BeforeDropDown);
            this.gridDropDown.AutoEdit = false;
        }

        void gridDropDown_KeyDown(object sender, KeyEventArgs e)
        {
            List<Keys> notValidKeys = new List<Keys>();
            notValidKeys.Add(Keys.Up);
            notValidKeys.Add(Keys.Down);
            notValidKeys.Add(Keys.Left);
            notValidKeys.Add(Keys.Right);
            notValidKeys.Add(Keys.Enter);
            notValidKeys.Add(Keys.Escape);
            notValidKeys.Add(Keys.Shift);

            if (!notValidKeys.Contains(e.KeyCode))
            {
                //UltraCombo u = new UltraCombo();

                Int32 selection = this.gridDropDown.Textbox.SelectionStart;
                if (this.gridDropDown.IsDroppedDown)
                {
                    this.gridDropDown.Textbox.SelectionLength = 0;
                    this.gridDropDown.Textbox.SelectionStart = selection;
                }

                setFilter();
            }
        }

        private void gridDropDown_KeyPress(object sender, KeyPressEventArgs e)
        {
            
        }

        void gridDropDown_AfterCloseUp(object sender, EventArgs e)
        {
            clearFilter();
        }

        private void gridDropDown_BeforeDropDown(object sender, System.ComponentModel.CancelEventArgs e)
        {
            clearFilter();
        }

        private void gridDropDown_TextChanged(object sender, EventArgs e)
        {
            if (this.gridDropDown.Text == "")
            {
                clearFilter();
            }
            else
            {
                setFilter();
            }
        }

        private void gridDropDown_AfterCloseUp(object sender, Infragistics.Win.UltraWinGrid.DropDownEventArgs e)
        {
            clearFilter();
        }

        private void gridDropDown_KeyUp(object sender, KeyEventArgs e)
        {
            List<Keys> notValidKeys = new List<Keys>();
            notValidKeys.Add(Keys.Up);
            notValidKeys.Add(Keys.Down);
            notValidKeys.Add(Keys.Left);
            notValidKeys.Add(Keys.Right);
            notValidKeys.Add(Keys.Enter);
            notValidKeys.Add(Keys.Escape);
            notValidKeys.Add(Keys.Shift);

            if (!notValidKeys.Contains(e.KeyCode))
            {
                //UltraCombo u = new UltraCombo();

                Int32 selection = this.gridDropDown.Textbox.SelectionStart;
                if (this.gridDropDown.IsDroppedDown)
                {
                    this.gridDropDown.Textbox.SelectionLength = 0;
                    this.gridDropDown.Textbox.SelectionStart = selection;
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
