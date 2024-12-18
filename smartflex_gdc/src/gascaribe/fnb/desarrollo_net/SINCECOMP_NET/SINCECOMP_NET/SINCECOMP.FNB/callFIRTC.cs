using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using SINCECOMP.FNB.UI;
using System.Windows.Forms;

namespace SINCECOMP.FNB
{
    public class callFIRTC : IOpenExecutable 
    {
        FIRTC _FIRTC = new FIRTC();

        public void Execute(Dictionary<string, object> parameters)
        {
            String Oper;
            String[] informationUser = SINCECOMP.FNB.BL.BLFIRTC.getInformatioUser();
            Oper = informationUser[0];

            if (Oper == "A" || Oper == "R")
            {
                using (FIRTC frm = new FIRTC())
                {
                    frm.ShowDialog();
                }
            }
            else
            {
                SINCECOMP.FNB.BL.BLGENERAL general = new BL.BLGENERAL();
                general.mensajeERROR("Usuario no configurado para utilizar las funciones de esta forma");
                return;
            }
        }

    }
}
