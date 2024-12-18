using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using SINCECOMP.FNB.BL;

namespace SINCECOMP.FNB.UI
{
    public partial class LDRAV : OpenForm 
    {
        BLGENERAL general = new BLGENERAL();
        private long packageId;

        public LDRAV()
        {
            InitializeComponent();
        }

        /**
         * Constructor utilizado cuando se llama la forma a nivel de solicitud.
         * vhurtadoSAO212591
         */
        public LDRAV(long packageId) : this()
        {
            tbNumberSecuence.TextBoxValue = general.getConsecutiveByPackage(Convert.ToString(packageId));
            tbNumberSecuence.Enabled = false;
            this.packageId = packageId;
            //CASO 200-1880
            oSTBSolVenta.TextBoxValue = packageId.ToString();
            oSTBSolVenta.Enabled = false;
            //CASO 200-1880
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnProcess_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(tbNumberSecuence.TextBoxValue) && String.IsNullOrEmpty(oSTBSolVenta.TextBoxValue))
            {
                general.mensajeERROR("No se Ingreso Consecutivo de Venta o Solicitud de Venta Valido");//Debe digitar un Consecutivo de Venta");
            }
            else
            {
                String package_Id;

                if (tbNumberSecuence.Enabled)
                {
                    //general.mensajeERROR("oSTBSolVenta.TextBoxValue[" + oSTBSolVenta.TextBoxValue + "]");
                    if (String.IsNullOrEmpty(oSTBSolVenta.TextBoxValue))
                    {
                        package_Id = general.getPackageByConsecutive(tbNumberSecuence.TextBoxValue);
                    }
                    else
                    {
                        package_Id = oSTBSolVenta.TextBoxValue;

                    }
                    //general.mensajeERROR("package_Id[" + package_Id + "]");
                    
                }
                else
                {
                    package_Id = Convert.ToString(this.packageId);
                }

                if (!String.IsNullOrEmpty(package_Id))
                {
                    LDSALEREPORT forma = new LDSALEREPORT(package_Id);
                    forma.Show();
                }
                else
                {
                    general.mensajeERROR("No se Ingreso Consecutivo de Venta o Solicitud de Venta Valido");
                }
            }
        }

        private void oSTBSolVenta_Validating(object sender, CancelEventArgs e)
        {

        }
    }
}