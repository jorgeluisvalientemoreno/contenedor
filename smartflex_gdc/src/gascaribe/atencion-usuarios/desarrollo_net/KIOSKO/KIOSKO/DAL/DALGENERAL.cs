using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace KIOSKO.DAL
{
    class DALGENERAL
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
        /// Ejecuta el Procedimiento solicitado a partir de parametros definidos y devuelve el Cursor con los datos Solicitados
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <param name="numField">Número de Campos que seran enviados al Procedimiento</param>
        /// <param name="Type">Listado de Tipos de los Campos enviados. Deben ser enviados en el mismo orden de los Campos</param>
        /// <param name="Campos">Listado de Parametros o Campos enviados ha ser ejecutados por el Procedimiento</param>
        /// <param name="Values">Listado de Valores que seran asignados a los Campos</param>
        /// <returns>Cursor con la funcion ejecutada (DataTable)</returns>
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
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64, string.IsNullOrEmpty(Values[i].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[i]));
                            break;
                        case "Float":
                            OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Object, string.IsNullOrEmpty(Values[i].ToString()) ? (Object)DBNull.Value : Values[i]);
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

        /// <summary>
        /// Ejecuta el Procedimiento solicitado a partir de parametros definidos y devuelve los valores de Salida
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <param name="numField">Número de Campos que seran enviados al Procedimiento</param>
        /// <param name="Type">Listado de Tipos de los Campos enviados. Deben ser enviados en el mismo orden de los Campos</param>
        /// <param name="State">estado del Parametro In/Out</param>
        /// <param name="Campos">Listado de Parametros o Campos enviados ha ser ejecutados por el Procedimiento</param>
        /// <param name="Values">Listado de Valores que seran asignados a los Campos</param>
        /// <returns>Cursor con la funcion ejecutada (DataTable)</returns>
        public Object[] objetosProcedure(String Procedure, int numField, String[] Type, String[] State, String[] Campos, Object[] Values)
        {
            Object[] Result = {};
            String[] nameCursor = new String[100];
            int posCursor = 0;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                for (int i = 0; i <= numField - 1; i++)
                {
                    switch (State[i])
                    {
                        case "In":
                            {
                                switch (Type[i])
                                {
                                    case "String":
                                        OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.String, Convert.ToString(Values[i]));
                                        break;
                                    case "Int64":
                                        OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64, string.IsNullOrEmpty(Values[i].ToString()) ? (Object)DBNull.Value : Convert.ToInt64(Values[i]));
                                        break;
                                    case "Float":
                                        OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Object, string.IsNullOrEmpty(Values[i].ToString()) ? (Object)DBNull.Value : Values[i]);
                                        break;
                                    default:
                                        break;
                                }
                            }
                            break;
                        case "Out":
                            {
                                switch (Type[i])
                                {
                                    case "String":
                                        OpenDataBase.db.AddOutParameter(cmdCommand, Campos[i], DbType.String, 255);
                                        break;
                                    case "Int64":
                                        OpenDataBase.db.AddOutParameter(cmdCommand, Campos[i], DbType.Int64, 255);
                                        break;
                                    case "Float":
                                        OpenDataBase.db.AddOutParameter(cmdCommand, Campos[i], DbType.Object, 255);
                                        break;
                                    case "Cursor":
                                        {
                                            OpenDataBase.db.AddParameterRefCursor(cmdCommand, Campos[i]);
                                            nameCursor[posCursor] = Campos[i];
                                            posCursor++;
                                        }
                                        break;
                                    default:
                                        break;
                                }
                            }
                            break;
                    }
                }
                int pos = 0;
                DataSet dsgeneral = new DataSet();
                OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, "tabla");
                Result[pos] = dsgeneral;
            }
            return Result;
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

        

    }
}
