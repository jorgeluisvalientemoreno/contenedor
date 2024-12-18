using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace LEMADOPA.DAL
{
    class DALGENERAL
    {

        //CURSOR PROCEDIMIENTOS ORACLE
        static String listavalores = "ld_boconstans.frfSentence"; //genera listas de valores a apartir de una consulta basica (select)
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
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.String, Convert.ToString(Values[i]));
                            break;
                        case "Int64":
                            {
                                if(Values[i] == null)
                                    OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64, null);
                                else
                                    OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64, Convert.ToInt64(Values[i]));
                            }
                            break;
                        case "DateTime":
                            {
                                if (Values[i] == null)
                                    OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.DateTime, null);
                                else
                                    OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.DateTime, Convert.ToDateTime(Values[i]));
                            }
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
        //

        //FUNCION ORACLE
        public Object valueReturn(String Procedure, int numField, String[] Type, String[] Campos, Object[] Values, String TypeReturn)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                for (int i = 0; i <= numField - 1; i++)
                {
                    switch (Type[i])
                    {
                        case "String":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.String, Convert.ToString(Values[i]));
                            break;
                        case "Int64":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64,
                                string.IsNullOrEmpty(Values[i].ToString().Trim()) ?
                                (Object)DBNull.Value :
                                Convert.ToInt64(Values[i]));
                            break;
                        default:
                            break;
                    }
                }
                switch (TypeReturn)
                {
                    case "String":
                        OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                        break;
                    case "Int64":
                        OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                        break;
                    case "Boolean":
                        OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                        break;
                    default:
                        break;
                }
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }
        //

        public void doCommit()
        {
            OpenDataBase.Transaction.Commit();
        }

        //Incio CASO 200-1880
        //Servicio para obtener la clasificacion de la causal con la que se legalizara la OT entrega documento de PU
        public static Int64 DALFnuValidaCausal(Int64 InuCausal)
        {
            Int64 nuEXITOFALLO = 0;

            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDCI_PKLEMADOPA.FnuValidaCausal"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "InuCausal", DbType.Int64, InuCausal);
                    OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                    nuEXITOFALLO = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
                };
            }
            catch
            {
            }

            return nuEXITOFALLO;
        }
        //Fin CASO 200-1880

    }
}
