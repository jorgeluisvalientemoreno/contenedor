using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.FNB.Entities
{
    class ComArtGEC
    {
        private Int64 commissionId;

        [DisplayName("Identificación")]
        public Int64 CommissionId
        {
            get { return commissionId; }
            set { commissionId = value; }
        }

        private String lineId;

        [DisplayName("Línea")]
        public String LineId
        {
            get { return lineId; }
            set { lineId = value; }
        }

        private String sublineId;

        [DisplayName("Sublínea")]
        public String SublineId
        {
            get { return sublineId; }
            set { sublineId = value; }
        }

        private String articleId;

        [DisplayName("Artículo")]
        public String ArticleId
        {
            get { return articleId; }
            set { articleId = value; }
        }

        private String saleChanelId;

        [DisplayName("Canal de Venta")]
        public String SaleChanelId
        {
            get { return saleChanelId; }
            set { saleChanelId = value; }
        }

        private String geograpLocationId;

        [DisplayName("Ubicación Geográfica")]
        public String GeograpLocationId
        {
            get { return geograpLocationId; }
            set { geograpLocationId = value; }
        }

        private String contratorId;

        [DisplayName("Contratista")]
        public String ContratorId
        {
            get { return contratorId; }
            set { contratorId = value; }
        }

        private Decimal recoveryPercentage;

        [DisplayName("% Comisión de cobro")]
        public Decimal RecoveryPercentage
        {
            get { return recoveryPercentage; }
            set
            {
                if (value < 0)
                    ExceptionHandler.DisplayMessage(2741, "La comision debe ser Mayor o Igual 0");
                else
                    recoveryPercentage = value;
            }
        }

        private Decimal pymentPercentage;

        [DisplayName("% Comisión de pago")]
        public Decimal PymentPercentage
        {
            get { return pymentPercentage; }
            set
            {
                if (value < 0)
                    ExceptionHandler.DisplayMessage(2741, "La comision debe ser mayor o Igual 0");
                else
                    pymentPercentage = value;
            }
        }

        private String incluVatRecoCommi;

        [DisplayName("Incluye IVA la comisión de cobro")]
        public String IncluVatRecoCommi
        {
            get { return incluVatRecoCommi; }
            set { incluVatRecoCommi = value; }
        }

        private String incluVatPayCommi;

        [DisplayName("Incluye IVA la comisión de pago")]
        public String IncluVatPayCommi
        {
            get { return incluVatPayCommi; }
            set { incluVatPayCommi = value; }
        }

        private DateTime initialDate;

        [DisplayName("Fecha Inicial")]
        public DateTime InitialDate
        {
            get { return initialDate; }
            set
            {

                initialDate = value;
            }
        }

        private String supplierId;

        [DisplayName("Proveedor")]
        public String SupplierId
        {
            get { return supplierId; }
            set { supplierId = value; }
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

        private DateTime initialDateA;

        public DateTime InitialDateA
        {
            get { return initialDateA; }
            set { initialDateA = value; }
        }

        public ComArtGEC(DataRow row)
        {
            CommissionId = Convert.ToInt64(row["commission_id"]);
            if (Convert.IsDBNull(row["article_id"]) != true)
                ArticleId = Convert.ToString(row["article_id"]);
            else
                ArticleId = " ";
            if (Convert.IsDBNull(row["sale_chanel_id"]) != true)
                SaleChanelId = Convert.ToString(row["sale_chanel_id"]);
            else
                SaleChanelId = " ";
            if (Convert.IsDBNull(row["geograp_location_id"]) != true)
                GeograpLocationId = Convert.ToString(row["geograp_location_id"]);
            else
                GeograpLocationId = " ";
            if (Convert.IsDBNull(row["contrator_id"]) != true)
                ContratorId = Convert.ToString(row["contrator_id"]);
            else
                ContratorId = " ";
            RecoveryPercentage = Convert.ToDecimal(row["recovery_percentage"]);
            PymentPercentage = Convert.ToDecimal(row["pyment_percentage"]);
            if (Convert.IsDBNull(row["inclu_vat_reco_commi"]) != true)
                IncluVatRecoCommi = Convert.ToString(row["inclu_vat_reco_commi"]);
            else
                IncluVatRecoCommi = "N";
            if (Convert.IsDBNull(row["inclu_vat_pay_commi"]) != true)
                IncluVatPayCommi = Convert.ToString(row["inclu_vat_pay_commi"]);
            else
                IncluVatPayCommi = "N";
            if (Convert.IsDBNull(row["initial_date"]) != true)
                InitialDate = Convert.ToDateTime(row["initial_date"]);
            else
                InitialDate = DateTime.Parse("01/01/01");
            if (Convert.IsDBNull(row["initial_date"]) != true)
                InitialDateA = Convert.ToDateTime(row["initial_date"]);
            else
                InitialDateA = DateTime.Parse("01/01/01");
            //
            if (Convert.IsDBNull(row["line_id"]) != true)
                LineId = Convert.ToString(row["line_id"]);
            else
                LineId = " ";
            if (Convert.IsDBNull(row["subline_id"]) != true)
                SublineId = Convert.ToString(row["subline_id"]);
            else
                SublineId = " ";
            //
            SupplierId = Convert.ToString(row["supplier_id"]);
        }

    }
}
