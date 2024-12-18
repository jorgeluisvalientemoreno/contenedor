using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;

namespace LEMADOPA.UI
{
    public partial class FRMTEXTO : OpenForm
    {

        public String texto;
        public String textoO;

        public FRMTEXTO(String nombre, String boton, int longitud, String textoR)
        {
            InitializeComponent();
            this.Text = nombre;
            this.btn_boton.Text = boton;
            this.txt_texto.MaxLength = longitud;
            this.txt_texto.Text = textoR;
            textoO = textoR;
        }

        private void btn_boton_Click(object sender, EventArgs e)
        {
            texto = txt_texto.Text;
            this.Close();
        }

        private void FRMTEXTO_FormClosed(object sender, FormClosedEventArgs e)
        {
            
        }

        private void btn_cancelar_Click(object sender, EventArgs e)
        {
            texto = textoO;
            this.Close();
        }
    }
}
