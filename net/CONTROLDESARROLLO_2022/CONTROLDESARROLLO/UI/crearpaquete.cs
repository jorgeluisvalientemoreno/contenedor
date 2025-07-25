using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

//Librerias BL
using CONTROLDESARROLLO.BL;
using CONTROLDESARROLLO.ENTITY;

namespace CONTROLDESARROLLO.UI
{
    public partial class crearpaquete : Form
    {
    
         BLGENERAL BlGeneral = new BLGENERAL();

        //Tabla de memoria para items de datos adicionales
        DataTable DTDatoParametrosMetodo = new DataTable();
        /////////////////////////////////////////////////////////////////////////

        public Int64 nuIndiceMetodo = 0;
        public Int64 nuIndiceParametro = 0;

        public crearpaquete()
        {
            InitializeComponent();


            //Creacion de campos de la tabla de memoria
            DTDatoParametrosMetodo.Columns.Clear();
            DTDatoParametrosMetodo.Rows.Clear();
            DTDatoParametrosMetodo.Columns.Add("indicemetodo");
            DTDatoParametrosMetodo.Columns.Add("indiceparametro");
            DTDatoParametrosMetodo.Columns.Add("nombre");
            DTDatoParametrosMetodo.Columns.Add("tipo");
            DTDatoParametrosMetodo.Columns.Add("io");
            /////////////////////////////////////////////////////
        }

        private void crearpaquete_Load(object sender, EventArgs e)
        {
            CbxEsquema.Items.Add("PERSONALIZACIONES");
            CbxEsquema.Items.Add("ADM_PERSON");
            CbxEsquema.Items.Add("OPEN");

            // Seleccionar el primer elemento por defecto
            CbxEsquema.SelectedIndex = 0;

            // Crear una nueva columna de texto
            DataGridViewTextBoxColumn textColumnIndiceMetodo = new DataGridViewTextBoxColumn();
            textColumnIndiceMetodo.HeaderText = "Indice Metodo";
            textColumnIndiceMetodo.Name = "indicemetodo";
            //textColumnIndiceMetodo.Visible = false;
            // Agregar la columna al DataGridView
            DgvMetodos.Columns.Add(textColumnIndiceMetodo);

            // Crear una nueva columna de texto
            DataGridViewTextBoxColumn textColumnNombreMetodo = new DataGridViewTextBoxColumn();
            textColumnNombreMetodo.HeaderText = "Nombre";
            textColumnNombreMetodo.Name = "nombre";
            // Agregar la columna al DataGridView
            DgvMetodos.Columns.Add(textColumnNombreMetodo);

            // Crear una columna de tipo ComboBox
            DataGridViewComboBoxColumn comboColumnMetodo = new DataGridViewComboBoxColumn();
            comboColumnMetodo.HeaderText = "Metodo";
            comboColumnMetodo.Name = "metodo";
            // Agregar valores a la columna ComboBox
            comboColumnMetodo.Items.Add("procedimiento");
            comboColumnMetodo.Items.Add("funcion");
            // Agregar la columna ComboBox al DataGridView
            DgvMetodos.Columns.Add(comboColumnMetodo);

            // Crear una columna de tipo ComboBox
            DataGridViewComboBoxColumn comboColumnRetorno = new DataGridViewComboBoxColumn();
            comboColumnRetorno.HeaderText = "Retorno";
            comboColumnRetorno.Name = "Retorno";
            // Agregar valores a la columna ComboBox
            comboColumnRetorno.Items.Add("number");
            comboColumnRetorno.Items.Add("varchar2");
            comboColumnRetorno.Items.Add("date");
            comboColumnRetorno.Items.Add("boolean");
            // Agregar la columna ComboBox al DataGridView
            DgvMetodos.Columns.Add(comboColumnRetorno);


            //Manejo de variables de metodos
            DataGridViewTextBoxColumn textColumnIndiceParametro = new DataGridViewTextBoxColumn();
            textColumnIndiceParametro.HeaderText = "Indice Parametro";
            textColumnIndiceParametro.Name = "indiceparametro";
            //textColumnIndiceMetodo.Visible = false;
            DgvVariables.Columns.Add(textColumnIndiceParametro);

            // Crear una nueva columna de texto
            DataGridViewTextBoxColumn textColumnNombre = new DataGridViewTextBoxColumn();
            textColumnNombre.HeaderText = "Nombre";
            textColumnNombre.Name = "nombre";
            // Agregar la columna al DataGridView
            DgvVariables.Columns.Add(textColumnNombre);

            // Crear una columna de tipo ComboBox
            DataGridViewComboBoxColumn comboColumnTipo = new DataGridViewComboBoxColumn();
            comboColumnTipo.HeaderText = "Tipo";
            comboColumnTipo.Name = "tipo";
            // Agregar valores a la columna ComboBox
            comboColumnTipo.Items.Add("number");
            comboColumnTipo.Items.Add("varchar2");
            comboColumnTipo.Items.Add("date");
            comboColumnTipo.Items.Add("boolean");
            // Agregar la columna ComboBox al DataGridView
            DgvVariables.Columns.Add(comboColumnTipo);

            // Crear una columna de tipo ComboBox
            DataGridViewComboBoxColumn comboColumnIO = new DataGridViewComboBoxColumn();
            comboColumnIO.HeaderText = "I/O";
            comboColumnIO.Name = "io";
            // Agregar valores a la columna ComboBox
            comboColumnIO.Items.Add("In");
            comboColumnIO.Items.Add("Out");
            // Agregar la columna ComboBox al DataGridView
            DgvVariables.Columns.Add(comboColumnIO);

            // Asegúrate de que haya al menos una fila
            DgvMetodos.Rows[0].Cells[0].Value = nuIndiceMetodo;
            nuIndiceMetodo = nuIndiceMetodo + 1;

            // Asegúrate de que haya al menos una fila
            DgvVariables.Rows[0].Cells[0].Value = nuIndiceParametro;
            nuIndiceParametro = nuIndiceParametro + 1;

        }

