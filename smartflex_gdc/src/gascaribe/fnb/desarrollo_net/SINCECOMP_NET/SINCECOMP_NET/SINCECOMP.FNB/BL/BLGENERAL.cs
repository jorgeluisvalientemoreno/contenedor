using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using SINCECOMP.FNB.DAL;
using SINCECOMP.FNB.Entities;
using SINCECOMP.FNB.UI;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using Infragistics.Win.UltraWinGrid;
using OpenSystems.Common.ExceptionHandler;
using Infragistics.Win;
using System.Data.OleDb;
using System.Windows.Forms; 
//
using Excel = Microsoft.Office.Interop.Excel;
using System.Reflection;
using OpenSystems.Windows.Controls;

namespace SINCECOMP.FNB.BL
{
    class BLGENERAL
    {
        DALGENERAL general = new DALGENERAL();

        /// <summary>
        /// Devuelve los datos de la fecha limite de modificacion aplicada para el usuario
        /// </summary>
        /// <param name="userId">Identificacion del Usuario Conectado o el Usuario a Validar</param>
        /// <returns>Datos con la fecha limite aplicada al usuario (DataRow)</returns>
        public DataRow[] limitDate(String userId)
        {
            String condition = "supplier_id=" + userId;
            DataTable dataLimitDate = general.getLimitDate();
            return dataLimitDate.Select(condition);
        }

        /// <summary>
        /// Usuario Conectado
        /// </summary>
        /// <returns>Datos del Usuario Conectado (DataTable)</returns>
        public Int64 userConnect()
        {            
            return general.getUserConnect();
        }

        /// <summary>
        /// Metodo para generar lista de valores para Combos
        /// </summary>
        /// <param name="Query">Consulta en SQL requerida para generar la lista de valores</param>
        /// <returns>Cursor con la Lista de Valores (DataTable)</returns>
        public DataTable getValueList(String Query)
        {
           return general.getValueList(Query);
         
        }

        public DataTable getValueListNumberId(String Query, String valueCodigo)
        {
            return general.getValueListNumberId(Query, valueCodigo);
        }

        /// <summary>
        /// Metodo para cargar en una grilla los valores requeridos por una lista. Necesario si se desean cargar Vacios en un Lista de Valores
        /// </summary>
        /// <param name="query">Consulta en SQL necesaria para generar la lista de Valores (Los valores a mostrar deben ser Textos)</param>
        /// <param name="display">Valor que sera visible por el usuarios (Texto)</param>
        /// <param name="value">Valor a Cargar internamente (Texto) (Para Valores numericos aplicar to_char)</param>
        /// <returns>Lista de Valores a cargar en la Grilla (UltraDropDown)</returns>
        public UltraDropDown valuelist(String query, String display, String value)
        {
            DataTable tabla = new DataTable();
            DataRow datos;
            tabla.Columns.Add(value);
            tabla.Columns.Add(display);
            datos = tabla.NewRow();
            tabla.Rows.Add(datos);
            DataTable tbDetail;
            
            if (!string.IsNullOrEmpty(query))
            {
                tbDetail = getValueList(query);

                if (tbDetail != null)
                    tabla.Merge(tbDetail, true, MissingSchemaAction.Add);
            }
            UltraDropDown dropDowntb = new UltraDropDown();
           
            dropDowntb.DataSource = tabla;
            dropDowntb.ValueMember = value;
            dropDowntb.DisplayMember = display;
            dropDowntb.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            return dropDowntb;
        }


        public DataTable valuelist(String query)
        {
            DataTable tabla = new DataTable();
            DataRow datos;
            datos = tabla.NewRow();
            tabla.Rows.Add(datos);
            DataTable tbDetail;

            if (query != "")
            {

                tbDetail = getValueList(query);



                if (tbDetail != null)
                    tabla.Merge(tbDetail, true, MissingSchemaAction.Add);
            }


            return tabla;
        }


