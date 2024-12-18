using System;
using System.Collections.Generic;
using System.Text;

namespace Ludycom.Constructoras.ENTITIES
{
    class QuotationBasicData
    {
        private Int64 projectId;

        public Int64 ProjectId
        {
            get { return projectId; }
            set { projectId = value; }
        }

        private Int64 consecutive;

        public Int64 Consecutive
        {
            get { return consecutive; }
            set { consecutive = value; }
        }

        private String status;

        public String Status
        {
            get { return status; }
            set { status = value; }
        }

        private Int32? costList;

        public Int32? CostList
        {
            get { return costList; }
            set { costList = value; }
        }

        private DateTime? validityDate;

        public DateTime? ValidityDate
        {
            get { return validityDate; }
            set { validityDate = value; }
        }

        private String paymentModality;

        public String PaymentModality
        {
            get { return paymentModality; }
            set { paymentModality = value; }
        }

        private Double? quotedValue;

        public Double? QuotedValue
        {
            get { return quotedValue; }
            set { quotedValue = value; }
        }

        private String comment;

        public String Comment
        {
            get { return comment; }
            set { comment = value; }
        }

        private DateTime? registerDate;

        public DateTime? RegisterDate
        {
            get { return registerDate; }
            set { registerDate = value; }
        }

        private DateTime? lastModDate;

        public DateTime? LastModDate
        {
            get { return lastModDate; }
            set { lastModDate = value; }
        }
        //INICIO CA 200-2022
        private Int32? planComercEsp;

        public Int32? PlanComercEsp
        {
            get { return planComercEsp; }
            set { planComercEsp = value; }
        }

        private Int32? unidadInstaladora;

        public Int32? UnidadInstaladora
        {
            get { return unidadInstaladora; }
            set { unidadInstaladora = value; }
        }

        private Int32? unidadCertificadora;

        public Int32? UnidadCertificadora
        {
            get { return unidadCertificadora; }
            set { unidadCertificadora = value; }
        }
        
        //FIN CA 200-2022
        //INICIO CA 153
        private String flagaso;
        public String Flagaso
        {
            get { return flagaso; }
            set { flagaso = value; }
        }
        //FIN CA 153
    }
}
