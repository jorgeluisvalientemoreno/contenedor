#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : FlowShareFIHOS
 * Descripcion   : Clase para el flujo de cuotas de ayuda de venta
 * Autor         : 
 * Fecha         : 
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 07-Sep-2013  216582  lfernandez     1 - <ValueExtraQuote> <CapitalValue> <InterestValue> <SureValue>
 *                                         <TotalValue> <SaldoCapital> Se redondea el valor a devolver a 2
 *                                         decimales para el excel del flujo de cuotas
 * 05-Sep-2013  212246  lfernandez     1 - <NumberQuotePay> Se actualiza el displayName
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.FNB.Entities
{
    class FlowShareFIHOS
    {
        private Int64 numberQuotePay;

        [DisplayName("Número de la Cuota")]
        public Int64 NumberQuotePay
        {
            get { return numberQuotePay; }
            set { numberQuotePay = value; }
        }

        private Decimal valueExtraQuote;

        [DisplayName("Valor de la Cuota Extra")]
        public Decimal ValueExtraQuote
        {
            get { return Math.Round(valueExtraQuote,2); }
            set { valueExtraQuote = value; }
        }

        private Decimal capitalValue;

        [DisplayName("Valor de Capital")]
        public Decimal CapitalValue
        {
            get { return Math.Round(capitalValue,2); }
            set { capitalValue = value; }
        }

        private Decimal interestValue;

        [DisplayName("Valor de Interes")]
        public Decimal InterestValue
        {
            get { return Math.Round(interestValue, 2); }
            set { interestValue = value; }
        }

        private Decimal sureValue;

        [DisplayName("Valor Seguro")]
        public Decimal SureValue
        {
            get { return Math.Round(sureValue, 2); }
            set { sureValue = value; }
        }

        private Decimal totalValue;

        [DisplayName("Valor Total")]
        public Decimal TotalValue
        {
            get { return Math.Round(totalValue, 2); }
            set { totalValue = value; }
        }

        private Decimal saldoCapital;

        public Decimal SaldoCapital
        {
            get { return Math.Round(saldoCapital, 2); }
            set { saldoCapital = value; }
        }

        public FlowShareFIHOS()
        {
        }
    }
}
