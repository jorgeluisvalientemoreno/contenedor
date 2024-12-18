using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;

namespace Ludycom.Constructoras.ENTITIES
{
    class PropPerFloorAndUnitType
    {
        private Int32 floorId;
        
        public Int32 FloorId
        {
            get { return floorId; }
            set { floorId = value; }
        }

        private Int32 propUnitType;

        public Int32 PropUnitType
        {
            get { return propUnitType; }
            set { propUnitType = value; }
        }

        private String floorDescription;

        [DisplayName("Piso")]
        public String FloorDescription
        {
            get { return floorDescription; }
            set { floorDescription = value; }
        }

        private String propUnitTypeDescription;

        [DisplayName("Tipo de Unidad")]
        public String PropUnitTypeDescription
        {
            get { return propUnitTypeDescription; }
            set { propUnitTypeDescription = value; }
        }

        private Int64 project;

        public Int64 Project
        {
            get { return project; }
            set { project = value; }
        }

        private List<QuotationItem> quotationItemList;

        public List<QuotationItem> QuotationItemList
        {
            get { return quotationItemList; }
            set { quotationItemList = value; }
        }

        public PropPerFloorAndUnitType()
        {

        }

        public PropPerFloorAndUnitType(Int64 projectId, Int32 floorId, Int32 propUnitTypeId, String floorDesc, String propUnitTypeDesc)
        {
            this.FloorId = floorId;
            this.PropUnitType = propUnitTypeId;
            this.FloorDescription = floorDesc;
            this.PropUnitTypeDescription = propUnitTypeDesc;
            this.Project = projectId;
            this.QuotationItemList = new List<QuotationItem>();
        }

        public PropPerFloorAndUnitType(DataRow drPropPerFloorAndUnitType)
        {
            this.FloorId = Convert.ToInt32(drPropPerFloorAndUnitType["ID_PISO"]);
            this.PropUnitType = Convert.ToInt32(drPropPerFloorAndUnitType["ID_TIPO_UNID_PRED"]);
            this.FloorDescription = Convert.ToString(drPropPerFloorAndUnitType["PISO_DESC"]);
            this.PropUnitTypeDescription = Convert.ToString(drPropPerFloorAndUnitType["TIPO_UNID_DESC"]);
            this.Project = Convert.ToInt64(drPropPerFloorAndUnitType["ID_PROYECTO"]);
            this.QuotationItemList = new List<QuotationItem>();
        }
    }
}
