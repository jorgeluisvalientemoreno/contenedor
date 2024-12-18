using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Util;
using OpenSystems.Component.Framework;
using OpenSystems.Windows.Controls;
using OpenSystems.Common;
using OpenSystems.Common.Data;
using System.Data.Common;
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.Common.Util;
using System.Resources;
using System.Reflection;


namespace LDCIMP
{
    public partial class LDCIMP : OpenForm
    {
        private OpenSystems.Windows.Controls.OpenHeaderTitles Header = null;
        private Int64 nuSubscriptionId;
        private Decimal nuTotal;

        public LDCIMP(Int64 inuSusc)
        {
            this.nuSubscriptionId = inuSusc;
            InitializeComponent();          
            this.LoadData();
        }

        private void LoadData()
        {
            DataSet _dsReturn = initProducts(this.nuSubscriptionId);

            DataTable dt = new DataTable();

            dt.Columns.Add("Producto");
            dt.Columns.Add("Tipo Producto");
            dt.Columns.Add("Suma Corriente");
            dt.Columns.Add("Deuda 30 días");
            dt.Columns.Add("Deuda 60 días");
            dt.Columns.Add("Deuda 90 días");
            dt.Columns.Add("Deuda 91 días");
            dt.Columns.Add("Total");

            foreach (DataRow row in _dsReturn.Tables[0].Rows)
            {
                DataRow rowdg = dt.NewRow();
                rowdg["Producto"] = row["PRODUCTO"];                
                rowdg["Tipo Producto"] = row["Tipo Producto"].ToString();
                rowdg["Suma Corriente"] = row["SUMACORRIENTE"];
                rowdg["Deuda 30 días"] = row["SUMA30"];
                rowdg["Deuda 60 días"] = row["SUMA60"];
                rowdg["Deuda 90 días"] = row["SUMA90"];
                rowdg["Deuda 91 días"] = row["SUMA91"];
                rowdg["Total"] = Convert.ToDecimal(row["SUMACORRIENTE"]) + Convert.ToDecimal(row["SUMA30"]) + Convert.ToDecimal(row["SUMA60"]) + Convert.ToDecimal(row["SUMA90"]) + Convert.ToDecimal(row["SUMA91"]);

                nuTotal = nuTotal + Convert.ToDecimal(rowdg["Total"]);
                dt.Rows.Add(rowdg);             
            }

            this.txtTotal.Text = nuTotal.ToString();
            
            this.dtgProducts.DataSource = dt;

            this.dtgProducts.Columns["Producto"].ReadOnly = true;
            this.dtgProducts.Columns["Tipo Producto"].ReadOnly = true;
            this.dtgProducts.Columns["Suma Corriente"].ReadOnly = true;
            this.dtgProducts.Columns["Deuda 30 días"].ReadOnly = true;
            this.dtgProducts.Columns["Deuda 90 días"].ReadOnly = true;
            this.dtgProducts.Columns["Deuda 91 días"].ReadOnly = true;
            this.dtgProducts.Columns["Total"].ReadOnly = false;
        }

        internal static DataSet initProducts(Int64 inuSusc)
        {
            DataSet _dsReturn = new DataSet();

            try
            {
                using (DbCommand dbCommand = OpenDataBase.db.GetStoredProcCommand("ldc_pk_product_validate.GETPRODUCTSBYCONTRACT"))
                {
                    OpenDataBase.db.AddInParameter(dbCommand, "inuSesususc", DbType.Int64, inuSusc); // 105162);
                    OpenDataBase.db.AddParameterRefCursor(dbCommand);
                    _dsReturn = OpenDataBase.db.ExecuteDataSet(dbCommand);                                               
                }
            }
            catch (Exception)
            {
                throw;
            }
            return _dsReturn;
        }       

        private void button1_Click(object sender, EventArgs e)
        {
            this.LoadData();
        }

        private string validateValueProduct(Int64 inuSusc, Int64 inuProductId, Decimal inuValue) 
        {
            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_pk_product_validate.VALIDATE_EXECUTE_PARCIAL_PAY"))
                {
                    string sbOk = "N";
                    //Se hace el llamado a la bd para la validación
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuValorTotal", DbType.Decimal, inuValue);
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuSubscription", DbType.Int64, inuSusc);
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuProductId", DbType.Int64, inuProductId);
                    OpenDataBase.db.AddOutParameter(cmdCommand, "osbOk", DbType.String, 1000);

                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                    sbOk = OpenConvert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbOk"));

                    return sbOk;
                }
            }
            catch (Exception)
            {
                throw;                
            }
        }

