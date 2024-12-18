#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : FIRTC
 * Descripcion   : Aprobación de Solicitudes de Unión/Traslado de Cupos 
 * Autor         : Sidecom
 * Fecha         : -
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 07-Sep-2013  212252  mmira          1 - Se modifica <FIRTC> para habilitar correctamente las opciones disponibles 
 *                                      según el rol del usuario.
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
//
using SINCECOMP.FNB.BL;
using SINCECOMP.FNB.Entities;
using Infragistics.Win;
using OpenSystems.Common.Util;

namespace SINCECOMP.FNB.UI
{
    public partial class FIRTC : OpenForm
    {
        String Oper,nameUser;
        Int64 userId;
        BLFIRTC _BLFIRTC = new BLFIRTC();
        BLGENERAL general = new BLGENERAL();

        public FIRTC()
        {
            InitializeComponent();
            //rutina de verificacion de usuario
            String[] informationUser = BLFIRTC.getInformatioUser(); 
            Oper     = informationUser[0];
            userId   = Convert .ToInt64 ( informationUser[1]);
            nameUser = informationUser[2];
            //fin de la rutina
            //vhurtadoSAO216207: Se cambia: se deshabilita revisión en caso A
            //         se deshabilita aceptar en caso R
            //jrobayo.SAO218071: Se modifica la opción para usuarios no aurizados
            //                   para desplegar 
            switch (Oper)
            {
                case "A":
                    {
                        btnRevisition.Enabled = false;
                        btnAccept.Enabled = true;
                        btnDeny.Enabled = true;
                    }
                    break;
                case "R":
                    {
                        btnRevisition.Enabled = true;
                        btnAccept.Enabled = false;
                        btnDeny.Enabled = true;
                    }
                    break;
            }
            ugTrasnferDeta.DisplayLayout.Override.AllowUpdate = DefaultableBoolean.False;
            //dgDetailPriceList.DisplayLayout.Override.AllowUpdate = DefaultableBoolean.False;
        }

        private void btnRevisition_Click(object sender, EventArgs e)
        {
            if (approvalRequestFIRTCBindingSource != null)
            {
                ApprovalRequestFIRTC approvalTmp = (ApprovalRequestFIRTC)approvalRequestFIRTCBindingSource.Current;

                if (approvalTmp.NumberRequest != null)
                {
                    /*24/09/2014 Llozada [RQ 1226]: La observación debe ser obligatoria*/
                    if (!String.IsNullOrEmpty(ostbReviewObservation.TextBoxValue)) 
                    { 
                        _BLFIRTC.RegisterStatusChange(approvalTmp.NumberRequest, 1, ostbRequestObservation.TextBoxValue, ostbReviewObservation.TextBoxValue);

                        general.doCommit();
                        approvalRequestFIRTCBindingSource.DataSource = _BLFIRTC.getTrasnferOrder(0);
                    }
                    else
                        general.mensajeERROR("Por favor ingrese la observación");                    
                }
            }   
        }

        private void btnAccept_Click(object sender, EventArgs e)
        {
            if (approvalRequestFIRTCBindingSource != null)
            {
                ApprovalRequestFIRTC approvalTmp = (ApprovalRequestFIRTC)approvalRequestFIRTCBindingSource.Current;

                if (approvalTmp.NumberRequest != null)
                {
                    /*24/09/2014 Llozada [RQ 1226]: La observación debe ser obligatoria*/
                    if (!String.IsNullOrEmpty(ostbReviewObservation.TextBoxValue)) 
                    { 
                        _BLFIRTC.RegisterStatusChange(approvalTmp.NumberRequest, 3, ostbRequestObservation.TextBoxValue, ostbReviewObservation.TextBoxValue);

                        general.doCommit();
                        approvalRequestFIRTCBindingSource.DataSource = _BLFIRTC.getTrasnferOrder(0);
                    }
                    else
                        general.mensajeERROR("Por favor ingrese la observación"); 
                }
            }        
        }

        private void btnDeny_Click(object sender, EventArgs e)
        {
            //List<TransferOrderInfo> lstOrders = transferOrderInfoBindingSource.DataSource as List<TransferOrderInfo>;
           // foreach (TransferOrderInfo row in lstOrders)

            if (approvalRequestFIRTCBindingSource != null)
            {
                ApprovalRequestFIRTC approvalTmp = (ApprovalRequestFIRTC)approvalRequestFIRTCBindingSource.Current;

                if (approvalTmp.NumberRequest != null)
                {                   
                    /*24/09/2014 Llozada [RQ 1226]: La observación debe ser obligatoria*/
                    if (!String.IsNullOrEmpty(ostbReviewObservation.TextBoxValue)) 
                    { 
                        _BLFIRTC.RegisterStatusChange(approvalTmp.NumberRequest, 2, ostbRequestObservation.TextBoxValue, ostbReviewObservation.TextBoxValue);

                        general.doCommit();
                        approvalRequestFIRTCBindingSource.DataSource = _BLFIRTC.getTrasnferOrder(0);
                    }
                    else
                        general.mensajeERROR("Por favor ingrese la observación"); 
                }                
            }                   
        }

