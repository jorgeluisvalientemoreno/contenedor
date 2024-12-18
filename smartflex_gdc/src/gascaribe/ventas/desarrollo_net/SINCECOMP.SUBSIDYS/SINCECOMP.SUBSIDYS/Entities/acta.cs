using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace SINCECOMP.SUBSIDYS.Entities
{
    class acta
    {
        private Int64 consecute;

        [DisplayName("Consecutivo")]
        public Int64 Consecute
        {
            get { return consecute; }
            set { consecute = value; }
        }

        private Int64 subsidy_id;

        [DisplayName("Subsidio")]
        public Int64 Subsidy_id
        {
            get { return subsidy_id; }
            set { subsidy_id = value; }
        }

        private String ente;

        [DisplayName("Ente")]
        public String Ente
        {
            get { return ente; }
            set { ente = value; }
        }

        private Int64 asig_subsidy_id;

        [DisplayName("Asignación")]
        public Int64 Asig_subsidy_id
        {
            get { return asig_subsidy_id; }
            set { asig_subsidy_id = value; }
        }

        private String ubicacion;

        [DisplayName("Ubicación")]
        public String Ubicacion
        {
            get { return ubicacion; }
            set { ubicacion = value; }
        }

        private Int64 susccodi;

        [DisplayName("Contrato")]
        public Int64 Susccodi
        {
            get { return susccodi; }
            set { susccodi = value; }
        }

        private String cliente;

        [DisplayName("Cliente")]
        public String Cliente
        {
            get { return cliente; }
            set { cliente = value; }
        }

        private String estrato;

        [DisplayName("Estrato")]
        public String Estrato
        {
            get { return estrato; }
            set { estrato = value; }
        }

        private Int64 subsidy_Value;

        [DisplayName("Valor Subsidiado")]
        public Int64 Subsidy_Value
        {
            get { return subsidy_Value; }
            set { subsidy_Value = value; }
        }

        private Int64 acta_cobro;

        public Int64 Acta_cobro
        {
            get { return acta_cobro; }
            set { acta_cobro = value; }
        }

        public acta(DataRow row, int contador)
        {
            //if (Convert.IsDBNull(row["Consecute"]) != true)
            //    Consecute = Convert.ToInt64(row["Consecute"]);
            //else
            Consecute = contador;
            if (Convert.IsDBNull(row["Subsidy_id"]) != true)
                Subsidy_id = Convert.ToInt64(row["Subsidy_id"]);
            else
                Subsidy_id = 0;
            if (Convert.IsDBNull(row["Ente"]) != true)
                Ente = Convert.ToString(row["Ente"]);
            else
                Ente="";
            if (Convert.IsDBNull(row["Asig_subsidy_id"]) != true)
                Asig_subsidy_id = Convert.ToInt64(row["Asig_subsidy_id"]);
            else
                Asig_subsidy_id=0;
            if (Convert.IsDBNull(row["Ubicacion"]) != true)
                Ubicacion = Convert.ToString(row["Ubicacion"]);
            else
                Ubicacion="";
            if (Convert.IsDBNull(row["Susccodi"]) != true)
                Susccodi = Convert.ToInt64(row["Susccodi"]);
            else
                Susccodi=0;
            if (Convert.IsDBNull(row["Cliente"]) != true)
                Cliente = Convert.ToString(row["Cliente"]);
            else
                Cliente="";
            if (Convert.IsDBNull(row["Estrato"]) != true)
                Estrato = Convert.ToString(row["Estrato"]);
            else
                Estrato="";
            if (Convert.IsDBNull(row["Subsidy_Value"]) != true)
                Subsidy_Value = Convert.ToInt64(row["Subsidy_Value"]);
            else
                Subsidy_Value = 0;
            if (Convert.IsDBNull(row["Acta_cobro"]) != true)
                Acta_cobro = Convert.ToInt64(row["Acta_cobro"]);
            else
                Acta_cobro = 0;

        }
    }
}
