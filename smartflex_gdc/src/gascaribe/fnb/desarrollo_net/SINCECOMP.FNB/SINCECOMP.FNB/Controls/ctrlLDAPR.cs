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
using SINCECOMP.FNB.UI;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;
using System.Collections;

namespace SINCECOMP.FNB.Controls
{
    public partial class ctrlLDAPR : UserControl
    {
        BindingSource customerbinding = new BindingSource();
        Boolean start;
        //columnas
        String a = "propertyId";
        String b = "description";
        String c = "checkSave";
        String d = "checkModify";
        //
        BLGENERAL general = new BLGENERAL();
        //
        String msjError = "";
        public Boolean operPendientes = false;

        public ctrlLDAPR()
        {
            InitializeComponent();
            start = false;
            List<PropLDAPR> ListProperty = new List<PropLDAPR>();
            ListProperty = BLLDAPR.FcuProperty();
            customerbinding.DataSource = ListProperty;
            bnNavigator.BindingSource = customerbinding;
            dgProperty.DataSource = customerbinding;
            start = true;
            //ocultar columnas guias
            String[] fieldReadOnly = new string[] { a };
            general.setColumnReadOnly(dgProperty, fieldReadOnly);
            dgProperty.DisplayLayout.Bands[0].Columns[c].Hidden = true;
            dgProperty.DisplayLayout.Bands[0].Columns[d].Hidden = true;
            dgProperty.DisplayLayout.Bands[0].Columns[a].CellAppearance.TextHAlign = HAlign.Right;
            //dgProperty.DisplayLayout.Bands[0].Columns[a].CellActivation = Activation.NoEdit;
            dgProperty.DisplayLayout.Bands[0].Columns[a].CellAppearance.BackColor = Color.LightGray;
            dgProperty.DisplayLayout.Bands[0].Columns[b].MaxLength = 200;
            //campos obligatorios
            String[] fieldsproperty = new string[] { a, b };
            general.setColumnRequiered(dgProperty, fieldsproperty);
            //campos mayusculas
            String[] fieldsupper = new string[] { b };
            general.setColumnUpper(dgProperty, fieldsupper);
            //
            operPendientes = false;
        }

        private void bindingNavigatorAddItem_Click(object sender, EventArgs e)
        {
            if (dgProperty.Rows.Count > 0)
            {
                try
                {
                    dgProperty.ActiveRow.Cells[c].Activated = true;
                }
                catch
                {
                    dgProperty.Rows[0].Cells[c].Activated = true;
                }
                msjError = "";
                if (validate(dgProperty.Rows.Count - 1))
                {
                    //incio de operaciones
                    operPendientes = true;
                    //
                    customerbinding.Add(BLLDAPR.AddRowList());
                    dgProperty.Rows[dgProperty.Rows.Count - 1].Cells[a].Value = general.valueReturn(BLConsultas.secuencePropertybyArticle, "Int64"); //BLLDAPR.consPropert();
                    dgProperty.Rows[dgProperty.Rows.Count - 1].Cells[c].Value = 1;
                    dgProperty.Rows[dgProperty.Rows.Count - 1].Cells[d].Value = 0;
                    bindingNavigatorMoveLastItem.PerformClick();
                }
                else
                {
                    if (msjError != "")
                        general.mensajeERROR(msjError);
                }
            }
            else
            {
                //incio de operaciones
                operPendientes = true;
                //
                customerbinding.Add(BLLDAPR.AddRowList());
                dgProperty.Rows[0].Cells[a].Value = general.valueReturn(BLConsultas.secuencePropertybyArticle, "Int64"); //BLLDAPR.consPropert();
                dgProperty.Rows[0].Cells[c].Value = 1;
                dgProperty.Rows[0].Cells[d].Value = 0;
                bindingNavigatorMoveLastItem.PerformClick();
            }
        }