        public OpenGridDropDown valuelistNumberId(String query, String display, String value)
        {            
            DataTable tbDetail;

            if (query != string.Empty)
                tbDetail = getValueListNumberId(query, value);
            else 
            {

                tbDetail = new DataTable();

                tbDetail.Columns.Add(value);
                tbDetail.Columns.Add(display);


                DataRow blanItem = tbDetail.NewRow();

                tbDetail.Rows.Add(blanItem); 

            }

            OpenGridDropDown dropDowntb = new OpenGridDropDown();

            dropDowntb.DataSource = tbDetail;
            dropDowntb.ValueMember = value;
            dropDowntb.DisplayMember = display;
            dropDowntb.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
                  
            return dropDowntb;
        }

        //
        public OpenGridDropDown valuelist2(String query, String display, String value)
        {
            DataTable tbDetail;
            if (!string.IsNullOrEmpty(query))
                tbDetail = getValueList(query);
            else
            {
                tbDetail = new DataTable();
                tbDetail.Columns.Add(value);
                tbDetail.Columns.Add(display);
                DataRow blanItem = tbDetail.NewRow();
                tbDetail.Rows.Add(blanItem);

            }

            OpenGridDropDown dropDowntb = new OpenGridDropDown();

            dropDowntb.DataSource = tbDetail; 
            dropDowntb.ValueMember = value;
            dropDowntb.DisplayMember = display;
            dropDowntb.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;

            return dropDowntb;
        }
        //

        public UltraDropDown valuelistn(String query, String display, String value)
        {
            DataTable tabla = new DataTable();
            tabla = getValueList(query);
            UltraDropDown dropDowntb = new UltraDropDown();
            dropDowntb.SetDataBinding(tabla, null);//.DataSource = tabla;
            dropDowntb.ValueMember = value;
            dropDowntb.DisplayMember = display;
            dropDowntb.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            return dropDowntb;
        }

        /// <summary>
        /// Metodo para cargar en un combo los valores requeridos por una lista. Necesario si se desean cargar Vacios en un Lista de Valores
        /// </summary>
        /// <param name="query">Consulta en SQL necesaria para generar la lista de Valores (Los valores a mostrar deben ser Textos)</param>
        /// <param name="display">Valor que sera visible por el usuarios (Texto)</param>
        /// <param name="value">Valor a Cargar internamente (Texto) (Para Valores numericos aplicar to_char)</param>
        /// <returns>Lista de Valores a cargar en un Combo (DataTable)</returns>
        public DataTable getComboList(String query, String value, String display)
        {
            DataTable tabla = new DataTable();
            DataRow datos;
            tabla.Columns.Add(value);
            tabla.Columns.Add(display);
            datos = tabla.NewRow();
            datos[0] = " ";
            datos[1] = "";
            tabla.Rows.Add(datos);
            DataTable tbDetail;
            if (query != "")
            {
                tbDetail = getValueList(query);
                tabla.Merge(tbDetail, true, MissingSchemaAction.Add);
            }
            return tabla;
        }

        /// <summary>
        /// Mensajes de Error
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void mensajeERROR(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.DisplayError(2741,msj);
        }

        /// <summary>
        /// Elevar Mensaje de Error
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void raiseERROR(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.Raise(2741,msj);
        }        

        /// <summary>
        /// 
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public DateTime TruncDateTime(DateTime date)
        {
            return new DateTime(date.Ticks - (date.Ticks % TimeSpan.TicksPerDay), date.Kind);
        }

