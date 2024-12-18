using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.GESTIONORDENES.Entities
{
    public class ItemWarranty
    {

        /*private String identificadorGarantias;

        [DisplayName("Id. Garantia")]
        public String IdentificadorGarantias
        {
            get { return identificadorGarantias; }
            set { identificadorGarantias = value; }
        }
        private String codigoItem;

        [DisplayName("Codigo del Item")]
        public String CodigoItem
        {
            get { return codigoItem; }
            set { codigoItem = value; }
        }
        private String identificadorElementoRed;

        [DisplayName("Identificador del Elemento de Red")]
        public String IdentificadorElementoRed
        {
            get { return identificadorElementoRed; }
            set { identificadorElementoRed = value; }
        }
        private String codigoElementoRed;

        [DisplayName("Codigo Elemento de Red")]
        public String CodigoElementoRed
        {
            get { return codigoElementoRed; }
            set { codigoElementoRed = value; }
        }
        private String consecutivoProducto;

        [DisplayName("Consecutivo del Producto")]
        public String ConsecutivoProducto
        {
            get { return consecutivoProducto; }
            set { consecutivoProducto = value; }
        }
        private String numeroOrden;

        [DisplayName("Numero de la Orden")]
        public String NumeroOrden
        {
            get { return numeroOrden; }
            set { numeroOrden = value; }
        }
        private String fechaFinalGarantia;

        [DisplayName("Fecha Final de la Garantia")]
        public String FechaFinalGarantia
        {
            get { return fechaFinalGarantia; }
            set { fechaFinalGarantia = value; }
        }
        private String indicadorGarantia;

        [DisplayName("Indicador de la Garantia")]
        public String IndicadorGarantia
        {
            get { return indicadorGarantia; }
            set { indicadorGarantia = value; }
        }
        private String identificadorItemSeriado;

        [DisplayName("Identificador del Item Seriado")]
        public String IdentificadorItemSeriado
        {
            get { return identificadorItemSeriado; }
            set { identificadorItemSeriado = value; }
        }
        private String serieItemSeriado;

        [DisplayName("Serie del Item Seriado")]
        public String SerieItemSeriado
        {
            get { return serieItemSeriado; }
            set { serieItemSeriado = value; }
        }*/

        private String itemsLegalizados;

        [DisplayName("Items Legalizados")]
        public String ItemsLegalizados
        {
            get { return itemsLegalizados; }
            set { itemsLegalizados = value; }
        }
        private String ordenTrabajo;

        [DisplayName("Orden de Trabajo")]
        public String OrdenTrabajo
        {
            get { return ordenTrabajo; }
            set { ordenTrabajo = value; }
        }
        private String fechaLegalizacion;

        [DisplayName("Fecha de Legalizacion")]
        public String FechaLegalizacion
        {
            get { return fechaLegalizacion; }
            set { fechaLegalizacion = value; }
        }
        private String fechaVigenciaGarantia;

        [DisplayName("Fecha de Vigencia de la Garantia")]
        public String FechaVigenciaGarantia
        {
            get { return fechaVigenciaGarantia; }
            set { fechaVigenciaGarantia = value; }
        }
        private String observacionOrden;

        [DisplayName("Observacion de la Orden")]
        public String ObservacionOrden
        {
            get { return observacionOrden; }
            set { observacionOrden = value; }
        }
        private String unidadOperativa;

        [DisplayName("Unidad Operativa")]
        public String UnidadOperativa
        {
            get { return unidadOperativa; }
            set { unidadOperativa = value; }
        }

    }
}
