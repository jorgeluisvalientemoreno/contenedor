using System;
using System.Collections.Generic;
using System.Text;
using LDCGESTTA.Entities;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.Data;
using OpenSystems.Common.ExceptionHandler;

using System.Windows.Forms;
using OpenSystems.Common.Util;

namespace LDCGESTTA.DAL
{
    class DALDC_GESTTA
    {

        /// <summary>
        /// Se obtiene la informacion de tarifas
        /// </summary>
        /// <returns>Se obtiene la informacion de tarifas</returns> 
        public static DataTable GetInfoTarifa(Int64 inuTipoServ, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            DataSet DSDatosInfoTarifa = new DataSet("DatosInfoTarifa");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BSGESTIONTARIFAS.frfgetConftari"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inutipoprod", DbType.Int64, inuTipoServ); 
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuerror", DbType.Int64, 20); 
                OpenDataBase.db.AddOutParameter(cmdCommand, "osberror", DbType.String, 500); 
                OpenDataBase.db.AddReturnRefCursor(cmdCommand); 
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosInfoTarifa, "DatosInfoTarifa"); 

                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuerror")); 
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osberror"));
            }
            return DSDatosInfoTarifa.Tables["DatosInfoTarifa"];
        }


        /// <summary>
        /// Se envian los datos al procedimiento de tarifas
        /// </summary>
        /// <param name="newItem">Se envian los datos al procedimiento de tarifas</param>
        public void ProcesaTarifas(Int64 inuCodProyecto, String isbDescProyect, Int64 inuTypeServ, Int64 inuEstado,
                                   String isbObservacion, String isbDocumento, Int64 inuActividad, DateTime FechaIni, 
                                   DateTime FechaFin, out Int64 OnuCodProyecto, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BSGESTIONTARIFAS.prProcesatarifas"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuproytari", DbType.Int64, inuCodProyecto); 
                OpenDataBase.db.AddInParameter(cmdCommand, "isbDescTari", DbType.String, isbDescProyect); 
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTipoServ", DbType.Int64, inuTypeServ); 
                OpenDataBase.db.AddInParameter(cmdCommand, "inuEstado", DbType.Int64, inuEstado); 
                OpenDataBase.db.AddInParameter(cmdCommand, "isbObservacion", DbType.String, isbObservacion);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbDocumento", DbType.String, isbDocumento); 
                OpenDataBase.db.AddInParameter(cmdCommand, "inuactividad", DbType.Int64, inuActividad);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtFechaIni", DbType.DateTime, FechaIni);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtFechaFin", DbType.DateTime, FechaFin);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuproytari", DbType.Int64, 20); 
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuerror", DbType.Int64, 20); 
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbError", DbType.String, 500); 


                OpenDataBase.db.ExecuteNonQuery(cmdCommand); 
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuerror")); 
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbError"));

                OnuCodProyecto = 0;

                if (onuErrorCode == 0 && inuCodProyecto == -1)
                {
                    OnuCodProyecto = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuproytari"));
                }
            }
        }


        /// <summary>
        /// Se obtiene informacion del codigo del Proyecto
        /// </summary>
        /// <param name="newItem">Se obtiene informacion del codigo del Proyecto</param>
        public void GetInfoProyecto(Int64 inuCodProyecto, out String osbDescProyect, 
                                    out Int64 onuTypeServ,
                                    out String osbObservacion, out String osbDocumento,
                                    out String osbFechaIni, out String osbFechaFin,
                                    out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BSGESTIONTARIFAS.prGetInfoProyTari"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuproytari", DbType.Int64, inuCodProyecto);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbDescTari", DbType.String, 500);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuTipoServ", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbObservacion", DbType.String, 500);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbDocumento", DbType.String, 500);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbFechaIni", DbType.DateTime, 500);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbFechaFin", DbType.DateTime, 500);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuerror", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbError", DbType.String, 500);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand); 
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuerror")); 
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbError"));
               
                onuTypeServ = 0;
                osbDescProyect = "";
                osbObservacion = "";
                osbDocumento = "";
                osbFechaIni ="";
                osbFechaFin = "";
                
                if (onuErrorCode == 0)
                {
                    onuTypeServ = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuTipoServ"));
                    osbDescProyect = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbDescTari"));
                    osbObservacion = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbObservacion"));
                    osbDocumento = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbDocumento"));
                    osbFechaIni = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbFechaIni"));
                    osbFechaFin = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbFechaFin")); 
                }
                
                
            }
        }


        /// <summary>
        /// Se envian los datos del Excel leido
        /// </summary>
        /// <param name="newItem">Se envian los datos del Excel leido</param>
        public void ProcesarInfoExcel(Int64 inuCodProyecto, String isbDescProyect, Int64 inuMercadoRelevante,
                                      Int64 inuTipoServ, String isbTipo_Moneda, Int64 inutarifa_concepto,
                                      Double inurango_inicial, Double inurango_final, Int64 inucategoria,
                                      Int64 inuestrato, Double inuvalor_monetario, Double inuvalor_porcentaje,
                                      Double inuTarifaDirecta, Double inuPorceTariDire,
                                      Int64 inuLinea, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_BSGESTIONTARIFAS.prLeerarchivoPlano"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCodigo_Proyecto", DbType.Int64, inuCodProyecto);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbDescripcion", DbType.String, isbDescProyect);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuMercado_relevante", DbType.Int64, inuMercadoRelevante);
                OpenDataBase.db.AddInParameter(cmdCommand, "iNutipo_Producto", DbType.Int64, inuTipoServ);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbTipo_Moneda", DbType.String, isbTipo_Moneda);
                OpenDataBase.db.AddInParameter(cmdCommand, "inutarifa_concepto", DbType.Int64, inutarifa_concepto);
                OpenDataBase.db.AddInParameter(cmdCommand, "inurango_inicial", DbType.Double, inurango_inicial);
                OpenDataBase.db.AddInParameter(cmdCommand, "inurango_final", DbType.Double, inurango_final);
                OpenDataBase.db.AddInParameter(cmdCommand, "inucategoria", DbType.Int64, inucategoria);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuestrato", DbType.Int64, inuestrato);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuvalor_monetario", DbType.Double, inuvalor_monetario);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuvalor_porcentaje", DbType.Double, inuvalor_porcentaje);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTarifaDirecta", DbType.Double, inuTarifaDirecta);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPorceTariDire", DbType.Double, inuPorceTariDire);               
                OpenDataBase.db.AddInParameter(cmdCommand, "inuLinea", DbType.Int64, inuLinea);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuerror", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbError", DbType.String, 500);


                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuerror"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbError"));
            }
        }

    }
}
