using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.Common.Data;
using OpenSystems.EnterpriseLibrary;

namespace BSS.LineamientosPSPD.src
{
    class GUtilities
    {
        public Int64 GetSeq(String proceso, String seqName)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(proceso))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSeqName", DbType.String, seqName);
                OpenDataBase.db.AddOutParameter(cmdCommand, "Seq", DbType.Int64, 10);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Int64 seq = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "Seq").ToString());
                return seq;
            }
        }

        /// <summary>
        /// Se obtiene el resultado de una consulta para llenar un OpenCombo
        /// </summary>
        /// <param name="query">Consulta para obtener los datos requeridos</param>
        /// <returns>Cursor con el resultado de la consulta</returns>
        public DataTable GetListOfValue(String query)
        {
            DataSet dsLOV = new DataSet("ListOfValues");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_boconstans.frfSentence"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbselect", DbType.String, query);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsLOV, "ListOfValues");
            }

            return dsLOV.Tables["ListOfValues"];
        }

        /// <summary>
        /// Despliega mensaje de error
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void DisplayErrorMessage(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.DisplayError(2741, msj);
        }

        /// <summary>
        /// Elevar Mensaje de Error
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void RaiseERROR(String mesagge)
        {
            String[] msj = mesagge.Split(';');
            ExceptionHandler.Raise(2741, msj);
        }

        /// <summary>
        /// Despliega mensaje de Exito
        /// </summary>
        /// <param name="mesagge">Mensaje a Desplegar</param>
        public void DisplayInfoMessage(String mesagge)
        {
            ExceptionHandler.DisplayMessage(2741, mesagge);
        }

        /// <summary>
        /// Se valida si el atributo se encuentra en la instancia
        /// </summary>
        /// <param name="instance">Nombre de la instancia</param>
        /// <param name="group">Nombre del grupo</param>
        /// <param name="entity">Nombre de la entidad</param>
        /// <param name="attribute">Nombre del atributo</param>
        /// <returns>Retorna un booleano indicando si el atributo está instanciado</returns>
        public Boolean IsAttributeInInstance(String instance, String group, String entity, String attribute)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ge_boinstancecontrol.fblacckeyattributestack"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBINSTANCE", DbType.String, instance);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBGROUP", DbType.String, DBNull.Value);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBENTITY", DbType.String, entity);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBATTRIBUTE", DbType.String, attribute);
                OpenDataBase.db.AddInParameter(cmdCommand, "IONUATTRIBUTE", DbType.Int32, 1);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }

        /// <summary>
        /// Obtiene el valor del atributo instanciado
        /// </summary>
        /// <param name="instance">Nombre de la instancia</param>
        /// <param name="group">Nombre del grupo</param>
        /// <param name="entity">Nombre de la entidad</param>
        /// <param name="attribute">Nombre del atributo</param>
        /// <returns>Retorna el valor del atributo</returns>
        public String GetAttributeValue(String instance, String group, String entity, String attribute)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ge_boinstancecontrol.fblacckeyattributestack"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBINSTANCE", DbType.String, instance);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBGROUP", DbType.String, DBNull.Value);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBENTITY", DbType.String, entity);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBATTRIBUTE", DbType.String, attribute);
                OpenDataBase.db.AddInParameter(cmdCommand, "IONUATTRIBUTE", DbType.Int32, 1);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBVALUE", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return OpenDataBase.db.GetParameterValue(cmdCommand, "OSBVALUE").ToString();
            }
        }

        /// <summary>
        /// Obtiene el valor de un parámetro en LD_PARAMETER
        /// </summary>
        /// <param name="parameterName">Nombre del parámetro</param>
        /// <param name="parameterType">Tipo del valor del parámetro</param>
        /// <returns>Valor del Parametro (Object: puede ser de tipo Cadena o Numérico)</returns>
        public Object getParameterValue(String parameterName, String parameterType)
        {
            try
            {
                Object valor = null;
                switch (parameterType)
                {
                    case "String":
                        {
                            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dald_parameter.fsbgetvalue_chain"))
                            {
                                OpenDataBase.db.AddInParameter(cmdCommand, "inuparameter_id", DbType.String, parameterName);
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
                                OpenDataBase.db.AddInParameter(cmdCommand, "inuparameter_id", DbType.String, parameterName);
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
        /// Hace Commit en la BD
        /// </summary>
        public void doCommit()
        {
            OpenDataBase.Transaction.Commit();
        }

        /// <summary>
        /// Hace Rollback en la BD
        /// </summary>
        public void doRollback()
        {
            OpenDataBase.Transaction.Rollback();
        }
    }
}
