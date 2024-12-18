using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.IO;
//using SINCECOMP.SUBSIDYS.Entities;

namespace SINCECOMP.SUBSIDYS.DAL
{
    class dalLDASR
    {


        

        public static Boolean readFile(String locationFile)
        {
            Boolean state = true;
            Boolean blStateTotal = true;
            StreamReader file1 = new StreamReader(locationFile);
            Int64 numberLineEnd = 0;
            Int64 inuCurrent = 0;
            Int64 inuTotal = 0;
            Int64 inuTotalrec = 0;
            Int64 inuErrors = 0;
            Int64 inuRowsOk = 0;

            String sbLineFile = null;

            String sbErrorMessage = null;

            while ((sbLineFile = file1.ReadLine()) != null)
            {
                inuTotal++;
            }
            file1.Close();
            StreamReader file = new StreamReader(locationFile);
            while ((sbLineFile = file.ReadLine()) != null)
            {
                //rutina de lectura
                numberLineEnd++;
                inuCurrent++;
                

                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_bosubsidy.FBLAssigRetrosubByArchive"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbLineFile", DbType.String, sbLineFile);

                    OpenDataBase.db.AddInParameter(cmdCommand, "inuCurrent", DbType.Int64, inuCurrent);

                    OpenDataBase.db.AddInParameter(cmdCommand, "inuTotal", DbType.Int64, inuTotal);
                    
                    OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);

                    OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);

                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                    sbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));

                    state = Convert.ToBoolean(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));

                    if (state == false)
                    {
                        ProReadFile(locationFile, sbErrorMessage, numberLineEnd, numberLineEnd);
                        OpenDataBase.Transaction.Rollback();
                        inuTotalrec++;
                        
                        //blStateTotal = false;
                        //general.mensaje(sbErrorMessage);

                        //joncon
                        inuErrors++;

                    }
                    else
                    {
                        ProReadFile(locationFile, sbErrorMessage, numberLineEnd, numberLineEnd);
                        OpenDataBase.Transaction.Commit();
                        //general.mensajeOk(sbErrorMessage);
                        
                        //Cuenta cuantas filas se procesaron de forma correcta
                        inuRowsOk++;
                        
                    }

                    
                }
            }
            
            DALGENERAL general = new DALGENERAL();
            
            //cerrar el archivo
            file.Close();
                        
            if ((inuRowsOk > 0) && (inuErrors > 0))
            {
              general.mensajeOk("El proceso terminó con algunas inconsistencias. Ver archivo de inconsistencias generado en la misma ubicación del archivo procesado");
              blStateTotal = true;              
            }
            
            if ((inuRowsOk > 0) && (inuErrors == 0))
            {
                general.mensajeOk("El proceso fue exitoso");
                blStateTotal = true;                              
            }
                
            if ((inuRowsOk == 0) && (inuErrors > 0))
            {          
              //Todos los registros presentaron error durante su procesamiento
              general.mensaje("Proceso fallido. Ver archivo de inconsistencias generado en la misma ubicación del archivo procesado");
              blStateTotal = false;                              
            }

            return blStateTotal;
            
            /*
            if (blStateTotal)
                general.mensajeOk("El proceso fue Exitoso");
            else
            {
                if (inuTotalrec == inuTotal)
                {
                    blStateTotal = false;
                }
                else
                {
                    general.mensaje("El proceso presento algunas inconsistencias");
                    blStateTotal = true;
                }
            }
            file.Close();
            return blStateTotal;
            */
        }

        static void ProReadFile(String locationFile, String sbErrorMessage, Int64 numberLineInit, Int64 numberLineend)
        {
            String FileLog;
            String NewLine = char.ConvertFromUtf32(13) + char.ConvertFromUtf32(10);
            FileLog = locationFile.Replace(".", "_");
            String textMessage = "La linea # " + numberLineInit.ToString() + " " + sbErrorMessage + NewLine;
            File.AppendAllText(FileLog + "_Inc.txt", textMessage);
        }
    }
}
