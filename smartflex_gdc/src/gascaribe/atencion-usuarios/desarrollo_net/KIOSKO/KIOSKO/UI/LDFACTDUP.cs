using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

using OpenSystems.Windows.Controls;
using KIOSKO.BL;
using KIOSKO.Report;
using KIOSKO.Entities;
using System.Text.RegularExpressions;
using System.Drawing.Text;
using CrystalDecisions.CrystalReports.Engine;
using System.IO;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Drawing.Drawing2D;
using OpenSystems.Common.Data;
using System.Threading;

namespace KIOSKO.UI
{
    public partial class LDFACTDUP : OpenForm
    {

        //parametro para validacion de reglas
        //String parReglas = "";
        //objeto de llamados generales
        BLGENERAL general = new BLGENERAL();
        //objeto de llamados del metodo
        BLLDFACTDUP blLDFACTDUP = new BLLDFACTDUP();
        //longitud maxima en la caja de datos
        int max_long = 14;//30;
        //opcion de buscada seleccionada
        String opcionBusqueda = "";
        //suscripcion
        String suscripcion = "";
        //saldos
        String sant = "";
        String sact = "";
        //valor duplicado
        String valDup = "";
        //Impresion Automatica
        String printerAutomatic = "";
        Int64 valrp = 0;
        DateTime fechmax = DateTime.Today;

        //Variable Booleana para determinar si la tecla presionada es RETROCESO - BACKSPACE
        private bool BoolBACKSPACE = false;

        public LDFACTDUP()
        {
            InitializeComponent();
            /*parReglas = "A"; //asignacion parametro
            if (String.IsNullOrEmpty(parReglas))
            {
                this.Close();
            }*/
            ldfactdup_mensajes Datos = new ldfactdup_mensajes();
            Datos = blLDFACTDUP.consultaMensajes(BLCONSULTAS.ConsultaMensajes);
            lbl_mensaje1.Text = Datos.titulo;
            lbl_mensaje2.Text = Datos.mensaje;
            //Mod 19.12.17
            opcionBusqueda = "contrato";
        }

        #region "Manejo de la caja de datos"

        public Boolean validar_caja_dato()
        {
            int longitud = txt_dato.TextLength;
            //validar longitud
            if (longitud == max_long)
            {
                return false;
            }
            else
            {
                //cambiar tamaño del texto cuando sea mayor al tamaño de la caja
                if (longitud >= 14)
                {
                    Single newsize = 25 - ((longitud + 1) - 14) / 2;
                    //Single sizetext = newsize.ToString() + "F";
                    txt_dato.Font = new System.Drawing.Font("Verdana", newsize);//25F);
                }
            }
            return true;
        }

        public void insertar(String texto)
        {
            if (validar_caja_dato())
            {
                txt_dato.AppendText(texto);
            }
        }

        #endregion

        #region "Numeros del Teclado"

        private void rs_1_Click(object sender, EventArgs e)
        {
            insertar("1");
        }

        private void rs_2_Click(object sender, EventArgs e)
        {
            insertar("2");
        }

        private void rs_3_Click(object sender, EventArgs e)
        {
            insertar("3");
        }

        private void rs_4_Click(object sender, EventArgs e)
        {
            insertar("4");
        }

        private void rs_5_Click(object sender, EventArgs e)
        {
            insertar("5");
        }

        private void rs_6_Click(object sender, EventArgs e)
        {
            insertar("6");
        }

        private void rs_7_Click(object sender, EventArgs e)
        {
            insertar("7");
        }

        private void rs_8_Click(object sender, EventArgs e)
        {
            insertar("8");
        }

        private void rs_9_Click(object sender, EventArgs e)
        {
            insertar("9");
        }

        private void rs_0_Click(object sender, EventArgs e)
        {
            insertar("0");
        }

        #endregion

        private void limpiar()
        {
            txt_dato.Clear();
            txt_dato.Focus();
            ocultar(false);
            //Mod 19.12.17
            //os_selcednit.FillColor = System.Drawing.Color.Transparent;
            //os_selcontrato.FillColor = System.Drawing.Color.Transparent;
        }

        private void rs_limpiar_Click(object sender, EventArgs e)
        {
            limpiar();
        }

