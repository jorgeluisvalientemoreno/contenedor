using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;

namespace LODPDT.UI
{
    public partial class frm_texto : OpenForm
    {
        public String texto;
        public String textoO;

        public frm_texto(String nombre, String boton, int longitud, String textoR)
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

        private void frm_texto_FormClosed(object sender, FormClosedEventArgs e)
        {

        }

        private void btn_cancelar_Click(object sender, EventArgs e)
        {
            texto = textoO;
            this.Close();
        }
    }
}
