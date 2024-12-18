using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using LDC_APUSSOTECO.Entities;
using LDC_APUSSOTECO.BL;
using LDC_APUSSOTECO.DAL;
using OpenSystems.Common.Util;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.Common.Data;
using System.Data.Common;
using System.Collections;

namespace LDC_APUSSOTECO.UI
{
    public partial class LDCAPUSSOTECO : OpenForm
    {

        BLUtilities utilities = new BLUtilities();
        BLLDCAPUSSOTECO blLDC_FCVC = new BLLDCAPUSSOTECO();

        List<Keys> notValidKeys;

        private ContratoBasicData ContratoBasicData;


        public LDCAPUSSOTECO()
        {
            InitializeComponent();

            InitializeData();
        }


        #region DataInitialization
        /// <summary>
        /// Se inicializan los datos predeterminados
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 24-04-2019  MiguelBallesteros      1 - creación   
        /// </changelog>
        public void InitializeData()
        {
            ContratoBasicData = new ContratoBasicData();

            bsChargeByDetaContratos.DataSource = ContratoBasicData.ItemsList;

            // se llama a la funcion para el cargado de los contratos en la grilla
            LoadAllContratos();

            // se llena el combo estado
            setValueCbEstado();

        }


        /// <summary>
        /// Se establece la lista de valores para el combobox responsable
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 06-02-2020  Miguel Ballesteros     1. Creación 
        private void setValueCbEstado()
        {

            String query = "select decode(ROWNUM, 1, 'A', 2, 'R') as CODIGO, " +
                            " decode(ROWNUM, 1, 'Aprobado', 2, 'Rechazado') as DESCRIPCION " +
                            " from dual " +
                            " connect by level <= 2";

            DataTable dtListResponsable = utilities.getListOfValue(query);
            cbEstado.DataSource = dtListResponsable;
            cbEstado.ValueMember = "CODIGO";
            cbEstado.DisplayMember = "DESCRIPCION";
        }



        /// <summary>
        /// Se definen teclas no válidas
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void defineNotValidKeys()
        {
            notValidKeys = new List<Keys>();
            notValidKeys.Add(Keys.Up);
            notValidKeys.Add(Keys.Down);
            notValidKeys.Add(Keys.Left);
            notValidKeys.Add(Keys.Right);
            notValidKeys.Add(Keys.Enter);
            notValidKeys.Add(Keys.Escape);
            notValidKeys.Add(Keys.Shift);
        }

        #endregion


        #region ButtonsActions
        /// <summary>
        /// Acción del boton aceptar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {

                DialogResult ContinueCancel = ExceptionHandler.DisplayMessage(
                                          2741,
                                          "¿Desea Ingresar la informacion diligenciada?",
                                          MessageBoxButtons.YesNo,
                                          MessageBoxIcon.Question);

