using System;
using System.Collections.Generic;
using System.Text;

namespace Ludycom.Constructoras.ENTITIES
{
    class CustomerBasicData
    {
        private String identificationType;

        public String IdentificationType
        {
            get { return identificationType; }
            set { identificationType = value; }
        }

        private String identification;

        public String Identification
        {
            get { return identification; }
            set { identification = value; }
        }

        private String customerName;

        public String CustomerName
        {
            get { return customerName; }
            set { customerName = value; }
        }
    }
}
