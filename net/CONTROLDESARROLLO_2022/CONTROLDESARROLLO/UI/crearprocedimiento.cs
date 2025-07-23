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
    public partial class crearprocedimiento : Form
    {
        BLGENERAL BlGeneral = new BLGENERAL();

        public crearprocedimiento()
        {
            InitializeComponent();
        }

        private void crearprocedimiento_Load(object sender, EventArgs e)
        {

            CbxEsquema.Items.Add("PERSONALIZACIONES");
            CbxEsquema.Items.Add("ADM_PERSON");
            CbxEsquema.Items.Add("OPEN");

            // Seleccionar el primer elemento por defecto
            CbxEsquema.SelectedIndex = 0;
            
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
        }

        private void BtnProcesar_Click(object sender, EventArgs e)
        {

            TxbLogica.Text = BlGeneral.FsbEstructuraProcedimiento(CbxEsquema.Text.ToLower(), TbxNombre.Text, DgvVariables, "N");

            //MessageBox.Show("Seleccionaste: " + CbxTipo.SelectedIndex.ToString() + " - " + CbxTipo.SelectedItem.ToString());

            //TxbLogica.Text = "create or replace procedure " + CbxEsquema.Text.ToLower() + "." + TbxNombre.Text;
            //////////////////////////
            //if (DgvVariables.RowCount > 0)
            //{
            //    int NuCantidadFilas = DgvVariables.Rows.Count;

            //    TxbLogica.Text = TxbLogica.Text + "(" + Environment.NewLine;
            //    foreach (DataGridViewRow row in DgvVariables.Rows)
            //    {
            //        if (!row.IsNewRow) // Ignorar la fila nueva
            //        {
            //            //MessageBox.Show("ID: {id}, Nombre: {nombre}, Edad: {edad}");
            //            TxbLogica.Text = TxbLogica.Text + row.Cells["nombre"].Value.ToString() + " " + row.Cells["io"].Value.ToString() + " " + row.Cells["tipo"].Value.ToString();
            //        }
            //        NuCantidadFilas = NuCantidadFilas - 1;

            //        if (NuCantidadFilas > 1)
            //        {
            //            TxbLogica.Text = TxbLogica.Text + "," + Environment.NewLine;
            //        }
                    
            //    }
            //    TxbLogica.Text = TxbLogica.Text + ") IS " + Environment.NewLine;
                
            //}
            ///////////////////////////
            //TxbLogica.Text = TxbLogica.Text + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "  csbMetodo CONSTANT VARCHAR2(100) := '" + TbxNombre.Text + "';" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "  onuErrorCode    number;" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "  osbErrorMessage varchar2(4000);" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "  cnuNVLTRC CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef;" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "BEGIN" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "  pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "  pkg_traza.trace('Traza', cnuNVLTRC);" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "  pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "EXCEPTION" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "  WHEN pkg_error.CONTROLLED_ERROR THEN" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "    pkg_Error.getError(OnuErrorCode, OsbErrorMessage);" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "    pkg_traza.trace('Error: ' || OsbErrorMessage,cnuNVLTRC);" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "    pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERC);" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "    raise pkg_error.CONTROLLED_ERROR;" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "  WHEN OTHERS THEN" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "    pkg_Error.setError;" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "    pkg_Error.getError(OnuErrorCode, OsbErrorMessage);" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "    pkg_traza.trace('Error: ' || OsbErrorMessage,cnuNVLTRC);" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "    pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERR);" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "    raise pkg_error.CONTROLLED_ERROR;" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "END;" + Environment.NewLine;
            //TxbLogica.Text = TxbLogica.Text + "/" + Environment.NewLine;

            //if (CbxEsquema.Text.ToUpper() != "OPEN")
            //{
            //    TxbLogica.Text = TxbLogica.Text + "BEGIN" + Environment.NewLine;
            //    TxbLogica.Text = TxbLogica.Text + "  pkg_utilidades.prAplicarPermisos('" + TbxNombre.Text.ToUpper() + "','" + CbxEsquema.Text.ToUpper() + "');" + Environment.NewLine;
            //    TxbLogica.Text = TxbLogica.Text + "END;" + Environment.NewLine;
            //    TxbLogica.Text = TxbLogica.Text + "/" + Environment.NewLine;
            //    TxbLogica.Text = TxbLogica.Text + "BEGIN" + Environment.NewLine;
            //    TxbLogica.Text = TxbLogica.Text + "  pkg_utilidades.prCrearSinonimos('" + TbxNombre.Text.ToUpper() + "','" + CbxEsquema.Text.ToUpper() + "');" + Environment.NewLine;
            //    TxbLogica.Text = TxbLogica.Text + "END;" + Environment.NewLine;
            //    TxbLogica.Text = TxbLogica.Text + "/" + Environment.NewLine;

            //}

        }        
    }
}