        /// <summary>
        /// Mensaje de Exito
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void mensajeOk(String mesagge)
        {
            ExceptionHandler.DisplayMessage(2741, mesagge);
        }
        //EVESAN 03/Julio/2013
        public void messageErrorException(Exception mesagge)
        {
            GlobalExceptionProcessing.ShowErrorException(mesagge);
        }
        /// <summary>
        /// Metodo para aplicar el asterisco de Requerido a las Columnas de UltraGrid
        /// </summary>
        /// <param name="ug">UltraGrid al cual se le aplicara el efecto</param>
        /// <param name="Fields">Listado de columnas a las cuales se les aplicara el efecto de requerido</param>
        public void setColumnRequiered(UltraGrid ug, String[] Fields)
        {
            foreach (String column in Fields)
            {
                if (ug.DisplayLayout != null)
                {   
                    ug.DisplayLayout.Bands[0].Columns[column].Header.Appearance.Image = global::SINCECOMP.FNB.Resource.asterisc;
                    ug.DisplayLayout.Bands[0].Columns[column].Header.Appearance.ImageHAlign = HAlign.Left;
                    ug.DisplayLayout.Bands[0].Columns[column].Header.Appearance.ImageVAlign = VAlign.Middle;
                }
            }
        }

        /// <summary>
        /// Metodo para obligara la escritura en mayuscula dentro de las celdas de una columna especifica
        /// </summary>
        /// <param name="ug">UltraGrid al cual se le aplicar el efecto</param>
        /// <param name="Fields">Listado de columnas a las cuales se les aplicara el efecto de Mayusculas en la escritura</param>
        public void setColumnUpper(UltraGrid ug, String[] Fields)
        {
            foreach (String column in Fields)
            {
                ug.DisplayLayout.Bands[0].Columns[column].CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            }
        }

        /// <summary>
        /// Metodo para colocar a las columnas en Modo de Solo lectura
        /// </summary>
        /// <param name="ug">UltraGrid al cual se le aplicar el efecto</param>
        /// <param name="Fields">Listado de columnas a las cuales se les aplicara el efecto de Solo Lectura</param>
        public void setColumnReadOnly(UltraGrid ug, String[] Fields)
        {
            foreach (String column in Fields)
            {
                ug.DisplayLayout.Bands[0].Columns[column].CellActivation = Activation.NoEdit;
            }
        }

        /// <summary>
        /// Metodo para obtener valores de un Parametro
        /// </summary>
        /// <param name="sbParam">Descripcion del parametro</param>
        /// <param name="tipo">Tipo de valor que Debe buscar</param>
        /// <returns>Valor del Parametro solicitado (Double)</returns>
        public Object getParam(String sbParam, String tipo)
        {
            Object valor= general.getParam(sbParam, tipo);
            if (!string.IsNullOrEmpty(valor.ToString()))
                return valor;
            else
            {
                mensajeERROR("El Parámetro: " + sbParam + ", no se encuentra configurado. Favor validar.");
                return valor;
            }
        }

        /// <summary>
        /// Confirma las acciones en la Base de Datos
        /// </summary>
        public void doCommit()
        {
            general.doCommit(); 
        }

