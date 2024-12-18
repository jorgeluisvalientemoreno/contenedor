using System;
using System.Collections.Generic;
using System.Text;

//Libreria OPEN
using System.ComponentModel;
using OpenSystems.Common.ExceptionHandler;

namespace BSS.METROSCUBICOS.Entities
{
    class Prometcub
    {
        //columna A
        private Boolean Eselection;
        [DisplayName(" ")]
        public Boolean selection
        {
            get { return Eselection; }
            set { Eselection = value; }
        }

        //columna B
        //private Int64 EAccion;
        //[DisplayName("Accion")]
        //public Int64 accion
        //{
        //    get { return EAccion; }
        //    set { EAccion = value; }
        //}
        private String EAccion;
        [DisplayName("Accion")]
        public String accion
        {
            get { return EAccion; }
            set { EAccion = value; }
        }

        //columna C
        private String EObservacion;
        [DisplayName("Observacion")]
        public String observacion
        {
            get { return EObservacion; }
            set { EObservacion = value; }
        }

        //columna D
        private Int64 EPeriodo;
        [DisplayName("Periodo")]
        public Int64 periodo
        {
            get { return EPeriodo; }
            set { EPeriodo = value; }
        }

        //columna D
        private Int64 EAnno;
        [DisplayName("Año")]
        public Int64 anno
        {
            get { return EAnno; }
            set { EAnno = value; }
        }

        //columna F
        private Int64 EMes;
        [DisplayName("Mes")]
        public Int64 mes
        {
            get { return EMes; }
            set { EMes = value; }
        }

        //columna G
        private String ECiclo;
        [DisplayName("Ciclo")]
        public String ciclo
        {
            get { return ECiclo; }
            set { ECiclo = value; }
        }

        //columna H
        private Int64 EContrato;
        [DisplayName("Contrato")]
        public Int64 contrato
        {
            get { return EContrato; }
            set { EContrato = value; }
        }

        //columna I
        private Int64 EProducto;
        [DisplayName("Producto")]
        public Int64 producto
        {
            get { return EProducto; }
            set { EProducto = value; }
        }

        //columna J
        private String EConcepto;
        [DisplayName("Concepto")]
        public String concepto
        {
            get { return EConcepto; }
            set { EConcepto = value; }
        }

        //columna K
        private Int64 EVolliq;
        [DisplayName("Volumen liquidado")]
        public Int64 volliq
        {
            get { return EVolliq; }
            set { EVolliq = value; }
        }

        //columna L
        private Int64 EValliq;
        [DisplayName("Valor Liquidado")]
        public Int64 valliq
        {
            get { return EValliq; }
            set { EValliq = value; }
        }

        //columna M
        private String ECategoria;
        [DisplayName("Categoría")]
        public String categoría
        {
            get { return ECategoria; }
            set { ECategoria = value; }
        }

        //columna N
        private String ESubcategoria;
        [DisplayName("Subcategoria")]
        public String subcategoria
        {
            get { return ESubcategoria; }
            set { ESubcategoria = value; }
        }

        //columna O
        private String EEstado_producto;
        [DisplayName("Estado producto")]
        public String estado_producto
        {
            get { return EEstado_producto; }
            set { EEstado_producto = value; }
        }

        //columna P
        private Int64 ECodigociclo;
        [DisplayName("Codigo Ciclo")]
        public Int64 codigociclo
        {
            get { return ECodigociclo; }
            set { ECodigociclo = value; }
        }

        //columna q
        private String EProceso;
        [DisplayName("Proceso")]
        public String proceso
        {
            get { return EProceso; }
            set { EProceso = value; }
        }

        //columna q
        private Int64 EProcesoCod;
        [DisplayName("procesoCod")]
        public Int64 procesoCod
        {
            get { return EProcesoCod; }
            set { EProcesoCod = value; }
        }
    }
}
