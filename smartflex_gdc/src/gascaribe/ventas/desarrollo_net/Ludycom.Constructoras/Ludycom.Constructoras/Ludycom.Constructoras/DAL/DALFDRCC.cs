using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using Ludycom.Constructoras.ENTITIES;

namespace Ludycom.Constructoras.DAL
{
    class DALFDRCC
    {

        Double? nullValueDouble = null;
        Int32? nullValue32 = null;
        DateTime? nullDate = null;
        //Int64? nullValue64 = null;

        /// <summary>
        /// Se obtienen los ítems de la lista de precios
        /// </summary>
        /// <param name="listPriceId">Id de la lista de precios</param>
        /// <returns>Retorna una tabla de datos con los items</returns>               
        public DataTable GetPriceListItems(Int64 listPriceId)
        {
            DataSet dsItems = new DataSet("Items");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fcritemsfijos"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INULISTAPRECIOS", DbType.Int64, listPriceId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsItems, "Items");
            }
            return dsItems.Tables["Items"];
        }

        /// <summary>
        /// Se obtienen los ítems de la lista de precios
        /// </summary>
        /// <returns>Retorna una tabla de datos con los items por tipo de trabajo</returns>               
        public DataTable GetItemsByTaskType()
        {
            DataSet dsItemsTaskType = new DataSet("ItemsTipoTrab");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fcrItemsTipoTrab"))
            {
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsItemsTaskType, "ItemsTipoTrab");
            }
            return dsItemsTaskType.Tables["ItemsTipoTrab"];
        }

        /// <summary>
        /// Se valida si la cotización existe
        /// </summary>
        /// <param name="quotationId">Consecutivo de la cotización</param>
        /// <returns>Retorna un valor booleano indicando la existencia de la cotización</returns>
        public Boolean QuotationExists(Int64 quotationId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fblexistecotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONUNICO", DbType.Int64, quotationId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Boolean, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return (bool)OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
            }
        }

        /// <summary>
        /// Se obtiene el proyecto asociado a la cotización
        /// </summary>
        /// <param name="quotationId">Consecutivo de la cotización</param>
        /// <returns>Retorna el id del proyecto</returns>
        public Int64 GetProjectOfQuotation(Int64 quotationId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fnuproyecto"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCONSECCOTIZACION", DbType.Int64, quotationId);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se obtiene el porcentaje de IVA de la instalación interna
        /// </summary>
        /// <returns>Retorna el porcentaje de IVA de la instalación interna</returns>
        public Double GetPercentIntInstallation()
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fnuObtieneIVAInstInterna"))
            {
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Double, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        /// <summary>
        /// Se obtienen los datos básicos de la cotización
        /// </summary>
        /// <param name="quotationId">Consecutivo de la cotización</param>
        /// <returns>Retorna una instancia de QuotationBasicData con los datos básicos de la cotización</returns>
        public QuotationBasicData GetQuotationBasicData(Int64 quotationId)
        {
            QuotationBasicData quotationBasicData = new QuotationBasicData();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.prodatoscotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCONSECCOTIZACION", DbType.Int64, quotationId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUCOTIZACIONDETALLADA", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONULISTAPRECIOS", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ODTFECHAVIGENCIA", DbType.DateTime, 80);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBFORMAPAGO", DbType.String, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUVALORCOTIZADO", DbType.Double, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUESTADO", DbType.String, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBOBSERVACION", DbType.String, 4000);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ODTFECHAREGISTRO", DbType.DateTime, 80);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ODTFECHAULTMODIF", DbType.DateTime, 80);
                //INICIO CA 200-2022
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUPLANCOMERESP", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUUNIDADINSTA", DbType.Int64, 50);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUUNIDADCERTI", DbType.Int64, 50);
                //FIN CA 200-2022
                //INICIO CA 153
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBFLAGGOGA", DbType.String, 50);
                //FIN INICIO 153
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                


                quotationBasicData.Consecutive = Convert.ToInt16(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUCOTIZACIONDETALLADA"));
                quotationBasicData.CostList = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONULISTAPRECIOS"))) ? nullValue32 : Convert.ToInt32(OpenDataBase.db.GetParameterValue(cmdCommand, "ONULISTAPRECIOS"));
                quotationBasicData.ValidityDate = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTFECHAVIGENCIA").ToString()) ? nullDate : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTFECHAVIGENCIA").ToString());
                quotationBasicData.Status = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUESTADO"));
                quotationBasicData.RegisterDate = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTFECHAREGISTRO").ToString()) ? nullDate : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTFECHAREGISTRO").ToString());
                quotationBasicData.LastModDate = string.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTFECHAULTMODIF").ToString()) ? nullDate : Convert.ToDateTime(OpenDataBase.db.GetParameterValue(cmdCommand, "ODTFECHAULTMODIF").ToString());
                quotationBasicData.PaymentModality = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBFORMAPAGO"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBFORMAPAGO"));
                quotationBasicData.Comment = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBOBSERVACION"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBOBSERVACION"));
                quotationBasicData.QuotedValue = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUVALORCOTIZADO"))) ? nullValueDouble : Convert.ToDouble(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUVALORCOTIZADO").ToString());
                //INICIO CA 200-2022
                quotationBasicData.PlanComercEsp = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUPLANCOMERESP"))) ? nullValue32 : Convert.ToInt32(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUPLANCOMERESP"));
                quotationBasicData.UnidadInstaladora = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUUNIDADINSTA"))) ? nullValue32 : Convert.ToInt32(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUUNIDADINSTA"));
                quotationBasicData.UnidadCertificadora = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUUNIDADCERTI"))) ? nullValue32 : Convert.ToInt32(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUUNIDADCERTI"));
                //FI CA 200-2022
                //INICIO 153
                quotationBasicData.Flagaso = string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBFLAGGOGA"))) ? "" : Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBFLAGGOGA"));
                
                //FIN 153

                return quotationBasicData;
            }
        }

        /// <summary>
        /// Se registran los datos básicos de la cotización
        /// </summary>
        /// <param name="quotationBasicData">Instancia de la clase QuotationBasicData</param>
        public Int64 RegisterQuotationBasicData(QuotationBasicData quotationBasicData)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.proCreaCotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, quotationBasicData.ProjectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBOBSERVACION", DbType.String, quotationBasicData.Comment);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULISTA_COSTO", DbType.Int32, quotationBasicData.CostList == 0 ? null : quotationBasicData.CostList);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHAVIGENCIA", DbType.DateTime, quotationBasicData.ValidityDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALORCOTIZADO", DbType.Double, quotationBasicData.QuotedValue);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPLANCOMERCIAL", DbType.Int64, quotationBasicData.PlanComercEsp);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBFORMAPAGO", DbType.String, quotationBasicData.PaymentModality);
                //INICIO CA 200-2022
                OpenDataBase.db.AddInParameter(cmdCommand, "INUUNIDINSTA", DbType.Int64, quotationBasicData.UnidadInstaladora);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUUNIDADCERT", DbType.Int64, quotationBasicData.UnidadCertificadora);
                //FIN CA 200-2022
                //INICIO CA 153
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBFLAGGOGA", DbType.String, quotationBasicData.Flagaso);
                //FIN CA 153
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUID_COTIZACION_DETALLADA", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBERROR", DbType.String, 4000);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUID_COTIZACION_DETALLADA"))) ? 0 : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUID_COTIZACION_DETALLADA"));
            }
        }

        /// <summary>
        /// Se actualizan los datos básicos de la cotizacion
        /// </summary>
        /// <param name="quotationBasicData">Instancia de la clase QuotationBasicData</param>
        public void UpdateQuotationBasicData(QuotationBasicData quotationBasicData)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.proModifDatosBasicosCotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, quotationBasicData.ProjectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ID_COTIZACION_DETALLADA", DbType.Int64, quotationBasicData.Consecutive);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBOBSERVACION", DbType.String, quotationBasicData.Comment);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULISTA_COSTO", DbType.Int32, quotationBasicData.CostList == 0 ? null : quotationBasicData.CostList);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHAVIGENCIA", DbType.DateTime, quotationBasicData.ValidityDate);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALORCOTIZADO", DbType.Double, quotationBasicData.QuotedValue);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPLANCOMERCIAL", DbType.Int64, quotationBasicData.PlanComercEsp);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBFORMAPAGO", DbType.String, quotationBasicData.PaymentModality);
                //INICIO CA 200-2022
                OpenDataBase.db.AddInParameter(cmdCommand, "INUUNIDINSTA", DbType.Int64, quotationBasicData.UnidadInstaladora);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUUNIDADCERT", DbType.Int64, quotationBasicData.UnidadCertificadora);
                //FIN CA 200-2022
                //INICIO CA 153
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBFLAGGOGA", DbType.String, quotationBasicData.Flagaso);
                //FIN CA 153
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBERROR", DbType.String, 4000);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se actualizan los datos básicos del proyecto
        /// </summary>
        /// <param name="projectBasicData">Instancia de la clase ProjectBasicData</param>
        public void UpdateProjectData(ProjectBasicData projectBasicData)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_BOProyectoConstructora.proModificaContratoYPagare"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectBasicData.ProjectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBCONTRATO", DbType.String, projectBasicData.Contract);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBPAGARE", DbType.String, projectBasicData.PrommissoryNote);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se actualiza la fecha de vigencia
        /// </summary>
        /// <param name="quotation">Instancia de la clase QuotationBasicData</param>
        public void UpdateValidityDate(QuotationBasicData quotation)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("daldc_cotizacion_construct.updFECHA_VIGENCIA"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUID_COTIZACION_DETALLADA", DbType.Int64, quotation.Consecutive);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUID_PROYECTO", DbType.String, quotation.ProjectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTFECHA_VIGENCIA$", DbType.DateTime, quotation.ValidityDate);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se registran los tipos de trabajo por cotización
        /// </summary>
        /// <param name="taskTypeInfo">instancia de ConsolidatedQuotation</param>
        public void RegisterQuotationTaskType(ConsolidatedQuotation taskTypeInfo)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacionconstructora.proCreaTiposTrabajoxCot"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, taskTypeInfo.Quotation);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, taskTypeInfo.Project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.Int64, taskTypeInfo.TaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUITEM", DbType.Int64, taskTypeInfo.ItemdId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBTIPOTRAB", DbType.String, taskTypeInfo.TaskTypeAcron);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se actualizan los tipos de trabajo de la cotizacion
        /// </summary>
        /// <param name="quotationBasicData">Instancia de la clase QuotationBasicData</param>
        public void UpdateQuotationTaskType(QuotationTaskType quotationTaskType)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.proModifTiposTrabajo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "ID_COTIZACION_DETALLADA", DbType.Int64, quotationTaskType.QuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, quotationTaskType.Project);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBTIPOTRABDESC", DbType.String, quotationTaskType.TaskTypeClassif);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.Int64, quotationTaskType.TaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUACTIVIDAD", DbType.Int64, quotationTaskType.ItemId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBOPERATION", DbType.String, quotationTaskType.Operation);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBERROR", DbType.String, 4000);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se registran los items fijos
        /// </summary>
        /// <param name="quotationId">Secuencia de la cotización</param>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="itemId">Id del ítem</param>
        /// <param name="amount">Cantidad</param>
        /// <param name="price">Precio</param>
        /// <param name="itemType">Tipo de ítem FP:Fijos por Proyecto FU:Fijos por unidad predial</param>
        /// <param name="taskType">Tipo de trabajo</param>
        public void RegisterFixedItems(QuotationItem fixedItem)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacionconstructora.proCreaItemsFijos"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, fixedItem.QuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, fixedItem.ProjectId);
                //Caso 200-1640
                Int64 numberId = 0;
                String elemento = fixedItem.ItemId;
                if (elemento.Substring(elemento.Length - 1, 1).ToString() == "C" || elemento.Substring(elemento.Length - 1, 1).ToString() == "G")
                {
                    numberId = Int64.Parse(elemento.Substring(0, elemento.Length - 1).ToString());
                }
                else
                {
                    numberId = Int64.Parse(elemento);
                }
                //
                OpenDataBase.db.AddInParameter(cmdCommand, "INUITEM", DbType.Int64, numberId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTIDAD", DbType.Int16, fixedItem.Amount);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPRECIO", DbType.Double, fixedItem.Price);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOSTO", DbType.Double, fixedItem.Cost);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBTIPOITEM", DbType.String, fixedItem.ItemType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.Int64, fixedItem.TaskType);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBERROR", DbType.String, 4000);
                //
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se registran los valores fijos
        /// </summary>
        /// <param name="consecutive">consecutivo del registro</param>
        /// <param name="quotationId">Secuencia de la cotización</param>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="description">Descripción</param>
        /// <param name="amount">Cantidad</param>
        /// <param name="price">Precio</param>
        public void RegisterFixedValues(FixedValues fixedValue)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacionconstructora.proCreaValoresFijos"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUITEM", DbType.Int64, fixedValue.Consecutive);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, fixedValue.QuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, fixedValue.ProjectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBDESCRIPCION", DbType.String, fixedValue.Description);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTIDAD", DbType.Int16, fixedValue.Amount);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPRECIO", DbType.Double, fixedValue.Cost);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.Int64, fixedValue.TaskType);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBERROR", DbType.String, 4000);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se obtiene el metraje por tipo y piso a nivel de proyecto
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <returns>Retorna una tabla de datos con el metraje por tipo y piso</returns>               
        public DataTable GetLengthPerFloorPerPropUnitType(Int64 projectId)
        {
            DataSet dsLengthPerFloorPerPropUnitType = new DataSet("MetrajePorPisoYTipo");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fcrMetrajexPisoxTipoProy"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsLengthPerFloorPerPropUnitType, "MetrajePorPisoYTipo");
            }
            return dsLengthPerFloorPerPropUnitType.Tables["MetrajePorPisoYTipo"];
        }

        /// <summary>
        /// Se registran el metraje por piso y tipo
        /// </summary>
        /// <param name="lengthPerFloorPropUnitTypeObj">Instancia de la clase LengthPerFloorPerPropUnitType</param>
        public void RegisterLengthPerFloorPropUnitType(LengthPerFloorPerPropUnitType lengthPerFloorPropUnitTypeObj)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacionconstructora.proCreaMetrajeXPisoYTipo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, lengthPerFloorPropUnitTypeObj.QuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPISO", DbType.Int32, lengthPerFloorPropUnitTypeObj.Floor);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPO", DbType.Int32, lengthPerFloorPropUnitTypeObj.PropUnitTypeId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUFLAUTA", DbType.Double, lengthPerFloorPropUnitTypeObj.Flute);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUHORNO", DbType.Double, lengthPerFloorPropUnitTypeObj.Oven);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUBBQ", DbType.Double, lengthPerFloorPropUnitTypeObj.BBQ);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUESTUFA", DbType.Double, lengthPerFloorPropUnitTypeObj.Stove);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUSECADORA", DbType.Double, lengthPerFloorPropUnitTypeObj.Dryer);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCALENTADOR", DbType.Double, lengthPerFloorPropUnitTypeObj.Heater);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGVALBAJ", DbType.Double, lengthPerFloorPropUnitTypeObj.LongValBaj);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGBAJANTE", DbType.Double, lengthPerFloorPropUnitTypeObj.LongBaj);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGBAJTAB", DbType.Double, lengthPerFloorPropUnitTypeObj.LongBajTabl);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGTABLERO", DbType.Double, lengthPerFloorPropUnitTypeObj.LongTab);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, lengthPerFloorPropUnitTypeObj.Project);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBERROR", DbType.String, 4000);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se registran los ítems por metraje
        /// </summary>
        /// <param name="lengthPerFloorPropUnitTypeObj">Instancia de la clase ItemsPerLength</param>
        /// <param name="taskType">Tipo de trabajo</param>
        public void RegisterItemsPerLength(ItemsPerLength itemsPerLengthObj, Int64 taskType)
        {

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacionconstructora.proCreaItemsXMetraje"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACION", DbType.Int64, itemsPerLengthObj.QuotationId);
                //Caso 200-1640
                Int64 numberId = 0;
                String elemento = itemsPerLengthObj.ItemId;
                if (elemento.Substring(elemento.Length - 1, 1).ToString() == "C" || elemento.Substring(elemento.Length - 1, 1).ToString() == "G")
                {
                    numberId = Int64.Parse(elemento.Substring(0, elemento.Length - 1).ToString());
                }
                else
                {
                    numberId = Int64.Parse(elemento);
                }
                //
                OpenDataBase.db.AddInParameter(cmdCommand, "INUITEM", DbType.Int64, numberId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPRECIO", DbType.Double, itemsPerLengthObj.Price);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOSTO", DbType.Double, itemsPerLengthObj.Cost);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBFLAUTA", DbType.String, itemsPerLengthObj.Flute == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBBBQ", DbType.String, itemsPerLengthObj.BBQ == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBHORNO", DbType.String, itemsPerLengthObj.Oven == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBESTUFA", DbType.String, itemsPerLengthObj.Stove == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBSECADORA", DbType.String, itemsPerLengthObj.Dryer == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBCALENTADOR", DbType.String, itemsPerLengthObj.Heater == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBVALBAJANTE", DbType.String, itemsPerLengthObj.LongValBaj == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBLONGBAJANTE", DbType.String, itemsPerLengthObj.LongBaj == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBLONGBAJTABLERO", DbType.String, itemsPerLengthObj.LongBajTabl == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBLONGTABLERO", DbType.String, itemsPerLengthObj.LongTab == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, itemsPerLengthObj.Project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRABAJO", DbType.Int64, taskType);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBERROR", DbType.String, 4000);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se registran los ítems por unidad predial
        /// </summary>
        /// <param name="quotationItem">Instancia de la clase QuotationItem</param>
        public void RegisterItemsPerPropUnit(QuotationItem quotationItem)
        {
            Int64? nullValue = null;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacionconstructora.proCreaItemsUnidPredGenerico"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, quotationItem.ProjectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, quotationItem.QuotationId);
                //Caso 200-1640
                Int64 numberId = 0;
                String elemento = quotationItem.ItemId;
                if (elemento.Substring(elemento.Length - 1, 1).ToString() == "C" || elemento.Substring(elemento.Length - 1, 1).ToString() == "G")
                {
                    numberId = Int64.Parse(elemento.Substring(0, elemento.Length - 1).ToString());
                }
                else
                {
                    numberId = Int64.Parse(elemento);
                }
                //
                OpenDataBase.db.AddInParameter(cmdCommand, "INUITEM", DbType.Int64, numberId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.Int64, quotationItem.TaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALFIJO", DbType.Int64, nullValue); //VALIDAR
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTIDAD", DbType.Double, quotationItem.Amount);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPRECIO", DbType.Double, quotationItem.Price); 
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOSTO", DbType.Double, quotationItem.Cost);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPISO", DbType.Int32, quotationItem.FloorId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPO", DbType.Int32, quotationItem.PropUnitTypeId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBTIPOITEM", DbType.String, quotationItem.ItemType);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se registra el consolidado de la cotización
        /// </summary>
        /// <param name="quotationItem">Instancia de la clase QuotationItem</param>
        public void RegisterConsolidatedQuotation(ConsolidatedQuotation consolidatedQuotation)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bocotizacionconstructora.proCreaConsolidaCotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, consolidatedQuotation.Quotation);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, consolidatedQuotation.Project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRABAJO", DbType.Int64, consolidatedQuotation.TaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUIVA", DbType.Double, consolidatedQuotation.Iva);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPRECIO", DbType.Double, consolidatedQuotation.Price);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOSTO", DbType.Double, consolidatedQuotation.Cost);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUMARGEN", DbType.Double, consolidatedQuotation.MarkUp);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPRECIOTOTAL", DbType.Double, consolidatedQuotation.TotalPrice);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se obtienen los tipos de trabajo por cotización
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="quotationId">Consecutivo de la cotización</param>
        /// <returns>Retorna los tipos de trabajo de la cotización</returns>               
        public DataTable GetQuotationTaskType(Int64 projectId, Int64 quotationId)
        {
            DataSet dsQuotationTaskType = new DataSet("TipoTrabajoCotizacion");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fcrTipoTrabajoCotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, quotationId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsQuotationTaskType, "TipoTrabajoCotizacion");
            }
            return dsQuotationTaskType.Tables["TipoTrabajoCotizacion"];
        }

        /// <summary>
        /// Se obtiene los ítems fijos por proyecto/unidad predial
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="quotationId">Id de la cotización</param>
        /// <param name="itemType">Tipo de ítem</param>
        /// <param name="taskTypeId">Tipo de trabajo</param>
        /// <returns>Retorna una tabla de datos con los items fijos</returns>               
        public DataTable GetFixedItems(Int64 projectId, Int64 nuQuotationId, String itemType, Int64 taskTypeId)
        {
            DataSet dsFixedItems = new DataSet("ItemsFijosCotizados");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fcrItemsFijosCot"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, nuQuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBTIPOITEM", DbType.String, itemType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.Int64, taskTypeId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsFixedItems, "ItemsFijosCotizados");
            }
            return dsFixedItems.Tables["ItemsFijosCotizados"];
        }

        /// <summary>
        /// Se obtienen los valores fijos
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="quotationId">Id de la cotización</param>
        /// <param name="taskType">Tipo de Trabajo</param>
        /// <returns>Retorna una tabla de datos con los valores fijos</returns>               
        public DataTable GetFixedValues(Int64 projectId, Int64 nuQuotationId, Int64 taskType)
        {
            DataSet dsFixedValues = new DataSet("ValoresFijos");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fcrValoresFijosCot"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, nuQuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.Int64, taskType);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsFixedValues, "ValoresFijos");
            }
            return dsFixedValues.Tables["ValoresFijos"];
        }

        /// <summary>
        /// Se obtiene el metraje por tipo y piso a nivel de cotización
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="quotationId">Id de la cotización</param>
        /// <returns>Retorna una tabla de datos con el metraje por tipo y piso</returns>               
        public DataTable GetLengthPerFloorPerPropUnitTypeQuot(Int64 projectId, Int64? nuQuotationConsecutive)
        {
            DataSet dsLengthPerFloorPerPropUnitType = new DataSet("MetrajePorPisoYTipo");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fcrMetrajexPisoxTipoCot"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, nuQuotationConsecutive);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsLengthPerFloorPerPropUnitType, "MetrajePorPisoYTipo");
            }

            return dsLengthPerFloorPerPropUnitType.Tables["MetrajePorPisoYTipo"];
        }

        /// <summary>
        /// Se obtienen los ítems por metraje
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="quotationId">Id de la cotización</param>
        /// <returns>Retorna una tabla de datos con los ítems por metraje</returns>               
        public DataTable GetItemsPerLength(Int64 projectId, Int64 nuQuotationId)
        {
            DataSet dsItemsPerLength = new DataSet("ItemsPorMetraje");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fcrItemsxMetraje"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, nuQuotationId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsItemsPerLength, "ItemsPorMetraje");
            }
            return dsItemsPerLength.Tables["ItemsPorMetraje"];
        }

        /// <summary>
        /// Se obtienen los pisos y tipos de unidad predial por projecto
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <returns>Retorna los pisos y tipos de trabajo por proyecto</returns>               
        public DataTable GetFloorPropUnitType(Int64 projectId)
        {
            DataSet dsFloorPropUnitType = new DataSet("PisosTipos");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fcrPisosTiposProy"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsFloorPropUnitType, "PisosTipos");
            }
            return dsFloorPropUnitType.Tables["PisosTipos"];
        }

        /// <summary>
        /// Se obtiene los ítems fijos por unidad predial
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="quotationId">Id de la cotización</param>
        /// <param name="itemType">Tipo de ítem</param>
        /// <param name="taskTypeId">Tipo de Trabajo</param>
        /// <returns>Retorna una tabla de datos con los items</returns>               
        public DataTable GetItemsPerPropUnit(Int64 projectId, Int64 nuQuotationId, String itemType, Int64 taskTypeId)
        {
            DataSet dsFixedItems = new DataSet("ItemsUnidPredCotizados");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fcrItemsxMetrajexUnidPredCot"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, nuQuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBTIPOITEM", DbType.String, itemType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.Int64, taskTypeId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsFixedItems, "ItemsUnidPredCotizados");
            }
            return dsFixedItems.Tables["ItemsUnidPredCotizados"];
        }

        /// <summary>
        /// Método para obtener el consolidado de la cotización
        /// </summary>
        /// <param name="projectId">Id del proyecto</param>
        /// <param name="quotationId">Id de la cotización</param>
        /// <returns>Retorna una tabla de datos con el consolidado</returns>               
        public DataTable GetConsolidatedQuotation(Int64 projectId, Int64 nuQuotationId)
        {
            DataSet dsConsolidatedQuotation = new DataSet("Consolidado");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_bccotizacionconstructora.fcrConsolidadoCotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, nuQuotationId);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsConsolidatedQuotation, "Consolidado");
            }
            return dsConsolidatedQuotation.Tables["Consolidado"];
        }

        /// <summary>
        /// Se actualizan los items fijos
        /// </summary>
        /// <param name="quotationItem">Instancia de la clase QuotationItem</param>
        public void UpdateFixedItems(QuotationItem quotationItem)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.proModifItemsFijos")) 
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, quotationItem.QuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, quotationItem.ProjectId);
                //Caso 200-1640
                Int64 numberId = 0;
                String elemento = quotationItem.ItemId;
                if (elemento.Substring(elemento.Length - 1, 1).ToString() == "C" || elemento.Substring(elemento.Length - 1, 1).ToString() == "G")
                {
                    numberId = Int64.Parse(elemento.Substring(0, elemento.Length - 1).ToString());
                }
                else
                {
                    numberId = Int64.Parse(elemento);
                }
                //
                OpenDataBase.db.AddInParameter(cmdCommand, "INUITEM", DbType.Int64, numberId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUNUEVACANTIDAD", DbType.Double, quotationItem.Amount);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUNUEVOPRECIO", DbType.Double, quotationItem.Price);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUNUEVOCOSTO", DbType.Double, quotationItem.Cost);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBTIPOITEM", DbType.String, quotationItem.ItemType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.String, quotationItem.TaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBTIPOOPERACION", DbType.String, quotationItem.Operation);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBERROR", DbType.String, 300);
                
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se actualizan los valores fijos
        /// </summary>
        /// <param name="fixedValue">Instancia de la clase FixedValues</param>
        public void UpdateFixedValues(FixedValues fixedValue)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.proModifValoresFijos")) 
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, fixedValue.QuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, fixedValue.ProjectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUNUEVACANTIDAD", DbType.Double, fixedValue.Amount);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUNUEVOPRECIO", DbType.Double, fixedValue.Cost);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUVALFIJO", DbType.Int64, fixedValue.Consecutive);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.Int64, fixedValue.TaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBDESCRIPCION", DbType.String, fixedValue.Description);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBOPERACION", DbType.String, fixedValue.Operation);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se actualizan los ítems por metraje
        /// </summary>
        /// <param name="itemsPerLength">Instancia de la clase ItemsPerLength</param>
        public void UpdateItemsPerLength(ItemsPerLength itemsPerLength)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.proModifItemsXMetraje"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, itemsPerLength.QuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, itemsPerLength.Project);
                //Caso 200-1640
                Int64 numberId = 0;
                String elemento = itemsPerLength.ItemId;
                if (elemento.Substring(elemento.Length - 1, 1).ToString() == "C" || elemento.Substring(elemento.Length - 1, 1).ToString() == "G")
                {
                    numberId = Int64.Parse(elemento.Substring(0, elemento.Length - 1).ToString());
                }
                else
                {
                    numberId = Int64.Parse(elemento);
                }
                //
                OpenDataBase.db.AddInParameter(cmdCommand, "INUITEM", DbType.Int64, numberId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBFLAUTA", DbType.String, itemsPerLength.Flute == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBBBQ", DbType.String, itemsPerLength.BBQ == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBHORNO", DbType.String, itemsPerLength.Oven == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBESTUFA", DbType.String, itemsPerLength.Stove == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBSECADORA", DbType.String, itemsPerLength.Dryer == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBCALENTADOR", DbType.String, itemsPerLength.Heater == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBLONGVALBAJANTE", DbType.String, itemsPerLength.LongValBaj == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBLONGBAJANTE", DbType.String, itemsPerLength.LongBaj == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBLONGBAJTABLERO", DbType.String, itemsPerLength.LongBajTabl == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBLONGTABLERO", DbType.String, itemsPerLength.LongTab == true ? "S" : "N");
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOSTO", DbType.Double, itemsPerLength.Cost);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPRECIO", DbType.Double, itemsPerLength.Price);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBTIPOITEM", DbType.String, itemsPerLength.ItemType);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBOPERACION", DbType.String, itemsPerLength.Operation);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se actualiza el metraje por piso y tipo
        /// </summary>
        /// <param name="lengthPerFloorPerPropUnitType">Instancia de la clase LengthPerFloorPerPropUnitType</param>
        public void UpdateLengthPerFloorPerPropUnitType(LengthPerFloorPerPropUnitType lengthPerFloorPerPropUnitType)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.proModifMetrajeXPisoYTipo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, lengthPerFloorPerPropUnitType.QuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, lengthPerFloorPerPropUnitType.Project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPISO", DbType.Int32, lengthPerFloorPerPropUnitType.Floor);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPO", DbType.Int32, lengthPerFloorPerPropUnitType.PropUnitTypeId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUFLAUTA", DbType.Double, lengthPerFloorPerPropUnitType.Flute);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUHORNO", DbType.Double, lengthPerFloorPerPropUnitType.Oven);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUBBQ", DbType.Double, lengthPerFloorPerPropUnitType.BBQ);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUESTUFA", DbType.Double, lengthPerFloorPerPropUnitType.Stove);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUSECADORA", DbType.Double, lengthPerFloorPerPropUnitType.Dryer);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCALENTADOR", DbType.Double, lengthPerFloorPerPropUnitType.Heater);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGVALBAJ", DbType.Double, lengthPerFloorPerPropUnitType.LongValBaj);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGBAJANTE", DbType.Double, lengthPerFloorPerPropUnitType.LongBaj);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGBAJTAB", DbType.Double, lengthPerFloorPerPropUnitType.LongBajTabl);
                OpenDataBase.db.AddInParameter(cmdCommand, "INULONGTABLERO", DbType.Double, lengthPerFloorPerPropUnitType.LongTab);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCANTUNIDPRED", DbType.Double, lengthPerFloorPerPropUnitType.AmountPropUnit);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se actualizan los items por unidad
        /// </summary>
        /// <param name="quotationItem">Instancia de la clase QuotationItem</param>
        public void UpdateItemsPerPropUnit(QuotationItem quotationItem)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.proModifItemsUnidPredial"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, quotationItem.QuotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, quotationItem.ProjectId);
                //Caso 200-1640
                Int64 numberId = 0;
                String elemento = quotationItem.ItemId;
                if (elemento.Substring(elemento.Length - 1, 1).ToString() == "C" || elemento.Substring(elemento.Length - 1, 1).ToString() == "G")
                {
                    numberId = Int64.Parse(elemento.Substring(0, elemento.Length - 1).ToString());
                }
                else
                {
                    numberId = Int64.Parse(elemento);
                }
                //
                OpenDataBase.db.AddInParameter(cmdCommand, "INUITEM", DbType.Int64, numberId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUNUEVACANTIDAD", DbType.Double, quotationItem.Amount);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUNUEVOPRECIO", DbType.Double, quotationItem.Price);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUNUEVOCOSTO", DbType.Double, quotationItem.Cost);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBTIPOITEM", DbType.String, quotationItem.ItemType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRAB", DbType.Int64, quotationItem.TaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBTIPOOPERACION", DbType.String, quotationItem.Operation);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Método para modificar el consolidado de la cotización
        /// </summary>
        /// <param name="consolidatedQuotation">Instancia de la clase ConsolidatedQuotation</param>
        public void UpdateConsolidatedQuotation(ConsolidatedQuotation consolidatedQuotation)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.proModifConsolidaCotizacion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, consolidatedQuotation.Quotation);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, consolidatedQuotation.Project);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUTIPOTRABAJO", DbType.Int64, consolidatedQuotation.TaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOSTO", DbType.Double, consolidatedQuotation.Cost);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPRECIO", DbType.Double, consolidatedQuotation.Price);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUMARGEN", DbType.Double, consolidatedQuotation.MarkUp);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUIVA", DbType.Double, consolidatedQuotation.Iva);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBOPERACION", DbType.String, consolidatedQuotation.Operation);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se copia la cotización detallada
        /// </summary>
        /// <param name="projectId">Código del proyecto</param>
        /// <param name="quotation">Código de la cotización</param>
        public Int64 CopyQuotation(Int64 projectId, Int64 quotation)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.proCopiarCotizacionDetallada"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADAORIGEN", DbType.Int64, quotation);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUNUEVACOTIZACIONDETALLADA", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBERROR", DbType.String, 4000);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return string.IsNullOrEmpty(Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUNUEVACOTIZACIONDETALLADA"))) ? 0 : Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUNUEVACOTIZACIONDETALLADA"));
            }
        }

        /// <summary>
        /// Se preaprueba la cotización detallada
        /// </summary>
        /// <param name="projectId">Código del proyecto</param>
        /// <param name="quotation">Código de la cotización</param>
        /// <param name="address">Dirección de cobro</param>
        public void PreApproveQuotation(Int64 projectId, Int64 quotation, Int64 address, Int64 activity, Int32 cycle)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.proPreAprueba"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, quotation);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUDIRECCIONCOBRO", DbType.Int64, address);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUACTIVIDAD", DbType.Int64, activity);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCICLO", DbType.Int32, cycle);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBERROR", DbType.String, 4000);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se imprime pre-cupón
        /// </summary>
        /// <param name="projectId">Código del proyecto</param>
        /// <param name="quotation">Código de la cotización</param>
        /// <param name="path">Ruta del archivo</param>
        /// <param name="fileName">Nombre del archivo</param>
        public void PrintPreCupon(Int64 projectId, Int64 quotation, String path, String fileName)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.proImprimePrecupon"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCOTIZACIONDETALLADA", DbType.Int64, quotation);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBRUTA", DbType.String, path);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBNOMBREARCHIVO", DbType.String, fileName);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBERROR", DbType.String, 4000);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        /// <summary>
        /// Se actualiza el porcentaje de cuota inicial
        /// </summary>
        /// <param name="projectId">Código del proyecto</param>
        /// <param name="percentage">Porcentaje de la cuota inicial</param>
        public void UpdateInitialFeePercentage(Int64 projectId, Double percentage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("daldc_proyecto_constructora.updPORC_CUOT_INI"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "INUID_PROYECTO", DbType.Int64, projectId);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUPORC_CUOT_INI", DbType.Double, percentage);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        static String listavalores = "ld_boconstans.frfSentence";

        /// <summary>
        /// Recibe una consulta y devuelve el cursor con los datos
        /// </summary>
        /// <param name="Query">SQL con la consulta</param>
        /// <returns></returns>
        public DataTable getValueList(String Query)
        {
            DataSet dsValueList = new DataSet("ValueList");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(listavalores))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbselect", DbType.String, Query);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsValueList, "ValueList");
            }

            return dsValueList.Tables["ValueList"];
        }

        public Object getParam(String sbParam, String tipo)
        {
            try
            {
                Object valor = null;
                switch (tipo)
                {
                    case "String":
                        {
                            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dald_parameter.fsbgetvalue_chain"))
                            {
                                OpenDataBase.db.AddInParameter(cmdCommand, "inuparameter_id", DbType.String, sbParam);
                                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                                valor = OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
                            }
                        }
                        break;
                    case "Int64":
                        {
                            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dald_parameter.fnugetnumeric_value"))
                            {
                                OpenDataBase.db.AddInParameter(cmdCommand, "inuparameter_id", DbType.String, sbParam);
                                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Double, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                                valor = OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE");
                            }
                        }
                        break;
                    default:
                        valor = null;
                        break;
                }
                return valor;
            }
            catch
            {
                return null;
            }
        }

        //12.07.18
        //Servicios Diseñados por el Ing. Sebastian Tapias para el Manejo de las nuevas condiciones de la Forma
        /*public void proRegistraComercial(Int64 InuPackageID, Int64 InuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDCI_PKCOTICOMERCONS.proRegistraConstructora"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "InuPackageID", DbType.Int64, InuPackageID);
                OpenDataBase.db.AddInParameter(cmdCommand, "InuOperatingUnit", DbType.Int64, InuOperatingUnit);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        public void proActualizaComercial(Int64 InuPackageID, Int64 InuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDCI_PKCOTICOMERCONS.proActualizaConstructora"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "InuPackageID", DbType.Int64, InuPackageID);
                OpenDataBase.db.AddInParameter(cmdCommand, "InuOperatingUnit", DbType.Int64, InuOperatingUnit);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        public void proCargaComercial(Int64 InuPackageID, Int64 InuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDCI_PKCOTICOMERCONS.proCargaConstructora"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "InuPackageID", DbType.Int64, InuPackageID);
                OpenDataBase.db.AddInParameter(cmdCommand, "InuOperatingUnit", DbType.Int64, InuOperatingUnit);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }*/

        //Caso 200-1640
        //Aplicacion de Metodos del Ing. Sebastian Tapias
        //Servicio Reportado
        /*PROCEDURE proRegistraConstructora(inuPackageId     IN ldc_coticonstructora_adic.id_cotizacion%TYPE,
                                    inuProyecto      IN ldc_coticonstructora_adic.id_proyecto%TYPE,
                                    inuContratista   IN ldc_coticonstructora_adic.contratista%TYPE,
                                    inuOperatingUnit IN ldc_coticonstructora_adic.unidad_operativa%TYPE,
                                    onuErrorCode     OUT NUMBER,
                                    osbErrorMessage  OUT VARCHAR2);*/
        public void proRegistraConstructora(Int64 inuPackageId, Int64 inuProyecto, Int64 inuContratista, Int64 inuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proRegistraConstructora"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProyecto", DbType.Int64, inuProyecto);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContratista", DbType.Int64, inuContratista);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOperatingUnit", DbType.Int64, inuOperatingUnit);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        /*PROCEDURE proRegistraConstructoraItem(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                        inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                        inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                        isbTipoItem     IN ldc_itemscoticonstru_adic.tipo_item%TYPE,
                                        inuTipoTrab     IN ldc_itemscoticonstru_adic.tipo_trab%TYPE,
                                        isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                        onuErrorCode    OUT NUMBER,
                                        osbErrorMessage OUT VARCHAR2);*/
        public void proRegistraConstructoraItem(Int64 inuPackageId, Int64 inuProyecto, Int64 inuIditem, String isbTipoItem, Int64 inuTipoTrab, String isbClassItem, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proRegistraConstructoraItem"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProyecto", DbType.Int64, inuProyecto);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIditem", DbType.Int64, inuIditem);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbTipoItem", DbType.String, isbTipoItem);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTipoTrab", DbType.Int64, inuTipoTrab);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbClassItem", DbType.String, isbClassItem);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        /*PROCEDURE proActualizaConstructora(inuPackageId     IN ldc_coticonstructora_adic.id_cotizacion%TYPE,
                                     inuProyecto      IN ldc_coticonstructora_adic.id_proyecto%TYPE,
                                     inuContratista   IN ldc_coticonstructora_adic.contratista%TYPE,
                                     inuOperatingUnit IN ldc_coticonstructora_adic.unidad_operativa%TYPE,
                                     onuErrorCode     OUT NUMBER,
                                     osbErrorMessage  OUT VARCHAR2);*/
        public void proActualizaConstructora(Int64 inuPackageId, Int64 inuProyecto, Int64 inuContratista, Int64 inuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proActualizaConstructora"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProyecto", DbType.Int64, inuProyecto);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuContratista", DbType.Int64, inuContratista);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOperatingUnit", DbType.Int64, inuOperatingUnit);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        /*PROCEDURE proActualizaConstructoraItem(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                         inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                         inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                         isbTipoItem     IN ldc_itemscoticonstru_adic.tipo_item%TYPE,
                                         inuTipoTrab     IN ldc_itemscoticonstru_adic.tipo_trab%TYPE,
                                         isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                         isbOperacion    IN VARCHAR2, --Operacion
                                         onuErrorCode    OUT NUMBER,
                                         osbErrorMessage OUT VARCHAR2);*/
        public void proActualizaConstructoraItem(Int64 inuPackageId, Int64 inuProyecto, Int64 inuIditem, String isbTipoItem, Int64 inuTipoTrab, String isbClassItem, String isbOperacion, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proActualizaConstructoraItem"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProyecto", DbType.Int64, inuProyecto);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIditem", DbType.Int64, inuIditem);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbTipoItem", DbType.String, isbTipoItem);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTipoTrab", DbType.Int64, inuTipoTrab);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbClassItem", DbType.String, isbClassItem);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbOperacion", DbType.String, isbOperacion);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        /*PROCEDURE proCargaConstructora(inuPackageId     IN ldc_coticonstructora_adic.id_cotizacion%TYPE,
                                 inuProyecto      IN ldc_coticonstructora_adic.id_proyecto%TYPE,
                                 onuContratista   OUT ldc_coticonstructora_adic.contratista%TYPE,
                                 onuOperatingUnit OUT ldc_coticonstructora_adic.unidad_operativa%TYPE,
                                 onuErrorCode     OUT NUMBER,
                                 osbErrorMessage  OUT VARCHAR2);*/
        public void proCargaConstructora(Int64 inuPackageId, Int64 inuProyecto, out Int64 onuContratista, out Int64 onuOperatingUnit, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proCargaConstructora"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProyecto", DbType.Int64, inuProyecto);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuContratista", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuOperatingUnit", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuContratista = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuContratista"));
                onuOperatingUnit = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuOperatingUnit"));
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        /*PROCEDURE proRegistraItemValFijos(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                    inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                    inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                    inuTipoTrab     IN ldc_itemscoticonstru_adic.tipo_trab%TYPE,
                                    isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                    onuErrorCode    OUT NUMBER,
                                    osbErrorMessage OUT VARCHAR2);*/
        public void proRegistraItemValFijos(Int64 inuPackageId, Int64 inuProyecto, Int64 inuIditem, Int64 inuTipoTrab, String isbClassItem, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proRegistraItemValFijos"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProyecto", DbType.Int64, inuProyecto);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIditem", DbType.Int64, inuIditem);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTipoTrab", DbType.Int64, inuTipoTrab);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbClassItem", DbType.String, isbClassItem);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        /*PROCEDURE proActualizaItemValFijos(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                     inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                     inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                     inuTipoTrab     IN ldc_itemscoticonstru_adic.tipo_trab%TYPE,
                                     isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                     isbOperacion    IN VARCHAR2, --Operacion
                                     onuErrorCode    OUT NUMBER,
                                     osbErrorMessage OUT VARCHAR2);*/
        public void proActualizaItemValFijos(Int64 inuPackageId, Int64 inuProyecto, Int64 inuIditem, Int64 inuTipoTrab, String isbClassItem, String isbOperacion, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proActualizaItemValFijos"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProyecto", DbType.Int64, inuProyecto);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIditem", DbType.Int64, inuIditem);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTipoTrab", DbType.Int64, inuTipoTrab);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbClassItem", DbType.String, isbClassItem);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbOperacion", DbType.String, isbOperacion);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        /*PROCEDURE proRegistraItemMetraje(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                   inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                   inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                   isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                   onuErrorCode    OUT NUMBER,
                                   osbErrorMessage OUT VARCHAR2);*/
        public void proRegistraItemMetraje(Int64 inuPackageId, Int64 inuProyecto, Int64 inuIditem, String isbClassItem, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proRegistraItemMetraje"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProyecto", DbType.Int64, inuProyecto);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIditem", DbType.Int64, inuIditem);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbClassItem", DbType.String, isbClassItem);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        /*PROCEDURE proActualizaItemMetraje(inuPackageId    IN ldc_itemscoticonstru_adic.id_cotizacion%TYPE,
                                    inuProyecto     IN ldc_itemscoticonstru_adic.id_proyecto%TYPE,
                                    inuIditem       IN ldc_itemscoticonstru_adic.id_item%TYPE,
                                    isbClassItem    IN ldc_itemscoticonstru_adic.class_item%TYPE,
                                    isbOperacion    IN VARCHAR2, --Operacion
                                    onuErrorCode    OUT NUMBER,
                                    osbErrorMessage OUT VARCHAR2);*/
        public void proActualizaItemMetraje(Int64 inuPackageId, Int64 inuProyecto, Int64 inuIditem, String isbClassItem, String isbOperacion, out Int64 onuErrorCode, out String osbErrorMessage)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKCOTICOMERCONS.proActualizaItemMetraje"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, inuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuProyecto", DbType.Int64, inuProyecto);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuIditem", DbType.Int64, inuIditem);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbClassItem", DbType.String, isbClassItem);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbOperacion", DbType.String, isbOperacion);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuErrorCode", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                onuErrorCode = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuErrorCode"));
                osbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));
            }
        }

        public ActividadesPlanEsp getActiviPlanespec(Int64 inuPlanEspecial)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ldc_boCotizacionConstructora.proGetActividadesPlEspe"))
            {
                Int64 activicxc = 0;
                Int64 activicert = 0;
                string planinte = "N";

                OpenDataBase.db.AddInParameter(cmdCommand, "INUPLANESPE", DbType.Int64, inuPlanEspecial);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUACTIVIDADCXC", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUACTIVIDADINS", DbType.Int64, 20);
                OpenDataBase.db.AddOutParameter(cmdCommand, "OSBPLANESPE", DbType.String, 20);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                activicxc = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUACTIVIDADCXC"));
                activicert = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUACTIVIDADINS"));
                planinte = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "OSBPLANESPE"));

                ActividadesPlanEsp actPlanesp = new ActividadesPlanEsp();
                actPlanesp.Activicxc = activicxc;
                actPlanesp.Activicert = activicert;
                actPlanesp.PlanIntEsp = planinte;

                return actPlanesp;
            }
        }


        //IMPRIME COTIZACION DETALLADA Y RESUMIDA CASO 200-2022
        public void PrintCotizacion(Int64 inuProyecto, Int64 quotationId, String sTipoImpresion)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PAKGENFORMCOTI.IMPRIME_COTIZACION"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuProyecto", DbType.Int64, inuProyecto);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuCotizacinoConsec", DbType.Int64, quotationId);
                OpenDataBase.db.AddInParameter(cmdCommand, "sbTipo", DbType.String, sTipoImpresion);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

    }
}
