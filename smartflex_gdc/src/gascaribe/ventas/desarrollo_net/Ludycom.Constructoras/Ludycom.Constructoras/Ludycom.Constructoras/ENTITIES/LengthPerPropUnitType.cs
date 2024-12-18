using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace Ludycom.Constructoras.ENTITIES
{
    class LengthPerPropUnitType
    {
        private Int64 projectId;

        public Int64 Project
        {
            get { return projectId; }
            set { projectId = value; }
        }

        private Int32 propUnitTypeId;

        [Browsable(true)]
        public Int32 PropUnitTypeId
        {
            get { return propUnitTypeId; }
            set { propUnitTypeId = value; }
        }

        private String propUnitType;

        [DisplayName("Tipo de Unidad Predial")]
        public String PropUnitType
        {
            get { return propUnitType; }
            set { propUnitType = value; }
        }

        private Double flute;

        [DisplayName("Flauta")]
        public Double Flute {
            get { return flute; }
            set { flute = value; }
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

        private String operation;

        public String Operation
        {
            get { return operation; }
            set { operation = value; }
        }


        public LengthPerPropUnitType()
        {

        }

        public LengthPerPropUnitType(DataRow drLengthPerPropUnitType)
        {
            this.Project = Convert.ToInt64(drLengthPerPropUnitType["ID_PROYECTO"]);
            this.PropUnitTypeId = Convert.ToInt32(drLengthPerPropUnitType["TIPO_UNID_PREDIAL"]);
            this.PropUnitType = Convert.ToString(drLengthPerPropUnitType["DESCRIPCION"]);
            this.Flute = Convert.ToDouble(drLengthPerPropUnitType["FLAUTA"]);
            this.Oven = Convert.ToDouble(drLengthPerPropUnitType["HORNO"]);
            this.BBQ = Convert.ToDouble(drLengthPerPropUnitType["BBQ"]);
            this.Stove = Convert.ToDouble(drLengthPerPropUnitType["ESTUFA"]);
            this.Dryer = Convert.ToDouble(drLengthPerPropUnitType["SECADORA"]);
            this.Heater = Convert.ToDouble(drLengthPerPropUnitType["CALENTADOR"]);
            this.LongValBaj = Convert.ToDouble(drLengthPerPropUnitType["LONG_VAL_BAJANTE"]);
            this.longBajTabl = Convert.ToDouble(drLengthPerPropUnitType["LONG_BAJANTE_TABL"]);
            this.LongTab = Convert.ToDouble(drLengthPerPropUnitType["LONG_TABLERO"]);
            this.Operation = "N";
        }
    }
}
