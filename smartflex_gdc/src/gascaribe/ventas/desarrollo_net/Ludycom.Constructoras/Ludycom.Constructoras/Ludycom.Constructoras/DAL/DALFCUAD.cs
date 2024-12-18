using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using Ludycom.Constructoras.ENTITIES;

namespace Ludycom.Constructoras.DAL
{
    class DALFCUAD
    {
        /// <summary>
        /// Se obtiene el detalle del acta para cuota adicional por avance de obra
        /// </summary>
        /// <param name="project">Id del proyecto</param>
        /// <returns>Retorna una tabla de datos con el detalle del acta</returns>               
        public DataTable GetActDetail(Int64 project)
        {
            DataSet dsActDetail = new DataSet("DetalleActa");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcVentaConstructora.fcrDetalleActa"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsActDetail, "DetalleActa");
            }
            return dsActDetail.Tables["DetalleActa"];
        }

        /// <summary>
        /// Método para generar el cupón
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="cuponValue">valor del cupón</param>
        /// <param name="feeType">tipo de cuota adicional</param>
        /// <returns>Retorna un diccionario con los datos del cupon y la cuota generada</returns>   
        public IDictionary<String, Int64?> GenerateCupon(Int64 project, Double cuponValue, String feeType)
        {
            IDictionary<String, Int64?> generateCuponResult = new Dictionary<String, Int64?>();
            Int64? nullValue = null;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proRegistraCuotaAdicional"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALORCUPON", DbType.Double, cuponValue);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBTIPOCUOTA", DbType.String, feeType);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUCUOTA", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUCUPON", DbType.Int64, 15);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                generateCuponResult.Add("CUOTA", String.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCUOTA"))) ? nullValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCUOTA")));
                generateCuponResult.Add("CUPON", String.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCUPON"))) ? nullValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCUPON")));
                
                return generateCuponResult;
            }
        }

        /// <summary>
        /// Método para registrar el detalle del acta para cuota adicional por avance de obra
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="feeId">id de la cuota</param>
        /// <param name="workProgFee">Instancia de WorkProgressFee</param>
        public void RegisterActDetail(Int64 project, Int64 feeId, WorkProgressFee workProgFee)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proCreaDetalleActa"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCUOTA", DbType.Int64, feeId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.Int64, workProgFee.TaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALORUNIT", DbType.Double, workProgFee.Price);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTIDAD", DbType.Int32, workProgFee.Amount);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALORTOTAL", DbType.Double, workProgFee.TotalPrice);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para imprimir el cupón
        /// </summary>
        /// <param name="cupon">cupón</param>
        public void PrintCupon(Int64 cupon)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proImprimeCupon"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCUPON", DbType.Int64, cupon);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para imprimir el acta
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <param name="feeId">id de la cuota</param>
        public void PrintWorkProgressAct(Int64 project, Int64 feeId, String path)
        {
            Int64? nullValue = null;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boVentaConstructora.proImprimeActa"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, project==0?nullValue:project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCUOTA", DbType.Int64, feeId == 0 ? nullValue : feeId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBRUTA", DbType.String, path);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }
    }
}
