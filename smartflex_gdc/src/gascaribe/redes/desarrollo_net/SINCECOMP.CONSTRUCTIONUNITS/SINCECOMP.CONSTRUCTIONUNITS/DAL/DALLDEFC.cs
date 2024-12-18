using System;
using System.Collections.Generic;
using System.Text;

// Librerías sistema
using System.Data;
using System.Data.Common;

// Librerías OpenSystems
using OpenSystems.Common.Data;

using SINCECOMP.CONSTRUCTIONUNITS.Entity;

namespace SINCECOMP.CONSTRUCTIONUNITS.DAL
{
    class DALLDEFC
    {
        public static Int64 ExpressionReferenceRecords(Int64 GeograpLocationId, Int64 InitialYear, Int64 InitialMonth, Int64 FinalYear, Int64 FinalMonth)
        {

            Int64 nuInsert;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOExecutedRelMarket.ProCregInfo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuGeograp_Location_Id", DbType.Int64, GeograpLocationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialYear", DbType.Int64, InitialYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuInitialMonth", DbType.Int64, InitialMonth);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalYear", DbType.Int64, FinalYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuFinalMonth", DbType.Int64, FinalMonth);

                OpenDataBase.db.AddOutParameter(cmdCommand, "onuInsert", DbType.Int64, 10);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                nuInsert = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuInsert"));

                return nuInsert;
                //Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuInsert"));

            }
        }


        public static DataTable ExpressionReferenceRecordsProLDCreg(Int64 nuTypeQuery, Int64 nuYear, String sbDescrelevantmarket, String DescConstructUnit)
        {

            DataSet DSCREG = new DataSet("LDCREG");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedRelMarket.ProLDCreg"))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "inuTypeQuery", DbType.Int64, nuTypeQuery);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuYear", DbType.Int64, nuYear);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuDescRelevantMarket", DbType.String, sbDescrelevantmarket);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuDescConstructUnit", DbType.String, DescConstructUnit);

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSCREG, "LDCREG");
            }
            return DSCREG.Tables["LDCREG"];
        }

        public static DataTable DSGeograLocation()
        {

            DataSet DSGeograLocation = new DataSet("GeGeograLocation");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedRelMarket.ProGeograLocation"))
            {
                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSGeograLocation, "GeGeograLocation");
            }
            return DSGeograLocation.Tables["GeGeograLocation"];
        }

        public static DataTable DSLdRelevantMarket()
        {

            DataSet DSLdRelevantMarket = new DataSet("LdRelevantMarket");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCExecutedRelMarket.ProLdRelevantMarket"))
            {

                OpenDataBase.db.AddParameterRefCursor(cmdCommand);

                OpenDataBase.db.LoadDataSet(cmdCommand, DSLdRelevantMarket, "LdRelevantMarket");
            }
            return DSLdRelevantMarket.Tables["LdRelevantMarket"];
        }

        public static String ColumnExcel(Int64 nuColumnNumber)
        {

            Int64 intDividend = nuColumnNumber;
            string strColumnName = String.Empty;
            Int64 intModulo;
            while (intDividend > 0)
            {
                intModulo = (intDividend - 1) % 26;
                strColumnName = Convert.ToChar(65 + intModulo).ToString() + strColumnName;
                intDividend = (Int64)((intDividend - intModulo) / 26);
            }
            return strColumnName;
        }
    }
}


