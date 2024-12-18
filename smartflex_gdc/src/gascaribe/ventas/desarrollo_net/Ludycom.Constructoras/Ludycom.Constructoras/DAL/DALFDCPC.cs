using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using OpenSystems.EnterpriseLibrary;
using Ludycom.Constructoras.ENTITIES;

namespace Ludycom.Constructoras.DAL
{
    class DALFDCPC
    {
        Int64? nullValue = null;

        /// <summary>
        /// Se obtienen los datos básicos del cliente
        /// </summary>
        /// <param name="subscriber">Código del Cliente</param>
        /// <returns>Retorna una instancia de CustomerBasicData con los datos básicos del cliente</returns>
        public CustomerBasicData GetCustomerBasicData(Int64 subscriber)
        {
            CustomerBasicData customerBasicData = new CustomerBasicData();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_BCproyectoConstructora.proDatosCliente"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCLIENTE", DbType.Int64, subscriber);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUTIPOIDENTIFICACION", DbType.Int64, 4);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBNROIDENTIFICACION", DbType.String, 500);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBNOMBRE", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                customerBasicData.IdentificationType = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUTIPOIDENTIFICACION"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUTIPOIDENTIFICACION"));
                customerBasicData.Identification = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBNROIDENTIFICACION"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBNROIDENTIFICACION"));
                customerBasicData.CustomerName = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBNOMBRE"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBNOMBRE"));
               
                return customerBasicData;
            }
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
            Int64? result;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boproyectoconstructora.procreaproyecto"))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTOORIGEN", DbType.Int64, string.IsNullOrEmpty(originProjectId.ToString())?nullValue:originProjectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBNOMBRE", DbType.String, projectName);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBDESCRIPCION", DbType.String, string.IsNullOrEmpty(description)? "": description);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCLIENTE", DbType.Int64, subscriber);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOCONSTRUCCION", DbType.Int64, buildingType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTPISOS", DbType.Int64, floorsQuantity);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTTORRES", DbType.Int64, towersQuantity);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTTIPUNIDPRED", DbType.Int64, aparmTypeQuant);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULOCALIDAD", DbType.Int64, string.IsNullOrEmpty(location.ToString()) ? nullValue : location);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUDIRECCION", DbType.Int64, string.IsNullOrEmpty(address.ToString()) ? nullValue : address);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOVIVIENDA", DbType.Int64, tenementType);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUPROYECTO", DbType.Int64, 20);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                result = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUPROYECTO"))) ? nullValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUPROYECTO"));

                return result;
            }
        }


        /// <summary>
        /// Se registra el metraje por tipo de unidad predial
        /// </summary>
        /// <param name="lengthPerPropUnitType">Instancia de LengthPerPropUnitType</param>
        public void RegisterLengthPerPropUnitType(LengthPerPropUnitType lengthPerPropUnitType)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boproyectoconstructora.procreametrajextipounidpredial"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, lengthPerPropUnitType.Project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOUNIDPREDIAL", DbType.Int64, lengthPerPropUnitType.PropUnitTypeId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUFLAUTA", DbType.Double, lengthPerPropUnitType.Flute);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUHORNO", DbType.Double, lengthPerPropUnitType.Oven);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUBBQ", DbType.Double, lengthPerPropUnitType.BBQ);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUESTUFA", DbType.Double, lengthPerPropUnitType.Stove);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUSECADORA", DbType.Double, lengthPerPropUnitType.Dryer);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCALENTADOR", DbType.Double, lengthPerPropUnitType.Heater);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGVALBAJANTE", DbType.Double, lengthPerPropUnitType.LongValBaj);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGBAJANTETABL", DbType.Double, lengthPerPropUnitType.LongBajTabl);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGTABLERO", DbType.Double, lengthPerPropUnitType.LongTab);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se registra el metraje por piso
        /// </summary>
        /// <param name="lengthPerFloor">Instancia de LengthPerFloor</param>
        public void RegisterLengthPerFloor(LengthPerFloor lengthPerFloor)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boproyectoconstructora.proCreaMetrajeXpiso"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPISO", DbType.Int64, lengthPerFloor.Floor);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, lengthPerFloor.Project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGBAJANTE", DbType.Double, lengthPerFloor.LongBaj);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
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
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boproyectoconstructora.procreaunidadesprediales"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPISO", DbType.Int64, floorId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTORRE", DbType.Int64, towerQuantity);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOUNIDAD", DbType.Int64, unitTypeId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTUNIDADES", DbType.Int64, propQuantity);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

    }
}
