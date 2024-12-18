using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

//LIBRERIAS DE OPEN
using OpenSystems.Windows.Controls;


//LIBRERIAS COMPLEMENTARIAS
using SINCECOMP.VALORECLAMO.BL;
using System.Data;
using System.Windows.Forms;
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;

namespace SINCECOMP.VALORECLAMO.UI
{
    public partial class LDCAVR : OpenForm
    {
        BLLDCAVR general = new BLLDCAVR();
        Boolean inicio = false;

        public LDCAVR()
        {
            InitializeComponent();
        }

        private void LDCAVR_Load(object sender, EventArgs e)
        {
            OgReclamos.DisplayLayout.Bands[0].Columns["valorfactura"].CellAppearance.TextHAlign = HAlign.Right;
            OgReclamos.DisplayLayout.Bands[0].Columns["valorfactura"].Format = "$ #,##0.00";
            OgReclamos.DisplayLayout.Bands[0].Columns["valorreclamo"].CellAppearance.TextHAlign = HAlign.Right;
            OgReclamos.DisplayLayout.Bands[0].Columns["valorreclamo"].Format = "$ #,##0.00";
            //OgReclamos.DisplayLayout.Bands[0].Columns["reclamosid"].Hidden = true;
            //OgReclamos.DisplayLayout.Bands[0].Columns["reclamosid"].Format = "$ #,##0.00";
            OgReclamos.DisplayLayout.Bands[0].Columns["reclamosid"].CellAppearance.TextHAlign = HAlign.Right;
            //OgReclamos.DisplayLayout.Bands[0].Columns["reclamosid"].Hidden = false;
            OgReclamos.DisplayLayout.Bands[0].Columns["reclamooriginal"].Hidden = true;

            //Columnas que no debe ser editadas
            OgReclamos.DisplayLayout.Bands[0].Columns["solicitud"].CellActivation = Activation.NoEdit;
            OgReclamos.DisplayLayout.Bands[0].Columns["cuenta"].CellActivation = Activation.NoEdit;
            OgReclamos.DisplayLayout.Bands[0].Columns["factura"].CellActivation = Activation.NoEdit;
            OgReclamos.DisplayLayout.Bands[0].Columns["cargos"].CellActivation = Activation.NoEdit;
            OgReclamos.DisplayLayout.Bands[0].Columns["contrato"].CellActivation = Activation.NoEdit;
            OgReclamos.DisplayLayout.Bands[0].Columns["causal"].CellActivation = Activation.NoEdit;
            OgReclamos.DisplayLayout.Bands[0].Columns["tiposolicitud"].CellActivation = Activation.NoEdit;
            OgReclamos.DisplayLayout.Bands[0].Columns["fecharegitro"].CellActivation = Activation.NoEdit;
            OgReclamos.DisplayLayout.Bands[0].Columns["puntoatencion"].CellActivation = Activation.NoEdit;
            OgReclamos.DisplayLayout.Bands[0].Columns["funcionario"].CellActivation = Activation.NoEdit;
            OgReclamos.DisplayLayout.Bands[0].Columns["valorfactura"].CellActivation = Activation.NoEdit;
            //OgReclamos.DisplayLayout.Bands[0].Columns[""].CellActivation = Activation.NoEdit;
            ///////////////////////////////////////////

        }

