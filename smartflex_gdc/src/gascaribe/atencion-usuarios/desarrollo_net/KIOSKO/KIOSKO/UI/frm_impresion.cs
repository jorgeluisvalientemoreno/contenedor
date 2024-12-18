using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using KIOSKO.Report;
using System.Threading;

namespace KIOSKO.UI
{
    public partial class frm_impresion : OpenForm
    {

        cr_factura plantilla;

        public frm_impresion(cr_factura factura)
        {
            InitializeComponent();
            plantilla = factura;
        }

        private void frm_impresion_Load(object sender, EventArgs e)
        {
            System.Drawing.Printing.PrinterSettings instance = new System.Drawing.Printing.PrinterSettings();
            plantilla.PrintOptions.PrinterName = instance.PrinterName;
            //Thread.Sleep(5000);
            lbl_impresora.Text = "Imprimiendo en [ " + instance.PrinterName + " ]";
            plantilla.PrintToPrinter(1, false, 0, 0);
            this.Close();
        }
    }
}