        Boolean validate(int irow)
        {
            //if (dgProperty.Rows[irow].Cells[b].Text == "")
            //    return false;
            if (dgProperty.Rows[irow].Cells[b].Text == "")
            {
                general.mensajeERROR("Debera ingresar la Descripción para la Propiedad con Codigo: " + dgProperty.Rows[irow].Cells[a].Text);
                return false;
            }
            return true;
        }

        private void bindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            if (dgProperty.Rows.Count > 0)
            {
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                Boolean error = false;
                //error en filas
                try
                {
                    dgProperty.ActiveRow.Cells[c].Activated = true;
                }
                catch
                {
                    dgProperty.Rows[0].Activated = true;
                }
                String errorRow = "";
                int irow;
                for (irow = 0; irow <= dgProperty.Rows.Count - 1; irow++)
                {
                    msjError = "";
                    if (validate(irow))
                    {
                        Int64 propertyid = Convert.ToInt64(dgProperty.Rows[irow].Cells[a].Text);
                        String description = dgProperty.Rows[irow].Cells[b].Text;
                        Int64 cs = Convert.ToInt64(dgProperty.Rows[irow].Cells[c].Value);
                        if (cs == 1)
                        {
                            BLLDAPR.saveProperty(propertyid, description);
                            dgProperty.Rows[irow].Cells[c].Value = 0;
                            dgProperty.Rows[irow].Cells[d].Value = 0;
                        }
                        Int64 cm = Convert.ToInt64(dgProperty.Rows[irow].Cells[d].Value);
                        if (cm == 1)
                        {
                            BLLDAPR.modifyProperty(propertyid, description);
                            dgProperty.Rows[irow].Cells[c].Value = 0;
                            dgProperty.Rows[irow].Cells[d].Value = 0;
                        }
                    }
                    else
                    {
                        if (msjError != "")
                            general.mensajeERROR(msjError);
                        errorRow += dgProperty.Rows[irow].Cells[a].Text + ", ";
                        error = true;
                    }
                }
                general.doCommit();//BLLDAPR.Save();
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
                if (error)
                    general.mensajeERROR("Error en la información ingresada, las Propiedades con el Codigo: " + errorRow + "pudierón no ser Guardadas o Modificadas");
                else
                    operPendientes = false;
            }
        }

        private void bindingNavigatorDeleteItem_Click(object sender, EventArgs e)
        {
            if (bindingNavigatorPositionItem.Text == "0")
                general.mensajeERROR("No hay ninguna Propiedad Seleccionada");
            else
            {
                Boolean del = true;
                Int64 cs = 1;
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                try
                {
                    cs = Convert.ToInt64(dgProperty.ActiveRow.Cells[c].Value);
                }
                catch
                {
                    del = false;
                    general.mensajeERROR("No hay ninguna Propiedad de artículo Seleccionada");

                }
                if (cs == 0 && del)
                {
                    Question pregunta = new Question("LDAPB - Eliminar la Propiedad del artículo", "¿Desea Eliminar la Propiedad " + dgProperty.ActiveRow.Cells[a].Value.ToString() + " - " + dgProperty.ActiveRow.Cells[b].Value.ToString() + "?", "Si", "No");
                    pregunta.ShowDialog();
                    Int64 answer = pregunta.answer;
                    if (answer == 2)
                    {
                        try
                        {
                            //cargar de los datos del procedimiento
                            String[] p1 = new string[] { "Int64" };
                            String[] p2 = new string[] { "inuproperty_id" };
                            Object[] p3 = new object[] { dgProperty.ActiveRow.Cells[a].Value };
                            //ejecucion de la operacion
                            general.executeMethod(BLConsultas.deletePropertybyArticle, 1, p1, p2, p3);
                            //BLLDAPR.deleteProperty(Convert.ToInt64(dgProperty.ActiveRow.Cells[a].Value));
                            dgProperty.ActiveRow.Delete(false);
                            general.doCommit();//BLLDAPR.Save();
                        }
                        catch
                        {
                            general.mensajeERROR("No puede eliminar esta Propiedad, se debe hallar asociada a un Registro");
                        }
                    }
                }
                else
                {
                    if (del)
                        dgProperty.ActiveRow.Delete(false);
                }
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;
            }
        }

