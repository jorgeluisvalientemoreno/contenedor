using System;
using System.Collections.Generic;
using System.Text;
using SINCECOMP.VALORECLAMO.Entities;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Data;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.VALORECLAMO.DAL
{
    internal class DALLDVALREC
    {

        //GetSubcriptionData
        public dataLDVALREC getSubscriptionData(Int64 subscription)
        {
            DALGENERAL dalGeneral = new DALGENERAL();
            String[] tipos = { "Int64" };
            String[] campos = { "inucontrato" };
            object[] valores = { subscription };
            DataTable Datos = dalGeneral.cursorProcedure("LDC_PKVALORESRECLAMO.getdatoscontrato", 1, tipos, campos, valores);
            dataLDVALREC DataLDVALREC = new dataLDVALREC
            {
                funcionario = Datos.Rows[0].ItemArray[0].ToString(),
                puntoatencion = Datos.Rows[0].ItemArray[1].ToString(),
                solicitantetipodoc = Datos.Rows[0].ItemArray[2].ToString().Split(' ')[0].ToString(),
                solicitantedoc = Datos.Rows[0].ItemArray[3].ToString(),
                identificadorCliente = Datos.Rows[0].ItemArray[4].ToString(),
                nombre = Datos.Rows[0].ItemArray[5].ToString(),
                direccionrespuesta = Int64.Parse(Datos.Rows[0].ItemArray[6].ToString())
            };
            return DataLDVALREC;
        }

        public Int64 getContract(String factura)
        {
            DALGENERAL dalGeneral = new DALGENERAL();
            String[] tipos = { "Int64" };
            String[] campos = { "inufactura" };
            String[] valores = { factura };
            Int64 Datos = Int64.Parse(dalGeneral.valueReturn("LDC_PKVALORESRECLAMO.fnuGetIssuscrip", 1, tipos, campos, valores, "Int64").ToString());
            return Datos;
        }

        public Int64 RegisterXML(String XML)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("OS_RegisterRequestWithXML"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbrequestxml", DbType.String, XML);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onupackageid", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onumotiveid", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuerrorcode", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osberrormessage", DbType.String, 200);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int64 error = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuerrorcode"));
                String message = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osberrormessage"));
                if (error == 0)
                {
                    return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onupackageid"));
                }
                else
                {
                    ExceptionHandler.DisplayMessage(2741, message);// + "\n" + XML);
                    OpenDataBase.Transaction.Rollback();
                    return 0;
                }
            }
        }

        public Int64 SolicitudInteraccion(Int64 Solicitud)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKVALORESRECLAMO.Progetsolintera"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackage", DbType.Int64, Solicitud);
                OpenDataBase.db.AddOutParameter(cmdCommand, "inuinteraccion", DbType.Int64, 15);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                Int64 interaccion = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "inuinteraccion"));
                return interaccion;
            }
        }

        public void doCommit()
        {
            OpenDataBase.Transaction.Commit();
        }
    }
}