        private void rs_buscar_Click(object sender, EventArgs e)
        {
            //proceso de busqueda segun el criterio seleccionado
            //CONSULTO LOS DATOS DE LA FACTURA
            Boolean ingreso = false;
            //Object[] Resultados;
            DataTable Datos = null;
            suscripcion = "";
            sant = "";
            sact = "";
            switch (opcionBusqueda)
            {
                case "":
                    {
                        general.mensajeERROR("Debe Seleccionar un tipo de Busqueda");
                    }
                    break;
                case "cednit":
                    {
                        if (String.IsNullOrEmpty(txt_dato.Text.Trim()))
                        {
                            general.mensajeERROR("Debe Ingresar una Cedula o NIT para iniciar la Busqueda");
                        }
                        else
                        {
                            object[] valores = { "", txt_dato.Text };
                            Datos = blLDFACTDUP.consultaFacturas(BLCONSULTAS.ConsultadeDatos, valores);
                            ingreso = true;
                        }
                    }
                    break;
                case "contrato":
                    {
                        if (String.IsNullOrEmpty(txt_dato.Text.Trim()))
                        {
                            general.mensajeERROR("Debe Ingresar un Contrato para iniciar la Busqueda");
                        }
                        else
                        {
                            object[] valores = { txt_dato.Text, "" };
                            Datos = blLDFACTDUP.consultaFacturas(BLCONSULTAS.ConsultadeDatos, valores);
                            ingreso = true;
                        }
                    }
                    break;
            }
            if (ingreso)
            {
                if (Datos.Rows.Count > 0)
                {
                    ocultar(true);
                    txt_municipio.Text = Datos.Rows[0].ItemArray[2].ToString();
                    txt_direccion.Text = Datos.Rows[0].ItemArray[10].ToString();
                    txt_categoria.Text = Datos.Rows[0].ItemArray[11].ToString();
                    txt_facturaant.Text = "$ " + Datos.Rows[0].ItemArray[5].ToString();
                    txt_facturaact.Text = "$ " + Datos.Rows[0].ItemArray[6].ToString();
                    cmb_imprimir.SelectedIndex = 0;
                    //asignacion variables generales
                    suscripcion = Datos.Rows[0].ItemArray[4].ToString();
                    sact = Datos.Rows[0].ItemArray[6].ToString();
                    sant = Datos.Rows[0].ItemArray[5].ToString();
                    /*if (parReglas == "A")
                    {
                    }*/
                }
                else
                {
                    ocultar(false);
                    general.mensajeERROR("Datos Incorrectos, no hubo ningún resultado para su Busqueda");
                }
            }
        }

        /// <summary>
        /// Ocultar/Desocultar grilla de Datos
        /// </summary>
        /// <param name="accion">true para ver, false para ocultar</param>
        public void ocultar(Boolean accion)
        {
            txt_municipio.Visible = accion;
            txt_direccion.Visible = accion;
            txt_categoria.Visible = accion;
            txt_facturaant.Visible = accion;
            txt_facturaact.Visible = accion;
            cmb_imprimir.Visible = accion;
            btn_imprimir.Visible = accion;
        }

        private void txt_dato_KeyPress(object sender, KeyPressEventArgs e)
        {
            //validacion que permita ingresar solo numeros
            if (!Char.IsNumber(e.KeyChar))
            {
                e.Handled = true;
            }
        }

        private void os_selcednit_Click(object sender, EventArgs e)
        {
            //valido si esta marcada la otra opcion
            if (opcionBusqueda == "contrato")
            {
                os_selcontrato.FillColor = System.Drawing.Color.Transparent;
            }
            //activo la nueva opcion
            opcionBusqueda = "cednit";
            os_selcednit.FillColor = System.Drawing.Color.Black;
        }

        private void os_selcontrato_Click(object sender, EventArgs e)
        {
            //valido si esta marcada la otra opcion
            if (opcionBusqueda == "cednit")
            {
                os_selcednit.FillColor = System.Drawing.Color.Transparent;
            }
            //activo la nueva opcion
            opcionBusqueda = "contrato";
            os_selcontrato.FillColor = System.Drawing.Color.Black;
        }

