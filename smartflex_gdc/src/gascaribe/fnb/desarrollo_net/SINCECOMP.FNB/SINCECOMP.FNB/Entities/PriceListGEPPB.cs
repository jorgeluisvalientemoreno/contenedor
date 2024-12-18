using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.Entities
{
    class PriceListGEPPB
    {

        private Int64 priceListId;

        [DisplayName("Identificación")]
        public Int64 PriceListId
        {
            get { return priceListId; }
            set { priceListId = value; }
        }

        private String description;

        [DisplayName("Descripción")]
        public String Description
        {
            get { return description; }
            set { description = value; }
        }

        //private Int64? supplierId;

        //[DisplayName("Proveedor")]
        //public Int64? SupplierId
        //{
        //    get { return supplierId; }
        //    set { supplierId = value; }
        //}
        private String supplierId;

        [DisplayName("Proveedor")]
        public String SupplierId
        {
            get { return supplierId; }
            set { supplierId = value; }
        }

        private DateTime creationDate;

        [DisplayName("Fecha de Creación")]
        public DateTime CreationDate
        {
            get { return creationDate; }
            set { creationDate = value; }
        }

        private DateTime initialDate;

        [DisplayName("Fecha Inicial")]
        public DateTime InitialDate
        {
            get { return initialDate; }
            set {
                if(Convert.ToDateTime(this.creationDate.ToString("dd/MM/yyyy")) > Convert.ToDateTime(value.ToString("dd/MM/yyyy")))
                {
                 ExceptionHandler.DisplayMessage(2741, "La fecha inicial no puede ser inferior a la de creación");
                } else if
                    (Convert.ToDateTime(this.FinalDate.ToString("dd/MM/yyyy")) < Convert.ToDateTime(value.ToString("dd/MM/yyyy")))
                    ExceptionHandler.DisplayMessage(2741, "La fecha inicial no puede ser mayor a la fecha final");
                else
                {
                    initialDate = value;
                }
            }
        }

        private DateTime finalDate;

        [DisplayName("Fecha Final")]
        public DateTime FinalDate
        {
            get { return finalDate; }
            set {
                if (Convert.ToDateTime(this.creationDate.ToString("dd/MM/yyyy")) > Convert.ToDateTime(value.ToString("dd/MM/yyyy")))
                {
                    ExceptionHandler.DisplayMessage(2741, "La fecha final no puede ser inferior a la de creación");
                }
                else if (Convert.ToDateTime(value.ToString("dd/MM/yyyy")) < Convert.ToDateTime(this.initialDate.ToString("dd/MM/yyyy")))//EVESAN
                {
                    ExceptionHandler.DisplayMessage(2741, "La fecha final no puede ser menor a la Fecha inicial"); 
                    return;
                }
                else
                {
                    finalDate = value;
                }
            }
        }

        private String approved;

        [DisplayName("Aprobado")]
        public String Approved
        {
            get { return approved; }
            set { approved = value; }
        }

        private DateTime? lastDateApproved;

        [DisplayName("Ultima Fecha de Aprobado")]
        public DateTime? LastDateApproved
        {
            get { return lastDateApproved; }
            set { lastDateApproved = value; }
        }

        private Int64 version;

        [DisplayName("Versión")]
        public Int64 Version
        {
            get { return version; }
            set { version = value; }
        }

        private String conditionApproved;

        [DisplayName("Condición de Aprobación")]
        public String ConditionApproved
        {
            get { return conditionApproved; }
            set { conditionApproved = value; }
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

        private String approvedT;

        public String ApprovedT
        {
            get { return approvedT; }
            set { approvedT = value; }
        }


        private Int64 amountPrintOUTS;

        [DisplayName("Nro. Veces Impresa")]
        public Int64 AmountPrintOUTS
        {
            get { return amountPrintOUTS; }
            set { amountPrintOUTS = value; }
        }

        public PriceListGEPPB(DataRow row)
        {
            try
            {
                PriceListId = Convert.ToInt64(row["Price_List_Id"]);
                Description = Convert.ToString(row["description"]);
                SupplierId = Convert.ToString(row["Supplier_Id"]);
                //if (row["Supplier_Id"].ToString()== " ")
                //    SupplierId = null;
                //else
                //    SupplierId = Convert.ToInt64(row["Supplier_Id"]);
                FinalDate = Convert.ToDateTime(row["Final_Date"]);
                InitialDate = Convert.ToDateTime(row["Initial_Date"]);

                if (Convert.IsDBNull(row["Approved"]) != true)
                {
                    Approved = Convert.ToString(row["Approved"]);
                    ApprovedT = Convert.ToString(row["Approved"]);
                }
                else
                {
                    Approved = "N";
                    ApprovedT = "N";
                }
                CreationDate = Convert.ToDateTime(row["Creation_Date"]);
                if (Convert.IsDBNull(row["Last_Date_Approved"]) != true)
                    LastDateApproved = Convert.ToDateTime(row["Last_Date_Approved"]);
                else
                    LastDateApproved = null; //DateTime.Parse("01/01/0001");
                if (Convert.IsDBNull(row["Version"]) != true)
                    Version = Convert.ToInt64(row["Version"]);
                else
                    Version = 0;
                ConditionApproved = Convert.ToString(row["Condition_Approved"]);

                if (Convert.IsDBNull(row["AMOUNT_PRINTOUTS"]) != true)
                    AmountPrintOUTS = Convert.ToInt64(row["AMOUNT_PRINTOUTS"]);
                else
                    AmountPrintOUTS = 0;

            }
            catch { }
        }
    }
}
