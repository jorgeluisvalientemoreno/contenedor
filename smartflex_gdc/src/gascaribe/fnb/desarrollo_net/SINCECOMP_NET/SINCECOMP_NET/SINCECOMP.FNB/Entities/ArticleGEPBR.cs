using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

//NameSpace
namespace SINCECOMP.FNB.Entities
{
    /// <summary>
    /// 
    /// </summary>
    class ArticleGEPBR
    {
        #region Campos

        private Int64 id;
        private String instalation;
        private String subline;
        private Int64 warranty;
        private String description;
        private String brand;
        private String funder;
        private String concept;
        private String supplier;
        private Decimal vat;
        private String observation;
        private String costcontrol;
        private String active;
        private String equivalence;
        private String available;
        private String approbation;
        private String reference;
        private Int64 checkSave;
        private Int64 checkModify;
        #endregion Campos
        //
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Identificación")]
        public Int64 Id
        {
            get { return id; }
            set { id = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Descripción")]
        public String Description
        {
            get { return description; }
            set { description = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Garantia")]
        public Int64 Warranty
        {
            get { return warranty; }
            set
            {
                if (0 <= value)
                    warranty = value;
                else
                    ExceptionHandler.DisplayMessage(2741, "No puede digitar una garantía menor a cero");

            }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Instalación")]
        public String Instalation
        {
            get { return instalation; }
            set { instalation = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Sublínea")]
        public String Subline
        {
            get { return subline; }
            set { subline = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Marca")]
        public String Brand
        {
            get { return brand; }
            set { brand = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Financiador")]
        public String Funder
        {
            get { return funder; }
            set { funder = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Concepto")]
        public String Concept
        {
            get { return concept; }
            set { concept = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Proveedor")]
        public String Supplier
        {
            get { return supplier; }
            set { supplier = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("IVA")]
        public Decimal Vat
        {
            get { return vat; }
            set
            {

                if (value >= 0)
                {
                    vat = value;
                }
                else
                {

                    ExceptionHandler.DisplayMessage(2741, "No puede digitar un IVA menor que cero");
                }

            }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Observación")]
        public String Observation
        {
            get { return observation; }
            set { observation = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Control Precio")]
        public String Costcontrol
        {
            get { return costcontrol; }
            set { costcontrol = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Activo")]
        public String Active
        {
            get { return active; }
            set { active = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Equivalencia")]
        public String Equivalence
        {
            get { return equivalence; }
            set { equivalence = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Disponible")]
        public String Available
        {
            get { return available; }
            set { available = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Aprobación")]
        public String Approbation
        {
            get { return approbation; }
            set { approbation = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        [DisplayName("Referencia")]
        public String Reference
        {
            get { return reference; }
            set { reference = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        public Int64 CheckSave
        {
            get { return checkSave; }
            set { checkSave = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        public Int64 CheckModify
        {
            get { return checkModify; }
            set { checkModify = value; }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="row"></param>
        public ArticleGEPBR(DataRow row)
        {
            Id = Convert.ToInt64(row["article_id"]);
            Description = Convert.ToString(row["description"]);
            if (Convert.IsDBNull(row["warranty"]) != true)
                Warranty = Convert.ToInt64(row["warranty"]);
            else
                Warranty = 0;
            if (Convert.IsDBNull(row["installation"]) != true)
                Instalation = Convert.ToString(row["installation"]);
            else
                Instalation = string.Empty;
            if (Convert.IsDBNull(row["subline_id"]) != true)
                Subline = Convert.ToString(row["subline_id"]);
            else
                Subline = string.Empty;
            if (Convert.IsDBNull(row["brand_id"]) != true)
                Brand = Convert.ToString(row["brand_id"]);
            else
                Brand = string.Empty;
            if (Convert.IsDBNull(row["financier_id"]) != true)
                Funder = Convert.ToString(row["financier_id"]);
            else
                Funder = string.Empty;
            if (Convert.IsDBNull(row["concept_id"]) != true)
                Concept = Convert.ToString(row["concept_id"]);
            else
                concept = string.Empty;
            if (Convert.IsDBNull(row["supplier_id"]) != true)
                Supplier = Convert.ToString(row["supplier_id"]);
            else
                Supplier = string.Empty;
            if (Convert.IsDBNull(row["vat"]) != true)
                Vat = Convert.ToDecimal(row["vat"]);
            else
                Vat = 0;
            if (Convert.IsDBNull(row["observation"]) != true)
                Observation = Convert.ToString(row["observation"]);
            else
                Observation = string.Empty;
            Costcontrol = Convert.ToString(row["price_control"]);
            if (Convert.IsDBNull(row["avalible"]) != true)
                Available = Convert.ToString(row["avalible"]);
            else
                Available = string.Empty;
            if (Convert.IsDBNull(row["active"]) != true)
                Active = Convert.ToString(row["active"]);
            else
                Active = string.Empty;
            if (Convert.IsDBNull(row["approved"]) != true)
                Approbation = Convert.ToString(row["approved"]);
            else
                Approbation = string.Empty;
            Reference = Convert.ToString(row["reference"]);
            if (Convert.IsDBNull(row["equivalence"]) != true)
                Equivalence = Convert.ToString(row["equivalence"]);
            else
                Equivalence = string.Empty;

        }
    }
}