        private void btn_imprimir_Click(object sender, EventArgs e)
        {
            //valor duplicado
            valDup = general.getParam(BLCONSULTAS.parametroCosto, "Int64").ToString();
            //
            Boolean ejecutar = false;
            String saldo = "";
            String factimp = "";
            switch (cmb_imprimir.Text)
            {
                case "ANTERIOR":
                    {
                        factimp = "0";
                        saldo = sant;
                    }
                    break;
                case "ACTUAL":
                    {
                        factimp = "1";
                        saldo = sact;
                    }
                    break;
                case "SELECCIONE":
                    {
                        general.mensajeERROR("Debe seleccionar una Factura ha Imprimir (Anterior/Actual)?");
                    }
                    break;
            }
            if (factimp != "")
            {
                if (saldo == "0")
                {
                    general.mensajeOk("La factura " + cmb_imprimir.Text.ToLower() + " ya fue Cancelada");
                    limpiar();
                }
                else
                {
                    if (factimp == "0")
                    {
                        if (double.Parse(sant) <= double.Parse(sact))
                        {
                            Question pregunta = new Question("LDFACTDUP - Imprimir", "Va a imprimir la factura de la localidad " + txt_municipio.Text + " Direccion " + txt_direccion.Text, "Si", "No");
                            pregunta.ShowDialog();
                            if (pregunta.answer == 2)
                            {
                                Question pregunta_1 = new Question("LDFACTDUP - Imprimir", "Señor Usuario el duplicado de la factura tiene un costo de $ " + valDup + " Mas IVA. Esta seguro?", "Si", "No");
                                pregunta_1.ShowDialog();
                                if (pregunta_1.answer == 2)
                                {
                                    ejecutar = true;

                                    Gensolicitudrp();// caso:234
                                }
                                else
                                {
                                    limpiar();
                                }
                            }
                            else
                            {
                                limpiar();
                            }
                        }
                        else
                        {
                            general.mensajeOk("Factura Cancelada");
                        }
                    }
                    else
                    {
                        Question pregunta = new Question("LDFACTDUP - Imprimir", "Va a imprimir la factura de la localidad " + txt_municipio.Text + " Direccion " + txt_direccion.Text, "Si", "No");
                        pregunta.ShowDialog();
                        if (pregunta.answer == 2)
                        {
                            Question pregunta_1 = new Question("LDFACTDUP - Imprimir", "Señor Usuario el duplicado de la factura tiene un costo de $ " + valDup + " Mas IVA. Esta seguro?", "Si", "No");
                            pregunta_1.ShowDialog();                            
                            if (pregunta_1.answer == 2)
                            {
                                ejecutar = true;
                                Gensolicitudrp();// caso:234
                                
                            }
                            else
                            {
                                limpiar();
                            }
                        }
                        else
                        {
                            limpiar();
                        }
                    }
                }
                if (ejecutar)
                {
                    //CASO 200-2224
                    Boolean impreOK = true;
                    imprimir(suscripcion, saldo, factimp, out impreOK);
                    if (impreOK)
                    {
                        limpiar();
                    }
                    else
                    {
                        general.mensajeOk("Su duplicado no pudo ser generado. Por favor intente nuevamente o contacte a un funcionario de Atención a Clientes.");
                    }
                }
            }
        }