        private void BtnProcesar_Click(object sender, EventArgs e)
        {
            //MessageBox.Show("Seleccionaste: " + CbxTipo.SelectedIndex.ToString() + " - " + CbxTipo.SelectedItem.ToString());

            //Encabezado
            TxbLogica.Text = "CREATE OR REPLACE PACKAGE " + CbxEsquema.Text.ToLower() + "." + TbxNombre.Text + " IS" + Environment.NewLine;
            if ((DgvMetodos.RowCount - 1) > 0)
            {
                foreach (DataGridViewRow row in DgvMetodos.Rows)
                {
                    try
                    {
                        if (row.Cells["Metodo"].Value.ToString().ToUpper() == "procedimiento".ToUpper())
                        {
                            TxbLogica.Text = TxbLogica.Text + "procedure " + row.Cells["nombre"].Value.ToString() + ";" + Environment.NewLine;
                        }
                        else
                        {
                            TxbLogica.Text = TxbLogica.Text + "function " + row.Cells["nombre"].Value.ToString() + " RETURN " + row.Cells["Retorno"].Value.ToString() + ";" + Environment.NewLine;
                        }
                    }
                    catch
                    {
                    }
                }
            }
            TxbLogica.Text = TxbLogica.Text + "END " + TbxNombre.Text + ";" + Environment.NewLine; ;
            TxbLogica.Text = TxbLogica.Text + "/" + Environment.NewLine; ;
            TxbLogica.Text = TxbLogica.Text + Environment.NewLine; ;

            //Cuerpo
            TxbLogica.Text = TxbLogica.Text + "CREATE OR REPLACE PACKAGE BODY " + CbxEsquema.Text.ToLower() + "." + TbxNombre.Text + " IS" + Environment.NewLine;
            TxbLogica.Text = TxbLogica.Text + "csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';" + Environment.NewLine;
            TxbLogica.Text = TxbLogica.Text + "cnuNVLTRC  CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef;" + Environment.NewLine;

            if ((DgvMetodos.RowCount - 1) > 0)
            {
                foreach (DataGridViewRow row in DgvMetodos.Rows)
                {
                    try
                    {
                        if (row.Cells["Metodo"].Value.ToString().ToUpper() == "procedimiento".ToUpper())
                        {
                            TxbLogica.Text = TxbLogica.Text + BlGeneral.FsbEstructuraProcedimiento(CbxEsquema.Text.ToLower(), row.Cells["nombre"].Value.ToString(), DgvVariables, "S");
                            //TxbLogica.Text = TxbLogica.Text + "procedure " + row.Cells["nombre"].Value.ToString() + ";" + Environment.NewLine;
                        }
                        else
                        {
                            TxbLogica.Text = TxbLogica.Text + BlGeneral.FsbEstructuraFuncion(CbxEsquema.Text.ToLower(), row.Cells["nombre"].Value.ToString(), row.Cells["Retorno"].Value.ToString(), DgvVariables, "S");
                            //TxbLogica.Text = TxbLogica.Text + "function " + row.Cells["nombre"].Value.ToString() + "IS RETURN " + row.Cells["Retorno"].Value.ToString() + ";" + Environment.NewLine;
                        }
                    }
                    catch
                    {
                    }
                }
            }
            
            
            TxbLogica.Text = TxbLogica.Text + "END " + TbxNombre.Text + ";" + Environment.NewLine;
            TxbLogica.Text = TxbLogica.Text + "/" + Environment.NewLine;

            
            if (CbxEsquema.Text.ToUpper() != "OPEN")
            {
                TxbLogica.Text = TxbLogica.Text + "BEGIN" + Environment.NewLine;
                TxbLogica.Text = TxbLogica.Text + "  pkg_utilidades.prAplicarPermisos('" + TbxNombre.Text.ToUpper() + "','" + CbxEsquema.Text.ToUpper() + "');" + Environment.NewLine;
                TxbLogica.Text = TxbLogica.Text + "END;" + Environment.NewLine;
                TxbLogica.Text = TxbLogica.Text + "/" + Environment.NewLine;
                TxbLogica.Text = TxbLogica.Text + "BEGIN" + Environment.NewLine;
                TxbLogica.Text = TxbLogica.Text + "  pkg_utilidades.prCrearSinonimos('" + TbxNombre.Text.ToUpper() + "','" + CbxEsquema.Text.ToUpper() + "');" + Environment.NewLine;
                TxbLogica.Text = TxbLogica.Text + "END;" + Environment.NewLine;
                TxbLogica.Text = TxbLogica.Text + "/" + Environment.NewLine;

            }
        }

