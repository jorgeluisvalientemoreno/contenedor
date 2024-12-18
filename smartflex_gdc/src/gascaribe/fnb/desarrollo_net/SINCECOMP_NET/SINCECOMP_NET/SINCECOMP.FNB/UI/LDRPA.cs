using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
//
using SINCECOMP.FNB.BL;
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.DAL;

namespace SINCECOMP.FNB.UI
{
    public partial class LDRPA : OpenForm 
    {
        BLGENERAL general = new BLGENERAL();

        public LDRPA()
        {
            InitializeComponent();
            List<ListSN> lista = new List<ListSN>();
            lista.Add(new ListSN("1", "Deudor"));
            lista.Add(new ListSN("2", "Codeudor"));
            BindingSource tabla = new BindingSource();
            tabla.DataSource = lista;
            cbType.DataSource = tabla;
            cbType.DisplayMember = "Description";
            cbType.ValueMember = "Id";
            cbType.Value = 1;
        }

        /**
         * Constructor utilizado cuando se llama la forma a nivel de solicitud.
         * vhurtadoSAO212591.
         */
        public LDRPA(Int64 packageId) : this()
        {
            tbNumberSecuence.TextBoxValue = Convert.ToString(DALLDAPR.getConsecutiveByReq(packageId));
            tbNumberSecuence.Enabled = false;
        }

        private void btnProcess_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(tbNumberSecuence.TextBoxValue))
            {
                general.mensajeERROR("Debe ingresar un Consecutivo");
            }
            else
            {
                DataTable dataConsec = general.getValueList("select NON_BA_FI_REQU_ID dato from ld_non_ba_fi_requ where DIGITAL_PROM_NOTE_CONS = " + tbNumberSecuence.TextBoxValue);
                if (dataConsec.Rows.Count == 0)
                    general.mensajeERROR("No existe ningun Pagare con este Consecutivo");
                else
                {
                    String msgCopy = "|";
                    Int64 cont = 0;
                    if (flClient.Checked)
                    {
                        msgCopy += "Copia Cliente." + cbType.Text + "|";
                        cont++;
                    }
                    if (flContrat.Checked)
                    {
                        msgCopy += "Copia Contratista/Proveedor." + cbType.Text + "|";
                        cont++;
                    }
                    if (flEntity.Checked)
                    {
                        msgCopy += "Copia Entidad Financiera." + cbType.Text + "|";
                        cont++;
                    }
                    if (cont>0)
                    {
                        msgCopy = cont.ToString() + msgCopy;
                        LDPAGARE PagClient = new LDPAGARE(Convert.ToInt64(dataConsec.Rows[0][0].ToString()), msgCopy);
                        PagClient.Show();
                    }
                    else
                        general.mensajeERROR("No selecciono ninguna opción de Copia");
                }
            }

        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

    }
}