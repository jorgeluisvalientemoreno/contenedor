using System;
using System.Collections.Generic;
using System.Text;
using LDC_APUSSOTECO.DAL;
using LDC_APUSSOTECO.Entities;
using System.Data;
using System.IO;
using OpenSystems.Printing.Common;
using OpenSystems.Common.ExceptionHandler;
using System.Windows.Forms;


namespace LDC_APUSSOTECO.BL
{
    class BLLDCAPUSSOTECO
    {
        DALDCAPUSSOTECO dalLDC_FCVC = new DALDCAPUSSOTECO();
        DALUtilities dalUtilities = new DALUtilities();

        /// <summary>
        /// Se obtienen los tipos de trabajo cotizados
        /// </summary>
        /// <param name="quotationId">id de la cotización</param>
        /// <returns>Retorna los tipos de trabajo de la cotización</returns>  
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 20-10-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public List<GridDetaContrato> GetDatosContratos()
        {
            
            DataTable dtGridDetaContrato;
            List<GridDetaContrato> GridDetaContratoList = new List<GridDetaContrato>();
            dtGridDetaContrato = dalLDC_FCVC.GetDatosContratos();

            foreach (DataRow item in dtGridDetaContrato.Rows)
            {
                GridDetaContrato tmpQuotationTaskType = new GridDetaContrato(item);
                GridDetaContratoList.Add(tmpQuotationTaskType);

            }

            return GridDetaContratoList;   
        }

        /// <summary>
        /// Se obtiene el usuario conectado
        /// </summary>
        /// <returns>Se obtiene el usuario conectado</returns>               
        public String getUserConect()
        {
            return dalLDC_FCVC.getUserConect();
        }


        /// <summary>
        /// Se envian los datos de los medidores
        /// </summary>
        /// <returns>Actualiza listas</returns>               
        public void ActualizaDatosContratos(Int64 nuContrato, String sbEstado, String sbObservacion, out Int64 onuErrorCode, out String osbErrorMessage)                                       
        {
            dalLDC_FCVC.ActualizaDatosContratos(nuContrato, sbEstado, sbObservacion, out onuErrorCode, out osbErrorMessage);
        }

    }
}
