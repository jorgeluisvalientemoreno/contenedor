using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Ludycom.Constructoras.BL;
using Ludycom.Constructoras.ENTITIES;
using OpenSystems.Common.Util;
using OpenSystems.Windows.Controls;
using System.IO;
//using Infragistics.Win;
//using Infragistics.Shared;
//using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.ExceptionHandler;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace Ludycom.Constructoras.UI
{
    public partial class LDCMOPL : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLLDCMOPL blLDCMOPL = new BLLDCMOPL();
        ToolTip toolTip1 = new ToolTip();

        private bool pendingChanges = false;

        public LDCMOPL()
        {
            InitializeComponent();
            toolTip1.AutoPopDelay = 5000;
            toolTip1.InitialDelay = 1000;
            toolTip1.ReshowDelay = 200;
            // Force the ToolTip text to be displayed whether or not the form is active.
            toolTip1.ShowAlways = true;

            // Set up the ToolTip text for the Button and Checkbox.
            toolTip1.SetToolTip(this.generalCheck, "Seleccionar / DeSeleccionar Todo");
            cargarLista();
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

        }

        private void generalCheck_CheckedChanged(object sender, EventArgs e)
        {
            if (generalCheck.Checked == false)
            {

                //Logica para desmarcar todos lo sregistros
                foreach (ListadoInternas rfInternas in bsListadoInternas)
                {
                    rfInternas.selection = false;
                }
            }
            else
            {

                //Logica para marcar todos lo sregistros
                foreach (ListadoInternas rfInternas in bsListadoInternas)
                {
                    rfInternas.selection = true;
                }
            }
            dtgOrdenesInterna.Refresh();
        }

        private void btn_buscup_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Convert.ToString(cbx_proyecto.Value)))
            {
                //blLDCMOPL.mensajeERROR("valor " + Convert.ToInt64(cbx_proyecto.Value));
                bsListadoInternas.DataSource = blLDCMOPL.FrfOrdenInternas(Convert.ToInt64(cbx_proyecto.Value));
                dtgOrdenesInterna.DisplayLayout.Bands[0].Columns[1].CellActivation = Activation.NoEdit;
                dtgOrdenesInterna.DisplayLayout.Bands[0].Columns[2].CellActivation = Activation.NoEdit;
                dtgOrdenesInterna.DisplayLayout.Bands[0].Columns[3].CellActivation = Activation.NoEdit;
                dtgOrdenesInterna.DisplayLayout.Bands[0].Columns[4].CellActivation = Activation.NoEdit;
                if (bsListadoInternas != null)
                {
                    if (!btnProcesar.Enabled)
                    {
                        btnProcesar.Enabled = true;
                    }
                }
                else
                {
                    if (btnProcesar.Enabled)
                    {
                        btnProcesar.Enabled = false;
                    }
                }

            }
            else
            {
                blLDCMOPL.mensajeERROR("Debe seleccionar un Proyecto");
                btn_buscup.Focus();
            }
            dtgOrdenesInterna.Refresh();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            if (pendingChanges)
            {
                DialogResult continueCancelling = ExceptionHandler.DisplayMessage(
                                    2741,
                                    "No han guardado todos los cambios. Desea cerrar la aplicación sin guardar los cambios?",
                                    MessageBoxButtons.YesNo,
                                    MessageBoxIcon.Question);

                if (continueCancelling == DialogResult.No)
                {
                    return;
                }
            }

            this.Close();
        }

        private void btnProcesar_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Realmente deseas Procesar la(s) orden(es) selecionada(s)?", "Confirmar Proceso.",
                                     MessageBoxButtons.YesNo, MessageBoxIcon.Question)
                                     == DialogResult.Yes)
            {
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                Int64? procesar = 0;
                String estado = "N"; 
                String error = null;
                String errores = null;
                //Ciclo para recorrer todos los registros de BidingSource relacionado son las ordenes gestionadas
                foreach (ListadoInternas rfInternas in bsListadoInternas)
                {

                   
                    //Solo permite legalizar las ordnes que esten marcadas
                    try{

                        if (rfInternas.selection == true ){
                            estado = "S";
                        }
                        else
                        {
                            estado = "N";
                        } 
                        
                        //MessageBox.Show("procesar " + rfInternas.orden + " solicitud " + rfInternas.solicitud + "estado " + estado);

                        error = blLDCMOPL.funProcesaOrden(Convert.ToInt64(cbx_proyecto.Value), rfInternas.orden, rfInternas.solicitud, estado);
                        if (string.IsNullOrEmpty(error))
                        {
                            procesar = procesar + 1;
                            //MessageBox.Show("Ingreso aca" + procesar);
                            utilities.doCommit();
                        }
                        else
                        {
                            errores = errores + rfInternas.orden + "error " + error;
                        //    MessageBox.Show("Ingreso aca2" + errores);
                        }
                        
                        
                    }
                    catch (Exception ex)
                    {
                        utilities.doRollback();
                        GlobalExceptionProcessing.ShowErrorException(ex);
                    }
                    }

                if (!string.IsNullOrEmpty(errores))
                {
                    blLDCMOPL.mensajeERROR("Se presentaron los siguientes errores: " + errores);

                }
                else
                {
                    MessageBox.Show("Proceso termino con exito");
                }
                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

                bsListadoInternas.Clear();
                //////////////////////////////////////////////////////
                dtgOrdenesInterna.Refresh();
                if (btnProcesar.Enabled)
                {
                    btnProcesar.Enabled = false;
                }
                

            }
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            bsListadoInternas.Clear();
            //////////////////////////////////////////////////////
            dtgOrdenesInterna.Refresh();
            cbx_proyecto.Value = null;
            if (generalCheck.Checked)
            {
                generalCheck.CheckState = CheckState.Unchecked;
                //generalCheck.
            }

        }

        private void cbx_proyecto_ValueChanged(object sender, EventArgs e)
        {
           
            bsListadoInternas.Clear();
            //////////////////////////////////////////////////////
            dtgOrdenesInterna.Refresh();
        }
    }
}
