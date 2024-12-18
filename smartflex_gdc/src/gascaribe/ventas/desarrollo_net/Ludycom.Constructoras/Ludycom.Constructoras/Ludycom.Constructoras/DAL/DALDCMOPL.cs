using System;
using System.Collections.Generic;
using System.Text;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Data;

using Ludycom.Constructoras.ENTITIES;

namespace Ludycom.Constructoras.DAL
{
    class DALDCMOPL
    {
      //  BLLDCMOPL blLDCMOPL = new BLLDCMOPL();
        public List<ListadoInternas> FrfOrdenInternas(Int64 inuProyecto)
        {
            DataSet DSDatosOrdenTrabajo = new DataSet("DatosOrdenInternas");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcVentaConstructora.FrfOrdenInternas"))
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
                        Convert.ToInt64(x[2]),//contrato,
                         Convert.ToInt64(x[3]),//producto,
                        x[4].ToString()//Direccion,                       
                        ));
            }

            return EOrdenInternas;

        }
    }
}