        private void BtnBuscar_Click(object sender, EventArgs e)
        {
            BdsReclamos.Clear();
            inicio = false;

            if (String.IsNullOrEmpty(TxtContrato.Text) && String.IsNullOrEmpty(txtSolicitud.Text))
            {
                MessageBox.Show("Al menos el contrato o solicitud deben ser digitados.");
            }
            else
            {
                //if (!String.IsNullOrEmpty(txtSolicitud.Text))
                if (!String.IsNullOrEmpty(TxtContrato.Text))
                {
                    OgReclamos.DisplayLayout.Bands[0].Columns["cargos"].Hidden = true;
                    OgReclamos.DisplayLayout.Bands[0].Columns["reclamosid"].Hidden = true;
                    OgReclamos.DisplayLayout.Bands[0].Columns["valorreclamo"].CellActivation = Activation.NoEdit;
                }
                else
                {
                    OgReclamos.DisplayLayout.Bands[0].Columns["cargos"].Hidden = false;
                    OgReclamos.DisplayLayout.Bands[0].Columns["reclamosid"].Hidden = true;
                    OgReclamos.DisplayLayout.Bands[0].Columns["valorreclamo"].CellActivation = Activation.AllowEdit;
                }

                //CONSULTO LOS CARGOS DE LA FACTURA
                String[] tipos = { "Int64", "Int64" };
                String[] campos = { "nuContrato", "nuSolicitud" };
                object[] valores = { TxtContrato.Text, txtSolicitud.Text };
                //MessageBox.Show(TxtContrato.Text);
                DataTable Datos = general.cursorProcedure("Ldc_PkValoresReclamo.GETRECLAMO", 2, tipos, campos, valores);
                int totalFila = OgReclamos.Rows.Count;
                if (Datos.Rows.Count > 0)
                {

                    System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                    for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                    {
                        BdsReclamos.AddNew();
                        OgReclamos.Rows[totalFila].Cells["solicitud"].Value = Datos.Rows[x].ItemArray[0].ToString();
                        OgReclamos.Rows[totalFila].Cells["cuenta"].Value = Datos.Rows[x].ItemArray[1].ToString();
                        OgReclamos.Rows[totalFila].Cells["factura"].Value = Datos.Rows[x].ItemArray[2].ToString();
                        OgReclamos.Rows[totalFila].Cells["cargos"].Value = Datos.Rows[x].ItemArray[3].ToString();
                        OgReclamos.Rows[totalFila].Cells["contrato"].Value = Datos.Rows[x].ItemArray[4].ToString();
                        OgReclamos.Rows[totalFila].Cells["causal"].Value = Datos.Rows[x].ItemArray[5].ToString();
                        OgReclamos.Rows[totalFila].Cells["tiposolicitud"].Value = Datos.Rows[x].ItemArray[6].ToString();
                        OgReclamos.Rows[totalFila].Cells["fecharegitro"].Value = Datos.Rows[x].ItemArray[7].ToString();
                        OgReclamos.Rows[totalFila].Cells["puntoatencion"].Value = Datos.Rows[x].ItemArray[8].ToString();
                        OgReclamos.Rows[totalFila].Cells["funcionario"].Value = Datos.Rows[x].ItemArray[9].ToString();
                        OgReclamos.Rows[totalFila].Cells["valorfactura"].Value = Double.Parse(Datos.Rows[x].ItemArray[10].ToString());
                        OgReclamos.Rows[totalFila].Cells["valorreclamo"].Value = Double.Parse(Datos.Rows[x].ItemArray[11].ToString());
                        OgReclamos.Rows[totalFila].Cells["reclamosid"].Value = Double.Parse(Datos.Rows[x].ItemArray[12].ToString());
                        OgReclamos.Rows[totalFila].Cells["reclamooriginal"].Value = Double.Parse(Datos.Rows[x].ItemArray[11].ToString());
                        totalFila++;

                    }
                    inicio = true;

                    System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

                }
                else
                {
                    if (!String.IsNullOrEmpty(txtSolicitud.Text))
                    {
                        MessageBox.Show("La solicitud [" + txtSolicitud.Text + "] tiene un estado invalido.");
                    }
                    else
                    {
                        if (!String.IsNullOrEmpty(TxtContrato.Text))
                        {
                            MessageBox.Show("El contrato [" + TxtContrato.Text + "] no tiene solicitud(es) de reclamo en estado valido.");
                        }
                    }
                }
            }
        }

        private void BtnLimpiar_Click(object sender, EventArgs e)
        {
            BdsReclamos.Clear();
            TxtContrato.Text = null;
            txtSolicitud.Text = null;
            txtObservacion = null;
        }

