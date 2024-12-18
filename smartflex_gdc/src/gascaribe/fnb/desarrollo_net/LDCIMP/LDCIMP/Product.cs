using System;
using System.Collections.Generic;
using System.Text;

namespace LDCIMP
{
    public class Product
    {
        private object _ProductId;
        private string _TipoProducto;
        private object _SumaCorriente;
        private object _Suma30;
        private object _Suma60;
        private object _Suma90;
        private object _Suma91;

        public virtual object ProductId
        {
            get { return this._ProductId; }
            set { this._ProductId = value; }
        }

        public virtual object TipoProducto
        {
            get { return this._TipoProducto; }
            set { this._TipoProducto = value.ToString(); }
        }

        public virtual object SumaCorriente
        {
            get { return this._SumaCorriente; }
            set { this._SumaCorriente = value; }
        }

        public virtual object Suma30
        {
            get { return this._Suma30; }
            set { this._Suma30 = value; }
        }

        public virtual object Suma60
        {
            get { return this._Suma60; }
            set { this._Suma60 = value; }
        }

        public virtual object Suma90
        {
            get { return this._Suma90; }
            set { this._Suma90 = value; }
        }

        public virtual object Suma91
        {
            get { return this._Suma91; }
            set { this._Suma91 = value; }
        }
    }
}
