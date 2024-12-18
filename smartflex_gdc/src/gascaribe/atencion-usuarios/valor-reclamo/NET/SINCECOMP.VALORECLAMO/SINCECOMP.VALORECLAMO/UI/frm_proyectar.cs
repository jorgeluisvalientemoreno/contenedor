using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using Infragistics.Win.UltraWinGrid;
using SINCECOMP.VALORECLAMO.Entities;
using Infragistics.Win;
using SINCECOMP.VALORECLAMO.BL;

namespace SINCECOMP.VALORECLAMO.UI
{
    public partial class frm_proyectar : OpenForm
    {

        //VARIABLES GENERALES
        public List<LDVALREC_proyectar> lista = new List<LDVALREC_proyectar>(); //Lista principal a cargar en la grilla principal
        public List<LDVALREC_cargos> listacopia = new List<LDVALREC_cargos>(); //Lista principal a cargar en la grilla copia
        BL.BLGENERAL general = new BL.BLGENERAL(); //Variable de procesos generales
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
        String p = "editable";
        String q = "concepoblig";//13.10.17 columna para saber si cuando se selcciona es obligatorio editar
        String r = "unit";//13.10.17 columna para manejar unidades
        String s = "solicitud";
        String TipoForma = "";

        /// <summary>
        /// CONSTRUCTOR DEL FORMULARIO PROYECTAR
        /// </summary>
        /// <param name="datosGrilla">DATOS DE LA GRILLA DEL FORMULARIO MAESTRO</param>
        public frm_proyectar(UltraGrid datosGrilla, String tipoForma, DataRow[] dtr)
        {
            InitializeComponent();
            //INICIO DEL PROCESO DE CARGA EN LA FORMA
            String solicitud = "";
            String cuenta = "";
            String ano = "";
            String mes = "";
            Double total = 0;
            Double aprobado = 0;
            Double pendiente = 0;
            Double reclamo = 0;
            DateTime fecha = DateTime.Now;
            TipoForma = tipoForma;
            //VERIFICO QUE LA GRILLA DE DATOS DEL FORMULARIO MAESTRO POSEE REGISTROS
            if (datosGrilla.Rows.Count > 0)
            {
                if (TipoForma == "1")
                {
                    if (dtr.Length > 0)
                    {
                        foreach (var drow in dtr)
                        {
                            LDVALREC_cargos fila = new LDVALREC_cargos
                            {
                                selection = true,
                                cuenta = drow.ItemArray[1].ToString(),
                                product = Int64.Parse(drow.ItemArray[2].ToString()),
                                concept = drow.ItemArray[3].ToString(),
                                signed = drow.ItemArray[4].ToString(),
                                VLR_FACTURADO = Double.Parse(drow.ItemArray[5].ToString()),
                                CAUSAL = drow.ItemArray[6].ToString(),
                                DOCUMENTO = drow.ItemArray[7].ToString(),
                                CONSECUTIVO = drow.ItemArray[8].ToString(),
                                VLR_RECLAMADO = Double.Parse(drow.ItemArray[9].ToString()),
                                factura = drow.ItemArray[10].ToString(),
                                ano = drow.ItemArray[11].ToString(),
                                mes = drow.ItemArray[12].ToString(),
                                saldo = drow.ItemArray[13].ToString(),
                                fecha = DateTime.Parse(drow.ItemArray[14].ToString()),
                                VLRTOTAL = drow.ItemArray[15].ToString(),
                                editable = drow.ItemArray[16].ToString(),
                                concepoblig = drow.ItemArray[17].ToString(),
                                unit = Double.Parse(drow.ItemArray[18].ToString()),
                                solicitud = drow.ItemArray[19].ToString()
                            };
                            //AGREGO EL VALOR
                            this.listacopia.Add(fila);
                        }
                    }
                }
                else
                {            
                    //copia resultados grilla
                    for (int x = 0; x <= datosGrilla.Rows.Count - 1; x++)
                    {
                        LDVALREC_cargos fila = new LDVALREC_cargos
                        {
                            selection = Boolean.Parse(datosGrilla.Rows[x].Cells[0].Value.ToString()),
                            cuenta = datosGrilla.Rows[x].Cells[a].Value.ToString(),
                            product = Int64.Parse(datosGrilla.Rows[x].Cells[b].Value.ToString()),
                            concept  = datosGrilla.Rows[x].Cells[c].Value.ToString(),
                            signed = datosGrilla.Rows[x].Cells[d].Value.ToString(),
                            VLR_FACTURADO  = Double.Parse(datosGrilla.Rows[x].Cells[e].Value.ToString()),
                            CAUSAL  = datosGrilla.Rows[x].Cells[f].Value.ToString(),
                            DOCUMENTO = datosGrilla.Rows[x].Cells[g].Value.ToString(),
                            CONSECUTIVO  = datosGrilla.Rows[x].Cells[h].Value.ToString(),
                            VLR_RECLAMADO  = Double.Parse(datosGrilla.Rows[x].Cells[i].Value.ToString()),
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
                        this.listacopia.Add(fila);
                    }
                }

                //Logica Original sin modificacion de CASO 275
                lDVALRECcargosBindingSource.DataSource = this.listacopia;
                //
                dtg_copia.DisplayLayout.Bands[0].Columns[s].SortIndicator = SortIndicator.Ascending;
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
                            solicitud = dtg_copia.Rows[x].Cells[s].Value.ToString();
                            cuenta = dtg_copia.Rows[x].Cells[a].Value.ToString();
                            ano = dtg_copia.Rows[x].Cells[k].Value.ToString();
                            mes = dtg_copia.Rows[x].Cells[l].Value.ToString();
                            total = 0;
                            if (dtg_copia.Rows[x].Cells[o].Value.ToString() != "")
                            {
                                total = Double.Parse(dtg_copia.Rows[x].Cells[o].Value.ToString());
                            }
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
                                    {}
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
                                agregar(solicitud, cuenta, ano, mes, total, aprobado, pendiente, reclamo, fecha);
                                solicitud = dtg_copia.Rows[x].Cells[s].Value.ToString();
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
                    agregar(solicitud, cuenta, ano, mes, total, aprobado, pendiente, reclamo, fecha);
                    //ASIGNO A LA GRILLA LA LISTA PRINCIPAL CON LOS ACUMULADOS
                    lDVALRECproyectarBindingSource.DataSource = this.lista;
                }
            }
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
        private void agregar(String solicitud, String cuenta, String ano, String mes, Double total, Double aprobado, Double pendiente, Double reclamo, DateTime fecha)
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
                solicitud = solicitud,
                cuenta = Int64.Parse(cuenta),
                ano = Int64.Parse(ano),
                mes = Int64.Parse(mes),
                valortotal = total,
                valoraprobado = ValorAbono,
                saldopendiente = ValorPendiente,
                valorreclamo = reclamo,
                fechageneracion = fecha
            };
            //AGREGO EL VALOR
            this.lista.Add(fila);
        }

