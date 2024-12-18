using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using SINCECOMP.FNB.Entities;
using System.IO;

namespace SINCECOMP.FNB.DAL
{
    class DALFIACE
    {
        //nombre de funciones y procedimentos
        static String deleteEQ = "ld_boportafolio.DeleteExtraQuota"; //eliminar cupo extra
        static String modifyEQ = "ld_boportafolio.UpdateExtraQuota"; //modificar cupo extra
        static String insertEQ = "ld_boportafolio.InsertExtraQuota"; //insertar cupo extra
        static String queryEQ = "dald_extra_quota.frfGetRecords"; //consultar cupo extra
        static String secuenceEQ = "ld_boportafolio.fnugetExtraQuotaId"; //secuencia cupo extra

        //consecutivo cupo extra
        public static Int64 consExtraQuota()
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(secuenceEQ))
            {
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        //eliminar cupos extra
        public static void deleteExtraQuota(Int64 inuextra_quota_id)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(deleteEQ))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuextra_quota_id", DbType.Int64, inuextra_quota_id);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //guardar cambios
        public static void Save()
        {
            OpenDataBase.Transaction.Commit();
        }

        //actualizar cupos extra
        public static void modifyExtraQuota(Int64 inuextra_quota_id, String inusupplier_id, String inucategory_id, String inusubcategory_id,
            String inugeograp_location_id, String inusale_chanel_id, String inuquota_option, Decimal inuvalue, String inuline_id,
            String inusubline_id, DateTime inuinitial_date, DateTime inufinal_date, String inuobservation, String inudocument, Object ruta, String td)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(modifyEQ))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuextra_quota_id", DbType.Int64, inuextra_quota_id);
                if (inusupplier_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusupplier_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusupplier_id", DbType.Int64, inusupplier_id);
                if (inucategory_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inucategory_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inucategory_id", DbType.Int64, inucategory_id);
                if (inusubcategory_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubcategory_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubcategory_id", DbType.Int64, inusubcategory_id);
                if (inugeograp_location_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inugeograp_location_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inugeograp_location_id", DbType.Int64, inugeograp_location_id);
                if (inusale_chanel_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusale_chanel_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusale_chanel_id", DbType.Int64, inusale_chanel_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuquota_option", DbType.String, inuquota_option);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuvalue", DbType.Decimal, inuvalue);
                if (inuline_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuline_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuline_id", DbType.Int64, inuline_id);
                if (inusubline_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubline_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubline_id", DbType.Int64, inusubline_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuinitial_date", DbType.DateTime, inuinitial_date);
                OpenDataBase.db.AddInParameter(cmdCommand, "inufinal_date", DbType.DateTime, inufinal_date);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuobservation", DbType.String, inuobservation);
                //archivo
                if (inudocument == "Si")
                {
                    switch (td)
                    {
                        case "B":
                                OpenDataBase.db.AddInParameter(cmdCommand, "inudocument", DbType.Binary, ruta);
                            break;
                        case "P":
                            {
                                String filePath = Convert.ToString(ruta);
                                FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
                                byte[] fileData = new byte[fs.Length];
                                fs.Read(fileData, 0, System.Convert.ToInt32(fs.Length));
                                fs.Close();
                                OpenDataBase.db.AddInParameter(cmdCommand, "inudocument", DbType.Binary, fileData);
                            }
                            break;
                    }
                }
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inudocument", DbType.Binary, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //guardar cupos extra
        public static void saveExtraQuota(Int64 inuextra_quota_id, String inusupplier_id, String inucategory_id, String inusubcategory_id,
            String inugeograp_location_id, String inusale_chanel_id, String inuquota_option, Decimal inuvalue, String inuline_id,
            String inusubline_id, DateTime inuinitial_date, DateTime inufinal_date, String inuobservation, String inudocument, Object ruta, String td)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(insertEQ))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuextra_quota_id", DbType.Int64, inuextra_quota_id);
                if (inusupplier_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusupplier_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusupplier_id", DbType.Int64, inusupplier_id);
                if (inucategory_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inucategory_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inucategory_id", DbType.Int64, inucategory_id);
                if (inusubcategory_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubcategory_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubcategory_id", DbType.Int64, inusubcategory_id);
                if (inugeograp_location_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inugeograp_location_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inugeograp_location_id", DbType.Int64, inugeograp_location_id);
                if (inusale_chanel_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusale_chanel_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusale_chanel_id", DbType.Int64, inusale_chanel_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuquota_option", DbType.String, inuquota_option);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuvalue", DbType.Decimal, inuvalue);
                if (inuline_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuline_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuline_id", DbType.Int64, inuline_id);
                if (inusubline_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubline_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubline_id", DbType.Int64, inusubline_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuinitial_date", DbType.DateTime, inuinitial_date);
                OpenDataBase.db.AddInParameter(cmdCommand, "inufinal_date", DbType.DateTime, inufinal_date);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuobservation", DbType.String, inuobservation);
                //archivo
                if (inudocument == "Si")
                {
                    String filePath = Convert.ToString(ruta);
                    FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
                    byte[] fileData = new byte[fs.Length];
                    fs.Read(fileData, 0, System.Convert.ToInt32(fs.Length));
                    fs.Close();
                    OpenDataBase.db.AddInParameter(cmdCommand, "inudocument", DbType.Binary, fileData);
                }
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inudocument", DbType.Binary, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //consulta de extra cupo
        public static DataTable getExtraQuota()
        {
            DataSet dsextraquota = new DataSet("LDExtraQuota");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(queryEQ))
            {
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsextraquota, "LDExtraQuota");
            }
            return dsextraquota.Tables["LDExtraQuota"];
        }

    }
}
