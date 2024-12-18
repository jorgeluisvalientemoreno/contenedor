using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.FNB.Entities
{
    public class ContainerArticle
    {
        #region Campos
        private string _subLineId;
        private string _articleID;
        private string _Description;
        #endregion Campos

        #region propiedades
        [DisplayName("Código")]
        public string CODIGO
        {
            get { return _articleID; }
            set { _articleID = value; }
        }
        [DisplayName("Descripción")]
        public string DESCRIPCION
        {
            get { return _Description; }
            set { _Description = value; }
        }
        [DisplayName("Sub Línea")]
        public string SubLineId
        {
            get { return _subLineId; }
            set { _subLineId = value; }
        }

        #endregion propiedades
    }
}
