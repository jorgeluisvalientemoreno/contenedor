using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace SINCECOMP.FNB.UI
{
    public partial class IFIFAP : Form
    {
        Boolean ventaMateriales;
        Boolean ventaNormal;
        Boolean aceptar;

        public IFIFAP()
        {
            InitializeComponent();
        }

        public Boolean VentaMateriales
        {
            get { return ventaMateriales; }
            set { ventaMateriales = value; }
        }

        public Boolean VentaNormal
        {
            get { return ventaNormal; }
            set { ventaNormal = value; }
        }

        public Boolean Aceptar
        {
            get { return aceptar; }
            set { aceptar = value; }
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void buttonAceptar_Click(object sender, EventArgs e)
        {
            VentaNormal = rdvNormal.Checked;
            VentaMateriales = rdvMateriales.Checked;
            Aceptar = true;
            this.Close();
        }

        private void buttonCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void TmrControl_Tick(object sender, EventArgs e)
        {
            buttonAceptar.PerformClick();
        }
    }
}
