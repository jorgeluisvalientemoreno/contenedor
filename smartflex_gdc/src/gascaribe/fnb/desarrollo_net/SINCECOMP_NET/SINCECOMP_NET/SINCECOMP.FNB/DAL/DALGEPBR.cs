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
    class DALGEPBR
    {
        //nombre de funciones y procedimentos
        //static String deleteA = "ld_boportafolio.DeleteArticle"; //eliminar articulos
        //static String deleteP = "ld_boportafolio.DeletePropert_by_article"; //eliminar propiedadeS
        static String modifyP = "ld_boportafolio.UpdatePropert_by_article"; //modificar propiedades
        static String modifyA = "ld_boportafolio.UpdateArticle"; //modificar articuloS
        static String insertP = "ld_boportafolio.InsertPropert_by_article"; //insertar propiedades
        static String insertA = "ld_boportafolio.InsertArticle"; //insertar articulo
        static String queryP = "LD_BOPortafolio.frfGetRecords_P_B_A"; //consultar propiedades
        static String queryA = "dald_article.frfGetRecords"; //consultar articulo
        //static String secuenceP = "ld_boportafolio.fnugetPropertbyArtId"; //secuencia de propiedades
        //static String secuenceA = "ld_boportafolio.fnugetArticleId"; //secuencia de articulos

        //eliminar propiedades
        //public static void deletePropertbyArticle(Int64 inupropert_by_article_id)
        //{
        //    using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(deleteP))
        //    {
        //        OpenDataBase.db.AddInParameter(cmdCommand, "inupropert_by_article_id", DbType.Int64, inupropert_by_article_id);
        //        OpenDataBase.db.ExecuteNonQuery(cmdCommand);
        //    }
        //}

        //modificar propiedades
        public static void modifyPropertbyArticle(Int64 inupropert_by_article_id, Int64 inuarticleid, String inuproperty_id, String inuvalue)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(modifyP))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inupropert_by_article_id", DbType.Int64, inupropert_by_article_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuproperty_id", DbType.Int64, inuproperty_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuarticle_id", DbType.Int64, inuarticleid);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuvalue", DbType.String, inuvalue);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //guardar propiedades
        public static void savePropertbyArticle(Int64 inupropert_by_article_id, Int64 inuarticleid, String inuproperty_id, String inuvalue)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(insertP))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inupropert_by_article_id", DbType.Int64, inupropert_by_article_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuproperty_id", DbType.Int64, inuproperty_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuarticle_id", DbType.Int64, inuarticleid);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuvalue", DbType.String, inuvalue);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //consecutivo propiedades
        //public static Int64 consProperties()
        //{
        //    using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(secuenceP))
        //    {
        //        OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
        //        OpenDataBase.db.ExecuteNonQuery(cmdCommand);
        //        return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
        //    }
        //}

        //consecutivo articulo
        //public static Int64 consArticle()
        //{
        //    using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(secuenceA))
        //    {
        //        OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
        //        OpenDataBase.db.ExecuteNonQuery(cmdCommand);
        //        return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE")); 
        //    }
        //}

        //eliminar articulos
        //public static void deleteArticle(Int64 inuarticle_id)
        //{
        //    using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(deleteA))
        //    {
        //        OpenDataBase.db.AddInParameter(cmdCommand, "inuarticle_id", DbType.Int64, inuarticle_id);
        //        OpenDataBase.db.ExecuteNonQuery(cmdCommand);
        //    }
        //}

        //modificar articulos
        public static void modifyArticle(Int64 inuarticle_id, String isbescription, Int64 inuwarranty, String inusubline_id,
            String inufinancier_id, String inuconcept_id, String inusupplier_id, String inubrand_id, String isbreference,
            String isbapproved, String isbavalible, String isbactive, String isbprice_control, String isbobservation,
            Decimal? inuvat, String isbinstallation, String isbequivalence)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(modifyA))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuarticle_id", DbType.Int64, inuarticle_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbescription", DbType.String, isbescription);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuwarranty", DbType.Int64, inuwarranty);
                OpenDataBase.db.AddInParameter(cmdCommand, "inusubline_id", DbType.Int64, inusubline_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inufinancier_id", DbType.Int64, inufinancier_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuconcept_id", DbType.Int64, inuconcept_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inusupplier_id", DbType.Int64, inusupplier_id);
                if (inubrand_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inubrand_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inubrand_id", DbType.Int64, inubrand_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbreference", DbType.String, isbreference);
                if (isbapproved == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbapproved", DbType.String, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbapproved", DbType.String, isbapproved);
                if (isbavalible == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbavalible", DbType.String, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbavalible", DbType.String, isbavalible);
                if (isbactive == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbactive", DbType.String, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbactive", DbType.String, isbactive);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbprice_control", DbType.String, isbprice_control);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbobservation", DbType.String, isbobservation);
                if (inuvat == 0) inuvat = null;
                OpenDataBase.db.AddInParameter(cmdCommand, "inuvat", DbType.Decimal, inuvat);
                if (isbinstallation == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbinstallation", DbType.String, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbinstallation", DbType.String, isbinstallation);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbequivalence", DbType.String, isbequivalence);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Confirmar transacciones
        //public static void Save()
        //{
        //    OpenDataBase.Transaction.Commit();
        //}

        //guardar articulos
        public static void saveArticle(Int64 inuarticle_id, String isbescription, Int64 inuwarranty, String inusubline_id,
            String inufinancier_id, String inuconcept_id, String inusupplier_id, String inubrand_id, String isbreference,
            String isbapproved, String isbavalible, String isbactive, String isbprice_control, String isbobservation,
            Decimal? inuvat, String isbinstallation, String isbequivalence)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(insertA))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuarticle_id", DbType.Int64, inuarticle_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbescription", DbType.String, isbescription);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuwarranty", DbType.Int64, inuwarranty);
                OpenDataBase.db.AddInParameter(cmdCommand, "inusubline_id", DbType.Int64, inusubline_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inufinancier_id", DbType.Int64, inufinancier_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuconcept_id", DbType.Int64, inuconcept_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "inusupplier_id", DbType.Int64, inusupplier_id);
                if (inubrand_id == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inubrand_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inubrand_id", DbType.Int64, inubrand_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbreference", DbType.String, isbreference);
                if (isbapproved == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbapproved", DbType.String, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbapproved", DbType.String, isbapproved);
                if (isbavalible == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbavalible", DbType.String, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbavalible", DbType.String, isbavalible);
                if (isbactive == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbactive", DbType.String, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbactive", DbType.String, isbactive);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbprice_control", DbType.String, isbprice_control);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbobservation", DbType.String, isbobservation);
                if (inuvat == 0) inuvat = null;
                OpenDataBase.db.AddInParameter(cmdCommand, "inuvat", DbType.Decimal, inuvat);
                if (isbinstallation == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbinstallation", DbType.String, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbinstallation", DbType.String, isbinstallation);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbequivalence", DbType.String, isbequivalence);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //propiedades
        public static DataTable getProperties(Int64 inuarticle_id)
        {
            DataSet dsproperty = new DataSet("LDPropersbyarticle");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(queryP))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuarticle_id", DbType.Int64, inuarticle_id);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsproperty, "LDPropersbyarticle");
            }
            return dsproperty.Tables["LDPropersbyarticle"];
        }

        //articulo
        public static DataTable getArticle()
        {
            DataSet dsarticle = new DataSet("LDArticle");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(queryA))
            {
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsarticle, "LDArticle");
            }
            return dsarticle.Tables["LDArticle"];
        }

        /**
         * isGranSuperficie: Busca en la base de datos para un proveedor si es gran superficie.
         */
        public static Boolean isGranSuperficie(Int64 prov)
        {
            String postLegProccess = "N";
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCNONBANKFINANCING.fsbGetPostLegProccess"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContractorId", DbType.Int64, prov);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                postLegProccess = OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString();
            };
            return "Y".Equals(postLegProccess);
        }
    }
}
