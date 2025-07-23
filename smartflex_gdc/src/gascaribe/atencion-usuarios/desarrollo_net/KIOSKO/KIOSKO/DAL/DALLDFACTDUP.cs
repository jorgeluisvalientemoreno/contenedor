using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

using KIOSKO.Entities;
using System.Drawing.Text;
using System.Runtime.InteropServices;
using System.Drawing;

namespace KIOSKO.DAL
{
    public class DALLDFACTDUP
    {
        public static DataTable consultaFacturas(String Procedure, Object[] Values)
        {
            //Cliente para la busqueda
            Int64 clientSearch = 7014;
            //
            DataSet dsgeneral = new DataSet("Tables");
            String[] tablas = { "Tables", "t2" };
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSusccodi", DbType.Int64, Convert.ToInt64(Values[0]));
                OpenDataBase.db.AddInParameter(cmdCommand, "isbIdentificacion", DbType.String, Convert.ToString(Values[1]));
                OpenDataBase.db.AddInParameter(cmdCommand, "isbTelefono", DbType.String, Convert.ToString(""));
                OpenDataBase.db.AddInParameter(cmdCommand, "nuServicio", DbType.Int64, clientSearch);
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "CUSUSCRIPCIONES");
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "ocuMensaje");
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 255);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, tablas);
            }
            return dsgeneral.Tables["Tables"];
        }

        public static resp_facturacion consultaFactura(String Procedure, Object[] Values)
        {
            //aplica para .net
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(BL.BLCONSULTAS.AplicacionCargosConsumos))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "vaplica", DbType.Int64, Convert.ToInt64("1"));
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
            //
            resp_facturacion Respuestas = new resp_facturacion();
            DataSet dsgeneral = new DataSet("datosBasicos");
            String[] tablas = { "datosBasicos", "detalles", "revision", "historico", "lecturas", "c", "rangos", "e", "codigos", "g", "valores", "marcas" };
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSusccodi", DbType.Int64, Convert.ToInt64(Values[0]));
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSaldogen", DbType.Int64, Convert.ToInt64(Values[1]));
                OpenDataBase.db.AddInParameter(cmdCommand, "isbTipoSaldo", DbType.String, Convert.ToString(Values[2]));
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "CUDATOSBASIC");
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "CUCONCEPT");
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "CUREVISION");
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "CUHISTORICO");
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "CULECTURAS");
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "CUTOTALES");
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "CURANGOS");
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "CUCOMPCOST");
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "CUCODBAR");
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "CUTASACAMB");
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "CUOTROS");
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "CUMARCAS");
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbSeguroLiberty", DbType.String, 255);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbOrdenSusp", DbType.String, 255);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbProcFact", DbType.String, 255);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbImprimir", DbType.String, 255);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 255);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBSISTEMA", DbType.String, "N");
                //OSF-3938
                //Adicion de control de error try
                try
                {
                    OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, tablas);

                    Respuestas.osbseguroliberty = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbseguroliberty"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbseguroliberty"));
                    Respuestas.osbordensusp = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbordensusp"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbordensusp"));
                    Respuestas.osbprocfact = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbprocfact"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbprocfact"));
                    Respuestas.osbimprimir = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbimprimir"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbimprimir"));
                    Int64? valor = null;
                    Respuestas.onuErrorCode = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode").ToString()) ? valor : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode").ToString());
                    Respuestas.osbErrorMessage = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));

                    //Caso 200-2574 - Danval - 24-04-19
                    //se arma el codigo y agrega la imagen al cursor en forma de datos
                    String cadena = "415" + dsgeneral.Tables["codigos"].Rows[0].ItemArray[0].ToString() + "8020" + dsgeneral.Tables["codigos"].Rows[0].ItemArray[1].ToString() + "s3900" + dsgeneral.Tables["codigos"].Rows[0].ItemArray[2].ToString() + "s96" + dsgeneral.Tables["codigos"].Rows[0].ItemArray[3].ToString();
                    String[] tipos = { "String" };
                    String[] campos = { };
                    String[] valoresF = { cadena };
                    using (DbCommand cmdCommand_1 = OpenDataBase.db.GetStoredProcCommand(BL.BLCONSULTAS.codigoBarra))
                    {
                        OpenDataBase.db.AddInParameter(cmdCommand_1, "isbCadeOrig", DbType.String, Convert.ToString(cadena));
                        OpenDataBase.db.AddParameter(cmdCommand_1, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                        OpenDataBase.db.ExecuteNonQuery(cmdCommand_1);
                        cadena = OpenDataBase.db.GetParameterValue(cmdCommand_1, @"RETURN_VALUE").ToString();
                    }
                    DataTable data = new DataTable();
                    DataRow row;
                    data.TableName = "imagen";
                    data.Columns.Add("codigo_barra_formateado", System.Type.GetType("System.Byte[]"));
                    data.Columns.Add("codigo_texto");
                    row = data.NewRow();
                    row[0] = convertirTextoImagen(cadena);
                    row[1] = cadena;
                    data.Rows.Add(row);
                    dsgeneral.Tables.Add(data);
                    //
                }
                catch
                {
                }

                Respuestas.datos = dsgeneral;
            }
            //aplica para .net
            /*using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(BL.BLCONSULTAS.AplicacionCargosConsumos))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "vaplica", DbType.Int64, Convert.ToInt64("0"));
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }*/
            //
            return Respuestas;
        }

        public static ldfactdup_mensajes consultaMensajes(String Procedure)
        {
            ldfactdup_mensajes textos = new ldfactdup_mensajes();
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbtitulo", DbType.String, 255);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbmensaje", DbType.String, 255);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                textos.titulo = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbtitulo"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbtitulo"));
                textos.mensaje = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbmensaje"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbmensaje"));
            }
            return textos;
        }

        public static String ConsultaAlertas(String Procedure, Object[] Values)
        {
            String respuesta = "";
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nususccodi", DbType.Int64, Convert.ToInt64(Values[0]));
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                respuesta = (String)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
            return respuesta;
        }

        //Caso 200-2574 - Danval - 24-04-19
        //Servicio para convertir un texto en imagen
        public static Byte[] convertirTextoImagen(string texto)
        {
            string Barrcode = texto;
            PrivateFontCollection pfc = new PrivateFontCollection();
            var fontBytes = Properties.Resources.BC128CT;
            var fontData = Marshal.AllocCoTaskMem(fontBytes.Length);
            Marshal.Copy(fontBytes, 0, fontData, fontBytes.Length);
            pfc.AddMemoryFont(fontData, fontBytes.Length);
            Marshal.FreeCoTaskMem(fontData);
System.Drawing.Bitmap bitmap = new System.Drawing.Bitmap(Barrcode.Length * 169, 650);
            using (System.Drawing.Graphics graphics = System.Drawing.Graphics.FromImage(bitmap))
            {
                System.Drawing.Font ofont = new System.Drawing.Font(pfc.Families[0], 400);
                System.Drawing.PointF point = new System.Drawing.PointF(1f, 1f);
                System.Drawing.SolidBrush black = new System.Drawing.SolidBrush(System.Drawing.Color.Black);
                System.Drawing.SolidBrush white = new System.Drawing.SolidBrush(System.Drawing.Color.White);
                graphics.FillRectangle(white, 0, 0, bitmap.Width, bitmap.Height);
                graphics.DrawString(/*"*" +*/ Barrcode/* + "*"*/, ofont, black, point);
            }
            ImageConverter converter = new ImageConverter();
            return (byte[])converter.ConvertTo(bitmap, typeof(byte[]));
        }

        //Informacion del control de historial
        public static Valida_rp PrValidaAptorp(Int64 inuContrato)
        {
            Valida_rp validacion = new Valida_rp();
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_VALIDA_APTO_RP"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContrato", DbType.Int64, inuContrato);

                OpenDataBase.db.AddOutParameter(cmdCommand, "onuresult", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "odtfechamax", DbType.DateTime, 10);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);


                validacion.resultado = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuresult"));
                validacion.fechamax = Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "odtfechamax"));

            }
            return validacion;
        }
        /////////////////////////////////////////////////

        //Servicio para 
        public static void PrRegGesac(Int64 icontrato, String itelefono)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_REGPROGESAC"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "icontrato", DbType.Int64, icontrato);
                OpenDataBase.db.AddInParameter(cmdCommand, "itelefono", DbType.String, itelefono);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        


    }
}
