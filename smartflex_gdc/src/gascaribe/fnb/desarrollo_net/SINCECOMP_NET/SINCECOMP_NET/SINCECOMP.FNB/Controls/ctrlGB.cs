using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
//
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.BL;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;
using System.Collections;

namespace SINCECOMP.FNB.Controls
{
    public partial class ctrlGB : UserControl
    {
        BindingSource customerbinding = new BindingSource();
        Boolean start;
        String typeUser;
        Int64 userId;
        //columnas
        String a = "BrandId";
        String b = "Description";
        String c = "Approved";
        String d = "ConditionApproved";
        String e = "CheckSave";
        String f = "CheckModify";
        //
        BLGENERAL general = new BLGENERAL();

        public ctrlGB(String typeuser, Int64 userid)
        {
            InitializeComponent();
            //validaciones de usuario
            typeUser = typeuser;
            userId = userid;
            //
            start = false;
            List<BrandGB> ListBrand = new List<BrandGB>();
            ListBrand = BLGB.FcuBrand();
            customerbinding.DataSource = ListBrand;
            bnNavigator.BindingSource = customerbinding;
            dgBrand.DataSource = customerbinding;
            //combo s/n
            List<ListSN> lista = new List<ListSN>();
            lista.Add(new ListSN("Y", "Si"));
            lista.Add(new ListSN("N", "No"));
            BindingSource tabla = new BindingSource();
            tabla.DataSource = lista;
            UltraDropDown dropDownsn = new UltraDropDown();
            dropDownsn.DataSource = tabla;
            dropDownsn.ValueMember = "Id";
            dropDownsn.DisplayMember = "Description";
            dgBrand.DisplayLayout.Bands[0].Columns[c].ValueList = dropDownsn;
            dgBrand.DisplayLayout.Bands[0].Columns[c].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList;
            //dgBrand.DisplayLayout.Bands[0].Columns[d].ValueList = dropDownsn;
            //dgBrand.DisplayLayout.Bands[0].Columns[d].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownList;
            //ocultar columnas guias
            dgBrand.DisplayLayout.Bands[0].Columns[d].Hidden = true;
            dgBrand.DisplayLayout.Bands[0].Columns[e].Hidden = true;
            dgBrand.DisplayLayout.Bands[0].Columns[f].Hidden = true;
            //alineaciones y bloqueo
            dgBrand.DisplayLayout.Bands[0].Columns[a].CellActivation = Activation.NoEdit;
            dgBrand.DisplayLayout.Bands[0].Columns[a].CellAppearance.BackColor = Color.LightGray;
            dgBrand.DisplayLayout.Bands[0].Columns[c].CellAppearance.TextHAlign = HAlign.Center;
            //dgBrand.DisplayLayout.Bands[0].Columns[d].CellAppearance.TextHAlign = HAlign.Center;
            //
            dgBrand.DisplayLayout.Bands[0].Columns[b].MaxLength = 100;
            //campos obligatorios
            String[] fieldsbrand = new string[] { a, b, c };//, d };
            general.setColumnRequiered(dgBrand, fieldsbrand);
            //
            if (typeUser == "F")
            {
                dgBrand.DisplayLayout.Bands[0].Columns[c].CellActivation = Activation.AllowEdit;
                //dgBrand.DisplayLayout.Bands[0].Columns[d].CellActivation = Activation.AllowEdit;
            }
            else
            {
                dgBrand.DisplayLayout.Bands[0].Columns[c].CellActivation = Activation.NoEdit;
                //dgBrand.DisplayLayout.Bands[0].Columns[d].CellActivation = Activation.NoEdit;
            }
            start = true;
        }

        private void bindingNavigatorAddItem_Click(object sender, EventArgs et)
        {
            customerbinding.Add(BLGB.AddRowList());
            dgBrand.Rows[dgBrand.Rows.Count - 1].Cells[a].Value = BLGB.consBrand();
            dgBrand.Rows[dgBrand.Rows.Count - 1].Cells[c].Value = "N";
            //dgBrand.Rows[dgBrand.Rows.Count - 1].Cells[d].Value = "Y";
            dgBrand.Rows[dgBrand.Rows.Count - 1].Cells[e].Value = 1;
            dgBrand.Rows[dgBrand.Rows.Count - 1].Cells[f].Value = 0;
            bindingNavigatorLastPosition.PerformClick();
        }

        private void bindingNavigatorSaveItem_Click(object sender, EventArgs et)
        {
            System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
            dgBrand.ActiveRow.Cells[a].Activated = true;
            Boolean error = false;
            int irow;
            for (irow = 0; irow <= dgBrand.Rows.Count - 1; irow++)
            {
                if (validate(irow))
                {
                    Int64 inubrand_id = Convert.ToInt64(dgBrand.Rows[irow].Cells[a].Text);
                    String inudescription = Convert.ToString(dgBrand.Rows[irow].Cells[b].Value);
                    String inuapproved = Convert.ToString(dgBrand.Rows[irow].Cells[c].Value);
                    String inucondition_approved = "Y"; //Convert.ToString(dgBrand.Rows[irow].Cells[d].Value);
                    Int64 cs = Convert.ToInt64(dgBrand.Rows[irow].Cells[e].Text);
                    if (cs == 1)
                    {
                        BLGB.saveBrand(inubrand_id, inudescription, inuapproved, inucondition_approved);
                        dgBrand.Rows[irow].Cells[e].Value = 0;
                        dgBrand.Rows[irow].Cells[f].Value = 0;
                    }
                    Int64 cm = Convert.ToInt64(dgBrand.Rows[irow].Cells[f].Text);
                    if (cm == 1)
                    {
                        BLGB.modifyBrand(inubrand_id, inudescription, inuapproved, inucondition_approved);
                        dgBrand.Rows[irow].Cells[e].Value = 0;
                        dgBrand.Rows[irow].Cells[f].Value = 0;
                    }
                }
                else
                    error = true;
            }
            general.doCommit();//BLGB.Save();
            System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
            if (error)
                general.mensajeERROR("Falta información, algunas Marcas pudierón no ser guardadas");
        }

        Boolean validate(int irow)
        {
            if (dgBrand.Rows[irow].Cells[b].Text == "")
                return false;
            return true;
        }

        private void bindingNavigatorDeleteItem_Click(object sender, EventArgs et)
        {
            System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
            Int64 cs = Convert.ToInt64(dgBrand.Rows[int.Parse(bindingNavigatorPositionItem.Text) - 1].Cells[e].Value);
            if (cs == 0)
            {
                try
                {
                    BLGB.deleteBrand(Convert.ToInt64(dgBrand.Rows[int.Parse(bindingNavigatorPositionItem.Text) - 1].Cells[a].Value));
                    dgBrand.ActiveRow.Delete(false);
                    general.doCommit();//BLGB.Save();
                }
                catch
                {
                    general.mensajeERROR("No puede eliminar esta Marca");
                }
            }
            else
                dgBrand.ActiveRow.Delete(false);
            System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
        }

        private void dgBrand_CellChange(object sender, CellEventArgs et)
        {
            dgBrand.Rows[et.Cell.Row.Index].Cells[f].Value = 1;
            if (et.Cell.Column.Key == c) //|| et.Cell.Column.Key == d)
            {
                dgBrand.ActiveRow.Cells[f].Activated = true;
                dgBrand.ActiveRow.Cells[et.Cell.Column.Key].Activated = true;
            }

        }


    }
}
