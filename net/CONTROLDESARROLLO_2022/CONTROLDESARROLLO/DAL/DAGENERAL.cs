using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;

//Librerias
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace CONTROLDESARROLLO.DAL
{
    class DAGENERAL
    {
        //Homologaciones
        static String sentenciahomologaciones = "LD_BOCONSTANS.frfSentence";

        //Servicio General
        public DataTable SQLGeneral(String Query)
        {
            DataSet dsValueList = new DataSet("Homologacion");

            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand(sentenciahomologaciones))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "isbselect", DbType.String, Query);
                OpenDataBase.db.AddReturnRefCursor(cmdCommand);
                OpenDataBase.db.LoadDataSet(cmdCommand, dsValueList, "Homologacion");
            }            
            return dsValueList.Tables["Homologacion"];
        }

        //Retornar Estructura Funcion
        public String FsbEstructuraFuncion(String CbxEsquema, String TbxNombre, String CbxTipo, DataGridView DgvVariables, String sbAplicaPaquete)
        {
            String sbEstructuraFuncion;

            if (sbAplicaPaquete == "N")
                sbEstructuraFuncion = "create or replace function " + CbxEsquema + "." + TbxNombre;
            else
                sbEstructuraFuncion = "function " + TbxNombre;

            ////////////////////////

            if (sbAplicaPaquete == "N")
            {
                if (DgvVariables.RowCount > 0)
                {

                    int NuCantidadFilas = DgvVariables.Rows.Count;

                    sbEstructuraFuncion = sbEstructuraFuncion + "(" + Environment.NewLine;
                    foreach (DataGridViewRow row in DgvVariables.Rows)
                    {
                        if (!row.IsNewRow) // Ignorar la fila nueva
                        {
                            //MessageBox.Show("ID: {id}, Nombre: {nombre}, Edad: {edad}");
                            sbEstructuraFuncion = sbEstructuraFuncion + row.Cells["nombre"].Value.ToString() + " " + row.Cells["io"].Value.ToString() + " " + row.Cells["tipo"].Value.ToString();
                        }
                        NuCantidadFilas = NuCantidadFilas - 1;

                        if (NuCantidadFilas > 1)
                        {
                            sbEstructuraFuncion = sbEstructuraFuncion + "," + Environment.NewLine;
                        }
                    }
                    sbEstructuraFuncion = sbEstructuraFuncion + ")" + Environment.NewLine;

                }
            }

            /////////////////////////
            sbEstructuraFuncion = sbEstructuraFuncion + "  return " + CbxTipo + " is " + Environment.NewLine;
            if (sbAplicaPaquete == "N")
                sbEstructuraFuncion = sbEstructuraFuncion + "  csbMetodo CONSTANT VARCHAR2(100) := '" + TbxNombre + "';" + Environment.NewLine;
            else
                sbEstructuraFuncion = sbEstructuraFuncion + "  csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME||'" + TbxNombre + "';" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  onuErrorCode    number;" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  osbErrorMessage varchar2(4000);" + Environment.NewLine;
            if  (CbxTipo.ToUpper() == "varchar2".ToUpper())
            {
                sbEstructuraFuncion = sbEstructuraFuncion + "  nuReturn " + CbxTipo + "(4000);" + Environment.NewLine;
            }
            else
            {
                sbEstructuraFuncion = sbEstructuraFuncion + "  nuReturn " + CbxTipo + ";" + Environment.NewLine;
            }
            sbEstructuraFuncion = sbEstructuraFuncion + "BEGIN" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  pkg_traza.trace('Traza', pkg_traza.cnuNivelTrzDef);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  RETURN(nuReturn);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "EXCEPTION" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  WHEN pkg_error.CONTROLLED_ERROR THEN" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_Error.getError(OnuErrorCode, OsbErrorMessage);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_traza.trace('Error: ' || OsbErrorMessage,pkg_traza.cnuNivelTrzDef);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    RETURN(nuReturn);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  WHEN OTHERS THEN" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_Error.setError;" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_Error.getError(OnuErrorCode, OsbErrorMessage);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_traza.trace('Error: ' || OsbErrorMessage,pkg_traza.cnuNivelTrzDef);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    RETURN(nuReturn);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "END;" + Environment.NewLine;
            if (sbAplicaPaquete == "N")
            {
                sbEstructuraFuncion = sbEstructuraFuncion + "/" + Environment.NewLine;
            }

            if (sbAplicaPaquete == "N")
            {
                if (CbxEsquema != "OPEN")
                {
                    sbEstructuraFuncion = sbEstructuraFuncion + "BEGIN" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "  pkg_utilidades.prAplicarPermisos('" + TbxNombre + "','" + CbxEsquema + "');" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "END;" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "/" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "BEGIN" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "  pkg_utilidades.prCrearSinonimos('" + TbxNombre + "','" + CbxEsquema + "');" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "END;" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "/" + Environment.NewLine;
                }
            }

            return sbEstructuraFuncion; 
        }


        //Retornar Estructura Funcion
        public String FsbEstructuraProcedimiento(String CbxEsquema, String TbxNombre, DataGridView DgvVariables, String sbAplicaPaquete)
        {
            String sbEstructuraFuncion;

            if (sbAplicaPaquete == "N")
                sbEstructuraFuncion = "create or replace procedure " + CbxEsquema + "." + TbxNombre;
            else
                sbEstructuraFuncion = "procedure " + TbxNombre;

            ////////////////////////
            if (sbAplicaPaquete == "N")
            {
                if (DgvVariables.RowCount > 0)
                {
                    int NuCantidadFilas = DgvVariables.Rows.Count;

                    sbEstructuraFuncion = sbEstructuraFuncion + "(" + Environment.NewLine;
                    foreach (DataGridViewRow row in DgvVariables.Rows)
                    {
                        if (!row.IsNewRow) // Ignorar la fila nueva
                        {
                            //MessageBox.Show("ID: {id}, Nombre: {nombre}, Edad: {edad}");
                            sbEstructuraFuncion = sbEstructuraFuncion + row.Cells["nombre"].Value.ToString() + " " + row.Cells["io"].Value.ToString() + " " + row.Cells["tipo"].Value.ToString();
                        }
                        NuCantidadFilas = NuCantidadFilas - 1;

                        if (NuCantidadFilas > 1)
                        {
                            sbEstructuraFuncion = sbEstructuraFuncion + "," + Environment.NewLine;
                        }

                    }
                    sbEstructuraFuncion = sbEstructuraFuncion + ") IS " + Environment.NewLine;

                }

            }
            /////////////////////////
            sbEstructuraFuncion = sbEstructuraFuncion + Environment.NewLine;
            if (sbAplicaPaquete == "N")
                sbEstructuraFuncion = sbEstructuraFuncion + "  csbMetodo CONSTANT VARCHAR2(100) := '" + TbxNombre + "';" + Environment.NewLine;
            else
                sbEstructuraFuncion = sbEstructuraFuncion + "  csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME||'" + TbxNombre + "';" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  onuErrorCode    number;" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  osbErrorMessage varchar2(4000);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  cnuNVLTRC CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef;" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "BEGIN" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  pkg_traza.trace('Traza', cnuNVLTRC);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "EXCEPTION" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  WHEN pkg_error.CONTROLLED_ERROR THEN" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_Error.getError(OnuErrorCode, OsbErrorMessage);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_traza.trace('Error: ' || OsbErrorMessage,cnuNVLTRC);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERC);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    raise pkg_error.CONTROLLED_ERROR;" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "  WHEN OTHERS THEN" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_Error.setError;" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_Error.getError(OnuErrorCode, OsbErrorMessage);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_traza.trace('Error: ' || OsbErrorMessage,cnuNVLTRC);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERR);" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "    raise pkg_error.CONTROLLED_ERROR;" + Environment.NewLine;
            sbEstructuraFuncion = sbEstructuraFuncion + "END;" + Environment.NewLine;
            if (sbAplicaPaquete == "N")
            {
                sbEstructuraFuncion = sbEstructuraFuncion + "/" + Environment.NewLine;
            }

            if (sbAplicaPaquete == "N")
            {
                if (CbxEsquema.ToUpper() != "OPEN")
                {
                    sbEstructuraFuncion = sbEstructuraFuncion + "BEGIN" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "  pkg_utilidades.prAplicarPermisos('" + TbxNombre + "','" + CbxEsquema + "');" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "END;" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "/" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "BEGIN" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "  pkg_utilidades.prCrearSinonimos('" + TbxNombre + "','" + CbxEsquema + "');" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "END;" + Environment.NewLine;
                    sbEstructuraFuncion = sbEstructuraFuncion + "/" + Environment.NewLine;

                }
            }
            
            return sbEstructuraFuncion;
        }

    }
}