        private void dgProperty_CellChange(object sender, CellEventArgs e)
        {
            dgProperty.Rows[e.Cell.Row.Index].Cells[d].Value = 1;
            //incio de operaciones
            operPendientes = true;
            //
        }

        private void bindingNavigatorPrintItem_Click(object sender, EventArgs e)
        {
            general.imprimirExcel(dgProperty);
        }

        private void importar_Click(object sender, EventArgs e)
        {
            general.importarExcel(dgProperty );
        }

        private void exportar_Click(object sender, EventArgs e)
        {
            //String[] listaColumnas = new string[] { a };
            general.exportarExcel(dgProperty);//, listaColumnas);
        }

        private void dgProperty_Error(object sender, ErrorEventArgs et)
        {
            //String tMensaje = "";
            if (et.ErrorType == ErrorType.Data)
            {
                //if (et.DataErrorInfo.Source == DataErrorSource.CellUpdate)
                //{
                //if (et.DataErrorInfo.Cell.Column.Key == f)
                //tMensaje = "Referencia invalida. Debe seleccionar una Referencia de la lista.";
                //}
                et.Cancel = true;
                //general.mensajeERROR(tMensaje);
            }
        }

        private void dgProperty_BeforeSortChange(object sender, BeforeSortChangeEventArgs et)
        {
            if (dgProperty.Rows.Count > 0)
            {
                Boolean pendiente = false;
                foreach (UltraGridRow fila in dgProperty.Rows)
                {
                    if (fila.Cells[c].Text == "1")
                        pendiente = true;
                }
                if (pendiente)
                {
                    general.mensajeERROR("No puede realizar esta operación mientras hayan registros pendientes por Guardar");
                    et.Cancel = true;
                }
            }
        }

        private void dgProperty_BeforeRowFilterChanged(object sender, BeforeRowFilterChangedEventArgs et)
        {
            if (dgProperty.Rows.Count > 0)
            {
                Boolean pendiente = false;
                foreach (UltraGridRow fila in dgProperty.Rows)
                {
                    if (fila.Cells[c].Text == "1")
                        pendiente = true;
                }
                if (pendiente)
                {
                    general.mensajeERROR("No puede realizar esta operación mientras hayan registros pendientes por Guardar");
                    et.Cancel = true;
                }
            }
        }

        public Boolean validandoC()
        {
            //grilla uno
            Boolean saveR = false;
            int irow;
            if (dgProperty.Rows.Count > 0)
            {
                try
                {
                    dgProperty.ActiveRow.Cells[c].Activated = true;
                }
                catch
                {
                    dgProperty.Rows[0].Activated = true;
                }
                for (irow = 0; irow <= dgProperty.Rows.Count - 1; irow++)
                {
                    msjError = "";
                    if (validate(irow))
                    {
                        Int64 cs = Convert.ToInt64(dgProperty.Rows[irow].Cells[c].Value);
                        if (cs == 1)
                            saveR = true;
                        Int64 cm = Convert.ToInt64(dgProperty.Rows[irow].Cells[d].Value);
                        if (cm == 1)
                            saveR = true;
                    }
                    else
                    {
                        if (msjError != "")
                            general.mensajeERROR(msjError);
                        return false;
                    }
                }
            }
            //
            if (saveR)
            {
                Question pregunta = new Question("LDAPB - Pregunta", "¿Desea Guardar los cambios en Administracion de Propiedades de artículos?", "Si", "No");
                pregunta.ShowDialog();
                Int64 answer = pregunta.answer;
                if (answer == 2)
                {
                    try
                    {
                        bindingNavigatorSaveItem.PerformClick();
                    }
                    catch
                    {
                        return false;
                    }
                }
            }
            return true;
        }
    }
}
