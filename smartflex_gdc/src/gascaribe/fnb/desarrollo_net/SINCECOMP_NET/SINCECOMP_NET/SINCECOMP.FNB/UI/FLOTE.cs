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
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.UI
{
    public partial class FLOTE : OpenForm
    {
        BLGENERAL general = new BLGENERAL();
        BLFLOTE _blFLOTE = new BLFLOTE();
        Boolean start;
        int notify = 0;
        int selection = 0;

        public FLOTE()
        {
            start = false;
            InitializeComponent();
            
            start = true;
            Int64 TypeCausal = Convert.ToInt64(general.getParam("TYPE_CAU_LEG_ORD_DEL", "Int64"));
            Int64 TypeTask = Convert.ToInt64(general.getParam("CODI_TITR_EFNB", "Int64"));

            String causalSelect = "select a.causal_id id , a.description  description FROM  ge_causal a, or_task_type_causal b WHERE a.causal_type_id  = "
                + TypeCausal + " AND b.task_type_id = " + TypeTask + " AND a.causal_id = b.causal_id";

            DataTable causalList = general.getValueList(causalSelect);

            
            ocCausal.DataSource = causalList;
            ocCausal.ValueMember = "id";
            ocCausal.DisplayMember = "description";

            cbClient.Select_Statement =
                "SELECT subscriber_id id, subscriber_name || ' ' || subs_last_name description " +
                "FROM ge_subscriber " +
                "@WHERE @" +
                "@subscriber_id = :ID @" +
                "@upper(subscriber_name || ' ' || subs_last_name) like '%' || :DESCRIPTION || '%' @";


            //Inicio CASO 200-85
            //Bloquear objetos para evitar el manejo de materiales
            valorRealVenta.Visible = false;
            labelValorRealVenta.Visible = false;
            //Fin CASO 200-85

        }

        private void openButton1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btn_Search_Click(object sender, EventArgs e)
        {
            Int64? valor = null;
            Int64? inuorder = string.IsNullOrEmpty(tb_number.TextBoxValue) ? valor : Convert.ToInt64(tb_number.TextBoxValue);
            Int64? inupackage = string.IsNullOrEmpty(tb_request.TextBoxValue) ? valor : Convert.ToInt64(tb_request.TextBoxValue);
            Int64? nuClient = string.IsNullOrEmpty(cbClient.TextValue) ? valor : Convert.ToInt64(cbClient.TextValue);
            DateTime idtdatemin = string.IsNullOrEmpty(uc_datemin.Text) ? Convert.ToDateTime("01/01/1900") : Convert.ToDateTime(uc_datemin.Text);
            DateTime idtdatemax = string.IsNullOrEmpty(uc_datemax.Text) ? Convert.ToDateTime("12/12/2032") : Convert.ToDateTime(uc_datemax.Text);
            List<OrderFILOT> ListOrder = new List<OrderFILOT>();
            ListOrder = BLFLOTE.FcuFLOTE(inupackage, inuorder, nuClient, idtdatemin, idtdatemax);
            orderFILOTBindingSource.DataSource = ListOrder;
            //EVESAN 02/Julio/2013
            if(ListOrder.Count == 0)
                general.mensajeERROR("No se encontraron órdenes con los parámetros de búsqueda ingresados");
            ////////////////////////
            foreach (UltraGridRow row in dgv_Register.Rows)
            {
                row.Cells["Exito"].Activation = Activation.NoEdit;
            }

            ////CASO 200-1164
            ////Desabilitar las filas de las ordenes relacionadas a un item de seguro voluntario
            //Int64 nuFNUORDENSEGUROVOLUNTARIO = 0;
            //foreach (UltraGridRow row in dgv_Register.Rows)
            //{
            //    nuFNUORDENSEGUROVOLUNTARIO = _blFLOTE.FNUORDENSEGUROVOLUNTARIO((Int64)row.Cells["ActivityId"].Value);
            //    if (nuFNUORDENSEGUROVOLUNTARIO == 1)
            //    {
            //        row.Activation = Activation.NoEdit;
            //    }
            //}
            ////CASO 200-1164

            orderFILOTBindingSource.Sort = "orderId asc";
        }

        private void uc_datemin_ValueChanged(object sender, EventArgs e)
        {
            if (start)
            {
                if (uc_datemin.Text != "" && uc_datemax.Text != "")
                {
                    if (DateTime.Compare(Convert.ToDateTime(uc_datemax.Text), Convert.ToDateTime(uc_datemin.Text)) < 0)
                    {
                        start = false;
                        general.mensajeERROR("La fecha Minima no debe ser Mayor que la fecha Maxima");
                        uc_datemin.Text = "";
                    }
                }
            }
            start = true;
        }

        private void uc_datemax_ValueChanged(object sender, EventArgs e)
        {
            if (start)
            {
                if (uc_datemax.Text != "" && uc_datemin.Text != "")
                {
                    if (DateTime.Compare(Convert.ToDateTime(uc_datemax.Text), Convert.ToDateTime(uc_datemin.Text)) < 0)
                    {
                        start = false;
                        general.mensajeERROR("La fecha Maxima no debe ser Menor que la fecha Minima");
                        uc_datemax.Text = "";
                    }
                }
            }
            start = true;
        }

        private void btn_Clean_Click(object sender, EventArgs e)
        {
            ////////
            //LDRVOUCHER_GDC Windowpagare = new LDRVOUCHER_GDC("15673552",2);
            //Windowpagare.Show();
            ////////
            ////////
            //LDCPU_GDC Windowpagare = new LDCPU_GDC("15670525");
            //Windowpagare.Show();
            ////////
            ////////
            //LDCPU_GDC Windowpagare1 = new LDCPU_GDC("15671518");
            //Windowpagare1.Show();
            ////////
            limpiar();
        }

        void limpiar()
        {
            start = false;
            tb_request.TextBoxValue = "";
            tb_number.TextBoxValue = "";
            cbClient.TextValue = "";
            uc_datemin.Text = "";
            uc_datemax.Text = "";
            //EVESAN 02/Julio/2013
            //Se resetea el binding de la grilla "dgv_Register" para limpiarla
            orderFILOTBindingSource.Clear();
            ///////////////////////////////////////////////////
            start = true;
        }

        private void btnprocess_Click(object sender, EventArgs e)
        {
            
            if (ocCausal.Value != null)
            {
                Int64 orderTmp = -1;
                Int64 articleId;
                String ActivityChain = "";
                String successValue;
                String comment = null;
                String invoice = null;
                int sw = 0;
                
                //orderFILOTBindingSource.Filter = "Selection = true";
                //Agordillo Cambio.6853
                //Se obtiene el campo Valor Real Venta
                Int64 nuValorReal = Convert.ToInt64(valorRealVenta.TextBoxValue);

                foreach (OrderFILOT x in orderFILOTBindingSource)
                {
                    if (x.Selection == true)
                    {
                        if (IsAvalidRow())
                        { 
                            if (x.Exito)
                            {
                                successValue = "1";
                            }
                            else
                            {
                                successValue = "0";
                            }

                            if (orderTmp != -1)
                            {
                                if (orderTmp == x.OrderId)
                                {
                                    ActivityChain = ActivityChain + "|" + x.ActivityId + "," + successValue;

                                    //KCienfuegos.RNP156 
                                    if (String.IsNullOrEmpty(comment))
                                    {
                                        comment = x.OrderComment;
                                    }
                                    else
                                    {
                                        if (!String.IsNullOrEmpty(x.OrderComment))
                                        {
                                            comment = comment + " - " + x.OrderComment;
                                        }
                                    }

                                    //KCienfuegos.RNP1224 
                                    if (!String.IsNullOrEmpty(x.InvoiceNumber))
                                    {
                                        invoice = x.InvoiceNumber;
                                    }
                                }
                                else
                                {
                                    //Agordillo Caso.6853 04-10-2015
                                    // Se valida si la orden es de materiales ingrese el valor Real de la Venta
                                    if (_blFLOTE.fblOrdenMaterialSale(orderTmp))
                                    {
                                        Int64 nuValorSale = _blFLOTE.fnugetValorSale(orderTmp);

                                        if (nuValorReal == null || nuValorReal==0)
                                        {
                                            general.mensajeERROR("La orden " + orderTmp + " es de Venta de Materiales por Favor Ingrese el valor Real de la Venta");
                                            return;
                                        }
                                        // Agordillo Cambio.6853
                                        // Se valida que el Valor Real Venta no se mayor del de la venta                                 
                                        if (nuValorReal > nuValorSale)
                                        {
                                            general.mensajeERROR("El Valor Real, no puede ser mayor al valor con Inicial de la venta");
                                            return;
                                        }
                                    }
                                    else if (nuValorReal > 0)
                                    {
                                        general.mensajeERROR("La orden no es de Venta de Materiales por favor no diligencie el campo Valor Real de la Venta");
                                        return;
                                    }

                                    //Agordillo Cambio.6853
                                    // Se envia como parametro adicional a la funcion el Valor Real de la Venta
                                    BLFLOTE.legalizeOrder(orderTmp, Int32.Parse(ocCausal.Value.ToString()), ActivityChain, nuValorReal);
                                    /*KCienfuegos.RNP156 26-08-2014*/
                                    if (comment != null)
                                    {
                                        BLFLOTE.commentDelOrder(orderTmp, comment);
                                    }
                                    /*******************************/
                                    /*KCienfuegos.1224 13-01-2015*/
                                    if (invoice != null)
                                    {
                                        BLFLOTE.registerInvoice(orderTmp, invoice);
                                    }
                                    /*******************************/

                                    // CAMBIO 3603 Se hace commit por cada orden legalizada para evitar bloqueos
                                    general.doCommit();
                                    orderTmp = x.OrderId;
                                    ActivityChain = x.ActivityId + "," + successValue;
                                    comment = x.OrderComment;
                                    invoice = x.InvoiceNumber; //RNP1224
                                }
                            }
                            else
                            {
                                orderTmp = x.OrderId;
                                articleId = x.ArticleId;
                                ActivityChain = x.ActivityId + "," + successValue;
                                comment = x.OrderComment;
                                invoice = x.InvoiceNumber;
                            }
                        }
                        else
                        {
                            if (sw == 0)
                            {
                                general.mensajeERROR("El campo Número de Factura debe ser diligenciado");
                            }
                            sw = 1;
                        }
                    }
                }
                //EVESAN 02/Julio/2013
                if (orderTmp != -1)
                {

                    //Agordillo Caso.6853 04-10-2015
                    // Se valida si la orden es de materiales ingrese el valor Real de la Venta
                    if (_blFLOTE.fblOrdenMaterialSale(orderTmp))
                    {
                        // Se obtiene el valor de la Vta
                        Int64 nuValorSale = _blFLOTE.fnugetValorSale(orderTmp);

                        if (nuValorReal == null || nuValorReal == 0)
                        {
                            general.mensajeERROR("La orden " + orderTmp + " es de Venta de Materiales por Favor Ingrese el Valor Real de la Venta");
                            return;
                        }
                        // Agordillo Cambio.6853
                        // Se valida que el Valor Real Venta no se mayor del de la venta                                 
                        if (nuValorReal > nuValorSale)
                        {
                            general.mensajeERROR("El Valor Real, no puede ser mayor al valor con Inicial de la venta");
                            return;
                        }

                    }
                    else if (nuValorReal> 0) 
                    {
                        general.mensajeERROR("La orden no es de Venta de Materiales por favor no diligencie el campo Valor Real de la Venta");
                        return;
                    }

                    //Agordillo Caso.6853 04-10-2015
                    // Se agrega el parametro nuValorReal de entrada a la funcion de Legalizar
                    BLFLOTE.legalizeOrder(orderTmp, Int32.Parse(ocCausal.Value.ToString()), ActivityChain, nuValorReal);
                    /*KCienfuegos.RNP156 26-08-2014*/
                    if (comment != null)
                    {
                        BLFLOTE.commentDelOrder(orderTmp, comment);
                    }
                    /*******************************/
                    /*KCienfuegos.RNP1224 13-01-2015*/
                    if (invoice != null)
                    {
                        BLFLOTE.registerInvoice(orderTmp, invoice);
                    }
                    /*******************************/

                    // CAMBIO 3603
                    general.doCommit(); 
                    general.mensajeOk("El proceso finalizó con Éxito");
                    limpiar();
                }
                else if (sw == 0)
                {
                    general.mensajeERROR("No se ha seleccionado las órdenes que se van a legalizar");
                }
                ///////////////////////////////////////
            }
            else 
            {
                general.mensajeERROR("Por favor seleccione la Causal de Legalización");
            }
        }

        private void FLOTE_Load(object sender, EventArgs e)
        {
            
        }

        private void dgv_Register_AfterCellUpdate(object sender, CellEventArgs e)
        {


        }

        private void dgv_Register_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {
            //
        }

        private void dgv_Register_CellChange(object sender, CellEventArgs e)
        {
            if (e.Cell.Column.Key == "Selection")
            {
                OrderFILOT tmp = (OrderFILOT)orderFILOTBindingSource.Current;

                Boolean value = !(Boolean)e.Cell.Value;
                Int64 OrderId = (Int64)e.Cell.Row.Cells["OrderId"].Value;
                Int64 ActivityId = (Int64)e.Cell.Row.Cells["ActivityId"].Value;
                selection = 1;


                foreach (OrderFILOT x in orderFILOTBindingSource)
                {
                    

                    if (OrderId == x.OrderId)
                    {
                        x.Selection = value;
                        x.Exito = value;
                    }
                }
                

                foreach (UltraGridRow row in dgv_Register.Rows)
                {
                    notify = 1;
                    if ((Int64)row.Cells["OrderId"].Value == OrderId)
                    {
                        if (value == true)
                        {
                            row.Cells["Exito"].Activation = Activation.AllowEdit;
                        }
                        else
                        {
                            row.Cells["Exito"].Activation = Activation.NoEdit;
                        }

                        if (Convert.ToBoolean(row.Cells["Exito"].Value)) {
                            row.Cells["InvoiceNumber"].Activation = Activation.AllowEdit;
                            dgv_Register.ActiveCell = row.Cells["InvoiceNumber"];
                            dgv_Register.PerformAction(Infragistics.Win.UltraWinGrid.UltraGridAction.EnterEditMode);
                            
                        }
                        else{
                            row.Cells["InvoiceNumber"].Value = null;
                            row.Cells["InvoiceNumber"].Activation = Activation.NoEdit;
                            dgv_Register.ActiveCell = row.Cells["InvoiceNumber"];
                            dgv_Register.PerformAction(Infragistics.Win.UltraWinGrid.UltraGridAction.ExitEditMode);
                            
                        }

                    }
                }
                selection = 0;
                notify = 0;

                orderFILOTBindingSource.EndEdit();
                orderFILOTBindingSource.ResetBindings(false);
                dgv_Register.EndUpdate();
                
            }

            //********************15-01-2015 - KCienfuegos.RNP1224********************
            if (e.Cell.Column.Key == "Exito")
            {
                Boolean Entregado = !(Boolean)e.Cell.Value;
                Int64 OrderId = (Int64)e.Cell.Row.Cells["OrderId"].Value;
                Int64 ActivityId = (Int64)e.Cell.Row.Cells["ActivityId"].Value;

                 notify = 1;
                foreach (UltraGridRow row in dgv_Register.Rows)
                {
                    if ((Int64)row.Cells["ActivityId"].Value == ActivityId)
                    {
                        if (Entregado == true)
                        {
                            row.Cells["InvoiceNumber"].Activation = Activation.AllowEdit;
                            dgv_Register.ActiveCell = row.Cells["InvoiceNumber"];
                            dgv_Register.PerformAction(Infragistics.Win.UltraWinGrid.UltraGridAction.EnterEditMode);

                        }

                    }

                    if ((Int64)row.Cells["ActivityId"].Value == ActivityId)
                    {
                        if (Entregado == false)
                        {
                            row.Cells["InvoiceNumber"].Value = null;
                            row.Cells["InvoiceNumber"].Activation = Activation.NoEdit;
                            dgv_Register.ActiveCell = row.Cells["InvoiceNumber"];
                            dgv_Register.PerformAction(Infragistics.Win.UltraWinGrid.UltraGridAction.ExitEditMode);
                        }
                        
                    }
                }
                notify = 0;
                //********************FIN- KCienfuegos.RNP1224********************

                orderFILOTBindingSource.EndEdit();
                orderFILOTBindingSource.ResetBindings(false);
                dgv_Register.EndUpdate();
            }
        }

        //********************09-01-2015 - KCienfuegos.RNP1224********************
        private void dgv_Register_BeforeExitEditMode(object sender, EventArgs e)
        {

            UltraGridRow row = this.dgv_Register.ActiveRow;
            Boolean value = (Boolean)row.Cells["Exito"].Value;
            
            if (Convert.ToString(row.Cells["InvoiceNumber"].Value) == string.Empty & value)
            {
                general.mensajeERROR("Por favor ingresar el número de factura");
            }

        }

        private void dgv_Register_BeforeRowDeactivate(object sender, CancelEventArgs e)
        {
            
            if (dgv_Register.ActiveRow != null)
            {
                if (!IsAvalidRow())
                {
                    general.mensajeERROR("El campo Número de Factura debe ser diligenciado.");
                    e.Cancel = true;
                }
            }
        }

        private bool IsAvalidRow()
        {
            bool result = true;
            

            if (dgv_Register.ActiveRow != null)
            {
                UltraGridRow row = this.dgv_Register.ActiveRow;
                Boolean value = (Boolean)row.Cells["Exito"].Value;

                if (Convert.ToString(dgv_Register.ActiveRow.Cells["InvoiceNumber"].Value) == string.Empty & value & _blFLOTE.getParam("NUM_FACT_OBLIGATORIO") == "Y" & notify == 0) 
                {
                    result = false;
                }
            }

            return result;
        }

        private void dgv_Register_BeforeExitEditMode(object sender, Infragistics.Win.UltraWinGrid.BeforeExitEditModeEventArgs e)
        {
            int o = 1;
        }

        private void dgv_Register_AfterExitEditMode(object sender, EventArgs e)
        {

            UltraGridRow row = this.dgv_Register.ActiveRow;
            Boolean value = (Boolean)row.Cells["Exito"].Value;
            Int64 orderId = (Int64)row.Cells["OrderId"].Value;
            String invoice = (String)row.Cells["InvoiceNumber"].Value;

            if (invoice != String.Empty)
            {
                notify = 1;
                foreach (UltraGridRow rowppal in dgv_Register.Rows)
                {
                    if ((Int64)rowppal.Cells["OrderId"].Value == orderId)
                    {
                        if ((Boolean)rowppal.Cells["Exito"].Value == true)
                        {
                            rowppal.Cells["InvoiceNumber"].Value = invoice;

                        }

                    }

                }
                
                if (selection == 0)
                {
                    notify = 0;
                }
            }

        }

        private void valorRealVenta_Load(object sender, EventArgs e)
        {

        }
        //*********************FIN RNP1224*********************
    }
}