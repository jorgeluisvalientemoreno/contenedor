#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : <Nombre de la Clase>
 * Descripcion   : <Objetivo o descripcion de la clase>
 * Autor         : Sicecomp
 * Fecha         : 08-May-2013
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 16-Oct-2013  220118  LDiuza         1 - Se crea metodo <NotifyMail> encargado de hacer la notificacion por
 *                                          correo de la creacion de lista de precios.
 *                                     2 - Se modifica el metodo <ReadFile> para que notifique la creación de listas
 *                                         de precios al final de procesar todo el archivo.
 * 07-Sep-2013  216578  lfernandez     1 - <ReadFile> En el último llamado a ProcessLine se valida si retorna
 *                                         false y si es así para que se muestre mensaje de error.
 * 30-Ago-2013  215138  jaricapa       1 - Se indica cual es el número de la línea del error.
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.IO;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.DAL
{
    class DALGEPBA
    {
        /// <summary>
        /// Carga el archivo
        /// </summary>
        /// <param name="locationFile">Ubicación del archivo</param>
        /// <returns>true si se procesó con éxito</returns>
        public static Boolean ReadFile(String locationFile)
        {
            String LineProcess = null;
            Int32 lineNumber;
            bool result = true;

            List<string> listLine = new List<string>();
            WriteLogFile(locationFile, "INICIO");
            bool isValid = LoadFile(locationFile, out listLine);

            if (isValid)
            {
                if (listLine.Count > Int32.MaxValue)
                {
                    WriteLogFile(locationFile, "El archivo superó el máximo número de líneas permitidos. Max: [" + Int32.MaxValue + "]");
                    WriteLogFile(locationFile, "FIN");
                    return false;
                }

                if (listLine.Count > 0)
                {
                    for (int i = 0; i < listLine.Count; i++)
                    {
                        lineNumber = i + 1;
                        string line = listLine[i];
                        string nuCode = line.Substring(0, line.IndexOf("|"));

                        AddLineToProcess(lineNumber, line, ref LineProcess, ref nuCode);

                        if (nuCode == "Y")
                        {
                            result = ProcessLine(locationFile);

                            if (!result)
                            {
                                isValid = false;
                                OpenDataBase.Transaction.Rollback();
                            }

                            ResetTableLineofFile();
                            //Agrego la línea actual, para que sea procesa en la próxima ejecución.
                            AddTableLineofFile(lineNumber, line);
                            LineProcess = line;
                        }
                    }
                }
                else
                {
                    WriteLogFile(locationFile, "El archivo no contiene líneas para procesar.");
                    isValid = false;
                }
            }
            else
            {
                WriteLogFile(locationFile, "No se puede continuar con el proceso. El archivo tiene errores de formato.");
                isValid = false;
            }

            // Se procesa la última línea
            result = ProcessLine(locationFile);
            if (!result)
            {
                isValid = false;
                OpenDataBase.Transaction.Rollback();
            }

            // Limpio los datos en servidor
            ResetTableLineofFile();
            WriteLogFile(locationFile, "FIN");

            if (isValid)
            {
                //Se notifica via mail
                NotifyMail();
            }

            return isValid;
        }

        private static void NotifyMail()
        {
            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_boportafolio.SendMailNotifPriceList"))
                {
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                }
            }
            catch (Exception ex)
            {
                GlobalExceptionProcessing.ShowErrorException(ex);
            }
        }

      
        /// <summary>
        /// Carga las líneas del archivo
        /// </summary>
        /// <param name="locationFile">Localización del archivo</param>
        /// <param name="listLine">Colección de líneas</param>
        /// <returns>Resultado de la validación</returns>
        private static bool LoadFile(String locationFile, out List<string> listLine)
        {      
            String line;
            Int64 numberLine = 1;
            String nuCode;
            bool result = true;
            StreamReader file = null;
            listLine = new List<string>();
            try
            {
                Encoding encoding = TextFileEncodingDetector.DetectTextFileEncoding(locationFile);
                
                file = new StreamReader(locationFile, encoding);
                while ((line = file.ReadLine()) != null)
                {
                    if (line.Length > 0)
                    {
                        Int32 index = line.IndexOf("|");
                        if (index == -1)
                        {
                            string message = "La línea[" + line + "] no tiene el formato correcto. Verifique que se encuentre " +
                                              "separado por '|'.";
                            WriteLogFile(locationFile, numberLine, message);
                            result = false;
                        }
                        else
                        {
                            nuCode = line.Substring(0, index);

                            if (index > 0 && ValidateFormat(nuCode))
                            {
                                WriteLogFile(locationFile, "Palabra clave [" + numberLine + "]: Formato OK");
                                listLine.Add(line);
                            }
                            else
                            {
                                string message = "La palabra clave [" + nuCode + "] no tiene el formato correcto. Formatos válidos: [ARTICULO]," +
                                                    "[PROPIEDAD], [PRECIO], [LISTAPRECIO], [LPARTICULO] O [COMISION]";
                                WriteLogFile(locationFile, numberLine, message);
                                result = false;
                            }
                        }
                    }
                    numberLine++;
                }
            }
            finally
            {
                if (file != null)
                {
                    file.Close();
                }
            }
            return result;
        }

        private static void AddLineToProcess(Int32 numberLine, String line, ref String LineProcess, ref String nuCode)
        {
            if (nuCode == "ARTICULO")
            {
                if (LineProcess == null)
                {
                    LineProcess = line;
                    AddTableLineofFile(numberLine, line);
                }
                else
                {
                    nuCode = "Y";
                }
            }
            if (nuCode == "PROPIEDAD" && LineProcess != null)
            {
                AddTableLineofFile(numberLine, line);
                nuCode = "N";
            }
            if (nuCode == "PRECIO" && LineProcess != null)
            {
                AddTableLineofFile(numberLine, line);
                nuCode = "N";
            }
            if (nuCode == "LISTAPRECIO")
            {
                if (LineProcess == null)
                {
                    LineProcess = line;
                    AddTableLineofFile(numberLine, line);
                }
                else
                {
                    nuCode = "Y";
                }
            }
            if (nuCode == "LPARTICULO" && LineProcess != null)
            {
                AddTableLineofFile(numberLine, line);
                nuCode = "N";
            }
            if (nuCode == "COMISION")
            {
                if (LineProcess == null)
                {
                    LineProcess = line;
                    AddTableLineofFile(numberLine, line);
                }
                else
                {
                    nuCode = "Y";
                }
            }
        }
        /// <summary>
        /// Valida todos los formatos establecidos para GEPBA
        /// </summary>
        /// <param name="nuCode">Palabra Reservada</param>
        /// <returns>True si el formato es válido</returns>
        private static Boolean ValidateFormat(String nuCode)
        {
            if (nuCode != "N")
            {
                if (nuCode != "Y")
                {
                    if (nuCode != "ARTICULO")
                    {
                        if (nuCode != "PROPIEDAD")
                        {
                            if (nuCode != "PRECIO")
                            {
                                if (nuCode != "LISTAPRECIO")
                                {
                                    if (nuCode != "LPARTICULO")
                                    {
                                        if (nuCode != "COMISION")
                                        {
                                            return false;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return true;
        }

        /// <summary>
        /// Procesa la línea guarda en memoria del servidor
        /// </summary>
        /// <param name="locationFile">Ubicación del archivo</param>        
        /// <returns>Resultado de la validación</returns>
        private static Boolean ProcessLine(String locationFile)
        {
            bool result = true;
            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_boportafolio.fnuprocesslineoffile"))
                {

                    OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 5000);
                    OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                    string sbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
                    result = Convert.ToBoolean(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
                    if (result == false)
                    {
                        OpenDataBase.Transaction.Rollback();
                    }
                    else
                    {
                        OpenDataBase.Transaction.Commit();
                    }

                    WriteLogFile(locationFile, sbErrorMessage);
                }
            }
            catch (Exception ex)
            {
                result = false;
                GlobalExceptionProcessing.ShowErrorException(ex);
            }
            return result;
        }


        static void AddTableLineofFile(Int32 numberLine, String sbLine)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_boportafolio.AddTableLineofFile"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuLineNumber", DbType.Int32, numberLine);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbLine", DbType.String, sbLine);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        static void ResetTableLineofFile()
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_boportafolio.ResetTableLineofFile"))
            {
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Permite escribir un mensaje de error en el archivo de log.
        /// </summary>
        /// <param name="locationFile">Ubicación del Archivo</param>
        /// <param name="lineNumber">Número de Línea</param>
        /// <param name="sbErrorMessage">Mensaje</param>        
        private static void WriteLogFile(String locationFile, Int64 lineNumber, String sbErrorMessage)
        {
            String textMessage = string.Format("Error en la línea[{0}]:{1}", lineNumber, sbErrorMessage);
            WriteLogFile(locationFile, textMessage);
        }

        /// <summary>
        /// Permite escribir un mensaje de error en el archivo de log.
        /// </summary>
        /// <param name="locationFile">Ubicación del Archivo</param>
        /// <param name="lineNumber">Número de Línea</param>
        /// <param name="sbErrorMessage">Mensaje</param>
        /// <param name="isErrorLine">Indica si se inserta una línea de error</param>
        private static void WriteLogFile(String locationFile, String sbErrorMessage)
        {
            String fileLog;
            String textMessage = null;
            String sbNewLine = char.ConvertFromUtf32(13) + char.ConvertFromUtf32(10);
            fileLog = locationFile.Replace(".", "_");
            textMessage = sbErrorMessage + sbNewLine;
            File.AppendAllText(fileLog + "_Resultados.txt", textMessage);
        }
    }
}
