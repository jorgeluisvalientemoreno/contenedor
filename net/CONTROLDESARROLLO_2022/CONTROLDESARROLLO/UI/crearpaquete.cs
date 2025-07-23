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
        DataTable DTDatoParametrosServicio = new DataTable();
        /////////////////////////////////////////////////////////////////////////

        public crearpaquete()
        {
            InitializeComponent();


            //Creacion de campos de la tabla de memoria
            DTDatoParametrosServicio.Columns.Clear();
            DTDatoParametrosServicio.Rows.Clear();
            DTDatoParametrosServicio.Columns.Add("indice");
            DTDatoParametrosServicio.Columns.Add("nombre_servicio");
            DTDatoParametrosServicio.Columns.Add("nombre_columna");
            DTDatoParametrosServicio.Columns.Add("tipo");
            DTDatoParametrosServicio.Columns.Add("io");
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
            textColumnIndiceMetodo.HeaderText = "Indice";
            textColumnIndiceMetodo.Name = "indice";
            textColumnIndiceMetodo.Visible = false;
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
            DgvMetodos.Rows[0].Cells[0].Value = 0;
            
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
                            TxbLogica.Text = TxbLogica.Text + "function " + row.Cells["nombre"].Value.ToString() + "IS RETURN " + row.Cells["Retorno"].Value.ToString() + ";" + Environment.NewLine;
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
                            TxbLogica.Text = TxbLogica.Text + "procedure " + row.Cells["nombre"].Value.ToString() + ";" + Environment.NewLine;
                        }
                        else
                        {
                            TxbLogica.Text = TxbLogica.Text + "function " + row.Cells["nombre"].Value.ToString() + "IS RETURN " + row.Cells["Retorno"].Value.ToString() + ";" + Environment.NewLine;
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

        private void DgvMetodos_RowsAdded(object sender, DataGridViewRowsAddedEventArgs e)
        {
            //MessageBox.Show("Indice: " + e.RowIndex);
            // Asegúrate de que haya al menos una fila
            if (DgvMetodos.CurrentRow != null && DgvMetodos.CurrentRow.Index >= 0)
            {

                String sbIndice = DgvMetodos.Rows[DgvMetodos.CurrentRow.Index - 1].Cells[0].Value.ToString();

                DgvMetodos.Rows[e.RowIndex].Cells[0].Value = int.Parse(sbIndice) + 1;

                MessageBox.Show("Valor celda Indice: " + e.RowIndex);

            }
        }

        private void DgvMetodos_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            //if (e.RowIndex >= 0)
            //{
            //    DataGridViewRow filaSeleccionada = DgvMetodos.Rows[e.RowIndex];
            //    string valor = filaSeleccionada.Cells["indice"].Value.ToString();
            //    MessageBox.Show("Fila seleccionada: " + valor);
            //}
        }
    }
}
