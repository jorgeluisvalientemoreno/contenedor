using System;
using System.Collections.Generic;
using System.Text;

//
using OpenSystems.Common.Interfaces;
using SINCECOMP.GESTIONORDENES.UI;
using SINCECOMP.GESTIONORDENES.DAL;

namespace SINCECOMP.GESTIONORDENES
{        
    //class callLDCGESORD
    //{
    //}

    public class callLEGO : IOpenExecutable
    {
        SINCECOMP.GESTIONORDENES.DAL.DALGENERAL oDALgeneral = new SINCECOMP.GESTIONORDENES.DAL.DALGENERAL();

        public void Execute(Dictionary<string, object> parameters)
        {
            Int64 VFnuExisteFuncional;
            VFnuExisteFuncional = DALLEGO.FnuExisteFuncional();
            if (VFnuExisteFuncional > 0)
            {
                using (LEGO frm = new LEGO())
                {
                    frm.ShowDialog();
                }
            }
            else
            {
                oDALgeneral.mensajeERROR("El funcionario no esta confirgurado en LDCLEGO");
            }
        }
    }
}