        private void imprimir(String suscripcion, String saldo, String factimp, out Boolean ExitoI)
        {
            //Parametro de Salida de impresion exitosa
            ExitoI = true;
            //valor duplicado
            printerAutomatic = general.getParam(BLCONSULTAS.parametroImpresion, "String").ToString();
            //
            object[] valores = { suscripcion, saldo, factimp };
            resp_facturacion DatosFactura = blLDFACTDUP.consultaFactura(BLCONSULTAS.ConsultaFactura, valores);
            if (factimp == "0") 
            {
                if (double.Parse(sant) <= double.Parse(sact)) 
                {
                    try
                    {
                        if (DatosFactura.osbprocfact == "S") 
                        {
                            general.mensajeOk("Contrato en proceso de facturación");
                        }
                        if (DatosFactura.osbseguroliberty == "S") 
                        {
                            general.mensajeOk("Va a imprimir la factura de " + txt_municipio.Text + " Direccion " + txt_direccion.Text);
                        } 
                        else 
                        {}
                    } 
                    catch (Exception ex) 
                    {
                        general.mensajeERROR("Inconvenientes durante el proceso de generacion de la factura: " + ex.Message);
                    }
                }
            }
            try
            {
                if(DatosFactura.osbordensusp != "N")
                {
                    string cadenaSinTags = Regex.Replace(DatosFactura.osbordensusp, "<.*?>", string.Empty);
                    general.mensajeOk(cadenaSinTags);
                }
            }
            catch(Exception e)
            {
                general.mensajeERROR("Inconvenientes durante el proceso de generacion de la factura: " + e.Message);
            }
            //bloqueado para compatibilidad con caso 200-1515 y 200-1427
            /*if(DatosFactura != null && DatosFactura.osbimprimir != null && DatosFactura.osbimprimir != "S")
            {}
            else
            {*/
                if (DatosFactura.datos.Tables["datosBasicos"].Rows.Count > 0)
                {

                    String nombreCodigo = "barcode_" + suscripcion + "_" + DateTime.Now.ToString("ddMMyyyyhhmmss");

                    cr_factura plantilla = new cr_factura();

                    //caso 200-2574 - danval - 20-04-19
                    //se retira la generacion del codigo de barras
                    //String cadena = "415" + DatosFactura.datos.Tables["codigos"].Rows[0].ItemArray[0].ToString() + "8020" + DatosFactura.datos.Tables["codigos"].Rows[0].ItemArray[1].ToString() + "s3900" + DatosFactura.datos.Tables["codigos"].Rows[0].ItemArray[2].ToString() + "s96" + DatosFactura.datos.Tables["codigos"].Rows[0].ItemArray[3].ToString();
                    
                    //cargamos los datos para llenar la factura
                    //String[] tipos = { "String" };
                    //String[] campos = { "isbCadeOrig" };
                    //String[] valoresF = { cadena };
                    //cadena = general.valueReturn(BLCONSULTAS.codigoBarra, 1, tipos, campos, valoresF, "String").ToString();

                    //Inicio CASO 200-2224
                    //numero de intentos validos
                    //int intentos = 2;
                    //Direccion 
                    //string DireccionCarpeta = Environment.GetEnvironmentVariable("USERPROFILE") + "//desktop";
                    //Validacion de imagen
                    //int continuar = 1;
                    //do
                    //{
                        //creamos el codigo de barras
                        //convertirTextoImagen(cadena, suscripcion, nombreCodigo);
                        //Thread.Sleep(2000);
                        //general.mensajeOk("Control 1");
                        //if (!System.IO.File.Exists(DireccionCarpeta + "\\" + nombreCodigo + ".png"))
                        //{
                            //continuar++;
                            //ExitoI = false;
                        //}
                        //else
                        //{
                            //FileInfo file = new FileInfo(DireccionCarpeta + "\\" + nombreCodigo + ".png");
                            //if (file.Length == 0)
                            //{
                                //continuar++;
                                //ExitoI = false;
                                //File.Delete(DireccionCarpeta + "\\" + nombreCodigo + ".png");
                            //}
                            //else
                            //{
                                //continuar = intentos + 1;
                                //ExitoI = true;
                            //}
                        //}
                    //} while (continuar <= intentos && !ExitoI);

                    //if (!ExitoI)
                    //{
                        /*rutina para reversar el cobro de el duplicado*/
                        //????nueva funcion o rollback???
                        //OpenDataBase.Transaction.Rollback();
                        //
                        //return;
                    //}
                    //creamos el codigo de barras
                    //convertirTextoImagen(cadena, suscripcion, nombreCodigo);
                    //Fin CASO 200-2224

                    //ingresamos los datos a la plantilla
                    plantilla.SetDataSource(DatosFactura.datos);
                    plantilla.Subreports[0].SetDataSource(DatosFactura.datos.Tables["detalles"]);
                    plantilla.Subreports[1].SetDataSource(DatosFactura.datos.Tables["historico"]);
                    plantilla.Subreports[2].SetDataSource(DatosFactura.datos.Tables["rangos"]);
                    plantilla.SetParameterValue("valoresref", DatosFactura.datos.Tables["valores"].Rows[0].ItemArray[1].ToString());
                    plantilla.SetParameterValue("valcalc", DatosFactura.datos.Tables["valores"].Rows[1].ItemArray[1].ToString());
                    
                    //Agregar un 0 faltante antes de un punto (.)
                    //plantilla.SetParameterValue("cupobrilla", DatosFactura.datos.Tables["valores"].Rows[2].ItemArray[1].ToString());
                    String cpbr = DatosFactura.datos.Tables["valores"].Rows[2].ItemArray[1].ToString();
                    if (cpbr.Substring(0, 1).ToString() == ".")
                        cpbr = "0" + cpbr;
                    plantilla.SetParameterValue("cupobrilla", cpbr);

                    //definimos la ruta de la imagen en el reporte
                    //string DireccionCarpeta = Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory);
                    //CAmbio posicion de logica CASO 200-2224
                    //string DireccionCarpeta = Environment.GetEnvironmentVariable("USERPROFILE") + "//desktop";
                    //
                    //caso 200-2574 - danval - 20-04-19
                    //se retira la generacion del codigo de barras
                    //Thread.Sleep(2000);
                    //plantilla.SetParameterValue("url_image", DireccionCarpeta + "\\" + nombreCodigo + ".png"); //"\\temp_ldfactdup_barcode.png");
                    plantilla.SetParameterValue("url_image", "");

                    //limpiar();

                    //modificacion 14.09.18 cupo brilla
                    int contC = -1;
                    Boolean marca = false;
                    foreach (DataColumn col in DatosFactura.datos.Tables["datosBasicos"].Columns)
                    {
                        if (!marca)
                        {
                            contC++;
                            if (col.ColumnName == "PAGARE_UNICO")
                            {
                                marca = true;
                            }
                        }
                    }
                    //
                    //MessageBox.Show(DatosFactura.datos.Tables["datosBasicos"].Rows[0].ItemArray[contC].ToString());
                    //MessageBox.Show(DatosFactura.datos.Tables["datosBasicos"].Rows[0].ItemArray[27].ToString());
                    plantilla.SetParameterValue("sbPAGARE_UNICO", DatosFactura.datos.Tables["datosBasicos"].Rows[0].ItemArray[contC].ToString());

                    //rutina para impresion directa o forma con diseño
                    switch (printerAutomatic)
                    {
                        case "S":
                            {
                                frm_impresion forma = new frm_impresion(plantilla);
                                //forma.ShowDialog();
                                forma.Show();
                            }
                            break;
                        case "N":
                            {
                                frm_reporte forma = new frm_reporte();
                                forma.cr_viewer.ReportSource = plantilla;
                                //forma.ShowDialog();
                                forma.Show();
                            }
                            break;
                    }
                    //caso 200-2574 - danval - 20-04-19
                    //se retira la generacion del codigo de barras
                    //File.Delete(DireccionCarpeta + "\\" + nombreCodigo + ".png");
                    OpenDataBase.Transaction.Commit();                    
                }
                else
                {
                    general.mensajeERROR("Error durante la busqueda de Registros de la Factura");
                }
            //}
        }