        private void DgvMetodos_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {

            try
            {
                if (!String.IsNullOrEmpty(DgvMetodos.Rows[e.RowIndex].Cells["metodo"].Value.ToString()))
                {
                    if (DgvMetodos.Rows[e.RowIndex].Cells["metodo"].Value.ToString().ToUpper() == "PROCEDIMIENTO")
                    {
                        DgvMetodos.Rows[e.RowIndex].Cells["retorno"].ReadOnly = true;
                        DgvMetodos.Rows[e.RowIndex].Cells["retorno"].Value = null;
                    }
                    else
                    {
                        DgvMetodos.Rows[e.RowIndex].Cells["retorno"].ReadOnly = false;

                    }
                }
            }
            catch
            {
            }
        }

        private void DgvMetodos_UserAddedRow(object sender, DataGridViewRowEventArgs e)
        {
            e.Row.Cells["indicemetodo"].Value = nuIndiceMetodo;
            nuIndiceMetodo = nuIndiceMetodo + 1;
        }

        private void DgvVariables_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            //DataGridViewRow DgvMetodosfilaActiva = DgvMetodos.CurrentRow;

            //DataGridViewRow DgvVariablesFilaSeleccionada = DgvVariables.CurrentRow;

            ////string nombreColumna = DgvVariables.Columns[e.ColumnIndex].Name;
            ////object nuevoValor = DgvVariables.Rows[e.RowIndex].Cells[e.ColumnIndex].Value;

            //MessageBox.Show("Indice: " + DgvMetodosfilaActiva.Cells[0].Value.ToString());

