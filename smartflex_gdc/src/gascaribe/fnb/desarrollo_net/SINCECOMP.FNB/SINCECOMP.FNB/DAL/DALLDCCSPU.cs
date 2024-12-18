using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using SINCECOMP.FNB.Entities;
namespace SINCECOMP.FNB.DAL
{
    class DALLDCCSPU
    {
        public static DataTable FtrfPromissoryLDCCSPU(Int64 nuPackageId, String sbPromissoryTypeDebtor, String sbPromissoryTypeCosigner)
        {
            DataSet DSpromissory = new DataSet("promissory");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.FtrfPromissoryLDCCSPU"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuPackageId", DbType.Int64, nuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbPromissoryTypeDebtor", DbType.String, sbPromissoryTypeDebtor);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbPromissoryTypeCosigner", DbType.String, sbPromissoryTypeCosigner);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSpromissory, "promissory");
            }
            return DSpromissory.Tables["promissory"];
        }

        public static DataTable FRTDATOSSOLICITUPAGAREUNICO(String FindRequest)
        {
            DataSet DSSaleFNB = new DataSet("GeneralFNB");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.FRTDATOSSOLICITUPAGAREUNICO"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inufindvalue", DbType.Int64, Convert.ToInt64(FindRequest));
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSSaleFNB, "GeneralFNB");
            }
            return DSSaleFNB.Tables["GeneralFNB"];
        }

        public static DataTable FRTPAGUNIDAT(String FindRequest)
        {
            DataSet DSAGUNIDAT = new DataSet("LDCPAGUNIDAT");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVENTAPAGOUNICO.FRTPAGUNIDAT"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inufindvalue", DbType.Int64, Convert.ToInt64(FindRequest));
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSAGUNIDAT, "LDCPAGUNIDAT");
            }
            return DSAGUNIDAT.Tables["LDCPAGUNIDAT"];
        }

        //CASO 200-2215
        public static void EditPromissory(Int64 package_id, String promissory_type, String debtorname, String last_name, Int64 forwardingplace, DateTime forwardingdate, DateTime birthdaydate, Int64 propertyphone_id, Int64 movilphone_id, String documento, Int64 pagare, out Int64 osberror, out String osbmsjError)
        {
            osberror = 0;
            osbmsjError = "";
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(BL.BLConsultas.editPrommisory))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, package_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPromissoryType", DbType.String, promissory_type);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbDebtorname", DbType.String, debtorname);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbLastName", DbType.String, last_name);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuForwardingPlace", DbType.Int64, forwardingplace);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtforwardingdate", DbType.DateTime, forwardingdate);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtBirthdayDate", DbType.DateTime, birthdaydate);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbPropertyPhone", DbType.Int64, propertyphone_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbMovilPhone", DbType.Int64, movilphone_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbdocumento", DbType.String, documento);
                OpenDataBase.db.AddInParameter(cmdCommand, "inupagare", DbType.Int64, pagare);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osberror", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbmensaje", DbType.String, 200);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                osberror = Int64.Parse(OpenDataBase.db.GetParameterValue(cmdCommand, "osberror").ToString());
                osbmsjError = OpenDataBase.db.GetParameterValue(cmdCommand, "osbmensaje").ToString();
            }
        }

        public static void validEditPromissory(Int64 package_id, out Int64 osberror, out String osbmsjError)
        {
            osberror = 0;
            osbmsjError = "";
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(BL.BLConsultas.validarEdicion))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, package_id);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onucodigoerror", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbmensaje", DbType.String, 200);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                osberror = Int64.Parse(OpenDataBase.db.GetParameterValue(cmdCommand, "onucodigoerror").ToString());
                osbmsjError = OpenDataBase.db.GetParameterValue(cmdCommand, "osbmensaje").ToString();
            }
        }
        //Fin 200-2215

    }
}
