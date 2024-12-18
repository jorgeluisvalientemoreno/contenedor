using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
//
using SINCECOMP.SUBSIDYS.BL;
using System.IO;

namespace SINCECOMP.SUBSIDYS.UI
{
    public partial class LDISU : OpenForm
    {
        public LDISU()
        {
            InitializeComponent();
        }

        BLGENERAL general = new BLGENERAL();

        private void btnProcess_Click(object sender, EventArgs e)
        {
            if (general.validarPath(tbArchiveubication.TextBoxValue))
            {
                if (File.Exists(tbArchiveubication.TextBoxValue))
                {
                    if (BLLDISU.readFile(tbArchiveubication.TextBoxValue) == true)
                    {
                        MessageBox.Show("El proceso culmin� de forma exitosa");
                    }
                    else
                    {
                        MessageBox.Show("Proceso termin� con errores. Ver el archivo de inconsistencias generado en la misma ubicaci�n del archivo procesado");
                    }
                }
                else
                {
                    MessageBox.Show("El archivo no existe","Ruta inv�lida",MessageBoxButtons.OK,MessageBoxIcon.Error);
                }
            }
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            ofdFile.ShowDialog();
            tbArchiveubication.TextBoxValue = ofdFile.FileName;
        }
    }
}