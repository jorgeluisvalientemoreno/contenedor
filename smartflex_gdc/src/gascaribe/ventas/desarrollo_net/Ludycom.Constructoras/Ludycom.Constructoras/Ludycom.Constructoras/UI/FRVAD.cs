using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Ludycom.Constructoras.BL;
using Ludycom.Constructoras.ENTITIES;
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.Windows.Controls;


namespace Ludycom.Constructoras.UI
{
    public partial class FRVAD : OpenForm
    {
        BLUtilities utilities = new BLUtilities();
        BLFDCPC blFDCPC = new BLFDCPC();
        BLFDMPC blFDMPC = new BLFDMPC();
        BLFRVAD blFRVAD = new BLFRVAD();
        BLGENERAL general = new BLGENERAL();

        private Int64 nuProjectId;
        private Int64 nuSubscriberCode;
        private Int64? nuCupon;

        private Double additionalValue;
        private Double costValue;
        // private bool blPendingChanges = false;

        private CustomerBasicData customerBasicData;
        private ProjectBasicData projectBasicData;
        private List<CheckConcept> conceptList = new List<CheckConcept>();
        private List<CheckConcept> checksToDeleteList = new List<CheckConcept>();
        private List<CheckConcept> itemsList = new List<CheckConcept>();
        private List<Int64> ListaConcepto = new List<Int64>();
        
        Int64 yesAplica;

