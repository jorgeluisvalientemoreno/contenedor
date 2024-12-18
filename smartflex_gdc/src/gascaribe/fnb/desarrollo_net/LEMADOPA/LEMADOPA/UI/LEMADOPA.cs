using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
//LIBRERIAS DE OPEN
using OpenSystems.Windows.Controls;
//LIBRERIAS DEL PROYECTO
using LEMADOPA.BL;
using Infragistics.Win.UltraWinGrid;

namespace LEMADOPA.UI
{
    public partial class LEMADOPA : OpenForm
    {

        //LIBRERIA PRINCIPAL
        BLGENERAL general = new BLGENERAL();
        //COLUMNAS GRILLA DE BUSQUEDA
        String a = "seleccion";
        String b = "numOrden";
        String c = "nombreUsuario";
        String d = "solicitud";
        String e = "numContrato";
        String f = "fechaCreacion";
        String g = "fechaAsign";
        String h = "observacion";
        //PROCEDIMIENTOS Y FUNCIONES PARA EL PROYECTO DE ORACLE
        String cursorCausales = "LDCI_PKLEMADOPA.fnConsulCausLEMADOPA";
        String cursorBusqueda = "LDCI_PKLEMADOPA.fnConsultaLEMADOPA";
        String legalizacionDocumento = "LDCI_PKLEMADOPA.fnActualizaLEMADOPA";

        //Inicio CASO 200-1880
        String i = "proveedor";
        String rfLVProvCont = "LDCI_PKLEMADOPA.frfLVProvCont";
        //Fin CASO 200-1880

        public LEMADOPA()
        {
            InitializeComponent();
            //COMBO DE CAUSALES
            String[] tipos = { "" };
            String[] campos = { "" };
            object[] valores = { "" };
            DataTable Datos = general.cursorProcedure(cursorCausales, 0, tipos, campos, valores);
            cmb_causal.DataSource = Datos;
            cmb_causal.ValueMember = "ID";
            cmb_causal.DisplayMember = "DESCRIPTION";

            //Inicio CASO 200-1880
            DataTable LVDatos = general.cursorProcedure(rfLVProvCont, 0, tipos, campos, valores);
            oCProveedor.DataSource = LVDatos;
            oCProveedor.ValueMember = "ID";
            oCProveedor.DisplayMember = "DESCRIPTION";
            //Fin CASO 200-1880
        
        }

        void limpiar()
        {
            //LIMPIO LA GRILLA
            if (ug_datos.Rows.Count > 0)
            {
                for (int y = ug_datos.Rows.Count - 1; y >= 0; y--)
                {
                    ug_datos.Rows[y].Delete(false);
                }
            }
        }

