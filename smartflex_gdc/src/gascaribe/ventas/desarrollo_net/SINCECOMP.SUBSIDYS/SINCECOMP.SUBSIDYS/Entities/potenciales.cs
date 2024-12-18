using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.SUBSIDYS.Entities
{
    class potenciales
    {
        private String location;

        public String Location
        {
            get { return location; }
            set { location = value; }
        }

        private Int64 client;

        public Int64 Client
        {
            get { return client; }
            set { client = value; }
        }

        private String clientName;

        public String ClientName
        {
            get { return clientName; }
            set { clientName = value; }
        }

        private String lastName;

        public String LastName
        {
            get { return lastName; }
            set { lastName = value; }
        }

        private String tels;

        public String Tels
        {
            get { return tels; }
            set { tels = value; }
        }

        private String geoubication;

        public String Geoubication
        {
            get { return geoubication; }
            set { geoubication = value; }
        }

        private Int64 subsidyValue;

        public Int64 SubsidyValue
        {
            get { return subsidyValue; }
            set { subsidyValue = value; }
        }

        private String subsidyDesc;

        public String SubsidyDesc
        {
            get { return subsidyDesc; }
            set { subsidyDesc = value; }
        }

        private String ldcname;

        public String Ldcname
        {
            get { return ldcname; }
            set { ldcname = value; }
        }

        private Int64 companytels;

        public Int64 Companytels
        {
            get { return companytels; }
            set { companytels = value; }
        }
    }
}
