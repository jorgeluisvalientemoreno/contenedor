using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

//Libreiras OPEN
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Windows.Controls;
using BSS.METROSCUBICOS.BL;

namespace BSS.METROSCUBICOS.UI
{
    public partial class LDCEMC : OpenForm
    {
        BLLDCEMC general = new BLLDCEMC();

        //Columnas definidas para la grilla prncipal
        String ca = "selection";
        String cb = "accion";
        String cc = "observacion";
        String cd = "periodo";
        String ce = "anno";
        String cf = "mes";
        String cg = "ciclo";
        String ch = "contrato";
        String ci = "producto";
        String cj = "concepto";
        String ck = "volliq";
        String cl = "valliq";
        String cm = "categoría";
        String cn = "subcategoria";
        String co = "estado_producto";
        String cp = "codigociclo";
        String cq = "proceso";
        String cr = "procesoCod";
        //


        public LDCEMC()
        {
            InitializeComponent();
        }

        private void BtnBuscar_Click(object sender, EventArgs e)
        {
            Int64 RbSeleccion = 1;


            if (RbGenCargos.Checked)
            {
                RbSeleccion = 2;
            }
            

            //CONSULTO LOS CARGOS DE LA FACTURA
            String[] tipos = { "Int64" };
            String[] campos = { "InuTipoBusqueda" };
            object[] valores = { RbSeleccion };
            //MessageBox.Show(TxtContrato.Text);
            DataTable Datos = general.cursorProcedure("LDC_PKMETROSCUBICOS.FRFESTMETCUBACCION", 1, tipos, campos, valores);
            int totalFila = UgMetrosCubicos.Rows.Count;
            if (Datos.Rows.Count > 0)
            {
                var valueList = new ValueList();
                if (RbSeleccion == 1)
                {
                    valueList.ValueListItems.Add("0", "Validado");
                    valueList.ValueListItems.Add("1", "Reversar Cargos");
                    UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cc].Hidden = false;
                    UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cl].Hidden = false;
                }
                else
                {
                    valueList.ValueListItems.Add("2", "Corregido Generación");
                    UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cc].Hidden = true;
                    UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cl].Hidden = true;
                }

                UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cb].ValueList = valueList;

                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                {
                    bsPrometcub.AddNew();

                    if (RbSeleccion == 2)
                    {
                        UgMetrosCubicos.Rows[totalFila].Cells[cb].Value = 2;
                    }

                    UgMetrosCubicos.Rows[totalFila].Cells[cd].Value = Datos.Rows[x].ItemArray[0].ToString();
                    UgMetrosCubicos.Rows[totalFila].Cells[ce].Value = Datos.Rows[x].ItemArray[1].ToString();
                    UgMetrosCubicos.Rows[totalFila].Cells[cf].Value = Datos.Rows[x].ItemArray[2].ToString();
                    UgMetrosCubicos.Rows[totalFila].Cells[cg].Value = Datos.Rows[x].ItemArray[3].ToString();
                    UgMetrosCubicos.Rows[totalFila].Cells[ch].Value = Datos.Rows[x].ItemArray[4].ToString();
                    UgMetrosCubicos.Rows[totalFila].Cells[ci].Value = Datos.Rows[x].ItemArray[5].ToString();
                    UgMetrosCubicos.Rows[totalFila].Cells[cj].Value = Datos.Rows[x].ItemArray[6].ToString();
                    UgMetrosCubicos.Rows[totalFila].Cells[ck].Value = Datos.Rows[x].ItemArray[7].ToString();
                    UgMetrosCubicos.Rows[totalFila].Cells[cl].Value = Datos.Rows[x].ItemArray[8].ToString();
                    UgMetrosCubicos.Rows[totalFila].Cells[cm].Value = Datos.Rows[x].ItemArray[9].ToString();
                    UgMetrosCubicos.Rows[totalFila].Cells[cn].Value = Datos.Rows[x].ItemArray[10].ToString();
                    UgMetrosCubicos.Rows[totalFila].Cells[co].Value = Datos.Rows[x].ItemArray[11].ToString();
                    UgMetrosCubicos.Rows[totalFila].Cells[cp].Value = Datos.Rows[x].ItemArray[12].ToString();             
                    //inicio ca 461
                    UgMetrosCubicos.Rows[totalFila].Cells[cq].Value = Datos.Rows[x].ItemArray[13].ToString();
                    UgMetrosCubicos.Rows[totalFila].Cells[cr].Value = Datos.Rows[x].ItemArray[14].ToString(); 
                    //fin ca 461
                    totalFila++;

                }

                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

                BtnBuscar.Enabled = false;
                BtnProcesar.Enabled = true;
                RbRevCargos.Enabled = false;
                RbGenCargos.Enabled = false;

            }

        }

        private void BtnProcesar_Click(object sender, EventArgs e)
        {

            Int64 NuFilaSeleccionada = 0;
            Int64 NuObservacion = 0;
            Int64 NuAccion = 0;

            //Definicion de DATA de grilla en Varibles
            Int64 v_periodo;
            Int64 v_anno;
            Int64 v_mes;
            Int64 v_contrato;
            Int64 v_producto;
            String v_observacion = null;
            Int64 v_accion;
            Int64 InuTipoBusqueda;
            Int64 v_ciclo;
            String v_proceso = null; //ca 461 nueva variable para proceso
            Int64 v_procesocod;
            //

            Int64 NuContarFilas = 0;

            if (UgMetrosCubicos.Rows.Count > 0)
            {
                //////////////////////////////////VALIDACION////////////////////////////////

                //Recorrido de grilla
                for (int x = 0; x <= UgMetrosCubicos.Rows.Count - 1; x++)
                {
                    if (Boolean.Parse(UgMetrosCubicos.Rows[x].Cells[ca].Value.ToString()))
                    {
                        NuContarFilas = NuContarFilas + 1;
                    }
                }

                if (NuContarFilas > 0)
                {
                    //Recorre grilla para validar si selecciona Accion
                    for (int x = 0; x <= UgMetrosCubicos.Rows.Count - 1; x++)
                    {
                        if (Boolean.Parse(UgMetrosCubicos.Rows[x].Cells[ca].Value.ToString()))
                        {
                            if (String.IsNullOrEmpty(UgMetrosCubicos.Rows[x].Cells[cb].Text) && NuAccion == 0)
                            {
                                MessageBox.Show("Falta Seleccionar una Acccion.");
                                NuAccion = 1;
                            }
                        }
                    }

                    //Recorre grilla para validar observacion obligatoria
                    if (NuAccion == 0)
                    {
                        for (int x = 0; x <= UgMetrosCubicos.Rows.Count - 1; x++)
                        {
                            if (Boolean.Parse(UgMetrosCubicos.Rows[x].Cells[ca].Value.ToString()))
                            {

                                v_accion = Convert.ToInt64(UgMetrosCubicos.Rows[x].Cells[cb].Value.ToString());
                                if (v_accion == 0)
                                {
                                    if (String.IsNullOrEmpty(UgMetrosCubicos.Rows[x].Cells[cc].Text) && NuObservacion == 0)
                                    {
                                        MessageBox.Show("La Observacion de la Acccion Validacion es Obligatoria.");
                                        NuObservacion = 1;
                                    }
                                }

                            }
                        }
                    }

                    //alidar periodo activo del ciclo seleccionado en la grilla
                    Int64 nuContrl = 0;
                    if (NuObservacion == 0 && NuAccion == 0 && RbGenCargos.Checked == true)
                    {
                        for (int x = 0; x <= UgMetrosCubicos.Rows.Count - 1; x++)
                        {
                            if (nuContrl == 0)
                            {
                                v_ciclo = Convert.ToInt64(UgMetrosCubicos.Rows[x].Cells[cp].Value.ToString());
                                String[] U1 = new string[] { "Int64" };
                                String[] U2 = new string[] { "v_ciclo" };
                                Object[] U3 = new object[] { v_ciclo };
                                general.executeService("LDC_PKMETROSCUBICOS.PRPERIODOACTIVO", 1, U1, U2, U3);


                            }
                        }
                    }

                    //////////////////////////////////////////////////////////////7

                    if (NuObservacion == 0 && NuAccion == 0)
                    {
                        //Recorrido de grilla para actualizar DATA
                        for (int x = 0; x <= UgMetrosCubicos.Rows.Count - 1; x++)
                        {
                            System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                            PbProcesar.Visible = true;
                            PbProcesar.Maximum = Convert.ToInt32(NuContarFilas);

                            if (Boolean.Parse(UgMetrosCubicos.Rows[x].Cells[ca].Value.ToString()))
                            {

                                v_periodo = Convert.ToInt64(UgMetrosCubicos.Rows[x].Cells[cd].Value.ToString());
                                v_anno = Convert.ToInt64(UgMetrosCubicos.Rows[x].Cells[ce].Value.ToString());
                                v_mes = Convert.ToInt64(UgMetrosCubicos.Rows[x].Cells[cf].Value.ToString());
                                v_contrato = Convert.ToInt64(UgMetrosCubicos.Rows[x].Cells[ch].Value.ToString());
                                v_producto = Convert.ToInt64(UgMetrosCubicos.Rows[x].Cells[ci].Value.ToString());
                                v_observacion = UgMetrosCubicos.Rows[x].Cells[cc].Text;
                                v_accion = Convert.ToInt64(UgMetrosCubicos.Rows[x].Cells[cb].Value.ToString());

                                if (RbGenCargos.Checked)
                                {
                                    InuTipoBusqueda = 2;
                                }
                                else
                                {
                                    InuTipoBusqueda = 1;
                                }

                                v_ciclo = Convert.ToInt64(UgMetrosCubicos.Rows[x].Cells[cp].Value.ToString());
                                v_proceso = UgMetrosCubicos.Rows[x].Cells[cq].Text;
                                v_procesocod = Convert.ToInt64(UgMetrosCubicos.Rows[x].Cells[cr].Value.ToString());
                                //MessageBox.Show("Ciclo[" + v_ciclo.ToString() + "]");

                                //MessageBox.Show("Accion[" + UgMetrosCubicos.Rows[x].Cells[cb].Value.ToString() + "]");
                                //se agrego la consulta de actualizacion
                                String[] U1 = new string[] { "Int64", "Int64", "Int64", "Int64", "Int64", "String", "Int64", "Int64", "Int64", "Int64" };
                                String[] U2 = new string[] { "v_periodo", "v_anno", "v_mes", "v_contrato", "v_producto", "v_observacion", "v_accion", "InuTipoBusqueda", "v_ciclo", "v_proceso" };
                                Object[] U3 = new object[] { v_periodo, v_anno, v_mes, v_contrato, v_producto, v_observacion, v_accion, InuTipoBusqueda, v_ciclo, v_procesocod };
                                general.executeService("LDC_PKMETROSCUBICOS.PRESTMETCUBACCION", 10, U1, U2, U3);

                                PbProcesar.Value = PbProcesar.Value + 1;

                                NuFilaSeleccionada = 1;
                            }

                            System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

                        }

                        if (NuFilaSeleccionada == 0)
                        {
                            MessageBox.Show("No se ha seleccionado ningun dato a procesar.");
                            PbProcesar.Visible = false;
                            PbProcesar.Value = 0;
                        }
                        else
                        {
                            MessageBox.Show("Proceso Ejecutado Existosamente.");
                            PbProcesar.Visible = false;
                            PbProcesar.Value = 0;
                        
                            bsPrometcub.Clear();
                            BtnBuscar.Enabled = true;
                            BtnProcesar.Enabled = false;
                            RbRevCargos.Enabled = true;
                            RbGenCargos.Enabled = true;
                        }
                    }
                }
                else
                {
                    MessageBox.Show("No se ha seleccionado ningun dato a procesar.");
                }//Fin de validacicion de cantidad de filas
            }
        }

        private void BtnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void LDCEMC_Load(object sender, EventArgs e)
        {
            
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cd].CellAppearance.TextHAlign = HAlign.Right;
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cd].CellActivation = Activation.ActivateOnly;

            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[ce].CellAppearance.TextHAlign = HAlign.Right;
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[ce].CellActivation = Activation.ActivateOnly;
            
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cf].CellAppearance.TextHAlign = HAlign.Right;
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cf].CellActivation = Activation.ActivateOnly;

            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cg].CellActivation = Activation.ActivateOnly;
            
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[ch].CellAppearance.TextHAlign = HAlign.Right;
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[ch].CellActivation = Activation.ActivateOnly;

            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[ci].CellAppearance.TextHAlign = HAlign.Right;
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[ci].CellActivation = Activation.ActivateOnly;

            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cj].CellActivation = Activation.ActivateOnly;
            
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[ck].CellAppearance.TextHAlign = HAlign.Right;
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[ck].CellActivation = Activation.ActivateOnly;

            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cl].CellAppearance.TextHAlign = HAlign.Right;
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cl].CellActivation = Activation.ActivateOnly;

            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cm].CellAppearance.TextHAlign = HAlign.Right;
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cm].CellActivation = Activation.ActivateOnly;

            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cn].CellAppearance.TextHAlign = HAlign.Right;
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cn].CellActivation = Activation.ActivateOnly;

            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[co].CellAppearance.TextHAlign = HAlign.Right;
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[co].CellActivation = Activation.ActivateOnly;

            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cp].Hidden = true;

            //inicio ca 461
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cq].CellActivation = Activation.ActivateOnly;
            UgMetrosCubicos.DisplayLayout.Bands[0].Columns[cr].Hidden = true;
            //fin ca 461

            PbProcesar.Visible = false;
        }

        private void BtnLimpiar_Click(object sender, EventArgs e)
        {
            bsPrometcub.Clear();
            BtnBuscar.Enabled = true;
            BtnProcesar.Enabled = false;
            RbRevCargos.Enabled = true;
            RbGenCargos.Enabled = true;
        }

        private void UgMetrosCubicos_Error(object sender, ErrorEventArgs e)
        {
            if (e.ErrorType == ErrorType.Data)
            {
                if (String.IsNullOrEmpty(UgMetrosCubicos.ActiveRow.Cells[cb].Text))
                {
                    UgMetrosCubicos.ActiveRow.Cells[cc].Value = " ";
                    e.Cancel = true;
                }
                else
                {
                    if (Convert.ToInt64(UgMetrosCubicos.ActiveRow.Cells[cb].Value.ToString()) == 0)
                    {
                        MessageBox.Show("La Accion " + UgMetrosCubicos.ActiveRow.Cells[cb].Text + " Debe tener una observacion.");
                        e.Cancel = true;
                    }
                    else
                    {
                        UgMetrosCubicos.ActiveRow.Cells[cc].Value = " ";
                        e.Cancel = true;
                    }
                }
            }
        }
    }
}
