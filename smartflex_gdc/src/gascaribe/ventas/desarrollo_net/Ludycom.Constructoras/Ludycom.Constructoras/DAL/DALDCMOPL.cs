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
    class DALDCMOPL
    {
      //  BLLDCMOPL blLDCMOPL = new BLLDCMOPL();
        public List<ListadoInternas> FrfOrdenInternas(Int64 inuProyecto)
        {
            DataSet DSDatosOrdenTrabajo = new DataSet("DatosOrdenInternas");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.FrfOrdenInternas"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProyecto", DbType.Int64, inuProyecto);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosOrdenTrabajo, "DatosOrdenInternas");
            }

            List<ListadoInternas> EOrdenInternas = new List<ListadoInternas>();

            foreach (DataRow x in DSDatosOrdenTrabajo.Tables["DatosOrdenInternas"].Rows)
            {
                //
                /* String datos = x[0].ToString() + " " + Convert.ToInt64(x[1]) + " " + Convert.ToInt64(x[2]) + " " + Convert.ToInt64(x[3]) + " " + x[4].ToString();
                 blLDCMOPL.mensajeERROR(datos);*/

                EOrdenInternas.Add(new ListadoInternas(String.IsNullOrEmpty(x[0].ToString()) ? false : x[0].ToString().Equals("N") ? false : true, //Orden,
                         Convert.ToInt64(x[1]),//orden,
                          Convert.ToInt64(x[2]),//solicitud,
                        Convert.ToInt64(x[3]),//contrato,
                         Convert.ToInt64(x[4]),//producto,
                        x[5].ToString()//Direccion,                       
                        ));
            }

            return EOrdenInternas;

        }

        public String funProcesaOrden(Int64 inuProyecto, Int64 orden, Int64 solicitud, String estado)
        {

            String nullString = null;
            
            String sberror = null;
            Int64? nullValue = null;
            Int64? nuerror = 0;
           // MessageBox.Show("Ingreso funProcesaOrden" + inuProyecto + " orden " + orden + "solcitud " + solicitud +"estado "+ estado);
            try
            {

                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.prPermLegaOrden"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuOrden", DbType.Int64, orden);
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuSolicitud", DbType.Int64, solicitud);
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuProyecto", DbType.Int64, inuProyecto);
                    OpenDataBase.db.AddInParameter(cmdCommand, "isbestado", DbType.String, estado);
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
