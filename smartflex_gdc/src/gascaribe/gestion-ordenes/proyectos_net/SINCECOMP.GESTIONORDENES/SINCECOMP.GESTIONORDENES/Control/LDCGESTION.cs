using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using SINCECOMP.GESTIONORDENES.BL;
using SINCECOMP.GESTIONORDENES.DAL;
using SINCECOMP.GESTIONORDENES.Entities;
using SINCECOMP.GESTIONORDENES.UI;
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;


namespace SINCECOMP.GESTIONORDENES.Control
{
    public partial class LDCGESTION : UserControl
    {
        Int64 nuTipoTrab = 0;
        BLGENERAL general = new BLGENERAL();
        DALLEGO oDALLEGO = new DALLEGO();

        Int64 nuTipoTrabID = 0;
        Int64 nuUOACOfertados = 0;
        Int64 nuUOOfertados = 0;

        Int64 nuubicacion_geografica = 0;

        Int64 nutotaldatoadicional = 0;
        OpenSystems.Windows.Controls.OpenSimpleTextBox[] opentextbox;
        OpenSystems.Windows.Controls.OpenCombo[] OpenCombobox;

        //Dato adicional orden adicional
        Int64 nutotaldatoadicionalOtAdicional = 0;
        OpenSystems.Windows.Controls.OpenSimpleTextBox[] opentextboxDatoAdicional;
        OpenSystems.Windows.Controls.OpenCombo[] OpenComboboxDatoAdicional;
        
        //Tabla de memoria para items de datos adicionales
        DataTable DTDatoAdicionalOTAdicional = new DataTable();
        /////////////////////////////////////////////////////////////////////////

        public Int64 nuControlGuardado;

        Int64 nuControlDatoAdicionalOTAdicional;

        Int64 nuFocoObjetoDinamico = 0;
        Int64 nuGrupoObjetoDinamico = 0;

        //Variable posicion Y de datos actiivdad y datos adicionales
        Int64 nuActividad_orden = 0;
        int nuYDatoActividad = 0;
        OpenSystems.Windows.Controls.OpenSimpleTextBox[] opentextboxDatoActividad;

        //Variables para ubicar foco
        Int64 nuControlDatoActividad = 0;
        Int64 nuControlDatoAdicional = 0;
        Int64 nuControlItem = 0;

        //Dato actividad (Atributo - Componente) de la orden adicional 
        int nuYDatoActividadOTAdicional = 0;
        Int64 nuControlDatoActividadOTAdicional = 0;
        OpenSystems.Windows.Controls.OpenSimpleTextBox[] opentextboxDatoaActividadOTAdicional;

        //Tabla de memoria para items de datos adicionales
        DataTable DTDatoActividadOTAdicional = new DataTable();


        //Variable para  identificar si la causal de la OT a gestiona es de EXITO o FALLO
        Int64 ClasificadorCausalOTGestion = 0;

        //Tabla de memoria para controlar DATOS ADICIONALES y COMPONENTES ACTIVIDAD
        DataTable DTDatoAdicionalActividadOTAD = new DataTable();

        //Varaibles glabal para manejar lista de valores para ITEMS de OT principal
        //con el fin de utlizar filtro de la columna DESCIPCION
        UltraCombo UCITEMS = new UltraCombo();

        //GUARDARA LA CONSULTA PRINCIPAL DEL ULTRACOMBO
        String QueryPpal = "";
        String QueryPpalVisual = "";

        String consultaItemNoOfert = "SELECT  CODIGO_MATERIAL CODIGO, ' '||DESCRIPCION_MATERIAL||'  '||CODIGO_MATERIAL  DESCRIPCION " +
                                      "  FROM LDC_OR_TASK_TYPES_MATERIALES "+
                                      "  WHERE "+
                                       " (select count(LIUL.ITEM) from LDC_ITEM_UO_LR LIUL where LIUL.ITEM = CODIGO_MATERIAL) = 0";

        String consultaItemOfert = "SELECT CODIGO_MATERIAL CODIGO, '  '||DESCRIPCION_MATERIAL||' '||CODIGO_MATERIAL  DESCRIPCION " + 
                                    " FROM LDC_OR_TASK_TYPES_MATERIALES ";

        String consultaItemNoOfertInd = " SELECT  CODIGO_MATERIAL CODIGO,  DESCRIPCION_MATERIAL||'  '||CODIGO_MATERIAL  DESCRIPCION" +
                                   "  FROM LDC_OR_TASK_TYPES_MATERIALES " +
                                   "  WHERE (select count(LIUL.ITEM) from LDC_ITEM_UO_LR LIUL where LIUL.ITEM = CODIGO_MATERIAL) = 0 ";

        String consultaItemOfertInd = "SELECT CODIGO_MATERIAL CODIGO, DESCRIPCION_MATERIAL||'  '||CODIGO_MATERIAL DESCRIPCION " +
                                    " FROM LDC_OR_TASK_TYPES_MATERIALES ";

        String consultaItemNoOfert_268 = "SELECT  CODIGO_MATERIAL CODIGO,  ' '||DESCRIPCION_MATERIAL||'  '||CODIGO_MATERIAL  DESCRIPCION " +
                                      "  FROM LDC_OR_TASK_TYPES_MATERIALES " +
                                      "  WHERE " +
                                       " (select count(LIUL.ITEM) from LDC_ITEM_UO_LR LIUL where LIUL.ITEM = CODIGO_MATERIAL " +
                                       " and not exists (select null from LDC_HOMOITMAITAC where ITEM_ACTIVIDAD=LIUL.ITEM)) = 0";

        String consultaItemNoOfertInd_268 = "SELECT  CODIGO_MATERIAL CODIGO,   DESCRIPCION_MATERIAL||'  '||CODIGO_MATERIAL DESCRIPCION " +
                                   "  FROM LDC_OR_TASK_TYPES_MATERIALES " +
                                   "  WHERE " +
                                    " (select count(LIUL.ITEM) from LDC_ITEM_UO_LR LIUL where LIUL.ITEM = CODIGO_MATERIAL " +
                                    " and not exists (select null from LDC_HOMOITMAITAC where ITEM_ACTIVIDAD=LIUL.ITEM)) = 0";

        
        BLLEGO bllego = new BLLEGO();
        Int64 yesAplica;

        Int64 Siaplixcaso;

        public LDCGESTION()
        {
            InitializeComponent();

            //desactivar las pestañas
            tcPpal.Tabs[0].Enabled = false;
            tcPpal.Tabs[1].Enabled = false;

            //Congiuracion Grilla Gestion OT
            //Tipo trabajo
            dtgTrabAdic.DisplayLayout.Bands[0].Columns["tipotrab"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            dtgTrabAdic.DisplayLayout.Bands[0].Columns["tipotrab"].FilterOperatorDropDownItems = FilterOperatorDropDownItems.Equals
                    | FilterOperatorDropDownItems.StartsWith
                    | FilterOperatorDropDownItems.Contains
                    | FilterOperatorDropDownItems.Like;          
            dtgTrabAdic.DisplayLayout.Bands[0].Columns["tipotrab"].Width = 220;
            //Causal
            dtgTrabAdic.DisplayLayout.Bands[0].Columns["causal"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate; 
            dtgTrabAdic.DisplayLayout.Bands[0].Columns["causal"].Width = 100;

            //Actividad
            dtgTrabAdic.DisplayLayout.Bands[0].Columns["actividad"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate; 
            dtgTrabAdic.DisplayLayout.Bands[0].Columns["actividad"].Width = 220;
            //Item
            dtgTrabAdic.DisplayLayout.Bands[0].Columns["item"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            dtgTrabAdic.DisplayLayout.Bands[0].Columns["item"].Width = 220;
            //Valor Unitario
            dtgTrabAdic.DisplayLayout.Bands[0].Columns["valormaterial"].CellActivation = Activation.NoEdit;
            //Valor Total 
            dtgTrabAdic.DisplayLayout.Bands[0].Columns["valortotalmaterial"].CellActivation = Activation.NoEdit;

            /////Grilla Item Orden Gestion
            ugItemOrdenGestion.DisplayLayout.Bands[0].Columns["item"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            ugItemOrdenGestion.DisplayLayout.Bands[0].Columns["item"].Width = 220;
            //Valor Unitario
            ugItemOrdenGestion.DisplayLayout.Bands[0].Columns["valoritem"].CellActivation = Activation.NoEdit;
            //Valor Total 
            ugItemOrdenGestion.DisplayLayout.Bands[0].Columns["valortotalitem"].CellActivation = Activation.NoEdit;


            //Creacion de campos de la tabla de memoria
            DTDatoAdicionalOTAdicional.Columns.Clear();
            DTDatoAdicionalOTAdicional.Rows.Clear();
            DTDatoAdicionalOTAdicional.Columns.Add("orden");
            DTDatoAdicionalOTAdicional.Columns.Add("tipotrab");
            DTDatoAdicionalOTAdicional.Columns.Add("causal");
            DTDatoAdicionalOTAdicional.Columns.Add("codigodatoadicional");
            DTDatoAdicionalOTAdicional.Columns.Add("valordatoadicional");
            DTDatoAdicionalOTAdicional.Columns.Add("actividad");
            DTDatoAdicionalOTAdicional.Columns.Add("material");

            //Creacion de campos de la tabla de memoria para Datos Actividad para la actividad del Trabajo Adicional
            DTDatoActividadOTAdicional.Columns.Clear();
            DTDatoActividadOTAdicional.Rows.Clear();
            DTDatoActividadOTAdicional.Columns.Add("orden");
            DTDatoActividadOTAdicional.Columns.Add("actividad");
            DTDatoActividadOTAdicional.Columns.Add("material");
            DTDatoActividadOTAdicional.Columns.Add("atributo");
            DTDatoActividadOTAdicional.Columns.Add("valoratributo");
            DTDatoActividadOTAdicional.Columns.Add("componente");
            DTDatoActividadOTAdicional.Columns.Add("valorcomponente");

            //Creacion de campos de la tabla de memoria para Datos Adicionales y Actividad del Trabajo Adicional
            DTDatoAdicionalActividadOTAD.Columns.Clear();
            DTDatoAdicionalActividadOTAD.Rows.Clear();
            DTDatoAdicionalActividadOTAD.Columns.Add("orden");
            DTDatoAdicionalActividadOTAD.Columns.Add("tipotrab");
            DTDatoAdicionalActividadOTAD.Columns.Add("causal");
            DTDatoAdicionalActividadOTAD.Columns.Add("actividad");
            DTDatoAdicionalActividadOTAD.Columns.Add("material");

            /*Caso 200-1580*/
            this.tcPpal.Tabs[2].Enabled = false;

            ///Inicio caso 200-2692
            yesAplica = bllego.AplicaEntrega("OSS_CON_MABG_2002692_1");
            ///Fin caso 200-2692

            /// inicio caso 268
            Siaplixcaso = bllego.AplicaEntrega("OSS_HT_0000268_2");

            if (Siaplixcaso == 1)
            {
                consultaItemNoOfert = consultaItemNoOfert_268;
                consultaItemNoOfertInd = consultaItemNoOfertInd_268;
            }

            /// fin caso 268
        }

        private void tsb_agregar_Click(object sender, EventArgs e)
        {
            if (bsTrabAdic.Count == 0)
            {
                //Agregar una nueva fila en la grilla
                bsTrabAdic.AddNew();
            }
            else
            {
                if ((dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[0].Value.ToString() != "0") && !String.IsNullOrEmpty(dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[0].Value.ToString()))
                {
                    //Agregar una nueva fila en la grilla
                    bsTrabAdic.AddNew();
                }
            }
        }

        private void tsb_eliminar_Click(object sender, EventArgs e)
        {
            int totalFila = dtgTrabAdic.Rows.Count;

            for (int j = totalFila - 1; j >= 0; j--)
            {
                if (dtgTrabAdic.Rows[j].Cells[0].Value.ToString() == "True")
                {                    
                    dtgTrabAdic.Rows[j].Delete(false);
                }
            }

        }

        private void dtgTrabAdic_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            //Codigo para inicializar la columna y definir un boton en lugar de celda para edicion en al grilla
            Infragistics.Win.UltraWinGrid.UltraGridLayout layout = e.Layout;
            Infragistics.Win.UltraWinGrid.UltraGridBand band = layout.Bands[0];
            Infragistics.Win.UltraWinGrid.UltraGridColumn buttonColumn = band.Columns.Add("Accion");
            buttonColumn.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
        }

        private void dtgTrabAdic_InitializeRow(object sender, Infragistics.Win.UltraWinGrid.InitializeRowEventArgs e)
        {
            //Inicializar al etiqueta y valor del boton en al grilla
            if (e.ReInitialize == false)
            {
                e.Row.Cells["Accion"].Value = "Eliminar";
            }
        }

        private void dtgTrabAdic_ClickCellButton(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            if (bsTrabAdic.Count > 0)
            {
                ///////Eliminar datos adicionales del tipo de trabajo adicional
                DataRow[] dtr = DTDatoAdicionalOTAdicional.Select("orden = " + Convert.ToInt64(tbOrden.Text) + " and tipotrab = " + Convert.ToInt64(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value) + " and causal = " + Convert.ToInt64(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].Value) + " and actividad = " + Convert.ToInt64(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].Value) + " and material = " + Convert.ToInt64(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].Value));
                foreach (var drow in dtr)
                {
                    drow.Delete();
                }
                DTDatoAdicionalOTAdicional.AcceptChanges();

                //AL utilizar le boton elimina la fila del boton utilizado.
                ultraTabPageControl5.Controls.Clear();
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Delete(false);
            }
        }

        private void dtgTrabAdic_BeforeCellActivate(object sender, Infragistics.Win.UltraWinGrid.CancelableCellEventArgs e)
        {
            if (e.Cell.Column.Key == "tipotrab" && (dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].ValueList == null || Convert.ToInt64(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value) == 0))
            {
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].ValueList = general.valuelistNumberId("select ott.task_type_id CODIGO, ott.description DESCRIPCION from or_task_type ott where ott.task_type_id in (select LDC_TTA.TIPOTRABADICLEGO_ID from LDC_TIPOTRABADICLEGO LDC_TTA where LDC_TTA.TIPOTRABLEGO_ID = " + nuTipoTrabID + ") order by ott.task_type_id", "DESCRIPCION", "CODIGO");

                //Columan Causal
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].ValueList = null;
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].Value = 0;

