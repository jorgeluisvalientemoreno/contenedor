using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace Ludycom.Constructoras.ENTITIES
{
    class LengthPerFloorPerPropUnitType
    {
        private Int64 projectId;

        [DisplayName("Id del Proyecto")]
        public Int64 Project
        {
            get { return projectId; }
            set { projectId = value; }
        }

        private Int64? quotationId;

        [DisplayName("Id Cotización")]
        public Int64? QuotationId
        {
            get { return quotationId; }
            set { quotationId = value; }
        }

        private String floorPropUnitTypeDesc;

        [DisplayName("Piso/Tipo")]
        public String FloorPropUnitTypeDesc
        {
            get { return floorPropUnitTypeDesc; }
            set { floorPropUnitTypeDesc = value; }
        }

        private Int32 floorId;

        [DisplayName("Piso")]
        public Int32 Floor
        {
            get { return floorId; }
            set { floorId = value; }
        }

        private Int32 propUnitTypeId;

        [DisplayName("Id Tipo de Unidad Predial")]
        public Int32 PropUnitTypeId
        {
            get { return propUnitTypeId; }
            set { propUnitTypeId = value; }
        }

        private Double flute;

        [DisplayName("Flauta")]
        public Double Flute
        {
            get { return flute; }
            set
            {
                if (string.IsNullOrEmpty(Convert.ToString(value)))
                {
                    flute = 0;
                }
                else
                {
                    flute = value;
                }
            }
        }

        private Double oven;

        [DisplayName("Horno")]
        public Double Oven
        {
            get { return oven; }
            set { oven = value; }
        }

        private Double bbq;

        [DisplayName("BBQ")]
        public Double BBQ
        {
            get { return bbq; }
            set { bbq = value; }
        }

        private Double stove;

        [DisplayName("Estufa")]
        public Double Stove
        {
            get { return stove; }
            set { stove = value; }
        }

        private Double dryer;

        [DisplayName("Secadora")]
        public Double Dryer
        {
            get { return dryer; }
            set { dryer = value; }
        }

        private Double heater;

        [DisplayName("Calentador")]
        public Double Heater
        {
            get { return heater; }
            set { heater = value; }
        }

        private Double longValBaj;

        [DisplayName("Longitud de Val a Bajante")]
        public Double LongValBaj
        {
            get { return longValBaj; }
            set { longValBaj = value; }
        }

        private Double longBajTabl;

        [DisplayName("Longitud de Bajante a Tablero")]
        public Double LongBajTabl
        {
            get { return longBajTabl; }
            set { longBajTabl = value; }
        }

        private Double longTab;

        [DisplayName("Longitud de Tablero")]
        public Double LongTab
        {
            get { return longTab; }
            set { longTab = value; }
        }

        private Double longBaj;

        [DisplayName("Longitud del Bajante")]
        public Double LongBaj
        {
            get { return longBaj; }
            set { longBaj = value; }
        }

        private Int32 amountPropUnit;

        [DisplayName("Cant. de Unidades Prediales")]
        public Int32 AmountPropUnit
        {
            get { return amountPropUnit; }
            set { amountPropUnit = value; }
        }

        private String operation;

        public String Operation
        {
            get { return operation; }
            set { operation = value; }
        }

        public LengthPerFloorPerPropUnitType(DataRow dtRow)
        {
            Int64? nullValue = null;
            this.Project = Convert.ToInt64(dtRow["ID_PROYECTO"]);
            this.QuotationId = string.IsNullOrEmpty(Convert.ToString(dtRow["QUOTATION_ID"])) ? nullValue : Convert.ToInt64(dtRow["QUOTATION_ID"]);
            this.FloorPropUnitTypeDesc = Convert.ToString(dtRow["PISO_DESC"]) + " " + Convert.ToString(dtRow["TIPO_DESC"]);
            this.Floor = Convert.ToInt32(dtRow["ID_PISO"]);
            this.PropUnitTypeId = Convert.ToInt32(dtRow["TIPO_UNID_PREDIAL"]);
            this.Flute = Convert.ToDouble(dtRow["FLAUTA"]);
            this.Oven = Convert.ToDouble(dtRow["HORNO"]);
            this.BBQ = Convert.ToDouble(dtRow["BBQ"]);
            this.Stove = Convert.ToDouble(dtRow["ESTUFA"]);
            this.Dryer = Convert.ToDouble(dtRow["SECADORA"]);
            this.Heater = Convert.ToDouble(dtRow["CALENTADOR"]);
            this.LongValBaj = Convert.ToDouble(dtRow["LONG_VAL_BAJANTE"]);
            this.LongBajTabl = Convert.ToDouble(dtRow["LONG_BAJANTE_TABL"]);
            this.LongTab = Convert.ToDouble(dtRow["LONG_TABLERO"]);
            this.LongBaj = Convert.ToDouble(dtRow["LONG_BAJANTE"]);
            this.AmountPropUnit = Convert.ToInt32(dtRow["CANTIDAD"]);
            this.Operation = Convert.ToString(dtRow["OPERACION"]);
        }
    }
}
