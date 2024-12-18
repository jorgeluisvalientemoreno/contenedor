using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using LODPDT.BL;
using LODPDT.Entities;
using Infragistics.Win.UltraWinGrid;

namespace LODPDT.UI
{
    public partial class FRM_LODPDT : OpenForm
    {

        Boolean inicio;
        BLGENERAL general = new BLGENERAL();
        /*String Col_boton_AAA = "Actualizar";
        String Col_boton_AAN = "NoActualizar";
        String Col_boton_AAC = "ActualizarSoloDeudor";
        String Col_boton_AAD = "ActualizarSoloCoDeudor";
        String Col_boton_ELA = "Autoriza";
        String Col_boton_ELN = "NoAutoriza";
        String Col_boton_ELR = "Revocado";*/
        //private static List<ListOfVal> actualizarDatos = new List<ListOfVal>();
        //private static List<ListOfVal> estadoLey = new List<ListOfVal>();

        public FRM_LODPDT()
        {
            InitializeComponent();
            inicio = true;
            ListaValores(inicio);
            inicio = false;
            //modificaciones forzadas al componente.
            //no importa que se modifiquen desde la herramienta igual las aplica
            og_datos.DisplayLayout.GroupByBox.Hidden = true;
            og_datos.DisplayLayout.UseFixedHeaders = false;
            //og_datos.DisplayLayout.Bands[0].Header.Appearance.TextHAlign = Infragistics.Win.HAlign.Center;
            //og_datos.DisplayLayout.Bands[0].Header.Appearance.TextVAlign = Infragistics.Win.VAlign.Middle;
            //definicion de botones
            /*
            UltraGridColumn btn_aaa = og_datos.DisplayLayout.Bands[0].Columns[Col_boton_AAA];
            btn_aaa.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
            UltraGridColumn btn_aan = og_datos.DisplayLayout.Bands[0].Columns[Col_boton_AAN];
            btn_aan.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
            UltraGridColumn btn_aac = og_datos.DisplayLayout.Bands[0].Columns[Col_boton_AAC];
            btn_aac.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
            UltraGridColumn btn_aad = og_datos.DisplayLayout.Bands[0].Columns[Col_boton_AAD];
            btn_aad.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
            UltraGridColumn btn_ela = og_datos.DisplayLayout.Bands[0].Columns[Col_boton_ELA];
            btn_ela.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
            UltraGridColumn btn_eln = og_datos.DisplayLayout.Bands[0].Columns[Col_boton_ELN];
            btn_eln.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;
            UltraGridColumn btn_elr = og_datos.DisplayLayout.Bands[0].Columns[Col_boton_ELR];
            btn_elr.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.Button;*/
            /*lista quemada
            actualizarDatos.Clear();
            //Lista de Actualizar Datos
            actualizarDatos.Add(new ListOfVal(" ", ""));
            actualizarDatos.Add(new ListOfVal("A", "Actualizar"));
            actualizarDatos.Add(new ListOfVal("N", "No Actualizar"));
            actualizarDatos.Add(new ListOfVal("D", "Actualizar Solo Deudor"));
            actualizarDatos.Add(new ListOfVal("C", "Actualizar Solo Codeudor"));
            //
            estadoLey.Clear();
            //Lista de Actualizar Datos
            estadoLey.Add(new ListOfVal(" ", ""));
            estadoLey.Add(new ListOfVal("A", "Autoriza"));
            estadoLey.Add(new ListOfVal("N", "No Autoriza"));
            estadoLey.Add(new ListOfVal("R", "Revoca"));
            //asignacion en la grilla actualizar estado
            OpenGridDropDown dropDowntb = new OpenGridDropDown();
            dropDowntb.DataSource = actualizarDatos;
            dropDowntb.ValueMember = "id";
            dropDowntb.DisplayMember = "descripcion";
            dropDowntb.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            og_datos.DisplayLayout.Bands[0].Columns["actualizarDatos"].ValueList = dropDowntb;
            og_datos.DisplayLayout.Bands[0].Columns["actualizarDatos"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //asignacion en la grilla estado de ley
            OpenGridDropDown dropDowntb1 = new OpenGridDropDown();
            dropDowntb1.DataSource = estadoLey;
            dropDowntb1.ValueMember = "id";
            dropDowntb1.DisplayMember = "descripcion";
            dropDowntb1.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            og_datos.DisplayLayout.Bands[0].Columns["estadoLey"].ValueList = dropDowntb1;
            og_datos.DisplayLayout.Bands[0].Columns["estadoLey"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            */
            //lista de Actualizar datos
            String[] tipos = { };
            String[] campos = { };
            object[] valores = { };
            DataTable actualizarDatos = general.cursorProcedure(BLConsultas.ListaActualizarDatos, 0, tipos, campos, valores);
            OpenGridDropDown dropDowntb = new OpenGridDropDown();
            dropDowntb.DataSource = actualizarDatos;
            dropDowntb.ValueMember = "ID";
            dropDowntb.DisplayMember = "DESCRIPTION";
            dropDowntb.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            og_datos.DisplayLayout.Bands[0].Columns["actualizarDatos"].ValueList = dropDowntb;
            og_datos.DisplayLayout.Bands[0].Columns["actualizarDatos"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //lista de ESTADOS DE DE LEY
            DataTable estadoLey = general.cursorProcedure(BLConsultas.ListaEstadosLey, 0, tipos, campos, valores);
            OpenGridDropDown dropDowntb1 = new OpenGridDropDown();
            dropDowntb1.DataSource = estadoLey;
            dropDowntb1.ValueMember = "ID";
            dropDowntb1.DisplayMember = "DESCRIPTION";
            dropDowntb1.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            og_datos.DisplayLayout.Bands[0].Columns["estadoLey"].ValueList = dropDowntb1;
            og_datos.DisplayLayout.Bands[0].Columns["estadoLey"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //lista de CAUSALEs
            DataTable causales = general.cursorProcedure(BLConsultas.ListaCausales, 0, tipos, campos, valores);
            OpenGridDropDown dropDowntb2 = new OpenGridDropDown();
            dropDowntb2.DataSource = causales;
            dropDowntb2.ValueMember = "CAUSAL_ID";
            dropDowntb2.DisplayMember = "DESCRIPTION";
            dropDowntb2.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            og_datos.DisplayLayout.Bands[0].Columns["causalLegalizacion"].ValueList = dropDowntb2;
            og_datos.DisplayLayout.Bands[0].Columns["causalLegalizacion"].Style = Infragistics.Win.UltraWinGrid.ColumnStyle.DropDownValidate;
            //campos de solo lectura
            og_datos.DisplayLayout.Bands[0].Columns["contrato"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["departamento"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["localidad"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["solicitud"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["estadoSolicitud"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["fechaVenta"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["orden"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["contratista"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["unidadOperativa"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["nombreCliente"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["apellidoCliente"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["identificacionCliente"].CellActivation = Activation.NoEdit;
            //og_datos.DisplayLayout.Bands[0].Columns["fechaRegistro"].CellActivation = Activation.NoEdit;
            //og_datos.DisplayLayout.Bands[0].Columns["fechaFinal"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["valorTotalVenta"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["valorFinanciar"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["cuotaInicial"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["pagare"].CellActivation = Activation.NoEdit;
            //og_datos.DisplayLayout.Bands[0].Columns["vendedor"].CellActivation = Activation.NoEdit;
            //og_datos.DisplayLayout.Bands[0].Columns["puntoVenta"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["nombreCodeudor"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["apellidoCodeudor"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["identificacionCodeudor"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["pagareUnico"].CellActivation = Activation.NoEdit;
            og_datos.DisplayLayout.Bands[0].Columns["estadoOT"].CellActivation = Activation.NoEdit;
        }

        public void ListaValores(Boolean comienzo)
        {
            String[] tipos = { };
            String[] campos = { };
            object[] valores = { };
            //PROVEEDORES
            DataTable DatosP = general.cursorProcedure(BLConsultas.ListaProveedores, 0, tipos, campos, valores);
            cmb_proveedor.DataSource = DatosP;
            cmb_proveedor.ValueMember = "ID";
            cmb_proveedor.DisplayMember = "DESCRIPCION";
            //DEPARTAMENTOS
            DataTable DatosD = general.cursorProcedure(BLConsultas.ListaDepartamentos, 0, tipos, campos, valores);
            cmb_departamento.DataSource = DatosD;
            cmb_departamento.ValueMember = "ID";
            cmb_departamento.DisplayMember = "DESCRIPCION";
            
        }

        private void cmb_proveedor_ValueChanged(object sender, EventArgs e)
        {
            if (!inicio)
            {
                String[] tipos = { "Int64" };
                String[] campos = { "inuProveedor" };
                object[] valores = { cmb_proveedor.Value };
                //UNIDADES OPERATIVAS
                cmb_unidadOperativa.DataSource = null;
                cmb_unidadOperativa.Value = "";
                DataTable DatosOU = general.cursorProcedure(BLConsultas.ListaOperatingUnit, 1, tipos, campos, valores);
                cmb_unidadOperativa.DataSource = DatosOU;
                cmb_unidadOperativa.ValueMember = "ID";
                cmb_unidadOperativa.DisplayMember = "DESCRIPCION";
            }
        }

        private void cmb_departamento_ValueChanged(object sender, EventArgs e)
        {
            if (!inicio)
            {
                String[] tipos = { "Int64" };
                String[] campos = { "inuDepartment" };
                object[] valores = { cmb_departamento.Value };
                //LOCALIDADES
                cmb_localidad.DataSource = null;
                cmb_localidad.Value = "";
                DataTable DatosOU = general.cursorProcedure(BLConsultas.ListaLocalidad, 1, tipos, campos, valores);
                cmb_localidad.DataSource = DatosOU;
                cmb_localidad.ValueMember = "ID";
                cmb_localidad.DisplayMember = "DESCRIPCION";
            }
        }

        private void btn_buscar_Click(object sender, EventArgs e)
        {
            if (txt_fechaInicial.TextBoxValue != null && txt_fechaFinal.TextBoxValue != null)
            {
                datosBindingSource.Clear();
                //
                //List<Entities.Datos> data = new List<Entities.Datos>();
                //String[] tipos = { "Date", "Date", "Int64", "Int64", "Int64", "Int64", "Int64", "Int64", "String" };
                String[] tipos = { "String", "String", "String", "String", "String", "String", "String", "String", "String" };
                String[] campos = { "isbsale_date", "isbfinal_date", "isbsupplier_id", "inuoper_unit", "isbdepartment", "isbrequi_approv_annulm", "isbcontrato", "isblocalidad", "isbpackageid" };
                object[] valores = { DateTime.Parse(txt_fechaInicial.TextBoxValue).ToString("dd/MM/yyyy"), DateTime.Parse(txt_fechaFinal.TextBoxValue).ToString("dd/MM/yyyy"), cmb_proveedor.Value, cmb_unidadOperativa.Value, cmb_departamento.Value, chk_soloVentas.Checked ? "Y" : "N", txt_contrato.TextBoxValue, cmb_localidad.Value, txt_solicitud.TextBoxValue };
                DataTable DatosOrdenes = general.cursorProcedure(BLConsultas.ConsultaOrdenes, 9, tipos, campos, valores);
                if (DatosOrdenes.Rows.Count > 0)
                {
                    for (int i = 0; i <= DatosOrdenes.Rows.Count - 1; i++)
                    {
                        //MessageBox.Show("registro: " + i);
                        Entities.Datos DataDatos = new Entities.Datos
                        {
                            Orden = (Int64)valor(DatosOrdenes.Rows[i].ItemArray[0].ToString(), "Int64"),//order id
                            Solicitud = (Int64)valor(DatosOrdenes.Rows[i].ItemArray[1].ToString(), "Int64"),//package id
                            Contrato = (Int64)valor(DatosOrdenes.Rows[i].ItemArray[2].ToString(), "Int64"),//contrato
                            NombreCliente = (String)valor(DatosOrdenes.Rows[i].ItemArray[3].ToString(), "String"),//nombre del cliente
                            NuevoNombreCliente = (String)valor(DatosOrdenes.Rows[i].ItemArray[4].ToString(), "String"),//nuevo nombre del cliente
                            //
                            ApellidoCliente = (String)valor(DatosOrdenes.Rows[i].ItemArray[29].ToString(), "String"),
                            NuevoApellidoCliente = (String)valor(DatosOrdenes.Rows[i].ItemArray[30].ToString(), "String"),
                            //
                            IdentificacionCliente = (String)valor(DatosOrdenes.Rows[i].ItemArray[5].ToString(), "String"),//identificacion del cliente
                            NuevoIdentificacionCliente = (String)valor(DatosOrdenes.Rows[i].ItemArray[6].ToString(), "String"),//nueva identificacion del cliente
                            FechaVenta = (DateTime)valor(DatosOrdenes.Rows[i].ItemArray[7].ToString(), "DateTime"),//fecha de venta
                            FechaRegistro = (DateTime)valor(null, "DateTime"),//(DateTime)valor(DatosOrdenes.Rows[i].ItemArray[8].ToString(), "DateTime"),//request date
                            FechaFinal = (DateTime?)valor(DatosOrdenes.Rows[i].ItemArray[9].ToString(), "DateTime?"),//fecha final
                            ValorTotalVenta = (Int64)valor(DatosOrdenes.Rows[i].ItemArray[10].ToString(), "Int64"),//valor total de venta
                            ValorFinanciar = (Int64)valor(DatosOrdenes.Rows[i].ItemArray[11].ToString(), "Int64"),//valor a financiar
                            CuotaInicial = (Double)valor(DatosOrdenes.Rows[i].ItemArray[12].ToString(), "Double"),//cuota inicial
                            Pagare = (String)valor(DatosOrdenes.Rows[i].ItemArray[13].ToString(), "String"),//pagare
                            Contratista = (String)valor(DatosOrdenes.Rows[i].ItemArray[14].ToString(), "String"),//contratista
                            Vendedor = (String)valor("", "String"),//(String)valor(DatosOrdenes.Rows[i].ItemArray[15].ToString(), "String"),//vendedor
                            UnidadOperativa = (String)valor(DatosOrdenes.Rows[i].ItemArray[16].ToString(), "String"),//operating unit
                            PuntoVenta = (String)valor("", "String"),//(String)valor(DatosOrdenes.Rows[i].ItemArray[17].ToString(), "String"),//punto de venta
                            NombreCodeudor = (String)valor(DatosOrdenes.Rows[i].ItemArray[18].ToString(), "String"),//nombre codeudor
                            NuevoNombreCodeudor = (String)valor(DatosOrdenes.Rows[i].ItemArray[19].ToString(), "String"),//nuevo nombre codeudor
                            ApellidoCodeudor = (String)valor(DatosOrdenes.Rows[i].ItemArray[20].ToString(), "String"),//apellido codeudor
                            NuevoApellidoCodeudor = (String)valor(DatosOrdenes.Rows[i].ItemArray[21].ToString(), "String"),//nuevo apellido codeudor
                            IdentificacionCodeudor = (String)valor(DatosOrdenes.Rows[i].ItemArray[22].ToString(), "String"),// identificacion codeudor
                            NuevoIdentificacionCodeudor = (String)valor(DatosOrdenes.Rows[i].ItemArray[23].ToString(), "String"),//nueva identificacion codeudor
                            PagareUnico = (String)valor(DatosOrdenes.Rows[i].ItemArray[24].ToString(), "String"),//pagare unico
                            Departamento = (String)valor(DatosOrdenes.Rows[i].ItemArray[25].ToString(), "String"),//Departamento
                            Localidad = (String)valor(DatosOrdenes.Rows[i].ItemArray[26].ToString(), "String"),//Localidad
                            EstadoSolicitud = (String)valor(DatosOrdenes.Rows[i].ItemArray[27].ToString(), "String"),//estado de la solicitud de venta
                            EstadoOT = (String)valor(DatosOrdenes.Rows[i].ItemArray[28].ToString(), "String"),//estado OT
                            //botones
                            /*Actualizar = "Aplicar",
                            NoActualizar = "Aplicar",
                            ActualizarSoloDeudor = "Aplicar",
                            ActualizarSoloCoDeudor = "Aplicar",
                            Autoriza = "Aplicar",
                            NoAutoriza = "Aplicar",
                            Revocado = "Aplicar",*/
                            ActualizarDatos = "",
                            EstadoLey = "",
                            //faltantes
                            CausalLegalizacion = "",
                            Observacion = "",
                            Seleccion = false
                        };
                        //data.Add(DataDatos);
                        datosBindingSource.Add(DataDatos);
                    }
                }
                else
                {
                    general.mensajeERROR("Esta Consulta no obtuvo resultados.");
                }
                //
                //datosBindingSource.Add(data);
                //
            }
            else
            {
                general.mensajeERROR("Debe ingresar un Rango de Fechas.");
            }
        }   
     
        Object valor(Object objeto, String tipo)
        {
            //Object envio;
            if (objeto == null)
            {
                switch (tipo)
                {
                    case "String":
                        return "";
                        break;
                    case "Int64":
                        return Int64.Parse("0");
                        break;
                    case "Double":
                        return Double.Parse("0");
                        break;
                    case "DateTime":
                        return DateTime.Parse("01/01/0001 00:00:00");
                        break;
                    case "DateTime?":
                        return null;
                    default:
                        return "";
                        break;
                }
            }
            else
            {
                switch (tipo)
                {
                    case "String":
                        return objeto;
                        break;
                    case "Int64":
                        {
                            if(objeto.ToString() == "")
                                return Int64.Parse("0");
                            else
                                return Int64.Parse(objeto.ToString());
                        }
                        break;
                    case "Double":
                        {
                            if (objeto.ToString() == "")
                                return Double.Parse("0");
                            else
                                return Double.Parse(objeto.ToString());
                        }
                        break;
                    case "DateTime":
                        {
                            if (objeto.ToString() == "")
                                return DateTime.Parse("01/01/0001 00:00:00");
                            else
                                return DateTime.Parse(objeto.ToString());
                        }
                        break;
                    case "DateTime?":
                        {
                            if (objeto.ToString() == "")
                                return null;
                            else
                                return DateTime.Parse(objeto.ToString());
                        }
                        break;
                    default:
                        return "";
                        break;
                }
            }
            //return envio;
        }

        private void og_datos_Error(object sender, ErrorEventArgs e)
        {
            /*if (e.ErrorType == ErrorType.Data)
            {
                e.Cancel = true;
            }*/
        }

        private void btn_exportar_Click(object sender, EventArgs e)
        {
            if (og_datos.Rows.Count > 0)
            {
                sfd_guardar.FileName = "LODPD." + DateTime.Now.ToString("dd.MM.yy.HH.mm.ss");
                sfd_guardar.ShowDialog();
            }
        }

        private void sfd_guardar_FileOk(object sender, CancelEventArgs e)
        {
            try
            {
                uee_exportar.Export(og_datos, sfd_guardar.FileName);
                general.mensajeOk("Documento Exportado a Excel con Exito");
            }
            catch(Exception error)
            {
                general.mensajeERROR("Error exportando el Informa a Excel");
            }
        }

        private void btn_cancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btn_limpiar_Click(object sender, EventArgs e)
        {
            txt_fechaInicial.TextBoxValue = "";
            txt_fechaFinal.TextBoxValue = "";
            cmb_proveedor.Value = "";
            //cmb_unidadOperativa.Value
            cmb_departamento.Value = "";
            txt_contrato.TextBoxValue = "";
            //cmb_localidad.Value
            txt_solicitud.TextBoxValue = "";
            chk_soloVentas.Checked = false;
            datosBindingSource.Clear();
            txt_codigoAgrupador.TextBoxValue = "";
            txt_codigoAgrupador.TextBoxValue = general.ConsecutivoAgrupador();
        }

        private void FRM_LODPDT_Load(object sender, EventArgs e)
        {
            og_datos.DisplayLayout.Bands[0].Columns["observacion"].CellActivation = Activation.NoEdit;
            txt_codigoAgrupador.TextBoxValue = general.ConsecutivoAgrupador();
        }

        private void og_datos_DoubleClick(object sender, EventArgs e)
        {
            
        }

        private void btn_procesar_Click(object sender, EventArgs e)
        {
            int respuesta = validar();
            if (respuesta == 0)
            {
                String[] tipos = { "Int64", "String", "String", "String", "Int64", "Int64", "String", "String", "String", "String", "String", "String", "String", "String", "String" };
                String[] campos = { "inuIdOrder", "inuCodEstLey", "isbActualizaDatos", "isbComment", "inucausal", "nuGroupId", "nuevoNombreCliente", "nuevoApellidoCliente", "nuevaIdCliente", "oldIdCliente", "nuevoNombreCodeudor", "nuevoApellidoCodeudor", "nuevaIdCodeudor", "oldIdCodeudor", "solicitud" };
                String ordenesE = "";
                String errorO = "";
                String error1 = "";
                Int64 nOrdenes = 0;
                Int64 nErrores = 0;
                Int64 nExitosas = 0;
                for (int i = 0; i <= og_datos.Rows.Count - 1; i++)
                {
                    errorO = "";
                    error1 = "";
                    if (og_datos.Rows[i].Cells["seleccion"].Value.ToString() == "True")
                    {
                        nOrdenes++;
                        /*object valor = og_datos.Rows[i].Cells["orden"].Value;
                        if (valor == null)
                        {
                            valor = 2;
                        }*/
                        object[] valores = { og_datos.Rows[i].Cells["orden"].Value, og_datos.Rows[i].Cells["estadoLey"].Value, og_datos.Rows[i].Cells["actualizarDatos"].Value, og_datos.Rows[i].Cells["observacion"].Value, og_datos.Rows[i].Cells["causalLegalizacion"].Value, txt_codigoAgrupador.TextBoxValue, og_datos.Rows[i].Cells["nuevoNombreCliente"].Value, og_datos.Rows[i].Cells["nuevoApellidoCliente"].Value, og_datos.Rows[i].Cells["nuevoIdentificacionCliente"].Value, og_datos.Rows[i].Cells["identificacionCliente"].Value, og_datos.Rows[i].Cells["nuevoNombreCodeudor"].Value, og_datos.Rows[i].Cells["nuevoApellidoCodeudor"].Value, og_datos.Rows[i].Cells["nuevoIdentificacionCodeudor"].Value, og_datos.Rows[i].Cells["identificacionCodeudor"].Value, og_datos.Rows[i].Cells["solicitud"].Value };
                        general.executeProcedure(BLConsultas.LegalizarOT, 15, tipos, campos, valores, out errorO, out error1);
                        if (errorO != "0")
                        {
                            nErrores++;
                            ordenesE = ordenesE + "[Orden: " + og_datos.Rows[i].Cells["orden"].Value.ToString() + "] [Error: " + error1 + "] ";
                        }
                    }
                }
                nExitosas = nOrdenes - nErrores;
                if (ordenesE == "")
                {
                    general.mensajeOk("Proceso Finalizado. " + nOrdenes + " Orden(es) Legalizada(s).");
                }
                else
                {
                    general.mensajeERROR("El proceso termino con Errores [" + nExitosas + " de " + nOrdenes + " - Legalizada(s)]. " + nErrores.ToString() + " Orden(es) no fue(ron) Legalizada(s): " + ordenesE);
                }
                //
                txt_fechaInicial.TextBoxValue = "";
                txt_fechaFinal.TextBoxValue = "";
                cmb_proveedor.Value = "";
                //cmb_unidadOperativa.Value
                cmb_departamento.Value = "";
                txt_contrato.TextBoxValue = "";
                //cmb_localidad.Value
                txt_solicitud.TextBoxValue = "";
                chk_soloVentas.Checked = false;
                datosBindingSource.Clear();
                txt_codigoAgrupador.TextBoxValue = "";
                txt_codigoAgrupador.TextBoxValue = general.ConsecutivoAgrupador();
            }
            else
            {
                switch(respuesta)
                {
                    case 1:
                        {
                            general.mensajeERROR("Revise la Información - Actualizar Datos, Estados de Ley y Causales son Obligatorias");
                        }
                        break;
                    case 2:
                        {
                            general.mensajeERROR("Revise la Información - Para Actualizar los datos de un registro debe diligenciar todos los campos editables del Registro seleccionado");
                        }
                        break;
                    case 3:
                        {}
                        break;
                    case 4:
                        {
                            general.mensajeERROR("Revise la Información - Para Actualizar los datos de un Cliente Seleccionado debe diligenciar todos los campos editables correspondientes al Cliente");
                        }
                        break;
                    case 5:
                        {
                            general.mensajeERROR("Revise la Información - Para Actualizar los datos de un Codeudor Seleccionado debe diligenciar todos los campos editables correspondientes al Codeudor");
                        }
                        break;
                    case 6:
                        {
                            general.mensajeERROR("Revise la Información - No selecciono ninguna Orden");
                        }
                        break;
                }
            }
        }

        public int validar()
        {
            int contT = 0;
            int contEL = 0;
            for (int i = 0; i <= og_datos.Rows.Count - 1; i++)
            {
                if (og_datos.Rows[i].Cells["seleccion"].Value.ToString() == "True")
                {
                    contT++;
                    if (og_datos.Rows[i].Cells["actualizarDatos"].Value.ToString() != "" && og_datos.Rows[i].Cells["estadoLey"].Value.ToString() != "" && og_datos.Rows[i].Cells["causalLegalizacion"].Value.ToString() != "")
                    {
                        contEL++;
                    }
                    else
                    {
                        switch (og_datos.Rows[i].Cells["actualizarDatos"].Value.ToString())
                        {
                            case "1":
                                {
                                    if (og_datos.Rows[i].Cells["nuevoNombreCliente"].Value.ToString() != "" && og_datos.Rows[i].Cells["nuevoApellidoCliente"].Value.ToString() != "" && og_datos.Rows[i].Cells["nuevoIdentificacionCliente"].Value.ToString() != "" && og_datos.Rows[i].Cells["nuevoNombreCodeudor"].Value.ToString() != "" && og_datos.Rows[i].Cells["nuevoApellidoCodeudor"].Value.ToString() != "" && og_datos.Rows[i].Cells["nuevoIdentificacionCodeudor"].Value.ToString() != "")
                                    { }
                                    else
                                    {
                                        return 2;
                                    }
                                }
                                break;
                            case "2":
                                {
                                    //return 3;
                                }
                                break;
                            case "3":
                                {
                                    if (og_datos.Rows[i].Cells["nuevoNombreCliente"].Value.ToString() != "" && og_datos.Rows[i].Cells["nuevoApellidoCliente"].Value.ToString() != "" && og_datos.Rows[i].Cells["nuevoIdentificacionCliente"].Value.ToString() != "")
                                    { }
                                    else
                                    {
                                        return 4;
                                    }
                                }
                                break;
                            case "4":
                                {
                                    if (og_datos.Rows[i].Cells["nuevoNombreCodeudor"].Value.ToString() != "" && og_datos.Rows[i].Cells["nuevoApellidoCodeudor"].Value.ToString() != "" && og_datos.Rows[i].Cells["nuevoIdentificacionCodeudor"].Value.ToString() != "")
                                    { }
                                    else
                                    {
                                        return 5;
                                    }
                                }
                                break;
                        }
                    }
                }
            }
            if (contT == 0)
            {
                return 6;
            }
            if (contT > contEL)
            {
                return 1;
            }
            return 0;
        }

        private void og_datos_DoubleClickCell(object sender, DoubleClickCellEventArgs e)
        {
            try
            {
                //general.mensajeOk(og_datos.ActiveCell.Column.ToString());
                if (og_datos.ActiveCell.Column.ToString() == "Observacion")
                {
                    //LLAMO LA FORMA DE LAS OBSERVACIONES Y ASIGNO LOS VALORES EN LA GRILLA Y LOS REASIGNO A LA CELDA
                    frm_texto forma = new frm_texto("Observacion", "Ingresar", 2000, og_datos.Rows[og_datos.ActiveCell.Row.Index].Cells["observacion"].Value.ToString());
                    forma.ShowDialog();
                    og_datos.Rows[og_datos.ActiveCell.Row.Index].Cells["observacion"].Value = forma.texto;
                }
            }
            catch (Exception error)
            { }
        }

    }
}
