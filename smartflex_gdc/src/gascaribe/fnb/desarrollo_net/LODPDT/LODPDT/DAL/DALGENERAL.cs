using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using OpenSystems.Common.ExceptionHandler;

namespace LODPDT.DAL
{
    class DALGENERAL
    {

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

        public DataTable cursorProcedure(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values)
        {
            DataSet dsgeneral = new DataSet("Tabla");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                for (int i = 0; i <= numField - 1; i++)
                {

                    switch (Type[i])
                    {
                        case "String":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.String, Values[i] == null ? (Object)DBNull.Value : Convert.ToString(Values[i]));
                            break;
                        case "Int64":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64, Values[i] == null ? (Object)DBNull.Value : Convert.ToInt64(Values[i]));
                            break;
                        case "Date":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Date, Values[i] == null ? (Object)DBNull.Value : Convert.ToDateTime(Values[i]));
                            break;
                        default:
                            break;
                    }
                }
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, "Tabla");
            }
            return dsgeneral.Tables["Tabla"];
        }

        public void executeProcedure(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values, out String Valor, out String mensajeE)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                for (int i = 0; i <= numField - 1; i++)
                {

                    switch (Type[i])
                    {
                        case "String":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.String, Values[i] == null ? (Object)DBNull.Value : Convert.ToString(Values[i]));
                            break;
                        case "Int64":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64, Values[i] == null ? (Object)DBNull.Value : Convert.ToInt64(Values[i]));
                            break;
                        case "Date":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Date, Values[i] == null ? (Object)DBNull.Value : Convert.ToDateTime(Values[i]));
                            break;
                        default:
                            break;
                    }
                }
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuerrorcode", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osberrormessage", DbType.String, 200);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                //validacion
                Int64 error = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuerrorcode"));
                mensajeE = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osberrormessage"));
                if (error == 0)
                {
                    OpenDataBase.Transaction.Commit();
                }
                Valor = error.ToString();
                /*if (error == 0)
                {
                    OpenDataBase.Transaction.Commit();
                }
                else
                {
                    ExceptionHandler.DisplayMessage(2741, message);
                    OpenDataBase.Transaction.Rollback();
                }*/

            }
        }

        public String ConsecutivoAgrupador()
        {
            String consecutive;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BOPROCESRUTEROS.FNUOBTIENESECUENCIA"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbSecuencia", DbType.String, "SEQ_LDC_ORDEN_LODPD");
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                consecutive = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
            return consecutive;
        }

    }
}
