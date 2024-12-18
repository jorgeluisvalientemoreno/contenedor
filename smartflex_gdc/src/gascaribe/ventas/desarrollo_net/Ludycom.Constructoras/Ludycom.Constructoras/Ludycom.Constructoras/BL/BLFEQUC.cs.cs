using System;
using System.Collections.Generic;
using System.Text;
using Ludycom.Constructoras.DAL;
using Ludycom.Constructoras.ENTITIES;
using System.Data;

namespace Ludycom.Constructoras.BL
{
    class BLFEQUC
    {
        DALFEQUC dalFEQUC = new DALFEQUC();

        /// <summary>
        /// Se obtienen los datos básicos de la solicitud de venta constructora
        /// </summary>
        /// <param name="project">id del proyecto</param>
        /// <returns>Retorna una instancia de RequestBasicData con los datos básicos de la solicitud</returns>
        public RequestBasicData GetRequestBasicData(Int64 project)
        {
            return dalFEQUC.GetRequestBasicData(project);
        }

        /// <summary>
        /// Se obtienen las unidades prediales
        /// </summary>
        /// <param name="project">Id del proyecto</param>
        /// <returns>Retorna una tabla de datos con las unidades prediales</returns>               
        public List<PropUnit> GetPropUnits(Int64 project)
        {
            List<PropUnit> propUnitList = new List<PropUnit>();
            DataTable dtpropUnits = dalFEQUC.GetPropUnits(project);

            foreach (DataRow item in dtpropUnits.Rows)
            {
                PropUnit tmpPropUnit = new PropUnit(item);
                propUnitList.Add(tmpPropUnit);
            }
            return propUnitList;
        }

        /// <summary>
        /// Se obtienen las direcciones creadas a partir de la venta constructora
        /// </summary>
        /// <param name="request">Id de la solicitud</param>
        /// <returns>Retorna una tabla de datos con las direcciones</returns>               
        public List<PropUnitEquivalence> GetAddresses(Int64 request)
        {
            List<PropUnitEquivalence> propUnitEquivalencesList = new List<PropUnitEquivalence>();
            DataTable dtPropUnitEquivalences = dalFEQUC.GetAddresses(request);

            foreach (DataRow item in dtPropUnitEquivalences.Rows)
            {
                PropUnitEquivalence tmpPropUnitEquivalences = new PropUnitEquivalence(item);
                propUnitEquivalencesList.Add(tmpPropUnitEquivalences);
            }

            return propUnitEquivalencesList;
        }

        /// <summary>
        /// Se establecen las equivalencias por unidad predial
        /// </summary>
        /// <param name="request">id de la solicitud</param>
        /// <param name="propUnitEquivalence">Instancia de PropUnitEquivalence</param>
        public void SetPropUnitEquivalence(Int64 request, PropUnitEquivalence propUnitEquivalence)
        {
            dalFEQUC.SetPropUnitEquivalence(request, propUnitEquivalence);
        }

    }
}
