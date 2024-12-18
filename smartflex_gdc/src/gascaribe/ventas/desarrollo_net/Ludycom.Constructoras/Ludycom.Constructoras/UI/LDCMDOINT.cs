using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Windows.Forms;
using Ludycom.Constructoras.BL;
using Ludycom.Constructoras.ENTITIES;
using OpenSystems.Common.Util;
using OpenSystems.Windows.Controls;
using Infragistics.Win.UltraWinGrid;
//using Infragistics.Win;
//using Infragistics.Shared;
using OpenSystems.Common.ExceptionHandler;
using System.Data.Common;
using OpenSystems.Common.Data;
namespace Ludycom.Constructoras.UI
{
    public partial class LDCMDOINT : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        private List<OrdenesInternas> ordenesInternasList = new List<OrdenesInternas>();
        private List<OrdenesInternas> ordenesInternasToDeleteList = new List<OrdenesInternas>();
        private OrdenesInternas currentOrdenesInternas;
        DataTable ordenInternas = new DataTable();
        BLLDCMDOINT blLdcmdoint = new BLLDCMDOINT();
        public LDCMDOINT()
        {
            InitializeComponent();
            cargarLista();
            ordenInternas.Columns.Clear();
            ordenInternas.Rows.Clear();
            ordenInternas.Columns.Add("orden");
        }
        public void cargarLista()
        {
            //Se carga la lista de tipos de trabajo de instalación interna
            //DataTable dtProyectos = utilities.getListOfValue(BLGeneralQueries.strProyectos);
            cbx_proyecto.Select_Statement = string.Join(string.Empty, new string[] { 
                                                        " SELECT ID_PROYECTO id, ",
                                                        " NOMBRE description, ",
                                                        " CLIENTE " ,
                                                        " FROM ldc_proyecto_constructora " ,
                                                         "@where @",
                                                         "@ID_PROYECTO like :id @",
                                                         "@upper(NOMBRE) like :description @ "});
           BSordenesInternas.DataSource = ordenesInternasList;

        }

        private void ugOrdenesInt_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {

        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
          this.Close();
        }
        
            
        private void bnOrdenesInternasAddNewItem_Click(object sender, EventArgs e)
        {
            if (validOrdenesNuevoRegistro())
            {
                //Si la fila activa es válida, se crea nuevo registro
                OrdenesInternas tmpOrdenesInternas = (OrdenesInternas)BSordenesInternas.AddNew();
              
               // ValidateChanges();
            }
            this.bnOrdenInterna.Focus();
        }

        private void bnOrdenesInternasDeleteItem_Click(object sender, EventArgs e)
        {
            OrdenesInternas tmpOrdenesInternas = (OrdenesInternas)BSordenesInternas.Current;
           // MessageBox.Show("Registros " + BSordenesInternas.Count);
            if (BSordenesInternas.Count <= 0)            {
               
                return;
            }

            if (BSordenesInternas.Count <= 1)
            {
                 btnProcesar.Enabled = false;
            }

            this.bnOrdenInterna.Focus();

            BSordenesInternas.RemoveCurrent();
                //ValidateChanges();
            
        }

        private void ugOrdenInterna_BeforeCellUpdate(object sender, BeforeCellUpdateEventArgs e)
        {
            OrdenesInternas tmpOrdenesInternas = (OrdenesInternas)BSordenesInternas.Current;            
        }

        private void ugOrdenInterna_AfterCellUpdate(object sender, CellEventArgs e)
        {
            //bool result = true;
            Int64? nullint = null;
           // OrdenesInternas tmpOrdenesInternas = (OrdenesInternas)BSordenesInternas.Current;
            if (this.ugOrdenInterna.ActiveRow != null)
            {
                //MessageBox.Show("Ingreso ugOrdenInterna_AfterCellUpdate");
                String ordeuno = "";
                String ordedos = "";

                 if (this.ugOrdenInterna.ActiveRow.Cells["ordenOri"].Value != null)
                 {
                    ordeuno = Convert.ToString(this.ugOrdenInterna.ActiveRow.Cells["ordenOri"].Value);

                 }
                if (this.ugOrdenInterna.ActiveRow.Cells["ordenDest"].Value != null)
                {
                    ordedos = Convert.ToString(this.ugOrdenInterna.ActiveRow.Cells["ordenDest"].Value);
                }
                Int64? ordenInt1 = string.IsNullOrEmpty(ordeuno) ? nullint : Convert.ToInt64(ordeuno);
                Int64? ordenInt2 = string.IsNullOrEmpty(ordedos) ? nullint : Convert.ToInt64(ordedos);
               

                if (e.Cell.Column.Key == "ordenOri")
                {
                   
                    if (validarordenlista(ordenInt1, 1))
                    {
                        utilities.DisplayErrorMessage("La orden de interna 1 ya existe en la lista");
                        //result = false;
                        return;
                    }
                    if (!validaOrdeExis(ordenInt1))
                    {
                        utilities.DisplayErrorMessage("La orden de interna 1 no existe o no esta asociado al proyecto");
                        //result = false;
                        return;
                    }

                }
                if (e.Cell.Column.Key == "ordenDest")
                {
                    if (validarordenlista(ordenInt2, 2))
                    {
                        utilities.DisplayErrorMessage("La orden de interna 2 ya existe en la lista");
                        //result = false;
                        return;
                    }

                    if (!validaOrdeExis(ordenInt2))
                    {
                        utilities.DisplayErrorMessage("La orden de interna 2 no existe o no esta asociado al proyecto");
                        //result = false;
                        return;
                    }

                }
                if (ordenInt1 != null && ordenInt2 != null){
                    if (ordenInt1 == ordenInt2)
                    {
                        utilities.DisplayErrorMessage("La orden de interna 1 no puede ser igual a la orden de interna 2");
                       // result = false;
                        return;
                    }
                }
                
                
                    
            }
             // ValidateChanges();
            //MessageBox.Show("Ingreso ugOrdenInterna_AfterCellUpdate");
            
        }

