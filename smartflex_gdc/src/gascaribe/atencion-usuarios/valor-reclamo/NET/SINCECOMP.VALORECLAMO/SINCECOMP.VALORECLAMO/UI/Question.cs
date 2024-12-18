using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;

namespace SINCECOMP.VALORECLAMO.UI
{
    public partial class Question : OpenForm
    {
        public Int64 answer;

        /// <summary>
        /// BOTON1 = 1 - BOTON2 = 2 - BOTON3 = 3 
        /// </summary>
        /// <param name="Title">TITULO DE LA VENTANA</param>
        /// <param name="Texto">PREGUNTA EN LA VENTANA</param>
        /// <param name="Opc1">TEXTO PARA EL PRIMER BOTON</param>
        /// <param name="Opc2">TEXTO PARA EL SEGUNDO BOTON</param>
        /// <param name="Opc3">TEXTO PARA EL TERCER BOTON</param>
        public Question(String Title, String Texto, String Opc1, String Opc2, String Opc3)
        {
            InitializeComponent();
            this.Text = Title;
            this.lblMessage.Text = Texto;
            this.btnopc1.Text = Opc1;
            this.btnopc2.Text = Opc2;
            this.btnopc3.Text = Opc3;
        }

        /// <summary>
        /// BOTON1 = 2 - BOTON2 = 3
        /// </summary>
        /// <param name="Title">TITULO DE LA VENTANA</param>
        /// <param name="Texto">PREGUNTA EN LA VENTANA</param>
        /// <param name="Opc1">TEXTO PARA EL PRIMER BOTON</param>
        /// <param name="Opc2">TEXTO PARA EL SEGUNDO BOTON</param>
        public Question(String Title, String Texto, String Opc1, String Opc2)
        {
            InitializeComponent();
            this.Text = Title;
            this.lblMessage.Text = Texto;
            this.btnopc2.Text = Opc1;
            this.btnopc3.Text = Opc2;
            this.btnopc1.Visible = false;
        }

        private void btnopc1_Click(object sender, EventArgs e)
        {
            answer = 1;
            this.Close();
        }

        private void btnopc2_Click(object sender, EventArgs e)
        {
            answer = 2;
            this.Close();
        }

        private void btnopc3_Click(object sender, EventArgs e)
        {
            answer = 3;
            this.Close();
        }
    }
}