        private void frm_proyectar_Load(object sender, EventArgs e)
        {
            //ESTILO DE LAS COLUMNAS DE LA GRILLA
            dtg_datos.DisplayLayout.Bands[0].Columns["valortotal"].Format = "$ #,##0.00";
            dtg_datos.DisplayLayout.Bands[0].Columns["valortotal"].CellAppearance.TextHAlign = HAlign.Right;
            dtg_datos.DisplayLayout.Bands[0].Columns["valoraprobado"].Format = "$ #,##0.00";
            dtg_datos.DisplayLayout.Bands[0].Columns["valoraprobado"].CellAppearance.TextHAlign = HAlign.Right;
            dtg_datos.DisplayLayout.Bands[0].Columns["saldopendiente"].Format = "$ #,##0.00";
            dtg_datos.DisplayLayout.Bands[0].Columns["saldopendiente"].CellAppearance.TextHAlign = HAlign.Right;
            dtg_datos.DisplayLayout.Bands[0].Columns["valorreclamo"].Format = "$ #,##0.00";
            dtg_datos.DisplayLayout.Bands[0].Columns["valorreclamo"].CellAppearance.TextHAlign = HAlign.Right;
            dtg_datos.DisplayLayout.Bands[0].Columns["fechageneracion"].Format = "dd'/'MM'/'yyyy";
            if(TipoForma == "1")
            {
                dtg_datos.DisplayLayout.Bands[0].Columns["solicitud"].Hidden = true;
            }
        }

        private void dtg_datos_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            if (Double.Parse(e.Row.Cells["valorreclamo"].Value.ToString()) < 0)
            {
                e.Row.Cells["valorreclamo"].Appearance.ForeColor = Color.Red;
            }
        }
    }
}
