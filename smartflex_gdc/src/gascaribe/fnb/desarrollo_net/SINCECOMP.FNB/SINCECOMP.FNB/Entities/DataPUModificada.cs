using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.FNB.Entities
{
    public class DataPUModificada
    {
        private Int64 package_id;

        [Browsable(true)]
        [DisplayName("Solicitud")]
        public Int64 Package_id
        {
            get { return package_id; }
            set { package_id = value; }
        }
        private String promissory_type;

        [Browsable(true)]
        [DisplayName("Tipo de Cliente")]
        public String Promissory_type
        {
            get { return promissory_type; }
            set { promissory_type = value; }
        }
        private String debtorname_old;

        [Browsable(true)]
        [DisplayName("Nombre Anterior")]
        public String Debtorname_old
        {
            get { return debtorname_old; }
            set { debtorname_old = value; }
        }
        private String debtorname_new;

        [Browsable(true)]
        [DisplayName("Nombre Nuevo")]
        public String Debtorname_new
        {
            get { return debtorname_new; }
            set { debtorname_new = value; }
        }
        private String last_name_old;

        [Browsable(true)]
        [DisplayName("Apellido Anterior")]
        public String Last_name_old
        {
            get { return last_name_old; }
            set { last_name_old = value; }
        }
        private String last_name_new;

        [Browsable(true)]
        [DisplayName("Apellido Nuevo")]
        public String Last_name_new
        {
            get { return last_name_new; }
            set { last_name_new = value; }
        }
        private Int64 forwardingplace_old;

        [Browsable(false)]
        public Int64 Forwardingplace_old
        {
            get { return forwardingplace_old; }
            set { forwardingplace_old = value; }
        }
        private String forwardingplace_old_desc;

        [Browsable(true)]
        [DisplayName("Lugar de Expedición del Documento Anterior")]
        public String Forwardingplace_old_desc
        {
            get { return forwardingplace_old_desc; }
            set { forwardingplace_old_desc = value; }
        }
        private Int64 forwardingplace_new;

        [Browsable(false)]
        public Int64 Forwardingplace_new
        {
            get { return forwardingplace_new; }
            set { forwardingplace_new = value; }
        }
        private String forwardingplace_new_desc;

        [Browsable(true)]
        [DisplayName("Lugar de Expedición del Documento Nueva")]
        public String Forwardingplace_new_desc
        {
            get { return forwardingplace_new_desc; }
            set { forwardingplace_new_desc = value; }
        }
        private DateTime forwardingdate_old;

        [Browsable(true)]
        [DisplayName("Fecha de Expedición del Documento Anterior")]
        public DateTime Forwardingdate_old
        {
            get { return forwardingdate_old; }
            set { forwardingdate_old = value; }
        }
        private DateTime forwardingdate_new;

        [Browsable(true)]
        [DisplayName("Fecha de Expedición del Documento Nueva")]
        public DateTime Forwardingdate_new
        {
            get { return forwardingdate_new; }
            set { forwardingdate_new = value; }
        }
        private DateTime birthdaydate_old;

        [Browsable(true)]
        [DisplayName("Fecha de Nacimiento Anterior")]
        public DateTime Birthdaydate_old
        {
            get { return birthdaydate_old; }
            set { birthdaydate_old = value; }
        }
        private DateTime birthdaydate_new;

        [Browsable(true)]
        [DisplayName("Fecha de Nacimiento Nueva")]
        public DateTime Birthdaydate_new
        {
            get { return birthdaydate_new; }
            set { birthdaydate_new = value; }
        }
        private Int64 propertyphone_id_old;

        [Browsable(true)]
        [DisplayName("Telefono Anterior")]
        public Int64 Propertyphone_id_old
        {
            get { return propertyphone_id_old; }
            set { propertyphone_id_old = value; }
        }
        private Int64 propertyphone_id_new;

        [Browsable(true)]
        [DisplayName("Telefono Nuevo")]
        public Int64 Propertyphone_id_new
        {
            get { return propertyphone_id_new; }
            set { propertyphone_id_new = value; }
        }
        private Int64 movilphone_id_old;

        [Browsable(true)]
        [DisplayName("Celular Anterior")]
        public Int64 Movilphone_id_old
        {
            get { return movilphone_id_old; }
            set { movilphone_id_old = value; }
        }
        private Int64 movilphone_id_new;

        [Browsable(true)]
        [DisplayName("Celular Nuevo")]
        public Int64 Movilphone_id_new
        {
            get { return movilphone_id_new; }
            set { movilphone_id_new = value; }
        }
        private String documento;

        [Browsable(true)]
        [DisplayName("Documento del Usuario Modificado")]
        public String Documento
        {
            get { return documento; }
            set { documento = value; }
        }
        private Int64 pagare;

        [Browsable(true)]
        [DisplayName("Número del Pagare")]
        public Int64 Pagare
        {
            get { return pagare; }
            set { pagare = value; }
        }
        private Int64 person_id;

        [Browsable(false)]
        public Int64 Person_id
        {
            get { return person_id; }
            set { person_id = value; }
        }
        private String person_id_desc;

        [Browsable(true)]
        [DisplayName("Usuario que realizo la Modificación")]
        public String Person_id_desc
        {
            get { return person_id_desc; }
            set { person_id_desc = value; }
        }
        private DateTime fecha_modificacion;

        [Browsable(true)]
        [DisplayName("Fecha de Modificación")]
        public DateTime Fecha_modificacion
        {
            get { return fecha_modificacion; }
            set { fecha_modificacion = value; }
        }

        public DataPUModificada(DataRow row)
        {
            Package_id = Convert.ToInt64(row["package_id"]);
            Promissory_type = row["promissory_type"].ToString();
            Debtorname_old = row["debtorname_old"].ToString();
            Debtorname_new = row["debtorname_new"].ToString();
            Last_name_old = row["last_name_old"].ToString();
            Last_name_new = row["last_name_new"].ToString();
            Forwardingplace_old = Convert.ToInt64(row["forwardingplace_old"]);
            Forwardingplace_old_desc = row["forwardingplace_old_desc"].ToString();
            Forwardingplace_new = Convert.ToInt64(row["forwardingplace_new"]);
            Forwardingplace_new_desc = row["forwardingplace_new_desc"].ToString();
            Forwardingdate_old = Convert.ToDateTime(row["forwardingdate_old"].ToString());
            Forwardingdate_new = Convert.ToDateTime(row["forwardingdate_new"].ToString());
            Birthdaydate_old = Convert.ToDateTime(row["birthdaydate_old"].ToString());
            Birthdaydate_new = Convert.ToDateTime(row["birthdaydate_new"].ToString());
            Propertyphone_id_old = Convert.ToInt64(row["propertyphone_id_old"].ToString());
            Propertyphone_id_new = Convert.ToInt64(row["propertyphone_id_new"].ToString());
            Movilphone_id_old = Convert.ToInt64(row["movilphone_id_old"].ToString());
            Movilphone_id_new = Convert.ToInt64(row["movilphone_id_new"].ToString());
            Documento = row["documento"].ToString();
            Pagare = Convert.ToInt64(row["pagare"].ToString());
            Person_id = Convert.ToInt64(row["person_id"].ToString());
            Person_id_desc = row["person_id_desc"].ToString();
            Fecha_modificacion = Convert.ToDateTime(row["fecha_modificacion"].ToString());
        }
    }
}
