using System;
using System.Collections.Generic;
using System.Text;
using Ludycom.Constructoras.ENTITIES;
using Ludycom.Constructoras.DAL;
using System.Data;

namespace Ludycom.Constructoras.BL
{
    class BLFDMPC
    {

        DALFDMPC dalFDMPC = new DALFDMPC();

        /// <summary>
        /// Se valida si el proyecto existe
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna un valor booleano indicando la existencia del proyecto</returns>
        public Boolean ProjectExists(Int64 projectId)
        {
            return dalFDMPC.ProjectExists(projectId);
        }

        /// <summary>
        /// Se valida si el proyecto existe
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna un valor booleano indicando si el proyecto ya tiene la venta registrada</returns>
        public Boolean ProjectHasSale(Int64 projectId)
        {
            return dalFDMPC.ProjectHasSale(projectId);
        }

        /// <summary>
        /// Se valida si al proyecto se le definió la equivalencia por unidades prediales
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna un valor booleano indicando si al proyecto se le definió la equivalencia por unidades prediales</returns>
        public Boolean DefinedEquivalence(Int64 projectId)
        {
            return dalFDMPC.DefinedEquivalence(projectId);
        }

        /// <summary>
        /// Se obtiene la forma de pago del proyecto
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna la forma de pago del proyecto</returns>
        public String GetPaymentModality(Int64 projectId)
        {
            return dalFDMPC.GetPaymentModality(projectId);
        }

         /// <summary>
        /// Se obtiene el código del cliente dado el proyecto
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna el id del cliente</returns>
        public Int64 GetProjectCustomer(Int64 projectId)
        {
            return dalFDMPC.GetProjectCustomer(projectId);
        }

        /// <summary>
        /// Se obtiene el código del contrato dado el proyecto
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna el id del contrato</returns>
        public Int64? GetProjectSubscription(Int64 projectId)
        {
            return dalFDMPC.GetProjectSubscription(projectId);
        }

        /// <summary>
        /// Se obtienen los datos básicos del proyecto
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna una instancia de ProjectBasicData con los datos básicos del proyecto/returns>
        public ProjectBasicData GetProjectBasicData(Int64 projectId)
        {
            return dalFDMPC.GetProjectBasicData(projectId);
        }

        /// <summary>
        /// Método para obtener el tipo de construcción de un proyecto
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna un valor numérico con el tipo de construcción</returns>
        public Int32 GetBuildingType(Int64 projectId)
        {
            return dalFDMPC.GetBuildingType(projectId);
        }

                /// <summary>
        /// Método para obtener el número de unidades prediales por piso y tipo
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <param name="floorId">Código del Piso</param>
        /// <param name="propUnitTypeId">Código del Tipo</param>
        /// <returns>Retorna un valor numérico con la cantidad de unidades prediales</returns>
        public Int64 GetPropUnitPerFloorAndUnitType(Int64 projectId, Int32 floorId, Int32 propUnitTypeId)
        {
            return dalFDMPC.GetPropUnitPerFloorAndUnitType(projectId, floorId, propUnitTypeId);
        }

        /// <summary>
        /// Método para obtener el número de unidades prediales por torre
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        public Int64 GetPropUnitAmountPerTower(Int64 projectId)
        {
            return dalFDMPC.GetPropUnitAmountPerTower(projectId);
        }

        /// <summary>
        /// Se valida si el proyecto tiene cotizaciones detalladas
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna un valor booleano dependiendo si existen o no cotizaciones para el proyecto</returns>
        public Boolean QuotationsExist(Int64 projectId)
        {
            return dalFDMPC.QuotationsExist(projectId);
        }

        /// <summary>
        /// Se obtiene el metraje por tipo de unidad predial
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna una tabla de datos con el metraje por tipo de unidad predial</returns>
        public List<LengthPerPropUnitType> GetLengthPerPropUnitType(Int64 projectId)
        {
            List<LengthPerPropUnitType> lengthPerPropUnitTypeList = new List<LengthPerPropUnitType>();
            DataTable dtLengthPerPropUnitType = dalFDMPC.GetLengthPerPropUnitType(projectId);

            foreach (DataRow item in dtLengthPerPropUnitType.Rows)
            {
                LengthPerPropUnitType tmpLengthPerPropUnitType = new LengthPerPropUnitType(item);
                lengthPerPropUnitTypeList.Add(tmpLengthPerPropUnitType);
            }

            return lengthPerPropUnitTypeList;
        }

        /// <summary>
        /// Se obtiene el metraje por piso
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna una lista con los datos del metraje por piso</returns>
        public List<LengthPerFloor> GetLengthPerFloor(Int64 projectId)
        {
            List<LengthPerFloor> lengthPerFloorList = new List<LengthPerFloor>();
            DataTable dtLengthPerFloor = dalFDMPC.GetLengthPerFloor(projectId);

            foreach (DataRow item in dtLengthPerFloor.Rows)
            {
                LengthPerFloor tmpLengthPerFloor = new LengthPerFloor(item);
                lengthPerFloorList.Add(tmpLengthPerFloor);
            }

            return lengthPerFloorList;
        }

        
        /// <summary>
        /// Método para borrar datos del proyecto
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        public void DeleteProjectData(Int64 projectId)
        {
            dalFDMPC.DeleteProjectData(projectId);
        }

        /// <summary>
        /// Método para actualizar el metraje por tipo de unidad predial
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <param name="projectBasicData">Datos básicos</param>
        public void UpdateProjectBasicData(ProjectBasicData projectBasicData, Int64 tenementType)
        {
            dalFDMPC.UpdateProjectBasicData(projectBasicData, tenementType);
        }

        /// <summary>
        /// Método para actualizar definición del proyecto
        /// </summary>
        /// <param name="projectBasicData">Definición del proyetcto</param>
        public void UpdateProjectDefinition(ProjectBasicData projectBasicData)
        {
            dalFDMPC.UpdateProjectDefinition(projectBasicData);
        }

        /// <summary>
        /// Método para crear definición del proyecto
        /// </summary>
        /// <param name="projectBasicData">Definición del proyetcto</param>
        public void RegisterProjectDefinition(ProjectBasicData projectBasicData)
        {
            dalFDMPC.RegisterProjectDefinition(projectBasicData);
        }

        /// <summary>
        /// Método para actualizar el metraje por tipo de unidad predial
        /// </summary>
        /// <param name="lengthPerPropUnitType">Datos del metraje</param>
        public void ModifyLengthPerPropUnitType(LengthPerPropUnitType lengthPerPropUnitType)
        {
            dalFDMPC.ModifyLengthPerPropUnitType(lengthPerPropUnitType);
        }

        /// <summary>
        /// Método para actualizar el metraje por piso
        /// </summary>
        /// <param name="lengthPerFloor">Datos del metraje</param>
        public void ModifyLengthPerFloor(LengthPerFloor lengthPerFloor)
        {
            dalFDMPC.ModifyLengthPerFloor(lengthPerFloor);
        }
    }
}
