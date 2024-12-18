using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.FNB.Entities
{
    public class ContainerSalesChanel
    {
        #region Campos
        private string _ID;
        private string _Description;
        #endregion Campos

        #region propiedades
        [DisplayName("Código")]
        public string CODIGO
        {
            get { return _ID; }
            set { _ID = value; }
        }
        [DisplayName("Descripción")]
        public string DESCRIPCION
        {
            get { return _Description; }
            set { _Description = value; }
        }

        #endregion propiedades
    }
}
