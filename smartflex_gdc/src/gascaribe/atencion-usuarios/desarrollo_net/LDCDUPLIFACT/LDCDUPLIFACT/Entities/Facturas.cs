using System;
using System.Collections.Generic;
using System.Text;

namespace LDCDUPLIFACT
{
    class Facturas
    {
      
        private int contrato;
        private int periodo;
        private int factura;
        private string observacion;
        private string categoria;
        private Boolean good;

        public Facturas(int contrato, int periodo, int factura, string observacion, string categoria, Boolean good)
        {
            this.contrato = contrato;
            this.periodo = periodo;
            this.factura = factura;
            this.observacion = observacion;
            this.categoria = categoria;
            this.good = good;
        }

        public int Contrato
        {
            get { return contrato; }
            set { contrato = value; }
        }
        public int Periodo
        {
            get { return periodo; }
            set { periodo = value; }
        }
        public int Factura
        {
            get { return factura; }
            set { factura = value; }
        }
        public string Observacion
        {
            get { return observacion; }
            set { observacion = value; }
        }
        public string Categoria
        {
            get { return categoria; }
            set { categoria = value; }
        }
        public Boolean Good
        {
            get { return good; }
            set { good = value; }
        }
    
    }
}
