using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace SINCECOMP.GESTIONORDENES.Entities
{
    class TrabajoAdicional
    {
        ////columna 0
        //private Boolean Eselection;
        //[DisplayName("")]
        //public Boolean selection
        //{
        //    get { return Eselection; }
        //    set { Eselection = value; }
        //}

        //columna 0
        private Int64 ETipoTrab;
        [DisplayName("Tipo de Trabajo")]
        public Int64 tipotrab
        {
            get { return ETipoTrab; }
            set { ETipoTrab = value; }
        }

        //columna 1
        private Int64 ECausal;
        [DisplayName("Causal")]
        public Int64 causal
        {
            get { return ECausal; }
            set { ECausal = value; }
        }


        //columna 2
        private Int64 EActividad;
        [DisplayName("Actividad")]
        public Int64 actividad
        {
            get { return EActividad; }
            set { EActividad = value; }
        }

        //columna 3
        private Int64 EItem;
        [DisplayName("Materiales/Actividades Secundarias")]
        public Int64 item
        {
            get { return EItem; }
            set { EItem = value; }
        }

        //columna 4
        private Double ECantidad;
        [DisplayName("Cantidad")]
        public Double cantidad
        {
            get { return ECantidad; }
            set { ECantidad = value; }
        }

        //columna 5
        private Double EValorMaterial;
        [DisplayName("Valor Material (Unidad)")]
        public Double valormaterial
        {
            get { return EValorMaterial; }
            set { EValorMaterial = value; }
        }

        //columna 6
        private Double EValorTotalMaterial;
        [DisplayName("Valor Total Material")]
        public Double valortotalmaterial
        {
            get { return EValorTotalMaterial; }
            set { EValorTotalMaterial = value; }
        }

    }
}
