using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using System.Windows.Forms;
using OpenSystems.Common.Util;

namespace BSS.LineamientosPSPD.Entities
{
	class Cargue
	{
        private String contrato;
        private String direccionReportada;
        private String direccionPredioOsf;
        private Int64? suscriptorId;
        private String nombreSuscriptor;
        //private DataGridViewComboBoxColumn motivoInclusion;

        [DisplayName("Contrato")]
        public String Contrato
        {
            get { return contrato; }
            set { contrato = value; }
        }

        [DisplayName("Dirección Reportada")]
        public String DireccionReportada
        {
            get { return direccionReportada; }
            set { direccionReportada = value; }
        }

        [DisplayName("Dirección Predio OSF")]
        public String DireccionPredioOsf
        {
            get { return direccionPredioOsf; }
            set { direccionPredioOsf = value; }
        }

        [DisplayName("Suscriptor Id")]
        public Int64? SuscriptorId
        {
            get { return suscriptorId; }
            set { suscriptorId = value; }
        }

        [DisplayName("Nombre Suscriptor")]
        public String NombreSuscriptor
        {
            get { return nombreSuscriptor; }
            set { nombreSuscriptor = value; }
        }
        /*
        [DisplayName("Motivo Inclusión")]
        public DataGridViewComboBoxColumn MotivoInclusion
        {
            get { return motivoInclusion; }
            set { motivoInclusion = value; }
        }*/
	}
}
