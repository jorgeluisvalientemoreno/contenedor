using System;
using System.Collections.Generic;
using System.Text;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Data;
using OpenSystems.Common.ExceptionHandler;
using Ludycom.Constructoras.ENTITIES;

namespace Ludycom.Constructoras.DAL
{
    class DALDCMDOINT
    {
        public DataTable FrfOrdenInternas(Int64 inuProyecto)
        {
            DataSet DSDatosOrdenTrabajo = new DataSet("DatosOrdenInternas");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.FrfOrdenInternasMod"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProyecto", DbType.Int64, inuProyecto);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosOrdenTrabajo, "DatosOrdenInternas");
            }

            return DSDatosOrdenTrabajo.Tables["DatosOrdenInternas"];            
        }
        public String funProcesaOrden(Int64? ordenuno, Int64? ordendos)
        {

            String nullString = null;

            String sberror = null;
            Int64? nullValue = null;
            Int64? nuerror = 0;
            // MessageBox.Show("Ingreso funProcesaOrden" + inuProyecto + " orden " + orden + "solcitud " + solicitud +"estado "+ estado);
            try
            {

                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.prModiOrdInte"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuOrdenOrig", DbType.Int64, ordenuno);
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuOrdenDest", DbType.Int64, ordendos);
                    OpenDataBase.db.AddOutParameter(cmdCommand, "onuok", DbType.Int64, 10);
                    OpenDataBase.db.AddOutParameter(cmdCommand, "osberror", DbType.String, 4000);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                    nuerror = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onuok"))) ? nullValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuok"));
                    // sberror = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osberror"));
                    sberror = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osberror"))) ? nullString : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osberror"));
                }
            }
            catch (Exception e)
            {
                GlobalExceptionProcessing.ShowErrorException(e);

                sberror = e.Message;
            }

            return sberror;
        }  
    }
}
