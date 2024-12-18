using System;
using System.Collections.Generic;
using System.Text;

namespace Ludycom.Constructoras.ENTITIES
{
    class RequestBasicData
    {
        private Int64 requestId;

        public Int64 RequestId
        {
            get { return requestId; }
            set { requestId = value; }
        }

        private DateTime registerDate;

        public DateTime RegisterDate
        {
            get { return registerDate; }
            set { registerDate = value; }
        }
    }
}
