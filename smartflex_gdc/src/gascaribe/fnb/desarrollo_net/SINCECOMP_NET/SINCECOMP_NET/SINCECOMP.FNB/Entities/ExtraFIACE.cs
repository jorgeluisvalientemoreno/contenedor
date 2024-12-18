using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.Entities
{
    class ExtraFIACE
    {
        private Int64 extraQuotaId;

        [DisplayName("Código")]
        public Int64 ExtraQuotaId
        {
            get { return extraQuotaId; }
            set { extraQuotaId = value; }
        }

        private String supplierId;

        [DisplayName("Proveedor")]
        public String SupplierId
        {
            get { return supplierId; }
            set { supplierId = value; }
        }

        private String categoryId;

        [DisplayName("Categoría")]
        public String CategoryId
        {
            get { return categoryId; }
            set { categoryId = value; }
        }

        private String subCategoryId;

        [DisplayName("Subcategoría")]
        public String SubCategoryId
        {
            get { return subCategoryId; }
            set { subCategoryId = value; }
        }

        private String geograpLocationId;

        [DisplayName("Ubicación Geográfica")]
        public String GeograpLocationId
        {
            get { return geograpLocationId; }
            set { geograpLocationId = value; }
        }

        private String saleChanelId;

        [DisplayName("Canal de Venta")]
        public String SaleChanelId
        {
            get { return saleChanelId; }
            set { saleChanelId = value; }
        }

        private String quotaOption;

        [DisplayName("Opción de Cupo")]
        public String QuotaOption
        {
            get { return quotaOption; }
            set { quotaOption = value; }
        }

        private Double value;

        [DisplayName("Valor")]
        public Double Value
        {
            get { return this.value; }
            set { 
                /*
                if(QuotaOption.Equals("P"))
                {
                    if(value>100)
                        ExceptionHandler.DisplayMessage(2741, "El Valor debe ser menor a 100 %");
                }
               */
                if (value <= 0)
                {
                    ExceptionHandler.DisplayMessage(2741, "El Valor debe ser mayor a Cero");
                }
                else
                {
                    this.value = value;
                }
            }
        }

        private String lineId;

        [DisplayName("Línea")]
        public String LineId
        {
            get { return lineId; }
            set { lineId = value; }
        }

        private String subLineId;

        [DisplayName("Sublínea")]
        public String SubLineId
        {
            get { return subLineId; }
            set { subLineId = value; }
        }

        private DateTime initialDate;

        [DisplayName("Fecha Inicial")]
        public DateTime InitialDate
        {
            get { return initialDate; }
            set
            {
                if (Convert.ToDateTime(this.FinalDate.ToString("dd/MM/yyyy")) < Convert.ToDateTime(value.ToString("dd/MM/yyyy")))
                    ExceptionHandler.DisplayMessage(2741, "La Fecha inicial no puede ser mayor a la Fecha final");
                else
                    initialDate = value;
            }
        }

        private DateTime finalDate;

        [DisplayName("Fecha Final")]
        public DateTime FinalDate
        {
            get { return finalDate; }
            set
            {
                if (Convert.ToDateTime(this.InitialDate.ToString("dd/MM/yyyy")) > Convert.ToDateTime(value.ToString("dd/MM/yyyy")))
                    ExceptionHandler.DisplayMessage(2741, "La Fecha final no puede ser menor a la Fecha inicial");
                else
                    finalDate = value;
            }
        }

        private String document;

        [DisplayName("Documento")]
        public String Document
        {
            get { return document; }
            set { document = value; }
        }

        private String observation;

        [DisplayName("Observación")]
        public String Observation
        {
            get { return observation; }
            set { observation = value; }
        }

        private Int64 checkSave;

        public Int64 CheckSave
        {
            get { return checkSave; }
            set { checkSave = value; }
        }

        private Int64 checkModify;

        public Int64 CheckModify
        {
            get { return checkModify; }
            set { checkModify = value; }
        }

        private Object filePath;

        public Object FilePath
        {
            get { return filePath; }
            set { filePath = value; }
        }

        private String typeDate;

        public String TypeDate
        {
            get { return typeDate; }
            set { typeDate = value; }
        }

        public ExtraFIACE(DataRow row)
        {
            ExtraQuotaId = Convert.ToInt64(row["Extra_Quota_Id"]);
            if (Convert.IsDBNull(row["Supplier_Id"]) != true)
                SupplierId = Convert.ToString(row["Supplier_Id"]);
            else
                SupplierId = " ";
            if (Convert.IsDBNull(row["Category_Id"]) != true)
                CategoryId = Convert.ToString(row["Category_Id"]);
            else
                CategoryId = " ";
            if (Convert.IsDBNull(row["SubCategory_Id"]) != true)
                SubCategoryId = Convert.ToString(row["SubCategory_Id"]);
            else
                SubCategoryId = " ";
            if (Convert.IsDBNull(row["Geograp_Location_Id"]) != true)
                GeograpLocationId = Convert.ToString(row["Geograp_Location_Id"]);
            else
                GeograpLocationId = " ";
            if (Convert.IsDBNull(row["Sale_Chanel_Id"]) != true)
                SaleChanelId = Convert.ToString(row["Sale_Chanel_Id"]);
            else
                SaleChanelId = " ";
            QuotaOption = Convert.ToString(row["Quota_Option"]);
            Value = Convert.ToDouble(row["Value"]);
            if (Convert.IsDBNull(row["Line_Id"]) != true)
                LineId = Convert.ToString(row["Line_Id"]);
            else
                LineId = " ";
            if (Convert.IsDBNull(row["SubLine_Id"]) != true)
                SubLineId = Convert.ToString(row["SubLine_Id"]);
            else
                SubLineId = " ";

            
               

                if (Convert.IsDBNull(row["Final_Date"]) != true)
                    FinalDate = Convert.ToDateTime(row["Final_Date"]);
                else
                    FinalDate = System.DateTime.Today;// Convert.ToDateTime("01/01/01");//DateTime? idtmindateannu = null;
                 
            if (Convert.IsDBNull(row["Initial_Date"]) != true)
                    InitialDate = Convert.ToDateTime(row["Initial_Date"]);
                else
                    InitialDate = System.DateTime.Today;// Convert.ToDateTime("01/01/01");

            Observation = Convert.ToString(row["Observation"]);
            if (Convert.IsDBNull(row["Document"]) != true)
            {
                Document = "Si";
                FilePath = row["Document"];
                TypeDate = "B";
            }
            else
            {
                Document = "No";
                TypeDate = "P";
            }
        }
    }
}