            //DataRow[] DTBuscarDataParametro = DTDatoParametrosMetodo.Select("indice = " + Convert.ToInt64(DgvMetodosfilaActiva.Cells[0].Value));
            //if (DTBuscarDataParametro.Length > 0)
            //{
            //    MessageBox.Show("Existe DATA en memoria");
            //    foreach (var drow in DTBuscarDataParametro)
            //    {
            //        MessageBox.Show(drow[0].ToString() + " - " + drow[1].ToString() + " - " + drow[2].ToString() + " - " + drow[3].ToString());
            //        drow.Delete();
            //    }
            //    DTDatoParametrosMetodo.AcceptChanges();
            //    DataRow NuevaFila = DTDatoParametrosMetodo.NewRow();
            //    NuevaFila["indicemetodo"] = Convert.ToInt64(DgvMetodosfilaActiva.Cells[0].Value);
            //    NuevaFila["nombre"] = DgvVariablesFilaSeleccionada.Cells[0].Value;
            //    NuevaFila["tipo"] = DgvVariablesFilaSeleccionada.Cells[1].Value;
            //    NuevaFila["io"] = DgvVariablesFilaSeleccionada.Cells[2].Value;

            //    // Agregar una nueva fila a la tabla de memoria.
            //    DTDatoParametrosMetodo.Rows.Add(NuevaFila);
            //}
            //else
            //{
            //    //MessageBox.Show("NO Existe DATA en memoria");
            //    DataRow NuevaFila = DTDatoParametrosMetodo.NewRow();
            //    NuevaFila["indicemetodo"] = Convert.ToInt64(DgvMetodosfilaActiva.Cells[0].Value);
            //    NuevaFila["nombre"] = DgvVariablesFilaSeleccionada.Cells[0].Value;
            //    NuevaFila["tipo"] = DgvVariablesFilaSeleccionada.Cells[1].Value;
            //    NuevaFila["io"] = DgvVariablesFilaSeleccionada.Cells[2].Value;
                
            //    // Agregar una nueva fila a la tabla de memoria.
            //    DTDatoParametrosMetodo.Rows.Add(NuevaFila);
            //}
        }

        private void DgvVariables_CurrentCellChanged(object sender, EventArgs e)
        {

            //if (DgvVariables.CurrentRow != null)
            //{
            //    DataGridViewRow DgvMetodosfilaActiva = DgvMetodos.CurrentRow;

            //    DataGridViewRow DgvVariablesFilaSeleccionada = DgvVariables.CurrentRow;

            //    //string nombreColumna = DgvVariables.Columns[e.ColumnIndex].Name;
            //    //object nuevoValor = DgvVariables.Rows[e.RowIndex].Cells[e.ColumnIndex].Value;

            //    MessageBox.Show("Indice: " + DgvMetodosfilaActiva.Cells[0].Value.ToString());

            //    DataRow[] DTBuscarDataParametro = DTDatoParametrosMetodo.Select("indice = " + Convert.ToInt64(DgvMetodosfilaActiva.Cells[0].Value));
            //    if (DTBuscarDataParametro.Length > 0)
            //    {
            //        MessageBox.Show("Existe DATA en memoria");
            //        foreach (var drow in DTBuscarDataParametro)
            //        {
            //            MessageBox.Show(drow[0].ToString() + " - " + drow[1].ToString() + " - " + drow[2].ToString() + " - " + drow[3].ToString());
            //            drow.Delete();
            //        }
            //        DTDatoParametrosMetodo.AcceptChanges();
            //        DataRow NuevaFila = DTDatoParametrosMetodo.NewRow();
            //        NuevaFila["indicemetodo"] = Convert.ToInt64(DgvMetodosfilaActiva.Cells[0].Value);
            //        NuevaFila["nombre"] = DgvVariablesFilaSeleccionada.Cells[0].Value;
            //        NuevaFila["tipo"] = DgvVariablesFilaSeleccionada.Cells[1].Value;
            //        NuevaFila["io"] = DgvVariablesFilaSeleccionada.Cells[2].Value;

            //        // Agregar una nueva fila a la tabla de memoria.
            //        DTDatoParametrosMetodo.Rows.Add(NuevaFila);
            //    }
            //    else
            //    {
            //        //MessageBox.Show("NO Existe DATA en memoria");
            //        DataRow NuevaFila = DTDatoParametrosMetodo.NewRow();
            //        NuevaFila["indicemetodo"] = Convert.ToInt64(DgvMetodosfilaActiva.Cells[0].Value);
            //        NuevaFila["nombre"] = DgvVariablesFilaSeleccionada.Cells[0].Value;
            //        NuevaFila["tipo"] = DgvVariablesFilaSeleccionada.Cells[1].Value;
            //        NuevaFila["io"] = DgvVariablesFilaSeleccionada.Cells[2].Value;

            //        // Agregar una nueva fila a la tabla de memoria.
            //        DTDatoParametrosMetodo.Rows.Add(NuevaFila);
            //    }
            //}

        }