                if (ContinueCancel == DialogResult.No)
                {
                    return;
                }
                if (ContinueCancel == DialogResult.Yes)
                {

                    // variables para manejar errores y procesos del area de medidores //
                    Int64 onuErrorCode = 0;
                    String osbErrorMessage = "";
                    Boolean Check = false;


                    // se valida que por lo menos exista una lista checkeada en la grilla de medidores
                    for (int i = 0; i <= ugInternalDetaContrato.Rows.Count - 1; i++)
                    {
                        if (ugInternalDetaContrato.Rows[i].Cells[1].Value.ToString() == "True" ||
                            ugInternalDetaContrato.Rows[i].Cells[2].Value.ToString() == "True")
                        {
                            Check = true;
                        }

                    }


                    // si hay al menos un elemento checkeado de la grilla de contratos
                    if (Check)
                    {   

                        // se recorre toda la grilla de contratos para procesarlos

                        // se hace el llamado del procedimiento que hace la actualizacion en la tabla de contratos LDC_CONTRATPENDTERMI
                        for (int i = 0; i <= ugInternalDetaContrato.Rows.Count - 1; i++)
                        {
                            // solo se procesarán los contratos que esten seleccionados en aprobado
                            if (ugInternalDetaContrato.Rows[i].Cells[1].Value.ToString() == "True")
                            {
                                
                                String sbEstado = "A";
                                Int64 nuContrato = Convert.ToInt64(ugInternalDetaContrato.Rows[i].Cells[0].Value.ToString());
                                String sbObservacion = Convert.ToString(ugInternalDetaContrato.Rows[i].Cells[3].Value.ToString());

                                blLDC_FCVC.ActualizaDatosContratos(nuContrato, sbEstado, sbObservacion, out onuErrorCode, out osbErrorMessage);
                                //utilities.doCommit();

                            }

                            // solo se procesarán los contratos que esten seleccionados en rechazado
                            if (ugInternalDetaContrato.Rows[i].Cells[2].Value.ToString() == "True")
                            {
                                String sbEstado = "R";
                                Int64 nuContrato = Convert.ToInt64(ugInternalDetaContrato.Rows[i].Cells[0].Value.ToString());
                                String sbObservacion = Convert.ToString(ugInternalDetaContrato.Rows[i].Cells[3].Value.ToString());

                                blLDC_FCVC.ActualizaDatosContratos(nuContrato, sbEstado, sbObservacion, out onuErrorCode, out osbErrorMessage);
                                //utilities.doCommit();

                            }

                        }


                        // si la inserccion de los contratos en la tabla es correcta
                        if (onuErrorCode == 0)
                        {
                            MessageBox.Show("Los contratos se actualizaron con exito");
                            //this.Close();

                            // se resetea la grilla
                            bsChargeByDetaContratos.Clear();

                            // se limpia la informacion del encabezado
                            tbComment.TextBoxValue = "";
                            cbEstado.Value = "";
                            chkGeneral.Value = "N";

                            // se carga nuevamente los contratos que no fueron procesados
                            LoadAllContratos();
                        }
                        else
                        {
                            utilities.DisplayErrorMessage("Se presento el siguiente Error al procesar el contrato!! " + onuErrorCode + " " + osbErrorMessage);
                        }
                        Check = false;

                    }
                    else
                    {
                        utilities.DisplayErrorMessage("Debe seleccionar por lo menos un check (aprobado) o (rechazado) para el contrato");
                    }


                }

            }
            catch (Exception ex)
            {
                utilities.doRollback();
                GlobalExceptionProcessing.ShowErrorException(ex);
                this.Dispose();
            }
        }



        /// <summary>
        /// Acción del boton cancelar
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void btnCancel_Click(object sender, EventArgs e)
        {

            DialogResult ContinueCancel = ExceptionHandler.DisplayMessage(
                                          2741,
                                          "No se han guardado todos los cambios. ¿Desea cerrar la aplicación sin guardar",
                                          MessageBoxButtons.YesNo,
                                          MessageBoxIcon.Question);

            if (ContinueCancel == DialogResult.No)
            {
                return;
            }
            else
            {
                this.Dispose();
            }

        }

        #endregion


        /// <summary>
        /// metodo para seleccionar todo los checkbox de la grilla al checkear "General"
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void ClickCheckList(object sender, EventArgs e)
        {

            if (cbEstado.Value == null && chkGeneral.Value == "Y")
            {
                utilities.DisplayErrorMessage("Debe ingresar el estado en la lista de valores (Estado)!!");
                chkGeneral.Value = "N";
            }
            else if (cbEstado.Value != null && chkGeneral.Value == "Y")
            {
                if (ugInternalDetaContrato.Rows.Count > 0)
                {
                    for (int i = 0; i <= ugInternalDetaContrato.Rows.Count - 1; i++)
                    {
                        // se limpian los campos 1 y 2 de la grilla para despues cargar la informacion general
                        ugInternalDetaContrato.Rows[i].Cells[1].Value = 0;
                        ugInternalDetaContrato.Rows[i].Cells[2].Value = 0;

                        if (ugInternalDetaContrato.Rows[i].Cells[1].Value.ToString() == "False" &&
                            ugInternalDetaContrato.Rows[i].Cells[2].Value.ToString() == "False")
                        {
                            // se valida el valor seleccionado del combo estado
                            if (cbEstado.Value.ToString() == "A")
                            {
                                ugInternalDetaContrato.Rows[i].Cells[1].Value = 1;

                                // se cambia la propieda de la grilla a no editable en todos sus campos
                                NoEditUgInternalDetaContrato();

                                // se carga la informacion del campo observacion en la grilla de contratos
                                ugInternalDetaContrato.Rows[i].Cells[3].Value = tbComment.TextBoxValue;
                            }
                            else
                            {
                                ugInternalDetaContrato.Rows[i].Cells[2].Value = 1;

                                // se cambia la propieda de la grilla a no editable en todos sus campos
                                NoEditUgInternalDetaContrato();

                                // se carga la informacion del campo observacion en la grilla de contratos
                                ugInternalDetaContrato.Rows[i].Cells[3].Value = tbComment.TextBoxValue;
                            }

                        }
                    }
                }

            }
            else
            {
                for (int i = 0; i <= ugInternalDetaContrato.Rows.Count - 1; i++)
                {
                    if (ugInternalDetaContrato.Rows[i].Cells[1].Value.ToString() == "True")
                    {
                        ugInternalDetaContrato.Rows[i].Cells[1].Value = 0;

                        // se cambia la propieda de la grilla permitiendo la edicion en todos sus campos
                        PermitEditUgInternalDetaContrato();

                        // se limpia el campo observacion de la grilla
                        ugInternalDetaContrato.Rows[i].Cells[3].Value = "";
                    }

                    if (ugInternalDetaContrato.Rows[i].Cells[2].Value.ToString() == "True")
                    {
                        ugInternalDetaContrato.Rows[i].Cells[2].Value = 0;

                        // se cambia la propieda de la grilla permitiendo la edicion en todos sus campos
                        PermitEditUgInternalDetaContrato();

                        // se limpia el campo observacion de la grilla
                        ugInternalDetaContrato.Rows[i].Cells[3].Value = "";
                    }
                }
            }

        }


        /// <summary>
        /// evento que se acciona cuando se cambia el valor del check de la grilla de medidores
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 30-06-2020  Miguel Ballesteros     1. Creación 
        private void ValCheckClickGridContra(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {

            int Index = ugInternalDetaContrato.ActiveRow.Index;

            if (ugInternalDetaContrato.Rows.Count > 0)
            {

                if (e.Cell.Text == "True" && e.Cell.Column.ToString() == "Aprobado")
                {
                    ugInternalDetaContrato.Rows[Index].Cells[2].Value = 0;
                }
                else if (e.Cell.Text == "True" && e.Cell.Column.ToString() == "Rechazado")
                {
                    ugInternalDetaContrato.Rows[Index].Cells[1].Value = 0;
                }
                
                
            }
        }


        /// <summary>
        /// metodo que se encarga de cargar todos los medidores de acuerdo al codigo de la Orden
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 22-04-2019  Miguel Ballesteros     1. Creación 
        private void LoadAllContratos()
        {

            BindingSource originBindingSource = bsChargeByDetaContratos;

            ContratoBasicData.ItemsList = blLDC_FCVC.GetDatosContratos();

            if (ContratoBasicData.ItemsList.Count > 0)
            {
                originBindingSource.DataSource = ContratoBasicData.ItemsList;
            }
            else
            {
                utilities.DisplayErrorMessage("No existen contratos pendientes en la tabla LDC_CONTRATPENDTERMI ");
            }

        }


        public String ObtenerUsuarioConectado()
        {

            String Usuario = blLDC_FCVC.getUserConect();


            // si el usuario conectado esta configurado en CONT o GDC
            if (Usuario == "NotFind")
            {
                utilities.DisplayErrorMessage("El usuario conectado no se encuentra configurado en el parametro LDC_PARUSERPERMI");

            }


            return Usuario;

        }


        // procedimiento que recorre la grilla de los medidores recien cargada para validar cada fila y modificar su atributo a no editado
        private void NoEditUgInternalDetaContrato()
        {
            for (int i = 0; i < ugInternalDetaContrato.DisplayLayout.Rows.Count; i++)
            {
                ugInternalDetaContrato.Rows[i].Cells[0].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
                ugInternalDetaContrato.Rows[i].Cells[1].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
                ugInternalDetaContrato.Rows[i].Cells[2].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
                ugInternalDetaContrato.Rows[i].Cells[3].Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            }

        }

        // procedimiento que recorre la grilla de los medidores recien cargada para validar cada fila y modificar su atributo a si editado
        private void PermitEditUgInternalDetaContrato()
        {
            for (int i = 0; i < ugInternalDetaContrato.DisplayLayout.Rows.Count; i++)
            {
                ugInternalDetaContrato.Rows[i].Cells[0].Activation = Infragistics.Win.UltraWinGrid.Activation.AllowEdit;
                ugInternalDetaContrato.Rows[i].Cells[1].Activation = Infragistics.Win.UltraWinGrid.Activation.AllowEdit;
                ugInternalDetaContrato.Rows[i].Cells[2].Activation = Infragistics.Win.UltraWinGrid.Activation.AllowEdit;
                ugInternalDetaContrato.Rows[i].Cells[3].Activation = Infragistics.Win.UltraWinGrid.Activation.AllowEdit;
            }

        }


    }
}