        private void FIRTC_Load(object sender, EventArgs e)
        {
            //Se asigna la lista de agrupadores de ordenes a aprovar
            approvalRequestFIRTCBindingSource.DataSource = _BLFIRTC.getTrasnferOrder(0);

            //aplicacion de formatos
            ugTrasnferDeta.DisplayLayout.Bands[0].Columns["TransferenceValue"].Format = "$ #,##0.00";
            ugTrasnferDeta.DisplayLayout.Bands[0].Columns["TransferenceValue"].CellAppearance.TextHAlign = HAlign.Right;

            ugTrasnferQuota.DisplayLayout.Bands[0].Columns["totalValue"].Format = "$ #,##0.00";
            ugTrasnferQuota.DisplayLayout.Bands[0].Columns["totalValue"].CellAppearance.TextHAlign = HAlign.Right;
            ugTrasnferDeta.DisplayLayout.GroupByBox.Hidden = true;         
        }

        private void approvalRequestFIRTCBindingSource_CurrentItemChanged(object sender, EventArgs e)
        {
            //Se obtiene el registro current agrupador de ordenes a aprovar
            ApprovalRequestFIRTC approvalTmp = (ApprovalRequestFIRTC)approvalRequestFIRTCBindingSource.Current;
            //Se obtiene el detalle (ordenes) a aprovar.
            transferOrderInfoBindingSource.DataSource = _BLFIRTC.getTrasnferOrderInfo(approvalTmp.NumberRequest); 
        }

        
        
        private void transferOrderInfoBindingSource_CurrentItemChanged(object sender, EventArgs e)
        {
            //Se obtiene el agrupador de ordenes actualmente seleccionado
            ApprovalRequestFIRTC approvalTmp = (ApprovalRequestFIRTC)approvalRequestFIRTCBindingSource.Current;
            //Se obtiene la orden seleccionada actualmente 
            TransferOrderInfo trasnfertTmp = (TransferOrderInfo)transferOrderInfoBindingSource.Current;
          

            //Informacion de los usuarios que han aprovado diferentes etapas.
            ostbRequestUser.TextBoxValue = trasnfertTmp.RequestUser.ToString();
            ostbReviewUser.TextBoxValue = trasnfertTmp.ReviewUser.ToString();
            ostbRejectUser.TextBoxValue = trasnfertTmp.RejectUser.ToString();
            ostbApprovedUser.TextBoxValue = trasnfertTmp.ApprovedUser.ToString();

            //Infomacion de observaciones
            ostbRequestObservation.TextBoxValue = approvalTmp.RequestObservation;
            ostbApprovObservation.TextBoxValue = approvalTmp.ReviewObservation;

            // Obtener Consecutivo de la venta            
            textBoxOrder.TextBoxValue = _BLFIRTC.getConsecut(approvalTmp.NumberRequest);

            if (trasnfertTmp.ApprovedDate <= DateTime.MinValue)
            {
                udteApprovalDate.TextBoxObjectValue = null;                
            }
            else
            {                
                udteApprovalDate.TextBoxObjectValue = trasnfertTmp.ApprovedDate; 
            }

            if (trasnfertTmp.RejectDate <= DateTime.MinValue)
            {
                udteRejectDate.TextBoxObjectValue = null;                
            }
            else
            {
                udteRejectDate.TextBoxObjectValue = trasnfertTmp.RejectDate;                
            }

            if (trasnfertTmp.ReviewDate <= DateTime.MinValue)
            {
                udteReviewDate.TextBoxObjectValue = null;
            }
            else
            {
                udteReviewDate.TextBoxObjectValue = trasnfertTmp.ReviewDate;                
            }

            if (trasnfertTmp.RequestDate <= DateTime.MinValue)
            {
                udteRequestDate.TextBoxObjectValue = null;
            }
            else
            {
                udteRequestDate.TextBoxObjectValue = trasnfertTmp.RequestDate;                
            }
        }

        private void ostbRequestObservation_Load(object sender, EventArgs e)
        {

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

    }
}