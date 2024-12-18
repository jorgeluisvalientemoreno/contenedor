using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.VALORECLAMO.Entities;

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
    public partial class LDRECUS : OpenForm
    {

        //VARIABLES GENERALES DEL FORMULARIO
        BLGENERAL general = new BLGENERAL(); //Procedimiento Generales
        BLLDVALREC _blldvalrec = new BLLDVALREC(); //Procedimientos de BLLDVALREC
        String solicitudSeleccionada = ""; //Determino la Factura que se selcciona
        Int64 SubscriptionId = 0; //Contrato
        String identificadorCliente = ""; //Identtificador del Cliente Basado en el Contrato Sumnistrado
        int filaSeleccionada = 0; //fila en la que se esta ubicado
        String CodigoRespaldo = ""; //Determina el ultimo codigo de Reclamo seleccionado por el usuario
        //VARIABLE PARA EL INICIO DEL FORMULARIO, SOLO SE CARGA FALSO HASTA QUE TODO YA ESTA EN LA FORMA
        Boolean inicio = true;
        Boolean bloqCellChange = false;
        //10.08.17 COLUMNAS DEL MODELO EN EL DTGDATOS
        String a = "cuenta"; //ANTES 1
        String b = "product"; //ANTES 2
        String c = "concept"; //ANTES 3
        String d = "signed"; //ANTES 4
        String e = "VLR_FACTURADO"; //ANTES 5
        String f = "CAUSAL";
        String g = "DOCUMENTO";
        String h = "CONSECUTIVO";
        String i = "VLR_RECLAMADO"; //ANTES 6
        String j = "factura"; //ANTES 7
        String k = "ano"; //ANTES 8
        String l = "mes"; //ANTES 9
        String m = "saldo"; //ANTES 10
        String n = "fecha"; //ANTES 11
        String o = "VLRTOTAL";
        String p = "editable";//columna para saber si estara excluido (S si estara incluido/N no estara incluido)
        String q = "concepoblig";//13.10.17 columna para saber si cuando se selcciona es obligatorio editar
        String r = "unit";//13.10.17 columna para manejar unidades
        String s = "solicitud";//22.02.19 Columna de Solicitud
        String t = "tipoproducto";//CASO 275 Nuevo campo
        String u = "unitreclamadas";//CASO 275 Nuevo campo Unidades Reclamadas
        //22.02.19 variable de identificaion unica
        int vId = 0;
        DataTable solicitudOrigen;
        int tipoReclamo = 0;
        //modificacion 15.05.19
        String NumInteraccion = "";
        String conceptoConsumo = "";
        String alertaAdv = "";

        //OSF-96
        String sbReclamoUnico = "N";
        String sbExiteCliente = "-1";
        //////////////////////////////////

        /// <summary>
        /// CONSTRUCTOR DE LA FORMA LDVALREC
        /// </summary>
        /// <param name="subscriptionId">CONTRATO SELECCIONADO</param>
        /// <param name="DataLDVALREC">DATOS DEL CONTRATO SELECCIONADO</param>
        public LDRECUS(Int64 subscriptionId, dataLDVALREC DataLDVALREC)
        {
            InitializeComponent();
            //INICIO DE CODIGO DEL EVENTO
            SubscriptionId = subscriptionId;
            //modificacion 15.05.19
            String[] pa1 = new string[] { "Int64" };
            String[] pa2 = new string[] { "inuSusc" };
            String[] pa3 = new string[] { SubscriptionId.ToString() };
            NumInteraccion = general.valueReturn(BLConsultas.SoporteInteraccion, 1, pa1, pa2, pa3, "Int64").ToString();
            if (NumInteraccion == "-1")
            {
                general.mensajeERROR("No se instació número de intección, favor validar");
                this.Close();
            }
            txt_iteraccion.TextBoxValue = NumInteraccion;
            conceptoConsumo = general.getParam("COD_CONCEPTO_CONSUMO", "Int64").ToString();
            alertaAdv = general.getParam("ALERT_VALRECL_SELECT", "String").ToString();
            //CARGA DE LISTAS
            ListasValores(inicio);
            //IMPLEMENTACION DE CAMPOS PRINCIPALES
            txt_dateregister.TextBoxValue = DateTime.Now.ToString();
            txt_funcionario.TextBoxValue = DataLDVALREC.funcionario;
            txt_puntoatencion.TextBoxValue = DataLDVALREC.puntoatencion;
            cmb_solicitantetipodoc.Value = DataLDVALREC.solicitantetipodoc;
            txt_solicitantedoc.TextBoxValue = DataLDVALREC.solicitantedoc;
            txt_nombre.TextBoxValue = DataLDVALREC.nombre;
            oab_direccionrespuesta.Address_id = DataLDVALREC.direccionrespuesta.ToString();
            identificadorCliente = DataLDVALREC.identificadorCliente;
            //ASIGNO QUE LLAMA EL FORMULARIO CARGO TODOS LOS COMPONENTES
            inicio = false;
            //Random rnd = new Random();
            vId = 999999999;// rnd.Next(100000, 999999);
            op_atach.ObjectId = vId;
            op_atach.LevelName = "RECLAMO";
            
            //OSF-96
            sbReclamoUnico = general.getParam("RECLAMO_UNICO", "String").ToString();
            ////////////////////////////////
        }

        /// <summary>
        /// ASIGNO LOS VALORES A LAS LISTAS DE VALORES Y LOS COMBOS CORRESPONDIENTES
        /// </summary>
        /// <param name="comienzo">SI SE INGRESA POR PRIMERA VEZ SE ASIGNA EL TIPO DE DOCUMENTO DE LO CONTRARIO NO</param>
        void ListasValores(Boolean comienzo)
        {
            //LISTA DE VALORES DE TIPO DE DOCUMENTOS
            if (comienzo)
            {
                DataTable identType = general.getValueList(BLConsultas.TipoDocumentoC);
                cmb_solicitantetipodoc.DataSource = identType;
                cmb_solicitantetipodoc.ValueMember = "CODIGO";
                cmb_solicitantetipodoc.DisplayMember = "DESCRIPCION";
            }
            //LISTA DE VALORES CAUSALES
            if (comienzo == false)
            {
                ohl_causal.Select_Statement = string.Join(string.Empty, new string[] { });
                ohl_causal.Value = "";
            }
            ohl_causal.Select_Statement = string.Join(string.Empty, new string[] { BLConsultas.CausalesReclamoReposicion });
            //LISTA DE VALORES DE MEDIOS DE RECEPCION
            //DataTable medioRecep = general.getValueList(BLConsultas.MedioRecepcion);
            //if (comienzo == false)
            //{
            //    cmb_mediorecepcion.DataSource = null;
            //    cmb_mediorecepcion.Value = "";
            //}
            //cmb_mediorecepcion.DataSource = medioRecep;
            //cmb_mediorecepcion.ValueMember = "CODIGO";
            //cmb_mediorecepcion.DisplayMember = "DESCRIPCION";
            DataTable medioRecep = general.cursorProcedure(BLConsultas.MedioRecepcion, 0, null, null, null);
            if (comienzo == false)
            {
                cmb_mediorecepcion.DataSource = null;
                cmb_mediorecepcion.Value = "";
            }
            cmb_mediorecepcion.DataSource = medioRecep;
            cmb_mediorecepcion.ValueMember = "ID";
            cmb_mediorecepcion.DisplayMember = "DESCRIPTION";
            //LISTADO DE SOLICITUDES DE RECLAMO
            if (comienzo)
            {
                //DataTable solicitudOrigen = general.getValueList(BLConsultas.SolicitudesReclamo.Replace("&subscripcion&", SubscriptionId.ToString()));
                //Cambio de lista 07.02.19
                String[] tipos = { "Int64", "Int64" };
                String[] campos = { "inucontrato", "inuSuscriber" };
                object[] valores = { SubscriptionId, "" };
                solicitudOrigen = general.cursorProcedure(BLConsultas.SolicitudesReclamo, 2, tipos, campos, valores);
                //
                cmb_solicitud.DataSource = solicitudOrigen;
                cmb_solicitud.ValueMember = "Solicitud";
                cmb_solicitud.DisplayMember = "Solicitud";
            }
            //LISTA DE VALORES RESPUESTAS INMEDIATAS
            if (comienzo)
            {
                String[] tipos = { "Int64" };
                String[] campos = { "inuPackage_type" };
                object[] valores = { "100337" };
                DataTable Datos = general.cursorProcedure(BLConsultas.RespuestaInmediata, 1, tipos, campos, valores);
                oc_respuestarap.DataSource = Datos;
            }
        }

        private void tsb_eliminar_Click(object sender, EventArgs e)
        {
            //ELIMINO LAS FILAS SELECCIONADAS EN LA GRILLA
            int totalFila = og_cargos.Rows.Count;
            for (int j = totalFila - 1; j >= 0; j--)
            {
                if (og_cargos.Rows[j].Cells[0].Value.ToString() == "True")
                {
                    og_cargos.Rows[j].Delete(false);
                }
            }
            //ACTUALIZO EL CAMPO DE VALOR RECLAMADO
            actualizarReclamo();
            //
            if (og_cargos.Rows.Count == 0)
            {
                pn_grilla.Visible = false;
                pn_lista.Visible = false;
                tipoReclamo = 0;
            }
        }

        /// <summary>
        /// ACTUALIZA EL TOTAL DEL RECLAMO A PARTIR DE LOS VALORES DE RECLAMO INGRESADOS EN LOS CARGOS DE LAS FACTURAS
        /// </summary>
        private void actualizarReclamo()
        {
            //CALCULO EL TOTAL DE FILAS
            int totalFila = og_cargos.Rows.Count;
            Double valorReclamado = 0;
            Double valorEvaluado = 0;
            //RECORRO LA GRILLA PARA VALIDAR LOS VALORES REGISTRADOS
            for (int y = 0; y <= totalFila - 1; y++)
            {
                //13.10.17 se reviso el caso de valores que no se marcan
                valorEvaluado = Double.Parse(og_cargos.Rows[y].Cells[i].Value.ToString());
                if (valorEvaluado == 0 && og_cargos.Rows[y].Cells[q].Value.ToString() == "N")
                {
                    valorEvaluado = Double.Parse(og_cargos.Rows[y].Cells[e].Value.ToString());
                }
                //SE VALIDA SI ESTA SELECCIONADO Y SI ES UN CONCEPTO ELEGIBLE 22.09.17
                //if ((og_cargos.Rows[y].Cells[0].Value.ToString() == "True" || valorEvaluado > 0) && og_cargos.Rows[y].Cells[p].Value.ToString() == "S")
                //modificado 16.05.19
                if (og_cargos.Rows[y].Cells[0].Value.ToString() == "True" && og_cargos.Rows[y].Cells[p].Value.ToString() == "S")
                {
                    switch (og_cargos.Rows[y].Cells[d].Value.ToString())
                    {
                        case "DB":
                        case "SA":
                        case "AP":
                        case "TS":
                            {
                                valorReclamado += valorEvaluado;
                            }
                            break;
                        case "CR":
                        case "AS":
                        case "PA":
                        case "NS":
                        case "ST":
                            {
                                valorReclamado -= valorEvaluado;
                            }
                            break;
                    }
                }
            }
            //ASIGNO EL TOTAL RECLAMADO CALCULADO
            txt_valorReclamado.TextBoxValue = valorReclamado.ToString();
            if (valorReclamado < 0)
            {
                txt_valorReclamado.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                txt_valorReclamado.ForeColor = System.Drawing.Color.Black;
            }
        }

        private void btn_proyectar_Click(object sender, EventArgs e)
        {
            //ASIGNO LA FECHA SELECCIONADA EN LA COLUMNA DE FECHAS DE RECLAMO
            //10.08.17 YA NO SE ASIGNA LA FECHA DE LA FORMA
            /*int totalFila = dtg_cargos.Rows.Count;
            for (int j = 0; j <= totalFila - 1; j++)
            {
                dtg_cargos.Rows[j].Cells[11].Value = txt_dateregister.TextBoxValue;
            }*/
            //CARGO EL FORMULARIO DE PROYECTAR
            //13.10.17 validacion conceptos valores obligatorios
            String mensajeError = "";
            Boolean entro = false;
            for (int x = 0; x <= og_cargos.Rows.Count - 1; x++)
            {
                Double valorReclamo = 0;
                valorReclamo = Double.Parse(og_cargos.Rows[x].Cells[i].Value.ToString());
                if (og_cargos.Rows[x].Cells[0].Value.ToString() == "True" && og_cargos.Rows[x].Cells[p].Value.ToString() == "S" && valorReclamo == 0 && og_cargos.Rows[x].Cells[q].Value.ToString() == "S")
                {
                    entro = true;
                    if (mensajeError != "")
                    {
                        mensajeError += ", ";
                    }
                    mensajeError += "Cuenta: " + og_cargos.Rows[x].Cells[a].Value.ToString() + " - Consecutivo: " + og_cargos.Rows[x].Cells[h].Value.ToString();
                }
            }
            if (entro)
            {
                general.mensajeERROR("Los Conceptos detallados [ " + mensajeError + " ] deben llevar un Valor Reclamado definido por el Usuario para poder Proyectarse");
            }
            else
            {
                //CARGO EL FORMULARIO DE PROYECTAR
                frm_proyectar proyectar = new frm_proyectar(og_cargos, "2", null);
                proyectar.ShowDialog();
            }
        }

        private void LDVALREC_Load(object sender, EventArgs ef)
        {
            //ESTILOS DE LAS COLUMNAS PRINCIPALES
            og_cargos.DisplayLayout.GroupByBox.Hidden = true;
            og_cargos.DisplayLayout.UseFixedHeaders = false;
            og_cargos.DisplayLayout.Bands[0].Columns[a].CellActivation = Activation.NoEdit;
            og_cargos.DisplayLayout.Bands[0].Columns[b].CellActivation = Activation.NoEdit;
            og_cargos.DisplayLayout.Bands[0].Columns[c].CellActivation = Activation.NoEdit;
            og_cargos.DisplayLayout.Bands[0].Columns[d].CellActivation = Activation.NoEdit;
            og_cargos.DisplayLayout.Bands[0].Columns[e].CellActivation = Activation.NoEdit;
            og_cargos.DisplayLayout.Bands[0].Columns[e].Format = "$ #,##0.00";
            og_cargos.DisplayLayout.Bands[0].Columns[e].CellAppearance.TextHAlign = HAlign.Right;
            og_cargos.DisplayLayout.Bands[0].Columns[f].CellActivation = Activation.NoEdit;
            og_cargos.DisplayLayout.Bands[0].Columns[g].CellActivation = Activation.NoEdit;
            og_cargos.DisplayLayout.Bands[0].Columns[h].CellActivation = Activation.NoEdit;
            og_cargos.DisplayLayout.Bands[0].Columns[i].Format = "$ #,##0.00";
            og_cargos.DisplayLayout.Bands[0].Columns[i].CellAppearance.TextHAlign = HAlign.Right;
            og_cargos.DisplayLayout.Bands[0].Columns[j].Hidden = true;
            og_cargos.DisplayLayout.Bands[0].Columns[k].Hidden = true;
            og_cargos.DisplayLayout.Bands[0].Columns[l].Hidden = true;
            og_cargos.DisplayLayout.Bands[0].Columns[m].Hidden = true;
            og_cargos.DisplayLayout.Bands[0].Columns[n].Hidden = true;
            og_cargos.DisplayLayout.Bands[0].Columns[o].Hidden = true;
            //se agrego ocualtamiento de columna 22.09.17
            og_cargos.DisplayLayout.Bands[0].Columns[p].Hidden = true;
            og_cargos.DisplayLayout.Bands[0].Columns[0].Width = 20;
            //se agrego ocualtamiento de columna para conceptos obligatorios 13.10.17
            og_cargos.DisplayLayout.Bands[0].Columns[q].Hidden = true;
            //se agrego la no edicion de las unidades
            og_cargos.DisplayLayout.Bands[0].Columns[r].CellActivation = Activation.NoEdit;
            //22.02.19 columna de solicitud
            og_cargos.DisplayLayout.Bands[0].Columns[s].CellActivation = Activation.NoEdit;
            //Se coloca en NO editable nuevo campo CASO 275
            og_cargos.DisplayLayout.Bands[0].Columns[t].Hidden = true;
            og_cargos.DisplayLayout.Bands[0].Columns[u].Hidden = true;
        }

        /// <summary>
        /// VALIDAR SI LOS CAMPOS OBLIGATORIOS HAN SIDO SELECCIONADOS
        /// </summary>
        /// <returns>TRUE: SI SE HAN INGRESADO LOS VALORES OBLIGATORIOS, FALSE: SI ALGUNO NO HA SIDO INGRESADO</returns>
        Boolean validar()
        {
            //VALIDACION DE LA FECHA
            if (String.IsNullOrEmpty(txt_dateregister.TextBoxValue))
            {
                general.mensajeERROR("La Fecha de Registro es Obligatoria");
                txt_dateregister.Focus();
                return false;
            }
            //VALIDACION DEL MEDIO DE RECEPCION
            if (String.IsNullOrEmpty(cmb_mediorecepcion.Text))
            {
                general.mensajeERROR("El Medio de Recepción es Obligatorio");
                cmb_mediorecepcion.Focus();
                return false;
            }
            //VALIDACION DE LA OBSERVACION
            if (String.IsNullOrEmpty(txt_observacion.TextBoxValue))
            {
                general.mensajeERROR("La Observación es Obligatoria");
                txt_observacion.Focus();
                return false;
            }
            //VALIDACION DE LA CAUSAL
            if (String.IsNullOrEmpty(ohl_causal.TextValue))
            {
                general.mensajeERROR("La Causal es Obligatoria");
                ohl_causal.Focus();
                return false;
            }
            //VALIDACION DEL AREA CAUSANTE
            if (String.IsNullOrEmpty(cmb_areacausante.Text))
            {
                general.mensajeERROR("El Área Causante es Obligatoria");
                cmb_areacausante.Focus();
                return false;
            }
            //VALIDACION DEL AREA QUE GESTIONA
            if (String.IsNullOrEmpty(cmb_areagestiona.Text))
            {
                general.mensajeERROR("El Área que Gestiona es Obligatoria");
                cmb_areagestiona.Focus();
                return false;
            }
            return true;
        }

	    private void btn_agregar_Click(object sender, EventArgs ef)
        {
            Boolean aplicar = true;
            //DETERMINO LOS CARGOS APLICADOS AL RECLAMO SELECCIONADO
            int totalFila = og_cargos.Rows.Count;
            //DataTable Datos = general.getValueList(BLConsultas.CargosReclamo.Replace("&reclamo&", cmb_solicitud.Value.ToString()));
            //22.08.17 CAMBIO POR SERVICIO DE RECLAMOS
            String[] tipos = { "Int64" };
            String[] campos = { "inupackage" };
            object[] valores = { cmb_solicitud.Value.ToString() };
            DataTable Datos = general.cursorProcedure(BLConsultas.CargosReclamo, 1, tipos, campos, valores);
            //22.02.19 Valido si es un reclamo u otra cosa
            if (Datos.Rows.Count == 0)
            {
                if (pn_grilla.Visible)
                {
                    general.mensajeERROR("Los reclamos deben ser de un mismo tipo para ser agregados.");
                }
                else
                {
                    String textoD = "";
                    for (int i = 0; i <= solicitudOrigen.Rows.Count - 1; i++)
                    {
                        if (cmb_solicitud.Value.ToString() == solicitudOrigen.Rows[i].ItemArray[0].ToString())
                        {
                            textoD = solicitudOrigen.Rows[i].ItemArray[2].ToString();
                        }
                    }
                    //
                    Boolean repetido = false;
                    for (int i = 0; i <= chkl_solicitudes.Items.Count - 1; i++)
                    {
                        if (cmb_solicitud.Value.ToString() + " - " + textoD == chkl_solicitudes.Items[i].ToString())
                        {
                            repetido = true;
                        }
                    }
                    if (!repetido)
                    {
                        chkl_solicitudes.Items.Add(cmb_solicitud.Value.ToString() + " - " + textoD);
                        tipoReclamo = 1;
                        pn_lista.Visible = true;
                        pn_grilla.Visible = false;
                    }
                }
            }
            else
            {
                if (pn_lista.Visible)
                {
                    general.mensajeERROR("Los reclamos deben ser de un mismo tipo para ser agregados.");
                }
                else
                {
                    //
                    int tiempoLegal = int.Parse(general.getParam("NUM_MESES_VAL_FACT", "Int64").ToString());
                    Int64 mes = Int64.Parse(Datos.Rows[0].ItemArray[11].ToString());
                    Int64 ano = Int64.Parse(Datos.Rows[0].ItemArray[10].ToString());
                    DateTime fecha = DateTime.Parse("01/" + mes.ToString() + "/" + ano.ToString());
                    Int64 messistema = DateTime.Now.Month;
                    Int64 anosistema = DateTime.Now.Year;
                    DateTime fechasistema = DateTime.Parse("01/" + messistema.ToString() + "/" + anosistema.ToString()).AddMonths(-tiempoLegal);
                    Int64 respuesta = 2;
                    if (fecha < fechasistema)
                    {
                        Question form_quest = new Question("LDRECUS - Advertencia", "Usted escogió una Solicitud Asociada a una Cuenta de Cobro que excede los " + tiempoLegal.ToString() + " meses legales de Reclamación, ¿Desea Continuar?", "Si", "No");
                        form_quest.ShowDialog();
                        respuesta = form_quest.answer;
                    }
                    if (respuesta == 2)
                    {
                        //
                        Boolean ingresoCiclo = false;
                        //ASIGNO LOS VALORES QUE POSEE EL RECLAMO SELECCIONADO A LA GRILLA
                        for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                        {
                            String validUnit_p = Datos.Rows[x].ItemArray[15].ToString();
                            if (validUnit_p == "")
                            {
                                validUnit_p = "0";
                            }
                            Double validUnit = Double.Parse(validUnit_p);
                            Double validVlrfact = 0;
                            if (Datos.Rows[x].ItemArray[4].ToString() != "")
                            {
                                validVlrfact = Double.Parse(Datos.Rows[x].ItemArray[4].ToString());
                            }
                            Double validVlrRecl = 0;
                            if (Datos.Rows[x].ItemArray[8].ToString() != "")
                            {
                                validVlrRecl = Double.Parse(Datos.Rows[x].ItemArray[8].ToString());
                            }
                            //VERIFICO, SI EL CARGO DE LA FACTURA NO ESTA ASIGNADO, LA VARIABLE APLICAR NO CAMBIARA DE VALOR
                            for (int y = 0; y <= totalFila - 1; y++)
                            {
                                //15.08.17 SE VALIDA EL RESTO DE CONTENIDO
                                //13.10.17 SE ADICIONA LA VALIDACION CON LAS UNIDADES
                                if (og_cargos.Rows[y].Cells[a].Value.ToString() == Datos.Rows[x].ItemArray[0].ToString() && og_cargos.Rows[y].Cells[b].Value.ToString() == Datos.Rows[x].ItemArray[1].ToString() && og_cargos.Rows[y].Cells[c].Value.ToString() == Datos.Rows[x].ItemArray[2].ToString() && og_cargos.Rows[y].Cells[d].Value.ToString() == Datos.Rows[x].ItemArray[3].ToString() && og_cargos.Rows[y].Cells[e].Value.ToString() == validVlrfact.ToString() && og_cargos.Rows[y].Cells[f].Value.ToString() == Datos.Rows[x].ItemArray[5].ToString() && og_cargos.Rows[y].Cells[g].Value.ToString() == Datos.Rows[x].ItemArray[6].ToString() && og_cargos.Rows[y].Cells[h].Value.ToString() == Datos.Rows[x].ItemArray[7].ToString() && og_cargos.Rows[y].Cells[j].Value.ToString() == Datos.Rows[x].ItemArray[9].ToString() && og_cargos.Rows[y].Cells[k].Value.ToString() == Datos.Rows[x].ItemArray[10].ToString() && og_cargos.Rows[y].Cells[l].Value.ToString() == Datos.Rows[x].ItemArray[11].ToString() && og_cargos.Rows[y].Cells[m].Value.ToString() == Datos.Rows[x].ItemArray[12].ToString() && og_cargos.Rows[y].Cells[n].Value.ToString() == Datos.Rows[x].ItemArray[13].ToString() && og_cargos.Rows[y].Cells[o].Value.ToString() == Datos.Rows[x].ItemArray[14].ToString() && og_cargos.Rows[y].Cells[r].Value.ToString() == validUnit.ToString() && og_cargos.Rows[y].Cells[s].Value.ToString() == cmb_solicitud.Value.ToString())
                                {
                                    aplicar = false;
                                }
                            }
                            if (aplicar)
                            {
                                lDVALRECcargosBindingSource.AddNew();
                                ingresoCiclo = true;
                                og_cargos.Rows[totalFila].Cells[a].Value = Datos.Rows[x].ItemArray[0].ToString();
                                og_cargos.Rows[totalFila].Cells[b].Value = Datos.Rows[x].ItemArray[1].ToString();
                                og_cargos.Rows[totalFila].Cells[c].Value = Datos.Rows[x].ItemArray[2].ToString();
                                //VALIDACION DEL CONCEPTO , SI ES SELECCIONABLE O NO 22.09.17
                                String conceptoId = Datos.Rows[x].ItemArray[2].ToString().Split('-')[0].Trim().ToString();
                                //
                                og_cargos.Rows[totalFila].Cells[d].Value = Datos.Rows[x].ItemArray[3].ToString();
                                og_cargos.Rows[totalFila].Cells[e].Value = validVlrfact;
                                og_cargos.Rows[totalFila].Cells[f].Value = Datos.Rows[x].ItemArray[5].ToString();
                                //VALIDACION DE LA CAUSAL 05.02.19
                                String causalId = Datos.Rows[x].ItemArray[5].ToString().Split('-')[0].Trim().ToString();
                                //
                                og_cargos.Rows[totalFila].Cells[g].Value = Datos.Rows[x].ItemArray[6].ToString();
                                og_cargos.Rows[totalFila].Cells[h].Value = Datos.Rows[x].ItemArray[7].ToString();
                                og_cargos.Rows[totalFila].Cells[i].Value = validVlrRecl;
                                og_cargos.Rows[totalFila].Cells[j].Value = Datos.Rows[x].ItemArray[9].ToString();
                                og_cargos.Rows[totalFila].Cells[k].Value = Datos.Rows[x].ItemArray[10].ToString();
                                og_cargos.Rows[totalFila].Cells[l].Value = Datos.Rows[x].ItemArray[11].ToString();
                                og_cargos.Rows[totalFila].Cells[m].Value = Datos.Rows[x].ItemArray[12].ToString();
                                og_cargos.Rows[totalFila].Cells[n].Value = Datos.Rows[x].ItemArray[13].ToString();
                                og_cargos.Rows[totalFila].Cells[o].Value = Datos.Rows[x].ItemArray[14].ToString();
                                //BLOQUEO DE FILA 22.09.17
                                //VALOR ABONADO PARA EL CARGO DE LA FACTURA
                                String[] p1_1 = new string[] { "Int64" };
                                String[] p2_1 = new string[] { "inConcepto" };
                                String[] p3_1 = new string[] { conceptoId };
                                String RespuestaB = general.valueReturn(BLConsultas.excluyeconcepto, 1, p1_1, p2_1, p3_1, "String").ToString();
                                og_cargos.Rows[totalFila].Cells[p].Value = RespuestaB;
                                if (RespuestaB == "N")
                                {
                                    og_cargos.Rows[totalFila].Cells[p].Value = RespuestaB + "1";
                                    og_cargos.Rows[totalFila].Cells[i].Activation = Activation.NoEdit;
                                }
                                else
                                {
                                    //exclusion de causales 05.02.19
                                    String[] p1_3 = new string[] { "Int64" };
                                    String[] p2_3 = new string[] { "inConcepto" };
                                    String[] p3_3 = new string[] { causalId };
                                    RespuestaB = general.valueReturn(BLConsultas.excluyecausal, 1, p1_3, p2_3, p3_3, "String").ToString();
                                    og_cargos.Rows[totalFila].Cells[p].Value = RespuestaB;
                                    if (RespuestaB == "N")
                                    {
                                        og_cargos.Rows[totalFila].Cells[p].Value = RespuestaB + "2";
                                        og_cargos.Rows[totalFila].Cells[i].Activation = Activation.NoEdit;
                                    }
                                }
                                //13.10.17 VALIDACION DE CONCEPTO OBLIGATORIO SI SE SELCCIONA
                                String[] p1_2 = new string[] { "Int64" };
                                String[] p2_2 = new string[] { "inConcepto" };
                                String[] p3_2 = new string[] { conceptoId };
                                String RespuestaC = general.valueReturn(BLConsultas.ConceptosObligatorioValor, 1, p1_2, p2_2, p3_2, "String").ToString();
                                og_cargos.Rows[totalFila].Cells[q].Value = RespuestaC;
                                //13.10.17 unidades - se asigna 0 pues no hay unidades en el registro
                                og_cargos.Rows[totalFila].Cells[r].Value = validUnit;
                                //22.02.19 solicitud
                                og_cargos.Rows[totalFila].Cells[s].Value = cmb_solicitud.Value.ToString();
                                totalFila++;
                                inicio = true;
                                //chk_sel.Checked = false;
                                inicio = false;
                            }
                            aplicar = true;
                        }
                        //Observacion 10.07.18 activar fila 1 cuando se agregan nuevos registros
                        if (ingresoCiclo)
                        {
                            og_cargos.Rows[0].Activate();
                            tipoReclamo = 2;
                            pn_lista.Visible = false;
                            pn_grilla.Visible = true;
                            //ACTUALIZO EL VALOR TOTAL EN LOS RECLAMOS
                            actualizarReclamo();
                        }
                        else
                        {
                            general.mensajeERROR("No se ingreso ningún Concepto al Reclamo");
                        }
                    }
                }
            }
        }

        /// <summary>
        /// LIMPIA LOS CAMPOS EDITABLES EN EL FORMULARIO
        /// </summary>
        void cleanForm()
        {
            ListasValores(inicio);
            txt_observacion.TextBoxValue = "";
            int totalFila = og_cargos.Rows.Count;
            for (int j = totalFila - 1; j >= 0; j--)
            {
                og_cargos.Rows[j].Delete(false);
            }
            actualizarReclamo();
        }

        private void xMLToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //ME PERMITE VISUALIZAR EL XML QUE SE GENERARA ANTES DE ENVIARLO
            //general.mensajeOk(generadorXML());
        }

        /// <summary>
        /// METODO QUE DEVUELVE EL XML GENERADO
        /// </summary>
        /// <returns></returns>
        String generadorXML(String Cuenta)
        {
            //validacion respuesta inmediata
            String respuestaInm = "<ANSWER_ID />";
            if (!String.IsNullOrEmpty(oc_respuestarap.Text))
            {
                respuestaInm = "<ANSWER_ID>" + oc_respuestarap.Value + "</ANSWER_ID>";
            }
            //GENERO EL XML PARA EL REGISTRO
            //CABECERA XML
            //Caso 200-1648
            //Se agrego el Reception_type_id
            String XmlRegister = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>" +
                "<P_SOLICITUD_RECURSO_DE_REPOSICION_XML_100337 ID_TIPOPAQUETE=\"100337\">" +
                "<CUSTOMER>" + identificadorCliente + "</CUSTOMER>" +
                "<INTERACCI_N>" + NumInteraccion + "</INTERACCI_N>" +
                "<RECEPTION_TYPE_ID >" + cmb_mediorecepcion.Value + "</RECEPTION_TYPE_ID >" +
                "<CONTACT_ID>" + identificadorCliente + "</CONTACT_ID>" +
                "<COMMENT_ >" + txt_observacion.TextBoxValue + "</COMMENT_>" +
                "<MANAGEMENT_AREA_ID>" + cmb_areagestiona.Value + "</MANAGEMENT_AREA_ID>" +
                "<ORGANIZAT_AREA_ID>" + cmb_areacausante.Value + "</ORGANIZAT_AREA_ID>";
            //DETALLE XML
            //13.08.17 SE APLICA VALIDACION CUANDO NO HAY VALORES DE RECLAMO
            Boolean entro = false;
            for (int x = 0; x <= og_cargos.Rows.Count - 1; x++)
            {
                //CASO 200-1468
                //VALIDACION SOBRE LA CUENTA
                if (og_cargos.Rows[x].Cells[a].Value.ToString() == Cuenta)
                {
                    //13.10.17 VALOR EN RECLAMO
                    Double valorReclamo = 0;
                    valorReclamo = Double.Parse(og_cargos.Rows[x].Cells[i].Value.ToString());
                    if (valorReclamo == 0 && og_cargos.Rows[x].Cells[q].Value.ToString() == "N")
                    {
                        valorReclamo = Double.Parse(og_cargos.Rows[x].Cells[e].Value.ToString());
                    }
                    //10.08.17 SE VALIDA QUE EL VALOR RECLAMADO SEA > 0
                    //22.09.17 se valida que pueda ser incluido
                    //13.10.17 se valida que haya valor
                    if (og_cargos.Rows[x].Cells[0].Value.ToString() == "True" && og_cargos.Rows[x].Cells[p].Value.ToString() == "S")
                    {
                        //13.08.17 SE APLICA VALIDACION CUANDO NO HAY VALORES DE RECLAMO
                        entro = true;
                        //17.08.17 VALOR EN RECLAMO
                        /*Double valorReclamo = 0;
                        valorReclamo = Double.Parse(dtg_cargos.Rows[x].Cells[i].Value.ToString());
                        if (valorReclamo == 0)
                        {
                            valorReclamo = Double.Parse(dtg_cargos.Rows[x].Cells[e].Value.ToString());
                        }*/
                        //VALOR ABONADO PARA EL CARGO DE LA FACTURA
                        String[] p1_1 = new string[] { "Int64" };
                        String[] p2_1 = new string[] { "inCcobro" };
                        String[] p3_1 = new string[] { og_cargos.Rows[x].Cells[a].Value.ToString() };
                        String ValorAbono = general.valueReturn(BLConsultas.ValorAbonado, 1, p1_1, p2_1, p3_1, "Int64").ToString();
                        //ASIGNACION DEL CUERPO DEL DETALLE DEL XML
                        XmlRegister += "<M_MOTIVO_RECURSO_REPOSICION_100323>" +
                                "<CONTRATO>" + SubscriptionId.ToString() + "</CONTRATO>" +
                                "<CAUSAL_ID>" + ohl_causal.Value.ToString() + "</CAUSAL_ID>" +
                                "<PRODUCTO>" + og_cargos.Rows[x].Cells[b].Value.ToString() + "</PRODUCTO>" +
                                respuestaInm +
                                "<ID_SOLICITUD_PADRE>" + og_cargos.Rows[x].Cells[s].Value.ToString() + "</ID_SOLICITUD_PADRE>" +
                                "<ID_SOLICITUD_RECLAMO>" + CodigoRespaldo + "</ID_SOLICITUD_RECLAMO>" +
                                "<ID_FACTURA>" + og_cargos.Rows[x].Cells[j].Value.ToString() + "</ID_FACTURA>" +
                                "<ID_CUENTA_DE_COBRO>" + og_cargos.Rows[x].Cells[a].Value.ToString() + "</ID_CUENTA_DE_COBRO>" +
                                "<MES_DE_LA_FACTURA>" + og_cargos.Rows[x].Cells[l].Value.ToString() + "</MES_DE_LA_FACTURA>" +
                                "<ANO_DE_LA_FACTURA>" + og_cargos.Rows[x].Cells[k].Value.ToString() + "</ANO_DE_LA_FACTURA>" +
                                "<VALOR_TOTAL>" + og_cargos.Rows[x].Cells[o].Value.ToString() + "</VALOR_TOTAL>" +
                                "<VALOR_ABONADO>" + ValorAbono + "</VALOR_ABONADO>" +
                                "<SALDO_PENDIENTE>" + og_cargos.Rows[x].Cells[m].Value.ToString() + "</SALDO_PENDIENTE>" +
                                "<VALOR_DEL_RECLAMO>" + valorReclamo.ToString() + "</VALOR_DEL_RECLAMO>" +
                                "<FECHA_DE_LA_GENERACION_DE_LA_CUENTA_DE_COBRO>" + DateTime.Parse(og_cargos.Rows[x].Cells[n].Value.ToString()).ToString("dd'/'MM'/'yyyy") + "</FECHA_DE_LA_GENERACION_DE_LA_CUENTA_DE_COBRO>" +
                                "<ID_CONCEPTO>" + og_cargos.Rows[x].Cells[c].Value.ToString().Split('-')[0].ToString() + "</ID_CONCEPTO>" +
                                "<SIGNO>" + og_cargos.Rows[x].Cells[d].Value.ToString() + "</SIGNO>" +
                                "<DOCUMENTO_SOPORTE_DEL_CARGO>" + og_cargos.Rows[x].Cells[g].Value.ToString() + "</DOCUMENTO_SOPORTE_DEL_CARGO>" +
                                "<CONSECUTIVO_DEL_DOCUMENTO_SOPORTE_DEL_CARGO>" + og_cargos.Rows[x].Cells[h].Value.ToString() + "</CONSECUTIVO_DEL_DOCUMENTO_SOPORTE_DEL_CARGO>" +
                                "<CAUSA_DEL_CARGO>" + og_cargos.Rows[x].Cells[f].Value.ToString().Split('-')[0].ToString() + "</CAUSA_DEL_CARGO>" +
                                "<VALOR_FACTURADO_DEL_CARGO>" + og_cargos.Rows[x].Cells[e].Value.ToString() + "</VALOR_FACTURADO_DEL_CARGO>" +
                                "<UNIDADES>" + og_cargos.Rows[x].Cells[r].Value.ToString() + "</UNIDADES>" +
                                "</M_MOTIVO_RECURSO_REPOSICION_100323>";
                    }
                }
            }
            //13.08.17 SE APLICA VALIDACION CUANDO NO HAY VALORES DE RECLAMO
            if (!entro)
            {
                XmlRegister += "<M_MOTIVO_RECURSO_REPOSICION_100323>" +
                        "<CONTRATO></CONTRATO>" +
                        "<CAUSAL_ID></CAUSAL_ID>" +
                        "<PRODUCTO></PRODUCTO>" +
                        respuestaInm + 
                        "<ID_SOLICITUD_RECLAMO></ID_SOLICITUD_RECLAMO>" +
                        "<ID_FACTURA></ID_FACTURA>" +
                        "<ID_CUENTA_DE_COBRO></ID_CUENTA_DE_COBRO>" +
                        "<MES_DE_LA_FACTURA></MES_DE_LA_FACTURA>" +
                        "<ANO_DE_LA_FACTURA></ANO_DE_LA_FACTURA>" +
                        "<VALOR_TOTAL></VALOR_TOTAL>" +
                        "<VALOR_ABONADO></VALOR_ABONADO>" +
                        "<SALDO_PENDIENTE></SALDO_PENDIENTE>" +
                        "<VALOR_DEL_RECLAMO></VALOR_DEL_RECLAMO>" +
                        "<FECHA_DE_LA_GENERACION_DE_LA_CUENTA_DE_COBRO></FECHA_DE_LA_GENERACION_DE_LA_CUENTA_DE_COBRO>" +
                        "<ID_CONCEPTO></ID_CONCEPTO>" +
                        "<SIGNO></SIGNO>" +
                        "<DOCUMENTO_SOPORTE_DEL_CARGO></DOCUMENTO_SOPORTE_DEL_CARGO>" +
                        "<CONSECUTIVO_DEL_DOCUMENTO_SOPORTE_DEL_CARGO></CONSECUTIVO_DEL_DOCUMENTO_SOPORTE_DEL_CARGO>" +
                        "<CAUSA_DEL_CARGO></CAUSA_DEL_CARGO>" +
                        "<VALOR_FACTURADO_DEL_CARGO></VALOR_FACTURADO_DEL_CARGO>" +
                        "<UNIDADES></UNIDADES>" +
                        "</M_MOTIVO_RECURSO_REPOSICION_100323>";
            }
            //FINAL DEL XML
            XmlRegister += "</P_SOLICITUD_RECURSO_DE_REPOSICION_XML_100337>";
            return XmlRegister;
        }

        ////OSF-96
        String generadorXMLMemoriaUnico(String Cuenta)
        {
            //validacion respuesta inmediata
            String respuestaInm = "<ANSWER_ID />";
            if (!String.IsNullOrEmpty(oc_respuestarap.Text))
            {
                respuestaInm = "<ANSWER_ID>" + oc_respuestarap.Value + "</ANSWER_ID>";
            }
            //GENERO EL XML PARA EL REGISTRO
            //CABECERA XML
            //Caso 200-1648
            //Se agrego el Reception_type_id
            String XmlRegister = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>" +
                "<P_SOLICITUD_RECURSO_DE_REPOSICION_XML_100337 ID_TIPOPAQUETE=\"100337\">" +
                "<CUSTOMER>" + identificadorCliente + "</CUSTOMER>" +
                "<INTERACCI_N>" + NumInteraccion + "</INTERACCI_N>" +
                "<RECEPTION_TYPE_ID >" + cmb_mediorecepcion.Value + "</RECEPTION_TYPE_ID >" +
                "<CONTACT_ID>" + identificadorCliente + "</CONTACT_ID>" +
                "<COMMENT_ >" + txt_observacion.TextBoxValue + "</COMMENT_>" +
                "<MANAGEMENT_AREA_ID>" + cmb_areagestiona.Value + "</MANAGEMENT_AREA_ID>" +
                "<ORGANIZAT_AREA_ID>" + cmb_areacausante.Value + "</ORGANIZAT_AREA_ID>";
            //DETALLE XML
            //13.08.17 SE APLICA VALIDACION CUANDO NO HAY VALORES DE RECLAMO
            Boolean entro = false;
            for (int x = 0; x <= og_cargos.Rows.Count - 1; x++)
            {
                //CASO 200-1468
                //VALIDACION SOBRE LA CUENTA
                if (og_cargos.Rows[x].Cells[0].Value.ToString() == "True")
                {
                    //13.10.17 VALOR EN RECLAMO
                    Double valorReclamo = 0;
                    valorReclamo = Double.Parse(og_cargos.Rows[x].Cells[i].Value.ToString());
                    if (valorReclamo == 0 && og_cargos.Rows[x].Cells[q].Value.ToString() == "N")
                    {
                        valorReclamo = Double.Parse(og_cargos.Rows[x].Cells[e].Value.ToString());
                    }
                    //10.08.17 SE VALIDA QUE EL VALOR RECLAMADO SEA > 0
                    //22.09.17 se valida que pueda ser incluido
                    //13.10.17 se valida que haya valor
                    if (og_cargos.Rows[x].Cells[0].Value.ToString() == "True" && og_cargos.Rows[x].Cells[p].Value.ToString() == "S")
                    {
                        //13.08.17 SE APLICA VALIDACION CUANDO NO HAY VALORES DE RECLAMO
                        entro = true;
                        //17.08.17 VALOR EN RECLAMO
                        /*Double valorReclamo = 0;
                        valorReclamo = Double.Parse(dtg_cargos.Rows[x].Cells[i].Value.ToString());
                        if (valorReclamo == 0)
                        {
                            valorReclamo = Double.Parse(dtg_cargos.Rows[x].Cells[e].Value.ToString());
                        }*/
                        //VALOR ABONADO PARA EL CARGO DE LA FACTURA
                        String[] p1_1 = new string[] { "Int64" };
                        String[] p2_1 = new string[] { "inCcobro" };
                        String[] p3_1 = new string[] { og_cargos.Rows[x].Cells[a].Value.ToString() };
                        String ValorAbono = general.valueReturn(BLConsultas.ValorAbonado, 1, p1_1, p2_1, p3_1, "Int64").ToString();
                        //ASIGNACION DEL CUERPO DEL DETALLE DEL XML
                        XmlRegister += "<M_MOTIVO_RECURSO_REPOSICION_100323>" +
                                "<CONTRATO>" + SubscriptionId.ToString() + "</CONTRATO>" +
                                "<CAUSAL_ID>" + ohl_causal.Value.ToString() + "</CAUSAL_ID>" +
                                "<PRODUCTO>" + og_cargos.Rows[x].Cells[b].Value.ToString() + "</PRODUCTO>" +
                                respuestaInm +
                                "<ID_SOLICITUD_PADRE>" + og_cargos.Rows[x].Cells[s].Value.ToString() + "</ID_SOLICITUD_PADRE>" +
                                "<ID_SOLICITUD_RECLAMO>" + CodigoRespaldo + "</ID_SOLICITUD_RECLAMO>" +
                                "<ID_FACTURA>" + og_cargos.Rows[x].Cells[j].Value.ToString() + "</ID_FACTURA>" +
                                "<ID_CUENTA_DE_COBRO>" + og_cargos.Rows[x].Cells[a].Value.ToString() + "</ID_CUENTA_DE_COBRO>" +
                                "<MES_DE_LA_FACTURA>" + og_cargos.Rows[x].Cells[l].Value.ToString() + "</MES_DE_LA_FACTURA>" +
                                "<ANO_DE_LA_FACTURA>" + og_cargos.Rows[x].Cells[k].Value.ToString() + "</ANO_DE_LA_FACTURA>" +
                                "<VALOR_TOTAL>" + og_cargos.Rows[x].Cells[o].Value.ToString() + "</VALOR_TOTAL>" +
                                "<VALOR_ABONADO>" + ValorAbono + "</VALOR_ABONADO>" +
                                "<SALDO_PENDIENTE>" + og_cargos.Rows[x].Cells[m].Value.ToString() + "</SALDO_PENDIENTE>" +
                                "<VALOR_DEL_RECLAMO>" + valorReclamo.ToString() + "</VALOR_DEL_RECLAMO>" +
                                "<FECHA_DE_LA_GENERACION_DE_LA_CUENTA_DE_COBRO>" + DateTime.Parse(og_cargos.Rows[x].Cells[n].Value.ToString()).ToString("dd'/'MM'/'yyyy") + "</FECHA_DE_LA_GENERACION_DE_LA_CUENTA_DE_COBRO>" +
                                "<ID_CONCEPTO>" + og_cargos.Rows[x].Cells[c].Value.ToString().Split('-')[0].ToString() + "</ID_CONCEPTO>" +
                                "<SIGNO>" + og_cargos.Rows[x].Cells[d].Value.ToString() + "</SIGNO>" +
                                "<DOCUMENTO_SOPORTE_DEL_CARGO>" + og_cargos.Rows[x].Cells[g].Value.ToString() + "</DOCUMENTO_SOPORTE_DEL_CARGO>" +
                                "<CONSECUTIVO_DEL_DOCUMENTO_SOPORTE_DEL_CARGO>" + og_cargos.Rows[x].Cells[h].Value.ToString() + "</CONSECUTIVO_DEL_DOCUMENTO_SOPORTE_DEL_CARGO>" +
                                "<CAUSA_DEL_CARGO>" + og_cargos.Rows[x].Cells[f].Value.ToString().Split('-')[0].ToString() + "</CAUSA_DEL_CARGO>" +
                                "<VALOR_FACTURADO_DEL_CARGO>" + og_cargos.Rows[x].Cells[e].Value.ToString() + "</VALOR_FACTURADO_DEL_CARGO>" +
                                "<UNIDADES>" + og_cargos.Rows[x].Cells[r].Value.ToString() + "</UNIDADES>" +
                                "</M_MOTIVO_RECURSO_REPOSICION_100323>";
                    }
                }
            }
            //13.08.17 SE APLICA VALIDACION CUANDO NO HAY VALORES DE RECLAMO
            if (!entro)
            {
                XmlRegister += "<M_MOTIVO_RECURSO_REPOSICION_100323>" +
                        "<CONTRATO></CONTRATO>" +
                        "<CAUSAL_ID></CAUSAL_ID>" +
                        "<PRODUCTO></PRODUCTO>" +
                        respuestaInm +
                        "<ID_SOLICITUD_RECLAMO></ID_SOLICITUD_RECLAMO>" +
                        "<ID_FACTURA></ID_FACTURA>" +
                        "<ID_CUENTA_DE_COBRO></ID_CUENTA_DE_COBRO>" +
                        "<MES_DE_LA_FACTURA></MES_DE_LA_FACTURA>" +
                        "<ANO_DE_LA_FACTURA></ANO_DE_LA_FACTURA>" +
                        "<VALOR_TOTAL></VALOR_TOTAL>" +
                        "<VALOR_ABONADO></VALOR_ABONADO>" +
                        "<SALDO_PENDIENTE></SALDO_PENDIENTE>" +
                        "<VALOR_DEL_RECLAMO></VALOR_DEL_RECLAMO>" +
                        "<FECHA_DE_LA_GENERACION_DE_LA_CUENTA_DE_COBRO></FECHA_DE_LA_GENERACION_DE_LA_CUENTA_DE_COBRO>" +
                        "<ID_CONCEPTO></ID_CONCEPTO>" +
                        "<SIGNO></SIGNO>" +
                        "<DOCUMENTO_SOPORTE_DEL_CARGO></DOCUMENTO_SOPORTE_DEL_CARGO>" +
                        "<CONSECUTIVO_DEL_DOCUMENTO_SOPORTE_DEL_CARGO></CONSECUTIVO_DEL_DOCUMENTO_SOPORTE_DEL_CARGO>" +
                        "<CAUSA_DEL_CARGO></CAUSA_DEL_CARGO>" +
                        "<VALOR_FACTURADO_DEL_CARGO></VALOR_FACTURADO_DEL_CARGO>" +
                        "<UNIDADES></UNIDADES>" +
                        "</M_MOTIVO_RECURSO_REPOSICION_100323>";
            }
            //FINAL DEL XML
            XmlRegister += "</P_SOLICITUD_RECURSO_DE_REPOSICION_XML_100337>";
            return XmlRegister;
        }
        private void ohl_causal_ValueChanged(object sender, EventArgs e)
        {
            //15.08.17 VALIDO YA SE INICIO LA FORMA
            if (!inicio)
            {
                if (ohl_causal.Value.ToString() != "")
                {
                    inicio = true;
                    DataTable area_1 = general.getValueList(BLConsultas.AreasCausante.Replace("&causal&", ohl_causal.Value.ToString()));
                    cmb_areacausante.DataSource = null;
                    cmb_areacausante.Value = "";
                    cmb_areacausante.DataSource = area_1;
                    cmb_areacausante.DisplayMember = "Descripción";
                    cmb_areacausante.ValueMember = "ID";
                    inicio = false;
                }
            }
        }

        private void tsb_eraser_Click(object sender, EventArgs e)
        {
            //15.08.17 LIMPIAR GRILLA
            int totalFila = og_cargos.Rows.Count;
            for (int j = totalFila - 1; j >= 0; j--)
            {
                og_cargos.Rows[j].Delete(false);
            }
            //chk_sel.Checked = false;
            actualizarReclamo();
            pn_grilla.Visible = false;
            pn_lista.Visible = false;
            tipoReclamo = 0;
        }

        private void cmb_areacausante_ValueChanged(object sender, EventArgs e)
        {
            //17.08.17 VALIDO YA SE INICIO LA FORMA
            if (!inicio)
            {
                if (cmb_areacausante.Value.ToString() != "")
                {
                    DataTable area_2 = general.getValueList(BLConsultas.AreasGestiona.Replace("&causante&", cmb_areacausante.Value.ToString()));
                    cmb_areagestiona.DataSource = null;
                    cmb_areagestiona.Value = "";
                    cmb_areagestiona.DataSource = area_2;
                    cmb_areagestiona.DisplayMember = "Descripción";
                    cmb_areagestiona.ValueMember = "ID";
                }
            }
        }

        //CASO 200-1648
        //SE AGREGA VALIDACION PARA VERIFICAR ESTADOS DE CUENTA Y SUS VALORES EN RECLAMO

        public List<LDVALREC_proyectar> lista = new List<LDVALREC_proyectar>();

        String validar_cuentas(UltraGrid datosGrilla)
        {
            String respuesta = "";
            //INICIO DEL PROCESO DE validacion
            String cuenta = "";
            String ano = "";
            String mes = "";
            Double total = 0;
            Double aprobado = 0;
            Double pendiente = 0;
            Double reclamo = 0;
            DateTime fecha = DateTime.Now;
            List<LDVALREC_cargos> listacopia = new List<LDVALREC_cargos>();
            //VERIFICO QUE LA GRILLA DE DATOS DEL FORMULARIO MAESTRO POSEE REGISTROS
            if (datosGrilla.Rows.Count > 0)
            {
                //copia resultados grilla
                for (int x = 0; x <= datosGrilla.Rows.Count - 1; x++)
                {
                    LDVALREC_cargos fila = new LDVALREC_cargos
                    {
                        selection = Boolean.Parse(datosGrilla.Rows[x].Cells[0].Value.ToString()),
                        cuenta = datosGrilla.Rows[x].Cells[a].Value.ToString(),
                        product = Int64.Parse(datosGrilla.Rows[x].Cells[b].Value.ToString()),
                        concept = datosGrilla.Rows[x].Cells[c].Value.ToString(),
                        signed = datosGrilla.Rows[x].Cells[d].Value.ToString(),
                        VLR_FACTURADO = Double.Parse(datosGrilla.Rows[x].Cells[e].Value.ToString()),
                        CAUSAL = datosGrilla.Rows[x].Cells[f].Value.ToString(),
                        DOCUMENTO = datosGrilla.Rows[x].Cells[g].Value.ToString(),
                        CONSECUTIVO = datosGrilla.Rows[x].Cells[h].Value.ToString(),
                        VLR_RECLAMADO = Double.Parse(datosGrilla.Rows[x].Cells[i].Value.ToString()),
                        factura = datosGrilla.Rows[x].Cells[j].Value.ToString(),
                        ano = datosGrilla.Rows[x].Cells[k].Value.ToString(),
                        mes = datosGrilla.Rows[x].Cells[l].Value.ToString(),
                        saldo = datosGrilla.Rows[x].Cells[m].Value.ToString(),
                        fecha = DateTime.Parse(datosGrilla.Rows[x].Cells[n].Value.ToString()),
                        VLRTOTAL = datosGrilla.Rows[x].Cells[o].Value.ToString(),
                        editable = datosGrilla.Rows[x].Cells[p].Value.ToString(),
                        concepoblig = datosGrilla.Rows[x].Cells[q].Value.ToString(),
                        unit = Double.Parse(datosGrilla.Rows[x].Cells[r].Value.ToString()),
                        solicitud = datosGrilla.Rows[x].Cells[s].Value.ToString()
                    };
                    //AGREGO EL VALOR
                    listacopia.Add(fila);
                }
                lDVALREC2cargosBindingSource.DataSource = listacopia;
                //
                dtg_copia.DisplayLayout.Bands[0].Columns[a].SortIndicator = SortIndicator.Ascending;
                dtg_copia.DisplayLayout.Bands[0].Columns[k].SortIndicator = SortIndicator.Ascending;
                dtg_copia.DisplayLayout.Bands[0].Columns[l].SortIndicator = SortIndicator.Ascending;
                //RECORRIDO DEL PRIMER HASTA EL ULTIMO REGISTRO
                for (int x = 0; x <= dtg_copia.Rows.Count - 1; x++)
                {
                    //10.08.17 VALIDO QUE TENGA UN VALOR PARA RECLAMAR EN EL CONCEPTO
                    //22.09.17 valido que sea agregable dentro de los conceptos
                    if (dtg_copia.Rows[x].Cells[0].Value.ToString() == "True" && dtg_copia.Rows[x].Cells[p].Value.ToString() == "S")
                    {
                        //VERIFICO SI ES LA PRIMERA VEZ QUE APARECE UNA CUENTA
                        if (cuenta == "")
                        {
                            cuenta = dtg_copia.Rows[x].Cells[a].Value.ToString();
                            ano = dtg_copia.Rows[x].Cells[k].Value.ToString();
                            mes = dtg_copia.Rows[x].Cells[l].Value.ToString();
                            total = Double.Parse(dtg_copia.Rows[x].Cells[o].Value.ToString());
                            aprobado = 0;
                            pendiente = 0;
                            //17.08.17 VALOR RECLAMADO
                            reclamo = Double.Parse(dtg_copia.Rows[x].Cells[i].Value.ToString());
                            if (reclamo == 0)
                            {
                                reclamo = Double.Parse(dtg_copia.Rows[x].Cells[e].Value.ToString());
                            }
                            switch (dtg_copia.Rows[x].Cells[d].Value.ToString())
                            {
                                case "DB":
                                case "SA":
                                case "AP":
                                case "TS":
                                    { }
                                    break;
                                case "CR":
                                case "AS":
                                case "PA":
                                case "NS":
                                case "ST":
                                    {
                                        reclamo *= -1;
                                    }
                                    break;
                            }
                            //
                            fecha = DateTime.Parse(dtg_copia.Rows[x].Cells[n].Value.ToString());
                        }
                        else
                        {
                            //REALIZO LOS PROCESO DE SUMA DE LOS ACUMULADOS O REINICIO LA ASIGNACION DE LA CUENTA
                            if (cuenta == dtg_copia.Rows[x].Cells[a].Value.ToString())
                            {
                                total = Double.Parse(dtg_copia.Rows[x].Cells[o].Value.ToString());
                                aprobado += 0;
                                pendiente += 0;
                                //17.08.17 VALOR RECLAMADO
                                switch (dtg_copia.Rows[x].Cells[d].Value.ToString())
                                {
                                    case "DB":
                                    case "SA":
                                    case "AP":
                                    case "TS":
                                        {
                                            if (Double.Parse(dtg_copia.Rows[x].Cells[i].Value.ToString()) == 0)
                                            {
                                                reclamo += Double.Parse(dtg_copia.Rows[x].Cells[e].Value.ToString());
                                            }
                                            else
                                            {
                                                reclamo += Double.Parse(dtg_copia.Rows[x].Cells[i].Value.ToString());
                                            }
                                        }
                                        break;
                                    case "CR":
                                    case "AS":
                                    case "PA":
                                    case "NS":
                                    case "ST":
                                        {
                                            if (Double.Parse(dtg_copia.Rows[x].Cells[i].Value.ToString()) == 0)
                                            {
                                                reclamo -= Double.Parse(dtg_copia.Rows[x].Cells[e].Value.ToString());
                                            }
                                            else
                                            {
                                                reclamo -= Double.Parse(dtg_copia.Rows[x].Cells[i].Value.ToString());
                                            }
                                        }
                                        break;
                                }
                                //
                            }
                            else
                            {
                                //ASIGNO A LA LISTA PRINCIPAL LOS ACUMULADOS
                                respuesta = agregar(cuenta, ano, mes, total, aprobado, pendiente, reclamo, fecha);
                                if (respuesta != "")
                                {
                                    return respuesta;
                                }
                                cuenta = dtg_copia.Rows[x].Cells[a].Value.ToString();
                                ano = dtg_copia.Rows[x].Cells[k].Value.ToString();
                                mes = dtg_copia.Rows[x].Cells[l].Value.ToString();
                                total = Double.Parse(dtg_copia.Rows[x].Cells[o].Value.ToString());
                                aprobado = 0;
                                pendiente = 0;
                                //17.08.17 VALOR RECLAMADO
                                reclamo = Double.Parse(dtg_copia.Rows[x].Cells[i].Value.ToString());
                                if (reclamo == 0)
                                {
                                    reclamo = Double.Parse(dtg_copia.Rows[x].Cells[e].Value.ToString());
                                }
                                switch (dtg_copia.Rows[x].Cells[d].Value.ToString())
                                {
                                    case "DB":
                                    case "SA":
                                    case "AP":
                                    case "TS":
                                        { }
                                        break;
                                    case "CR":
                                    case "AS":
                                    case "PA":
                                    case "NS":
                                    case "ST":
                                        {
                                            reclamo *= -1;
                                        }
                                        break;
                                }
                                //
                                fecha = DateTime.Parse(dtg_copia.Rows[x].Cells[n].Value.ToString());
                            }
                        }
                    }
                }
                dtg_copia.DisplayLayout.Bands[0].SortedColumns.Clear();
                //AL FINALIZAR VERIFICO SI SE ASIGNO ALGUNA CUENTA Y LA ASIGNO A LA GRILLA
                if (cuenta != "")
                {
                    //ASIGNO A LA LISTA PRINCIPAL LOS ACUMULADOS
                    respuesta = agregar(cuenta, ano, mes, total, aprobado, pendiente, reclamo, fecha);
                    if (respuesta != "")
                    {
                        return respuesta;
                    }
                }
            }
            return respuesta;
        }

        /// <summary>
        /// PROCESO PARA ASIGNAR LOS RESULTADOS A LA LISTA PRINCIPAL
        /// </summary>
        /// <param name="cuenta">NUMERO DE LA CUENTA</param>
        /// <param name="ano">NUMERO DEL AÑO</param>
        /// <param name="mes">NUMERO DEL MES</param>
        /// <param name="total">TOTAL DEL FACTURA</param>
        /// <param name="aprobado">TOTAL APROBADO</param>
        /// <param name="pendiente">TOTAL PENDIENTE</param>
        /// <param name="reclamo">TOTAL DEL RECLAMO</param>
        /// <param name="fecha">FECHA DEL RECLAMO</param>
        String agregar(String cuenta, String ano, String mes, Double total, Double aprobado, Double pendiente, Double reclamo, DateTime fecha)
        {
            //BUSQUEDA DEL VALOR TOTAL ABONADO
            String[] p1_1 = new string[] { "Int64" };
            String[] p2_1 = new string[] { "inCcobro" };
            String[] p3_1 = new string[] { cuenta };
            Int64 ValorAbono = Convert.ToInt64(general.valueReturn(BLConsultas.ValorAbonado, 1, p1_1, p2_1, p3_1, "Int64"));
            //BUSQUEDA DEL VALOR PENDIENTE
            String[] p1_2 = new string[] { "Int64" };
            String[] p2_2 = new string[] { "inCcobro" };
            String[] p3_2 = new string[] { cuenta };
            Int64 ValorPendiente = Convert.ToInt64(general.valueReturn(BLConsultas.ValorPendiente, 1, p1_2, p2_2, p3_2, "Int64"));
            //CARGO EL VALOR A LA LISTA PRINCIPAL
            LDVALREC_proyectar fila = new LDVALREC_proyectar
            {
                cuenta = Int64.Parse(cuenta),
                ano = Int64.Parse(ano),
                mes = Int64.Parse(mes),
                valortotal = total,
                valoraprobado = ValorAbono,
                saldopendiente = ValorPendiente,
                valorreclamo = reclamo,
                fechageneracion = fecha
            };
            this.lista.Add(fila);
            //valido
            if (fila.valorreclamo < 0)
            {
                return fila.cuenta.ToString();
            }
            else
            {
                return "";
            }
        }

        private void btn_guardar_Click(object sender, EventArgs ec)
        {
            //VALIDO SI SE HAN INGRESADO LOS VALORES OBLIGATORIOS
            if (validar())
            {
                //VALIDO QUE TODOS LOS CARGOS REPORTADOS TENGAN UN VALOR RECLAMADO
                //10.08.17 YA NO SE VALIDA VALORES EN RECLAMO EN 0
                Boolean ejecutar = true;
                Double valor = Double.Parse(txt_valorReclamado.TextBoxValue);
                if (valor < 0)
                {
                    ejecutar = false;
                    general.mensajeERROR("No pueden haber Reclamos con Valores en Negativo");
                }
                else
                {
                    Boolean entro = false;
                    for (int x = 0; x <= og_cargos.Rows.Count - 1; x++)
                    {
                        //13.10.17 SE MODIFICO PARA CORREGIR VALIDACION DE VALORES VALIDOS
                        Double valorReclamo = 0;
                        valorReclamo = Double.Parse(og_cargos.Rows[x].Cells[i].Value.ToString());
                        if (valorReclamo == 0 && og_cargos.Rows[x].Cells[q].Value.ToString() == "N")
                        {
                            valorReclamo = Double.Parse(og_cargos.Rows[x].Cells[e].Value.ToString());
                        }
                        if (og_cargos.Rows[x].Cells[0].Value.ToString() == "True" && og_cargos.Rows[x].Cells[p].Value.ToString() == "S" && valorReclamo == 0)
                        {
                            entro = true;
                        }
                    }
                    if (!entro)
                    {
                        Question pregunta = new Question("LDRECUS - Guardar", "Esta seguro que desea guardar?", "Si", "No");
                        pregunta.ShowDialog();
                        if (pregunta.answer == 3)
                        {
                            ejecutar = false;
                        }
                    }
                }
                //13.10.17 - VALIDO QUE LOS CONCEPTOS EDITABLES OBLIGATORIOS TENGAN UN VALOR DEFINIDO
                if (ejecutar)
                {
                    String mensajeError = "";
                    Boolean entro = false;
                    for (int x = 0; x <= og_cargos.Rows.Count - 1; x++)
                    {
                        Double valorReclamo = 0;
                        valorReclamo = Double.Parse(og_cargos.Rows[x].Cells[i].Value.ToString());
                        if (og_cargos.Rows[x].Cells[0].Value.ToString() == "True" && og_cargos.Rows[x].Cells[p].Value.ToString() == "S" && valorReclamo == 0 && og_cargos.Rows[x].Cells[q].Value.ToString() == "S")
                        {
                            entro = true;
                            if (mensajeError != "")
                            {
                                mensajeError += ", ";
                            }
                            mensajeError += "Cuenta: " + og_cargos.Rows[x].Cells[a].Value.ToString() + " - Consecutivo: " + og_cargos.Rows[x].Cells[h].Value.ToString();
                        }
                    }
                    if (entro)
                    {
                        general.mensajeERROR("Los Conceptos detallados [ " + mensajeError + " ] deben llevar un Valor Reclamado definido por el Usuario");
                        ejecutar = false;
                    }
                }
                //caso 200-1648
                //valido que todos esten en 0 o positivo
                this.lista.Clear();
                String resp = validar_cuentas(og_cargos);
                if (resp != "")
                {
                    general.mensajeERROR("Los Valores en el Recurso de Reposición de la Cuenta " + resp + " no puede quedar en Negativo");
                    ejecutar = false;
                }
                //valido
                //SI TODOS LOS CARGOS TIENEN VALOR RECLAMADO CONTINUO CON EL PROCESO
                if (ejecutar)
                {
                    String codigosC = "";
                    if (this.lista.Count > 0)
                    {
                        int registro = 0;
                        //Int64 interaccion = 0;

                        //OSF-96
                        if (sbReclamoUnico == "S")
                        {
                            registro++;
                            //ASIGNO EL XML GENERADO
                            String XmlRegister = generadorXMLMemoriaUnico("");

                            //general.mensajeOk(XmlRegister);


                            //ASIGNO EL XML AL METODO
                            Int64 packageId = 0;
                            packageId = _blldvalrec.RegisterXML(XmlRegister);
                            //general.mensajeERROR(XmlRegister);
                            //SI EL VALOR DEVUELTO ES DIFERENTE DE 0 ES POR QUE EL TICKETE DEL REGISTRO DEL XML FUE GENERADO CON EXITO
                            if (packageId != 0)
                            {
                                //Caso 200-1648
                                //se agrego la consulta de actualizacion
                                String[] U1 = new string[] { "Int64", "Int64" };
                                String[] U2 = new string[] { "inupackage", "inureception" };
                                Object[] U3 = new object[] { packageId, cmb_mediorecepcion.Value };
                                general.executeService(BLConsultas.UpdateReceptionType, 2, U1, U2, U3);
                                //
                                //SALVO LOS CAMBIOS EN LA BASE DE DATOS
                                //proceso para interaccion 11.07.18
                                //if (registro == 1)
                                //{
                                //    interaccion = _blldvalrec.SolicitudInteraccion(packageId);
                                //}
                                //else
                                //{
                                //    //se agrego la consulta de actualizacion
                                //    String[] U1_1 = new string[] { "Int64", "Int64" };
                                //    String[] U2_1 = new string[] { "inuPackage", "inuinterac" };
                                //    Object[] U3_1 = new object[] { packageId, interaccion };
                                //    general.executeService(BLConsultas.ActualizarSolicitudReclamo, 2, U1_1, U2_1, U3_1);
                                //}
                                //validacion del tipo de reclamo
                                //se agrego la consulta de actualizacion
                                if (!String.IsNullOrEmpty(oc_respuestarap.Text))
                                {
                                    String[] U1_2 = new string[] { "Int64" };
                                    String[] U2_2 = new string[] { "inuPackage_id" };
                                    Object[] U3_2 = new object[] { packageId };
                                    general.executeService(BLConsultas.EliminarConRespuestaInmediata, 1, U1_2, U2_2, U3_2);
                                }
                                //registro del anexo
                                String[] U1_3 = new string[] { "Int64", "Int64" };
                                String[] U2_3 = new string[] { "inuPackage_id", "inuObject_id" };
                                Object[] U3_3 = new object[] { packageId, vId };
                                general.executeService(BLConsultas.registerAnexos, 2, U1_3, U2_3, U3_3);
                                //
                                _blldvalrec.doCommit();
                                codigosC += "Registro del Recurso de Reposición Exitoso para la Cuenta. Solicitud: " + packageId.ToString() + "\n";
                                //13.08.17 SE SOLICITO CERRAR EL FORMULARIO AL TERMINAR EL PROCESO
                                this.Close();
                            }
                            else
                            {
                                codigosC += "Error Registrando el Recurso de Reposición sobre la Cuenta" + "\n";
                            }
                        }
                        else
                        {
                            foreach (LDVALREC_proyectar cuenta in this.lista)
                            {
                                registro++;
                                //ASIGNO EL XML GENERADO
                                String XmlRegister = generadorXML(cuenta.cuenta.ToString());

                                //general.mensajeOk(XmlRegister);


                                //ASIGNO EL XML AL METODO
                                Int64 packageId = 0;
                                packageId = _blldvalrec.RegisterXML(XmlRegister);
                                //SI EL VALOR DEVUELTO ES DIFERENTE DE 0 ES POR QUE EL TICKETE DEL REGISTRO DEL XML FUE GENERADO CON EXITO
                                if (packageId != 0)
                                {
                                    //Caso 200-1648
                                    //se agrego la consulta de actualizacion
                                    String[] U1 = new string[] { "Int64", "Int64" };
                                    String[] U2 = new string[] { "inupackage", "inureception" };
                                    Object[] U3 = new object[] { packageId, cmb_mediorecepcion.Value };
                                    general.executeService(BLConsultas.UpdateReceptionType, 2, U1, U2, U3);
                                    //
                                    //SALVO LOS CAMBIOS EN LA BASE DE DATOS
                                    //proceso para interaccion 11.07.18
                                    //if (registro == 1)
                                    //{
                                    //    interaccion = _blldvalrec.SolicitudInteraccion(packageId);
                                    //}
                                    //else
                                    //{
                                    //    //se agrego la consulta de actualizacion
                                    //    String[] U1_1 = new string[] { "Int64", "Int64" };
                                    //    String[] U2_1 = new string[] { "inuPackage", "inuinterac" };
                                    //    Object[] U3_1 = new object[] { packageId, interaccion };
                                    //    general.executeService(BLConsultas.ActualizarSolicitudReclamo, 2, U1_1, U2_1, U3_1);
                                    //}
                                    //validacion del tipo de reclamo
                                    //se agrego la consulta de actualizacion
                                    if (!String.IsNullOrEmpty(oc_respuestarap.Text))
                                    {
                                        String[] U1_2 = new string[] { "Int64" };
                                        String[] U2_2 = new string[] { "inuPackage_id" };
                                        Object[] U3_2 = new object[] { packageId };
                                        general.executeService(BLConsultas.EliminarConRespuestaInmediata, 1, U1_2, U2_2, U3_2);
                                    }
                                    //registro del anexo
                                    String[] U1_3 = new string[] { "Int64", "Int64" };
                                    String[] U2_3 = new string[] { "inuPackage_id", "inuObject_id" };
                                    Object[] U3_3 = new object[] { packageId, vId };
                                    general.executeService(BLConsultas.registerAnexos, 2, U1_3, U2_3, U3_3);
                                    //
                                    _blldvalrec.doCommit();
                                    codigosC += "Registro del Recurso de Reposición Exitoso para la Cuenta " + cuenta.cuenta.ToString() + ". Solicitud: " + packageId.ToString() + "\n";
                                    //13.08.17 SE SOLICITO CERRAR EL FORMULARIO AL TERMINAR EL PROCESO
                                    this.Close();
                                }
                                else
                                {
                                    codigosC += "Error Registrando el Recurso de Reposición sobre la Cuenta " + cuenta.cuenta.ToString() + "\n";
                                }
                            }
                        }
                    }
                    else
                    {
                        String XmlRegister = generadorXML("");
                        Int64 packageId = 0;
                        packageId = _blldvalrec.RegisterXML(XmlRegister);
                        if (packageId != 0)
                        {
                            //Caso 200-1648
                            //se agrego la consulta de actualizacion
                            String[] U1 = new string[] { "Int64", "Int64" };
                            String[] U2 = new string[] { "inupackage", "inureception" };
                            Object[] U3 = new object[] { packageId, cmb_mediorecepcion.Value };
                            general.executeService(BLConsultas.UpdateReceptionType, 2, U1, U2, U3);
                            //
                            String[] U1_2 = new string[] { "Int64" };
                            String[] U2_2 = new string[] { "inuPackage_id" };
                            Object[] U3_2 = new object[] { packageId };
                            general.executeService(BLConsultas.EliminarConRespuestaInmediata, 1, U1_2, U2_2, U3_2);
                            //
                            _blldvalrec.doCommit();
                            codigosC = "Registro del Recurso de Reposición Exitoso. Solicitud: " + packageId.ToString() + "\n";
                            this.Close();
                        }
                        else
                        {
                            codigosC = "Error Registrando el Recurso de Reposición";
                        }
                    }
                    general.mensajeOk(codigosC);
                }
            }
        }

        private Boolean validarSubsidioValido(int filaSeleccionada)
        {
            String[] p1 = new string[] { "Int64" };
            String[] p2 = new string[] { "inuConc" };
            String[] p3 = new string[] { og_cargos.Rows[filaSeleccionada].Cells[c].Value.ToString().Split('-')[0].ToString() };
            String RespuestaA = general.valueReturn(BLConsultas.ConceptosdeConsumo, 1, p1, p2, p3, "Int64").ToString();
            //
            if (RespuestaA == "1")
            {
                //CALCULO EL TOTAL DE FILAS
                int totalFila = og_cargos.Rows.Count;
                String ccSelec = og_cargos.Rows[filaSeleccionada].Cells[a].Value.ToString();
                //RECORRO LA GRILLA PARA VALIDAR LOS VALORES REGISTRADOS
                for (int y = 0; y <= totalFila - 1; y++)
                {
                    if (y != filaSeleccionada)
                    {
                        if (og_cargos.Rows[y].Cells[0].Value.ToString() == "True" && og_cargos.Rows[y].Cells[a].Value.ToString() == ccSelec && int.Parse(og_cargos.Rows[y].Cells[c].Value.ToString().Split('-')[0].ToString()) == int.Parse(conceptoConsumo))
                        {
                            return true;
                        }
                    }
                }
            }
            return false;
        }

        private void og_cargos_AfterCellUpdate(object sender, CellEventArgs ec)
        {
            if (!inicio)
            {
                if (ec.Cell.Column.Key == i)
                {
                    if (og_cargos.Rows[ec.Cell.Row.Index].Cells[i].Value.ToString() != "0")
                    {
                        if (alertaAdv.Contains(og_cargos.Rows[ec.Cell.Row.Index].Cells[d].Value.ToString()))
                        {
                            if (!validarSubsidioValido(ec.Cell.Row.Index))
                            {
                                String mensajeCompl = "(NO DEFINIDO)";
                                DataTable descripcionSigno = general.getValueList(BLConsultas.signoDescripcion.Replace("&signo&", og_cargos.Rows[ec.Cell.Row.Index].Cells[d].Value.ToString()));
                                if (descripcionSigno.Rows.Count > 0)
                                {
                                    mensajeCompl = descripcionSigno.Rows[0].ItemArray[0].ToString();
                                }
                                general.mensajeERROR("¡Alerta! El Valor en Reclamo editado es un tipo " + mensajeCompl + " (" + og_cargos.Rows[ec.Cell.Row.Index].Cells[d].Value.ToString() + ")");
                                inicio = true;
                                og_cargos.Rows[ec.Cell.Row.Index].Cells[i].Value = 0;
                                inicio = false;
                            }
                            else
                            {
                                inicio = true;
                                og_cargos.Rows[ec.Cell.Row.Index].Cells[0].Value = 1;
                                og_cargos.Rows[ec.Cell.Row.Index].Appearance.FontData.Bold = DefaultableBoolean.False;
                                inicio = false;
                            }
                        }
                        else
                        {
                            if (og_cargos.Rows[ec.Cell.Row.Index].Cells[0].Value.ToString() == "False")
                            {
                                inicio = true;
                                og_cargos.Rows[ec.Cell.Row.Index].Cells[0].Value = 1;
                                og_cargos.Rows[ec.Cell.Row.Index].Appearance.FontData.Bold = DefaultableBoolean.False;
                                inicio = false;
                            }
                        }
                    }
                    else
                    {
                        if (og_cargos.Rows[ec.Cell.Row.Index].Cells[0].Value.ToString() == "True")
                        {
                            inicio = true;
                            og_cargos.Rows[ec.Cell.Row.Index].Cells[0].Value = 0;
                            og_cargos.Rows[ec.Cell.Row.Index].Appearance.FontData.Bold = DefaultableBoolean.True;
                            inicio = false;
                        }
                    }
                }
                if (ec.Cell.Column.Index == 0)
                {
                    if (ec.Cell.Value.ToString() == "True")
                    {
                        og_cargos.Rows[ec.Cell.Row.Index].Appearance.FontData.Bold = DefaultableBoolean.False;
                    }
                    else
                    {
                        og_cargos.Rows[ec.Cell.Row.Index].Appearance.FontData.Bold = DefaultableBoolean.True;
                    }
                    Boolean mensajeSi = false;
                    //advertencia de concepto que no sera agregado al reclamo 
                    //13.10.17 se modifico el mensaje
                    if (ec.Cell.Value.ToString() == "True")
                    {
                        if (validarSubsidioValido(ec.Cell.Row.Index))
                        {
                            general.mensajeERROR("La columna valor reclamado debe ser editado. recuerde que está en el concepto " + og_cargos.Rows[ec.Cell.Row.Index].Cells[c].Value.ToString().Split('-')[0].ToString());
                            mensajeSi = true;
                        }
                        //10.07.18 se valida el concepto obligatorio
                        if (og_cargos.Rows[ec.Cell.Row.Index].Cells[0].Value.ToString() == "True" && alertaAdv.Contains(og_cargos.Rows[ec.Cell.Row.Index].Cells[d].Value.ToString()) && !mensajeSi)
                        {
                            String mensajeCompl = "(NO DEFINIDO)";
                            DataTable descripcionSigno = general.getValueList(BLConsultas.signoDescripcion.Replace("&signo&", og_cargos.Rows[ec.Cell.Row.Index].Cells[d].Value.ToString()));
                            if (descripcionSigno.Rows.Count > 0)
                            {
                                mensajeCompl = descripcionSigno.Rows[0].ItemArray[0].ToString();
                            }
                            general.mensajeERROR("¡Alerta! El Valor en Reclamo seleccionado es un tipo " + mensajeCompl + " (" + og_cargos.Rows[ec.Cell.Row.Index].Cells[d].Value.ToString() + ")");
                            og_cargos.Rows[ec.Cell.Row.Index].Cells[0].Value = false;
                            og_cargos.Rows[ec.Cell.Row.Index].Appearance.FontData.Bold = DefaultableBoolean.True;
                            mensajeSi = true;
                        }
                        //
                        if (og_cargos.Rows[ec.Cell.Row.Index].Cells[0].Value.ToString() == "True" && og_cargos.Rows[ec.Cell.Row.Index].Cells[p].Value.ToString() == "N1" && !mensajeSi)
                        {
                            general.mensajeERROR("El Concepto [Cuenta: " + og_cargos.Rows[ec.Cell.Row.Index].Cells[a].Value.ToString() + " - Consecutivo: " + og_cargos.Rows[ec.Cell.Row.Index].Cells[h].Value.ToString() + "] no sera calculado en el Reclamo, por estar Excluido");
                            mensajeSi = true;
                        }
                        if (og_cargos.Rows[ec.Cell.Row.Index].Cells[0].Value.ToString() == "True" && og_cargos.Rows[ec.Cell.Row.Index].Cells[p].Value.ToString() == "N2" && !mensajeSi)
                        {
                            general.mensajeERROR("La Causal [Cuenta: " + og_cargos.Rows[ec.Cell.Row.Index].Cells[a].Value.ToString() + " - Consecutivo: " + og_cargos.Rows[ec.Cell.Row.Index].Cells[h].Value.ToString() + "] no sera calculada en el Reclamo, por estar Excluido");
                            mensajeSi = true;
                        }
                        //mod 12.05.19 se valida el nuevo mensaje de consumo
                        String concepto = og_cargos.Rows[ec.Cell.Row.Index].Cells[c].Value.ToString().Split('-')[0].ToString();
                        if (og_cargos.Rows[ec.Cell.Row.Index].Cells[0].Value.ToString() == "True" && int.Parse(concepto) == int.Parse(conceptoConsumo) && !mensajeSi)
                        {
                            general.mensajeERROR("La columna valor reclamado debe ser editado");
                            mensajeSi = true;
                        }
                        //13.10.17 se valida el concepto obligatorio
                        if (og_cargos.Rows[ec.Cell.Row.Index].Cells[0].Value.ToString() == "True" && og_cargos.Rows[ec.Cell.Row.Index].Cells[q].Value.ToString() == "S" && !mensajeSi)
                        {
                            general.mensajeERROR("El Valor [Cuenta: " + og_cargos.Rows[ec.Cell.Row.Index].Cells[a].Value.ToString() + " - Consecutivo: " + og_cargos.Rows[ec.Cell.Row.Index].Cells[h].Value.ToString() + "] en Reclamo debe ser editado por el Usuario");
                            mensajeSi = true;
                        }
                    }
                    else
                    {
                        String concepto = og_cargos.Rows[ec.Cell.Row.Index].Cells[c].Value.ToString().Split('-')[0].ToString();
                        if (og_cargos.Rows[ec.Cell.Row.Index].Cells[0].Value.ToString() == "False" && int.Parse(concepto) == int.Parse(conceptoConsumo))
                        {
                            //CALCULO EL TOTAL DE FILAS
                            int totalFila = og_cargos.Rows.Count;
                            String ccSelec = og_cargos.Rows[ec.Cell.Row.Index].Cells[a].Value.ToString();
                            //RECORRO LA GRILLA PARA VALIDAR LOS VALORES REGISTRADOS
                            for (int y = 0; y <= totalFila - 1; y++)
                            {
                                if (y != ec.Cell.Row.Index)
                                {
                                    String[] p1 = new string[] { "Int64" };
                                    String[] p2 = new string[] { "inuConc" };
                                    String[] p3 = new string[] { og_cargos.Rows[y].Cells[c].Value.ToString().Split('-')[0].ToString() };
                                    String RespuestaA = general.valueReturn(BLConsultas.ConceptosdeConsumo, 1, p1, p2, p3, "Int64").ToString();
                                    if (og_cargos.Rows[y].Cells[0].Value.ToString() == "True" && og_cargos.Rows[y].Cells[a].Value.ToString() == ccSelec && RespuestaA == "1")
                                    {
                                        og_cargos.Rows[y].Cells[0].Value = 0;
                                    }
                                }
                            }
                        }
                    }
                    //
                    if (!mensajeSi)
                    {
                        bloqCellChange = true;
                        if (og_cargos.Rows[ec.Cell.Row.Index].Cells[0].Value.ToString() == "True")
                        {
                            Double valorEvaluado = 0;
                            valorEvaluado = Double.Parse(og_cargos.Rows[ec.Cell.Row.Index].Cells[i].Value.ToString());
                            if (valorEvaluado == 0)
                            {
                                og_cargos.Rows[ec.Cell.Row.Index].Cells[i].Value = Double.Parse(og_cargos.Rows[ec.Cell.Row.Index].Cells[e].Value.ToString());
                            }
                        }
                        else
                        {
                            og_cargos.Rows[ec.Cell.Row.Index].Cells[i].Value = 0;
                        }
                        bloqCellChange = false;
                    }
                    actualizarReclamo();
                }
            }
        }

        private void og_cargos_AfterExitEditMode(object sender, EventArgs e)
        {
            //ACTUALIZO EL CAMPO DE VALOR RECLAMADO
            actualizarReclamo();
        }

        private void og_cargos_CellChange(object sender, CellEventArgs ec)
        {
            //bloqueo 05.02.19
            if (!bloqCellChange)
            {
                //CONFIRMAR EL VALOR INGRESADO
                if (ec.Cell.Column.Index == 0)
                {
                    og_cargos.ActiveRow.Activate();
                }
            }
        }

        private void og_cargos_Error(object sender, ErrorEventArgs e)
        {
            //CONTROL EL ERROR DE ULTRAGRID AL INGRESAR VALORES NO VALIDOS EN LA GRILLA (NULOS Y OTROS TIPOS SEGUN LA CLASE DE LA GRILLA)
            if (e.ErrorType == ErrorType.Data)
            {
                e.Cancel = true;
            }
        }

        private void og_cargos_KeyPress(object sender, KeyPressEventArgs e)
        {
            UltraGrid grid = sender as UltraGrid;
            UltraGridCell activeCell = grid.ActiveCell;
            //VERIFICO SI EL USUARIO PRESIONO ENTER PARA FINALIZAR REGISTRO EN CELDA DE LA GRILLA
            int totalFila = og_cargos.Rows.Count;
            if (e.KeyChar == (char)Keys.Return)// && columnaS == false)
            {
                //10.08.17 VALIDACION POR NOMBRE DE COLUMNA
                if (activeCell.Column.Key == i)
                {
                    filaSeleccionada = activeCell.Row.Index;// +1;
                    if (filaSeleccionada <= totalFila - 1)
                    {
                        //
                        og_cargos.Rows[filaSeleccionada].Activate();
                        Double valorEvaluado = 0;
                        valorEvaluado = Double.Parse(og_cargos.ActiveRow.Cells[i].Value.ToString());
                        if (valorEvaluado > 0)
                        {
                            if (og_cargos.ActiveRow.Cells[0].Value.ToString() == "False")
                            {
                                inicio = true;
                                og_cargos.ActiveRow.Cells[0].Value = 1;
                                og_cargos.ActiveRow.Appearance.FontData.Bold = DefaultableBoolean.False;
                                inicio = false;
                            }
                        }
                        else
                        {
                            inicio = true;
                            og_cargos.ActiveRow.Cells[0].Value = 0;
                            og_cargos.ActiveRow.Appearance.FontData.Bold = DefaultableBoolean.True;
                            inicio = false;
                        }
                        //
                        if (filaSeleccionada < totalFila - 1)
                        {
                            filaSeleccionada++;
                        }
                        og_cargos.Rows[filaSeleccionada].Cells[i].Activate();
                        //og_cargos.PerformAction(UltraGridAction.EnterEditMode);
                    }
                    else
                    {
                        og_cargos.ActiveRow.Activate();
                    }
                }
                else
                {
                    og_cargos.ActiveRow.Activate();
                }
            }
            //ACTUALIZO EL CAMPO DE VALOR RECLAMADO
            actualizarReclamo();
        }

        private void toolStripButton2_Click(object sender, EventArgs e)
        {
            //15.08.17 LIMPIAR LISTA
            int totalFila = chkl_solicitudes.Items.Count;
            for (int j = totalFila - 1; j >= 0; j--)
            {
                chkl_solicitudes.Items.RemoveAt(j);
            }
            //chk_sel.Checked = false;
            pn_grilla.Visible = false;
            pn_lista.Visible = false;
            tipoReclamo = 0;
        }

        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            //ELIMINO LOS ELEMENTOS SELECCIONADOS DE LA LISTA
            int totalFila = chkl_solicitudes.Items.Count;
            for (int j = totalFila - 1; j >= 0; j--)
            {
                if (chkl_solicitudes.GetItemChecked(j))
                {
                    chkl_solicitudes.Items.RemoveAt(j);
                }
            }
            //ACTUALIZO EL CAMPO DE VALOR RECLAMADO
            actualizarReclamo();
            //
            if (chkl_solicitudes.Items.Count == 0)
            {
                pn_grilla.Visible = false;
                pn_lista.Visible = false;
                tipoReclamo = 0;
            }
        }

        private void cmb_solicitud_ValueChanged(object sender, EventArgs e)
        {
            if (!inicio)
            {
                solicitudSeleccionada = cmb_solicitud.Value.ToString();
            }
        }

        private void btn_norec_Click(object sender, EventArgs ec)
        {
            Boolean aplicar = true;
            //DETERMINO LOS CARGOS APLICADOS AL RECLAMO SELECCIONADO
            int totalFila = og_cargos.Rows.Count;
            //DataTable Datos = general.getValueList(BLConsultas.CargosReclamo.Replace("&reclamo&", cmb_solicitud.Value.ToString()));
            //22.08.17 CAMBIO POR SERVICIO DE RECLAMOS
            String[] tipos = { "Int64" };
            String[] campos = { "inupackage" };
            object[] valores = { cmb_solicitud.Value.ToString() };
            DataTable Datos = general.cursorProcedure(BLConsultas.ValoresNoReclamados, 1, tipos, campos, valores);
            //22.02.19 Valido si es un reclamo u otra cosa
            if (Datos.Rows.Count == 0)
            {
                general.mensajeERROR("No es posible realizar la acción solicitada.");
            }
            else
            {
                if (pn_lista.Visible)
                {
                    general.mensajeERROR("Los reclamos deben se de un mismo tipo para ser agregados.");
                }
                else
                {
                    Boolean ingresoCiclo = false;
                    //ASIGNO LOS VALORES QUE POSEE EL RECLAMO SELECCIONADO A LA GRILLA
                    for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                    {
                        String validUnit_p = Datos.Rows[x].ItemArray[15].ToString();
                        if (validUnit_p == "")
                        {
                            validUnit_p = "0";
                        }
                        Double validUnit = Double.Parse(validUnit_p);
                        Double validVlrfact = 0;
                        if (Datos.Rows[x].ItemArray[4].ToString() != "")
                        {
                            validVlrfact = Double.Parse(Datos.Rows[x].ItemArray[4].ToString());
                        }
                        Double validVlrRecl = 0;
                        if (Datos.Rows[x].ItemArray[8].ToString() != "")
                        {
                            validVlrRecl = Double.Parse(Datos.Rows[x].ItemArray[8].ToString());
                        }
                        //VERIFICO, SI EL CARGO DE LA FACTURA NO ESTA ASIGNADO, LA VARIABLE APLICAR NO CAMBIARA DE VALOR
                        for (int y = 0; y <= totalFila - 1; y++)
                        {
                            //15.08.17 SE VALIDA EL RESTO DE CONTENIDO
                            //13.10.17 SE ADICIONA LA VALIDACION CON LAS UNIDADES
                            if (og_cargos.Rows[y].Cells[a].Value.ToString() == Datos.Rows[x].ItemArray[0].ToString() && og_cargos.Rows[y].Cells[b].Value.ToString() == Datos.Rows[x].ItemArray[1].ToString() && og_cargos.Rows[y].Cells[c].Value.ToString() == Datos.Rows[x].ItemArray[2].ToString() && og_cargos.Rows[y].Cells[d].Value.ToString() == Datos.Rows[x].ItemArray[3].ToString() && og_cargos.Rows[y].Cells[e].Value.ToString() == validVlrfact.ToString() && og_cargos.Rows[y].Cells[f].Value.ToString() == Datos.Rows[x].ItemArray[5].ToString() && og_cargos.Rows[y].Cells[g].Value.ToString() == Datos.Rows[x].ItemArray[6].ToString() && og_cargos.Rows[y].Cells[h].Value.ToString() == Datos.Rows[x].ItemArray[7].ToString() && og_cargos.Rows[y].Cells[j].Value.ToString() == Datos.Rows[x].ItemArray[9].ToString() && og_cargos.Rows[y].Cells[k].Value.ToString() == Datos.Rows[x].ItemArray[10].ToString() && og_cargos.Rows[y].Cells[l].Value.ToString() == Datos.Rows[x].ItemArray[11].ToString() && og_cargos.Rows[y].Cells[m].Value.ToString() == Datos.Rows[x].ItemArray[12].ToString() && og_cargos.Rows[y].Cells[n].Value.ToString() == Datos.Rows[x].ItemArray[13].ToString() && og_cargos.Rows[y].Cells[o].Value.ToString() == Datos.Rows[x].ItemArray[14].ToString() && og_cargos.Rows[y].Cells[r].Value.ToString() == validUnit.ToString())
                            {
                                aplicar = false;
                            }
                        }
                        if (aplicar)
                        {
                            lDVALRECcargosBindingSource.AddNew();
                            ingresoCiclo = true;
                            og_cargos.Rows[totalFila].Cells[a].Value = Datos.Rows[x].ItemArray[0].ToString();
                            og_cargos.Rows[totalFila].Cells[b].Value = Datos.Rows[x].ItemArray[1].ToString();
                            og_cargos.Rows[totalFila].Cells[c].Value = Datos.Rows[x].ItemArray[2].ToString();
                            //VALIDACION DEL CONCEPTO , SI ES SELECCIONABLE O NO 22.09.17
                            String conceptoId = Datos.Rows[x].ItemArray[2].ToString().Split('-')[0].Trim().ToString();
                            //
                            og_cargos.Rows[totalFila].Cells[d].Value = Datos.Rows[x].ItemArray[3].ToString();
                            og_cargos.Rows[totalFila].Cells[e].Value = validVlrfact;
                            og_cargos.Rows[totalFila].Cells[f].Value = Datos.Rows[x].ItemArray[5].ToString();
                            //VALIDACION DE LA CAUSAL 05.02.19
                            String causalId = Datos.Rows[x].ItemArray[5].ToString().Split('-')[0].Trim().ToString();
                            //
                            og_cargos.Rows[totalFila].Cells[g].Value = Datos.Rows[x].ItemArray[6].ToString();
                            og_cargos.Rows[totalFila].Cells[h].Value = Datos.Rows[x].ItemArray[7].ToString();
                            og_cargos.Rows[totalFila].Cells[i].Value = validVlrRecl;
                            og_cargos.Rows[totalFila].Cells[j].Value = Datos.Rows[x].ItemArray[9].ToString();
                            og_cargos.Rows[totalFila].Cells[k].Value = Datos.Rows[x].ItemArray[10].ToString();
                            og_cargos.Rows[totalFila].Cells[l].Value = Datos.Rows[x].ItemArray[11].ToString();
                            og_cargos.Rows[totalFila].Cells[m].Value = Datos.Rows[x].ItemArray[12].ToString();
                            og_cargos.Rows[totalFila].Cells[n].Value = Datos.Rows[x].ItemArray[13].ToString();
                            og_cargos.Rows[totalFila].Cells[o].Value = Datos.Rows[x].ItemArray[14].ToString();
                            //BLOQUEO DE FILA 22.09.17
                            //VALOR ABONADO PARA EL CARGO DE LA FACTURA
                            String[] p1_1 = new string[] { "Int64" };
                            String[] p2_1 = new string[] { "inConcepto" };
                            String[] p3_1 = new string[] { conceptoId };
                            String RespuestaB = general.valueReturn(BLConsultas.excluyeconcepto, 1, p1_1, p2_1, p3_1, "String").ToString();
                            og_cargos.Rows[totalFila].Cells[p].Value = RespuestaB;
                            if (RespuestaB == "N")
                            {
                                og_cargos.Rows[totalFila].Cells[p].Value = RespuestaB + "1";
                                og_cargos.Rows[totalFila].Cells[i].Activation = Activation.NoEdit;
                            }
                            else
                            {
                                //exclusion de causales 05.02.19
                                String[] p1_3 = new string[] { "Int64" };
                                String[] p2_3 = new string[] { "inConcepto" };
                                String[] p3_3 = new string[] { causalId };
                                RespuestaB = general.valueReturn(BLConsultas.excluyecausal, 1, p1_3, p2_3, p3_3, "String").ToString();
                                og_cargos.Rows[totalFila].Cells[p].Value = RespuestaB;
                                if (RespuestaB == "N")
                                {
                                    og_cargos.Rows[totalFila].Cells[p].Value = RespuestaB + "2";
                                    og_cargos.Rows[totalFila].Cells[i].Activation = Activation.NoEdit;
                                }
                            }
                            //13.10.17 VALIDACION DE CONCEPTO OBLIGATORIO SI SE SELCCIONA
                            String[] p1_2 = new string[] { "Int64" };
                            String[] p2_2 = new string[] { "inConcepto" };
                            String[] p3_2 = new string[] { conceptoId };
                            String RespuestaC = general.valueReturn(BLConsultas.ConceptosObligatorioValor, 1, p1_2, p2_2, p3_2, "String").ToString();
                            og_cargos.Rows[totalFila].Cells[q].Value = RespuestaC;
                            //13.10.17 unidades - se asigna 0 pues no hay unidades en el registro
                            og_cargos.Rows[totalFila].Cells[r].Value = validUnit;
                            //22.02.19 solicitud
                            og_cargos.Rows[totalFila].Cells[s].Value = "";
                            totalFila++;
                            inicio = true;
                            //chk_sel.Checked = false;
                            inicio = false;
                        }
                        aplicar = true;
                    }
                    //Observacion 10.07.18 activar fila 1 cuando se agregan nuevos registros
                    if (ingresoCiclo)
                    {
                        og_cargos.Rows[0].Activate();
                        tipoReclamo = 2;
                        pn_lista.Visible = false;
                        pn_grilla.Visible = true;
                        //ACTUALIZO EL VALOR TOTAL EN LOS RECLAMOS
                        actualizarReclamo();
                    }
                    else
                    {
                        general.mensajeERROR("No se ingreso ningún Concepto al Reclamo");
                    }
                }
            }
        }

        int filaActiva = -1;

        private void og_cargos_AfterEnterEditMode(object sender, EventArgs e)
        {
            filaActiva = og_cargos.ActiveRow.Index;
        }

        private void og_cargos_AfterCellActivate(object sender, EventArgs e)
        {
            if (filaActiva >= 0 && filaActiva <= og_cargos.Rows.Count - 1)
            {
                String concepto = og_cargos.Rows[filaActiva].Cells[c].Value.ToString().Split('-')[0].ToString();
                if (Double.Parse(og_cargos.Rows[filaActiva].Cells[i].Value.ToString()) == Double.Parse("0") && og_cargos.Rows[filaActiva].Cells[0].Value.ToString() == "True" && int.Parse(concepto) == int.Parse(conceptoConsumo) && og_cargos.ActiveCell.Column.Index != 0 && og_cargos.ActiveRow.Index != filaActiva)
                {
                    inicio = true;
                    general.mensajeERROR("No ha digitado valor reclamado para el concepto " + og_cargos.Rows[filaActiva].Cells[c].Value.ToString().Split('-')[0].ToString());
                    og_cargos.Rows[filaActiva].Cells[i].Activate();
                    inicio = false;
                }
            }
        }

    }
}
