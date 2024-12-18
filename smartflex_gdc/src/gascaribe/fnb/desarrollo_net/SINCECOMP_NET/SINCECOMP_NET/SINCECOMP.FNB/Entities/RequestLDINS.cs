using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.FNB.Entities
{
    class RequestLDINS
    {
        Boolean print;

        [DisplayName("Imprimir")]
        public Boolean Print
        {
            get { return print; }
            set { print = value; }
        }

        Int64 notificationId;

        [DisplayName("Notificación")]
        public Int64 NotificationId
        {
            get { return notificationId; }
            set { notificationId = value; }
        }

        Int64 notificationLogId;

        [DisplayName("Log. de Notificación")]
        public Int64 NotificationLogId
        {
            get { return notificationLogId; }
            set { notificationLogId = value; }
        }

        Int64 request;

        [DisplayName("Solicitud")]
        public Int64 Request
        {
            get { return request; }
            set { request = value; }
        }

        DateTime requestDate;

        [DisplayName("Fecha de Solicitud")]
        public DateTime RequestDate
        {
            get { return requestDate; }
            set { requestDate = value; }
        }

        DateTime registerDate;

        [DisplayName("Fecha de Registro")]
        public DateTime RegisterDate
        {
            get { return registerDate; }
            set { registerDate = value; }
        }

        //Int64 codeBased;

        //[DisplayName("Codigo Radicado")]
        //public Int64 CodeBased
        //{
        //    get { return codeBased; }
        //    set { codeBased = value; }
        //}
        String codeBased;

        [DisplayName("Radicado")]
        public String CodeBased
        {
            get { return codeBased; }
            set { codeBased = value; }
        }

        String destinyPerson;

        [DisplayName("Persona Destino")]
        public String DestinyPerson
        {
            get { return destinyPerson; }
            set { destinyPerson = value; }
        }

        //String causal;

        //[DisplayName("Causal")]
        //public String Causal
        //{
        //    get { return causal; }
        //    set { causal = value; }
        //}

        //String channel;

        //[DisplayName("Canal")]
        //public String Channel
        //{
        //    get { return channel; }
        //    set { channel = value; }
        //}
        Int64 causal;

        [DisplayName("Causal")]
        public Int64 Causal
        {
            get { return causal; }
            set { causal = value; }
        }

        Int64 channel;

        [DisplayName("Canal")]
        public Int64 Channel
        {
            get { return channel; }
            set { channel = value; }
        }

        String observation;

        [DisplayName("Observación")]
        public String Observation
        {
            get { return observation; }
            set { observation = value; }
        }

        public RequestLDINS(DataRow row)
        {
            if (Convert.IsDBNull(row["notification_id"]) != true)
                NotificationId = Convert.ToInt64(row["notification_id"]);
            else
                NotificationId = 0;
            if (Convert.IsDBNull(row["notification_log_id"]) != true)
                NotificationLogId = Convert.ToInt64(row["notification_log_id"]);
            else
                NotificationLogId = 0;
            if (Convert.IsDBNull(row["package_id"]) != true)
                Request = Convert.ToInt64(row["package_id"]);
            else
                Request = 0;
            if (Convert.IsDBNull(row["request_date"]) != true)
                RequestDate = Convert.ToDateTime(row["request_date"]);
            else
                RequestDate = Convert.ToDateTime("01/01/2001");

            if (Convert.IsDBNull(row["register_date"]) != true)
                RegisterDate = Convert.ToDateTime(row["register_date"]);
            else
                RegisterDate = Convert.ToDateTime("01/01/2001");

            if (Convert.IsDBNull(row["radicated"]) != true)
                CodeBased = Convert.ToString(row["radicated"]);
            else
                codeBased = "";
            if (Convert.IsDBNull(row["target_person"]) != true)
                DestinyPerson = Convert.ToString(row["target_person"]);
            else
                DestinyPerson = "";
            if (Convert.IsDBNull(row["causal_id"]) != true)
                Causal = Convert.ToInt64(row["causal_id"]);
            else
                Causal = 0;
            if (Convert.IsDBNull(row["com_channel_id"]) != true)
                Channel = Convert.ToInt64(row["com_channel_id"]);
            else
                Channel = 0;
            if (Convert.IsDBNull(row["observation"]) != true)
                Observation = Convert.ToString(row["observation"]);
            else
                Observation = "";
        }
    }
}
