using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using OpenSystems.Security.ExecutableMgr;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;


namespace CONTROLDESARROLLO.UI
{
    public partial class ACD : OpenForm
    {
        public ACD()
        {
            InitializeComponent();
        }

        private void ACD_Load(object sender, EventArgs e)
        {

        }

        private void menufuncioncreacion_Click(object sender, EventArgs e)
        {
            using (crearfuncion form = new crearfuncion())
            {
                form.ShowDialog();
            }
        }

        private void validacionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (valimp form = new valimp())
            {
                form.ShowDialog();
            }
        }

        private void crecionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (crearprocedimiento form = new crearprocedimiento())
            {
                form.ShowDialog();
            }
        }

        private void creacionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (crearpaquete form = new crearpaquete())
            {
                form.ShowDialog();
            }

        }


    }
}