        private void btn_buscar_Click(object sender, EventArgs ef)
        {
            limpiar();
            //ASIGNO LOS VALORES PARA LA BUSQUEDA
            String var1, var2, var3, var4, var5, var6;
            var1 = txt_ordentrabajo.TextBoxValue;
            var2 = txt_contrato.TextBoxValue;
            var3 = txt_solicitud.TextBoxValue;
            var4 = txt_fechainicial.TextBoxValue;
            var5 = txt_fechafinal.TextBoxValue;
            //Inicio CASO 200-1880
            if (String.IsNullOrEmpty(oCProveedor.Text))
            {
                var6 = null;
            }
            else
            {
                var6 = oCProveedor.Value.ToString();
            }
            //Fin CASO 200-1880
            //OBSERVACION: SE BLOQUEA LA RESTRICCION DE MINIMO DE DATOS, SE DEJARA OPCIONAL TODOS SIN UN MINIMO OBLIGATORIO
            //VALIDO SI SE INGRESO AL MENOS UN VALOR
            /*if (String.IsNullOrEmpty(var1) && String.IsNullOrEmpty(var2) && String.IsNullOrEmpty(var3) && String.IsNullOrEmpty(var4) && String.IsNullOrEmpty(var5))
            {
                general.mensajeERROR("Debe ingresar al menos un dato para la Busqueda.");
            }
            else
            {*/
                //CONSULTO LOS CARGOS DE LA FACTURA
                String[] tipos = { "Int64", "Int64", "Int64", "DateTime", "DateTime", "Int64" };
                String[] campos = { "inususc", "inuord", "inupack", "idtfeccreini", "idtfeccrefin", "inuprovcont" };
                object[] valores = { var2, var1, var3, var4, var5, var6 };
                DataTable Datos = general.cursorProcedure(cursorBusqueda, 6, tipos, campos, valores);
                //VERIFICO QUE HAYAN RESPUESTAS EN EL CURSOR
                if (Datos.Rows.Count == 0)
                {
                    general.mensajeERROR("Los Criterios de Busqueda ingresados no retornarón ningún Resultado. Revise la Información digitada.");
                }
                else
                {
                    //RECORRO EL CURSOR PARA ASIGNAR LOS RESULTADOS A LA GRILLA
                    for (int x = 0; x <= Datos.Rows.Count - 1; x++)
                    {
                        dATOSBUSQUEDABindingSource.AddNew();
                        ug_datos.Rows[x].Cells[a].Value = 0;
                        ug_datos.Rows[x].Cells[b].Value = Double.Parse(Datos.Rows[x].ItemArray[0].ToString());
                        ug_datos.Rows[x].Cells[c].Value = Datos.Rows[x].ItemArray[1].ToString();
                        ug_datos.Rows[x].Cells[d].Value = Double.Parse(Datos.Rows[x].ItemArray[2].ToString());
                        ug_datos.Rows[x].Cells[e].Value = Double.Parse(Datos.Rows[x].ItemArray[3].ToString());
                        ug_datos.Rows[x].Cells[f].Value = DateTime.Parse(Datos.Rows[x].ItemArray[4].ToString());
                        ug_datos.Rows[x].Cells[g].Value = DateTime.Parse(Datos.Rows[x].ItemArray[5].ToString());
                        ug_datos.Rows[x].Cells[h].Value = "";
                        //CASO 200-1880
                        ug_datos.Rows[x].Cells[i].Value = Datos.Rows[x].ItemArray[6].ToString();
                        //fin CASO 200-1880
                    }
                }
            //}
        }

        private void btn_cancelar_Click(object sender, EventArgs e)
        {
            //CIERRO LA FORMA
            this.Close();
        }

        private void btn_limpiar_Click(object sender, EventArgs e)
        {
            //LIMPIANDO DATOS DE CONSULTA
            txt_ordentrabajo.TextBoxValue = "";
            txt_contrato.TextBoxValue = "";
            txt_solicitud.TextBoxValue = "";
            txt_fechainicial.TextBoxValue = "";
            txt_fechafinal.TextBoxValue = "";
            //LIMPIANDO RESULTADOS DE BUSQUEDA
            limpiar();
        }

        private void LEMADOPA_Load(object sender, EventArgs ef)
        {
            //ESTILOS DE LAS COLUMNAS PRINCIPALES
            ug_datos.DisplayLayout.Bands[0].Columns[b].CellActivation = Activation.NoEdit;
            ug_datos.DisplayLayout.Bands[0].Columns[c].CellActivation = Activation.NoEdit;
            ug_datos.DisplayLayout.Bands[0].Columns[d].CellActivation = Activation.NoEdit;
            ug_datos.DisplayLayout.Bands[0].Columns[e].CellActivation = Activation.NoEdit;
            ug_datos.DisplayLayout.Bands[0].Columns[f].CellActivation = Activation.NoEdit;
            ug_datos.DisplayLayout.Bands[0].Columns[g].CellActivation = Activation.NoEdit;
            ug_datos.DisplayLayout.Bands[0].Columns[h].CellActivation = Activation.NoEdit;
            //CASO 200-1880
            ug_datos.DisplayLayout.Bands[0].Columns[i].CellActivation = Activation.NoEdit;
            //fin CASO 200-1880
        }

        private void ug_datos_DoubleClickCell(object sender, DoubleClickCellEventArgs e)
        {
            //VERIFICO QUE HAYA DADO DOBLE CLIC EN LA CELDA DE OBSERVACIONES
            if (e.Cell.Column.ToString() == h)
            {
                //LLAMO LA FORMA DE LAS OBSERVACIONES Y ASIGNO LOS VALORES EN LA GRILLA Y LOS REASIGNO A LA CELDA
                FRMTEXTO forma = new FRMTEXTO("Observacion", "Ingresar", 1600, ug_datos.Rows[e.Cell.Row.Index].Cells[h].Value.ToString());
                forma.ShowDialog();
                ug_datos.Rows[e.Cell.Row.Index].Cells[h].Value = forma.texto;
            }
        }

