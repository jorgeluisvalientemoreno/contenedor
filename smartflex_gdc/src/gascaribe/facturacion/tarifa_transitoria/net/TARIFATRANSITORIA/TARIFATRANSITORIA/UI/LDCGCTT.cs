using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
//using System.Linq;
using System.Text;
using System.Windows.Forms;

//CASO 415
using Infragistics.Win;
using OpenSystems.Windows.Controls;
using TARIFATRANSITORIA.BL;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.Data;

namespace TARIFATRANSITORIA.UI
{
    public partial class LDCGCTT : OpenForm
    {
        BLLDCGCTT general = new BLLDCGCTT(); //Procedimiento Generales
        Boolean BtnProcesarControl = false;

        public LDCGCTT()
        {
            InitializeComponent();
            //Cargue de DATA de Medio de Recpcion
            DataTable medioRecep = general.cursorProcedure("LDC_PKTARIFATRANSITORIA.GetReceptiontype", 0, null, null, null);
            CmbMediorecepcion.DataSource = null;
            CmbMediorecepcion.Value = "";
            CmbMediorecepcion.DataSource = medioRecep;
            CmbMediorecepcion.ValueMember = "ID";
            CmbMediorecepcion.DisplayMember = "DESCRIPTION";

            //Cargue de DATA Tipo Documento
            DataTable Solicitantetipodoc = general.cursorProcedure("LDC_PKTARIFATRANSITORIA.GetIdentificatype", 0, null, null, null);
            Cmbsolicitantetipodoc.DataSource = null;
            Cmbsolicitantetipodoc.Value = "";
            Cmbsolicitantetipodoc.DataSource = Solicitantetipodoc;
            Cmbsolicitantetipodoc.ValueMember = "ID";
            Cmbsolicitantetipodoc.DisplayMember = "DESCRIPTION";

            UblFechaSolicitud1.Text = DateTime.Now.Date.ToShortDateString();
            

        }

        private void LDCGCTT_Load(object sender, EventArgs e)
        {
            //CASO 415
            OgDetalleFactura.DisplayLayout.Bands[0].Columns["valornota"].Format = "$ #,##0.00";
            OgResumenDetalle.DisplayLayout.Bands[0].Columns["valornota"].Format = "$ #,##0.00";
            BtnConsultar.Enabled = false;
            BtnProcesar.Enabled = false;
        }

        private void BtnConsultar_Click(object sender, EventArgs e)
        {
            BdsDetalleFacturacion.Clear();
            BdsResumenDetalle.Clear();

            //CONSULTO LOS CARGOS DE LA FACTURA
            String[] tipos = { "Int64" };
            String[] campos = { "inservsusc" };
            object[] valores = { TxtContrato.Text };
            //MessageBox.Show(TxtContrato.Text);
            DataTable Datos = general.cursorProcedure("LDC_PKTARIFATRANSITORIA.GetDatosLDC_DEPRTATT", 1, tipos, campos, valores);
            int totalFila = OgDetalleFactura.Rows.Count;
            if (Datos.Rows.Count > 0)
            {

                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                {
                    BdsDetalleFacturacion.AddNew();
                    OgDetalleFactura.Rows[totalFila].Cells["factura"].Value = Datos.Rows[x].ItemArray[0].ToString();
                    OgDetalleFactura.Rows[totalFila].Cells["periodo"].Value = Datos.Rows[x].ItemArray[1].ToString();
                    OgDetalleFactura.Rows[totalFila].Cells["cuenta"].Value = Datos.Rows[x].ItemArray[2].ToString();
                    OgDetalleFactura.Rows[totalFila].Cells["concepto"].Value = Datos.Rows[x].ItemArray[3].ToString();
                    OgDetalleFactura.Rows[totalFila].Cells["causalcargo"].Value = Datos.Rows[x].ItemArray[4].ToString();
                    OgDetalleFactura.Rows[totalFila].Cells["nota"].Value = Datos.Rows[x].ItemArray[5].ToString();
                    OgDetalleFactura.Rows[totalFila].Cells["fecharegistro"].Value = Datos.Rows[x].ItemArray[6].ToString();
                    OgDetalleFactura.Rows[totalFila].Cells["signonota"].Value = Datos.Rows[x].ItemArray[7].ToString();
                    OgDetalleFactura.Rows[totalFila].Cells["valornota"].Value = Double.Parse(Datos.Rows[x].ItemArray[8].ToString());
                    totalFila++;
                }

                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

                if (BtnProcesarControl == true)
                {
                    BtnProcesar.Enabled = true;
                }

            }

            //RESUMEN CONCEPTOS DE LA FACTURA
            String[] tipos1 = { "Int64" };
            String[] campos2 = { "inservsusc" };
            object[] valores3 = { TxtContrato.Text };
            //MessageBox.Show(TxtContrato.Text);
            Datos = general.cursorProcedure("LDC_PKTARIFATRANSITORIA.GetResumenConcepto", 1, tipos1, campos2, valores3);
            totalFila = OgResumenDetalle.Rows.Count;
            if (Datos.Rows.Count > 0)
            {

                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                Double nuvalornota = 0;

                for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                {
                    BdsResumenDetalle.AddNew();
                    OgResumenDetalle.Rows[totalFila].Cells["concepto"].Value = Datos.Rows[x].ItemArray[0].ToString();
                    OgResumenDetalle.Rows[totalFila].Cells["valornota"].Value = Double.Parse(Datos.Rows[x].ItemArray[1].ToString());
                    nuvalornota = nuvalornota + Double.Parse(Datos.Rows[x].ItemArray[1].ToString());
                    totalFila++;
                }
                if (totalFila > 0) 
                {
                    BdsResumenDetalle.AddNew();
                    OgResumenDetalle.Rows[totalFila].Cells["concepto"].Value = "Total";
                    OgResumenDetalle.Rows[totalFila].Cells["valornota"].Value = nuvalornota;
                }

                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

            }
        }

