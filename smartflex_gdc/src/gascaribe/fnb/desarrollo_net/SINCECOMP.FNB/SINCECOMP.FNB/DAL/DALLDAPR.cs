using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.FNB.Entities;
using System.Data;
using OpenSystems.Common.Data;
using System.Data.Common;

namespace SINCECOMP.FNB.DAL
{
    class DALLDAPR
    {
        //nombre de funciones y procedimentos
        //static String deleteP = "ld_boportafolio.DeleteLD_Property"; //eliminar propiedades
        static String modifyP = "ld_boportafolio.UpdateLD_Property"; //modificar propiedades
        static String insertP = "ld_boportafolio.InsertLD_Property"; //insertar propiedades
        static String queryP = "dald_property.frfGetRecords"; //consultar propiedades
        //static String secuenceP = "ld_boportafolio.fnugetPropertId"; //secuencia propiedades

        //consecutivo
        //public static Int64 consPropert()
        //{
        //    using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(secuenceP))
        //    {
        //        OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
        //        OpenDataBase.db.ExecuteNonQuery(cmdCommand);
        //        return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
        //    }
        //}

        //eliminar propiedades
        //public static void deleteProperty(Int64 inuproperty_id)
        //{
        //    using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(deleteP))
        //    {
        //        OpenDataBase.db.AddInParameter(cmdCommand, "inuproperty_id", DbType.Int64, inuproperty_id);
        //        OpenDataBase.db.ExecuteNonQuery(cmdCommand);
        //    }
        //}

        ////guardar cambios
        //public static void Save()
        //{
        //    OpenDataBase.Transaction.Commit();
        //}

        ////actualizar propiedades
        public static void modifyProperty(Int64 inuproperty_id, String isbdescription)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(modifyP))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuproperty_id", DbType.Int64, inuproperty_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbdescription", DbType.String, isbdescription);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //guardar propiedades
        public static void saveProperty(Int64 inuproperty_id, String isbdescription)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(insertP))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuproperty_id", DbType.Int64, inuproperty_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbdescription", DbType.String, isbdescription);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //consulta de propiedades
        public static DataTable getProperty()
        {
            DataSet dsproperty = new DataSet("LDProperty");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(queryP))
            {
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsproperty, "LDProperty");
            }
            return dsproperty.Tables["LDProperty"];
        }

        //vhurtadoSAO212591: Obtiene núm consecutivo por solicitud
        public static Int64 getConsecutiveByReq(Int64 inuRequestId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_bononbankfinancing.GetConsecutiveByReq"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuRequestId", DbType.Int64, inuRequestId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuConsecutive", DbType.Int64, 100);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                Int64 consecutive = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "onuConsecutive").ToString()) ? 0 : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuConsecutive").ToString());
                return consecutive;
            }
        }
    }
}
