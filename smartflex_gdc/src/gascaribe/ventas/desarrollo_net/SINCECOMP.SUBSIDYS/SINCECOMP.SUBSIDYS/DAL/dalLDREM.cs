using System;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using OpenSystems.Common.ExceptionHandler;
//using SINCECOMP.SUBSIDYS.Entities;

namespace SINCECOMP.SUBSIDYS.DAL
{
    class dalLDREM
    {

        /// <summary>
        /// Objeto PLSQL para consulta de subsidios
        /// </summary>
        static String queryGrid = "LD_BCSubsidy.frfsubrem";


        /// <summary>
        /// Consulta de subsidios
        /// </summary>
        /// <returns>Tabla con datos de los subsidios</returns>
        public static DataTable getSubsidy()
        {
            DataSet dsquery = new DataSet("queryGrid");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(queryGrid))
            {
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsquery, "queryGrid");
            }
            return dsquery.Tables["queryGrid"];
        }

        //Obtiene el total asignado por un subsidio
        public static Int64 Fnugetsubtotaldelivery(Int64 inusubsidy)
        {
            String sbReturn;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("Ld_BcSubsidy.Fnugetsubtotaldelivery"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inusubsidy", DbType.Int64, inusubsidy);

                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                sbReturn = OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString();

                if (String.IsNullOrEmpty(sbReturn))
                {
                    return 0;
                }
                else
                {
                    return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
                }
            }
        }

        //Obtiene el remanente total de un subsidio
        public static Int64 fnuGetAuthorize_Value(Int64 inusubsidy)
        {
            String sbReturn;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dald_subsidy.fnuGetAuthorize_Value"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inusubsidy", DbType.Int64, inusubsidy);

                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                sbReturn = OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString();

                if (String.IsNullOrEmpty(sbReturn))
                {
                    return 0;
                }
                else
                {
                    return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
                }
            }
        }

        //Estado del subsidio
        public static String fsbGetRemainder_Status(Int64 inusubsidy)
        {
            String sbReturn;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dald_subsidy.fsbGetRemainder_Status"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inusubsidy", DbType.Int64, inusubsidy);

                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                sbReturn = OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString();

                if (String.IsNullOrEmpty(sbReturn))
                {
                    return "0";
                }
                else
                {
                    return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
                }
            }
        }

        /// <summary>
        /// Simulación de distribución de remanente
        /// </summary>
        /// <param name="SubsidyId">ID del subsidio</param>
        /// <param name="inValueDistributing">Valor a distribuir</param>
        /// <param name="inustate_delivery">Flag de simulación</param>
        /// <param name="onuErrorCode">Código de error</param>
        /// <param name="osbErrorMessage">Mensaje de error</param>
        /// <returns></returns>
        public Boolean FblDistrRemainSubsidy(Int64 SubsidyId, Int64 inValueDistributing, String inustate_delivery, Int64 onuErrorCode, String osbErrorMessage)
        {

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("Ld_BoSubsidy.FblDistrRemainSubsidy"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubsidyId", DbType.Int64, SubsidyId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inValueDistributing", DbType.Int64, inValueDistributing);
                OpenDataBase.db.AddInParameter(cmdCommand, "inustate_delivery", DbType.String, inustate_delivery);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 200);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                ExceptionHandler.EvaluateErrorCode
                (
                    OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"),
                    OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage")
                );

                return true;
            }
        }

        /// <summary>
        /// Aplicar remanente distribuido
        /// </summary>
        public static void ProcRemainingApplies()
        {
            //Int64 ONUstate;

            Int64 Error;
            String Mensaje;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("Ld_BoSubsidy.ProcRemainingApplies"))
            {
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 200);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                ExceptionHandler.EvaluateErrorCode
                (
                    OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"),
                    OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage")
                );

                if ((OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode") != DBNull.Value) && (OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage") != DBNull.Value))
                {
                    Error = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));

                    Mensaje = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));

                    System.Windows.Forms.MessageBox.Show(Mensaje);
                }
            }

        }

        /// <summary>
        /// Registra remanente distribuido para los conceptos del subsidio
        /// </summary>
        /// <param name="INUconcepto_rem_id"></param>
        /// <param name="INUubication_id"></param>
        /// <param name="INUasig_value"></param>
        /// <param name="INUsesion"></param>
        /// <param name="ONUErrorCode"></param>
        /// <param name="OSBErrorMessage"></param>
        public void ProcRegistraConceptosRem(Int64 INUconcepto_rem_id, Int64 INUubication_id, Int64 INUasig_value, Int64 INUsesion, Int64 ONUErrorCode, String OSBErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("Ld_BoSubsidy.RegistraConceptosRem"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUconcepto_rem_id", DbType.Int64, INUconcepto_rem_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUubication_id", DbType.Int64, INUubication_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUasig_value", DbType.Int64, INUasig_value);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUsesion", DbType.Int64, INUsesion);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBErrorMessage", DbType.String, 200);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                ONUErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUErrorCode"));
                OSBErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBErrorMessage"));

                ///return ONUErrorCode;
                ExceptionHandler.EvaluateErrorCode
                (
                    ONUErrorCode,
                    OSBErrorMessage
                );
                //OpenDataBase.Transaction.Commit();
            }
        }

        public void updSubsidyRemain(Int64 subsidyId, string state)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("DALD_Subsidy.updRemainder_Status"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuSubsidyId", DbType.Int64, subsidyId);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbRemainder_Status$", DbType.String, state);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        public void persistSimulation()
        {
            string DBObject = "LD_BCSubsidy.persistSimulation";

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(DBObject))
            {
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                OpenDataBase.Transaction.Commit();
            }
        }

    }
}
