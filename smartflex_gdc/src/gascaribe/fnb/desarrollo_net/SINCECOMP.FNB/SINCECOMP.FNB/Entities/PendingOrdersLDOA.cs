using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.FNB.Entities
{
    class PendingOrdersLDOA
    {
        private Boolean selection;

        [DisplayName(" ")]
        public Boolean Selection
        {
            get { return selection; }
            set { selection = value; }
        }

        private Int64 order;

        [DisplayName("Orden")]
        public Int64 Order
        {
            get { return order; }
            set { order = value; }
        }

        private String stateOrder;

        [DisplayName("Estado de la Orden")]
        public String StateOrder
        {
            get { return stateOrder; }
            set { stateOrder = value; }
        }

        private Int64 contract;

        [DisplayName("Contrato")]
        public Int64 Contract
        {
            get { return contract; }
            set { contract = value; }
        }

        private String  approval;

        [DisplayName("Aprobar")]
        public String Approval
        {
            get { return approval; }
            set { approval = value; }
        }

        private DateTime saleDate;

        [DisplayName("Fecha de Venta")]
        public DateTime SaleDate
        {
            get { return saleDate; }
            set { saleDate = value; }
        }

        private DateTime registerDate;
        [DisplayName("Fecha de Registro")]
        //[Browsable(false)]
        public DateTime RegisterDate
        {
            get { return registerDate; }
            set { registerDate = value; }
        }

        private String causalId;

        [DisplayName("Causal")]
        public String CausalId
        {
            get { return causalId; }
            set { causalId = value; }
        }
        //private Int64? causalId;

        //[DisplayName("Causal")]
        //public Int64? CausalId
        //{
        //    get {
        //        return causalId;//.HasValue ? causalId : null;//causalId; 
        //    }
        //    set {
        //        //Object valor = value;
        //        //if (string.IsNullOrEmpty (Convert.ToString (valor)))
        //        //    causalId = null;
        //        //else
        //        //if (value!=null)
        //            causalId = value; 
        //    }
        //}

        public PendingOrdersLDOA(DataRow row)
        {
            Order = Convert.ToInt64(row["order_id"]);
            StateOrder = Convert.ToString(row["description"]);
            Approval = Convert.ToString(row["approved"]);
            Contract  = Convert.ToInt64(row["subscription_id"]);
            RegisterDate = Convert.ToDateTime(row["request_date"]);
            SaleDate = Convert.ToDateTime(row["sale_date"]);
            //CausalId = null;
        }
    }
}
