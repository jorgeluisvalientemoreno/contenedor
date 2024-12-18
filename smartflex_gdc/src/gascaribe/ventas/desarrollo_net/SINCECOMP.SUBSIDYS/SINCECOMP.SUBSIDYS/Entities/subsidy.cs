using System;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.SUBSIDYS.Entities
{
    class subsidy
    {
        private Int64 subsidyId;

        [DisplayName("Subsidio")]
        public Int64 SubsidyId
        {
            get { return subsidyId; }
            set { subsidyId = value; }
        }

        private String description;

        [DisplayName("Descripción")]
        public String Description
        {
            get { return description; }
            set { description = value; }
        }

        private Int64 agreement;

        [DisplayName("Convenio")]
        public Int64 Agreement
        {
            get { return agreement; }
            set { agreement = value; }
        }

        private String descriptionagreement;

        [DisplayName("Descripción")]
        public String Descriptionagreement
        {
            get { return descriptionagreement; }
            set { descriptionagreement = value; }
        }

        private string remaining_status;

        [DisplayName("Estado Remanente")]
        public string Remaining_status
        {
            get { return remaining_status; }
            set { remaining_status = value; }
        }

        private Int64 authorizedvalue;

        [DisplayName("Valor Autorizado")]
        public Int64 Authorizedvalue
        {
            get { return authorizedvalue; }
            set { authorizedvalue = value; }
        }

        private Int64 remainingvalue;

        [DisplayName("Valor Remanente Subsidio")]
        public Int64 Remainingvalue
        {
            get { return remainingvalue; }
            set { remainingvalue = value; }
        }

        private Int64 distributingvalue;

        [DisplayName("Valor a Distribuir")]
        public Int64 Distributingvalue
        {
            get { return distributingvalue; }
            set { distributingvalue = value; }
        }

        public subsidy(DataRow row)
        {
            SubsidyId = Convert.ToInt64(row["subsidio"]);
            Description = row["descripcion"].ToString();
            Agreement = Convert.ToInt64(row["convenio"]);
            Descriptionagreement = Convert.ToString(row["deal_descripcion"]);
            Remaining_status = Convert.ToString(row["estado_remanente"]);
            Remainingvalue = Convert.ToInt64(row["remanente"]);
            Authorizedvalue = Convert.ToInt64(row["autorizado"]);
            //Remainingpoblation = Convert.ToInt64(row["remanente_poblacion"]);
            //PoblationId = Convert.ToInt64(row["poblacion"]);
            //Distributingvalue = Convert.ToInt64(row[""]);
        }
    }
}
