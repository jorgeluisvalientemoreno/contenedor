using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using OpenSystems.Common.Data;
using Ludycom.Constructoras.ENTITIES;
using System.Data.Common;

namespace Ludycom.Constructoras.DAL
{
    class DALFEQUC
    {
        /// <summary>
        /// Se obtienen los datos básicos de la solicitud de venta constructora
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <returns>Retorna una instancia de RequestBasicData con los datos básicos de la solicitud</returns>
        public RequestBasicData GetRequestBasicData(Int64 project)
        {
            RequestBasicData requestBasicData = new RequestBasicData();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcVentaConstructora.proSolicitudVenta"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUSOLICITUD", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ODTFECHAREGISTRO", DbType.DateTime, 80);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                requestBasicData.RequestId = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUSOLICITUD"));
                requestBasicData.RegisterDate = Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTFECHAREGISTRO").ToString());
 
                return requestBasicData;
            }
        }

        /// <summary>
        /// Se obtienen las unidades prediales
        /// </summary>
        /// <param name="project">Id del proyecto</param>
        /// <returns>Retorna una tabla de datos con las unidades prediales</returns>               
        public DataTable GetPropUnits(Int64 project)
        {
            DataSet dsItems = new DataSet("UnidadesPrediales");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcVentaConstructora.fcrUnidadesPredialesProy"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsItems, "UnidadesPrediales");
            }
            return dsItems.Tables["UnidadesPrediales"];
        }

        /// <summary>
        /// Se obtienen las direcciones creadas a partir de la venta constructora
        /// </summary>
        /// <param name="request">Id de la solicitud</param>
        /// <returns>Retorna una tabla de datos con las direcciones</returns>               
        public DataTable GetAddresses(Int64 request)
        {
            DataSet dsItems = new DataSet("Direcciones");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcVentaConstructora.fcrDireccionesVenta"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUSOLICITUD", DbType.Int64, request);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsItems, "Direcciones");
            }
            return dsItems.Tables["Direcciones"];
        }

        /// <summary>
        /// Se establecen las equivalencias por unidad predial
        /// </summary>
        /// <param name="request">id de la solicitud</param>
        /// <param name="propUnitEquivalence">Instancia de PropUnitEquivalence</param>
        public void SetPropUnitEquivalence(Int64 request, PropUnitEquivalence propUnitEquivalence)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proCreaEquivalencia"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUDIRECCION", DbType.Int64, propUnitEquivalence.Address);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUUNIDPREDIALCOTIZADA", DbType.Int64, propUnitEquivalence.PropUnitId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUSOLICITUDVENTA", DbType.Int64, request);
                
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

    }
}