        //private void convertirTextoImagen(string texto, String contrato, String nombreArchivo) //PictureBox convertirTextoImagen(string texto)
        //{
        //    string Barrcode = texto;//Numero del codigo de barras

        //    //formateamos la fuente a partir del recurso del proyecto
        //    PrivateFontCollection pfc = new PrivateFontCollection();
        //    var fontBytes = Properties.Resources.BC128CT;
        //    var fontData = Marshal.AllocCoTaskMem(fontBytes.Length);
        //    Marshal.Copy(fontBytes, 0, fontData, fontBytes.Length);
        //    pfc.AddMemoryFont(fontData, fontBytes.Length);
        //    Marshal.FreeCoTaskMem(fontData);

        //    //creamos la imagen y definimos el tamaño de este
        //    // System.Drawing.Bitmap bitmap = new System.Drawing.Bitmap((Barrcode.Length * 9)-50, 35);
        //    System.Drawing.Bitmap bitmap = new System.Drawing.Bitmap(Barrcode.Length * 169, 650);
        //    using (System.Drawing.Graphics graphics = System.Drawing.Graphics.FromImage(bitmap))
        //    {
        //        System.Drawing.Font ofont = new System.Drawing.Font(pfc.Families[0], 400);
        //        System.Drawing.PointF point = new System.Drawing.PointF(1f, 1f);
        //        System.Drawing.SolidBrush black = new System.Drawing.SolidBrush(System.Drawing.Color.Black);
        //        System.Drawing.SolidBrush white = new System.Drawing.SolidBrush(System.Drawing.Color.White);
        //        graphics.FillRectangle(white, 0, 0, bitmap.Width, bitmap.Height);
        //        graphics.DrawString(/*"*" +*/ Barrcode/* + "*"*/, ofont, black, point);
        //    }

