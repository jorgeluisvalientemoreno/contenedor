using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
//
namespace SINCECOMP.FNB.Entities
{
    /// <summary>
    /// 
    /// </summary>
    public class ContainerSublineByLine
    {

        #region Campos

        private string _id;
        private string _description;
        private string _idLine;

        #endregion Campos

        /// <summary>
        /// Identificador sublínea
        /// </summary>
        [DisplayName("Identificador")]
        public string CODIGO
        {
            get
            {
                return _id;
            }
            set
            {
                _id = value;
            }
        }

        /// <summary>
        /// Descripción de la sublínea
        /// </summary>
        [DisplayName("Descripción")]
        public string DESCRIPCION
        {
            get
            {
                return _description;
            }
            set
            {
                _description = value;
            }
        }

        /// <summary>
        /// Descripción de la línea
        /// </summary>
        [DisplayName("Identificador línea")]
        public string Line_id
        {
            get
            {
                return _idLine;
            }
            set
            {
                _idLine = value;
            }
        }


    }

}