        private void TxtContrato_Leave(object sender, EventArgs e)
        {
            try
            {
                BdsDetalleFacturacion.Clear();
                BdsResumenDetalle.Clear();
                if (!String.IsNullOrEmpty(TxtContrato.Text))
                {
                    //CONSULTO LOS CARGOS DE LA FACTURA
                    String[] tipos = { "Int64" };
                    String[] campos = { "inservsusc" };
                    object[] valores = { TxtContrato.Text };
                    //MessageBox.Show(TxtContrato.Text);
                 
                    System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;
                 
                    DataTable BasicDate = general.cursorProcedure("LDC_PKTARIFATRANSITORIA.GetInformacionCliente", 1, tipos, campos, valores);
                    if (BasicDate.Rows.Count > 0)
                    {

                        Int64 nuestrato = 0;
                        nuestrato = Convert.ToInt64(BasicDate.Rows[0]["estrato"].ToString());

                        if (nuestrato == 0)
                        {
                            //MessageBox.Show("El contrato [" + TxtContrato.Text + "] esta activo pero no se puede desvincular.");
                            //TxtContrato.Text = "";
                            //ulbServicio1.Text = "";
                            //ulbNombre1.Text = "";
                            //ulbTelefono1.Text = "";
                            //ulbDireccion1.Text = "";
                            //BtnConsultar.Enabled = false;

                            BtnProcesarControl = false;
                            BtnProcesar.Enabled = false;
                        }
                        else
                        {
                            BtnProcesarControl = true;
                        }

                        //else
                        //{

                            //System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                            ulbServicio1.Text = BasicDate.Rows[0]["servicio"].ToString();
                            ulbNombre1.Text = BasicDate.Rows[0]["nombre"].ToString();
                            ulbTelefono1.Text = BasicDate.Rows[0]["telefono"].ToString();
                            ulbDireccion1.Text = BasicDate.Rows[0]["direccion"].ToString();

                            BtnConsultar.Enabled = true;

                            //System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

                            /////DATA

                            //////LOGICA LLENADO DE GRILLA
                            BdsDetalleFacturacion.Clear();
                            BdsResumenDetalle.Clear();

                            //CONSULTO LOS CARGOS DE LA FACTURA
                            //String[] tipos1 = { "Int64" };
                            //String[] campos1 = { "inservsusc" };
                            //object[] valores1 = { TxtContrato.Text };
                            //MessageBox.Show(TxtContrato.Text);
                            DataTable Datos = general.cursorProcedure("LDC_PKTARIFATRANSITORIA.GetDatosLDC_DEPRTATT", 1, tipos, campos, valores);
                            int totalFila = OgDetalleFactura.Rows.Count;
                            if (Datos.Rows.Count > 0)
                            {

                                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                                for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                                {
                                    BdsDetalleFacturacion.AddNew();
                                    OgDetalleFactura.Rows[totalFila].Cells["factura"].Value = Datos.Rows[x].ItemArray[0].ToString();
                                    OgDetalleFactura.Rows[totalFila].Cells["periodo"].Value = Datos.Rows[x].ItemArray[1].ToString();
                                    OgDetalleFactura.Rows[totalFila].Cells["cuenta"].Value = Datos.Rows[x].ItemArray[2].ToString();
                                    OgDetalleFactura.Rows[totalFila].Cells["concepto"].Value = Datos.Rows[x].ItemArray[3].ToString();
                                    OgDetalleFactura.Rows[totalFila].Cells["causalcargo"].Value = Datos.Rows[x].ItemArray[4].ToString();
                                    OgDetalleFactura.Rows[totalFila].Cells["nota"].Value = Datos.Rows[x].ItemArray[5].ToString();
                                    OgDetalleFactura.Rows[totalFila].Cells["fecharegistro"].Value = Datos.Rows[x].ItemArray[6].ToString();
                                    OgDetalleFactura.Rows[totalFila].Cells["signonota"].Value = Datos.Rows[x].ItemArray[7].ToString();
                                    OgDetalleFactura.Rows[totalFila].Cells["valornota"].Value = Double.Parse(Datos.Rows[x].ItemArray[8].ToString());
                                    totalFila++;                           
                                }

                                System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

                                if (BtnProcesarControl == true)
                                {
                                    BtnProcesar.Enabled = true;
                                }

                            }

                            //RESUMEN CONCEPTOS DE LA FACTURA
                            String[] tipos1 = { "Int64" };
                            String[] campos2 = { "inservsusc" };
                            object[] valores3 = { TxtContrato.Text };
                            //MessageBox.Show(TxtContrato.Text);
                            Datos = general.cursorProcedure("LDC_PKTARIFATRANSITORIA.GetResumenConcepto", 1, tipos1, campos2, valores3);
                            totalFila = OgResumenDetalle.Rows.Count;
                            if (Datos.Rows.Count > 0)
                            {

                                //System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                                Double nuvalornota = 0;

                                for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                                {
                                    BdsResumenDetalle.AddNew();
                                    OgResumenDetalle.Rows[totalFila].Cells["concepto"].Value = Datos.Rows[x].ItemArray[0].ToString();
                                    OgResumenDetalle.Rows[totalFila].Cells["valornota"].Value = Double.Parse(Datos.Rows[x].ItemArray[1].ToString());
                                    nuvalornota = nuvalornota + Double.Parse(Datos.Rows[x].ItemArray[1].ToString());
                                    totalFila++;
                                }
                                if (totalFila > 0)
                                {
                                    BdsResumenDetalle.AddNew();
                                    OgResumenDetalle.Rows[totalFila].Cells["concepto"].Value = "Total";
                                    OgResumenDetalle.Rows[totalFila].Cells["valornota"].Value = nuvalornota;
                                }

                                //System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

                            }
                            /////FIN LOGICA LLENADO DE GRILLA

                            /////////
                        //}
                    }
                    else
                    {
                        MessageBox.Show("El contrato [" + TxtContrato.Text + "] no tiene un servicio en TARIFA TRANSITORIA activa.");
                        TxtContrato.Text = "";
                        ulbServicio1.Text = "";
                        ulbNombre1.Text = "";
                        ulbTelefono1.Text = "";
                        ulbDireccion1.Text = "";
                        BtnConsultar.Enabled = false;
                    }


                    ////////LOGICA LLENADO DE GRILLA
                    //BdsDetalleFacturacion.Clear();
                    //BdsResumenDetalle.Clear();

                    ////CONSULTO LOS CARGOS DE LA FACTURA
                    ////String[] tipos1 = { "Int64" };
                    ////String[] campos1 = { "inservsusc" };
                    ////object[] valores1 = { TxtContrato.Text };
                    ////MessageBox.Show(TxtContrato.Text);
                    //DataTable Datos = general.cursorProcedure("LDC_PKTARIFATRANSITORIA.GetDatosLDC_DEPRTATT", 1, tipos, campos, valores);
                    //int totalFila = OgDetalleFactura.Rows.Count;
                    //if (Datos.Rows.Count > 0)
                    //{

                    //    System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                    //    for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                    //    {
                    //        BdsDetalleFacturacion.AddNew();
                    //        OgDetalleFactura.Rows[totalFila].Cells["factura"].Value = Datos.Rows[x].ItemArray[0].ToString();
                    //        OgDetalleFactura.Rows[totalFila].Cells["periodo"].Value = Datos.Rows[x].ItemArray[1].ToString();
                    //        OgDetalleFactura.Rows[totalFila].Cells["cuenta"].Value = Datos.Rows[x].ItemArray[2].ToString();
                    //        OgDetalleFactura.Rows[totalFila].Cells["concepto"].Value = Datos.Rows[x].ItemArray[3].ToString();
                    //        OgDetalleFactura.Rows[totalFila].Cells["causalcargo"].Value = Datos.Rows[x].ItemArray[4].ToString();
                    //        OgDetalleFactura.Rows[totalFila].Cells["nota"].Value = Datos.Rows[x].ItemArray[5].ToString();
                    //        OgDetalleFactura.Rows[totalFila].Cells["fecharegistro"].Value = Datos.Rows[x].ItemArray[6].ToString();
                    //        OgDetalleFactura.Rows[totalFila].Cells["signonota"].Value = Datos.Rows[x].ItemArray[7].ToString();
                    //        OgDetalleFactura.Rows[totalFila].Cells["valornota"].Value = Double.Parse(Datos.Rows[x].ItemArray[8].ToString());
                    //        totalFila++;
                    //    }

                    //    System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

                    //    BtnProcesar.Enabled = true;

                    //}

                    ////RESUMEN CONCEPTOS DE LA FACTURA
                    //String[] tipos1 = { "Int64" };
                    //String[] campos2 = { "inservsusc" };
                    //object[] valores3 = { TxtContrato.Text };
                    ////MessageBox.Show(TxtContrato.Text);
                    //Datos = general.cursorProcedure("LDC_PKTARIFATRANSITORIA.GetResumenConcepto", 1, tipos1, campos2, valores3);
                    //totalFila = OgResumenDetalle.Rows.Count;
                    //if (Datos.Rows.Count > 0)
                    //{

                    //    //System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor;

                    //    Double nuvalornota = 0;

                    //    for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                    //    {
                    //        BdsResumenDetalle.AddNew();
                    //        OgResumenDetalle.Rows[totalFila].Cells["concepto"].Value = Datos.Rows[x].ItemArray[0].ToString();
                    //        OgResumenDetalle.Rows[totalFila].Cells["valornota"].Value = Double.Parse(Datos.Rows[x].ItemArray[1].ToString());
                    //        nuvalornota = nuvalornota + Double.Parse(Datos.Rows[x].ItemArray[1].ToString());
                    //        totalFila++;
                    //    }
                    //    if (totalFila > 0)
                    //    {
                    //        BdsResumenDetalle.AddNew();
                    //        OgResumenDetalle.Rows[totalFila].Cells["concepto"].Value = "Total";
                    //        OgResumenDetalle.Rows[totalFila].Cells["valornota"].Value = nuvalornota;
                    //    }

                    //    //System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

                    //}
                    ///////FIN LOGICA LLENADO DE GRILLA

                    System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Arrow;

                }
            }
            catch
            {
            }
        }

