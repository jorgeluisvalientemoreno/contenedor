using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;
using System.Data;
using SINCECOMP.FNB.DAL;

namespace SINCECOMP.FNB.Entities
{
    class OrderFILOT 
    {
        private Boolean selection;

        [DisplayName(" ")]
        public Boolean Selection
        {
            get { return selection; }
            set { selection = value; }
        }

        private Int64 orderId;

        [DisplayName("Orden")]
        public Int64 OrderId
        {
            get { return orderId; }
            set { orderId = value; }
        }

        private Int64 activityId;

        [DisplayName("Actividad")]
        public Int64 ActivityId
        {
            get { return activityId; }
            set { activityId = value; }
        }

        /*07-01-2015 KCienfuegos.RNP1224*/
        private String invoiceNumber;

        [DisplayName("Número de Factura")]
        public String InvoiceNumber
        {
            get { return invoiceNumber; }
            set { invoiceNumber = value; }
        }
        /*******************************/

        //private String stateActivity;

        //[DisplayName("Estado de la Actividad")]
        //public String StateActivity
        //{
        //    get { return stateActivity; }
        //    set { stateActivity = value; }
        //}

        private String stateOrder;

        [DisplayName("Estado de la Orden")]
        public String StateOrder
        {
            get { return stateOrder; }
            set { stateOrder = value; }
        }

        private String nameClient;

        [DisplayName("Nombre del Cliente")]
        public String NameClient
        {
            get { return nameClient; }
            set { nameClient = value; }
        }

        private String address;

        [DisplayName("Dirección")]
        public String Address
        {
            get { return address; }
            set { address = value; }
        }

        private DateTime? dateAsign;

        [DisplayName("Fecha de Asignación")]
        public DateTime? DateAsign
        {
            get { return dateAsign; }
            set { dateAsign = value; }
        }

        private Int64 articleId;

        [Browsable(false)]
        public Int64 ArticleId
        {
            get { return articleId; }
            set { articleId = value; }
        }


        private Boolean exito;

        [DisplayName("Entregado?")]
        public Boolean Exito
        {
            get { return exito; }
            set { exito = value; }
        }

        private String articleDescription;

        [DisplayName("Artículo")]        
        public String ArticleDescription
        {
            get { return articleDescription; }
            set { articleDescription = value; }
        }
        
        /*26-08-2014 KCienfuegos.RNP156*/
        private String orderComment;

        [DisplayName("Observación")]
        public String OrderComment
        {
            get { return orderComment; }
            set { orderComment = value; }
        }
        /*******************************/


        /*CASO 200-1164*/
        private String seguro_voluntario;

        [DisplayName("Seguro Voluntario")]
        public String Seguro_voluntario
        {
            get { return seguro_voluntario; }
            set { seguro_voluntario = value; }
        }
        /*******************************/


        public OrderFILOT(DataRow row)
        {
            orderId = Convert.ToInt64(row["order_id"]);
            activityId = Convert.ToInt64(row["order_activity_id"]);
            //stateActivity = row["status"].ToString();
            stateOrder = row["order_status_id"].ToString();
            nameClient = row["nomclien"].ToString();
            address = row["DIRECCION"].ToString();
            dateAsign = Convert.ToDateTime(row["assigned_date"]);
            articleId = Convert.ToInt64(row["article_id"]);
            articleDescription = row["DESCRIPTION"].ToString();
            /*CASO 200-1164*/
            seguro_voluntario = row["Seguro_Voluntario"].ToString();
            /*CASO 200-1164*/

        }

    }
}
