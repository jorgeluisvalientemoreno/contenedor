/*===========================================================================================================
* Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : LDOA
 * Descripcion   : Aprobación de ordenes
 *                 
 * Autor         : 
 * Fecha         : 
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 05-09-2013   213430  LDiuza         1 - Se crea metodo <validRow> el cual se encarga de definir si una orden
 *                                         tiene asociada una causal cuando ha sido seleccionada para aprobar.
 *                                     2 - Se modifica el metodo <btn_Click> para validar la existencia de causal
 *                                         antes de procesar. Se levanta excepcion indicando al usuaro lo sucedido.
 *                                     3 - Se modifica el metodo <dgPendingOrders_CellChange> para corregir la validacion
 *                                         que activa el la lista de valores de causales. en caso de que una orden haya sido
 *                                         seleccionada para aprobar se muestra asterisco (*) rojo indicando obligatoriedad
 *                                     4 - Se crea metodo <dgPendingOrders_BeforeRowDeactivate>, se ejecunta cuando se haga 
 *                                         cambio de fila, valdando si la orden esta marcada para aprobar y si ya tiene asociada
 *                                         una causal. Se levanta excepcion en caso de que no se cumplan las condiciones.
 *                                     5 - Se crea el metodo <dgPendingOrders_BeforeRowActivate> para mostrar o esconder 
 *                                         asterisco (*) que define obligatoriedad de la causal cuando se cambie de fila.
 *=========================================================================================================*/
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
//
using OpenSystems.Windows.Controls;
using SINCECOMP.FNB.BL;
using SINCECOMP.FNB.Entities;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.UI
{
    public partial class LDOA : OpenForm
    {

        //columnas de ordenes pendientes por aprobacion
        String a = "Order";
        String b = "StateOrder";
        String c = "Contract";
        String d = "Approval";
        String f = "CausalId";
        String g = "Selection";
        String h = "RegisterDate";
        //variables
        BLGENERAL general = new BLGENERAL();
        BLLDOA ldoa = new BLLDOA();
        BindingSource customerbinding = new BindingSource();
        BindingSource customerbinding1 = new BindingSource();

        public LDOA()
        {
            InitializeComponent();
            //cargar de los datos del procedimiento para las ordenes pendientes
            String[] p1 = new string[] { };
            String[] p2 = new string[] { };
            String[] p3 = new string[] { };
            //carga de la grilla de ordenes pendientes
            List<PendingOrdersLDOA> ListPendingOrders = new List<PendingOrdersLDOA>();
            ListPendingOrders = ldoa.FcuPendingOrders(BLConsultas.pendingorderldoa, 0, p1, p2, p3);
            
            customerbinding.DataSource = ListPendingOrders;
            dgPendingOrders.DataSource = customerbinding;
            dgArticleOrders.DataSource = customerbinding1;

            //combo causal en grid
            dgPendingOrders.DisplayLayout.Bands[0].Columns[f].ValueList = general.valuelistNumberId(BLConsultas.ListadoCausal, "DESCRIPCION", "CODIGO");
            dgPendingOrders.DisplayLayout.Bands[0].Columns[f].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;

            foreach (UltraGridRow row in dgPendingOrders.Rows)
            {
                row.Cells[d].Activation = Activation.NoEdit;
                row.Cells[d].Value = "Y";
                row.Cells[f].Activation = Activation.NoEdit;
                row.Cells[h].Activation = Activation.NoEdit;
                row.Cells[h].IgnoreRowColActivation = true;
            }

            List<ListSN> lista = new List<ListSN>();
            lista.Add(new ListSN("Y", "Aprobada"));
            lista.Add(new ListSN("N", "No Aprobada"));            
            BindingSource tabla = new BindingSource();
            tabla.DataSource = lista;

            UltraDropDown dropDownsn = new UltraDropDown();
            dropDownsn.DataSource = tabla;
            dropDownsn.ValueMember = "Id";
            dropDownsn.DisplayMember = "Description";
            dgPendingOrders.DisplayLayout.Bands[0].Columns[d].ValueList = dropDownsn;
            dgPendingOrders.DisplayLayout.Bands[0].Columns[d].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;

            //  Si hay órdenes
            if (dgPendingOrders.Rows.Count > 0)
            {
                //  Activa la primera fila de órdenes para actualizar la grilla de artículos
                dgPendingOrders.Rows[0].Activate();
            }

            String[] fieldsupper = new string[] { b, d, f };
            general.setColumnUpper(dgPendingOrders, fieldsupper);

            dgPendingOrders.DisplayLayout.Bands[0].Columns[h].CellActivation = Activation.NoEdit;
        }


        private void fillGridDeatil(UltraGrid ug)
        {
            try
            {
                String[] p1 = new string[] { "Int64", "Int64", "String" };
                String[] p2 = new string[] { "iorden", "inuSusccodi", "idtVisit" };
                String[] p3 = new string[] { dgPendingOrders.ActiveRow.Cells[a].Value.ToString(),
                                             dgPendingOrders.ActiveRow.Cells[c].Value.ToString(),
                                             dgPendingOrders.ActiveRow.Cells["RegisterDate"].Value.ToString()
                                             };
                //carga de la grilla de ordenes pendientes
                List<ArticleOrderLDOA> ListArticleOrder = new List<ArticleOrderLDOA>();
                ListArticleOrder = ldoa.FcuArticleOrders(BLConsultas.articleorderldoa, 3, p1, p2, p3);
                customerbinding1.DataSource = ListArticleOrder;
            }
            catch (Exception ex)
            {
                general.mensajeERROR("Error: " + ex.Message);
            }
        }

        private void btn_Click(object sender, EventArgs e)
        {
            String rowApproved;
            String rowCausal;
            String[] p1 = new string[] { "Int64", "String", "Int64" };
            String[] p2 = new string[] { "inuorder", "inapproved", "incausal" };
            String[] values = new String[3];
            Dictionary<String, String> orders = new Dictionary<String, String>();

            bool flag = false;

            //05-09-2013:LDiuza.SAO213430:2
            if (validRow())
            {
                foreach (UltraGridRow row in dgPendingOrders.Rows)
                {
                    if ((Boolean)row.Cells["Selection"].Value)
                    {
                        rowApproved = row.Cells["Approval"].Value.ToString();
                        rowCausal = row.Cells["CausalId"].Value == null ? "" : row.Cells["CausalId"].Value.ToString();

                        values[0] = row.Cells["Order"].Value.ToString();
                        values[1] = rowApproved;
                        values[2] = rowCausal;
                        ldoa.proapprovesaleorder(BLConsultas.AprovedOrderSale, 3, p1, p2, values);

                        //  Almacena la orden para borrar la fila posteriormente
                        orders.Add(values[0], "");

                        general.doCommit();

                        flag = true;
                    }
                }

                int idxRow = 0;

                //  Borra las filas de las órdenes procesadas
                while (idxRow < dgPendingOrders.Rows.Count)
                {
                    if (orders.ContainsKey(dgPendingOrders.Rows[idxRow].Cells["Order"].Value.ToString()))
                        dgPendingOrders.Rows[idxRow].Delete(false);
                    else
                        idxRow++;
                }

                //  Si hay órdenes activa la primera fila para mostrar la lista de sus artículos
                if (dgPendingOrders.Rows.Count > 0)
                {
                    dgPendingOrders.Rows[0].Activate();
                }
                else
                {
                    //  Limpia la grilla de artículos
                    customerbinding1.DataSource = new List<ArticleOrderLDOA>();
                }

                if (flag)
                {
                    general.mensajeOk("Proceso Ejecutado exitosamente");
                }
            }
            else
            {
                ExceptionHandler.DisplayMessage(2741, MessageBoxButtons.OK, MessageBoxIcon.Error, new string[] { "El campo Causal debe ser diligenacido" });
            }            
        }


        private void dgPendingOrders_Error(object sender, ErrorEventArgs et)
        {
            if (et.ErrorType == ErrorType.Data)
            {
                et.Cancel = true;
            }
        }

        private void dgPendingOrders_AfterRowActivate(object sender, EventArgs e)
        {
            fillGridDeatil(dgArticleOrders);
            dgArticleOrders.DataBind();
        }

        /// <summary>
        /// Evento ejecutado al cambiar el valor de una celda
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void dgPendingOrders_CellChange(object sender, CellEventArgs e)
        {
            if (e.Cell.Column.Key == g)
            {
                //05-09-2013:LDiuza.SAO213430:3
                Boolean value = e.Cell.Text.Equals("True");

                if (value)
                {
                    e.Cell.Row.Cells[d].Activation = Activation.AllowEdit;
                    e.Cell.Row.Cells[f].Activation = Activation.AllowEdit;
                    if (this.dgPendingOrders.DisplayLayout.Bands.Count > 0)
                    {
                        this.dgPendingOrders.DisplayLayout.Bands[0].Columns[f].Header.Appearance.Image = SINCECOMP.FNB.Resource.asterisc;
                    }
                }
                else
                {
                    e.Cell.Row.Cells[d].Activation = Activation.NoEdit;
                    e.Cell.Row.Cells[f].Activation = Activation.NoEdit;
                    e.Cell.Row.Cells[f].Value = null;
                    if (this.dgPendingOrders.DisplayLayout.Bands.Count > 0)
                    {
                        this.dgPendingOrders.DisplayLayout.Bands[0].Columns[f].Header.Appearance.Image = null;
                    }
                }
            }
        }

        //05-09-2013:LDiuza.SAO213430:4
        private void dgPendingOrders_BeforeRowDeactivate(object sender, CancelEventArgs e)
        {
            if (dgPendingOrders.ActiveRow != null)
            {
                if (!validRow())
                {
                    ExceptionHandler.DisplayMessage(2741, MessageBoxButtons.OK, MessageBoxIcon.Error, new string[] {"El campo Causal debe ser diligenacido"});
                    e.Cancel = true;
                }
            }
        }

        //05-09-2013:LDiuza.SAO213430:5
        private void dgPendingOrders_BeforeRowActivate(object sender, RowEventArgs e)
        {
            if (e.Row.Cells[g].Text.Equals("True"))
            {
                if (this.dgPendingOrders.DisplayLayout.Bands.Count > 0)
                {
                    this.dgPendingOrders.DisplayLayout.Bands[0].Columns[f].Header.Appearance.Image = SINCECOMP.FNB.Resource.asterisc;
                }
            }
            else
            {
                if (this.dgPendingOrders.DisplayLayout.Bands.Count > 0)
                {
                    this.dgPendingOrders.DisplayLayout.Bands[0].Columns[f].Header.Appearance.Image = null;
                }
            }
        }

        //05-09-2013:LDiuza.SAO213430:1
        private bool validRow()
        {
            bool result = true;
            if (dgPendingOrders.ActiveRow != null)
            {
                if (dgPendingOrders.ActiveRow.Cells[g].Text.Equals("True") && Convert.ToString(dgPendingOrders.ActiveRow.Cells[f].Value) == string.Empty)
                {
                    result = false;
                }
            }
            return result;
        }

        private void dgPendingOrders_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {
            //to do aecheverry
            /*
            if (e.Cell.Column.Key == f)
            {
                
            }            
             
             */
        }

        

        
    }
}