        private void DgvVariables_RowLeave(object sender, DataGridViewCellEventArgs e)
        {

            //int fila = e.RowIndex;

            //DataGridViewRow DgvMetodosfilaActiva = DgvMetodos.CurrentRow;

            ////DataGridViewRow DgvVariablesFilaSeleccionada = DgvVariables.CurrentRow;

            ////string nombreColumna = DgvVariables.Columns[e.ColumnIndex].Name;
            ////object nuevoValor = DgvVariables.Rows[e.RowIndex].Cells[e.ColumnIndex].Value;

            ////MessageBox.Show("Indice: " + DgvMetodosfilaActiva.Cells[0].Value.ToString());

            //DataRow[] DTBuscarDataParametro = DTDatoParametrosMetodo.Select("indice = " + Convert.ToInt64(DgvMetodosfilaActiva.Cells[0].Value));

            //if (DTBuscarDataParametro.Length > 0)
            //{
            //    MessageBox.Show("Existe DATA en memoria");
            //    foreach (var drow in DTBuscarDataParametro)
            //    {
            //        MessageBox.Show(drow[0].ToString() + " - " + drow[1].ToString() + " - " + drow[2].ToString() + " - " + drow[3].ToString());
            //        drow.Delete();
            //    }
            //    DTDatoParametrosMetodo.AcceptChanges();
            //    DataRow NuevaFila = DTDatoParametrosMetodo.NewRow();
            //    NuevaFila["indicemetodo"] = Convert.ToInt64(DgvMetodosfilaActiva.Cells[0].Value);
            //    NuevaFila["nombre"] = DgvVariables.Rows[fila].Cells[0].Value;
            //    NuevaFila["tipo"] = DgvVariables.Rows[fila].Cells[1].Value;
            //    NuevaFila["io"] = DgvVariables.Rows[fila].Cells[2].Value;

            //    // Agregar una nueva fila a la tabla de memoria.
            //    DTDatoParametrosMetodo.Rows.Add(NuevaFila);
            //}
            //else
            //{
            //    //MessageBox.Show("NO Existe DATA en memoria");
            //    DataRow NuevaFila = DTDatoParametrosMetodo.NewRow();
            //    NuevaFila["indicemetodo"] = Convert.ToInt64(DgvMetodosfilaActiva.Cells[0].Value);
            //    NuevaFila["nombre"] = DgvVariables.Rows[fila].Cells[0].Value;
            //    NuevaFila["tipo"] = DgvVariables.Rows[fila].Cells[1].Value;
            //    NuevaFila["io"] = DgvVariables.Rows[fila].Cells[2].Value;

            //    // Agregar una nueva fila a la tabla de memoria.
            //    DTDatoParametrosMetodo.Rows.Add(NuevaFila);
            //}
            
        }