        public FRVAD(Int64 project)
        {
            InitializeComponent();
            yesAplica = general.AplicaEntrega(Constants.ENTREGA_200_2022);
            this.ugMonthlyFee.DisplayLayout.Bands[0].Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.Yes;
            InitializeData(project);

            //Congiuracion Grilla Gestion OT
            //Concepto
            ugMonthlyFee.DisplayLayout.Bands[0].Columns["Concepto"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            ugMonthlyFee.DisplayLayout.Bands[0].Columns["Concepto"].FilterOperatorDropDownItems = FilterOperatorDropDownItems.Equals
                    | FilterOperatorDropDownItems.StartsWith
                    | FilterOperatorDropDownItems.Contains
                    | FilterOperatorDropDownItems.Like; //FilterOperatorDropDownItems.Like;            
            ugMonthlyFee.DisplayLayout.Bands[0].Columns["Concepto"].Width = 220;

            // validamos los datos que se mostrarán en la forma si es 1 me muestra la grilla con la observacion sino entonces muestra como estaba antes sin la grilla //
            if (yesAplica == 1)
            {
                tbCostValue.Hide();
                tbAdditionalValue.Hide();
                
            }
            else
            {
                bnNavegador.Hide();
                ugMonthlyFee.Hide();
               // this.Size = new Size(800,400);
            }

        }


        private void ugMonthlyFee_BeforeCellActivate(object sender, Infragistics.Win.UltraWinGrid.CancelableCellEventArgs e)
        {
            if (e.Cell.Column.Key == "Concepto" && (ugMonthlyFee.Rows[e.Cell.Row.VisibleIndex].Cells[0].ValueList == null || Convert.ToInt64(ugMonthlyFee.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value) == 0))
            {

                ugMonthlyFee.Rows[e.Cell.Row.VisibleIndex].Cells[0].ValueList = general.valuelistNumberId("select CONCCODI CODIGO, CONCDESC DESCRIPCION from concepto WHERE CONCCODI IN (SELECT column_value FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbgetvalue_chain('LDC_LISTCONCEPERM') ,',')))", "DESCRIPCION", "CODIGO");
                ugMonthlyFee.DisplayLayout.Bands[0].Columns[3].CellActivation = Activation.NoEdit;
                ugMonthlyFee.DisplayLayout.Bands[0].Columns[4].CellActivation = Activation.NoEdit;
                ugMonthlyFee.DisplayLayout.Bands[0].Columns[5].CellActivation = Activation.NoEdit;
            }

        }

        // metodoq que detecta cuando se cambia el valor de una celda//
        private void dtgTrabAdic_AfterCellUpdate(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {   
            // de acuerdo al valor del concepto hallamos el porcentaje del iva
            Int64 ValorConcept = Convert.ToInt64(ugMonthlyFee.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value);
            double PorcentIVA = general.ObtenerIvaConcepto(ValorConcept);
            Int64 Subtotal = Convert.ToInt64(ugMonthlyFee.Rows[e.Cell.Row.VisibleIndex].Cells[2].Value);
            // el valor del "valor adicional" será el mismo que aparecerá en el subtotal
             ugMonthlyFee.Rows[e.Cell.Row.VisibleIndex].Cells[3].Value = ugMonthlyFee.Rows[e.Cell.Row.VisibleIndex].Cells[2].Value;
            double ValorIVA = CalcularIVAValorAdicional(PorcentIVA, Subtotal);
            // en esta celda se establece el valor del IVA ya calculado entre el codigo del concepto y el valor del subtotal
            ugMonthlyFee.Rows[e.Cell.Row.VisibleIndex].Cells[4].Value = (Double)ValorIVA;

            //calculamos el total con la suma del subtotal + iva
            double Total = CalcularValorTotal(Subtotal, ValorIVA);
            ugMonthlyFee.Rows[e.Cell.Row.VisibleIndex].Cells[5].Value = (Double)Total;

            // Valida que si hay alguna fila agregada el boton este habilitado, de lo contrario sigue deshabilitado //
           // ValidarCambiosEnableBtnSave();

            

        }

        private double CalcularIVAValorAdicional(double porcentIva, Int64 subtotal)
        {
                double IVA = (subtotal * porcentIva) / 100;
                return IVA;
        }

        private double CalcularValorTotal(Int64 subtotal, double Iva)
        {
            double Total = subtotal + Iva;
            return Total;
        }


        #region DataInitialization

        public void InitializeData(Int64 project)
        {
            nuProjectId = project;
            bsConceptos.DataSource = conceptList;

            //Lista de Valores para el Tipo de Identificación
            DataTable dtIdentType = utilities.getListOfValue(BLGeneralQueries.strIdentificationType);
            ocIdentificationType.DataSource = dtIdentType;
            ocIdentificationType.ValueMember = "CODIGO";
            ocIdentificationType.DisplayMember = "DESCRIPCION";

            //Se cargan los datos del proyecto y del cliente
            LoadProjectAndCustomerBasicData(nuProjectId);
        }
        #endregion

        #region DataLoad
        /// <summary>
        /// Se cargan los datos básicos del proyecto y el cliente
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion 
        /// =========   =========              =====================================
        /// 09-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadProjectAndCustomerBasicData(Int64 projectId)
        {
            //Se inicializan datos básicos del proyecto
            LoadProjectBasicData(projectId);

            //Se obtiene el código del cliente
            nuSubscriberCode = blFDMPC.GetProjectCustomer(projectId);

            //Se inicializan datos básicos del cliente
            LoadCustomerBasicData(nuSubscriberCode);
        }

        /// <summary>
        /// Se cargan los datos básicos del proyecto
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion 
        /// =========   =========              =====================================
        /// 09-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadProjectBasicData(Int64 projectId)
        {
            //Se obtiene Datos Básicos del Proyecto
            projectBasicData = blFDMPC.GetProjectBasicData(projectId);

            //Se setean los datos del proyecto
            tbProjectName.TextBoxValue = projectBasicData.ProjectName;
        }

        /// <summary>
        /// Se cargan los datos básicos del cliente
        /// </summary>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion 
        /// =========   =========              =====================================
        /// 09-06-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public void LoadCustomerBasicData(Int64 nuSubscriberCode)
        {
            //Se obtienen los datos básicos del cliente
            customerBasicData = blFDCPC.GetCustomerBasicData(nuSubscriberCode);

            //Se setean los datos básicos del cliente en la pantalla
            ocIdentificationType.Value = customerBasicData.IdentificationType;
            tbCustomerId.TextBoxValue = customerBasicData.Identification;
            tbCustomerName.TextBoxValue = customerBasicData.CustomerName;
        }
        #endregion


        private void DefineValueGeneration()
        {
            this.btnRegisterAdditionalVal.Enabled = true;
            if (additionalValue > 0 && costValue > 0)
            {
                this.btnRegisterAdditionalVal.Enabled = true;
            }
            else
            {
                this.btnRegisterAdditionalVal.Enabled = false;
            }
        }

        private void btnRegisterAdditionalVal_Click(object sender, EventArgs e)
        {
            if (yesAplica == 1)
            {
                Boolean todoBien = true;
               
                    if (!String.IsNullOrEmpty(tbComment.TextBoxValue))
                    {
                        foreach (CheckConcept item in bsConceptos)
                        {
                            if ((item.Concepto == 0 || item.Concepto.Equals(null))
                                || (item.Costo_adicional == 0 || item.Costo_adicional.Equals(null))
                                || (item.Valor_adicional == 0 || item.Valor_adicional.Equals(null))
                                )
                            {
                                MessageBox.Show("Debe llenar las celdas de la grilla");
                                todoBien = false;
                            }
     
                        }
                       // MessageBox.Show(todoBien.ToString());
                        if (todoBien == true) {
                            foreach (CheckConcept item in bsConceptos)
                            {
                             //   MessageBox.Show(nuProjectId + "Concepto:" + item.Concepto + "Costo Adicional " + item.Costo_adicional + "Valor adcional " + item.Valor_adicional + "Observacion:" + tbComment.TextBoxValue);
                                nuCupon = blFRVAD.RegisterAdditionalValue(nuProjectId, item.Total, item.Costo_adicional, tbComment.TextBoxValue, item.Concepto);   
                            }
                            utilities.doCommit();
                            utilities.DisplayInfoMessage("Se generó el cupón exitosamente. Cupón: [" + nuCupon + "]");
                            this.Dispose();
                        }                   
                    }
                    else
                    {
                        MessageBox.Show("Debe ingresar la observación");
                    }
            }
            else
            {
                if (additionalValue > 0)
                {
                    if (String.IsNullOrEmpty(tbComment.TextBoxValue))
                    {
                        utilities.DisplayErrorMessage("Debe ingresar la observación");
                        return;
                    }
                    try
                    {
                        Cursor.Current = Cursors.WaitCursor;
        
                        nuCupon = blFRVAD.RegisterAdditionalValue(nuProjectId, additionalValue, costValue, tbComment.TextBoxValue, null);

                        utilities.doCommit();
                        utilities.DisplayInfoMessage("Se generó el cupón exitosamente. Cupón: [" + nuCupon + "]");
                        this.Dispose();
                    }
                    catch (Exception ex)
                    {
                        utilities.doRollback();
                        GlobalExceptionProcessing.ShowErrorException(ex);
                    }
                    Cursor.Current = Cursors.Default;
                }
            }
     
        }

        private void tbCostValue_Validating(object sender, CancelEventArgs e)
        {
            if (yesAplica == 0)
            {
                if (!String.IsNullOrEmpty(tbCostValue.TextBoxValue))
                {
                    costValue = Convert.ToDouble(tbCostValue.TextBoxValue);
                }
                else
                {
                    costValue = 0;
                    utilities.DisplayErrorMessage("Debe digitar un valor");
                }
                DefineValueGeneration();
            }
         
        }

        private void tbAdditionalValue_Validating(object sender, CancelEventArgs e)
        {
            if (yesAplica == 0) {

                if (!String.IsNullOrEmpty(tbAdditionalValue.TextBoxValue))
                {
                    additionalValue = Convert.ToDouble(tbAdditionalValue.TextBoxValue);
                }
                else
                {
                    additionalValue = 0;
                    utilities.DisplayErrorMessage("Debe digitar un valor");
                }
                DefineValueGeneration();
            }
           
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Dispose();
        }


        private void EnableChangesSaving()
        {
            if (!this.btnRegisterAdditionalVal.Enabled)
            {
                this.btnRegisterAdditionalVal.Enabled = true;
            }
        }


        private void DisableChangesSaving()
        {
            if (this.btnRegisterAdditionalVal.Enabled)
            {
                this.btnRegisterAdditionalVal.Enabled = false;
            }
        }

        private void bnAddNewConcept_Click(object sender, EventArgs e)
        {
            CheckConcept tmpConcept = (CheckConcept)bsConceptos.AddNew();
            ValidarCambiosEnableBtnSave();
        }


        private void bnConcepkDeleteItem_Click(object sender, EventArgs e)
        {
            CheckConcept tmpCheck = (CheckConcept)bsConceptos.Current;
            checksToDeleteList.Add(tmpCheck);
            bsConceptos.RemoveCurrent();
            ValidarCambiosEnableBtnSave();

        }

        private void FRVAD_Load(object sender, EventArgs e)
        {
  
        }


        private void ValidarCambiosEnableBtnSave()
        {
            if (ugMonthlyFee.Rows.Count > 0)
            {
                this.btnRegisterAdditionalVal.Enabled = true;
            }
            else
            {
                this.btnRegisterAdditionalVal.Enabled = false;
            }
        }

 

    }
}
