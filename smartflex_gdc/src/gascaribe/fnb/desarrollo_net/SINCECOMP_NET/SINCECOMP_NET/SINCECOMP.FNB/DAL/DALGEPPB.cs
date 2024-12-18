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
    class DALGEPPB
    {
        //nombre de funciones y procedimentos
        //static String deletePL = "ld_boportafolio.DeletePriceList"; //eliminar lista de precios
        static String modifyPL = "ld_boportafolio.UpdatePriceList"; //modificar lista de precios
        static String insertPL = "ld_boportafolio.InsertPriceList"; //insertar lista de precios
        static String queryPL = "dald_price_list.frfGetRecords"; //consultar lista de precios
        //static String secuencePL = "ld_boportafolio.fnugetPriceListId"; //secuencia de lista de precios
        //static String secuenceDPL = "ld_boportafolio.fnugetPriceListDetaId"; //secuencia detallle lista de precios
        static String queryDPL = "ld_boportafolio.frfGetRecords_detlist"; //consultar detalle lista de precios
        //static String deleteDPL = "ld_boportafolio.DeletePriceListDetail"; //eliminar detalle lista de precios
        static String modifyDPL = "ld_boportafolio.UpdatePriceListDetail"; //modificar detalle lista de precios
        static String insertDPL = "ld_boportafolio.InsertPriceListDeta"; //insertar detalle lista de precios
        static String approvedList = "ld_boportafolio.approvedList"; //aprobacion de lista de precios
        static String saveChanges = "ld_boportafolio.saveChanges_Price_List_Deta"; //Resgistro de insercion o actuaizaion en detalles de lista de precios

        //insercion o actualizacion de detalle de lista de precios
        public static void procSaveChanges(Int64 inuprice_list_id, String operation)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(saveChanges))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_list_id", DbType.Int64, inuprice_list_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isboperationtype", DbType.String, operation);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //aprobacion lista de precios
        public static void procApprovedList(Int64 inuprice_list_id)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(approvedList))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_list_id", DbType.Int64, inuprice_list_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbstatusapproved", DbType.String, "Y");
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //consecutivo lista de precios
        //public static Int64 consPriceListDetail()
        //{
        //    using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(secuenceDPL))
        //    {
        //        OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
        //        OpenDataBase.db.ExecuteNonQuery(cmdCommand);
        //        return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
        //    }
        //}

        ////consecutivo lista de precios
        //public static Int64 consPriceList()
        //{
        //    using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(secuencePL))
        //    {
        //        OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
        //        OpenDataBase.db.ExecuteNonQuery(cmdCommand);
        //        return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
        //    }
        //}

        //modificar detalle lista de precios
        public static void modifyPriceListDetail(Int64 inuprice_list_deta_id, Int64 inuprice_list_id, String inuarticle_id, Decimal inuprice, Decimal inuprice_aproved,
            String inusale_chanel_id, String inugeograp_location_id, Int64 inuversion)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(modifyDPL))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_list_deta_id", DbType.Int64, inuprice_list_deta_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_list_id", DbType.Int64, inuprice_list_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuarticle_id", DbType.Int64, inuarticle_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice", DbType.Decimal, inuprice);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_aproved", DbType.Decimal, inuprice_aproved);
                if (inusale_chanel_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusale_chanel_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusale_chanel_id", DbType.Int64, inusale_chanel_id);
                if (inugeograp_location_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inugeograp_location_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inugeograp_location_id", DbType.Int64, inugeograp_location_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuversion", DbType.Int64, inuversion);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //guardar detalle lista de precios
        public static void savePriceListDetail(Int64 inuprice_list_deta_id, Int64 inuprice_list_id, String inuarticle_id, Decimal inuprice, Decimal inuprice_aproved,
            String inusale_chanel_id, String inugeograp_location_id, Int64 inuversion)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(insertDPL))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_list_deta_id", DbType.Int64, inuprice_list_deta_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_list_id", DbType.Int64, inuprice_list_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuarticle_id", DbType.Int64, inuarticle_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice", DbType.Decimal, inuprice);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_aproved", DbType.Decimal, inuprice_aproved);
                if (inusale_chanel_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusale_chanel_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusale_chanel_id", DbType.Int64, inusale_chanel_id);
                if (inugeograp_location_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inugeograp_location_id", DbType.Int64, (Object)DBNull.Value);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inugeograp_location_id", DbType.Int64, inugeograp_location_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuversion", DbType.Int64, inuversion);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //eliminar detalle de lista de precios
        //public static void deletePriceListDetail(Int64 inuprice_list_deta_id)
        //{
        //    using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(deleteDPL))
        //    {
        //        OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_list_deta_id", DbType.Int64, inuprice_list_deta_id);
        //        OpenDataBase.db.ExecuteNonQuery(cmdCommand);
        //    }
        //}

        //eliminar lista de precios
        //public static void deletePriceList(Int64 inuprice_list_id)
        //{
        //    using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(deletePL))
        //    {
        //        OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_list_id", DbType.Int64, inuprice_list_id);
        //        OpenDataBase.db.ExecuteNonQuery(cmdCommand);
        //    }
        //}

        //modificar lista de precios
        public static void modifyPriceList(Int64 inuprice_list_id, String inudescription, String inusupplier_id, DateTime inuinitial_date,
            DateTime inufinal_date, String inuapproved, DateTime inucreation_date, Int64 inuversion, String inucondition_approved)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(modifyPL))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_list_id", DbType.Int64, inuprice_list_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inudescription", DbType.String, inudescription);
                OpenDataBase.db.AddInParameter(cmdCommand, "inusupplier_id", DbType.Int64, inusupplier_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuinitial_date", DbType.DateTime, inuinitial_date);
                OpenDataBase.db.AddInParameter(cmdCommand, "inufinal_date", DbType.DateTime, inufinal_date);
                if (inuapproved == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuapproved", DbType.String, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuapproved", DbType.String, inuapproved);
                OpenDataBase.db.AddInParameter(cmdCommand, "inucreation_date", DbType.DateTime, inucreation_date);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuversion", DbType.Int64, inuversion);
                OpenDataBase.db.AddInParameter(cmdCommand, "inucondition_approved", DbType.String, inucondition_approved);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Confirmar transacciones
        //public static void Save()
        //{
        //    OpenDataBase.Transaction.Commit();
        //}

        //guardar lista de precios
        public static void savePriceList(Int64 inuprice_list_id, String inudescription, String inusupplier_id, DateTime inuinitial_date,
            DateTime inufinal_date, String inuapproved, DateTime inucreation_date, Int64 inuversion, String inucondition_approved)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(insertPL))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_list_id", DbType.Int64, inuprice_list_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inudescription", DbType.String, inudescription);
                OpenDataBase.db.AddInParameter(cmdCommand, "inusupplier_id", DbType.String, inusupplier_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuinitial_date", DbType.DateTime, inuinitial_date);
                OpenDataBase.db.AddInParameter(cmdCommand, "inufinal_date", DbType.DateTime, inufinal_date);
                if (inuapproved == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuapproved", DbType.String, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuapproved", DbType.String, inuapproved);
                OpenDataBase.db.AddInParameter(cmdCommand, "inucreation_date", DbType.DateTime, inucreation_date);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuversion", DbType.Int64, inuversion);
                OpenDataBase.db.AddInParameter(cmdCommand, "inucondition_approved", DbType.String, inucondition_approved);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //detallle lista de precios
        public static DataTable getDetailPriceList(Int64 inuprice_list_id)
        {
            DataSet dsdetailpricelist = new DataSet("LDDetailPriceList");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(queryDPL))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuprice_list_id", DbType.Int64, inuprice_list_id);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsdetailpricelist, "LDDetailPriceList");
            }
            return dsdetailpricelist.Tables["LDDetailPriceList"];
        }

        //lista de precios
        public static DataTable getPriceList()
        {
            DataSet dspricelist = new DataSet("LDPriceList");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(queryPL))
            {
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dspricelist, "LDPriceList");
            }
            return dspricelist.Tables["LDPriceList"];
        }
    }
}