        //    //guardamos la imagen en la escritorio
        //    //Bitmap resized = new Bitmap(bitmap, new Size(320, 70));
        //    //luego de generar la imagen se guarda en una ruta del servidor
        //    //string DireccionCarpeta = Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory);
        //    string DireccionCarpeta = Environment.GetEnvironmentVariable("USERPROFILE") + "//desktop";
        //    var path = Path.Combine(DireccionCarpeta, nombreArchivo + ".png");
        //    //resized.Save(path, System.Drawing.Imaging.ImageFormat.Png);
        //    bitmap.Save(path, System.Drawing.Imaging.ImageFormat.Png);

        //}

        private void button1_Click(object sender, EventArgs e)
        {
            //convertirTextoImagen("Esto es una prueba");
        }

        private void txt_dato_KeyDown(object sender, KeyEventArgs e)
        {
            // Determina cuando la tecla es RETROCESO
            if (e.KeyCode == (Keys.Back) && (txt_dato.Text.Length > 0))
            {
                String str = txt_dato.Text;
                //String extraeru = str.Substring(str.Length - 1); //Extraigo la ultima letra letra
                //txt_dato.Text = str.Substring(0,str.Length-1);
                txt_dato.Text = str.Remove(str.Length - 1);
                txt_dato.Select(txt_dato.Text.Length, 0);
            }
        }

        public void Gensolicitudrp()// caso:234
        {
            Valida_rp valapto = new Valida_rp();
            valapto = blLDFACTDUP.PrValidaAptorp(Convert.ToInt64(txt_dato.Text));            
            valrp = valapto.resultado;
            //general.mensajeOk("valrp: " + valrp);
            if (valrp == 1)
            {
                Question pregunta_rp = new Question("LDFACTDUP - Revisión Periódica", "Señor usuario, actualmente se encuentra disponible para su proceso de Revisión Periódica, el cual tiene vencimiento el próximo" + valapto.fechamax + ". Si desea solicitar una visita para el proceso, por favor presione aceptar", "Aceptar", "Cancelar", 218);
                               
                pregunta_rp.ShowDialog();
                if (pregunta_rp.answer == 2)
                {
                    Telefono tel = new Telefono();
                    tel.ShowDialog();
                    //general.mensajeOk("telefono: " + tel.telefono);
                    if (tel.telefono != null)
                    {

                        blLDFACTDUP.PrRegGesac(Convert.ToInt64(txt_dato.Text), tel.telefono);
                        general.mensajeOk("Su solicitud ha sido tramitada con éxito.");

                    }

                }

            }
            if (valrp == 2)
            {
                Question pregunta_rp_can = new Question("LDFACTDUP - Revisión Periódica", "Señor usuario, actualmente usted se encuentra VENCIDO en su proceso de Revisión Periódica, por favor EVITE LA SUSPENSIÓN de su servicio. Si desea solicitar una visita para el proceso, por favor presione aceptar", "Aceptar", "Cancelar", 218);
                //pregunta_rp_can.Size = new Size(354, 218);
                pregunta_rp_can.ShowDialog();
                if (pregunta_rp_can.answer == 2)
                {
                    Telefono tel = new Telefono();
                    tel.ShowDialog();
                    //general.mensajeOk("telefono: " + tel.telefono);
                    if (tel.telefono != null)
                    {

                        blLDFACTDUP.PrRegGesac(Convert.ToInt64(txt_dato.Text), tel.telefono);
                        general.mensajeOk("Su solicitud ha sido tramitada con éxito.");
                    }
                }
                else
                {

                    Question pregunta_rp_can2 = new Question("LDFACTDUP - Revisión Periódica", "¿Señor Usuario, está seguro de no solicitar su proceso de visita de Revisión Periódica? Tenga presente que, de no realizarlo, se iniciaría la SUSPENSIÓN de su servicio por encontrarse vencido. ¿Desea programar la solicitud de Visita de Revisión Periódica?", "Aceptar", "Cancelar",226);                   
                    pregunta_rp_can2.ShowDialog();
                    if (pregunta_rp_can2.answer == 2)
                    {
                        Telefono tel = new Telefono();
                        tel.ShowDialog();
                        //general.mensajeOk("telefono: " + tel.telefono);
                        if (tel.telefono != null)
                        {

                            blLDFACTDUP.PrRegGesac(Convert.ToInt64(txt_dato.Text), tel.telefono);
                            general.mensajeOk("Su solicitud ha sido tramitada con éxito.");

                        }
                    }

                }
            }

        }

    }
}
