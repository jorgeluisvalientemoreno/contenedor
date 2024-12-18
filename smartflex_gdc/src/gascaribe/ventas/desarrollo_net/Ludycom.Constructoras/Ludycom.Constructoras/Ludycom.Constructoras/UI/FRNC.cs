using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Ludycom.Constructoras.BL;
using OpenSystems.Windows.Controls;
using OpenSystems.Common.ExceptionHandler;

namespace Ludycom.Constructoras.UI
{
    public partial class FRNC : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLFDRCC blFDRCC = new BLFDRCC();

        private Int64 project;
        private Int64 quotation;
        private String quotationStatus = "R";

        public String QuotationStatus
        {
            get { return quotationStatus; }
            set { quotationStatus = value; }
        }

        public FRNC(Int64 project, Int64 quotation)
        {
            InitializeComponent();
            this.project = project;
            this.quotation = quotation;
            InitializeData();
        }

        public void InitializeData()
        {
            //Se obtienen los datos de las actividades
            DataTable dtActivities = utilities.getListOfValue(BLGeneralQueries.strBuilderActivities);

            //Se construye la lista de las actividades
            ocActivities.DataSource = dtActivities;
            ocActivities.DisplayMember = "Description";
            ocActivities.ValueMember = "Id";

            //Se obtienen los datos de los ciclos
            DataTable dtCycles = utilities.getListOfValue(BLGeneralQueries.BuilderCycles);

            //Se construye la lista de los ciclos
            ocCycle.DataSource = dtCycles;
            ocCycle.DisplayMember = "Description";
            ocCycle.ValueMember = "Id";
        }

        private void btnAccept_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(tbBillCollectAddress.Address_id))
            {
                if (!(Convert.ToInt64(ocActivities.Value) > 0))
                {
                    utilities.DisplayErrorMessage("Debe seleccionar la actividad");
                    return;
                }

                if (!(Convert.ToInt64(ocCycle.Value) > 0))
                {
                    utilities.DisplayErrorMessage("Debe seleccionar el ciclo");
                    return;
                }

                try
                {
                    blFDRCC.PreApproveQuotation(project, quotation, Convert.ToInt64(tbBillCollectAddress.Address_id), Convert.ToInt64(ocActivities.Value), Convert.ToInt32(ocCycle.Value));
                    utilities.doCommit();
                    quotationStatus = "P";
                    utilities.DisplayInfoMessage("La cotización [" +quotation+ "] del proyecto ["+project+"] ha sido pre-aprobada exitosamente");
                    this.Close();   
                }
                catch (Exception ex)
                {
                    utilities.doRollback();
                    GlobalExceptionProcessing.ShowErrorException(ex);
                    return;
                }
            }
            else
            {
                utilities.DisplayErrorMessage("Debe digitar la dirección");
            }
        }
    }
}
