using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.CANCELLATION.UI;

namespace SINCECOMP.CANCELLATION
{
    public class callFNBCR : IOpenExecutable
    {
        private static SINCECOMP.CANCELLATION.BL.BLFNBCR _blFNBCR = new SINCECOMP.CANCELLATION.BL.BLFNBCR();

        public void Execute(Dictionary<string, object> parameters)
        {
            Int64 SaleRequestId = 0;
            try
            {
                SaleRequestId = Convert.ToInt64(parameters["NodeId"].ToString());

                using (FNBCR frm = new FNBCR(SaleRequestId))
                {
                    frm.ShowDialog();
                }
            }
            catch
            {
                throw;
            }

        }
    }
}
