using System;
using System.Collections.Generic;
using System.Text;

namespace KIOSKO.Entities
{
    class fact_historico
    {
        private String EfactorCorreccion;

        public String factorCorreccion
        {
            get { return EfactorCorreccion; }
            set { EfactorCorreccion = value; }
        }
        private Double EconsumoCorregido;

        public Double consumoCorregido
        {
            get { return EconsumoCorregido; }
            set { EconsumoCorregido = value; }
        }
        private String Epresion;

        public String presion
        {
            get { return Epresion; }
            set { Epresion = value; }
        }
        private String Etemperatura;

        public String temperatura
        {
            get { return Etemperatura; }
            set { Etemperatura = value; }
        }
        private Double EcalculoConsumo;

        public Double calculoConsumo
        {
            get { return EcalculoConsumo; }
            set { EcalculoConsumo = value; }
        }
        private String EconsumoPromedio;

        public String consumoPromedio
        {
            get { return EconsumoPromedio; }
            set { EconsumoPromedio = value; }
        }
        private String EequivalenciaKWH;

        public String equivalenciaKWH
        {
            get { return EequivalenciaKWH; }
            set { EequivalenciaKWH = value; }
        }
    }
}