        private void ugOrdenInterna_BeforeRowDeactivate(object sender, CancelEventArgs e)
        {

           /* if (!validOrdenesNuevoRegistro())
            {
                e.Cancel = true;
            }*/
        }

        private void ugOrdenInterna_AfterRowActivate(object sender, EventArgs e)
        {
            currentOrdenesInternas = (OrdenesInternas)BSordenesInternas.Current;

            btnProcesar.Enabled = true;
        }
      /*  private bool validOrdenesInternasRow()
        {
            bool result = true;
            Int64? nullint = null;

            if (this.ugOrdenInterna.ActiveRow != null)
            {
                MessageBox.Show("Ingreso validOrdenesInternasRow" + result);
                String ordeuno = "";
                String ordedos = "";
                if (this.ugOrdenInterna.ActiveRow.Cells["ordenOri"].Value != null)
                {
                    ordeuno = Convert.ToString(this.ugOrdenInterna.ActiveRow.Cells["ordenOri"].Value);
                    //MessageBox.Show("Convierte cadena uno");

                }
                if (this.ugOrdenInterna.ActiveRow.Cells["ordenDest"].Value != null)
                {
                   // MessageBox.Show("Convierte cadena dos antes");
                    ordedos = Convert.ToString(this.ugOrdenInterna.ActiveRow.Cells["ordenDest"].Value);
                   // MessageBox.Show("Convierte cadena dos despues");
                }
                //MessageBox.Show("Convierte cadena a numero");
                Int64? ordenInt1 = string.IsNullOrEmpty(ordeuno) ? nullint : Convert.ToInt64(ordeuno);
                Int64? ordenInt2 = string.IsNullOrEmpty(ordedos) ? nullint : Convert.ToInt64(ordedos);
                
                if (ordenInt1 != null && ordenInt2 != null)
                {
                    if (ordenInt1 == ordenInt2)
                    {
                        utilities.DisplayErrorMessage("La orden de interna 1 no puede ser igual a la orden de interna 2");
                        result = false;
                        return result;
                    }
                    if (validarordenlista(ordenInt1, 1))
                    {
                        utilities.DisplayErrorMessage("La orden de interna 1 ya existe en la lista");
                        result = false;
                        return result;
                    }
                    if (validarordenlista(ordenInt2, 2))
                    {
                        utilities.DisplayErrorMessage("La orden de interna 2 ya existe en la lista");
                        result = false;
                        return result;
                    }
                    if (!validaOrdeExis(ordenInt1))
                    {
                        utilities.DisplayErrorMessage("La orden de interna 1 no existe o no esta asociado al proyecto");
                        result = false;
                        return result;
                    }
                    if (!validaOrdeExis(ordenInt2))
                    {
                        utilities.DisplayErrorMessage("La orden de interna 2 no existe o no esta asociado al proyecto");
                        result = false;
                        return result;
                    }
                }
                
                }
            
            return result;
        }
        */
        private bool validOrdenesNuevoRegistro()
        {
           
            bool result = true;
           // MessageBox.Show("Ingreso validOrdenesNuevoRegistro" + result);
            Int64? nullint = null;
            if (this.ugOrdenInterna.ActiveRow != null)
            {
                String ordeuno = "";
                String ordedos = "";
                if (this.ugOrdenInterna.ActiveRow.Cells["ordenOri"].Value != null)
                {
                    ordeuno = Convert.ToString(this.ugOrdenInterna.ActiveRow.Cells["ordenOri"].Value);

                }
                if (this.ugOrdenInterna.ActiveRow.Cells["ordenDest"].Value != null)
                {
                    ordedos = Convert.ToString(this.ugOrdenInterna.ActiveRow.Cells["ordenDest"].Value);
                }
                Int64? ordenInt1 = string.IsNullOrEmpty(ordeuno) ? nullint : Convert.ToInt64(ordeuno);
                Int64? ordenInt2 = string.IsNullOrEmpty(ordedos) ? nullint : Convert.ToInt64(ordedos);

                if (ordenInt1 != null && ordenInt2 != null)
                {
                    if (ordenInt1 == ordenInt2)
                    {
                        utilities.DisplayErrorMessage("La orden de interna 1 no puede ser igual a la orden de interna 2");
                        result = false;
                        return result;
                    }
                    if (validarordenlista(ordenInt1, 1))
                    {
                        utilities.DisplayErrorMessage("La orden de interna 1 ya existe en la lista");
                        result = false;
                        return result;
                    }
                    if (validarordenlista(ordenInt2, 2))
                    {
                        utilities.DisplayErrorMessage("La orden de interna 2 ya existe en la lista");
                        result = false;
                        return result;
                    }

                    if (!validaOrdeExis(ordenInt1))
                    {
                        utilities.DisplayErrorMessage("La orden de interna 1 no existe o no esta asociado al proyecto");
                        result = false;
                        return result;
                    }
                    if (!validaOrdeExis(ordenInt2))
                    {
                        utilities.DisplayErrorMessage("La orden de interna 2 no existe o no esta asociado al proyecto");
                        result = false;
                        return result;
                    }
                   
                }
            }
            
            return result;
        }


