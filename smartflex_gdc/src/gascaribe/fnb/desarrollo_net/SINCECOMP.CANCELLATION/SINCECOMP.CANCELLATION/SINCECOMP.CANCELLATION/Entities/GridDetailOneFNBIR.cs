using System;
using System.Collections.Generic;
using System.Text;
//using System.Data;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.CANCELLATION.Entities
{
    class GridDetailOneFNBIR
    {
        private bool check;

        [DisplayName(" ")]
        public bool Check
        {
            get { return check; }
            set { check = value; }
        }

        private Int64 orderId;

        [DisplayName("Orden")]
        public Int64 OrderId
        {
            get { return orderId; }
            set { orderId = value; }
        }

        private Int64 typeDenyDevolution;

        //[DisplayName("Anulación/Devolución")]
        [Browsable(false)]
        public Int64 TypeDenyDevolution
        {
            get { return typeDenyDevolution; }
            set { typeDenyDevolution = value; }
        }

        private String typeDenyDevolutionDesc;
        
        [DisplayName("Anulación/Devolución")]
        public String TypeDenyDevolutionDesc
        {
            get { return typeDenyDevolutionDesc; }
            set { typeDenyDevolutionDesc = value; }
        }

        private Int64 saleSolicite;

        [DisplayName("Solicitud de Venta")]
        public Int64 SaleSolicite
        {
            get { return saleSolicite; }
            set { saleSolicite = value; }
        }

        private DateTime saleDate;

        [DisplayName("Fecha Venta")]
        public DateTime SaleDate
        {
            get { return saleDate; }
            set { saleDate = value; }
        }

        private DateTime denyDate;

        [DisplayName("Fecha Anulación")]
        public DateTime DenyDate
        {
            get { return denyDate; }
            set { denyDate = value; }
        }

        private Int64 contractId;

        [DisplayName("Contrato")]
        public Int64 ContractId
        {
            get { return contractId; }
            set { contractId = value; }
        }

        private String clientId;

        [DisplayName("Identificación")]
        public String ClientId
        {
            get { return clientId; }
            set { clientId = value; }
        }

        private String clientName;

        [DisplayName("Cliente")]
        public String ClientName
        {
            get { return clientName; }
            set { clientName = value; }
        }

        private String clientAddress;

        [DisplayName("Dirección")]
        public String ClientAddress
        {
            get { return clientAddress; }
            set { clientAddress = value; }
        }

        private String origin;

        [DisplayName("Origen")]
        public String Origin
        {
            get { return origin; }
            set { origin = value; }
        }

        private String causal;

        [DisplayName("Causal")]
        public String Causal
        {
            get { return causal; }
            set { causal = value; }
        }

        private Int64 identificador;

        [DisplayName("Identificador")]       
        public Int64 Identificador
        {
            get { return identificador; }
            set { identificador = value; }
        }

        private List<ResgisterFNBCR> articleList;

        [Browsable(false)]
        public List<ResgisterFNBCR> ArticleList
        {
            get { return articleList; }
            set { articleList = value; }
        }

        public GridDetailOneFNBIR(DataRow row)
        {
            
            orderId =               Convert.ToInt64(row["orden"]);
            identificador =         Convert.ToInt64(row["identificador"]);
            typeDenyDevolution =    Convert.ToInt64(row["task_type_id"]);            
            typeDenyDevolutionDesc  = Convert.ToString(row["task_type_desc"]);
            saleSolicite=           Convert.ToInt64 (row["Solicitud de venta"]);
            saleDate =              Convert.ToDateTime(row["Fecha de venta"]);
            denyDate=               Convert.ToDateTime (row["FechaAnulac"]);
            contractId=             Convert.ToInt64(row["contrato"]);
            clientId=               row["Identification"].ToString();
            clientName  =           row["Cliente"].ToString();
            clientAddress=          row["address"].ToString();
            origin=                 row["origen"].ToString();
            causal =                row["causal"].ToString();
            //state =                 row["Estado"].ToString();
            check =                 false;

        }
    }
}
