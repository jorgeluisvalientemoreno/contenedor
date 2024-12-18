#region Documentación
/*===========================================================================================================
 * Propiedad intelectual de Open International Systems (c).                                                  
 *===========================================================================================================
 * Unidad        : FIRTC
 * Descripcion   : Acceso a  la base de datos para la forma FIRTC
 * Autor         : Sidecom
 * Fecha         : -
 *                                                                                                           
 * Fecha        SAO     Autor          Modificación                                                          
 * ===========  ======  ============   ======================================================================
 * 07-Sep-2013  212252  mmira           1 - Se adiciona <getConsecut>.
 *=========================================================================================================*/
#endregion Documentación

using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using SINCECOMP.FNB.Entities;
//using SINCECOMP.FNB.Entities;

namespace SINCECOMP.FNB.DAL
{
    class DALFIRTC
    {
        //nombre de funciones y procedimentos
        static String informationUS = "ld_bopackagefnb.personTransfCuota"; //opciones para el usuario

        public static String[] getInformatioUser()
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(informationUS))
            {
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbstatus", DbType.String, 2);
                OpenDataBase.db.AddOutParameter(cmdCommand, "onupersonid", DbType.Int64, 15);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbname", DbType.String , 108);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
                String statusPerson = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbstatus"));
                String personId = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "onupersonid"));
                String namePerson = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbname"));
                String[] answerUser = new string[] {statusPerson , personId , namePerson };
                return answerUser;
            }
        }

        public List<ApprovalRequestFIRTC> getTrasnferOrder(int nuOrderApprovList)
        {
            DataSet TransferOrder = new DataSet("Approval");
            List<ApprovalRequestFIRTC> TrasnferList = new List<ApprovalRequestFIRTC>();

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCNONBANKFINANCING.getTrasnferOrder"))
            {
                OpenDataBase.db.AddParameterRefCursor(cmdCommand);
                OpenDataBase.db.AddInParameter(cmdCommand, "nuListOfOrderApprov", DbType.Int64, nuOrderApprovList);
                OpenDataBase.db.LoadDataSet(cmdCommand, TransferOrder, "Approval");                               
            }
           
            foreach (DataRow x in TransferOrder.Tables["Approval"].Rows)
            {

                TrasnferList.Add(new ApprovalRequestFIRTC(
                                                            Convert.ToInt64(x["package_id"]),
                                                            x["origin_subscrip_id"].ToString(), 
                                                            x["orderTaskType"].ToString(), 
                                                            Convert.ToDouble(x["totalValue"]), 
                                                            x["status"].ToString(),
                                                            x["request_observation"].ToString(),
                                                            x["review_observation"].ToString())
                                ); 
            }
            return TrasnferList;
        }

        public List<TransferOrderInfo> getTrasnferOrderInfo(Int64 inuOrder)
        {
           DataSet TransferOrder = new DataSet("TrasnferOrder");
           List<TransferOrderInfo> ListTransferOrder = new List<TransferOrderInfo>();

           using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BCNONBANKFINANCING.getTrasnferOrderInfo"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuOrder", DbType.Int64, inuOrder);  
                OpenDataBase.db.AddParameterRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, TransferOrder, "TrasnferOrder");
            }

            foreach (DataRow x in TransferOrder.Tables["TrasnferOrder"].Rows)
            {
                TransferOrderInfo newRow = new TransferOrderInfo();

                newRow.OriginSuscriptor = x["destiny_subscrip_id"].ToString();
                newRow.TransferenceValue = Convert.ToDouble(x["trasnfer_value"]);
                newRow.OrderId = x["order_id"].ToString();
                newRow.RequestUser = x["req_user"].ToString();
                newRow.ReviewUser = x["rev_user"].ToString();
                newRow.RejectUser = x["rej_user"].ToString();
                newRow.ApprovedUser = x["aprov_user"].ToString();
                
                //Variables temporales
                DateTime RequestDate = new DateTime();
                DateTime ReviewDate = new DateTime();
                DateTime RejectDate = new DateTime();
                DateTime ApprovedDate = new DateTime();

                //Se convierten cadenas a objetos tipo fecha
                DateTime.TryParse(x["request_date"].ToString(), out RequestDate);
                DateTime.TryParse(x["review_date"].ToString(), out ReviewDate);
                DateTime.TryParse(x["reject_date"].ToString(), out RejectDate);
                DateTime.TryParse(x["approved_date"].ToString(), out ApprovedDate);

                newRow.RequestDate = RequestDate;
                newRow.ReviewDate = ReviewDate;
                newRow.RejectDate = RejectDate;
                newRow.ApprovedDate = ApprovedDate;

                ListTransferOrder.Add(newRow);

            }
            return ListTransferOrder;
        }

        public void RegisterStatusChange(Int64 nuPackageId, Int32 nuStatus, String RequestObservation, String ReviewObservation )
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOQUOTATRANSFER.RegisterStatusChange"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "nuPackageId", DbType.Int64, nuPackageId);
                OpenDataBase.db.AddInParameter(cmdCommand, "inuStatus", DbType.Int32, nuStatus);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbRequestObservation", DbType.String, RequestObservation);
                OpenDataBase.db.AddInParameter(cmdCommand, "isbReviewObservation", DbType.String, ReviewObservation);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);
            }
        }

        public String getConsecut(Int64 nuPackageId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("LD_BOQUOTATRANSFER.GetConsSalebyOrder"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPackageId", DbType.Int64, nuPackageId);
                OpenDataBase.db.AddOutParameter(cmdCommand, "osbConsSale", DbType.String, 50);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbConsSale"));
            }
        }
    }
}
