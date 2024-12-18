using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using SINCECOMP.FNB.Entities;
using System.Windows.Forms;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.DAL
{
    class DALGENERAL
    {

        //nombre de funciones y procedimentos
        static String fechalimite = "DALD_suppli_modifica_date.frfGetRecords"; //establece gecha limite para actualizaciones
        static String usuarioconectado = "ld_boutilflow.fnuGetSupplierConect"; //verificar que usuario se ha conectado al sistema
        static String listavalores = "ld_boconstans.frfSentence"; //genera listas de valores a apartir de una consulta basica (select)

        /// <summary>
        /// Establece la fecha limite para realizar modificaciones de los Proveedores
        /// </summary>
        /// <returns>Cursor con la Fecha Limite (DataTable)</returns>
        public DataTable getLimitDate()
        {
            DataSet dslimitdate = new DataSet("LDLimit");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(fechalimite))
            {
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dslimitdate, "LDLimit");
            }
            return dslimitdate.Tables["LDLimit"];
        }

        /// <summary>
        /// Obtiene el Uusario conectado a la forma
        /// </summary>
        /// <returns>Cursor con la informacion del usuario Conectado (DataTable)</returns>
        public Int64 getUserConnect()
        {
            String UserUnit;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(usuarioconectado))
            {
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                UserUnit = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }


            return Convert.ToInt64(UserUnit);
        }

        /// <summary>
        /// Apartir de una consulta diseña una DataTable para aplicarlo en un Combo
        /// </summary>
        /// <param name="Query">Consulta en SQL requerida para obtener la informacion a mostrar</param>
        /// <returns>Cursor con la información de la consulta realizada (DataTable)</returns>
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



        public DataTable getValueListNumberId(String Query, String valueCodigo)
        {
            DataSet dsValueList = new DataSet("ValueList");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(listavalores))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbselect", DbType.String, Query);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsValueList, "ValueList");
            }

            DataRow blanItem = dsValueList.Tables["ValueList"].NewRow();

            dsValueList.Tables["ValueList"].Rows.InsertAt(blanItem, 0);



            return dsValueList.Tables["ValueList"];
        }

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
        /// Confirma el guardado en la Base de Datos
        /// </summary>
        public void doCommit()
        {
            OpenDataBase.Transaction.Commit();

        }

        /// <summary>
        /// Deshace los cambios en la Base de Datos hasta el ultimo punto
        /// </summary>
        public void doRollback()
        {
            OpenDataBase.Transaction.Rollback();

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
                                OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.String, string.IsNullOrEmpty(Values[i].ToString()) ? null : Convert.ToString( Values[i]) );
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
        /// Ejecuta el Procedimiento solicitado a partir de parametros definidos y devuelve el Cursor con los datos Solicitados
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <returns></returns>
        public DataTable cursorProcedure(String Procedure)
        {
            DataSet dsgeneral = new DataSet("Tabla");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsgeneral, "Tabla");
            }
            return dsgeneral.Tables["Tabla"];
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
                                (Object) DBNull.Value : 
                                Convert.ToInt64(Values[i]));
                            //OpenDataBase.db.AddInParameter(cmdCommand, Campos[i], DbType.Int64, Convert.ToInt64(Values[i]));
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

        /// <summary>
        /// Ejecuta el Procedimiento solicitado a partir de parametros definidos y devuelve un valor con el dato Solicitado
        /// </summary>
        /// <param name="Procedure">Nombre del procedimiento a Ejecutar</param>
        /// <param name="TypeReturn">Tipo de Valor que sera devuelto</param>
        /// <returns></returns>
        public Object valueReturn(String Procedure, String TypeReturn)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(Procedure))
            {
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

        public String getPackageByConsecutive(String consecutive)
        {
            String packageId;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fnugetPackageByCons"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuConsecutive", DbType.String, consecutive);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                packageId = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }

            return packageId;
        }

        public String getConsecutiveByPackage(String packageId)
        {
            String consecutive;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BONONBANKFINANCING.fnugetConsByPackage"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.String, packageId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                consecutive = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }

            return consecutive;
        }
    }
}