        private void DgvVariables_Leave(object sender, EventArgs e)
        {
            ////if ((DgvVariables.RowCount - 1) > 0)
            ////{
            //    DataGridViewRow DgvMetodosfilaActiva = DgvMetodos.CurrentRow;
            //foreach (DataGridViewRow row in DgvVariables.Rows)
            //{
            //    try
            //    {
            //        MessageBox.Show("Data " + DgvMetodosfilaActiva.Cells[0].Value.ToString() + "fila : " + row.Cells["indiceparametro"].Value.ToString() + " - Parametro: " + row.Cells["nombre"].Value.ToString() + " - Tipo: " + row.Cells["tipo"].Value.ToString() + " - IN/OUT" + row.Cells["io"].Value.ToString());
            //    }
            //    catch
            //    {
            //    }
            //}
            ////}

            DataGridViewRow DgvMetodosfilaActiva = DgvMetodos.CurrentRow;

            foreach (DataGridViewRow fila in DgvVariables.Rows)
            {

                DataRow[] DTBuscarDataParametro = DTDatoParametrosMetodo.Select("indicemetodo = " + Convert.ToInt64(DgvMetodosfilaActiva.Cells[0].Value));

                if (DTBuscarDataParametro.Length > 0)
                {
                    MessageBox.Show("Existe DATA en memoria");
                    foreach (var drow in DTBuscarDataParametro)
                    {
                        //MessageBox.Show(drow[0].ToString() + " - " + drow[1].ToString() + " - " + drow[2].ToString() + " - " + drow[3].ToString());
                        drow.Delete();
                    }
                    DTDatoParametrosMetodo.AcceptChanges();
                    DataRow NuevaFila = DTDatoParametrosMetodo.NewRow();
                    NuevaFila["indicemetodo"] = Convert.ToInt64(DgvMetodosfilaActiva.Cells[0].Value);
                    NuevaFila["indiceparametro"] = fila.Cells[0].Value;
                    NuevaFila["nombre"] = fila.Cells[1].Value;
                    NuevaFila["tipo"] = fila.Cells[2].Value;
                    NuevaFila["io"] = fila.Cells[3].Value;

                    // Agregar una nueva fila a la tabla de memoria.
                    DTDatoParametrosMetodo.Rows.Add(NuevaFila);
                    MessageBox.Show("Metodo: " + DgvMetodosfilaActiva.Cells[0].Value.ToString() + " - Parametro: " + fila.Cells[0].Value.ToString() + " - Nombre:" + fila.Cells[1].Value.ToString() + " - Tipo: " + fila.Cells[2].Value.ToString() + " - I/O: " + fila.Cells[3].Value.ToString());

                }
                else
                {
                    MessageBox.Show("NO Existe DATA en memoria");
                    DataRow NuevaFila = DTDatoParametrosMetodo.NewRow();
                    NuevaFila["indicemetodo"] = Convert.ToInt64(DgvMetodosfilaActiva.Cells[0].Value);
                    NuevaFila["indiceparametro"] = fila.Cells[0].Value;
                    NuevaFila["nombre"] = fila.Cells[1].Value;
                    NuevaFila["tipo"] = fila.Cells[2].Value;
                    NuevaFila["io"] = fila.Cells[3].Value;

                    // Agregar una nueva fila a la tabla de memoria.
                    DTDatoParametrosMetodo.Rows.Add(NuevaFila);
                    MessageBox.Show("Metodo: " + DgvMetodosfilaActiva.Cells[0].Value.ToString() + " - Parametro: " + fila.Cells[0].Value.ToString() + " - Nombre:" + fila.Cells[1].Value.ToString() + " - Tipo: " + fila.Cells[2].Value.ToString() + " - I/O: " + fila.Cells[3].Value.ToString());

                }
            }
        }

        private void DgvVariables_UserAddedRow(object sender, DataGridViewRowEventArgs e)
        {
            e.Row.Cells["indiceparametro"].Value = nuIndiceParametro;
            nuIndiceParametro = nuIndiceParametro + 1;
        }

        private void DgvVariables_Enter(object sender, EventArgs e)
        {
            DataGridViewRow DgvMetodosfilaActiva = DgvMetodos.CurrentRow;

            foreach (DataGridViewRow fila in DgvVariables.Rows)
            {

                DataRow[] DTBuscarDataParametro = DTDatoParametrosMetodo.Select("indicemetodo = " + Convert.ToInt64(DgvMetodosfilaActiva.Cells[0].Value));

                if (DTBuscarDataParametro.Length > 0)
                {
                    foreach (var filedata in DTBuscarDataParametro)
                    {
                        MessageBox.Show(filedata[0].ToString() + " - " + filedata[1].ToString() + " - " + filedata[2].ToString() + " - " + filedata[3].ToString() + " - " + filedata[4].ToString());
                    }
                }
            }
        }
    }
}
