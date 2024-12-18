using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using SINCECOMP.FNB.Entities;
using System.Windows.Forms;

namespace SINCECOMP.FNB.DAL
{
    class DALGB
    {
        //nombre de funciones y procedimentos
        static String deleteC = "ld_boportafolio.DeleteBrand"; //eliminar marca
        static String modifyC = "ld_boportafolio.UpdateBrand"; //modificar marca
        static String insertC = "ld_boportafolio.InsertBrand"; //insertar marca
        static String queryC = "LD_BOPortafolio.frfGetRecords_brand"; //consultar marca
        static String secuenceC = "ld_boportafolio.fnugetBrand"; //secuencia de marca

        //consecutivo articulo
        public static Int64 consBrand()
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(secuenceC))
            {
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        //eliminar marca
        public static void deleteBrand(Int64 inubrand_id)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(deleteC))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inubrand_id", DbType.Int64, inubrand_id);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //modificar marcas
        public static void modifyBrand(Int64 inubrand_id, String inudescription, String inuapproved, String inucondition_approved)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(modifyC))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inubrand_id", DbType.Int64, inubrand_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inudescription", DbType.String, inudescription);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuapproved", DbType.String, inuapproved);
                OpenDataBase.db.AddInParameter(cmdCommand, "inucondition_approved", DbType.String, inucondition_approved);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //guardar marcas
        public static void saveBrand(Int64 inubrand_id, String inudescription, String inuapproved, String inucondition_approved)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(insertC))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inubrand_id", DbType.Int64, inubrand_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inudescription", DbType.String, inudescription);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuapproved", DbType.String, inuapproved);
                OpenDataBase.db.AddInParameter(cmdCommand, "inucondition_approved", DbType.String, inucondition_approved);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Confirmar transacciones
        public static void Save()
        {
            OpenDataBase.Transaction.Commit();
        }

        //marcas
        public static DataTable getBrand()
        {
            DataSet dsbrand = new DataSet("LDBrand");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(queryC))
            {
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsbrand, "LDBrand");
            }
            return dsbrand.Tables["LDBrand"];
        }
    }
}
