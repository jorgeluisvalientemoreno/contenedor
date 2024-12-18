using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using OpenSystems.Component.Configuration;
//
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.BL;


namespace SINCECOMP.FNB.UI
{
    public partial class LDINS : OpenForm
    {
        BindingSource customerbinding = new BindingSource();
        Int64 RequestId;
        BLGENERAL general = new BLGENERAL();

        public LDINS(Int64 requestId)
        {
            RequestId = requestId;
            InitializeComponent();
            tbRequestId.TextBoxValue   = RequestId.ToString();
            //vendedor
            cmbSeller.DataSource = general.getValueList("select person_id codigo,name_ nombre from ge_person");
            cmbSeller.DisplayMember = "nombre";
            cmbSeller.ValueMember = "codigo";
            //estado
            cmbState.DataSource = general.getValueList("select motive_status_id codigo,description descripcion from ps_motive_status");
            cmbState.DisplayMember = "descripcion";
            cmbState.ValueMember = "codigo";
            //tipo de solicitud
            cmbRequestType.DataSource = general.getValueList("select package_type_id codigo,description descripcion from ps_package_type");
            cmbRequestType.DisplayMember = "descripcion";
            cmbRequestType.ValueMember = "codigo";
            //notificacion
            cmbNotification.DataSource = general.getValueList("select g.notification_id codigo from mo_packages m, MO_NOTIFY_LOG_PACK n, GE_NOTIFICATION_LOG g where  n.package_id=m.package_id and g.notification_log_id=n.notification_log_id and m.package_id=" + RequestId.ToString());
            cmbNotification.DisplayMember = "codigo";
            cmbNotification.ValueMember = "codigo";
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            
                Decimal inuseller = Convert.ToDecimal(cmbSeller.Value); // 26;
                Decimal inupackage = Convert.ToDecimal(RequestId); //17505;
                Decimal inustatus = Convert.ToDecimal(cmbState.Value); //13;
                DateTime inuregisterdate = DateTime.MinValue; 
                if ( !String.IsNullOrEmpty(ostbRegisterDate.TextBoxValue))
                {
                    inuregisterdate = Convert.ToDateTime(ostbRegisterDate.TextBoxValue); 
                }
                 Decimal inunotificationid = Convert.ToDecimal(cmbNotification.Value); //100068;
                Decimal inupackagetype = Convert.ToDecimal(cmbRequestType.Value); //100262;
                List<RequestLDINS> ListNotification = new List<RequestLDINS>();
                ListNotification = BLLDINS.fcuNotification(inuseller, inupackage, inustatus, inuregisterdate, inunotificationid, inupackagetype);
                if (ListNotification.Count > 0)
                {

                    customerbinding.DataSource = ListNotification;
                    dgSearchresults.DataSource = customerbinding;
                }
                else 
                {
                    customerbinding.DataSource = ListNotification;
                    dgSearchresults.DataSource = customerbinding;
                    general.mensajeERROR("No se encontraron registros");
                    }

        }

        private void btnProcess_Click(object sender, EventArgs e)
        {
            Boolean print = false; 

            for (int i = 0; i <= dgSearchresults.Rows.Count - 1; i++)
            {
                if (Convert.ToBoolean(dgSearchresults.Rows[i].Cells["Print"].Value))
                {
                    print = true; 
                    ConfigurationHandler.PrintNotificationLogId(dgSearchresults.Rows[i].Cells["NotificationLogId"].Value);
                }
                
            }
            if(!print)
            {

                general.mensajeERROR("No ha seleccionado ninguna notificación"); 
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}