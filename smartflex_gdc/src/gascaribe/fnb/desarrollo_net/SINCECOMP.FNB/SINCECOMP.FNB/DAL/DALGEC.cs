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
    class DALGEC
    {
        //nombre de funciones y procedimentos
        //static String deleteC = "ld_boportafolio.DeleteCommission"; //eliminar comision
        static String modifyC = "ld_boportafolio.UpdateCommission"; //modificar comision
        static String insertC = "ld_boportafolio.InsertCommission"; //insertar comision
        static String queryC = "LD_BOPortafolio.frfGetRecords_commi"; //consultar comisiones
        //static String secuenceC = "ld_boportafolio.fnugetCommissionId"; //secuencia de comision

        /// <summary>
        /// modificar comision
        /// </summary>
        /// <param name="commisionid"></param>
        /// <param name="articleid"></param>
        /// <param name="salechanelid"></param>
        /// <param name="geograplocationid"></param>
        /// <param name="contratorid"></param>
        /// <param name="recoverypercentage"></param>
        /// <param name="pymentpercentage"></param>
        /// <param name="initialdate"></param>
        /// <param name="incluvatpaycommi"></param>
        /// <param name="incluvatrecocommi"></param>
        /// <param name="lineid"></param>
        /// <param name="sublineid"></param>
        /// <param name="supplierid"></param>
        public static void modifyCommission(Int64 commisionid, String articleid, String salechanelid, String geograplocationid,
            String contratorid, Decimal recoverypercentage, Decimal pymentpercentage, DateTime initialdate, String incluvatpaycommi,
            String incluvatrecocommi, String lineid, String sublineid, String supplierid)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(modifyC))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inucommission_id", DbType.Int64, commisionid);
                if (articleid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuarticle_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuarticle_id", DbType.Int64, articleid);
                if (salechanelid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusale_chanel_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusale_chanel_id", DbType.Int64, salechanelid);
                if (geograplocationid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inugeograp_location_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inugeograp_location_id", DbType.Int64, geograplocationid);
                if (contratorid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inucontrator_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inucontrator_id", DbType.Int64, contratorid);
                OpenDataBase.db.AddInParameter(cmdCommand, "inurecovery_percentage", DbType.Decimal, recoverypercentage);
                OpenDataBase.db.AddInParameter(cmdCommand, "inupyment_percentage", DbType.Decimal, pymentpercentage);
                if (initialdate.Date.ToString("dd/MM/yy") == "01/01/01") initialdate = DateTime.Now;
                OpenDataBase.db.AddInParameter(cmdCommand, "idinitial_date", DbType.DateTime, initialdate);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbinclu_vat_pay_commi", DbType.String, incluvatpaycommi);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbinclu_vat_reco_commi", DbType.String, incluvatrecocommi);
                if (lineid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuline", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuline", DbType.Int64, lineid);
                if (sublineid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubline", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubline", DbType.Int64, sublineid);
                if (supplierid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusupplier", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusupplier", DbType.Int64, supplierid);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
            
        }

        /// <summary>
        /// guardar comision
        /// </summary>
        /// <param name="commisionid"></param>
        /// <param name="articleid"></param>
        /// <param name="salechanelid"></param>
        /// <param name="geograplocationid"></param>
        /// <param name="contratorid"></param>
        /// <param name="recoverypercentage"></param>
        /// <param name="pymentpercentage"></param>
        /// <param name="initialdate"></param>
        /// <param name="incluvatpaycommi"></param>
        /// <param name="incluvatrecocommi"></param>
        /// <param name="lineid"></param>
        /// <param name="sublineid"></param>
        /// <param name="supplierid"></param>
        public static void saveCommission(Int64 commisionid, String articleid, String salechanelid, String geograplocationid,
            String contratorid, Decimal recoverypercentage, Decimal pymentpercentage, DateTime initialdate, String incluvatpaycommi,
            String incluvatrecocommi, String lineid, String sublineid, String supplierid)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(insertC))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inucommission_id", DbType.Int64, commisionid);
                if (articleid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuarticle_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuarticle_id", DbType.Int64, articleid);
                if (salechanelid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusale_chanel_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusale_chanel_id", DbType.Int64, salechanelid);
                if (geograplocationid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inugeograp_location_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inugeograp_location_id", DbType.Int64, geograplocationid);
                if (contratorid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inucontrator_id", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inucontrator_id", DbType.Int64, contratorid);
                OpenDataBase.db.AddInParameter(cmdCommand, "inurecovery_percentage", DbType.Decimal, recoverypercentage);
                OpenDataBase.db.AddInParameter(cmdCommand, "inupyment_percentage", DbType.Decimal, pymentpercentage);
                if (initialdate.Date.ToString("dd/MM/yy") == "01/01/01") initialdate = DateTime.Now;
                OpenDataBase.db.AddInParameter(cmdCommand, "idinitial_date", DbType.DateTime, initialdate);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbinclu_vat_pay_commi", DbType.String, incluvatpaycommi);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbinclu_vat_reco_commi", DbType.String, incluvatrecocommi);
                if (lineid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuline", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuline", DbType.Int64, lineid);
                if (sublineid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubline", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusubline", DbType.Int64, sublineid);
                if (supplierid == " ")
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusupplier", DbType.Int64, null);
                else
                    OpenDataBase.db.AddInParameter(cmdCommand, "inusupplier", DbType.Int64, supplierid);
                OpenDataBase.db.AddOutParameter(cmdCommand, "result", DbType.Int64, 8);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                //1 insercion correcta, 0 clave unica violada, -1 insercion incorrecta (error smartflex)
                Int64 resultado = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "result"));
            }
        }

        //comisiones
        public static DataTable getCommission()
        {
            DataSet dscommission = new DataSet("LDCommission");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(queryC))
            {
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dscommission, "LDCommission");
            }
            return dscommission.Tables["LDCommission"];
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static DataSet GetSentence(string Sentence)
        {
            DataSet ds = new DataSet();
            string _storeProcedure = "ld_boconstans.frfSentence";

            using (DbCommand command = OpenDataBase.db.GetStoredProcCommand(_storeProcedure))
            {
                OpenDataBase.db.AddInParameter(command, "isbselect", DbType.String, Sentence);
                OpenDataBase.db.AddReturnRefCursor(command);
                OpenDataBase.db.LoadDataSet(command, ds, "ValueList");
            }
           
            return ds;
        }



    }
}
