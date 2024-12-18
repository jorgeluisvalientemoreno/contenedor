using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using OpenSystems.Common.Util;
using LDCGESTTA.Entities;
using LDCGESTTA.UI;
using LDCGESTTA.BL;

namespace LDCGESTTA
{
    public class callLDC_GESTTA : IOpenExecutable
    {
        private BLLDC_GESTTA blLDC_FCVC = new BLLDC_GESTTA();

        public void Execute(Dictionary<string, object> parameters)
        {
            using (LDC_GESTTA frm = new LDC_GESTTA())
            {
                frm.ShowDialog();
            }
        }

    }
}
