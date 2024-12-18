using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
//
using SINCECOMP.FNB.BL;

namespace SINCECOMP.FNB.Controls
{
    public partial class ctrlGELPPB : UserControl
    {
        String typeUser;
        Int64 userId;
        Boolean start;
        BLGENERAL general = new BLGENERAL();
        String msjError;

        public ctrlGELPPB(String typeuser, Int64 userid)
        {
            InitializeComponent();
            start = false;
            //validaciones de usuario
            typeUser = typeuser;
            userId = userid;
            //combo lista de precio base
            if (typeuser=="F")
                cbPriceList.DataSource = general.getValueList(BLConsultas.ListadePreciosControladasC + " order by price_list_id");
            else
                cbPriceList.DataSource = general.getValueList(BLConsultas.ListadePreciosControladasC + " and SUPPLIER_ID = " + userId + " order by price_list_id");
            cbPriceList.DisplayMember = "Descripcion";
            cbPriceList.ValueMember = "Codigo";
            //proveedor
            cbSupplier.DataSource = general.getValueList(BLConsultas.ProveedorC);
            cbSupplier.DisplayMember = "Nombre";
            cbSupplier.ValueMember = "Identificacion";
            tbDateInitial2.TextBoxValue = DateTime.Now.ToString("dd/MM/yyyy");
            ucDateInitial1.Value = ""; 
            ucDateFinal1.Value = ""; 
            start = true;

            // se validan las fechas de modificacion
            if (typeUser != "F")
            {
                //validar fecha limite
                DataRow[] dataLimitDate = general.limitDate(userId.ToString());
                if (dataLimitDate.Length > 0)
                {
                    String dateinitial = dataLimitDate[0][2].ToString().Substring(0, 10) + " " + dataLimitDate[0][4].ToString();
                    String datelimit = dataLimitDate[0][3].ToString().Substring(0, 10) + " " + dataLimitDate[0][5].ToString();
                    if (!(Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy HH:mm")) >= Convert.ToDateTime(dateinitial) && Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy HH:mm")) <= Convert.ToDateTime(datelimit)))
                    {                                                                   
                        btnProcess.Enabled = false;
                        btnCancel.Enabled = false;
                    }
                }
            }

        }

        private void cbPriceList_ValueChanged(object sender, EventArgs e)
        {
            if (start)
            {
                try
                {
                    DataRow[] dataPriceList = BLGELPPB.priceList(userId.ToString(), typeUser, cbPriceList.Value.ToString());
                    tbDescription1.TextBoxValue = Convert.ToString(dataPriceList[0]["DESCRIPTION"]);
                    try
                    {
                        ucDateInitial1.Value = ""; 
                        ucDateInitial1.Value = dataPriceList[0]["INITIAL_DATE"].ToString();
                    }
                    catch
                    {
                        ucDateInitial1.Value = ""; 
                    }
                    try
                    {
                        ucDateFinal1.Value = ""; 
                        ucDateFinal1.Value = dataPriceList[0]["FINAL_DATE"].ToString();
                    }
                    catch
                    {
                        ucDateFinal1.Value = ""; 
                    }
                    cbSupplier.Value = Convert.ToInt64(dataPriceList[0]["SUPPLIER_ID"]);
                }
                catch
                {
                    tbDescription1.TextBoxValue = "";
                    ucDateInitial1.Value = "";
                    ucDateFinal1.Value = "";
                    cbSupplier.Value = "";
                }
            }
        }

        Boolean validate()
        {
            if (cbPriceList.Text == "")
            {
                msjError = "Debera seleccionar una Lista de Precios";
                return false;
            }
            tbDescription2.Focus ();
            if (tbDescription2.TextBoxValue == "")
            {
                msjError = "Debera ingresar la Descripción para la Lista de Precios";
                return false;
            }
            if (tbDateInitial2.TextBoxValue == null)
            {
                msjError = "Debera ingresar una Fecha Inicial";
                return false;
            }
            if (ucDateFinal2.TextBoxValue == null)
            {
                msjError = "Debera ingresar una Fecha Final";
                return false;
            }
            return true;
        }

        private void btnProcess_Click(object sender, EventArgs e)
        {
            msjError = "";
            if (validate())
            {
                String[] p1 = new string[] { "Int64", "String", "DateTime", "DateTime", "Int64" };
                String[] p2 = new string[] { "inuprice_list_id", "isbdescription", "idtinitial_date", "idtfinal_date", "insupplier_id" };
                Object[] p3 = new object[] { cbPriceList.Value, tbDescription2.TextBoxValue.ToString(), Convert.ToDateTime(tbDateInitial2.TextBoxValue), Convert.ToDateTime(ucDateFinal2.TextBoxValue), cbSupplier.Value };
                general.executeMethod(BLConsultas.copyList, 5, p1, p2, p3);
                //
                general.doCommit(); //BLGELPPB.Save();
                general.mensajeOk("Lista creada Satisfactoriamente");
                start = false;
                cbPriceList.Value = "";
                start = true;
                tbDescription1.TextBoxValue = "";
                ucDateInitial1.Value = "";
                ucDateFinal1.Value = "";
                cbSupplier.Value = "";
                tbDescription2.TextBoxValue = "";
                tbDateInitial2.TextBoxValue = DateTime.Now.ToString("dd/MM/yyyy");
                ucDateFinal2.TextBoxValue = DateTime.Now.ToString("dd/MM/yyyy");
            }
            else
            {
                if (msjError !="")
                    general.mensajeERROR(msjError);
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            Form.ActiveForm.Close();
        }

        private void ucDateFinal2_TextBoxValueChanged(object sender, EventArgs e)
        {
            if (start)
            {
                if (ucDateFinal2.TextBoxValue != null)
                {
                    if (DateTime.Compare(Convert.ToDateTime(ucDateFinal2.TextBoxValue), Convert.ToDateTime(tbDateInitial2.TextBoxValue)) < 0)
                    {
                        general.mensajeERROR("La fecha Final no debe ser Nula, ni Menor o igual que la fecha Inicial");
                        ucDateFinal2.TextBoxValue = tbDateInitial2.TextBoxValue; //= DateTime.Now.ToString("dd/MM/yyyy");
                    }
                    else if (DateTime.Compare(Convert.ToDateTime(ucDateFinal2.TextBoxValue), Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy"))) < 0)
                    {
                        general.mensajeERROR("La fecha Final debe ser Mayor o igual que la fecha Actual");
                        ucDateFinal2.TextBoxValue = tbDateInitial2.TextBoxValue; //= DateTime.Now.ToString("dd/MM/yyyy");
                    }
                }
                else if (ucDateFinal2.TextBoxValue == null)
                {
                    general.mensajeERROR("La fecha Final no debe ser Nula, ni Menor que la fecha Inicial");
                    ucDateFinal2.TextBoxValue = tbDateInitial2.TextBoxValue; //= DateTime.Now.ToString("dd/MM/yyyy");
                }
            }
        }

        private void tbDateInitial2_TextBoxValueChanged(object sender, EventArgs e)
        {
            if (start)
            {
                if (tbDateInitial2.TextBoxValue != null && ucDateFinal2.TextBoxValue != null)
                {
                    if (DateTime.Compare(Convert.ToDateTime(ucDateFinal2.TextBoxValue), Convert.ToDateTime(tbDateInitial2.TextBoxValue)) < 0)
                    {
                        general.mensajeERROR("La fecha Inicial no debe ser Nula, ni Mayor que la fecha Final");
                        tbDateInitial2.TextBoxValue = DateTime.Now.ToString("dd/MM/yyyy");
                    }
                    else if (DateTime.Compare(Convert.ToDateTime(tbDateInitial2.TextBoxValue),Convert .ToDateTime(DateTime.Now.ToString("dd/MM/yyyy"))) < 0)
                    {
                        general.mensajeERROR("La fecha Inicial debe ser Mayor o igual que la fecha Actual");
                        tbDateInitial2.TextBoxValue = DateTime.Now.ToString("dd/MM/yyyy");
                    }
                }
                else if(tbDateInitial2.TextBoxValue == null)
                {
                    general.mensajeERROR("La fecha Inicial no debe ser Nula, ni Mayor que la fecha Final");
                    tbDateInitial2.TextBoxValue = DateTime.Now.ToString("dd/MM/yyyy");
                }
            }
        }
        
    }
}
