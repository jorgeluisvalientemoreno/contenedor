using System;
using System.Collections.Generic;
using System.Text;

//Libreias OPEN
using OpenSystems.Common.Interfaces;
using BSS.TARIFATRANSITORIA.UI;

namespace BSS.TARIFATRANSITORIA
{
    public class callLDCSNATT : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {

            using (LDCSNATT frm = new LDCSNATT())
            {
                frm.ShowDialog();
            }
        }
    }
}
