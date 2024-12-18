using System;
using System.Collections.Generic;
using System.Text;
using Ludycom.Constructoras.ENTITIES;
using Ludycom.Constructoras.DAL;

namespace Ludycom.Constructoras.BL
{
    class BLFDCPC
    {

        DALFDCPC dalFDCPC = new DALFDCPC();

        /// <summary>
        /// Se obtienen los datos básicos del cliente
        /// </summary>
        /// <param name="subscriber">Código del Cliente</param>
        /// <returns>Retorna una instancia de CustomerBasicData con los datos básicos del cliente</returns>
        /// <changelog>
        /// Historia de Modificaciones
        /// Fecha       Autor                  Modificacion	
        /// =========   =========              =====================================
        /// 11-05-2016  KCienfuegos            1 - creación                   
        /// </changelog>
        public CustomerBasicData GetCustomerBasicData(Int64 subscriber)
        {
            return dalFDCPC.GetCustomerBasicData(subscriber);
        }

        /// <summary>
        /// Se registran los datos Básicos del Proyecto
        /// </summary>
        /// <param name="projectName">Nombre del Proyecto</param>
        /// <param name="description">Descripción del Proyecto</param>
        /// <param name="subscriber">Código del Cliente</param>
        /// <param name="buildingType">Tipo de Construcción</param>
        /// <param name="floorsQuantity">Cantidad de pisos</param>
        /// <param name="towersQuantity">Cantidad de torres</param>
        /// <param name="aparmTypeQuant">Cantidad de tipos de apartamentos</param>
        /// <param name="location">Localidad del proyecto</param>
        /// <param name="address">Dirección del proyecto</param>
        /// <returns>Retorna el código del proyecto</returns>
        public Int64? RegisterProjectBasicData(String projectName, String description, Int64 subscriber, Int64 buildingType,
                                               Int64 floorsQuantity, Int64 towersQuantity, Int64 aparmTypeQuant,
                                               Int64? location, Int64? address, Int64? originProjectId, Int64 tenementType)
        {
            return dalFDCPC.RegisterProjectBasicData(projectName, description, subscriber, buildingType,
                                                    floorsQuantity, towersQuantity, aparmTypeQuant, location, address, originProjectId, tenementType);
        }

        /// <summary>
        /// Se registra el metraje por tipo de unidad predial
        /// </summary>
        /// <param name="lengthPerPropUnitType">Instancia de LengthPerPropUnitType</param>
        public void RegisterLengthPerPropUnitType(LengthPerPropUnitType lengthPerPropUnitType)
        {

            dalFDCPC.RegisterLengthPerPropUnitType(lengthPerPropUnitType);
        }

        /// <summary>
        /// Se registra el metraje por piso
        /// </summary>
        /// <param name="lengthPerFloor">Instancia de LengthPerFloor</param>
        public void RegisterLengthPerFloor(LengthPerFloor lengthPerFloor)
        {
            dalFDCPC.RegisterLengthPerFloor(lengthPerFloor);
        }

        /// <summary>
        /// Se registran las unidades prediales
        /// </summary>
        /// <param name="projectId">Id del Proyecto</param>
        /// <param name="floorId">Id piso</param>
        /// <param name="towerQuantity">Cantidad de Torres</param>
        /// <param name="unitTypeId">Id del tipo de unidad predial</param>
        /// <param name="propQuantity">Cantidad de unidades prediales</param>
        public void RegisterPropUnits(Int64 projectId, Int64 floorId, Int64 towerQuantity, Int64 unitTypeId, Int64 propQuantity)
        {
            dalFDCPC.RegisterPropUnits(projectId, floorId, towerQuantity, unitTypeId, propQuantity);
        }
    }
}
