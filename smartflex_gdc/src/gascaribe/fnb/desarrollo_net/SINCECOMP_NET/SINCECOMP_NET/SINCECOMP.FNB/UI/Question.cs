using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;

namespace SINCECOMP.FNB.UI
{
    public partial class Question : OpenForm
    {
        public Int64 answer;

        public Question(String Title, String Texto, String Opc1, String Opc2, String Opc3)
        {
            InitializeComponent();
            this.Text = Title;
            this.lblMessage.Text = Texto;
            this.btnopc1.Text = Opc1;
            this.btnopc2.Text = Opc2;
            this.btnopc3.Text = Opc3;
        }

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