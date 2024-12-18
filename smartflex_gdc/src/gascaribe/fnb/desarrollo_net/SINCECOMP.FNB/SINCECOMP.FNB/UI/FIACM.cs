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

namespace SINCECOMP.FNB.UI
{
    public partial class FIACM : OpenForm
    {
        BLGENERAL general = new BLGENERAL();
        Boolean start;

        public FIACM()
        {
            InitializeComponent();
            start = false;
            dtp_InitialDate.Value = DateTime.Now;
            dtp_FinalDate.Value = DateTime.Now;
            tb_observation.Length = 200;
            start = true;
        }

        private void btn_filesearch_Click(object sender, EventArgs e)
        {
            if (DialogResult.OK == ofdFile.ShowDialog())
                tb_filepath .TextBoxValue  = ofdFile.FileName;
        }

        Boolean validar()
        {
            if ( String.IsNullOrEmpty(tbSubscription.TextBoxValue) || tbQuotaValue.TextBoxValue == "" || tb_observation.TextBoxValue == "" )
            { return false; }
            
            return true;
        }

        private void btnProcess_Click(object sender, EventArgs e)
        {

            Double quotaManual;
            
            
            if (validar())
            {
                if (Double.TryParse(tbQuotaValue.TextBoxValue, out quotaManual))
                {

                    if (Double.Parse(tbQuotaValue.TextBoxValue) > 0)
                    {


                        System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                        DataTable consultaId = general.getValueList("select * from suscripc d where d.susccodi = " + tbSubscription.TextBoxValue);
                    
                            Int64 inumanual_quota_id = BLFIACM.consExtraQuota();
                            Int64 inusubscription_id = Convert.ToInt64(tbSubscription.TextBoxValue);
                            Int64 inuquotavalue = Convert.ToInt64(tbQuotaValue.TextBoxValue);
                            DateTime inuinitial_date;
                            
                        if (dtp_InitialDate.Value.ToString().Trim() == "")
                                inuinitial_date = DateTime.Now;
                            else
                                inuinitial_date = Convert.ToDateTime(dtp_InitialDate.Value);
                            
                        
                        String inufinal_date;
                            if (dtp_FinalDate.Value.ToString() == "")
                                inufinal_date = null;//Convert.ToDateTime("01/01/2001"); EVESAN
                            else
                                inufinal_date = Convert.ToDateTime(dtp_FinalDate.Value).ToString("dd/MM/yyyy");



                            /*
                             String idtsinesterdate;
                                if (dtpSinisterDate.Value.ToString() != "")
                                    idtsinesterdate = Convert.ToDateTime(dtpSinisterDate.Value).ToString("dd/MM/yyyy");
                                else
                                    idtsinesterdate = null;
                             */







                            String inusupport_file = tb_filepath.TextBoxValue;
                            String inuobservation = tb_observation.TextBoxValue;
                            String inuprint_in_bill;
                            if (chk_printbill.Checked == true)
                                inuprint_in_bill = "Y";
                            else
                                inuprint_in_bill = "N";

                            Double quota;
                            DateTime? initialDate;
                            DateTime? finalDate;
                            BLFIACM.getManualQuota(inusubscription_id, inuinitial_date, inufinal_date, out quota, out initialDate, out finalDate);
                            Int64 answer;
                            if (quota > 0)
                            {
                                    Question pregunta = new Question("FIACM - Actualizacion de Cupos", "El Contrato " + tbSubscription.TextBoxValue + " ya tiene un cupo manual asignado por valor de $" + quota + ", de " + initialDate + " a " + finalDate + ". ¿Desea Actualizarlo?", "Si", "No");
                                    pregunta.ShowDialog();
                                    answer = pregunta.answer;
                            }
                            else 
                            {
                                if (quota == -1)
                                    answer = 2;
                                else
                                {
                                    Question pregunta = new Question("FIACM - Actualizacion de Cupos", "El Contrato " + tbSubscription.TextBoxValue + " tiene mas de un cupo configurado para en el rango de fechas escrito. Antes de continuar, favor validar los datos. ¿Desea Actualizarlo de todos modos?", "Si", "No");
                                    pregunta.ShowDialog();
                                    answer = pregunta.answer;
                                }
                            }
                            if (answer == 2)
                            {
                                BLFIACM.insertQuota(inumanual_quota_id, inusubscription_id, inuquotavalue, inuinitial_date, inufinal_date, inusupport_file, inuobservation, inuprint_in_bill);
                                general.doCommit(); //BLFIACM.Save();
                                general.mensajeOk("Cupo Manual Registrado");
                                tbSubscription.TextBoxValue = "";
                                tbQuotaValue.TextBoxValue = "";
                                start = false;
                                dtp_InitialDate.Value = DateTime.Now;
                                dtp_FinalDate.Value = DateTime.Now;
                                start = true;
                                tb_filepath.TextBoxValue = "";
                                tb_observation.TextBoxValue = "";
                                chk_printbill.Checked = false;
                            }
                        } else {
                        general.mensajeERROR("El valor del cupo debe ser mayor que cero");}
                    

                        System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Default;
                    }else { general.mensajeERROR("El campo cupo manual esta en nulo"); }
            }
            else 
            {
            general.mensajeERROR("No ha digitado todos los campos requeridos");
            }
            
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void dtp_InitialDate_ValueChanged(object sender, EventArgs e)
        {
            if (start)
            {
                if (dtp_InitialDate.Value.ToString().Trim() == "")
                {
                    start = false;
                    dtp_FinalDate.Value = "";
                    start = true;
                }
                else
                {
                    DateTime fecha = Convert.ToDateTime (dtp_InitialDate.Value);
                    if (Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy")) > Convert.ToDateTime(fecha.ToString("dd/MM/yyyy")))
                    {
                        general.mensajeERROR("Fecha Inicial no puede ser inferior a la fecha actual");
                        start = false;
                        dtp_InitialDate.Value = DateTime.Now;
                        start = true;
                    }
                }
            }
        }

        private void dtp_FinalDate_ValueChanged(object sender, EventArgs e)
        {
            if (start)
            {
                if (dtp_FinalDate.Value.ToString().Trim() != "")
                {
                    DateTime fecFin = Convert.ToDateTime(dtp_FinalDate.Value);
                    DateTime fecAct = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy"));

                    if (fecFin < fecAct)
                    {
                        general.mensajeERROR("Fecha final no puede ser inferior a la fecha actual");
                        start = false;
                        dtp_FinalDate.Value = DateTime.Now;
                        start = true;
                    }
                    else
                    {
                        DateTime  fechai;
                        if (dtp_InitialDate.Value.ToString().Trim() == "")
                            fechai = fecAct;
                        else
                            fechai = Convert.ToDateTime (dtp_InitialDate.Value);
                        DateTime  fechaf = Convert.ToDateTime (dtp_FinalDate.Value);
                        if (Convert.ToDateTime(fechai.ToString("dd/MM/yyyy")) > Convert.ToDateTime(fechaf.ToString("dd/MM/yyyy")))
                        {
                            general.mensajeERROR("Fecha Final no puede ser inferior a fecha Inicial");
                            start = false;
                            dtp_FinalDate.Value = dtp_InitialDate .Value ;
                            start = true;
                        }
                    }
                }
            }
        }

        Boolean control = true;

        private void tbQuotaValue_TextBoxValueChanged(object sender, EventArgs e)
        {
            if (control)
            {
                try
                {
                    if (tbQuotaValue.TextBoxValue.ToString() != "")
                    {
                        if (Convert.ToInt64(tbQuotaValue.TextBoxValue) <= 0)
                        {
                            general.mensajeERROR("El valor debe ser mayor que 0");
                            tbQuotaValue.TextBoxValue = "";
                        }
                    }
                }
                catch
                {
                    tbQuotaValue.TextBoxValue = "";
                }
            }
        }

        private void tbQuotaValue_Leave(object sender, EventArgs e)
        {
            if (control)
            {
                if (general.ValidarTexto(tbQuotaValue.TextBoxValue) == "")
                {
                    control = false;
                    tbQuotaValue.TextBoxValue = "";
                    general.mensajeERROR("El valor del cupo no debe ser nulo");
                    tbQuotaValue.Focus();
                    control = true;
                }
            }
        }

    }
}