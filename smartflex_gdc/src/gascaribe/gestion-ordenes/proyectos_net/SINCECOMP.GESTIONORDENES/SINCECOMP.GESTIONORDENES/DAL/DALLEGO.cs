using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using SINCECOMP.GESTIONORDENES.Entities;
using System.Windows.Forms;
using OpenSystems.Common.ExceptionHandler;
using System.IO;
using OpenSystems.Common.Util;
//using SINCECOMP.GESTIONORDENES.Entities;


namespace SINCECOMP.GESTIONORDENES.DAL
{
    class DALLEGO
    {
        //Servicio para registrar la OT a legalizar
        public static void PrRegistoOrdenLegalizar(Int64 v_order_id, Int64 v_causal_id, String v_order_comment, DateTime v_exec_initial_date, DateTime v_exec_final_date, Int64 v_tecnico_unidad)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrRegistoOrdenLegalizar"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_causal_id", DbType.Int64, v_causal_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_comment", DbType.String, v_order_comment);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_exec_initial_date", DbType.DateTime, v_exec_initial_date);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_exec_final_date", DbType.DateTime, v_exec_final_date);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_tecnico_unidad", DbType.Int64, v_tecnico_unidad);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Servicio para registrar la OT adicionales
        //public static void PrRegistoOrdenAdicional(Int64 v_order_id, Int64 v_task_type_id, Int64 v_actividad, Int64 v_material, Double v_cantidad)
        public static void PrRegistoOrdenAdicional(Int64 v_order_id, Int64 v_task_type_id, Int64 v_actividad, Int64 v_material, String v_cantidad, Int64 v_causal_id)//, String v_valormaterial)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrRegistoOrdenAdicional"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_task_type_id", DbType.Int64, v_task_type_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_actividad", DbType.Int64, v_actividad);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_material", DbType.Int64, v_material);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_cantidad", DbType.Double, Convert.ToDouble(v_cantidad));
                OpenDataBase.db.AddInParameter(cmdCommand, "v_causal_id", DbType.Int64, v_causal_id);
                //OpenDataBase.db.AddInParameter(cmdCommand, "v_valormaterial", DbType.Double, Convert.ToDouble(v_valormaterial));

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Tabla para datos de orden de trabajo gestionadas por LEGO
        //public static DataTable FrfOrdenGestion(Int64 inuTipoTrab, DateTime idtDesde, DateTime idtHasta)
        public static List<OrdenGestionada> FrfOrdenGestion(Int64 inuTipoTrab, DateTime idtDesde, DateTime idtHasta)
        {
            DataSet DSDatosOrdenTrabajo = new DataSet("DatosOrdenGestionada");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfOrdenGestion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTipoTrab", DbType.Int64, inuTipoTrab);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtDesde", DbType.DateTime, idtDesde);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtHasta", DbType.DateTime, idtHasta);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosOrdenTrabajo, "DatosOrdenGestionada");
            }

            List<OrdenGestionada> EOrdenGestionada = new List<OrdenGestionada>();

            foreach (DataRow x in DSDatosOrdenTrabajo.Tables["DatosOrdenGestionada"].Rows)
            {
                //
                EOrdenGestionada.Add(new OrdenGestionada(Convert.ToInt64(x[0]), //Orden,
                        x[1].ToString(),//Agente,
                        x[2].ToString(),//Agente,
                        x[3].ToString(),//Direccion,
                        x[4].ToString(),//localidad,
                        x[5].ToString(),//FechaGestion,
                        Convert.ToInt64(x[6]),//Contrato,
                        x[7].ToString(),//Observacion,
                        x[8].ToString()//RespuestaOSF
                        ));
            }

            return EOrdenGestionada;

        }

        //Servicio para legalizar orden gestionada y generar actividad adicional configurada
        public static void PrConfirmarOrden(Int64 isbId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrConfirmarOrden"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbId", DbType.Int64, isbId);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Tabla para datos de orden de trabajo gestionadas por LEGO
        //public static DataTable FrfOrdenGestion(Int64 inuTipoTrab, DateTime idtDesde, DateTime idtHasta)
        public static DataTable FrfOrdenAdicional(Int64 OrdenTrabajo)
        {
            DataSet DSDatosOrdenAdicional = new DataSet("DatosOrdenAdicional");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfOrdenAdicional"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "OrdenTrabajo", DbType.Int64, OrdenTrabajo);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosOrdenAdicional, "DatosOrdenAdicional");
            }

            return DSDatosOrdenAdicional.Tables["DatosOrdenAdicional"];

        }

        //Servicio para legalizar orden gestionada y generar actividad adicional configurada
        public static void PrEliminarOrdenAdicional(Int64 v_order_id)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrEliminarOrdenAdicional"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Tabla para datos de orden de trabajo gestionadas por LEGO para el archivo de EXCEL
        public static DataTable FrfOrdenGestionExcel(Int64 inuTipoTrab, DateTime idtDesde, DateTime idtHasta)//(DateTime idtDesde, DateTime idtHasta)
        {
            DataSet DSDatosDatosOrdenGestionExcel = new DataSet("DatosOrdenGestionExcel");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfOrdenGestionExcel"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTipoTrab", DbType.Int64, inuTipoTrab);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtDesde", DbType.DateTime, idtDesde);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtHasta", DbType.DateTime, idtHasta);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosDatosOrdenGestionExcel, "DatosOrdenGestionExcel");
            }

            return DSDatosDatosOrdenGestionExcel.Tables["DatosOrdenGestionExcel"];

        }

        //Informacion del control de historial
        public void PrHistorialTTLEG(out Int64 onuOTRegistradas, out  Int64 onuOTAsignadas, out  Int64 onuOTSinFinalizar)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrHistorialTTLEGO"))
            {
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuOTRegistradas", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuOTAsignadas", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onuOTSinFinalizar", DbType.Int64, 10);
                
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                onuOTRegistradas = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuOTRegistradas"));
                onuOTAsignadas = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuOTAsignadas"));
                onuOTSinFinalizar = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "onuOTSinFinalizar"));

            }
        }
        /////////////////////////////////////////////////


        public static Int64 FnuExisteFuncional()
        {
            //(1) --> El funcionario esta configurado en LDCLEGO
            //(0) --> El funcionario NO esta configurado en LDCLEGO.
            Int64 nuRetornaValor;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FnuExisteFuncional"))
            {
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
            };
            return nuRetornaValor;
        }

        //Tabla para obtener datos de funcionario LEGO
        public static DataTable FrfFuncionalLEGO()
        {
            DataSet DSDatosFuncionalLEGO = new DataSet("DatosFuncionalLEGO");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfFuncionalLEGO"))
            {
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosFuncionalLEGO, "DatosFuncionalLEGO");
            }

            return DSDatosFuncionalLEGO.Tables["DatosFuncionalLEGO"];

        }


        //Funcion para retornar valor de existencia de la unidad operativa como unidad cotizada
        public static Int64 FnuUOACOfertados(Int64 inuUOACOfertados)
        {
            //(1) --> Mayor a cero significa que existen configuracion en LDCCUAI
            //(0) --> Menor o igual a cero significa que NO existen configuracion en LDCCUAI.
            Int64 nuRetornaValor;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FnuUOACOfertados"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuUOACOfertados", DbType.Int64, inuUOACOfertados);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
            };
            return nuRetornaValor;
        }


        //Funcion para retornar total de datos adicionales
        public static Int64 FnuTotalDatosAdicionales(Int64 nutask_type_id, Int64 NUCAUSAL_ID)
        {
            //(1) --> Mayor a cero significa que existen configuracion en LDCCUAI
            //(0) --> Menor o igual a cero significa que NO existen configuracion en LDCCUAI.
            Int64 nuRetornaValor;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FnuTotalDatosAdicionales"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nutask_type_id", DbType.Int64, nutask_type_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "NUCAUSAL_ID", DbType.Int64, NUCAUSAL_ID);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
            };
            return nuRetornaValor;
        }

        //Servicio para obtener registro de los datos adicionales
        public static DataTable FrfDatosAdicionales(Int64 nutask_type_id, Int64 NUCAUSAL_ID)
        {
            DataSet DSDatosAdicionales = new DataSet("DSDatosAdicionales");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfDatosAdicionales"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nutask_type_id", DbType.Int64, nutask_type_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "NUCAUSAL_ID", DbType.Int64, NUCAUSAL_ID); 
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosAdicionales, "DSDatosAdicionales");
            }

            return DSDatosAdicionales.Tables["DSDatosAdicionales"];

        }


        //Servicio para registrar datos adicionales a la orden a gestionar
        public static void PrRegistoDatoAdicional(Int64 v_order_id, String v_name_attribute, String v_value, Int64 v_task_type_id, Int64 v_causal_id)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrRegistoDatoAdicional"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_name_attribute", DbType.String, v_name_attribute);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_value", DbType.String, v_value);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_task_type_id", DbType.Int64, v_task_type_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_causal_id", DbType.Int64, v_causal_id);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Funcion para retornar valor rgestionado del dato adicional
        public static DataTable FrfDatoAdicional(Int64 v_order_id, String v_name_attribute, Int64 v_task_type_id, Int64 v_causal_id)
        {
            DataSet DSDatoAdicional = new DataSet("DSDatoAdicional");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfDatoAdicional"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_name_attribute", DbType.String, v_name_attribute);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_task_type_id", DbType.Int64, v_task_type_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_causal_id", DbType.Int64, v_causal_id);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatoAdicional, "DSDatoAdicional");
            }

            return DSDatoAdicional.Tables["DSDatoAdicional"];

        }

        //Informacion del control de historial
        public void PrDesgestionarOT ()
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrDesgestionarOT"))
            {
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }
        /////////////////////////////////////////////////

        //Servicio para legalizar orden gestionada y generar actividad adicional configurada
        public static void PrEliminarDatosAdicionales(Int64 v_order_id)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrEliminarDatosAdicionales"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //serivio para obtener el valor del item de la lista de costos
        //Informacion del control de historial
        public void getlistitemvalue(Int64 INUITEMID, DateTime IDTDATE, Int64 INUOPERATINGUNIT, Int64 INUCONTRACT, Int64 INUCONTRACTOR, Int64 INUGEOLOCATION, Int64 ISBTYPE, out Int64 ONUPRICELISTID, out  Int64 ONUVALUE)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ct_boliquidationsupport.getlistitemvalue"))
            {

                OpenDataBase.db.AddInParameter(cmdCommand, "INUITEMID", DbType.Int64, INUITEMID);
                OpenDataBase.db.AddInParameter(cmdCommand, "IDTDATE", DbType.DateTime, IDTDATE);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUOPERATINGUNIT", DbType.Int64, INUOPERATINGUNIT);
                //OpenDataBase.db.AddInParameter(cmdCommand, "INUCONTRACT", DbType.Int64, INUCONTRACT);
                //OpenDataBase.db.AddInParameter(cmdCommand, "INUCONTRACTOR", DbType.Int64, INUCONTRACTOR);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCONTRACT", DbType.Int64, null);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUCONTRACTOR", DbType.Int64, null);
                OpenDataBase.db.AddInParameter(cmdCommand, "INUGEOLOCATION", DbType.Int64, INUGEOLOCATION);
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBTYPE", DbType.Int64, ISBTYPE);
                
                //paraemtro de salida
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUPRICELISTID", DbType.Int64, 10);
                OpenDataBase.db.AddOutParameter(cmdCommand, "ONUVALUE", DbType.Int64, 10);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                if (String.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUPRICELISTID").ToString()))
                {
                    ONUPRICELISTID = 0;
                }
                else
                {
                    ONUPRICELISTID = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUPRICELISTID"));
                }
                if (String.IsNullOrEmpty(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUVALUE").ToString()))
                {
                    ONUVALUE = 0;
                }
                else
                {
                    ONUVALUE = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, "ONUVALUE"));
                }                
            }
        }
        /////////////////////////////////////////////////

        //Servicio para registrar items de la orden a gestionar
        public static void PrRegistoItemOrdenGestion(Int64 v_order_id, Int64 v_item, String v_cantidad)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrRegistoItemOrdenGestion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_item", DbType.Int64, v_item);
                //OpenDataBase.db.AddInParameter(cmdCommand, "v_cantidad", DbType.Int64, v_cantidad);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_cantidad", DbType.Double, Convert.ToDouble(v_cantidad));

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Tabla para datos de items de la orden gestionada por LEGO        
        public static DataTable FrfItemOrdenGestion(Int64 v_order_id)
        {
            DataSet DSItemOrdenGestion = new DataSet("DSItemOrdenGestion");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfItemOrdenGestion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSItemOrdenGestion, "DSItemOrdenGestion");
            }

            return DSItemOrdenGestion.Tables["DSItemOrdenGestion"];
        }

        //Servicio para eliminar items de orden a gestionar
        public static void PrEliminarItemOrdenGestion(Int64 v_order_id)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrEliminarItemOrdenGestion"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }
        
        //Servicio para registrar datos adicionales a la orden a gestionar
        public static void PrRegistoDatoAdicionalOTA(Int64 v_order_id, String v_name_attribute, String v_value, Int64 v_task_type_id, Int64 v_causal_id, Int64 v_actividad, Int64 v_material)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrRegistoDatoAdicionalOTA"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_name_attribute", DbType.String, v_name_attribute);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_value", DbType.String, v_value);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_task_type_id", DbType.Int64, v_task_type_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_causal_id", DbType.Int64, v_causal_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_actividad", DbType.Int64, v_actividad);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_material", DbType.Int64, v_material);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }


        //Funcion para retornar valor rgestionado del dato adicional
        public static DataTable FrfDatosAdicionalesOTA(Int64 v_order_id, Int64 v_task_type_id, Int64 v_causal_id, Int64  v_actividad, Int64 v_material)
        {
            DataSet DSDatoAdicionalOTA = new DataSet("DSDatoAdicionalOTA");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfDatosAdicionalesOTA"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_task_type_id", DbType.Int64, v_task_type_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_causal_id", DbType.Int64, v_causal_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_actividad", DbType.Int64, v_actividad);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_material", DbType.Int64, v_material);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatoAdicionalOTA, "DSDatoAdicionalOTA");
            }
            return DSDatoAdicionalOTA.Tables["DSDatoAdicionalOTA"];
        }

        //Servicio para eliminar items de orden a gestionar
        public static void PrEliminarDatosAdicionalesOTA(Int64 v_order_id)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrEliminarDatosAdicionalesOTA"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }


        //Funcion para retornar CAUSAL configurada en TIPOTRAB para legalizacion
        public static Int64 FnuTipoTrab(Int64 TIPOTRABLEGO_ID, Int64 TIPOTRABADICLEGO_ID)
        {
            
            Int64 nuRetornaValor;

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FnuTipoTrab"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "TIPOTRABLEGO_ID", DbType.Int64, TIPOTRABLEGO_ID);
                OpenDataBase.db.AddInParameter(cmdCommand, "TIPOTRABADICLEGO_ID", DbType.Int64, TIPOTRABADICLEGO_ID);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
            };
            return nuRetornaValor;
        }

        //Servicio para obtener el 1er valor de las lista de valores a inicializar en la grilla
        public static Int64 FnuDatoInicialListaValores(String IsbLista, Int64 InuDato1, Int64 InuDato2)
        {
            Int64 nuRetornaValor = 0;

            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FnuDatoInicialListaValores"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "IsbLista", DbType.String, IsbLista);
                    OpenDataBase.db.AddInParameter(cmdCommand, "InuDato1", DbType.Int64, InuDato1);
                    OpenDataBase.db.AddInParameter(cmdCommand, "InuDato2", DbType.Int64, InuDato2);
                    OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                    nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
                };
            }
            catch
            {
            }

            return nuRetornaValor;
        }

        //Servicio para obtener registro de los datos actividad
        public static DataTable FrfDatosActividad(Int64 InuActividad)
        {
            DataSet DSDatosActividad = new DataSet("DSDatosActividad");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfDatosActividad"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "InuActividad", DbType.Int64, InuActividad);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosActividad, "DSDatosActividad");
            }

            return DSDatosActividad.Tables["DSDatosActividad"];

        }

        //Servicio para registrar datos actividad a la orden a gestionar
        public static void PrRegistroDatoActividad(Int64 v_order_id, String v_name_attribute, String v_name_attribute_value, String v_component_id, String v_component_id_value)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrRegistoDatoActividad"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_name_attribute", DbType.String, v_name_attribute);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_name_attribute_value", DbType.String, v_name_attribute_value);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_component_id", DbType.String, v_component_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_component_id_value", DbType.String, v_component_id_value);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Servicio para obtener registro de los datos actividad
        public static DataTable FrfDatosActividadGestionado(Int64 InuActividad, Int64 InuOrden)
        {
            DataSet DSDatosActividadGestionado = new DataSet("DSDatosActividadGestionado");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfDatosActividadGestionado"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "InuActividad", DbType.Int64, InuActividad);
                OpenDataBase.db.AddInParameter(cmdCommand, "InuOrden", DbType.Int64, InuOrden);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosActividadGestionado, "DSDatosActividadGestionado");
            }

            return DSDatosActividadGestionado.Tables["DSDatosActividadGestionado"];

        }

        //Servicio para eliminar dato de actividad de OT de gestion
        public static void PrEliminarDatosActividad(Int64 v_order_id)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrEliminarDatosActividad"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Inicio CASO 200-1528
        //Servicio para registrar datos actividad al trabajo adicional
        public static void PrRegistoActividadAdicional(Int64 v_order_id, Int64 v_ACTIVIDAD, Int64 v_MATERIAL, String v_name_attribute, String v_name_attribute_value, String v_component_id, String v_component_id_value)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrRegistoActividadAdicional"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_ACTIVIDAD", DbType.Int64, v_ACTIVIDAD);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_MATERIAL", DbType.Int64, v_MATERIAL);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_name_attribute", DbType.String, v_name_attribute);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_name_attribute_value", DbType.String, v_name_attribute_value);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_name_attribute", DbType.String, v_component_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_name_attribute_value", DbType.String, v_component_id_value);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Funcion para retornar Datos Actividad de la OT adicional
        public static DataTable FrfDatosActividadAdicional(Int64 v_order_id, Int64 v_actividad, Int64 v_material)
        {
            DataSet DSDatosActividadAdicional = new DataSet("DSDatosActividadAdicional");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfDatosActividadAdicional"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_actividad", DbType.Int64, v_actividad);
                OpenDataBase.db.AddInParameter(cmdCommand, "v_material", DbType.Int64, v_material);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosActividadAdicional, "DSDatosActividadAdicional");
            }
            return DSDatosActividadAdicional.Tables["DSDatosActividadAdicional"];
        }

        //Servicio para eliminar dato actividad de la OT adicional
        public static void PrEliminarActividadAdicional(Int64 v_order_id)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.PrEliminarActividadAdicional"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "v_order_id", DbType.Int64, v_order_id);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        //Servicio para obtener resultado del calsificador de la causal
        public static Int64 FnuClasificadorCausal(Int64 InuCausal)
        {
            Int64 nuRetornaValor = 0;

            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FnuClasificadorCausal"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "InuCausal", DbType.Int64, InuCausal);
                    OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                    nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
                };
            }
            catch
            {
            }

            return nuRetornaValor;
        }

        //Tabla para datos de orden de trabajo gestionadas por LEGO para el archivo de EXCEL
        public static DataTable FrfOrdenLEGO(Int64 inuTipoTrab, DateTime idtDesde, DateTime idtHasta)//(DateTime idtDesde, DateTime idtHasta)
        {
            DataSet DSDatosDatosOrdenGestionExcel = new DataSet("DatosOrdenGestionExcel");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfOrdenLEGO"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuTipoTrab", DbType.Int64, inuTipoTrab);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtDesde", DbType.DateTime, idtDesde);
                OpenDataBase.db.AddInParameter(cmdCommand, "idtHasta", DbType.DateTime, idtHasta);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatosDatosOrdenGestionExcel, "DatosOrdenGestionExcel");
            }

            return DSDatosDatosOrdenGestionExcel.Tables["DatosOrdenGestionExcel"];

        }

        //Tabla para obtener lo items de la orden gestionada por LEGO para el archivo de EXCEL
        public static DataTable FrfItemOrdenLEGO(Int64 InuOrden)
        {
            DataSet DSItemOrdenGestionExcel = new DataSet("ItemOrdenGestionExcel");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfItemOrdenLEGO"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "InuOrden", DbType.Int64, InuOrden);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSItemOrdenGestionExcel, "ItemOrdenGestionExcel");
            }

            return DSItemOrdenGestionExcel.Tables["ItemOrdenGestionExcel"];

        }

        //Tabla para obtener lso trabajos adicionales de la orden gestionada por LEGO para el archivo de EXCEL
        public static DataTable FrfTAOrdenLEGO(Int64 InuOrden)
        {
            DataSet DSTAOrdenGestionExcel = new DataSet("TAOrdenGestionExcel");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfTAOrdenLEGO"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "InuOrden", DbType.Int64, InuOrden);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSTAOrdenGestionExcel, "TAOrdenGestionExcel");
            }

            return DSTAOrdenGestionExcel.Tables["TAOrdenGestionExcel"];

        }

        //Tabla para obtener los datos adicionales de la orden gestionada por LEGO para el archivo de EXCEL
        public static DataTable FrfDAOrdenLEGO(Int64 InuOrden)
        {
            DataSet DSDAOrdenGestionExcel = new DataSet("DAOrdenGestionExcel");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfDAOrdenLEGO"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "InuOrden", DbType.Int64, InuOrden);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDAOrdenGestionExcel, "DAOrdenGestionExcel");
            }

            return DSDAOrdenGestionExcel.Tables["DAOrdenGestionExcel"];

        }

        //Tabla para obtener los datos adicionales de la orden gestionada por LEGO para el archivo de EXCEL
        public static DataTable FrfDATAOrdenLEGO(Int64 InuOrden, Int64 Inutask_type_id, Int64 Inuactividad, Int64 Inumaterial)
        {
            DataSet DSDATAOrdenGestionExcel = new DataSet("DATAOrdenGestionExcel");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfDATAOrdenLEGO"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "InuOrden", DbType.Int64, InuOrden);
                OpenDataBase.db.AddInParameter(cmdCommand, "Inutask_type_id", DbType.Int64, Inutask_type_id);
                OpenDataBase.db.AddInParameter(cmdCommand, "Inuactividad", DbType.Int64, Inuactividad);
                OpenDataBase.db.AddInParameter(cmdCommand, "Inumaterial", DbType.Int64, Inumaterial);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDATAOrdenGestionExcel, "DATAOrdenGestionExcel");
            }

            return DSDATAOrdenGestionExcel.Tables["DATAOrdenGestionExcel"];

        }

        //Tabla para obtener los datos adicionales de la orden gestionada por LEGO para el archivo de EXCEL
        public static DataTable FrfCAOTAdicionalLEGO(Int64 InuOrden, Int64 Inuactividad)
        {
            DataSet DSFrfCAOTAdicionalExcel = new DataSet("DATACAOTAdicionalExcel");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FrfCAOTAdicionalLEGO"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "InuOrden", DbType.Int64, InuOrden);
                OpenDataBase.db.AddInParameter(cmdCommand, "Inuactividad", DbType.Int64, Inuactividad);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, DSFrfCAOTAdicionalExcel, "DATACAOTAdicionalExcel");
            }

            return DSFrfCAOTAdicionalExcel.Tables["DATACAOTAdicionalExcel"];

        }
        //Fin CASO 200-1528

        //Caso faltante horbarth danval 26-12-18
        //Servicio para obtener resultado del calsificador de la causal
        public static Int64 FnClasificadorCausalActivitdad(Int64 InuCausal)
        {
            Int64 nuRetornaValor = 0;

            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FnClasificadorCausalActivitdad"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "nuCausalID", DbType.Int64, InuCausal);
                    OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                    nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
                };
            }
            catch
            {
            }

            return nuRetornaValor;
        }
        //

        #region Caso 200-1580
        //Caso 200-1580
        //Daniel Valiente
        //Ordenes Garantias LEGO Cotizacion

        //Establece si existe configuración de garantía para el tipo de trabajo y causal establecido en la orden adicional definida en LEGO
        public static Int64 FNUEXISTENCIAGARANTIA(Int64 InuTipoTrabajo, Int64 InuCausal)
        {
            Int64 nuRetornaValor = 0;
            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.FNUEXISTENCIAGARANTIA "))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "InuTipoTrabajo", DbType.Int64, InuTipoTrabajo);
                    OpenDataBase.db.AddInParameter(cmdCommand, "InuCausal", DbType.Int64, InuCausal);
                    OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                    nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
                };
            }
            catch
            {
            }

            return nuRetornaValor;
        }

        //Retorna las ordenes de garantía relacionadas con el producto de la orden gestionada en LEGO
        //public static DataTable RFRFORDENESGARANTIA(Int64 InuOrden)

        public static DataTable RFRFORDENESGARANTIA(Int64 InuOrden, Int64 InuTaskType, DateTime IdtExcutdate /*Se agrega nuevo parametro caso:146*/)
        {
            DataSet DSDatos = new DataSet("DSDatos");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_PKGESTIONORDENES.RFRFORDENESGARANTIA"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "InuOrden", DbType.Int64, InuOrden);
                OpenDataBase.db.AddInParameter(cmdCommand, "InuTaskType", DbType.Int64, InuTaskType);
                OpenDataBase.db.AddInParameter(cmdCommand, "IdtExcutdate", DbType.DateTime, IdtExcutdate);// caso146
                OpenDataBase.db.AddParameterRefCursor(cmdCommand, "rfQuery");
                OpenDataBase.db.LoadDataSet(cmdCommand, DSDatos, "DSDatos");
            }
            return DSDatos.Tables["DSDatos"];
        }

        #endregion



        #region Caso 200-2692 Validacion de Entrega
        /// <summary>
        /// Se valida la entrega
        /// </summary>
        /// <param name="nomEntrega">Nombre de la entrega</param>
        public Int64 AplicaEntrega(String nomEntrega)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDC_FNU_APLICAENTREGA"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "ISBNOMBRE_ENTREGA", DbType.String, nomEntrega);
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }


        #endregion 

        // inicio caso 146
        public static Int64 ValidaGarantia(Int64 orden)
        {
            
            Int64 nuRetornaValor = 0;

            try
            {
                using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LDCPRBLOPORVAL"))
                {
                    OpenDataBase.db.AddInParameter(cmdCommand, "inuOrder", DbType.Int64, orden);
                    OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                    OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                    nuRetornaValor = Convert.ToInt64(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE").ToString());
                };
            }
            catch
            {
            }
            return nuRetornaValor;
        }
        // fin caso 146


        
    }
}