        private bool validarordenlista(Int64? orden, Int64 numord)
        {
            
            bool result = false;
           // MessageBox.Show("Ingreso validarordenlista" + orden);
            if (orden != null)
            {
                Int64? posicion = BSordenesInternas.Position;
                Int64? i = 0;
                OrdenesInternas tmpOrdenesInternas = (OrdenesInternas)BSordenesInternas.Current;
               // MessageBox.Show("valor current" + tmpOrdenesInternas.ordenDest + " " + tmpOrdenesInternas.ordenOri);
               // MessageBox.Show("Posicion" + posicion);
                if (tmpOrdenesInternas.ordenOri != null || tmpOrdenesInternas.ordenDest != null)
                {
                    foreach (OrdenesInternas DatoOrdden in BSordenesInternas)
                    {
                       // MessageBox.Show("ingreso a recorrer " + DatoOrdden.ordenOri + " " + DatoOrdden.ordenDest + " posicion " + i);
                        if ((DatoOrdden.ordenOri == orden || DatoOrdden.ordenDest == orden) && i != posicion)
                        {
                          //  MessageBox.Show("ingreso " + DatoOrdden.ordenOri + " " + DatoOrdden.ordenDest);
                            result = true;
                            return result;
                        }
                        i = i + 1;
                    }
                }
            }
            

            return result;
        }

        private bool validaOrdeExis(Int64? orden)
        {
            bool result = true;
           // MessageBox.Show("Ingreso validaOrdeExis" + orden);
            if (orden != null)
            {
                DataRow[] DTFilas = ordenInternas.Select("orden = " + orden + "");

               // MessageBox.Show("Ingreso validaOrdeExis" + DTFilas.Length);
                if (DTFilas.Length == 0)
                    result = false;
            }
            return result;
        }

        private void cbx_proyecto_ValueChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Convert.ToString(cbx_proyecto.Value)))
            {
               ordenInternas.Rows.Clear(); 
               
               ordenInternas = blLdcmdoint.FrfOrdenInternas(Convert.ToInt64(cbx_proyecto.Value));

               if (ordenInternas.Rows.Count == 0)
               {
                   utilities.DisplayErrorMessage("Proyecto seleccionado no tiene ordenes de interna");
                   cbx_proyecto.Focus();
                   btnProcesar.Enabled = false;
               }
               
            }
        }

        private void btnProcesar_Click(object sender, EventArgs e)
        {
            if (validOrdenesNuevoRegistro())
            {
                if (MessageBox.Show("Realmente deseas Procesar las Ordenes Ingresadas?", "Confirmar Proceso.",
                                     MessageBoxButtons.YesNo, MessageBoxIcon.Question)
                                     == DialogResult.Yes)
                {
                    String resul = "";
                    String error = "";
                    foreach (OrdenesInternas DatoOrden in BSordenesInternas)
                    {
                        if (DatoOrden.ordenOri != null && DatoOrden.ordenDest != null)
                        {
                            resul = blLdcmdoint.funProcesaOrden(DatoOrden.ordenOri, DatoOrden.ordenDest);
                            if (!string.IsNullOrEmpty(resul))
                            {
                                error = error + resul;
                            }
                        }
                    }
                    if (!string.IsNullOrEmpty(error))
                    {
                        utilities.DisplayErrorMessage("Proceso Termino con errores " + error);
                    }
                    else
                    {
                        MessageBox.Show("Proceso Termino Exitosamente");
                        btnProcesar.Enabled = false;
                        BSordenesInternas.Clear();

                    }
                }
                
            }
        }
    }
}