        public Boolean validar()
        {
            if (ug_datos.Rows.Count == 0)
            {
                general.mensajeERROR("Debe realizar una Busqueda.");
                return false;
            }

            //Inicio CASO 200-1880
            Int64 nuBLFnuValidaCausal = 0;
            nuBLFnuValidaCausal = BLGENERAL.BLFnuValidaCausal(Convert.ToInt64(cmb_causal.Value.ToString()));
            //Fin CASO 200-1880

            if (ug_datos.Rows.Count > 0)
            {
                int contMarcados = 0;
                for (int i = 0; i <= ug_datos.Rows.Count - 1; i++)
                {
                    if (ug_datos.Rows[i].Cells[a].Value.ToString() == "True")
                    {
                        contMarcados++;
                        //if (string.IsNullOrEmpty(ug_datos.Rows[i].Cells[h].Value.ToString().Trim()))
                        if (string.IsNullOrEmpty(ug_datos.Rows[i].Cells[h].Value.ToString().Trim()) && nuBLFnuValidaCausal == 2)
                        {
                            general.mensajeERROR("Las Observaciones en las Ordenes Seleccionadas son Obligatorias.");
                            return false;
                        }
                    }
                }
                if (contMarcados == 0)
                {
                    general.mensajeERROR("Debe seleccionar al menos una Orden para legalizar los Documentos.");
                    return false;
                }
            }
            if (string.IsNullOrEmpty(cmb_causal.Text))
            {
                general.mensajeERROR("Debe seleccionar una Causal para legalizar los Documentos.");
                cmb_causal.Focus();
                return false;
            }
            return true;
        }

        private void btn_procesar_Click(object sender, EventArgs ef)
        {
            //VALIDO QUE SE HALLA SELECCIONADO UNA CAUSAL
            if (validar())
            {
                //RECORRO LA GRILLA PARA GUARDAR LOS RESULTADOS
                for (int x = 0; x <= ug_datos.Rows.Count - 1; x++)
                {
                    //Inicio CASO 200-1880
                    //Agregar comentario si es NULO ya que el servicio de OPEN necesita que la observacion este llena
                    if (string.IsNullOrEmpty(ug_datos.Rows[x].Cells[h].Value.ToString().Trim()))
                    {
                        ug_datos.Rows[x].Cells[h].Value = "LEMADOPA";
                    }
                    //Fin CASO 200-1880
                    if (ug_datos.Rows[x].Cells[a].Value.ToString() == "True")
                    {
                        String[] tipos = { "Int64", "Int64", "String" };
                        String[] campos = { "inuord", "inuCaus", "isbObserv" };
                        object[] valores = { ug_datos.Rows[x].Cells[b].Value.ToString(), cmb_causal.Value, ug_datos.Rows[x].Cells[h].Value.ToString() };
                        general.valueReturn(legalizacionDocumento, 3, tipos, campos, valores, "Int64");
                    }
                }
                general.doCommit();
                //LIMPIANDO DATOS DE CONSULTA
                txt_ordentrabajo.TextBoxValue = "";
                txt_contrato.TextBoxValue = "";
                txt_solicitud.TextBoxValue = "";
                txt_fechainicial.TextBoxValue = "";
                txt_fechafinal.TextBoxValue = "";
                //LIMPIANDO RESULTADOS DE BUSQUEDA
                limpiar();
                //
                general.mensajeOk("El proceso ha Finalizado.");
            }
        }

        private void btn_seleccion_Click(object sender, EventArgs e)
        {
            //VERIFICO QUE HAYA FILAS PARA SELECCIONAR
            if (ug_datos.Rows.Count > 0)
            {
                //VERIFICO SI HAY FILAS MARCADAS
                int contMarcados = 0;
                for (int i = 0; i <= ug_datos.Rows.Count - 1; i++)
                {
                    if (ug_datos.Rows[i].Cells[a].Value.ToString() == "True")
                    {
                        contMarcados++;
                    }
                }
                //MARCO TODAS LAS FILAS SI HAY AL MENOS 1
                Boolean marca;
                if (contMarcados > 0)
                {
                    if (contMarcados == ug_datos.Rows.Count)
                    {
                        marca = false;
                    }
                    else
                    {
                        marca = true;
                    }
                }
                else
                {
                    marca = true;
                }
                for (int i = 0; i <= ug_datos.Rows.Count - 1; i++)
                {
                    ug_datos.Rows[i].Cells[a].Value = marca;
                }
            }
        }

    }
}