        private void btnProcesar_Click(object sender, EventArgs e)
        {
            //Se obtiene el valor del producto seleccinado
            Int64 nuProductId = -1;
            Decimal nuValueTotal = -1;
            String sbFlag = "Y";

            string sbProductType = "";
            foreach (DataGridViewRow item in this.dtgProducts.Rows)
            {
                sbProductType = item.Cells["Tipo Producto"].Value.ToString();
                nuProductId = Convert.ToInt64(item.Cells["Producto"].Value.ToString());
                nuValueTotal = Convert.ToDecimal(item.Cells["Total"].Value.ToString());                
                
                //Si el producto es de servicios financieros se realiza la validación
                if (sbProductType == "7055 - Servicios Financieros" || sbProductType == "7056 - Servicios Financieros PROMIGAS")
                {
                    if (nuValueTotal < 0)
                    {
                        ExceptionHandler.EvaluateErrorCode(2741, "El valor a pagar debe ser mayor a cero.");
                    }
                    sbFlag = this.validateValueProduct(this.nuSubscriptionId, nuProductId, nuValueTotal);
                }                 
            }

            nuValueTotal = Convert.ToDecimal(this.txtTotal.Text);

            this.ProcessFormat(this.nuSubscriptionId, nuProductId, nuValueTotal);                    

            this.Close();
        }

        private void ProcessFormat(Int64 inuSusc, Int64 inuProductId, Decimal inuValueTotal)
        {
            //Crea el trámite de pagos parciales
            this.CreatePackages(inuSusc, inuValueTotal);   
        }      
       
        private void CreatePackages(Int64 inuSusc, Decimal inuValorTotal)
        {
            Int64 nuEntityId = 2012; // Código de ge_entity PS_PACKAGE_TYPE
            Int64 nuPackageTypeId = 100039; 
            String sbWorkInstance = "WORK_INSTANCE";

            // Datos a instanciar - Contrato
            String sbSubsEntName = "SUSCRIPC";
            String sbSuscEntityPK = "SUSCCODI";
            // Factura
            String sbBillName = "FACTURA";
            String sbBillPK = "FACTCODI";
            String sbBillColValue = "FACTVAAP";
            // Mo_process
            String sbProcessName = "MO_PROCESS";
            String sbProcessFlag = "FLAG";
            String sbIsLaunch = "Y";

            // Se carga dinamicamente el assembly OpenSystems.Process.Executortramites para eliminar referencia circular
            Assembly assembly = Assembly.Load("OpenSystems.Process.Executor, Version=0.0.2.1, Culture=neutral, PublicKeyToken=1a886a7826ec4444");
            Type type = assembly.GetType("OpenSystems.Process.Executor.Register.Forms.RegisterHandler");

            // Inicia el llamado de tramite
            type.InvokeMember("InitRegister", BindingFlags.Default | BindingFlags.InvokeMethod, null, null, new object[] { "" + nuPackageTypeId, "" + -1, "" });
            // Indica a la instancia que el trámite fue lanzado desde la forma
            OpenSystems.Common.InstanceHandler.Instance.AddAttributeToInstance(sbWorkInstance, string.Empty, sbProcessName, sbProcessFlag, "" + sbIsLaunch);
            // Sube datos de factura a la instancia
            OpenSystems.Common.InstanceHandler.Instance.AddAttributeToInstance(sbWorkInstance, string.Empty, sbBillName, sbBillPK, "" + -1);
            // Sube el contrato a la instancia
            OpenSystems.Common.InstanceHandler.Instance.AddAttributeToInstance(sbWorkInstance, string.Empty, sbSubsEntName, sbSuscEntityPK, "" + inuSusc);
            // Sube el valor a pagar a la instancia
            OpenSystems.Common.InstanceHandler.Instance.AddAttributeToInstance(sbWorkInstance, string.Empty, sbBillName, sbBillColValue, "" + inuValorTotal);
            // Ejecuta la forma del tramite
            type.InvokeMember("Process", BindingFlags.Default | BindingFlags.InvokeMethod, null, null, new object[] { Header, nuPackageTypeId, null, nuEntityId, "LDC - Impresión pagos parciales por contrato" });           
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void dtgProducts_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {            
            Decimal nuValueTotal = 0;
            foreach (DataGridViewRow item in this.dtgProducts.Rows)
            {                
                nuValueTotal = nuValueTotal + Convert.ToDecimal(item.Cells["Total"].Value.ToString()); ;
            }
            this.txtTotal.Text = nuValueTotal.ToString();   
        }
             
    }

    
}