        private void BtnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void BtnProcesar_Click(object sender, EventArgs e)
        {
            //Parametros Servicio aplica reclamo
            Int64 InuTipo = 1;
            Int64 InuSolicitud = 0;
            String IsbComentario = null;
            Int64 Inureclamosid = 0;
            Double Inuvalorreclamo = 0;
            Int64 OnuErrorCode = 0;
            String OsbErrorMessage = null;

            Int64 NuFilaSeleccionada = 0;
            /////////////////////////////////////////

            String Mesajefinal = null;

            //Comentariado para cambiar la logica para que procesar solicitud por contrato
            //if (!String.IsNullOrEmpty(txtSolicitud.Text))
            //{
            //    InuTipo = 2;
            //    InuSolicitud = Int64.Parse(txtSolicitud.Text);
            //}

            IsbComentario = txtObservacion.Text;

            if (OgReclamos.Rows.Count > 0)
            {
                //copia resultados grilla
                for (int x = 0; x <= OgReclamos.Rows.Count - 1; x++)
                {
                    //selection = Boolean.Parse(datosGrilla.Rows[x].Cells[0].Value.ToString()),
                    //cuenta = datosGrilla.Rows[x].Cells[a].Value.ToString(),
                    //product = Int64.Parse(datosGrilla.Rows[x].Cells[b].Value.ToString()),
                    //concept  = datosGrilla.Rows[x].Cells[c].Value.ToString(),
                    //VLR_FACTURADO  = Double.Parse(datosGrilla.Rows[x].Cells[e].Value.ToString()),
                    //fecha = DateTime.Parse(datosGrilla.Rows[x].Cells[n].Value.ToString()),
                    if (Boolean.Parse(OgReclamos.Rows[x].Cells["selection"].Value.ToString()))
                    {
                        //
                        if (!String.IsNullOrEmpty(TxtContrato.Text))
                        {
                            InuTipo = 2;
                            InuSolicitud = Int64.Parse(OgReclamos.Rows[x].Cells["solicitud"].Value.ToString());
                        }

                        Inureclamosid = Int64.Parse(OgReclamos.Rows[x].Cells["reclamosid"].Value.ToString());
                        Inuvalorreclamo = Double.Parse(OgReclamos.Rows[x].Cells["valorreclamo"].Value.ToString());
                        //MessageBox.Show("Tipo[" + InuTipo + "] - Valor en reclamo[" + Inuvalorreclamo + "] - ReclamoID[" + Inureclamosid + "]");
                        general.prApplyValorReclamo(InuTipo, InuSolicitud, IsbComentario, Inureclamosid, Inuvalorreclamo, out OnuErrorCode, out  OsbErrorMessage);
                        //MessageBox.Show("Valor en reclamo[" + OgReclamos.Rows[x].Cells["valorreclamo"].Value.ToString() + "] - ReclamoID[" + OgReclamos.Rows[x].Cells["reclamosid"].Value.ToString() + "]");// - Cargos[" +  OgReclamos.Rows[x].Cells["cargos"].Value.ToString() +"]");
                        if (!String.IsNullOrEmpty(OsbErrorMessage))
                        {
                            Mesajefinal += OsbErrorMessage + "\n";
                        }
                        NuFilaSeleccionada = 1;
                    }
                }

                if (NuFilaSeleccionada == 0)
                {
                    MessageBox.Show("No se ha seleccionado ningun dato.");
                }
                else
                {
                    if (String.IsNullOrEmpty(Mesajefinal))
                    {
                        MessageBox.Show("Reclamo Aplicado Existosamente.");
                    }
                    else
                    {
                        MessageBox.Show(Mesajefinal);
                    }
                }

                BdsReclamos.Clear();
                TxtContrato.Text = null;
                txtSolicitud.Text = null;
                txtObservacion.Text = null;
                inicio = false;

            }
            
        }

        private void OgReclamos_AfterCellUpdate(object sender, CellEventArgs e)
        {
            if (inicio)
            {
                if (e.Cell.Column.Key == "valorreclamo")
                {
                    if (Convert.ToDouble(OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["valorreclamo"].Value) <= 0)
                    {
                        MessageBox.Show("El valor en reclamo no puede ser menor o igual a 0.");
                        OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["valorreclamo"].Value = OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["reclamooriginal"].Value;
                    }
                    else
                    {
                        if (Convert.ToDouble(OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["valorreclamo"].Value) > Convert.ToDouble(OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["reclamooriginal"].Value))
                        {
                            MessageBox.Show("El valor en reclamo no puede ser mayor a " + OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["reclamooriginal"].Value.ToString() + ".");
                            OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["valorreclamo"].Value = OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["reclamooriginal"].Value;
                        }
                    }
                }
            }
        }

        //private void OgReclamos_AfterCellUpdate(object sender, CellEventArgs e)
        //{
        //    if (inicio)
        //    {
        //        if (e.Cell.Column.Key == "valorreclamo")
        //        {
        //            if (Convert.ToDouble(OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["valorreclamo"].Value) <= 0)
        //            {
        //                MessageBox.Show("El valor en reclamo no puede ser menor o igual a 0.");
        //                OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["valorreclamo"].Value = OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["reclamooriginal"].Value;
        //            }
        //            else
        //            {
        //                if (Convert.ToDouble(OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["valorreclamo"].Value) > Convert.ToDouble(OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["reclamooriginal"].Value))
        //                {
        //                    MessageBox.Show("El valor en reclamo no puede ser mayor a " + OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["reclamooriginal"].Value.ToString() + ".");
        //                    OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["valorreclamo"].Value = OgReclamos.Rows[OgReclamos.ActiveCell.Row.Index].Cells["reclamooriginal"].Value;
        //                }
        //            }
        //        }
        //    }
        //}
    }
}
