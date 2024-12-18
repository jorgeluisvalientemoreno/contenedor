using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Data;
using System.Data.Common;
using System.Data;
using System.IO;

namespace SINCECOMP.FNB.DAL
{
    class DALFIACM
    {
        static String insertManualquota = "LD_BONONBANKFINANCING.InsertManualQuota"; //insercion manual de cuota 
        static String secuenceMQ = "LD_BONONBANKFINANCING.fnugetManualquota"; //consecutivo de quota

        //guardar cambios
        public static void Save()
        {
            OpenDataBase.Transaction.Commit();
        }

        //insertar quota
        public static void insertQuota(Int64 inumanual_quota_id, Int64 inusubscription_id, Int64 inuquotavalue, DateTime inuinitial_date, 
            String inufinal_date, String inusupport_file, String inuobservation, String inuprint_in_bill)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(insertManualquota))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inumanual_quota_id", DbType.Int64, inumanual_quota_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inusubscription_id", DbType.Int64, inusubscription_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuquotavalue", DbType.Int64, inuquotavalue);
                if (inuinitial_date.ToString("dd/MM/yyyy") == "")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuinitial_date", DbType.DateTime, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuinitial_date", DbType.DateTime, inuinitial_date.ToString("dd/MM/yyyy"));
                if (inufinal_date == "")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inufinal_date", DbType.DateTime, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inufinal_date", DbType.DateTime, inufinal_date);
                //
                if (!String.IsNullOrEmpty(inusupport_file))
                {
                    String filePath = Convert.ToString(inusupport_file);
                    FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
                    byte[] fileData = new byte[fs.Length];
                    fs.Read(fileData, 0, System.Convert.ToInt32(fs.Length));
                    fs.Close();
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusupport_file", DbType.Binary, fileData);
                }
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusupport_file", DbType.Binary , null);
                //
                OpenDataBase.db.AddInParameter(cmdCommand, "inuobservation", DbType.String, inuobservation);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprint_in_bill", DbType.String, inuprint_in_bill);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //consecutivo manual quota
        public static Int64 consManualQuota()
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(secuenceMQ))
            {
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }


                //consecutivo manual quota
        public static Double validateManualQuota(Int64 subscriptionId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCNONBANKFINANCING.FnuGetManualQuota"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inusubscriptionid", DbType.Int64, subscriptionId);       
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Double, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                
                
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Obtiene el detalle del cupo manual  
        /// </summary>
        /// <param name="subscripcion"></param>
        /// <param name="quota"></param>
        /// <param name="initialDate"></param>
        /// <param name="finalDate"></param>
        public static void getManualQuota(Int64 subscripcion, DateTime inInitial_date, String inFinal_date, out Double quota, out DateTime? initialDate, out DateTime? finalDate)
        {
            DateTime? date = null;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_bcnonbankfinancing.getmanualquota"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inusubscriptionid", DbType.Int64, subscripcion);
                //EVESAN 30/JUNIO/2013
                OpenDataBase.db.AddInParameter(cmdCommand, "idaInitial_date", DbType.DateTime, inInitial_date);
                OpenDataBase.db.AddInParameter(cmdCommand, "idaFinal_date", DbType.DateTime, inFinal_date);
                ////////////////////// 
                OpenDataBase.db.AddOutParameter(cmdCommand, "ocupo_manual_vigente", DbType.Double, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ofecha_inicial", DbType.DateTime, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ofecha_final", DbType.DateTime, 10);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                quota = Double.Parse(OpenDataBase.db.GetParameterValue(cmdCommand, "ocupo_manual_vigente").ToString());
                initialDate = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "ofecha_inicial").ToString()) ? date : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "ofecha_inicial").ToString());

                finalDate = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "ofecha_final").ToString()) ? date : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "ofecha_final").ToString());

            }

        }

        
    }
}
