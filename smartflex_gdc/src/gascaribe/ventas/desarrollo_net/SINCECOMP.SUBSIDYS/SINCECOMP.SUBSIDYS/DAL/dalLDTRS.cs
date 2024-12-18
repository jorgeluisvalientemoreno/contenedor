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
    class dalLDTRS
    {
        public static Boolean readFile(String locationFile)
        {
            Boolean state = true;
            Boolean blStateTotal = true;
            StreamReader file = new StreamReader(locationFile);
            Int64 numberLineEnd = 0;

            String sbLineFile = null;

            String sbErrorMessage = null;

            while ((sbLineFile = file.ReadLine()) != null)
            {
                //rutina de lectura
                numberLineEnd++;

                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_bosubsidy.fblTransferSubsidy"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbLineFile", DbType.String, sbLineFile);

                    OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);

                    OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);

                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                    sbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));

                    state = Convert.ToBoolean(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));

                    if (state == false)
                    {
                        ProReadFile(locationFile, sbErrorMessage, numberLineEnd, numberLineEnd);
                        OpenDataBase.Transaction.Rollback();
                        blStateTotal = false;
                    }
                    else
                    {
                        ProReadFile(locationFile, sbErrorMessage, numberLineEnd, numberLineEnd);
                        OpenDataBase.Transaction.Commit();
                    }

                }
            }
            file.Close();
            return blStateTotal;
        }

        static void ProReadFile(String locationFile, String sbErrorMessage, Int64 numberLineInit, Int64 numberLineend)
        {
            String FileLog;
            FileLog = locationFile.Replace(".", "_");
            String textMessage = " La linea # " + numberLineInit.ToString() + " " + sbErrorMessage + Environment.NewLine;
            File.AppendAllText(FileLog + "_Inc.txt", textMessage);              
        }
    }
}
