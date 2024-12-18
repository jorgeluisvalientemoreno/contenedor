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
    class DALFDMPC
    {
        Int64? nullValue = null;
        DateTime? nullDate = null;

        /// <summary>
        /// Se valida si el proyecto existe
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna un valor booleano indicando la existencia del proyecto</returns>
        public Boolean ProjectExists(Int64 projectId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("daldc_proyecto_constructora.fblExist"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUID_PROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }

        /// <summary>
        /// Se valida si al proyecto se le registró la venta
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna un valor booleano indicando si el proyecto ya tiene la venta registrada</returns>
        public Boolean ProjectHasSale(Int64 projectId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcVentaConstructora.fblProyectoConVenta"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }

        /// <summary>
        /// Se valida si al proyecto se le definió la equivalencia por unidades prediales
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna un valor booleano indicando si al proyecto se le definió la equivalencia por unidades prediales</returns>
        public Boolean DefinedEquivalence(Int64 projectId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcVentaConstructora.fblEquivalenciaRegistrada"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }

        /// <summary>
        /// Se obtiene la forma de pago del proyecto
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna la forma de pago del proyecto</returns>
        public String GetPaymentModality(Int64 projectId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcVentaConstructora.fsbFormaPagoDeProyecto"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se obtiene el código del cliente dado el proyecto
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna el id del cliente</returns>
        public Int64 GetProjectCustomer(Int64 projectId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("daldc_proyecto_constructora.fnuGetcliente"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUID_PROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "INURAISEERROR", DbType.Int16, 0);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se obtiene el código del contrato dado el proyecto
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna el id del contrato</returns>
        public Int64? GetProjectSubscription(Int64 projectId)
        {
            Int64? nullValue = null;
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("daldc_proyecto_constructora.fnuGetSUSCRIPCION"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUID_PROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "INURAISEERROR", DbType.Int16, 0);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"))) ? nullValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE")); 
            }
        }

        /// <summary>
        /// Se obtienen los datos básicos del proyecto
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna una instancia de ProjectBasicData con los datos básicos del proyecto/returns>
        public ProjectBasicData GetProjectBasicData(Int64 projectId)
        {
            ProjectBasicData projectBasicData = new ProjectBasicData();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcproyectoconstructora.prodatosproyecto"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBNOMBRE", DbType.String, 500);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBOBSERVACION", DbType.String, 2000);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUDIRECCION", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONULOCALIDAD", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUFECHACREACION", DbType.DateTime, 80);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUFECHAULTMODIF", DbType.DateTime, 80);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUPISOS", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUTORRES", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUTIPOSUNIDPRED", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUTOTALAPTOS", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUCONTRATO", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUPAGARE", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBFORMAPAGO", DbType.String, 100);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUTIPOVIVIENDA", DbType.Int64, 3);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBERROR", DbType.String, 2000);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                projectBasicData.ProjectName = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBNOMBRE"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBNOMBRE"));
                projectBasicData.Comment = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBOBSERVACION"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBOBSERVACION"));
                projectBasicData.AddressId = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUDIRECCION"))) ? nullValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUDIRECCION"));
                projectBasicData.LocationId = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONULOCALIDAD"))) ? nullValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONULOCALIDAD"));
                projectBasicData.RegisterDate = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUFECHACREACION").ToString()) ? nullDate : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUFECHACREACION").ToString());
                projectBasicData.LastModDate = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUFECHAULTMODIF").ToString()) ? nullDate : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUFECHAULTMODIF").ToString()); 
                projectBasicData.Floors = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUPISOS").ToString());
                projectBasicData.Towers = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUTORRES").ToString());
                projectBasicData.UnitsPropTypes = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUTIPOSUNIDPRED").ToString());
                projectBasicData.UnitsPropTotal = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUTOTALAPTOS").ToString());
                projectBasicData.Contract = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCONTRATO"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCONTRATO"));
                projectBasicData.PrommissoryNote = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUPAGARE"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUPAGARE"));
                projectBasicData.PaymentModality = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBFORMAPAGO"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBFORMAPAGO"));
                projectBasicData.TenementType = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUTIPOVIVIENDA"))) ? nullValue : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUTIPOVIVIENDA"));

                return projectBasicData;
            }
        }

        /// <summary>
        /// Método para obtener el tipo de construcción de un proyecto
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna un valor numérico con el tipo de construcción</returns>
        public Int32 GetBuildingType(Int64 projectId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("daldc_proyecto_constructora.fnuGetTIPO_CONSTRUCCION"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUID_PROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int32, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt32(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
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
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_BCProyectoConstructora.fnuUnidadesPorPisoYTipo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPISO", DbType.Int32, floorId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPO", DbType.Int32, propUnitTypeId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Método para obtener el número de unidades prediales por torre
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        public Int64 GetPropUnitAmountPerTower(Int64 projectId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_BCProyectoConstructora.fnuUnidadesPorTorre"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se valida si el proyecto tiene cotizaciones detalladas
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna un valor booleano dependiendo si existen o no cotizaciones para el proyecto</returns>
        public Boolean QuotationsExist(Int64 projectId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcproyectoconstructora.fbltienecotizaciones"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }

        /// <summary>
        /// Se obtiene el metraje por tipo de unidad predial
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna una tabla de datos con el metraje por tipo de unidad predial</returns>
        public DataTable GetLengthPerPropUnitType(Int64 projectId)
        {
            DataSet dsLengthPerPropUnitType = new DataSet("LengthPerPropUnitType");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcproyectoconstructora.fcrmetrajesxtipounid"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsLengthPerPropUnitType, "LengthPerPropUnitType");
            }
            return dsLengthPerPropUnitType.Tables["LengthPerPropUnitType"];
        }


        /// <summary>
        /// Se obtiene el metraje por piso
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        /// <returns>Retorna una tabla de datos con el metraje por piso</returns>
        public DataTable GetLengthPerFloor(Int64 projectId)
        {
            DataSet dsLengthPerFloor = new DataSet("LengthPerFloor");
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bcproyectoconstructora.fcrmetrajesxpiso"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsLengthPerFloor, "LengthPerFloor");
            }
            return dsLengthPerFloor.Tables["LengthPerFloor"];
        }

        /// <summary>
        /// Método para borrar datos del proyecto
        /// </summary>
        /// <param name="projectId">Código del Proyecto</param>
        public void DeleteProjectData(Int64 projectId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_BoProyectoConstructora.proBorraProyecto"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para actualizar datos básicos del proyecto
        /// </summary>
        /// <param name="projectBasicData">Datos básicos</param>
        public void UpdateProjectBasicData(ProjectBasicData projectBasicData, Int64 tenementType)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_BoProyectoConstructora.proModifDatosBasicosProyecto"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectBasicData.ProjectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBNOMBRE", DbType.String, projectBasicData.ProjectName);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBDESCRIPCION", DbType.String, projectBasicData.Comment);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULOCALIDAD", DbType.Int64, projectBasicData.LocationId == 0 ? null : projectBasicData.LocationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBFORMAPAGO", DbType.String, projectBasicData.PaymentModality);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUDIRECCION", DbType.Int64, Convert.ToString(projectBasicData.AddressId) == "" ? null : projectBasicData.AddressId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOVIVIENDA", DbType.Int64, tenementType);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para actualizar definición del proyecto
        /// </summary>
        /// <param name="projectBasicData">Definición del proyetcto</param>
        public void UpdateProjectDefinition(ProjectBasicData projectBasicData)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_BoProyectoConstructora.proModifDefinicionProyecto"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectBasicData.ProjectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTTORRES", DbType.Int64, projectBasicData.Towers);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTPISOS", DbType.Int64, projectBasicData.Floors);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTTIPO", DbType.Int64, projectBasicData.UnitsPropTypes);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTUNID", DbType.Int64, projectBasicData.UnitsPropTotal);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para crear definición del proyecto
        /// </summary>
        /// <param name="projectBasicData">Definición del proyetcto</param>
        public void RegisterProjectDefinition(ProjectBasicData projectBasicData)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_BoProyectoConstructora.proCreaDefinicionProyecto"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectBasicData.ProjectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOCONSTRUCCION", DbType.Int64, projectBasicData.BuildingType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTPISOS", DbType.Int64, projectBasicData.Floors);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTTIPUNIDPRED", DbType.Int64, projectBasicData.UnitsPropTypes);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTTORRES", DbType.Int64, projectBasicData.Towers);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBERROR", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para actualizar el metraje por tipo de unidad predial
        /// </summary>
        /// <param name="lengthPerPropUnitType">Datos del metraje</param>
        public void ModifyLengthPerPropUnitType(LengthPerPropUnitType lengthPerPropUnitType)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_BoProyectoConstructora.proModifMetrajXTipoUnidPredial"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, lengthPerPropUnitType.Project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPO", DbType.Int32, lengthPerPropUnitType.PropUnitTypeId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUFLAUTA", DbType.Double, lengthPerPropUnitType.Flute);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUHORNO", DbType.Double, lengthPerPropUnitType.Oven);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUBBQ", DbType.Double, lengthPerPropUnitType.BBQ);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUESTUFA", DbType.Double, lengthPerPropUnitType.Stove);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUSECADORA", DbType.Double, lengthPerPropUnitType.Dryer);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCALENTADOR", DbType.Double, lengthPerPropUnitType.Heater);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGVALBAJ", DbType.Double, lengthPerPropUnitType.LongValBaj);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGBAJTAB", DbType.Double, lengthPerPropUnitType.LongBajTabl);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGTABLERO", DbType.Double, lengthPerPropUnitType.LongTab);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para actualizar el metraje por piso
        /// </summary>
        /// <param name="lengthPerFloor">Datos del metraje</param>
        public void ModifyLengthPerFloor(LengthPerFloor lengthPerFloor)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_BoProyectoConstructora.proModifMetrajeXpiso"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, lengthPerFloor.Project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPISO", DbType.Int32, lengthPerFloor.Floor);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGBAJANTE", DbType.Double, lengthPerFloor.LongBaj);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }


    }
}

