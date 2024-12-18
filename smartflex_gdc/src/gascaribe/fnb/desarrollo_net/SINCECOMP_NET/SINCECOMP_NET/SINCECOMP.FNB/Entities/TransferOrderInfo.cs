using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace SINCECOMP.FNB.Entities
{
    class TransferOrderInfo
    {

        #region Constructor

        public TransferOrderInfo()
        { }

        #endregion Constructor

        #region Fields

        String originSuscriptor;
        String orderId;
        Double transferenceValue;
        String requestUser;        
        DateTime requestDate;        
        String reviewUser;        
        DateTime reviewDate;        
        String approvedUser;        
        DateTime approvedDate;        
        String rejectUser;        
        DateTime rejectDate;       
               

        #endregion Fields

        #region Visible Properties

        [DisplayName("Contrato que Cede")]
        public String OriginSuscriptor
        {
            get { return originSuscriptor; }
            set { originSuscriptor = value; }
        }
                
        [DisplayName("Nro. Orden")]
        public String OrderId
        {
            get { return orderId; }
            set { orderId = value; }
        }

        [DisplayName("Valor Transferido")]
        public Double TransferenceValue
        {
            get { return transferenceValue; }
            set { transferenceValue = value; }
        }

        #endregion Visible Properties
        
        #region Not Visible Properties

        [Browsable(false)]
        public String RequestUser
        {
            get { return requestUser; }
            set { requestUser = value; }
        }

        [Browsable(false)]
        public DateTime RequestDate
        {
            get { return requestDate; }
            set { requestDate = value; }
        }

        [Browsable(false)]
        public String ReviewUser
        {
            get { return reviewUser; }
            set { reviewUser = value; }
        }

        [Browsable(false)]
        public DateTime ReviewDate
        {
            get { return reviewDate; }
            set { reviewDate = value; }
        }

        [Browsable(false)]
        public String ApprovedUser
        {
            get { return approvedUser; }
            set { approvedUser = value; }
        }

        [Browsable(false)]
        public DateTime ApprovedDate
        {
            get { return approvedDate; }
            set { approvedDate = value; }
        }

        [Browsable(false)]
        public String RejectUser
        {
            get { return rejectUser; }
            set { rejectUser = value; }
        }

        [Browsable(false)]
        public DateTime RejectDate
        {
            get { return rejectDate; }
            set { rejectDate = value; }
        }
        #endregion Not Visible Properties
    }
}
