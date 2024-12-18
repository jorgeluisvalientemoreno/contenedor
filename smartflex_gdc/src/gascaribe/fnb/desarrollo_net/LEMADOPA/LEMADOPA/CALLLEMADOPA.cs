using System;
using System.Collections.Generic;
using System.Text;
//LIBRERIAS OPEN
using OpenSystems.Common.Interfaces;
//LIBRERIAS DEL PROYECTO
using LEMADOPA.UI;

namespace LEMADOPA
{
    public class CALLLEMADOPA : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (UI.LEMADOPA frm = new UI.LEMADOPA())
            {
                frm.ShowDialog();
            }
        }
    }
}