                //Columna actividad
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].ValueList = null;
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].Value = 0;

                //Columna material
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].ValueList = null;
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].Value = 0;
            }
            else if (e.Cell.Column.Key == "causal" && dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].ValueList == null)
            {            
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].ValueList = general.valuelistNumberId("select gc.causal_id CODIGO, gc.description DESCRIPCION from ge_causal gc where gc.causal_id in (select ottc.causal_id from or_task_type_causal ottc where ottc.task_type_id = " + dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value + ") order by gc.causal_id ASC", "DESCRIPCION", "CODIGO");                
                Int64 nuCausalTipoTrab = DALLEGO.FnuTipoTrab(nuTipoTrabID, Convert.ToInt64(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value));
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].Value = nuCausalTipoTrab;
            }
            else if (e.Cell.Column.Key == "actividad" && dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].ValueList == null)
            {
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].ValueList = null;
                if (nuUOACOfertados == 0)
                {
                    //Caso 200-2692//
                    if (yesAplica == 1)
                    {
                        dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].ValueList = general.valuelistNumberId("SELECT LOT.CODIGO_ACTIVIDAD CODIGO, LOT.DESCRIPCION_ACTIVIDAD DESCRIPCION FROM LDC_OR_TASK_TYPES_ITEMS LOT WHERE LOT.TIPO_TRABAJO =" + dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value + " AND NOT EXISTS (SELECT * FROM CT_ITEM_NOVELTY CT WHERE CT.ITEMS_ID = LOT.CODIGO_ACTIVIDAD) ORDER BY CODIGO_ACTIVIDAD ASC", "DESCRIPCION", "CODIGO");
                    }
                    else
                    {
                        dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].ValueList = general.valuelistNumberId("SELECT CODIGO_ACTIVIDAD CODIGO, DESCRIPCION_ACTIVIDAD DESCRIPCION FROM LDC_OR_TASK_TYPES_ITEMS WHERE TIPO_TRABAJO =" + dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value + " ORDER BY CODIGO_ACTIVIDAD ASC", "DESCRIPCION", "CODIGO");
                    }
                    //Fin Caso 200-2692//

                    dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].Value = DALLEGO.FnuDatoInicialListaValores("ActividadNoOfertado", Convert.ToInt64(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value), 0);
                }
                else
                {
                    //Caso 200-2692//
                    if (yesAplica == 1)
                    {
                        dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].ValueList = general.valuelistNumberId("SELECT LOT.CODIGO_ACTIVIDAD CODIGO, LOT.DESCRIPCION_ACTIVIDAD DESCRIPCION FROM LDC_OR_TASK_TYPES_ITEMS LOT WHERE LOT.TIPO_TRABAJO = " + dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value + "AND LOT.CODIGO_ACTIVIDAD in (select LIUOL.ACTIVIDAD from LDC_ITEM_UO_LR LIUOL where LIUOL.UNIDAD_OPERATIVA = " + nuUOOfertados + ") AND NOT EXISTS (SELECT * FROM CT_ITEM_NOVELTY CT WHERE CT.ITEMS_ID = LOT.CODIGO_ACTIVIDAD) ORDER BY CODIGO_ACTIVIDAD ASC", "DESCRIPCION", "CODIGO");
                    }
                    else
                    {
                        dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].ValueList = general.valuelistNumberId("SELECT CODIGO_ACTIVIDAD CODIGO, DESCRIPCION_ACTIVIDAD DESCRIPCION FROM LDC_OR_TASK_TYPES_ITEMS WHERE TIPO_TRABAJO = " + dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value + " AND CODIGO_ACTIVIDAD in (select LIUOL.ACTIVIDAD from LDC_ITEM_UO_LR LIUOL where LIUOL.UNIDAD_OPERATIVA = " + nuUOOfertados + ") ORDER BY CODIGO_ACTIVIDAD ASC", "DESCRIPCION", "CODIGO");
                    }
                    //Fin Caso 200-2692//

                    dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].Value = DALLEGO.FnuDatoInicialListaValores("ActividadOfertado", Convert.ToInt64(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value), nuUOOfertados);
                }
            }
            else if (e.Cell.Column.Key == "item" && dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].ValueList == null)
            {
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].ValueList = null;
                if (nuUOACOfertados == 0)
                {
                    dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].ValueList = general.valuelistNumberId(consultaItemNoOfert + " and TIPO_TRABAJO =" + dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value + " ORDER BY CODIGO_MATERIAL ASC", "DESCRIPCION", "CODIGO");   
                }
                else
                {
                    dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].ValueList = general.valuelistNumberId(consultaItemOfert + " WHERE TIPO_TRABAJO =" + dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value + " AND CODIGO_MATERIAL IN (select LIUOL.ITEM from LDC_ITEM_UO_LR LIUOL where LIUOL.UNIDAD_OPERATIVA = " + nuUOOfertados + " AND LIUOL.ACTIVIDAD = " + dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].Value + ") ORDER BY CODIGO_MATERIAL ASC", "DESCRIPCION", "CODIGO");
                }
            }
            #region Caso 200-1580
            //Caso 200-1580
            //Daniel Valiente
            //Ordenes Garantias LEGO Cotizacion

            if (!String.IsNullOrEmpty(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value.ToString()) && !String.IsNullOrEmpty(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].Value.ToString()))
            {
                //verificador
                if (BLLEGO.FNUEXISTENCIAGARANTIA(Int64.Parse(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value.ToString()), Int64.Parse(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].Value.ToString())) == 1)
                {
                    this.tcPpal.Tabs[2].Enabled = true;
                    llenar(Int64.Parse(tbOrden.Text), Int64.Parse(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value.ToString()));
                }
                else
                {
                    this.tcPpal.Tabs[2].Enabled = false;
                }
            }
            else
            {
                this.tcPpal.Tabs[2].Enabled = false;
            }

            #endregion
        }

        private void dtgTrabAdic_BeforeCellUpdate(object sender, Infragistics.Win.UltraWinGrid.BeforeCellUpdateEventArgs e)
        {
            if (String.IsNullOrEmpty(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value.ToString()))
            {
                nuTipoTrab = 0;
            }
            else
            {
                nuTipoTrab = Convert.ToInt64(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value);
            }

            if (e.Cell.Column.Key == "actividad" && Convert.ToInt64(e.NewValue) != 0 && !String.IsNullOrEmpty(e.NewValue.ToString()))
            {
            }

            if (e.Cell.Column.Key == "cantidad")
            {
            }


        }

        private void dtgTrabAdic_AfterCellUpdate(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
        {
            if (String.IsNullOrEmpty(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value.ToString()))
            {
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].ValueList = null;
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].Value = 0;
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].ValueList = null;
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].Value = 0;
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].ValueList = null;
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[4].Value = 0;
            }
            else
            {
                Int64 nuNuevoTipoTrab = Convert.ToInt64(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value);
                if (nuTipoTrab != nuNuevoTipoTrab)
                {

                    dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].ValueList = null;
                    dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].Value = 0;
                    dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].ValueList = null;
                    dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[2].Value = 0;
                    dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].ValueList = null;
                    dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].Value = 0;
                }
            }

            if (e.Cell.Column.Key == "item" && Convert.ToInt64(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].Value) != 0)
            {
                Int64 nuItemTA = Convert.ToInt64(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].Value);
                Int64 nuTTTA = Convert.ToInt64(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value);
                TrabajoAdicional articleSel;
                Int64 nuExisteItem = -1;

                for (int index = 0; index < bsTrabAdic.Count; index++)
                {
                    articleSel = (TrabajoAdicional)bsTrabAdic[index];

                    if (nuItemTA == articleSel.item && nuTTTA == articleSel.tipotrab)
                    {
                        if (nuExisteItem == -1)
                        {
                            nuExisteItem = index;
                        }
                    }
                }

                if (nuExisteItem != e.Cell.Row.Index)
                {
                    MessageBox.Show("El item [" + nuItemTA + "] ya esta definido en un trabajo adicional [" + nuTTTA + "]"); 
                    dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[3].Value = 0;
                    dtgTrabAdic.Focus();
                }
                else
                {
                    if (nuItemTA != 0)
                    {
                        Int64 ONUPRICELISTID;
                        Int64 ONUVALUE;
                        oDALLEGO.getlistitemvalue(nuItemTA, Convert.ToDateTime(tbFinEjecu.TextBoxValue), nuUOOfertados, 0, 0, nuubicacion_geografica, 1, out ONUPRICELISTID, out ONUVALUE);

                        dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[5].Value = ONUVALUE;                        
                    }
                }
            }

            if (e.Cell.Column.Key == "cantidad")
            {
                dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[6].Value = Convert.ToDouble(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[4].Value) * Convert.ToDouble(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[5].Value);

                GraficoDatoAdicional(Convert.ToInt64(tbOrden.Text), dtgTrabAdic.ActiveCell.Row.Index, Convert.ToInt64(dtgTrabAdic.Rows[dtgTrabAdic.ActiveCell.Row.Index].Cells[0].Value), Convert.ToInt64(dtgTrabAdic.Rows[dtgTrabAdic.ActiveCell.Row.Index].Cells[1].Value), "0", "0", Convert.ToInt64(dtgTrabAdic.Rows[dtgTrabAdic.ActiveCell.Row.Index].Cells[2].Value), Convert.ToInt64(dtgTrabAdic.Rows[dtgTrabAdic.ActiveCell.Row.Index].Cells[3].Value));
            }

            #region Caso 200-1580
            //Caso 200-1580
            //Daniel Valiente
            //Ordenes Garantias LEGO Cotizacion

            if (e.Cell.Column.Key == "causal")
            {
                if (!String.IsNullOrEmpty(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value.ToString()) && !String.IsNullOrEmpty(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].Value.ToString()))
                {
                    if (BLLEGO.FNUEXISTENCIAGARANTIA(Int64.Parse(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value.ToString()), Int64.Parse(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[1].Value.ToString())) == 1)
                    {
                        this.tcPpal.Tabs[2].Enabled = true;
                        llenar(Int64.Parse(tbOrden.Text), Int64.Parse(dtgTrabAdic.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value.ToString()));
                    }
                    else
                    {
                        this.tcPpal.Tabs[2].Enabled = false;
                    }
                }
                else
                {
                    this.tcPpal.Tabs[2].Enabled = false;
                }
            }

            #endregion

        }

        private void tsb_guardar_Click(object sender, EventArgs e)
        {
            PrGuardarDatos();            
        }

        private void dtgTrabAdic_Leave(object sender, EventArgs e)
        {
        }

        private void dtgTrabAdic_Error(object sender, Infragistics.Win.UltraWinGrid.ErrorEventArgs e)
        {
            if (e.ErrorType == ErrorType.Data)
            {
                ////Codigo para indicar el tipo de error generado
                dtgTrabAdic.ActiveCell.Value = 0;

                e.Cancel = true;
            }
        }

        private void tbFinEjecu_TabIndexChanged(object sender, EventArgs e)
        {
        }

        private void tbFinEjecu_Leave(object sender, EventArgs e)
        {
            if (Convert.ToDateTime(tbFinEjecu.TextBoxValue).Date > DateTime.Today)
            {
                MessageBox.Show("La fechal final de ejecucion no puede ser mayor a la fecha final del sistema.");
                tbFinEjecu.TextBoxObjectValue = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();
                tbFinEjecu.Focus();
            }
            else
            {
                if (nuControlDatoActividad == 1)
                {
                    TcDatoAdcionalOTGestion.SelectedTab = TcDatoAdcionalOTGestion.Tabs[0];
                }
                else
                {
                    if (nuControlDatoAdicional == 1)
                    {
                        TcDatoAdcionalOTGestion.SelectedTab = TcDatoAdcionalOTGestion.Tabs[0];
                    }
                    else
                    {
                        TcDatoAdcionalOTGestion.SelectedTab = TcDatoAdcionalOTGestion.Tabs[1];
                    }                    
                }
            }
        }

        private void tbOrden_Leave(object sender, EventArgs e)
        {
            try
            {
                if (!String.IsNullOrEmpty(tbOrden.Text))
                {
                    UCITEMS.DataSource = null;
                    DataTable BasicDate = DALGENERAL.FrfOrdenTrabajo(Convert.ToInt64(tbOrden.Text));
                    if (BasicDate.Rows.Count > 0)
                    {

                        System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                        //iniicalizar datos basicos de la orden
                        ulbDepa.Text = BasicDate.Rows[0]["departamento"].ToString();
                        ulbLoca.Text = BasicDate.Rows[0]["localidad"].ToString();
                        ulbTipoTrab.Text = BasicDate.Rows[0]["tipotrabajo"].ToString();
                        ulbFechCrea.Text = BasicDate.Rows[0]["fechacreacion"].ToString();
                        ulbFechAsig.Text = BasicDate.Rows[0]["fechaasignacion"].ToString();
                        ulbDireccion.Text = BasicDate.Rows[0]["direccion"].ToString();
                        ulbUnidadTrabajo.Text = BasicDate.Rows[0]["operating_unit_id"].ToString() + " - " + BasicDate.Rows[0]["operating_unit_name"].ToString();
                        ulbProducto.Text = BasicDate.Rows[0]["product_id"].ToString();
                        ulbContrato.Text = BasicDate.Rows[0]["subscription_id"].ToString();
                        ulbSolicitud.Text = BasicDate.Rows[0]["package_id"].ToString();
                        ulbCiclo.Text = BasicDate.Rows[0]["susccicl"].ToString() + " - " + BasicDate.Rows[0]["cicldesc"].ToString();

                        nuUOACOfertados = DALLEGO.FnuUOACOfertados(Convert.ToInt64(BasicDate.Rows[0]["operating_unit_id"].ToString()));
                        nuUOOfertados = Convert.ToInt64(BasicDate.Rows[0]["operating_unit_id"].ToString());                        

                        nuubicacion_geografica = Convert.ToInt64(BasicDate.Rows[0]["ubicacion_geografica"].ToString());
                        nuTipoTrabID = Convert.ToInt64(BasicDate.Rows[0]["tipotrabajo_id"].ToString());
                        nuActividad_orden = Convert.ToInt64(BasicDate.Rows[0]["actividad"].ToString());

                        //CASO 200-1528
                        //Agregar medidor a servicio de validacion y parte visual de orden en GESTION
                        ulbMedidor.Text = BasicDate.Rows[0]["medidor"].ToString();
                        ulbMarca.Text = BasicDate.Rows[0]["marca"].ToString();
                        //

                        //activar pestaña
                        tcPpal.Tabs[0].Enabled = true;
                        //Bloquear pestaña de datos adicionales en caso de no tener configurado trabajos adicionales
                        DataTable DTTrabajoAdicional = general.getValueList("select lttal.tipotrablego_id CODIGO, lttal.tipotrabadiclego_id DESCRIPCION from ldc_tipotrabadiclego lttal where lttal.tipotrablego_id = " + nuTipoTrabID);

                        if (DTTrabajoAdicional.Rows.Count > 0)
                        {
                            tcPpal.Tabs[1].Enabled = true;
                        }
                        else
                        {
                            tcPpal.Tabs[1].Enabled = false;
                        }
                        tcPpal.SelectedTab = tcPpal.Tabs[0];
                        //////////////////////////////////////////////////////////////////////////////////////

                        Int64 nuCausal = 0;
                        Int64 nuTecnicoLegaliza = 0;
                        String sbUnicoTecnico = "N";

                        DataTable DTFrfFuncionalLEGO = DALLEGO.FrfFuncionalLEGO();
                        if (DTFrfFuncionalLEGO.Rows.Count > 0)
                        {

                            foreach (DataRow row in DTFrfFuncionalLEGO.Rows)
                            {

                                nuCausal = 9595;
                                nuTecnicoLegaliza = Convert.ToInt64(row["tecnico_unidad"].ToString());
                                sbUnicoTecnico = row["unico_tecnico"].ToString();

                            }
                        }

                        //Inicializar datos en la lista de valores CAUSALES                        
                        DataTable causallegOT = general.getValueList("SELECT GC.CAUSAL_ID CODIGO,GC.DESCRIPTION DESCRIPCION FROM GE_CAUSAL GC ,OR_TASK_TYPE_CAUSAL OTTC WHERE OTTC.TASK_TYPE_ID =" + Convert.ToInt64(BasicDate.Rows[0]["tipotrabajo_id"].ToString()) + " AND GC.CAUSAL_ID=OTTC.CAUSAL_ID ORDER BY GC.CAUSAL_ID");
                        this.cbCausal.DataSource = causallegOT;
                        this.cbCausal.DisplayMember = "DESCRIPCION";
                        this.cbCausal.ValueMember = "CODIGO";
                        
                        Int64 nuCausalTipoTrab = DALLEGO.FnuTipoTrab(nuTipoTrabID, 0);

                        if (nuCausalTipoTrab > 0)
                        {
                            nuCausal = nuCausalTipoTrab;
                        }

                        if (nuCausal > 0)
                        {
                            this.cbCausal.Value = nuCausal;
                        }

                        DataTable TecnicoLegalizaOT = general.getValueList("select ooup.person_id CODIGO, dage_person.fsbgetname_(ooup.person_id, null) DESCRIPCION from or_oper_unit_persons ooup where ooup.operating_unit_id =" + Convert.ToInt64(BasicDate.Rows[0]["operating_unit_id"].ToString()) + " ORDER BY ooup.person_id");
                        this.oCbTecnicoLego.DataSource = TecnicoLegalizaOT;
                        this.oCbTecnicoLego.DisplayMember = "DESCRIPCION";
                        this.oCbTecnicoLego.ValueMember = "CODIGO";
                        if (nuTecnicoLegaliza > 0)
                        {
                            this.oCbTecnicoLego.Value = nuTecnicoLegaliza;
                        }

                        if (sbUnicoTecnico == "S")
                        {
                            oCbTecnicoLego.Enabled = false;
                        }
                        else
                        {
                            oCbTecnicoLego.Enabled = true;
                        }

                        tbOrden.Enabled = false;

                        //Inicializar fecha de la orden en ejecucion 
                        if (!String.IsNullOrEmpty(BasicDate.Rows[0]["fecha_ini_ejecucion"].ToString()))
                        {
                            tbInicioEjecu.TextBoxObjectValue = Convert.ToDateTime(BasicDate.Rows[0]["fecha_ini_ejecucion"].ToString());
                            tbInicioEjecu.Visible = false;
                            ulInicioEjecucion.Visible = true;
                            ulFechaInicioEjecicion.Visible = true;
                            ulFechaInicioEjecicion.Text = BasicDate.Rows[0]["fecha_ini_ejecucion"].ToString();
                        }
                        if (!String.IsNullOrEmpty(BasicDate.Rows[0]["fecha_fin_ejecucion"].ToString()))
                        {
                            tbFinEjecu.TextBoxObjectValue = Convert.ToDateTime(BasicDate.Rows[0]["fecha_fin_ejecucion"].ToString());
                            tbFinEjecu.Visible = false;
                            ulFinEjecucion.Visible = true;
                            ulFechaFinEjecucion.Visible = true;
                            ulFechaFinEjecucion.Text = BasicDate.Rows[0]["fecha_fin_ejecucion"].ToString();
                        }

                        BtnGuardar.Enabled = true;
                        BtnNuevo.Enabled = true;

                        txtObservacion.Focus();

                        System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

                    }
                    else
                    {
                        MessageBox.Show("La orden [" + tbOrden.Text + "] puede ya estar gestonada, no tiene relacion con el funcionario, no tiene estado valido, el tipo de trabajo no esta configurado para LEGO o la orden no existe. Valide la orden y/o configuraciones.");
                        ulbDepa.Text = "";
                        ulbLoca.Text = "";
                        ulbTipoTrab.Text = "";
                        ulbFechAsig.Text = "";
                        ulbFechCrea.Text = "";
                        ulbFechProg.Text = "";
                        ulbDireccion.Text = "";

                        tbOrden.Text = "";
                        cbCausal.Value = "";
                        txtObservacion.Text = "";
                        tbInicioEjecu.TextBoxValue = "";
                        tbFinEjecu.TextBoxValue = "";
                        bsTrabAdic.Clear();
                    }
                }
            }
            catch
            {
            }
        }

        private void dtgTrabAdic_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.F5)
            {
                if (dtgTrabAdic.Rows.Count == 0)
                {
                    //Agregar una nueva fila en la grilla
                    bsTrabAdic.AddNew();
                    ActivarCelda(0);
                }
                else
                {
                    if ((dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[0].Value.ToString() != "0") && !String.IsNullOrEmpty(dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[0].Value.ToString()))
                    {
                        //Agregar una nueva fila en la grilla
                        bsTrabAdic.AddNew();
                        ActivarCelda(0);
                    }
                }
            }
            else
            {
                if (e.KeyCode == Keys.F6)
                {
                    if (dtgTrabAdic.Rows.Count > 0)
                    {
                        if ((dtgTrabAdic.Rows[dtgTrabAdic.Rows.Count - 1].Cells[0].Value.ToString() != "0") && !String.IsNullOrEmpty(dtgTrabAdic.Rows[dtgTrabAdic.Rows.Count - 1].Cells[0].Value.ToString()))
                        {
                            //Agregar una nueva fila en la grilla
                            Int64 nutipotrabadic = Convert.ToInt64(dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[0].Value.ToString());
                            Int64 nucausal = Convert.ToInt64(dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[1].Value.ToString());
                            Int64 nuactitipotrabadic = Convert.ToInt64(dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[2].Value.ToString());
                            bsTrabAdic.AddNew();
                            dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[0].Value = nutipotrabadic;
                            ActivarCelda(0);
                            Int64 nuCausalTipoTrab = DALLEGO.FnuTipoTrab(nuTipoTrabID, nutipotrabadic); 
                            dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[1].Value = nuCausalTipoTrab;//nucausal;
                            ActivarCelda(1);
                            dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[1].Value = nucausal; 
                            dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[2].Value = nuactitipotrabadic;
                            ActivarCelda(2);
                            dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[3].Value = 0;
                            ActivarCelda(3);
                        }
                    }
                }
            }
        }

        private void tcPpal_KeyDown(object sender, KeyEventArgs e)
        {
            if (tcPpal.Tabs[1].Active == true)
            {
                if (e.KeyCode == Keys.F5)
                {
                    if (dtgTrabAdic.Rows.Count == 0)
                    {
                        //Agregar una nueva fila en la grilla
                        bsTrabAdic.AddNew();
                        ActivarCelda(0);
                    }
                    else
                    {
                        if ((dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[0].Value.ToString() != "0") && !String.IsNullOrEmpty(dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[0].Value.ToString()))
                        {
                            //Agregar una nueva fila en la grilla
                            bsTrabAdic.AddNew();
                            ActivarCelda(0);
                        }
                    }
                }
                else
                {
                    if (e.KeyCode == Keys.F6)
                    {
                        if (dtgTrabAdic.Rows.Count > 0)
                        {
                            if ((dtgTrabAdic.Rows[dtgTrabAdic.Rows.Count - 1].Cells[0].Value.ToString() != "0") && !String.IsNullOrEmpty(dtgTrabAdic.Rows[dtgTrabAdic.Rows.Count - 1].Cells[0].Value.ToString()))
                            {
                                //Agregar una nueva fila en la grilla
                                Int64 nutipotrabadic = Convert.ToInt64(dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[0].Value.ToString());
                                Int64 nucausal = Convert.ToInt64(dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[1].Value.ToString());
                                Int64 nuactitipotrabadic = Convert.ToInt64(dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[2].Value.ToString());
                                bsTrabAdic.AddNew();
                                dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[0].Value = nutipotrabadic;
                                ActivarCelda(0);
                                Int64 nuCausalTipoTrab = DALLEGO.FnuTipoTrab(nuTipoTrabID, nutipotrabadic); 
                                dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[1].Value = nuCausalTipoTrab;//nucausal;
                                ActivarCelda(1);
                                dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[2].Value = nuactitipotrabadic;
                                ActivarCelda(2);
                                dtgTrabAdic.Rows[bsTrabAdic.Count - 1].Cells[3].Value = 0;
                                ActivarCelda(3);
                            }
                        }
                    }
                }
            }
        }

        private void ActivarCelda(Int64 CeldaAcrivar)
        {
            if (CeldaAcrivar == 0)
            {
                UltraGridRow aUGRow = dtgTrabAdic.GetRow(ChildRow.First);
                for (int intPtr = 1; intPtr <= dtgTrabAdic.Rows.Count - 1; intPtr++)
                {
                    aUGRow = aUGRow.GetSibling(SiblingRow.Next);
                }
                dtgTrabAdic.ActiveRow = aUGRow;
                dtgTrabAdic.ActiveCell = aUGRow.Cells["tipotrab"];
                dtgTrabAdic.PerformAction(UltraGridAction.EnterEditMode, false, false);
            }
            else
            {
                if (CeldaAcrivar == 1)
                {
                    UltraGridRow aUGRow = dtgTrabAdic.GetRow(ChildRow.First);
                    for (int intPtr = 1; intPtr <= dtgTrabAdic.Rows.Count - 1; intPtr++)
                    {
                        aUGRow = aUGRow.GetSibling(SiblingRow.Next);
                    }
                    dtgTrabAdic.ActiveRow = aUGRow;
                    dtgTrabAdic.ActiveCell = aUGRow.Cells["causal"];
                    dtgTrabAdic.PerformAction(UltraGridAction.EnterEditMode, false, false);
                }
                else
                {
                    if (CeldaAcrivar == 2)
                    {
                        UltraGridRow aUGRow = dtgTrabAdic.GetRow(ChildRow.First);
                        for (int intPtr = 1; intPtr <= dtgTrabAdic.Rows.Count - 1; intPtr++)
                        {
                            aUGRow = aUGRow.GetSibling(SiblingRow.Next);
                        }
                        dtgTrabAdic.ActiveRow = aUGRow;
                        dtgTrabAdic.ActiveCell = aUGRow.Cells["actividad"];
                        dtgTrabAdic.PerformAction(UltraGridAction.EnterEditMode, false, false);
                    }
                    else
                    {
                        if (CeldaAcrivar == 3)
                        {
                            UltraGridRow aUGRow = dtgTrabAdic.GetRow(ChildRow.First);
                            for (int intPtr = 1; intPtr <= dtgTrabAdic.Rows.Count - 1; intPtr++)
                            {
                                aUGRow = aUGRow.GetSibling(SiblingRow.Next);
                            }
                            dtgTrabAdic.ActiveRow = aUGRow;
                            dtgTrabAdic.ActiveCell = aUGRow.Cells["item"];
                            dtgTrabAdic.PerformAction(UltraGridAction.EnterEditMode, false, false);
                        }
                    }
                }
            }
        }

        private void tcPpal_SelectedTabChanged(object sender, Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs e)
        {
            if (tcPpal.Tabs[1].Active == true)
            {

                //Valida Causal
                if (String.IsNullOrEmpty(cbCausal.Text))
                {
                    MessageBox.Show("Debe seleccionar una causal.");
                    tcPpal.SelectedTab = tcPpal.Tabs[0];
                }
                else
                {

                    //Valida Tecnico Legaliza
                    if (String.IsNullOrEmpty(oCbTecnicoLego.Text))
                    {
                        MessageBox.Show("Debe seleccionar una Tecnico Legaliza.");
                        tcPpal.SelectedTab = tcPpal.Tabs[0];
                    }
                    else
                    {

                        //Valida Observacion
                        if (String.IsNullOrEmpty(txtObservacion.Text))
                        {
                            MessageBox.Show("Debe colocar observacion.");
                            tcPpal.SelectedTab = tcPpal.Tabs[0];
                        }
                        else
                        {

                            //Valida Fechga inicio
                            if (String.IsNullOrEmpty(tbInicioEjecu.TextBoxValue))
                            {
                                MessageBox.Show("Debe seleccionar fecha inicio ejecucion.");
                                tcPpal.SelectedTab = tcPpal.Tabs[0];
                            }
                            else
                            {

                                //Valida fecha fin ejecucion
                                if (String.IsNullOrEmpty(tbFinEjecu.TextBoxValue))
                                {
                                    MessageBox.Show("Debe seleccionar fecha final ejecucion.");
                                    tcPpal.SelectedTab = tcPpal.Tabs[0];
                                }
                            }
                        }
                    }
                }
            }
        }

        private void cbCausal_ValueChanged(object sender, EventArgs e)
        {

            ultraTabPageControl3.Controls.Clear();

            /////////////////////////////////////////////////////
            //Datos actividad de la orden a gestionar

            //CASO 200-1528
            Int64 NuClasificadorCausal = 0;
            NuClasificadorCausal = DALLEGO.FnuClasificadorCausal(Convert.ToInt64(cbCausal.Value));
            ClasificadorCausalOTGestion = NuClasificadorCausal;
            //////////////////

            if (NuClasificadorCausal == 1)
            {


                int nuY = 10;
                //CASO 200-2089
                Int64 NuClasificadorCausalActivity = 0;
                NuClasificadorCausalActivity = DALLEGO.FnClasificadorCausalActivitdad(Convert.ToInt64(cbCausal.Value));
                if (NuClasificadorCausalActivity == 1)
                {
                    opentextboxDatoActividad = new OpenSystems.Windows.Controls.OpenSimpleTextBox[12];
                    DataTable DTDatosActividad = DALLEGO.FrfDatosActividad(nuActividad_orden);
                    if (DTDatosActividad.Rows.Count > 0)
                    {
                        int ii = 0;
                        int iii = 0;

                        for (int i = 0; i <= DTDatosActividad.Rows.Count - 1; i++)
                        {
                            nuY = nuY + 20;

                            opentextboxDatoActividad[iii] = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
                            opentextboxDatoActividad[iii].Name = DTDatosActividad.Rows[i]["NOMBRE"].ToString() + "_" + DTDatosActividad.Rows[i]["Ubicacion"].ToString();
                            opentextboxDatoActividad[iii].Caption = DTDatosActividad.Rows[i]["NOMBRE_DESPLIEGUE"].ToString().ToUpper();
                            opentextboxDatoActividad[iii].CharacterCasing = CharacterCasing.Upper;
                            opentextboxDatoActividad[iii].Required = Convert.ToChar(DTDatosActividad.Rows[i]["REQUERIDO"].ToString());
                            opentextboxDatoActividad[iii].Location = new System.Drawing.Point(300, nuY);

                            ultraTabPageControl3.Controls.Add(opentextboxDatoActividad[iii]);

                            nuControlDatoActividad = 1;

                            if (!String.IsNullOrEmpty(DTDatosActividad.Rows[i]["COMPONENTE"].ToString()))
                            {
                                if (Convert.ToInt64(DTDatosActividad.Rows[i]["COMPONENTE"].ToString()) == 2 || Convert.ToInt64(DTDatosActividad.Rows[i]["COMPONENTE"].ToString()) == 9)
                                {
                                    if (Convert.ToInt64(DTDatosActividad.Rows[i]["COMPONENTE"].ToString()) == 9 && DTDatosActividad.Rows[i]["NOMBRE"].ToString() == "READING")
                                    { 
                                        opentextboxDatoActividad[iii].Visible = false;
                                        opentextboxDatoActividad[iii].Required = Convert.ToChar("N");
                                    }
                                    //ii++;
                                    //iii = iii + ii;
                                    iii++;
                                    opentextboxDatoActividad[iii] = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
                                    opentextboxDatoActividad[iii].Name = "LECTURAS" + "_" + DTDatosActividad.Rows[i]["Ubicacion"].ToString();
                                    opentextboxDatoActividad[iii].Caption = "LECTURAS";
                                    opentextboxDatoActividad[iii].CharacterCasing = CharacterCasing.Upper;
                                    opentextboxDatoActividad[iii].Required = Convert.ToChar(DTDatosActividad.Rows[i]["REQUERIDO"].ToString());
                                    opentextboxDatoActividad[iii].Location = new System.Drawing.Point(800, nuY);
                                    ultraTabPageControl3.Controls.Add(opentextboxDatoActividad[iii]);
                                }
                            }
                            iii++;

                        }
                        if (nuY > 0)
                        {
                            nuYDatoActividad = nuY + 40;
                        }
                    }
                }
                else
                {
                    opentextboxDatoActividad = new OpenSystems.Windows.Controls.OpenSimpleTextBox[0];
                }

                nutotaldatoadicional = 0;


                nutotaldatoadicional = DALLEGO.FnuTotalDatosAdicionales(nuTipoTrabID, Convert.ToInt64(cbCausal.Value));
                opentextbox = new OpenSystems.Windows.Controls.OpenSimpleTextBox[nutotaldatoadicional];
                OpenCombobox = new OpenSystems.Windows.Controls.OpenCombo[nutotaldatoadicional];

                //Recorrer para crear objetos para informacion de datos adicionales
                DataTable Datos = DALLEGO.FrfDatosAdicionales(nuTipoTrabID, Convert.ToInt64(cbCausal.Value));
                Int64 nuattribute_set_id = 0;

                if (Datos.Rows.Count > 0)
                {
                    nuattribute_set_id = Convert.ToInt64(Datos.Rows[0].ItemArray[0].ToString());
                    Int64 nuColumna = 1;

                    if (nuYDatoActividad > 0)
                    {
                        nuY = nuYDatoActividad;
                    }

                    for (int i = 0; i <= Datos.Rows.Count - 1; i++)
                    {

                        nuControlDatoAdicional = 1;
                        if (nuattribute_set_id == Convert.ToInt64(Datos.Rows[i].ItemArray[0].ToString()))
                        {
                            if (nuColumna == 1)
                            {
                                nuColumna = 0;
                                nuY = nuY + 20;
                            }
                            else
                            {
                                nuColumna = 1;
                            }
                        }
                        else
                        {
                            nuattribute_set_id = Convert.ToInt64(Datos.Rows[i].ItemArray[0].ToString());
                            nuColumna = 0;
                            nuY = nuY + 40;
                        }

                        if (!String.IsNullOrEmpty(Datos.Rows[i].ItemArray[7].ToString()))
                        {
                            OpenCombobox[i] = new OpenSystems.Windows.Controls.OpenCombo();
                            OpenCombobox[i].Name = Datos.Rows[i].ItemArray[0].ToString() + "_" + Datos.Rows[i].ItemArray[2].ToString().ToUpper();
                            OpenCombobox[i].Caption = Datos.Rows[i].ItemArray[3].ToString().ToUpper();
                            OpenCombobox[i].Required = Convert.ToChar(Datos.Rows[i].ItemArray[8].ToString());

                            DataTable ListaOpenCombobox = general.getValueList(Datos.Rows[i].ItemArray[7].ToString());
                            DataTable tabla = new DataTable();
                            tabla.Columns.Add("CODIGO");
                            tabla.Columns.Add("DESCRIPCION");
                            for (int j = 0; j <= ListaOpenCombobox.Rows.Count - 1; j++)
                            {
                                DataRow row = tabla.NewRow();
                                row["CODIGO"] = ListaOpenCombobox.Rows[j][0].ToString();
                                row["DESCRIPCION"] = ListaOpenCombobox.Rows[j][1].ToString();
                                tabla.Rows.Add(row);

                            }

                            OpenCombobox[i].DataSource = tabla;//ListaOpenCombobox;
                            OpenCombobox[i].DisplayMember = "DESCRIPCION";
                            OpenCombobox[i].ValueMember = "CODIGO";
                            if (nuColumna == 0)
                            {
                                OpenCombobox[i].Location = new System.Drawing.Point(300, nuY);
                            }
                            else
                            {
                                OpenCombobox[i].Location = new System.Drawing.Point(800, nuY);
                            }
                            ultraTabPageControl3.Controls.Add(OpenCombobox[i]);
                        }
                        else
                        {
                            opentextbox[i] = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
                            opentextbox[i].Name = Datos.Rows[i].ItemArray[0].ToString() + "_" + Datos.Rows[i].ItemArray[2].ToString().ToUpper();
                            opentextbox[i].Caption = Datos.Rows[i].ItemArray[3].ToString().ToUpper();
                            opentextbox[i].CharacterCasing = CharacterCasing.Upper;
                            opentextbox[i].Required = Convert.ToChar(Datos.Rows[i].ItemArray[8].ToString());
                            if (nuColumna == 0)
                            {
                                opentextbox[i].Location = new System.Drawing.Point(300, nuY);
                            }
                            else
                            {
                                opentextbox[i].Location = new System.Drawing.Point(800, nuY);
                            }
                            ultraTabPageControl3.Controls.Add(opentextbox[i]);
                        }
                    }
                }

            }
        }

        public void PrGuardarDatos()
        {
            nuControlGuardado = 0;

            //Establece la busqueda de datos relacionada con la orden, indice de fila.
            string filtro; 
            string ordenar = "orden ASC";

            DataRow[] foundRows;

            //Validar clasificador de la causal de la OT a gestionar
            //1 - EXITO - Permitira validar los datos adcionales y componencetes de la actividad de la orden a gestionar
            //0 - FALLO
            //
            if (ClasificadorCausalOTGestion == 1)
            {
                //Validar datos obligatorios Adicionales y Dato Actividad
                //////Registrar Datos adicioanles a la orde en gestion
                for (int i = 0; i < nutotaldatoadicional; i++)
                {
                    try
                    {
                        if ((opentextbox[i].Required.ToString() == "Y") && (String.IsNullOrEmpty(opentextbox[i].TextBoxValue.ToString())))
                        {
                            MessageBox.Show("El Dato Adicional[" + opentextbox[i].Caption + "] es obligatorio");
                            nuControlGuardado = 1;
                        }
                    }
                    catch
                    {
                    }
                }

                for (int i = 0; i < nutotaldatoadicional; i++)
                {
                    try
                    {
                        if ((OpenCombobox[i].Required.ToString() == "Y") && (String.IsNullOrEmpty(OpenCombobox[i].Text.ToString())))
                        {
                            MessageBox.Show("El Dato Adicional[" + OpenCombobox[i].Caption + "] es obligatorio");
                            nuControlGuardado = 1;
                        }
                    }
                    catch
                    {
                    }
                }
                /////////////////////////////////////////////////////////////////

                ///////Datos Actividad orden a gestionar
                for (int ii = 0; ii < 12; ii++)
                {
                    try
                    {                       
                        if ((opentextboxDatoActividad[ii].Required.ToString() == "Y") && (String.IsNullOrEmpty(opentextboxDatoActividad[ii].TextBoxValue.ToString())))
                        {
                            MessageBox.Show("El Dato [" + opentextboxDatoActividad[ii].Caption + "] es obligatorio");
                            nuControlGuardado = 1;
                        }
                    }
                    catch
                    {
                    }
                }
            }

            if (tbOrden.Enabled == false && nuControlGuardado == 0)
            {
                Int64 nuValidarDatos = 0;

                //Validar datos necesarios de la OT a gestionar
                //Valida Causal
                if (String.IsNullOrEmpty(cbCausal.Text))
                {
                    MessageBox.Show("Debe seleccionar una causal.");
                    cbCausal.Focus();
                    nuControlGuardado = 1;
                }
                else
                {

                    //Valida Tecnico Legaliza
                    if (String.IsNullOrEmpty(oCbTecnicoLego.Text))
                    {
                        MessageBox.Show("Debe seleccionar una Tecnico Legaliza.");
                        oCbTecnicoLego.Focus();
                        nuControlGuardado = 1;
                    }
                    else
                    {

                        //Valida Observacion
                        if (String.IsNullOrEmpty(txtObservacion.Text))
                        {
                            MessageBox.Show("Debe colocar observacion.");

                            txtObservacion.Focus();
                            nuControlGuardado = 1;
                        }
                        else
                        {

                            //Valida Fechga inicio
                            if (String.IsNullOrEmpty(tbInicioEjecu.TextBoxValue))
                            {
                                MessageBox.Show("Debe seleccionar fecha inicio ejecucion.");

                                tbInicioEjecu.Focus();
                                nuControlGuardado = 1;
                            }
                            else
                            {

                                //Valida fecha fin ejecucion
                                if (String.IsNullOrEmpty(tbFinEjecu.TextBoxValue))
                                {
                                    MessageBox.Show("Debe seleccionar fecha final ejecucion.");

                                    tbFinEjecu.Focus();
                                    nuControlGuardado = 1;
                                }
                                else
                                {
                                    //inico ca 181
                                    if (Convert.ToDateTime(tbInicioEjecu.TextBoxValue).CompareTo(Convert.ToDateTime(tbFinEjecu.TextBoxValue)) > 0)
                                    {
                                        MessageBox.Show("La fecha inicial de ejecucion no puede ser mayor a la fecha final de ejecucion.");

                                        tbInicioEjecu.Focus();
                                        nuControlGuardado = 1;
                                    }
                                    else
                                    {

                                        //fin ca 181
                                        //registrar datos
                                        dtgTrabAdic.Focus();

                                        //validar dato
                                        foreach (TrabajoAdicional RfTrabajoAdicional in bsTrabAdic)
                                        {
                                            if (RfTrabajoAdicional.tipotrab == 0 || RfTrabajoAdicional.actividad == 0 || RfTrabajoAdicional.item == 0 || RfTrabajoAdicional.cantidad == 0 || RfTrabajoAdicional.causal == 0)
                                            {
                                                nuValidarDatos = 1;
                                            }
                                        }

                                        if (nuValidarDatos == 0 && nuControlDatoAdicionalOTAdicional == 0)
                                        {
                                            if (MessageBox.Show("Realmente deseas registrra estos datos?", "Confirmar Gestion de Orden",
                                         MessageBoxButtons.YesNo, MessageBoxIcon.Question)
                                         == DialogResult.Yes)
                                            {
                                                //Registrar la orden prinicpal
                                                BLLEGO.PrRegistoOrdenLegalizar(Convert.ToInt64(tbOrden.Text), Convert.ToInt64(cbCausal.Value), txtObservacion.Text, Convert.ToDateTime(tbInicioEjecu.TextBoxValue), Convert.ToDateTime(tbFinEjecu.TextBoxValue), Convert.ToInt64(oCbTecnicoLego.Value));

                                                int nuFilaOTAdicional = 0;

                                                //Ciclo para recorre la OT adciionales configuradas
                                                foreach (TrabajoAdicional RfTrabajoAdicional in bsTrabAdic)
                                                {
                                                    if (RfTrabajoAdicional.tipotrab != 0)
                                                    {
                                                        //Registra la configuracion de la OT Adicional
                                                        BLLEGO.PrRegistoOrdenAdicional(Convert.ToInt64(tbOrden.Text), RfTrabajoAdicional.tipotrab, RfTrabajoAdicional.actividad, RfTrabajoAdicional.item, RfTrabajoAdicional.cantidad.ToString(), RfTrabajoAdicional.causal);//, RfTrabajoAdicional.valormaterial.ToString());

                                                        //CASO 200-1528
                                                        //Valida si registra los datos adicionales y componente de la actividad relaionadas con la actividad 
                                                        //y la causal si esta es de EXITO (1) en caso que sea causal de FALLO no registra datos adicionales y componentes
                                                        Int64 NuClasificadorCausal = 0;
                                                        NuClasificadorCausal = DALLEGO.FnuClasificadorCausal(RfTrabajoAdicional.causal);
                                                        //////////////////

                                                        if (NuClasificadorCausal == 1)
                                                        {
                                                            filtro = "orden = " + Convert.ToInt64(tbOrden.Text) + " and tipotrab = " + RfTrabajoAdicional.tipotrab + " and causal = " + RfTrabajoAdicional.causal + " and actividad = " + RfTrabajoAdicional.actividad + " and material = " + RfTrabajoAdicional.item;
                                                            ordenar = "orden ASC";

                                                            //Usa el filtro sobre la tabal para seleccionar datos relacionados.
                                                            foundRows = DTDatoAdicionalOTAdicional.Select(filtro, ordenar);

                                                            if (foundRows.Length > 0)
                                                            {
                                                                for (int i = 0; i < foundRows.Length; i++)
                                                                {
                                                                    BLLEGO.PrRegistoDatoAdicionalOTA(Convert.ToInt64(foundRows[i][0].ToString()), foundRows[i][3].ToString(), foundRows[i][4].ToString(), Convert.ToInt64(foundRows[i][1].ToString()), Convert.ToInt64(foundRows[i][2].ToString()), Convert.ToInt64(foundRows[i][5].ToString()), Convert.ToInt64(foundRows[i][6].ToString()));
                                                                }
                                                            }
                                                            ////////////////////////////////////////////////////////////////////

                                                            nuFilaOTAdicional = nuFilaOTAdicional + 1;

                                                            //////////////////////////////////////////////////////////
                                                            ///////Datos Actividad orde a gestionar
                                                            DataTable DTDatosActividadAdicional = DALLEGO.FrfDatosActividad(RfTrabajoAdicional.actividad);
                                                            if (DTDatosActividadAdicional.Rows.Count > 0)
                                                            {
                                                                for (int iii = 0; iii <= DTDatosActividadAdicional.Rows.Count - 1; iii++)
                                                                {
                                                                    String SbNombreAtributo = string.Empty;
                                                                    String SbValorAtributo = string.Empty;
                                                                    String sbNombreComponente = string.Empty;
                                                                    String SbValorComponente = string.Empty;

                                                                    for (int ii = 0; ii < 12; ii++)
                                                                    {
                                                                        try
                                                                        {
                                                                            ////////Registrar Dato Actividad de OT adicionales
                                                                            filtro = "orden = " + Convert.ToInt64(tbOrden.Text) + " and actividad = " + RfTrabajoAdicional.actividad + " and material = " + RfTrabajoAdicional.item;
                                                                            ordenar = "orden ASC";

                                                                            //Usa el filtro sobre la tabal para seleccionar datos relacionados.
                                                                            foundRows = DTDatoActividadOTAdicional.Select(filtro, ordenar);

                                                                            if (foundRows.Length > 0)
                                                                            {
                                                                                for (int i = 0; i < foundRows.Length; i++)
                                                                                {
                                                                                    if (!String.IsNullOrEmpty(opentextboxDatoaActividadOTAdicional[ii].TextBoxValue.ToString()))
                                                                                    {

                                                                                        if (foundRows[i][3].ToString() == DTDatosActividadAdicional.Rows[iii]["NOMBRE"].ToString() + "_" + DTDatosActividadAdicional.Rows[iii]["Ubicacion"].ToString())
                                                                                        {
                                                                                            SbNombreAtributo = foundRows[i][3].ToString();
                                                                                            SbValorAtributo = foundRows[i][4].ToString();
                                                                                        }
                                                                                        if (foundRows[i][3].ToString() == "LECTURAS" + "_" + DTDatosActividadAdicional.Rows[iii]["Ubicacion"].ToString())
                                                                                        {
                                                                                            SbNombreAtributo = DTDatosActividadAdicional.Rows[iii]["NOMBRE"].ToString() + "_" + DTDatosActividadAdicional.Rows[iii]["Ubicacion"].ToString();
                                                                                            sbNombreComponente = foundRows[i][3].ToString();
                                                                                            SbValorComponente = foundRows[i][4].ToString();
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }                                                             
                                                                        }
                                                                        catch
                                                                        {
                                                                        }
                                                                    }

                                                                    if (!String.IsNullOrEmpty(SbNombreAtributo))
                                                                    {
                                                                        BLLEGO.PrRegistoActividadAdicional(Convert.ToInt64(tbOrden.Text), RfTrabajoAdicional.actividad, RfTrabajoAdicional.item, SbNombreAtributo, SbValorAtributo, sbNombreComponente, SbValorComponente);
                                                                    }
                                                                }
                                                            }
                                                        }//Fin validacion clasificador causal de OT Adicional
                                                    }
                                                }


                                                //Validar clasificador de la causal de la OT a gestionar
                                                //1 - EXITO - Permitira validar los datos adcionales y componencetes de la actividad de la orden a gestionar
                                                //0 - FALLO
                                                //
                                                if (ClasificadorCausalOTGestion == 1)
                                                {
                                                    //////Registrar Datos adicioanles a la orde en gestion
                                                    for (int i = 0; i < nutotaldatoadicional; i++)
                                                    {
                                                        try
                                                        {
                                                            if (!String.IsNullOrEmpty(opentextbox[i].TextBoxValue))
                                                            {
                                                                //Registra el dato adicional tipo TEXTO de la OT principal
                                                                BLLEGO.PrRegistoDatoAdicional(Convert.ToInt64(tbOrden.Text), opentextbox[i].Name, opentextbox[i].TextBoxValue, nuTipoTrabID, Convert.ToInt64(cbCausal.Value));
                                                            }
                                                        }
                                                        catch
                                                        {
                                                        }
                                                    }

                                                    for (int i = 0; i < nutotaldatoadicional; i++)
                                                    {
                                                        try
                                                        {
                                                            if (!String.IsNullOrEmpty(OpenCombobox[i].Value.ToString()))
                                                            {
                                                                //Registra el dato adicional tipo COMBO de la OT principal
                                                                BLLEGO.PrRegistoDatoAdicional(Convert.ToInt64(tbOrden.Text), OpenCombobox[i].Name, OpenCombobox[i].Value.ToString(), nuTipoTrabID, Convert.ToInt64(cbCausal.Value));
                                                            }
                                                        }
                                                        catch
                                                        {
                                                        }
                                                    }
                                                    /////////////////////////////////////////////////////////////////

                                                    ///////Datos Actividad orde a gestionar
                                                    DataTable DTDatosActividad1 = DALLEGO.FrfDatosActividad(nuActividad_orden);
                                                    if (DTDatosActividad1.Rows.Count > 0)
                                                    {
                                                        String SbNombreAtributo = string.Empty;
                                                        String SbValorAtributo = string.Empty;
                                                        String sbNombreComponente = string.Empty;
                                                        String SbValorComponente = string.Empty;



                                                        for (int i = 0; i <= DTDatosActividad1.Rows.Count - 1; i++)
                                                        {
                                                            SbNombreAtributo = string.Empty;
                                                            SbValorAtributo = string.Empty;
                                                            sbNombreComponente = string.Empty;
                                                            SbValorComponente = string.Empty;
                                                            for (int ii = 0; ii < 12; ii++)
                                                            {
                                                                try
                                                                {
                                                                    if (!String.IsNullOrEmpty(opentextboxDatoActividad[ii].TextBoxValue.ToString()))
                                                                    {

                                                                        if (opentextboxDatoActividad[ii].Name == DTDatosActividad1.Rows[i]["NOMBRE"].ToString() + "_" + DTDatosActividad1.Rows[i]["Ubicacion"].ToString())
                                                                        {
                                                                            SbNombreAtributo = opentextboxDatoActividad[ii].Name;
                                                                            SbValorAtributo = opentextboxDatoActividad[ii].TextBoxValue;
                                                                        }
                                                                        if (opentextboxDatoActividad[ii].Name == "LECTURAS" + "_" + DTDatosActividad1.Rows[i]["Ubicacion"].ToString())
                                                                        {
                                                                            SbNombreAtributo = DTDatosActividad1.Rows[i]["NOMBRE"].ToString() + "_" + DTDatosActividad1.Rows[i]["Ubicacion"].ToString();
                                                                            sbNombreComponente = opentextboxDatoActividad[ii].Name;
                                                                            SbValorComponente = opentextboxDatoActividad[ii].TextBoxValue;
                                                                        }
                                                                    }
                                                                }
                                                                catch
                                                                {
                                                                }
                                                            }

                                                            //Registra el compoennte de la OT principal
                                                            BLLEGO.PrRegistroDatoActividad(Convert.ToInt64(tbOrden.Text), SbNombreAtributo, SbValorAtributo, sbNombreComponente, SbValorComponente);
                                                        }
                                                    }
                                                    ////////////////////////////////////////////////////////////////////                                            
                                                    ////////////////////////////////////////////////////////////////////

                                                }//Fin de Dato adicionales y Componenetes de OT principal


                                                //Registrar Items de OT gestionada
                                                foreach (ItemOrdenGestion RfItemOrdenGestion in bsItemOrdenGestion)
                                                {
                                                    if (RfItemOrdenGestion.item != 0)
                                                    {
                                                        //Registra lso items configirados en la OT principal
                                                        BLLEGO.PrRegistoItemOrdenGestion(Convert.ToInt64(tbOrden.Text), Convert.ToInt64(RfItemOrdenGestion.item), RfItemOrdenGestion.cantidad.ToString());
                                                    }
                                                }

                                                MessageBox.Show("Datos Guardados de Manera Éxitosa");

                                                PrNuevoRegistro();

                                            }
                                            else
                                            {
                                                nuControlGuardado = 1;
                                            }
                                        }
                                        else
                                        {
                                            if (nuValidarDatos == 1)
                                            {
                                                MessageBox.Show("Los datos deben ser validos... Verfique la informacion digitada en trabajos adicionales.");
                                                nuControlGuardado = 1;
                                            }
                                            else
                                            {
                                                if (nuControlDatoAdicionalOTAdicional == 1)
                                                {
                                                    MessageBox.Show("Debe completar datos obligatorios de datos adicionales.");
                                                    nuControlGuardado = 1;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }


        private void ugItemOrdenGestion_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            //Codigo para inicializar la columna y definir un boton en lugar de celda para edicion en al grilla
            Infragistics.Win.UltraWinGrid.UltraGridLayout layout = e.Layout;
            Infragistics.Win.UltraWinGrid.UltraGridBand band = layout.Bands[0];
            Infragistics.Win.UltraWinGrid.UltraGridColumn buttonColumn = band.Columns.Add("Accion");
            buttonColumn.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
        }

        private void ugItemOrdenGestion_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            //Inicializar al etiqueta y valor del boton en al grilla
            if (e.ReInitialize == false)
            {
                e.Row.Cells["Accion"].Value = "Eliminar";
            }

        }

        private void ugItemOrdenGestion_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.F7)
            {
                if (ugItemOrdenGestion.Rows.Count == 0)
                {
                    //Agregar una nueva fila en la grilla
                    bsItemOrdenGestion.AddNew();
                    ActivarCeldaItem(1);
                }
                else
                {
                    if (ugItemOrdenGestion.Rows[bsItemOrdenGestion.Count - 1].Cells[0].Value.ToString() != "0")
                    {
                        bsItemOrdenGestion.AddNew();
                        ActivarCeldaItem(1);
                    }
                }
            }
        }

        private void ActivarCeldaItem(Int64 CeldaAcrivar)
        {
            if (CeldaAcrivar == 1)
            {
                UltraGridRow aUGRow = ugItemOrdenGestion.GetRow(ChildRow.First);
                for (int intPtr = 1; intPtr <= ugItemOrdenGestion.Rows.Count - 1; intPtr++)
                {
                    aUGRow = aUGRow.GetSibling(SiblingRow.Next);
                }
                ugItemOrdenGestion.ActiveRow = aUGRow;
                ugItemOrdenGestion.ActiveCell = aUGRow.Cells["item"];
                ugItemOrdenGestion.PerformAction(UltraGridAction.EnterEditMode, false, false);
            }
        }

        private void ugItemOrdenGestion_BeforeCellActivate(object sender, CancelableCellEventArgs e)
        {
            //CASO 200-2142 Se adiciono control de activacion de lista de valores para la columan de ITEM
            try
            {

                if (UCITEMS.Rows.Count <= 0)
                {
                    if (e.Cell.Column.Key == "item") 
                    {
                        if (nuUOACOfertados == 0)
                        {
                            QueryPpal = "SELECT CODIGO, DESCRIPCION, rownum INDICE FROM ( " + consultaItemNoOfertInd + " and TIPO_TRABAJO =" + nuTipoTrabID + " ORDER BY CODIGO_MATERIAL DESC)";

                            UCITEMS.DataSource = general.getValueListNumberId(QueryPpal, "CODIGO");
                            //
                            UCITEMS.ValueMember = "CODIGO";
                            UCITEMS.DisplayMember = "DESCRIPCION";

                            UCITEMS.DisplayLayout.ScrollStyle = ScrollStyle.Immediate;
                            UCITEMS.Rows.Band.ColHeadersVisible = false;

                            ugItemOrdenGestion.Rows[e.Cell.Row.VisibleIndex].Cells[0].ValueList = UCITEMS;
                        }
                        else
                        {
                            QueryPpal = "SELECT CODIGO, DESCRIPCION, rownum INDICE FROM ( " + consultaItemOfertInd + " WHERE TIPO_TRABAJO =" + nuTipoTrabID + " AND CODIGO_MATERIAL in (select LIUOL.ITEM from LDC_ITEM_UO_LR LIUOL where LIUOL.UNIDAD_OPERATIVA = " + nuUOOfertados + " AND LIUOL.ACTIVIDAD = " + nuActividad_orden + "  ) ORDER BY CODIGO_MATERIAL DESC)";

                            UCITEMS.DataSource = general.getValueListNumberId(QueryPpal, "CODIGO");
                            //
                            UCITEMS.ValueMember = "CODIGO";
                            UCITEMS.DisplayMember = "DESCRIPCION";

                            UCITEMS.DisplayLayout.ScrollStyle = ScrollStyle.Immediate;
                            UCITEMS.Rows.Band.ColHeadersVisible = false;

                            ugItemOrdenGestion.Rows[e.Cell.Row.VisibleIndex].Cells[0].ValueList = UCITEMS;
                        }
                    }
                }
                else
                {
                    UCITEMS.DisplayLayout.ScrollStyle = ScrollStyle.Immediate;
                    UCITEMS.Rows.Band.ColHeadersVisible = false;
                    ugItemOrdenGestion.Rows[e.Cell.Row.VisibleIndex].Cells[0].ValueList = UCITEMS;
                }
            }
            catch
            {
                if (e.Cell.Column.Key == "item") 
                {
                    if (nuUOACOfertados == 0)
                    {
                        QueryPpal = "SELECT CODIGO, DESCRIPCION, rownum INDICE FROM ( " + consultaItemNoOfertInd + " and TIPO_TRABAJO =" + nuTipoTrabID + "ORDER BY CODIGO_MATERIAL DESC)";

                        UCITEMS.DataSource = general.getValueListNumberId(QueryPpal, "CODIGO");
                        UCITEMS.ValueMember = "CODIGO";
                        UCITEMS.DisplayMember = "DESCRIPCION";

                        UCITEMS.DisplayLayout.ScrollStyle = ScrollStyle.Immediate;
                        UCITEMS.Rows.Band.ColHeadersVisible = false;

                        ugItemOrdenGestion.Rows[e.Cell.Row.VisibleIndex].Cells[0].ValueList = UCITEMS;
                    }
                    else
                    {
                        QueryPpal = "SELECT CODIGO, DESCRIPCION, rownum INDICE FROM ( " + consultaItemOfertInd + " WHERE TIPO_TRABAJO =" + nuTipoTrabID + " AND CODIGO_MATERIAL in (select LIUOL.ITEM from LDC_ITEM_UO_LR LIUOL where LIUOL.UNIDAD_OPERATIVA = " + nuUOOfertados + " AND LIUOL.ACTIVIDAD = " + nuActividad_orden + "  ) ORDER BY CODIGO_MATERIAL DESC)";

                        UCITEMS.DataSource = general.getValueListNumberId(QueryPpal, "CODIGO");

                        UCITEMS.ValueMember = "CODIGO";
                        UCITEMS.DisplayMember = "DESCRIPCION";

                        UCITEMS.DisplayLayout.ScrollStyle = ScrollStyle.Immediate;
                        UCITEMS.Rows.Band.ColHeadersVisible = false;

                        ugItemOrdenGestion.Rows[e.Cell.Row.VisibleIndex].Cells[0].ValueList = UCITEMS;
                    }
                }
            }
        }

        private void ugItemOrdenGestion_ClickCellButton(object sender, CellEventArgs e)
        {
            //AL utilizar le boton elimina la fila del boton utilizado.
            nutotaldatoadicionalOtAdicional = 0;
            ultraTabPageControl5.Controls.Clear();
            ugItemOrdenGestion.Rows[e.Cell.Row.VisibleIndex].Delete(false);
        }

        private void ugItemOrdenGestion_Error(object sender, ErrorEventArgs e)
        {
            if (e.ErrorType == ErrorType.Data)
            {
                ////Codigo para indicar el tipo de error generado
                ugItemOrdenGestion.ActiveCell.Value = 0;

                // Asigna a la propiedad canel el valor de TRUE para que al GRILLA no despliege un mensaje de error
                e.Cancel = true;
            }
        }

        private void ugItemOrdenGestion_AfterCellUpdate(object sender, CellEventArgs e)
        {
            if (e.Cell.Column.Key == "item" && Convert.ToInt64(ugItemOrdenGestion.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value) != 0)
            {
                Int64 nuItemTA = Convert.ToInt64(ugItemOrdenGestion.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value);
                ItemOrdenGestion articleSel;
                Int64 nuExisteItem = -1;

                for (int index = 0; index < bsItemOrdenGestion.Count; index++)
                {
                    articleSel = (ItemOrdenGestion)bsItemOrdenGestion[index];
                    if (nuItemTA == articleSel.item)
                    {
                        if (nuExisteItem == -1)
                        {
                            nuExisteItem = index;
                        }
                    }
                }

                if (nuExisteItem != e.Cell.Row.Index)
                {
                    MessageBox.Show("El item [" + nuItemTA + "] ya existe");
                    ugItemOrdenGestion.Rows[e.Cell.Row.VisibleIndex].Cells[0].Value = 0;
                    ugItemOrdenGestion.Focus();
                }
                else
                {
                    if (nuItemTA != 0)
                    {
                        Int64 ONUPRICELISTID;
                        Int64 ONUVALUE;
                        oDALLEGO.getlistitemvalue(nuItemTA, Convert.ToDateTime(tbFinEjecu.TextBoxValue), nuUOOfertados, 0, 0, nuubicacion_geografica, 1, out ONUPRICELISTID, out ONUVALUE);

                        ugItemOrdenGestion.Rows[e.Cell.Row.VisibleIndex].Cells[2].Value = ONUVALUE;
                    }
                }
            }

            if (e.Cell.Column.Key == "cantidad")
            {
                ugItemOrdenGestion.Rows[e.Cell.Row.VisibleIndex].Cells[3].Value = Convert.ToDouble(ugItemOrdenGestion.Rows[e.Cell.Row.VisibleIndex].Cells[1].Value) * Convert.ToDouble(ugItemOrdenGestion.Rows[e.Cell.Row.VisibleIndex].Cells[2].Value);
            }
        }

        private void TcDatoAdcionalOTGestion_KeyDown(object sender, KeyEventArgs e)
        {
            if (TcDatoAdcionalOTGestion.Tabs[1].Active == true)
            {
                if (e.KeyCode == Keys.F7)
                {
                    if (ugItemOrdenGestion.Rows.Count == 0)
                    {
                        //Agregar una nueva fila en la grilla
                        bsItemOrdenGestion.AddNew();
                        ActivarCeldaItem(1);
                    }
                    else
                    {
                        if (ugItemOrdenGestion.Rows[bsItemOrdenGestion.Count - 1].Cells[0].Value.ToString() != "0")
                        {
                            bsItemOrdenGestion.AddNew();
                            ActivarCeldaItem(1);
                        }
                    }
                }
            }
        }

        private void TcDatoAdcionalOTGestion_SelectedTabChanged(object sender, Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs e)
        {
            if (TcDatoAdcionalOTGestion.Tabs[1].Active == true)
            {
                //Valida Causal
                if (String.IsNullOrEmpty(cbCausal.Text))
                {
                    MessageBox.Show("Debe seleccionar una causal.");
                    cbCausal.Focus();
                }
                else
                {

                    //Valida Tecnico Legaliza
                    if (String.IsNullOrEmpty(oCbTecnicoLego.Text))
                    {
                        MessageBox.Show("Debe seleccionar una Tecnico Legaliza.");
                        oCbTecnicoLego.Focus();
                    }
                    else
                    {

                        //Valida Observacion
                        if (String.IsNullOrEmpty(txtObservacion.Text))
                        {
                            MessageBox.Show("Debe colocar observacion.");
                            txtObservacion.Focus();
                        }
                        else
                        {

                            //Valida Fechga inicio
                            if (String.IsNullOrEmpty(tbInicioEjecu.TextBoxValue))
                            {
                                MessageBox.Show("Debe seleccionar fecha inicio ejecucion.");
                                tbInicioEjecu.Focus();
                            }
                            else
                            {

                                //Valida fecha fin ejecucion
                                if (String.IsNullOrEmpty(tbFinEjecu.TextBoxValue))
                                {
                                    MessageBox.Show("Debe seleccionar fecha final ejecucion.");
                                    tbFinEjecu.Focus();
                                }
                            }
                        }
                    }
                }
            }
        }

        private void TcDatoAdcionalOTAdicional_Leave(object sender, EventArgs e)
        {
            if (bsTrabAdic.Count > 0)
            {
                //Establecer la fila seleccionada con los DATOS DE ACTIVIDAD y/o DATOS ADICIOANLES
                int FilaSeleccionada = Convert.ToInt16(dtgTrabAdic.ActiveRow.Index.ToString());

                DataRow[] DTAdicionalActividadOTAD = DTDatoAdicionalActividadOTAD.Select("orden = " + Convert.ToInt64(tbOrden.Text) + " and tipotrab = " + Convert.ToInt64(dtgTrabAdic.Rows[dtgTrabAdic.ActiveCell.Row.Index].Cells[0].Value) + " and causal = " + Convert.ToInt64(dtgTrabAdic.Rows[dtgTrabAdic.ActiveCell.Row.Index].Cells[1].Value) + " and actividad = " + Convert.ToInt64(dtgTrabAdic.Rows[dtgTrabAdic.ActiveCell.Row.Index].Cells[2].Value) + "");
                if (DTAdicionalActividadOTAD.Length == 0)
                {
                    DataRow NuevaFilaAAOTAD = DTDatoAdicionalActividadOTAD.NewRow();
                    NuevaFilaAAOTAD["orden"] = Convert.ToInt64(tbOrden.Text);
                    NuevaFilaAAOTAD["tipotrab"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[0].Value);
                    NuevaFilaAAOTAD["causal"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[1].Value);
                    NuevaFilaAAOTAD["actividad"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[2].Value);
                    NuevaFilaAAOTAD["material"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[3].Value);

                    // Agregar una nueva fila a la tabla de memoria.
                    DTDatoAdicionalActividadOTAD.Rows.Add(NuevaFilaAAOTAD);
                }


                nuControlDatoAdicionalOTAdicional = 0;

                //Inicio CASO 200-1528
                //Registrar nuevamente dato actividad de la orden adicional
                DataRow[] dtrDatoActividad = DTDatoActividadOTAdicional.Select("orden = " + Convert.ToInt64(tbOrden.Text) + " and actividad = " + Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[2].Value) + " and material = " + Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[3].Value));
                foreach (var drow in dtrDatoActividad)
                {                    
                    drow.Delete();
                }
                DTDatoActividadOTAdicional.AcceptChanges();

                //////Registrar Datos adicioanles a la orde en gestion
                for (int i = 0; i < 12; i++)
                {
                    try
                    {
                        if (!String.IsNullOrEmpty(opentextboxDatoaActividadOTAdicional[i].Name))
                        {
                            DataRow NuevaFila = DTDatoActividadOTAdicional.NewRow();
                            NuevaFila["orden"] = Convert.ToInt64(tbOrden.Text);
                            NuevaFila["actividad"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[2].Value);
                            NuevaFila["material"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[3].Value);
                            NuevaFila["atributo"] = opentextboxDatoaActividadOTAdicional[i].Name;
                            NuevaFila["valoratributo"] = opentextboxDatoaActividadOTAdicional[i].TextBoxValue;

                            // Agregar una nueva fila a la tabla de memoria.
                            DTDatoActividadOTAdicional.Rows.Add(NuevaFila);

                        }
                        else
                        {
                            if (opentextboxDatoaActividadOTAdicional[i].Required == 'Y')
                            {
                                MessageBox.Show("Debe llenar dato obligatorio[" + opentextboxDatoaActividadOTAdicional[i].Caption + "]");
                                nuControlDatoActividadOTAdicional = 1;
                                opentextboxDatoaActividadOTAdicional[i].Focus();
                            }
                        }
                    }
                    catch
                    {
                    }
                }

                DataRow[] dtr = DTDatoAdicionalOTAdicional.Select("orden = " + Convert.ToInt64(tbOrden.Text) + " and tipotrab = " + Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[0].Value) + " and causal = " + Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[1].Value) + " and actividad = " + Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[2].Value) + " and material = " + Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[3].Value));
                foreach (var drow in dtr)
                {
                    drow.Delete();
                }
                DTDatoAdicionalOTAdicional.AcceptChanges();

                //////Registrar Datos adicioanles a la orde en gestion
                for (int i = 0; i < nutotaldatoadicionalOtAdicional; i++)
                {
                    try
                    {
                        if (!String.IsNullOrEmpty(opentextboxDatoAdicional[i].TextBoxValue))
                        {
                            DataRow NuevaFila = DTDatoAdicionalOTAdicional.NewRow();
                            NuevaFila["orden"] = Convert.ToInt64(tbOrden.Text);
                            NuevaFila["tipotrab"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[0].Value);
                            NuevaFila["causal"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[1].Value);
                            NuevaFila["codigodatoadicional"] = opentextboxDatoAdicional[i].Name;
                            NuevaFila["valordatoadicional"] = opentextboxDatoAdicional[i].TextBoxValue;
                            NuevaFila["actividad"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[2].Value);
                            NuevaFila["material"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[3].Value);

                            // Agregar una nueva fila a la tabla de memoria.
                            DTDatoAdicionalOTAdicional.Rows.Add(NuevaFila);

                        }
                        else
                        {
                            if (opentextboxDatoAdicional[i].Required == 'Y')
                            {
                                MessageBox.Show("Debe llenar dato obligatorio[" + opentextboxDatoAdicional[i].Caption + "]");
                                nuControlDatoAdicionalOTAdicional = 1;
                                opentextboxDatoAdicional[i].Focus();
                            }
                        }
                    }
                    catch
                    {
                    }
                }

                for (int i = 0; i < nutotaldatoadicionalOtAdicional; i++)
                {
                    try
                    {
                        if (!String.IsNullOrEmpty(OpenComboboxDatoAdicional[i].Value.ToString()))
                        {
                            DataRow NuevaFila = DTDatoAdicionalOTAdicional.NewRow();
                            NuevaFila["orden"] = Convert.ToInt64(tbOrden.Text);
                            NuevaFila["tipotrab"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[0].Value);
                            NuevaFila["causal"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[1].Value); ;
                            NuevaFila["codigodatoadicional"] = OpenComboboxDatoAdicional[i].Name;
                            NuevaFila["valordatoadicional"] = OpenComboboxDatoAdicional[i].Value;
                            NuevaFila["actividad"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[2].Value);
                            NuevaFila["material"] = Convert.ToInt64(dtgTrabAdic.Rows[FilaSeleccionada].Cells[3].Value);

                            // Agregar una nueva fila a la tabla de memoria.
                            DTDatoAdicionalOTAdicional.Rows.Add(NuevaFila);
                        }
                        else
                        {
                            if (OpenComboboxDatoAdicional[i].Required == 'Y')
                            {
                                MessageBox.Show("Debe llenar dato obligatorio[" + OpenComboboxDatoAdicional[i].Caption + "]");
                                nuControlDatoAdicionalOTAdicional = 1;
                                OpenComboboxDatoAdicional[i].Focus();
                            }
                        }
                    }
                    catch
                    {
                    }
                }
            }
        }
        

        private void dtgTrabAdic_BeforeRowActivate(object sender, RowEventArgs e)
        {
            try
            {
                GraficoDatoAdicional(Convert.ToInt64(tbOrden.Text), e.Row.Index, Convert.ToInt64(dtgTrabAdic.Rows[e.Row.Index].Cells[0].Value), Convert.ToInt64(dtgTrabAdic.Rows[e.Row.Index].Cells[1].Value), "0", "0", Convert.ToInt64(dtgTrabAdic.Rows[e.Row.Index].Cells[2].Value), Convert.ToInt64(dtgTrabAdic.Rows[e.Row.Index].Cells[3].Value));
            }
            catch
            {
            }
        }

        private void tbInicioEjecu_Leave(object sender, EventArgs e)
        {
            if (Convert.ToDateTime(tbInicioEjecu.TextBoxValue).Date > DateTime.Today)
            {
                MessageBox.Show("La fechal inicial de ejecucion no puede ser mayor a la fecha final del sistema.");
                tbInicioEjecu.TextBoxObjectValue = OpenSystems.Common.Util.OpenDate.getSysDateOfDataBase();
                tbInicioEjecu.Focus();
            }
        }

        private void BtnGuardar_Click(object sender, EventArgs e)
        {
            PrGuardarDatos();
        }

        private void PrNuevoRegistro()
        {
            ulbDepa.Text = "";
            ulbLoca.Text = "";
            ulbTipoTrab.Text = "";
            ulbFechAsig.Text = "";
            ulbFechCrea.Text = "";
            ulbFechProg.Text = "";
            ulbDireccion.Text = "";
            ulbUnidadTrabajo.Text = "";
            ulbProducto.Text = "";
            ulbSolicitud.Text = "";
            ulbCiclo.Text = "";
            ulbContrato.Text = "";

            tbOrden.Text = "";
            cbCausal.Value = "";
            oCbTecnicoLego.Value = "";
            txtObservacion.Text = "";
            tbInicioEjecu.TextBoxValue = "";
            tbFinEjecu.TextBoxValue = "";
            bsTrabAdic.Clear();
            bsItemOrdenGestion.Clear();

            //Inicio CASO 200-1528
            tbInicioEjecu.Visible = true;
            ulInicioEjecucion.Visible = false;
            ulFechaInicioEjecicion.Visible = false;
            ulFechaInicioEjecicion.Text = "";

            tbFinEjecu.Visible = true;
            ulFinEjecucion.Visible = false;
            ulFechaFinEjecucion.Visible = false;
            ulFechaFinEjecucion.Text = "";

            ulbMedidor.Text = "";
            ulbMarca.Text = "";
            //Fin CASO 200-1528

            //desactivar las pestañas
            tcPpal.Tabs[0].Enabled = false;
            tcPpal.Tabs[1].Enabled = false;

            nutotaldatoadicional = 0;
            ultraTabPageControl3.Controls.Clear();

            BtnGuardar.Enabled = false;
            BtnNuevo.Enabled = false;

            tbOrden.Enabled = true;
            tbOrden.Focus();
        }

        private void BtnNuevo_Click(object sender, EventArgs e)
        {
            PrNuevoRegistro();
        }

        private void ugItemOrdenGestion_KeyUp(object sender, KeyEventArgs e)
        {
            if (ugItemOrdenGestion.ActiveCell.Column.Index == 0)
            {
                if ((e.KeyValue >= 96 && e.KeyValue <= 105) || (e.KeyValue >= 65 && e.KeyValue <= 90) || (e.KeyValue >= 48 && e.KeyValue <= 57) || (e.KeyCode == Keys.Back))
                {
                    UltraGridCell cell = ugItemOrdenGestion.ActiveCell;
                    String texto = cell.Text;

                    UCITEMS.DisplayLayout.Bands[0].ColumnFilters.ClearAllFilters();
                    UCITEMS.DisplayLayout.Bands[0].ColumnFilters[1].FilterConditions.Add(Infragistics.Win.UltraWinGrid.FilterComparisionOperator.Like, "*" + texto + "*");

                    cell.DroppedDown = true;
                    cell.SelStart = cell.Text.Length;
                }
                else
                {
                    if (e.KeyCode == Keys.Enter)
                    {
                        SendKeys.Send("{TAB}");
                        ugItemOrdenGestion.Rows[ugItemOrdenGestion.ActiveCell.Row.VisibleIndex].Cells[1].Value = 0;
                        ugItemOrdenGestion.Rows[ugItemOrdenGestion.ActiveCell.Row.VisibleIndex].Cells[2].Value = 0;
                        ugItemOrdenGestion.Rows[ugItemOrdenGestion.ActiveCell.Row.VisibleIndex].Cells[3].Value = 0;
                    }
                }
            }
        }

        private void dtgTrabAdic_KeyUp(object sender, KeyEventArgs e)
        {
            if ((e.KeyValue >= 96 && e.KeyValue <= 105) || (e.KeyValue >= 65 && e.KeyValue <= 90) || (e.KeyValue >= 48 && e.KeyValue <= 57) || (e.KeyCode == Keys.Back))
            {
                if (dtgTrabAdic.ActiveCell.Column.Index == 0)
                {
                    UltraGridCell cell = dtgTrabAdic.ActiveCell;
                    String texto = cell.Text;
                    String SBSQL;

                    SBSQL = "SELECT -1 CODIGO, '" + cell.Text + "' DESCRIPCION from dual UNION select ott.task_type_id CODIGO,  ' ' || ott.description DESCRIPCION from or_task_type ott where ott.task_type_id in (select LDC_TTA.TIPOTRABADICLEGO_ID from LDC_TIPOTRABADICLEGO LDC_TTA where LDC_TTA.TIPOTRABLEGO_ID = " + nuTipoTrabID + ")  and ott.task_type_id || upper(ott.description) like TRIM(UPPER('%" + cell.Text + "%')) order by 1 desc";

                    cell.ValueList = general.valuelistNumberId(SBSQL, "DESCRIPCION", "CODIGO");
                    cell.DroppedDown = true;
                    dtgTrabAdic.ActiveCell.Value = -1;
                    cell.SelStart = cell.Text.Length;
                    //Columan Causal
                    //Columna actividad
                    //Columna material
                }
                else if (dtgTrabAdic.ActiveCell.Column.Index == 1)
                {
                    UltraGridCell cell = dtgTrabAdic.ActiveCell;
                    String texto = cell.Text;
                    String SBSQL;

                    SBSQL = "SELECT -1 CODIGO, '" + cell.Text + "' DESCRIPCION from dual UNION select gc.causal_id CODIGO, ' ' || gc.description DESCRIPCION from ge_causal gc where gc.causal_id in (select ottc.causal_id from or_task_type_causal ottc where ottc.task_type_id = " + dtgTrabAdic.Rows[dtgTrabAdic.ActiveCell.Row.VisibleIndex].Cells[0].Value + ") and gc.causal_id || upper(gc.description) like TRIM(UPPER('%" + cell.Text + "%')) order by 1 desc";

                    cell.ValueList = general.valuelistNumberId(SBSQL, "DESCRIPCION", "CODIGO");
                    cell.DroppedDown = true;
                    dtgTrabAdic.ActiveCell.Value = -1;
                    cell.SelStart = cell.Text.Length;
                    //Columan Causal
                    //Columna actividad
                    //Columna material
                }
                else if (dtgTrabAdic.ActiveCell.Column.Index == 3)
                {
                    UltraGridCell cell = dtgTrabAdic.ActiveCell;
                    String texto = cell.Text;
                    String SBSQL;

                    if (nuUOACOfertados == 0)
                    {
                        SBSQL =  "SELECT -1 CODIGO, '" + cell.Text + "' DESCRIPCION from dual UNION "+consultaItemNoOfert + " AND TIPO_TRABAJO =" + dtgTrabAdic.Rows[dtgTrabAdic.ActiveCell.Row.VisibleIndex].Cells[0].Value +  " and CODIGO_MATERIAL || upper(DESCRIPCION_MATERIAL) like TRIM(UPPER('%" + cell.Text + "%')) order by 1 desc";
                    }
                    else
                    {
                        SBSQL = "SELECT -1 CODIGO, '" + cell.Text + "' DESCRIPCION from dual UNION "+consultaItemOfert + " WHERE TIPO_TRABAJO = " + dtgTrabAdic.Rows[dtgTrabAdic.ActiveCell.Row.VisibleIndex].Cells[0].Value + " AND CODIGO_MATERIAL in (select LIUOL.ITEM from LDC_ITEM_UO_LR LIUOL where LIUOL.UNIDAD_OPERATIVA = " + nuUOOfertados + " AND LIUOL.ACTIVIDAD = " + dtgTrabAdic.Rows[dtgTrabAdic.ActiveCell.Row.VisibleIndex].Cells[2].Value + ") and  CODIGO_MATERIAL || upper(DESCRIPCION_MATERIAL) like TRIM(UPPER('%" + cell.Text + "%')) order by 1 desc";    
                    }

                    cell.ValueList = general.valuelistNumberId(SBSQL, "DESCRIPCION", "CODIGO");
                    cell.DroppedDown = true;
                    dtgTrabAdic.ActiveCell.Value = -1;
                    cell.SelStart = cell.Text.Length;
                }

            }
            else
            {
                if (e.KeyCode == Keys.Enter)
                {

                    if (dtgTrabAdic.ActiveCell.Column.Index == 1 || dtgTrabAdic.ActiveCell.Column.Index == 2)
                    {
                        //CASO 200-1528
                        Int64 NuClasificadorCausal = 0;
                        NuClasificadorCausal = DALLEGO.FnuClasificadorCausal(Convert.ToInt64(dtgTrabAdic.Rows[dtgTrabAdic.ActiveRow.Index].Cells[1].Value));

                        if (NuClasificadorCausal == 0)
                        {
                            ultraTabPageControl5.Controls.Clear();
                        }
                    }
                    SendKeys.Send("{TAB}");
                }
                else if (e.KeyCode == Keys.Tab)
                {

                    if (dtgTrabAdic.ActiveCell.Column.Index == 1 || dtgTrabAdic.ActiveCell.Column.Index == 2)
                    {
                        //CASO 200-1528
                        Int64 NuClasificadorCausal = 0;
                        NuClasificadorCausal = DALLEGO.FnuClasificadorCausal(Convert.ToInt64(dtgTrabAdic.Rows[dtgTrabAdic.ActiveRow.Index].Cells[1].Value));

                        if (NuClasificadorCausal == 0)
                        {
                            ultraTabPageControl5.Controls.Clear();
                        }
                    }
                }
            }
        }

        private void GraficoDatoAdicional(Int64 Orden, Int64 Index, Int64 TipoTrab, Int64 Causal, String NombreDatoAdcional, String ValorDatoAdicional, Int64 Actividad, Int64 Material)
        {
            nuFocoObjetoDinamico = 0;
            nuGrupoObjetoDinamico = 0;

            ultraTabPageControl5.Controls.Clear();

            Int64 NuClasificadorCausal = 0;
            NuClasificadorCausal = DALLEGO.FnuClasificadorCausal(Causal);
            
            if (NuClasificadorCausal == 1)
            {

                Int64 nuGrafico = 0;
                DataRow[] DTAdicionalActividadOTAD = DTDatoAdicionalActividadOTAD.Select("orden = " + Convert.ToInt64(tbOrden.Text) + " and tipotrab = " + TipoTrab + " and causal = " + Causal + " and actividad = " + Actividad + "");
                if (DTAdicionalActividadOTAD.Length > 0)
                {
                    DataRow[] DTAdicionalActividadOTADExiste = DTDatoAdicionalActividadOTAD.Select("orden = " + Convert.ToInt64(tbOrden.Text) + " and tipotrab = " + TipoTrab + " and causal = " + Causal + " and actividad = " + Actividad + " and material = " + Material + "");
                    if (DTAdicionalActividadOTADExiste.Length > 0)
                    {
                        nuGrafico = 0;
                    }
                    else
                    {
                        nuGrafico = -1;
                    }
                }

                if (nuGrafico == 0)
                {

                    //Inicio CASO 200-1528
                    /////////////////////////////////////////////////////
                    //Datos actividad de la orden a gestionar
                    int nuY = 10;
                    opentextboxDatoaActividadOTAdicional = new OpenSystems.Windows.Controls.OpenSimpleTextBox[12];
                    DataTable DTDatosActividad = DALLEGO.FrfDatosActividad(Actividad);
                    if (DTDatosActividad.Rows.Count > 0)
                    {
                        int ii = 0;
                        int iii = 0;

                        for (int i = 0; i <= DTDatosActividad.Rows.Count - 1; i++)
                        {
                            nuY = nuY + 20;

                            //iii = i + ii;

                            opentextboxDatoaActividadOTAdicional[iii] = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
                            opentextboxDatoaActividadOTAdicional[iii].Name = DTDatosActividad.Rows[i]["NOMBRE"].ToString() + "_" + DTDatosActividad.Rows[i]["Ubicacion"].ToString();
                            opentextboxDatoaActividadOTAdicional[iii].Caption = DTDatosActividad.Rows[i]["NOMBRE_DESPLIEGUE"].ToString().ToUpper();
                            opentextboxDatoaActividadOTAdicional[iii].CharacterCasing = CharacterCasing.Upper;
                            opentextboxDatoaActividadOTAdicional[iii].Required = Convert.ToChar(DTDatosActividad.Rows[i]["REQUERIDO"].ToString());
                            opentextboxDatoaActividadOTAdicional[iii].Location = new System.Drawing.Point(300, nuY);

                            DataRow[] DTBuscarDatoTextoAtributo = DTDatoActividadOTAdicional.Select("orden = " + Convert.ToInt64(tbOrden.Text) + " and actividad = " + Actividad + "and material = " + Material + " and atributo = '" + opentextboxDatoaActividadOTAdicional[iii].Name + "'");
                            if (DTBuscarDatoTextoAtributo.Length > 0)
                            {
                                opentextboxDatoaActividadOTAdicional[iii].TextBoxValue = DTBuscarDatoTextoAtributo[0][4].ToString();
                            }

                            ultraTabPageControl5.Controls.Add(opentextboxDatoaActividadOTAdicional[iii]);

                            nuControlDatoActividad = 1;

                            if (!String.IsNullOrEmpty(DTDatosActividad.Rows[i]["COMPONENTE"].ToString()))
                            {
                                if (Convert.ToInt64(DTDatosActividad.Rows[i]["COMPONENTE"].ToString()) == 2 || Convert.ToInt64(DTDatosActividad.Rows[i]["COMPONENTE"].ToString()) == 9)
                                {
                                    if (Convert.ToInt64(DTDatosActividad.Rows[i]["COMPONENTE"].ToString()) == 9 && DTDatosActividad.Rows[i]["NOMBRE"].ToString() == "READING")
                                    {
                                        opentextboxDatoaActividadOTAdicional[iii].Visible = false;
                                        opentextboxDatoaActividadOTAdicional[iii].Required = Convert.ToChar("N");
                                    }
                                    //ii++;
                                    //iii = iii + ii;
                                    iii++;
                                    opentextboxDatoaActividadOTAdicional[iii] = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
                                    opentextboxDatoaActividadOTAdicional[iii].Name = "LECTURAS" + "_" + DTDatosActividad.Rows[i]["Ubicacion"].ToString();
                                    opentextboxDatoaActividadOTAdicional[iii].Caption = "LECTURAS";
                                    opentextboxDatoaActividadOTAdicional[iii].CharacterCasing = CharacterCasing.Upper;
                                    opentextboxDatoaActividadOTAdicional[iii].Required = Convert.ToChar(DTDatosActividad.Rows[i]["REQUERIDO"].ToString());
                                    opentextboxDatoaActividadOTAdicional[iii].Location = new System.Drawing.Point(800, nuY);

                                    DataRow[] DTBuscarDatoTextoComponente = DTDatoActividadOTAdicional.Select("orden = " + Convert.ToInt64(tbOrden.Text) + " and actividad = " + Actividad + "and material = " + Material + " and atributo = '" + opentextboxDatoaActividadOTAdicional[iii].Name + "'");
                                    if (DTBuscarDatoTextoComponente.Length > 0)
                                    {
                                        opentextboxDatoaActividadOTAdicional[iii].TextBoxValue = DTBuscarDatoTextoComponente[0][4].ToString();
                                    }

                                    ultraTabPageControl5.Controls.Add(opentextboxDatoaActividadOTAdicional[iii]);
                                }
                            }
                            iii++;

                        }
                        if (nuY > 0)
                        {
                            nuYDatoActividadOTAdicional = nuY + 40;
                        }
                    }

                    nutotaldatoadicionalOtAdicional = DALLEGO.FnuTotalDatosAdicionales(TipoTrab , Causal);

                    opentextboxDatoAdicional = new OpenSystems.Windows.Controls.OpenSimpleTextBox[nutotaldatoadicionalOtAdicional];
                    OpenComboboxDatoAdicional = new OpenSystems.Windows.Controls.OpenCombo[nutotaldatoadicionalOtAdicional];

                    //Recorrer para crear objetos para informacion de datos adicionales
                    DataTable Datos = DALLEGO.FrfDatosAdicionales(TipoTrab, Causal);
                    Int64 nuattribute_set_id = 0;

                    if (Datos.Rows.Count > 0)
                    {
                        nuattribute_set_id = Convert.ToInt64(Datos.Rows[0].ItemArray[0].ToString());
                        Int64 nuColumna = 1;
                        //int nuY = 10;

                        if (nuYDatoActividadOTAdicional > 0)
                        {
                            nuY = nuYDatoActividadOTAdicional;
                        }

                        for (int i = 0; i <= Datos.Rows.Count - 1; i++)
                        {

                            if (nuattribute_set_id == Convert.ToInt64(Datos.Rows[i].ItemArray[0].ToString()))
                            {
                                if (nuColumna == 1)
                                {
                                    nuColumna = 0;
                                    nuY = nuY + 20;
                                }
                                else
                                {
                                    nuColumna = 1;
                                }
                            }
                            else
                            {
                                nuattribute_set_id = Convert.ToInt64(Datos.Rows[i].ItemArray[0].ToString());
                                nuColumna = 0;
                                nuY = nuY + 40;
                            }

                            if (!String.IsNullOrEmpty(Datos.Rows[i].ItemArray[7].ToString()))
                            {
                                OpenComboboxDatoAdicional[i] = new OpenSystems.Windows.Controls.OpenCombo();
                                OpenComboboxDatoAdicional[i].Name = Datos.Rows[i].ItemArray[0].ToString() + "_" + Datos.Rows[i].ItemArray[2].ToString().ToUpper();
                                OpenComboboxDatoAdicional[i].Caption = Datos.Rows[i].ItemArray[3].ToString().ToUpper();
                                OpenComboboxDatoAdicional[i].Required = Convert.ToChar(Datos.Rows[i].ItemArray[8].ToString());

                                DataTable ListaOpenCombobox = general.getValueList(Datos.Rows[i].ItemArray[7].ToString());
                                DataTable tabla = new DataTable();
                                tabla.Columns.Add("CODIGO");
                                tabla.Columns.Add("DESCRIPCION");
                                for (int j = 0; j <= ListaOpenCombobox.Rows.Count - 1; j++)
                                {
                                    DataRow row = tabla.NewRow();
                                    row["CODIGO"] = ListaOpenCombobox.Rows[j][0].ToString();
                                    row["DESCRIPCION"] = ListaOpenCombobox.Rows[j][1].ToString();
                                    tabla.Rows.Add(row);

                                }

                                OpenComboboxDatoAdicional[i].DataSource = tabla;//ListaOpenCombobox;
                                OpenComboboxDatoAdicional[i].DisplayMember = "DESCRIPCION";
                                OpenComboboxDatoAdicional[i].ValueMember = "CODIGO";

                                ////Buscar dato para dato adicional
                                DataRow[] DTBuscarDatoCombo = DTDatoAdicionalOTAdicional.Select("orden = " + Convert.ToInt64(tbOrden.Text) + " and tipotrab = " + TipoTrab + " and causal = " + Causal + " and codigodatoadicional = '" + OpenComboboxDatoAdicional[i].Name + "' and actividad = " + Actividad + " and material = " + Material);
                                if (DTBuscarDatoCombo.Length > 0)
                                {
                                    OpenComboboxDatoAdicional[i].Value = DTBuscarDatoCombo[0][4];
                                }

                                if (nuColumna == 0)
                                {
                                    OpenComboboxDatoAdicional[i].Location = new System.Drawing.Point(300, nuY);
                                }
                                else
                                {
                                    OpenComboboxDatoAdicional[i].Location = new System.Drawing.Point(800, nuY);
                                }
                                ultraTabPageControl5.Controls.Add(OpenComboboxDatoAdicional[i]);
                            }
                            else
                            {
                                opentextboxDatoAdicional[i] = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
                                opentextboxDatoAdicional[i].Name = Datos.Rows[i].ItemArray[0].ToString() + "_" + Datos.Rows[i].ItemArray[2].ToString().ToUpper();
                                opentextboxDatoAdicional[i].Caption = Datos.Rows[i].ItemArray[3].ToString().ToUpper();
                                opentextboxDatoAdicional[i].CharacterCasing = CharacterCasing.Upper;
                                opentextboxDatoAdicional[i].Required = Convert.ToChar(Datos.Rows[i].ItemArray[8].ToString());

                                ////Buscar dato para dato adicional
                                DataRow[] DTBuscarDatoTexto = DTDatoAdicionalOTAdicional.Select("orden = " + Convert.ToInt64(tbOrden.Text) + " and tipotrab = " + TipoTrab + " and causal = " + Causal + " and codigodatoadicional = '" + opentextboxDatoAdicional[i].Name + "' and actividad = " + Actividad + " and material = " + Material);
                                if (DTBuscarDatoTexto.Length > 0)
                                {
                                    opentextboxDatoAdicional[i].TextBoxValue = DTBuscarDatoTexto[0][4].ToString();
                                }      

                                if (nuColumna == 0)
                                {
                                    opentextboxDatoAdicional[i].Location = new System.Drawing.Point(300, nuY);
                                }
                                else
                                {
                                    opentextboxDatoAdicional[i].Location = new System.Drawing.Point(800, nuY);
                                }
                                ultraTabPageControl5.Controls.Add(opentextboxDatoAdicional[i]);
                            }
                        }
                    }
                    ultraTabPageControl5.Focus();
                }                
            }         
        }

        private void ultraTabPageControl5_Leave(object sender, EventArgs e)
        {
        }

        #region Caso 200-1580
        //Caso 200-1580
        //Daniel Valiente
        //Ordenes Garantias LEGO Cotizacion

        void llenar(Int64 orden, Int64 InuTaskType)
        {
            itemWarrantyBindingSource.Clear();

            
            DataTable Datos = BLLEGO.RFRFORDENESGARANTIA(orden, InuTaskType, Convert.ToDateTime(tbFinEjecu.TextBoxValue));//caso:146;
            if (Datos.Rows.Count > 0)
            {
                for (int i = 0; i <= Datos.Rows.Count - 1; i++)
                {
                    Entities.ItemWarranty DataDatos = new Entities.ItemWarranty
                    {
                        ItemsLegalizados = Datos.Rows[i].ItemArray[10].ToString(),
                        OrdenTrabajo = Datos.Rows[i].ItemArray[5].ToString(),
                        FechaLegalizacion = Datos.Rows[i].ItemArray[11].ToString(),
                        FechaVigenciaGarantia = Datos.Rows[i].ItemArray[6].ToString(),
                        ObservacionOrden = Datos.Rows[i].ItemArray[12].ToString(),
                        UnidadOperativa = Datos.Rows[i].ItemArray[13].ToString()
                    };
                    itemWarrantyBindingSource.Add(DataDatos);
                }
            }
        }

        #endregion
        
        private void ugItemOrdenGestion_KeyPress(object sender, KeyPressEventArgs e)
        {
            //VALIDO QUE SE HALLA PRESIONADO EL TABULADOR
            if (e.KeyChar == '\t')
            {
                //OBTENGO LA CELDA ACTIVA DE LA GRILLA
                UltraGridCell cell = ugItemOrdenGestion.ActiveCell;
                if (cell.Column.Header.Caption == "Item")
                {
                    String texto = cell.Text;
                    //CONSULTO LOS ITEM NUEVAMENTE PERO CON LA CONDICION DEL TEXTO
                    DataTable datosResp = general.getValueList("select tabla1.* from (" + QueryPpal + ") tabla1 WHERE DESCRIPCION like '%" + texto + "%'");
                    //SOLO ME QUEDO CON LA RESPUESTA CUANDO SOLO HAY UNA
                    if (datosResp.Rows.Count == 1)
                    {
                        //TOMO EL INDICE DE LA ULTIMA COLUMNA
                        int numeroFila = int.Parse(datosResp.Rows[0].ItemArray[2].ToString());
                        //LA APLICO COMO VALOR ACTIVO EN EL ULTRACOMBO
                        UCITEMS.SelectedRow = UCITEMS.Rows[numeroFila];
                        //APLICO TABULACION PARA QUE PASE A LA SIGUIENTE CELDA.
                        //NOTA: SI LO QUITAS SIMPLEMENTE AL PRESIONAR TABULADOR SE QUEDARA CON LA SELECCION EN LA CELDA ACTIVA
                        SendKeys.Send("{TAB}");
                    }
                }
            }
        }
    }
}
