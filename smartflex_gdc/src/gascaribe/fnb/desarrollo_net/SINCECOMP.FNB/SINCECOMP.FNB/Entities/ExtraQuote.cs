#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : ExtraQuote
 * Descripcion   : Cuota Extra
 * Autor         : Sidecom
 * Fecha         : 08-May-2013
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 28-Ago-2013  211794  jaricapa       1 - Para proveedores no se visualizaba la etiqueta "Todos" cuando no había valor.
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Text;

namespace SINCECOMP.FNB.Entities
{
    public class ExtraQuote
    {
        private String lineName;

        public ExtraQuote()
        { }

        [DisplayName("Linea")]
        public String LineName
        {
            get { return lineName; }
         
        }
        private String sublineName;

        [DisplayName("Sublinea")]
        public String SublineName
        {
            get { return sublineName; }
            
        }

        private String supplierName;

        [DisplayName("Proveedor")]
        public String SupplierName
        {
            get { return supplierName; }
            
        }
        private String chanelSaleName;

        [DisplayName("Canal de Venta")]
        public String ChanelSaleName
        {
            get { return chanelSaleName; }
            
        }
        private Double quote;

        [DisplayName("Cupo")]
        public Double Quote
        {
            get { return quote; }
           
        }
        private DateTime finalDate;

        [DisplayName("Fecha Final")]
        public DateTime FinalDate
        {
            get { return finalDate; }
            
        }

        private double usedQuote;

        [Browsable(false)]
        public double UsedQuote
        {
            get { return usedQuote; }
            set { usedQuote = value; }
        }


        private Int64? lineId;

        [Browsable(false)]
        public Int64? LineId
        {
            get { return lineId; }
            set { lineId = value; }
        }


        private Int64? subLineId;

        [Browsable(false)]
        public Int64? SubLineId
        {
            get { return subLineId; }
            set { subLineId = value; }
        }

        private Int64? supplierId;

        [Browsable(false)]
        public Int64? SupplierId
        {
            get { return supplierId; }
            set { supplierId = value; }
        }

        private Int64? saleChanelId;

        [Browsable(false)]
        public Int64? SaleChanelId
        {
            get { return saleChanelId; }
            set { saleChanelId = value; }
        }
        private Int64? extraQuotaId;
        [Browsable(false)]
        public Int64? ExtraQuotaId
        {
            get { return extraQuotaId; }
            set { extraQuotaId = value; }
        }


        public ExtraQuote(
            String lineName, 
            String subLineName, 
            String supplierName, 
            String chanelSaleName, 
            Double quote, 
            DateTime finalDate, 
            Int64? lineId, 
            Int64? subLineId, 
            Int64? supplierId, 
            Int64? saleChanelId, 
            Int64? extraQuotaId) 
        {
            if (String.IsNullOrEmpty(lineName))
            {
                this.lineName = "Todos";  
            }
            else 
            {
                this.lineName = lineName;
            }


            if (String.IsNullOrEmpty(subLineName))
            {
                this.sublineName = "Todos";
            }
            else
            {
                this.sublineName = subLineName;
            }

            if (String.IsNullOrEmpty(supplierName))
            {
                this.supplierName = "Todos";
            }
            else
            {
                this.supplierName = supplierName;
            }

            if (String.IsNullOrEmpty(chanelSaleName))
            {
                this.chanelSaleName = "Todos";
            }
            else
            {
                this.chanelSaleName = chanelSaleName;
            }
                        
            if(quote <0)
            {
                this.quote = 0;
            }   
            else
            {
                this.quote = quote;
            }

            this.extraQuotaId = extraQuotaId;
            this.finalDate = finalDate;
            this.lineId = lineId;
            this.subLineId = subLineId;
            this.saleChanelId = saleChanelId;
            this.supplierId = supplierId;
            this.usedQuote = quote;
        }
    }
}