        /// <summary>
        /// Deshace las acciones en la Base de Datos
        /// </summary>
        public void doRollback()
        {
            general.doRollback(); 
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="query"></param>
        /// <param name="field"></param>
        /// <returns></returns>
        public String devolution(String query, String field)
        {
            DataTable DTable = getValueList("select numeric_value valor from ld_parameter where lower(parameter_id)='insurance_rate'");
            return DTable.Rows[0][field].ToString();
        }

        /// <summary>
        /// Ejecuta el Procedimiento solicitado a partir de parametros definidos
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <param name="numField">Número de Campos que seran enviados al Procedimiento</param>
        /// <param name="Type">Listado de Tipos de los Campos enviados. Deben ser enviados en el mismo orden de los Campos</param>
        /// <param name="Campos">Listado de Parametros o Campos enviados ha ser ejecutados por el Procedimiento</param>
        /// <param name="Values">Listado de Valores que seran asignados a los Campos</param>
        public void executeMethod(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values)
        {
            general.executeMethod(Procedure, numField, Type, Campos, Values);
        }

        /// <summary>
        /// Devuelve un cursor con los datos de una funcion especifica
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <param name="numField">Número de Campos que seran enviados al Procedimiento</param>
        /// <param name="Type">Listado de Tipos de los Campos enviados. Deben ser enviados en el mismo orden de los Campos</param>
        /// <param name="Campos">Listado de Parametros o Campos enviados ha ser ejecutados por el Procedimiento</param>
        /// <param name="Values">Listado de Valores que seran asignados a los Campos</param>
        /// <returns></returns>
        public DataTable cursorProcedure(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values)
        {
            return general.cursorProcedure(Procedure, numField, Type, Campos, Values);
        }

        /// <summary>
        /// Devuelve un cursor con los datos de una funcion especifica
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <returns></returns>
        public DataTable cursorProcedure(String Procedure)
        {
            return general.cursorProcedure(Procedure);
        }

        /// <summary>
        /// Ejecuta el Procedimiento solicitado a partir de parametros definidos y devuelve un valor con el dato Solicitado
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <param name="numField">Número de Campos que seran enviados al Procedimiento</param>
        /// <param name="Type">Listado de Tipos de los Campos enviados. Deben ser enviados en el mismo orden de los Campos</param>
        /// <param name="Campos">Listado de Parametros o Campos enviados ha ser ejecutados por el Procedimiento</param>
        /// <param name="Values">Listado de Valores que seran asignados a los Campos</param>
        /// <param name="TypeReturn">Tipo de Valor que sera devuelto</param>
        /// <returns>Devuelve el valor enviado por la Funcion (Object)</returns>
        public Object valueReturn(String Procedure, int numField, String[] Type, String[] Campos, String[] Values, String TypeReturn)
        {
            return general.valueReturn(Procedure, numField, Type, Campos, Values, TypeReturn);
        }

        /// <summary>
        /// Ejecuta el Procedimiento solicitado a partir de parametros definidos y devuelve un valor con el dato Solicitado
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <param name="TypeReturn">Tipo de Valor que sera devuelto</param>
        /// <returns></returns>
        public Object valueReturn(String Procedure, String TypeReturn)
        {
            return general.valueReturn(Procedure, TypeReturn);
        }

        /// <summary>
        /// Importa grillas de Archivo de Excel 2003
        /// </summary>
        /// <param name="grilla">UltraGrid del que se tomara la informacion</param>
        public void importarExcel(UltraGrid grilla)
        {
            try
            {
                String source;
                System.Windows.Forms.OpenFileDialog ofdFile = new System.Windows.Forms.OpenFileDialog();
                ofdFile.Title = "Abrir Archivo";
                ofdFile.Filter = "Archivo Excel 2003|*.xls";
                if (ofdFile.ShowDialog() == System.Windows.Forms.DialogResult.OK)
                {
                    source = ofdFile.FileName.ToString();
                    DataTable dt = new DataTable();
                    DataSet ds = ImportExcelXLS(source, true);
                    //pendiente
                    dt = ds.Tables[0];
                    dt.Rows[0].Delete();
                    grilla.DataSource = dt;
                    grilla.DataBind();
                    //
                }
            }
            catch
            {
                mensajeERROR("Error al Importar el Archivo");
            }
        }

        /// <summary>
        /// Metodo para generar la accion de Importacion del documento
        /// </summary>
        /// <param name="FileName">Nombre que se le dara al Archivo</param>
        /// <param name="hasHeaders">Determina se seran incluidas las Columnas</param>
        /// <returns>Datos obtenidos del documento de Excel (DataSet)</returns>
        private static DataSet ImportExcelXLS(string FileName, bool hasHeaders)
        {
            string HDR = hasHeaders ? "Yes" : "No";
            string strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + FileName + ";Extended Properties=\"Excel 8.0;HDR=" + HDR + ";IMEX=1\"";
            DataSet output = new DataSet();
            using (OleDbConnection conn = new OleDbConnection(strConn))
            {
                conn.Open();
                DataTable dt = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
                foreach (DataRow row in dt.Rows)
                {
                    string sheet = row["TABLE_NAME"].ToString();
                    OleDbCommand cmd = new OleDbCommand("SELECT * FROM [" + sheet + "]", conn);
                    cmd.CommandType = CommandType.Text;
                    DataTable outputTable = new DataTable(sheet);
                    output.Tables.Add(outputTable);
                    new OleDbDataAdapter(cmd).Fill(outputTable);
                }
            }
            return output;
        }

        //
        //String[] vectorColumnas;
        //

        /// <summary>
        /// Exportar Grillas a Excel 2003
        /// </summary>
        /// <param name="Grilla">UltraGrid del que se tomara la informacion</param>
        public void exportarExcel(UltraGrid Grilla)//, string[] Columnas)
        {
            try
            {
                //vectorColumnas = Columnas;
                String ruta;
                System.Windows.Forms.SaveFileDialog sfdFile = new System.Windows.Forms.SaveFileDialog();
                Infragistics.Win.UltraWinGrid.ExcelExport.UltraGridExcelExporter generador = new Infragistics.Win.UltraWinGrid.ExcelExport.UltraGridExcelExporter();
                //generador.CellExported += new Infragistics.Win.UltraWinGrid.ExcelExport.CellExportedEventHandler(generador_CellExported);
                sfdFile.Title = "Guardar Como...";
                sfdFile.Filter = "Archivo Excel 2003|*.xls";
                if (sfdFile.ShowDialog() == System.Windows.Forms.DialogResult.OK)
                {
                    ruta = sfdFile.FileName.ToString();
                    generador.Export(Grilla, @ruta);
                    mensajeOk("Proceso Ejecutado con exito.\nRevise el Archivo generado.");
                }
            }
            catch
            {
                mensajeERROR("Error al Exportar el Archivo");
            }
        }

        
        /// <summary>
        /// Imprimir en Archivo plano la Grilla
        /// </summary>
        /// <param name="grilla">UltraGrid del que se tomara la informacion</param>
        public void imprimirExcel(UltraGrid grilla)
        {
            try
            {
                System.Drawing.Printing.PrintDocument pdoc = new System.Drawing.Printing.PrintDocument();
                pdoc.DefaultPageSettings.Landscape = true;
                pdoc.DefaultPageSettings.Margins.Left = 50;
                pdoc.DefaultPageSettings.Margins.Right = 50;
                pdoc.DefaultPageSettings.Margins.Bottom = 50;
                pdoc.DefaultPageSettings.Margins.Top = 50;
                PageSetupDialog psd = new PageSetupDialog();
                psd.Document = pdoc;
                grilla.PrintPreview(grilla.DisplayLayout, pdoc, RowPropertyCategories.All);
               
            }
            catch (Exception exc)
            {
                mensajeERROR("Error durante la impresión.\n" + exc.Message);
            }
        }

        /// <summary>
        /// Genera una cadena XML basado en los campos requeridos
        /// </summary>
        /// <param name="cantidad">Cantidad de campos y/o valores a crear en el Gestor</param>
        /// <param name="Definicion">Nombre que se les asignara a cada uno de los parametros</param>
        /// <param name="Valores">Valores que seran asignados a las definiciones antes mencionadas</param>
        /// <returns>Cadena XML en String</returns>
        public String cadenaXML(int cantidad, String[] Definicion, String[] Valores)
        {
            String cadena = "";
            int i;
            for (i = 0; i <= cantidad - 1; i++)
                cadena += "<" + Definicion[i] + ">" + Valores[i] + "</" + Definicion[i] + ">";
            return cadena;
        }

        /// <summary>
        /// Validar si un objeto tiene un texto valido
        /// </summary>
        /// <param name="Objeto">Objeto a validar</param>
        /// <returns>Retorna el valor del texto</returns>
        public String ValidarTexto(Object Objeto)
        {
            try
            {
                return string.IsNullOrEmpty(Objeto.ToString()) ? "" : Objeto.ToString();
            }
            catch
            {
                return "";
            }
        }

        public String getPackageByConsecutive(String consecutive)
        {
            return general.getPackageByConsecutive(consecutive);
        }

        public String getConsecutiveByPackage(String packageId)
        {
            return general.getConsecutiveByPackage(packageId);
        }
    }
}
