using System;
using System.Collections.Generic;
using System.Text;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Data;

using VENTACUPONESMAS.Entities;

namespace VENTACUPONESMAS.DAL
{
    class DALLDIMPMAS
    {

        /// <summary>
        /// Obtiene los valores contenidos por un parametro
        /// </summary>
        /// <param name="sbParam">Descripcion del parametro</param>
        /// /// <param name="tipo">Tipo de valor que debera buscar</param>
        /// <returns>Valor del Parametro (Double)</returns>
        public Object getParam(String sbParam, String tipo)
        {
            try
            {
                Object valor = null;
                switch (tipo)
                {
                    case "String":
                        {
                            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dald_parameter.fsbgetvalue_chain"))
                            {
                                OpenDataBase.db.AddInParameter(cmdCommand, "inuparameter_id", DbType.String, sbParam);
                                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                                valor = OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
                            }
                        }
                        break;
                    case "Int64":
                        {
                            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dald_parameter.fnugetnumeric_value"))
                            {
                                OpenDataBase.db.AddInParameter(cmdCommand, "inuparameter_id", DbType.String, sbParam);
                                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Double, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                                valor = OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
                            }
                        }
                        break;
                    default:
                        valor = null;
                        break;
                }
                return valor;
            }
            catch
            {
                return null;
            }
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
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                for (int i = 0; i <= numField - 1; i++)
                {
                    switch (Type[i])
                    {
                        case "String":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.String, string.IsNullOrEmpty(Values[i].ToString()) ? null : Convert.ToString(Values[i]));
                            break;
                        case "Int64":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64, string.IsNullOrEmpty(Values[i].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[i]));
                            break;
                        case "DateTime":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.DateTime, string.IsNullOrEmpty(Values[i].ToString()) ? (Object)DBNull.Value : Convert.ToDateTime(Values[i]));
                            break;
                        default:
                            break;
                    }
                }
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        public DataSet consultaCupones(String Procedure, Object[] Values)
        {
            DataSet dsgeneral = new DataSet();
            String[] tablas = { "cupones" };
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inucodcliente", DbType.Int64, string.IsNullOrEmpty(Values[0].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[0]));
                OpenDataBase.db.AddInParameter(cmdCommand, "inufechai", DbType.String, Convert.ToString(Values[1]));
                OpenDataBase.db.AddInParameter(cmdCommand, "inufechaf", DbType.String, Convert.ToString(Values[2]));
                OpenDataBase.db.AddInParameter(cmdCommand, "inuidentcliente", DbType.String, Convert.ToString(Values[3]));
                OpenDataBase.db.AddInParameter(cmdCommand, "inuplancom", DbType.String, Convert.ToString(Values[4]));
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "orcupones");
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 255);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, tablas);   
            }
            return dsgeneral;
        }

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

    }
}
