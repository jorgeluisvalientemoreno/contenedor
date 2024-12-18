using System;
using System.Collections.Generic;
using System.Text;
//librerias OPEN
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Windows.Forms;
using OpenSystems.Common.ExceptionHandler;
using System.IO;
using OpenSystems.Common.Util;

namespace BSS.TARIFATRANSITORIA.DAL
{
    class DALGENERAL
    {
        //nombre de funciones y procedimentos
        static String listavalores = "ld_boconstans.frfSentence";

        public DataTable getValueList(String Query)
        {
            DataSet dsValueList = new DataSet("ValueList");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(listavalores))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbselect", DbType.String, Query);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsValueList, "ValueList");
            }

            return dsValueList.Tables["ValueList"];
        }

        public String Prvalicontt(Int64 inucontrato)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_pkgestionsiantt.prvalicontt"))
            {
                //Convert.ToInt64(inucontrato)
                OpenDataBase.db.AddInParameter(cmdCommand, "inucontrato", DbType.Int64, inucontrato);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbnombre", DbType.String, 200);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuerror", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osberror",  DbType.String, 200);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int64 error = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuerror"));
                String message = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osberror"));
                if (error == 0)
                {
                    return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbnombre"));
                }
                else
                {
                    ExceptionHandler.DisplayMessage(2741, message);// + "\n" + XML);
                    return "";
                }
            }
        }

        //Servicio para ejecutar servicios y retornar DATA de cursor tipo funcion
        public DataTable frfgetsimulacion(Int64 inucontrato)
        {
            DataSet dsgeneral = new DataSet("Tabla");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_pkgestionsiantt.frfgetsimulacion"))
            //using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_FRFGETSIMULACION"))
            {
                //Convert.ToInt64(inucontrato)
                OpenDataBase.db.AddInParameter(cmdCommand, "inucontrato", DbType.Int64, inucontrato);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuerror", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osberror", DbType.String, 200);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, "Tabla");
            }
            return dsgeneral.Tables["Tabla"];
        }

        public Int64 PRCALCSITT(Int64 inucontrato, Int64 inutiponota, Int64 inuanio, Int64 inumes, Int64 inumetros)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_pkgestionsiantt.PRCALCSITT"))
            {
                //Convert.ToInt64(inucontrato)
                OpenDataBase.db.AddInParameter(cmdCommand, "inucontrato", DbType.Int64, inucontrato);
                OpenDataBase.db.AddInParameter(cmdCommand, "inutiponota", DbType.Int64, inutiponota);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuanio", DbType.Int64, inuanio);
                OpenDataBase.db.AddInParameter(cmdCommand, "inumes", DbType.Int64, inumes);
                OpenDataBase.db.AddInParameter(cmdCommand, "inumetros", DbType.Int64, inumetros);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuerror", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osberror", DbType.String, 200);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int64 error = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuerror"));
                String message = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osberror"));
                if (error == 0)
                {
                    return error;
                }
                else
                {
                    ExceptionHandler.DisplayMessage(2741, message);// + "\n" + XML);
                    return error;
                }
            }
        }

    }
}