        private void BtnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void BtnProcesar_Click(object sender, EventArgs e)
        {

            Int64 Validacion = 0;
            Double inuCliente = 0;
            DateTime idtFecha = DateTime.Now;
            DateTime idthoy = DateTime.Now;

            //Validacion de documento de solicituante
            if (String.IsNullOrEmpty(Cmbsolicitantetipodoc.Text))
            {
                MessageBox.Show("Tipo de Documento Invalido");
                Validacion = 1;
                Cmbsolicitantetipodoc.Focus();
            }
            else
            {
                if (String.IsNullOrEmpty(Txtsolicitantedoc.TextBoxValue))
                {
                    MessageBox.Show("Documento Invalido");
                    Validacion = 1;
                    Txtsolicitantedoc.Focus();
                }
                else
                {
                    if (DAL.DALLDCGCTT.GetValidaDocumento(Convert.ToInt64(Cmbsolicitantetipodoc.Value), Txtsolicitantedoc.TextBoxValue) == 0)
                    {
                        MessageBox.Show("El documento no es valido.");
                        Validacion = 1;
                        Txtsolicitantedoc.TextBoxValue = null;
                        Txtsolicitantedoc.Focus();
                    }
                }
            }

            if (String.IsNullOrEmpty(ulbServicio1.Text))
            {
                MessageBox.Show("Servicio no valido");
                Validacion = 1;
            }
            if (String.IsNullOrEmpty(CmbMediorecepcion.Text))
            {
                MessageBox.Show("Medio de recepcion no valido");
                Validacion = 1;
                CmbMediorecepcion.Focus();
            }
            if (String.IsNullOrEmpty(TxtObservacion.TextBoxValue))
            {
                MessageBox.Show("Observacion no valida");
                Validacion = 1;
                TxtObservacion.Focus();
            }

            if (String.IsNullOrEmpty(Tbfechasolicitud.TextBoxValue))
            {
                MessageBox.Show("Fecha Solicitud no valida");
                Validacion = 1;
                Tbfechasolicitud.Focus();
            }

            //MessageBox.Show(Convert.ToDateTime(Tbfechasolicitud.TextBox48042859Value).ToShortDateString());
            //MessageBox.Show(DateTime.Today.ToShortDateString());

            idtFecha = Convert.ToDateTime(Tbfechasolicitud.TextBoxValue);
            //MessageBox.Show(idtFecha.ToString());

            idthoy = DateTime.Today;
            //MessageBox.Show(idthoy.ToString());

            //MessageBox.Show("Fecha Corta idtFecha" + idtFecha.Date.ToString() + " - idthoy " + idthoy.Date.ToString());
            ////idthoy = ;

            if (idtFecha.Date > idthoy.Date)
            {
                MessageBox.Show("Fecha Solicitud no puede ser mayor a la fecha actual");
                Validacion = 1;
                Tbfechasolicitud.Focus();
            }
            
            //Validacion = 1;

            if (Validacion == 0)
            {
                Int64 OnuPackage_id;
                Int64 onuError;
                String osbError;

                inuCliente = DAL.DALLDCGCTT.GetValidaDocumento(Convert.ToInt64(Cmbsolicitantetipodoc.Value), Txtsolicitantedoc.TextBoxValue);
                idtFecha = Convert.ToDateTime(Tbfechasolicitud.TextBoxValue);
                general.PRGENTRAMCANTT(Convert.ToInt64(ulbServicio1.Text), Convert.ToInt64(CmbMediorecepcion.Value), TxtObservacion.TextBoxValue, inuCliente, idtFecha, out OnuPackage_id, out  onuError, out  osbError);

                //MessageBox.Show("Solicitud [" + OnuPackage_id + "] - Codigo Error [" + onuError + "] - Mensaje Error [" + osbError + "]");

                if (OnuPackage_id > 0)
                {
                    MessageBox.Show("Solicitud [" + OnuPackage_id + "] Generada con exito.");
                    OpenDataBase.Transaction.Commit();
                    this.Close();
                }
                else
                {
                    MessageBox.Show("Inconsistencia: Codigo Error [" + onuError + "] - Mensaje Error [" + osbError + "]");
                    TxtContrato.Text = "";
                    ulbServicio1.Text = "";
                    ulbNombre1.Text = "";
                    ulbTelefono1.Text = "";
                    ulbDireccion1.Text = "";
                    CmbMediorecepcion.Text = null;
                    TxtObservacion.TextBoxValue = null;
                    BtnConsultar.Enabled = false;
                    TxtContrato.Focus();
                    BdsDetalleFacturacion.Clear();
                    BdsResumenDetalle.Clear();
                    OpenDataBase.Transaction.Rollback();
                    BtnProcesar.Enabled = false;

                }
            }
        }

        private void Txtsolicitantedoc_Leave(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(Cmbsolicitantetipodoc.Text))
            {
                MessageBox.Show("Tipo de Documento Invalido");
                Cmbsolicitantetipodoc.Focus();
            }
            else
            {
                if (String.IsNullOrEmpty(Txtsolicitantedoc.TextBoxValue))
                {
                    MessageBox.Show("Documento Invalido");
                    Txtsolicitantedoc.Focus();
                }
                else
                {
                    if (DAL.DALLDCGCTT.GetValidaDocumento(Convert.ToInt64(Cmbsolicitantetipodoc.Value),Txtsolicitantedoc.TextBoxValue) == 0)
                    {
                        MessageBox.Show("El documento no es valido.");
                        Txtsolicitantedoc.TextBoxValue = null;
                        Txtsolicitantedoc.Focus();
                    }
                }
            }
        }

    }
}
