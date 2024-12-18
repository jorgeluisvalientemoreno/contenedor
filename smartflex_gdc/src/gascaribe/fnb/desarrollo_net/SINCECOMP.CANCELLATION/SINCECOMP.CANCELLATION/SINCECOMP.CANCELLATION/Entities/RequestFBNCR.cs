using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.CANCELLATION.Entities
{
    internal class RequestFBNCR
    {
        Int64? _InterationId = null;
        Int64? _DeliveryAddressId = null;
        Int64? _ReceptionTypeId = null;
        Int64? _ContactId = null;
        Int64? _IdentTypeContact;
        String _IdentContact;
        String _NameContact;
        String _LastNameContact;
    

        public Int64? InterationId 
        { 
            get
            {
                return _InterationId;
            }
            set
            {
                _InterationId = value; 
            }
        }

        public Int64? DeliveryAddressId
        {
            get
            {
                return _DeliveryAddressId;
            }
            set
            {
                _DeliveryAddressId = value;
            }
        }

        public Int64? ReceptionTypeId
        {
            get
            {
                return _ReceptionTypeId;
            }
            set
            {
                _ReceptionTypeId = value;
            }
        }

        public Int64? ContactId 
        {
            get
            {
                return _ContactId;
            }
            set
            {
                _ContactId = value;
            }
        }

        public Int64? IdentTypeContact
        {
            get
            {
                return _IdentTypeContact;
            }
            set
            {
                _IdentTypeContact = value;
            }
        }

        public String IdentContact
        {
            get
            {
                return _IdentContact;
            }
            set
            {
                _IdentContact = value;
            }
        }

        public String NameContact
        {
            get
            {
                return _NameContact;
            }
            set
            {
                _NameContact = value;
            }
        }

        public String LastNameContact
        {
            get
            {
                return _LastNameContact;
            }
            set
            {
                _LastNameContact = value;
            }
        }

        public RequestFBNCR()
        {
            this._InterationId = null;
            this._DeliveryAddressId = null;
            this._ReceptionTypeId = null;
            this._ContactId = null;
            this._IdentTypeContact = null;
            this._IdentContact = String.Empty;
            this._NameContact = String.Empty;
            this._LastNameContact = String.Empty;
        }
    }
}
