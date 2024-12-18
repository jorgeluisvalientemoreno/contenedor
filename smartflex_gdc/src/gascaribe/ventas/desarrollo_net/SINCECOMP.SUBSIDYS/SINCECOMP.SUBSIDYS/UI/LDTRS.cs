using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.SUBSIDYS.BL;

namespace SINCECOMP.SUBSIDYS.UI
{
    public partial class LDTRS : OpenForm
    {
        public LDTRS()
        {
            InitializeComponent();
        }

        BLGENERAL general = new BLGENERAL();

        private void btnImport_Click_1(object sender, EventArgs e)
        {
            ofdFile.ShowDialog();
            tbArchiveubication.TextBoxValue = ofdFile.FileName;
        }

        private void btnProcess_Click(object sender, EventArgs e)
        {
            if (general.validarPath(tbArchiveubication.TextBoxValue))
            {
                if (blLDTRS.readFile(tbArchiveubication.TextBoxValue) == true)
                {
                    MessageBox.Show("Proceso Exitoso.");
                }
                else
                {
                    MessageBox.Show("Proceso termino con errores. Ver Archivo de Inconsistencias. Generado en la misma ubicación del archivo procesado.");
                }
            }
        }
    }
}