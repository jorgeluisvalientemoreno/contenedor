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
    public class ContainerSubLine
    {

        #region Campos

        private string _id;
        private string _description;
        private string _idSupplier;

        #endregion Campos

        /// <summary>
        /// Identificador línea
        /// </summary>
        [DisplayName("Identificador")]
        public string Codigo
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
        /// Descripción de la línea
        /// </summary>
        [DisplayName("Descripción")]
        public string Description
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
        [DisplayName("Identificador proveedor")]
        public string Supplier_id
        {
            get
            {
                return _idSupplier;
            }
            set
            {
                _idSupplier = value;
            }
        }


    }

}
