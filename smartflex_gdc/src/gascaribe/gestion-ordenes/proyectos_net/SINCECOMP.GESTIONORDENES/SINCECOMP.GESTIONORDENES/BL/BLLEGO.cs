using System;
using System.Collections.Generic;
using System.Text;
//
using System.Data;
using SINCECOMP.GESTIONORDENES.DAL;
using SINCECOMP.GESTIONORDENES.Entities;

namespace SINCECOMP.GESTIONORDENES.BL
{
    class BLLEGO
    {
        //caso 200-2692//
        DALLEGO dallego = new DALLEGO();        
        // fin caso 200-2692 //

        //Servicio para registrar la OT a legalizar
        public static void PrRegistoOrdenLegalizar(Int64 v_order_id, Int64 v_causal_id, String v_order_comment, DateTime v_exec_initial_date, DateTime v_exec_final_date, Int64 v_tecnico_unidad)
        {
            DALLEGO.PrRegistoOrdenLegalizar(v_order_id, v_causal_id, v_order_comment, v_exec_initial_date, v_exec_final_date, v_tecnico_unidad);
        }

        //Servicio para registrar la OT adicionales
        //public static void PrRegistoOrdenAdicional(Int64 v_order_id, Int64 v_task_type_id, Int64 v_actividad, Int64 v_material, Double v_cantidad)
        public static void PrRegistoOrdenAdicional(Int64 v_order_id, Int64 v_task_type_id, Int64 v_actividad, Int64 v_material, String v_cantidad, Int64 v_causal_id)//, String v_valormaterial)
        {
            DALLEGO.PrRegistoOrdenAdicional(v_order_id, v_task_type_id, v_actividad, v_material, v_cantidad, v_causal_id); //, v_valormaterial);

        }

        //Servicio para legalizar orden gestionada y generar actividad adicional configurada
        public static void PrConfirmarOrden(Int64 isbId)
        {
            DALLEGO.PrConfirmarOrden(isbId);
        }

        //Servicio para editar ordenes adicionales
        public static void PrEliminarOrdenAdicional(Int64 v_order_id)
        {
            DALLEGO.PrEliminarOrdenAdicional(v_order_id);
        }

        //Servicio para registrar la OT adicionales
        //public static void PrRegistoOrdenAdicional(Int64 v_order_id, Int64 v_task_type_id, Int64 v_actividad, Int64 v_material, Double v_cantidad)
        public static void PrRegistoDatoAdicional(Int64 v_order_id, String v_name_attribute, String v_value, Int64 v_task_type_id, Int64 v_causal_id)
        {
            DALLEGO.PrRegistoDatoAdicional(v_order_id, v_name_attribute, v_value, v_task_type_id, v_causal_id);

        }

        //Servicio para editar ordenes adicionales
        public static void PrEliminarDatosAdicionales(Int64 v_order_id)
        {
            DALLEGO.PrEliminarDatosAdicionales(v_order_id);
        }

        //Servicio para registrar items de la orden a gestionar
        public static void PrRegistoItemOrdenGestion(Int64 v_order_id, Int64 v_item, String v_cantidad)
        {
            DALLEGO.PrRegistoItemOrdenGestion(v_order_id, v_item, v_cantidad);

        }

        //Servicio para editar ordenes adicionales
        public static void PrEliminarItemOrdenGestion(Int64 v_order_id)
        {
            DALLEGO.PrEliminarItemOrdenGestion(v_order_id);
        }

        //Servicio para registrar la OT adicionales de orden aicional
        public static void PrRegistoDatoAdicionalOTA(Int64 v_order_id, String v_name_attribute, String v_value, Int64 v_task_type_id, Int64 v_causal_id, Int64 v_actividad, Int64 v_material)
        {
            DALLEGO.PrRegistoDatoAdicionalOTA(v_order_id, v_name_attribute, v_value, v_task_type_id, v_causal_id, v_actividad, v_material);

        }

        //Servicio para editar ordenes adicionales
        public static void PrEliminarDatosAdicionalesOTA(Int64 v_order_id)
        {
            DALLEGO.PrEliminarDatosAdicionalesOTA(v_order_id);
        }

        //Servicio para registrar la dato actividad la OT a gestionar
        public static void PrRegistroDatoActividad(Int64 v_order_id, String v_name_attribute, String v_name_attribute_value, String v_component_id, String v_component_id_value)
        {
            DALLEGO.PrRegistroDatoActividad(v_order_id, v_name_attribute, v_name_attribute_value, v_component_id, v_component_id_value);

        }

        //Servicio para eliminar dato actividad
        public static void PrEliminarDatosActividad(Int64 v_order_id)
        {
            DALLEGO.PrEliminarDatosActividad(v_order_id);
        }

        //Inicio CASO 200-1528
        //Servicio para registrar Dato Activdad de Trabajo Adicional
        public static void PrRegistoActividadAdicional(Int64 v_order_id, Int64 v_ACTIVIDAD, Int64 v_MATERIAL, String v_name_attribute, String v_name_attribute_value, String v_component_id, String v_component_id_value)
        {
            DALLEGO.PrRegistoActividadAdicional(v_order_id, v_ACTIVIDAD, v_MATERIAL, v_name_attribute, v_name_attribute_value, v_component_id, v_component_id_value);

        }

        //Servicio para eliminar ordenes adicionales
        public static void PrEliminarActividadAdicional(Int64 v_order_id)
        {
            DALLEGO.PrEliminarActividadAdicional(v_order_id);
        }
        //Fin CASO 200-158

        #region Caso 200-1580
        //Caso 200-1580
        //Daniel Valiente
        //Ordenes Garantias LEGO Cotizacion

        //Establece si existe configuración de garantía para el tipo de trabajo y causal establecido en la orden adicional definida en LEGO
        public static Int64 FNUEXISTENCIAGARANTIA(Int64 InuTipoTrabajo, Int64 InuCausal)
        {
            return DALLEGO.FNUEXISTENCIAGARANTIA(InuTipoTrabajo, InuCausal);
        }

        //Retorna las ordenes de garantía relacionadas con el producto de la orden gestionada en LEGO
        public static DataTable RFRFORDENESGARANTIA(Int64 InuOrden, Int64 InuTaskType, DateTime IdtExcutdate /*Se agrega nuevo parametro caso:146*/)
        {
            return DALLEGO.RFRFORDENESGARANTIA(InuOrden, InuTaskType, IdtExcutdate);
        }

        #endregion


        #region Caso 200-2692

        public Int64 AplicaEntrega(String nomEntrega)
        {
            return dallego.AplicaEntrega(nomEntrega);
        }

        #endregion 

        

    }
}
