using System;
using System.Collections.Generic;
using System.Text;
using LDCGESTTA.DAL;
using LDCGESTTA.Entities;
using System.Data;
using System.IO;
using OpenSystems.Printing.Common;
using OpenSystems.Common.ExceptionHandler;
using System.Windows.Forms;


namespace LDCGESTTA.BL
{
    class BLLDC_GESTTA
    {
        DALDC_GESTTA dalLDC_FCVC = new DALDC_GESTTA();
        DALUtilities dalUtilities = new DALUtilities();



        /// <summary>
        /// Se envian los datos al procedimiento de tarifas
        /// </summary>
        /// <returns>Se envian los datos al procedimiento de tarifas</returns>               
        public void ProcesaTarifas(Int64 inuCodProyecto, String isbDescProyect, Int64 inuTypeServ, Int64 inuEstado,
                                   String isbObservacion, String isbDocumento,  Int64 inuActividad, DateTime FechaIni, 
                                   DateTime FechaFin, out Int64 OnuCodProyecto, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalLDC_FCVC.ProcesaTarifas(inuCodProyecto, isbDescProyect, inuTypeServ, inuEstado, isbObservacion,
                                        isbDocumento, inuActividad, FechaIni, FechaFin, out OnuCodProyecto, out  onuErrorCode, out  osbErrorMessage);
        }


        /// <summary>
        /// Se obtiene informacion del codigo del Proyecto
        /// </summary>
        /// <returns>Se obtiene informacion del codigo del Proyecto</returns>               
        public void GetInfoProyecto(Int64 inuCodProyecto, out String osbDescProyect, out Int64 onuTypeServ,
                                    out String osbObservacion, out String osbDocumento,
                                    out String osbFechaIni, out String osbFechaFin,
                                    out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalLDC_FCVC.GetInfoProyecto(inuCodProyecto, out osbDescProyect, out onuTypeServ,
                                        out  osbObservacion, out  osbDocumento,
                                         out osbFechaIni, out osbFechaFin, out  onuErrorCode, out  osbErrorMessage);
        }


        /// <summary>
        /// se envian los datos del Excel leido
        /// </summary>
        /// <returns>se envian los datos del Excel leido</returns>               
        public void ProcesarInfoExcel(Int64 inuCodProyecto, String isbDescProyect, Int64 inuMercadoRelevante,
                                      Int64 inuTipoServ, String isbTipo_Moneda, Int64 inutarifa_concepto,
                                      Double inurango_inicial, Double inurango_final, Int64 inucategoria,
                                      Int64 inuestrato, Double inuvalor_monetario, Double inuvalor_porcentaje,
                                      Double inuTarifaDirecta, Double inuPorceTariDire,
                                      Int64 inuLinea, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            dalLDC_FCVC.ProcesarInfoExcel(inuCodProyecto,  isbDescProyect,  inuMercadoRelevante,
                                          inuTipoServ,  isbTipo_Moneda,  inutarifa_concepto,
                                          inurango_inicial,  inurango_final,  inucategoria,
                                          inuestrato,  inuvalor_monetario,  inuvalor_porcentaje,
                                          inuTarifaDirecta, inuPorceTariDire,
                                          inuLinea, out  onuErrorCode, out  osbErrorMessage);
        }
        
        

   
    }
}
