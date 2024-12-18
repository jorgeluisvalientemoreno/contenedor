using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

//LIBRERIAS DE OPEN
using OpenSystems.Windows.Controls;

//LIBRERIAS COMPLEMENTARIAS
using SINCECOMP.VALORECLAMO.BL;
using System.Data;
using System.Windows.Forms;
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;

using OpenSystems.Common.Data;


namespace SINCECOMP.VALORECLAMO.UI
{
    public partial class LDSOLICITANTE : OpenForm
    {

        BLGENERAL general = new BLGENERAL(); //Procedimiento Generales
        public String _TipoIdentificacion;
        public String _Identificacion;
        public Int64 _DireccionContrato;
        public Int64 _onuerrorcode;
        public String _osberrormessage;
        


        public LDSOLICITANTE()
        {
            InitializeComponent();
        }

        private void LDSOLICITANTE_Load(object sender, EventArgs e)
        {
            DataTable identType = general.getValueList(BLConsultas.TipoDocumentoC);
            cmb_solicitantetipodoc.DataSource = identType;
            cmb_solicitantetipodoc.ValueMember = "CODIGO";
            cmb_solicitantetipodoc.DisplayMember = "DESCRIPCION";

            cmb_solicitantetipodoc.Text = _TipoIdentificacion;
            txt_solicitantedoc.TextBoxValue = _Identificacion;

            _onuerrorcode = -1;
            _osberrormessage = "Cierre inesperado";

        }

        private void BtnProcesar_Click(object sender, EventArgs e)
        {
            Boolean BlObligatorio = true;

            ///////VALIDAR OBJETOS OBLIGATORIOS
            //VALIDACION DEL MEDIO DE RECEPCION
            if (String.IsNullOrEmpty(txt_nombre.TextBoxValue))
            {
                general.mensajeERROR("El Nombre es Obligatorio");
                txt_nombre.Focus();
                BlObligatorio = false;
            }
            if (String.IsNullOrEmpty(txt_apellido.TextBoxValue))
            {
                general.mensajeERROR("El Apellido es Obligatorio");
                txt_apellido.Focus();
                BlObligatorio = false;
            }
            if (String.IsNullOrEmpty(txt_telefono.TextBoxValue))
            {
                general.mensajeERROR("El Telefono es Obligatorio");
                txt_telefono.Focus();
                BlObligatorio = false;
            }
            if (String.IsNullOrEmpty(txt_correo.TextBoxValue))
            {
                general.mensajeERROR("El Correo es Obligatorio");
                txt_correo.Focus();
                BlObligatorio = false;
            }
            /////////

            Int64 onuerrorcode;
            String osberrormessage;

            if (BlObligatorio == true)
            {
                ///(Int64 inuident_type_id, String isbidentification, String isbsubscriber_name, String isbsubs_last_name, String isbphone, String isbe_mail, Int64 inuDireccionContrato, out Int64 onuerrorcode, out String osberrormessage)
                general.CreacionCliente(Convert.ToInt64(_TipoIdentificacion), _Identificacion, txt_nombre.TextBoxValue, txt_apellido.TextBoxValue, txt_telefono.TextBoxValue, txt_correo.TextBoxValue, _DireccionContrato, out onuerrorcode, out osberrormessage);
                if (onuerrorcode == 0)
                {
                    general.mensajeOk(osberrormessage);
                    _onuerrorcode = onuerrorcode;
                    _osberrormessage = osberrormessage;
                    OpenDataBase.Transaction.Commit();
                    this.Close();
                }
                else
                {
                    general.mensajeERROR(osberrormessage);
                    _onuerrorcode = onuerrorcode;
                    _osberrormessage = osberrormessage;
                    OpenDataBase.Transaction.Rollback();
                    this.Close();
                }
            }
        }
    }
}
