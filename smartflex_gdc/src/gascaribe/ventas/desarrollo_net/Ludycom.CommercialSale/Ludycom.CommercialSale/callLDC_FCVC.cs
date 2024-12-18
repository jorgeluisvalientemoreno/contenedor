using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using OpenSystems.Common.Util;
using Ludycom.CommercialSale.Entities;
using Ludycom.CommercialSale.UI;
using Ludycom.CommercialSale.BL;

namespace Ludycom.CommercialSale
{
    public class callLDC_FCVC : IOpenExecutable
    {
        private String strLevel;
        public Int64 nuCode = 4; //1 //152 //60 cot 2 3 //150
        private BLLDC_FCVC blLDC_FCVC = new BLLDC_FCVC();
        private BLUtilities utilities = new BLUtilities();

        public void Execute(Dictionary<string, object> parameters)
        {
            strLevel = string.Empty;

            strLevel = "LDC_COTI_COMERCIAL";  //CUSTOMER LDC_COTI_COMERCIAL

            if (parameters.ContainsKey("NodeLevel"))
            {
                strLevel = OpenConvert.ToString(parameters["NodeLevel"]);
            }

            if (parameters.ContainsKey("NodeId"))
            {
                nuCode = Convert.ToInt64(parameters["NodeId"].ToString());
            }

            if (nuCode > 0 & strLevel.Length > 0)
            {
                if (strLevel.Equals(Constants.QUOTATION_LEVEL))
                {
                    if (!blLDC_FCVC.QuotationExists(nuCode))
                    {
                        utilities.DisplayErrorMessage("La cotización con código " + nuCode + " no existe en el sistema");
                        return;
                    }

                    LDC_FCVC.QuotationMode = OperationType.Modification;
                }
                else
                {
                    LDC_FCVC.QuotationMode = OperationType.Register;
                }

                using (LDC_FCVC frm = new LDC_FCVC(nuCode))
                {
                    frm.ShowDialog();
                }
            }
        }
    }
}
