using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;
using System.IO;
using System.Windows.Forms;
using OpenSystems.Common.Util;
//using SINCECOMP.SUBSIDYS.Entities;

namespace SINCECOMP.SUBSIDYS.DAL
{
    class DALLDISU
    {
        public static Boolean readFile(String locationFile)
        {
            //Boolean state = true;
            Boolean blStateTotal = true;
            String line;
            StreamReader file = new StreamReader(locationFile);
            Int64 numberLineEnd = 0;
            Int64 numberLineInit = 0;

            String nuCode;

            String sbSubcidio = null;
            String sbPopulation = null;
            String sbConceptsSubsidize = null;
            String sbCollectionStops = null;

            String sbErrorMessage = null;

            bool newSubsidio = false;
            bool newPoblacion = false;
            bool blErrorFormat = false;

            bool error = false;

            Int64? subsidyId = null;

            while ((line = file.ReadLine()) != null)
            {
                //rutina de lectura

                if (line.Contains("|"))
                {
                    nuCode = line.Substring(0, line.IndexOf("|"));
                    newSubsidio = false;
                    newPoblacion = false;
                    error = false;
                    blErrorFormat = false;
                    switch (nuCode)
                    {
                        case "01":
                            {
                                if (sbSubcidio == null)
                                {
                                    sbSubcidio = line;
                                }
                                else
                                {
                                    //Indica que se está procesando un nuevo subsidio, se indica que se debe registrar
                                    newSubsidio = true;
                                    numberLineInit = numberLineEnd;
                                }
                                numberLineEnd++;
                                break;
                            }

                        case "02":
                            {
                                if (sbSubcidio != null)
                                {
                                    if (sbPopulation == null)
                                    {
                                        sbPopulation = line;
                                    }
                                    else
                                    {
                                        //Indica que se está procesando una nueva población, se indica que se debe registrar
                                        newPoblacion = true;
                                    }
                                }
                                else
                                {
                                    error = true;
                                }
                                numberLineEnd++;
                                break;
                            }
                        case "03":
                            {
                                if (sbSubcidio != null || sbPopulation != null)
                                {
                                    numberLineEnd++;
                                    if (sbConceptsSubsidize == null)
                                    {
                                        sbConceptsSubsidize = line;
                                    }
                                    else
                                    {
                                        sbConceptsSubsidize = sbConceptsSubsidize + "-" + line;
                                        //numberLineEnd++;
                                    }
                                }
                                else
                                {
                                    error = true;
                                }
                                break;
                            }
                        case "04":
                            {

                                if (sbSubcidio != null || sbPopulation != null)
                                {
                                    numberLineEnd++;
                                    if (sbCollectionStops == null)
                                    {
                                        sbCollectionStops = line;
                                    }
                                    else
                                    {
                                        sbCollectionStops = sbCollectionStops + "-" + line;
                                    }
                                }
                                else
                                {
                                    error = true;
                                }
                                break;
                            }
                        default:
                            {
                                blErrorFormat = true;
                                error = true;
                                break;
                            }
                    }
                    if (newSubsidio || newPoblacion)
                    {
                        registerConfig(locationFile, ref blStateTotal, numberLineEnd, numberLineInit, sbSubcidio, sbPopulation, sbConceptsSubsidize, sbCollectionStops, ref sbErrorMessage, ref subsidyId);

                        /*Inicializa nuevamente las variables*/
                        if (newSubsidio)
                        {
                            sbSubcidio = line;
                            sbPopulation = null;
                            subsidyId = null;
                        }
                        if (newPoblacion)
                            sbPopulation = line;

                        sbConceptsSubsidize = null;
                        sbCollectionStops = null;
                        //numberLineEnd++;
                        //numberLineInit = numberLineEnd;
                    }
                    if (error)
                    {
                        if (blErrorFormat)
                        {
                            sbErrorMessage = "No se ha ingresado un código válido para el inicio de línea";
                            ProReadFile(locationFile, sbErrorMessage, numberLineInit, numberLineEnd);
                            blStateTotal = false;
                        }
                        else if (sbSubcidio == null)
                        {
                            sbErrorMessage = "Falta definir Subsidio";
                            ProReadFile(locationFile, sbErrorMessage, numberLineInit, numberLineEnd);
                            blStateTotal = false;
                        }
                        else
                        {
                            if (sbPopulation == null)
                            {
                                sbErrorMessage = "Falta definir la Población";
                                ProReadFile(locationFile, sbErrorMessage, numberLineInit, numberLineEnd);
                                blStateTotal = false;
                            }
                        }
                    }

                }
            }
            if (sbSubcidio != null) // && sbPopulation != null)
            {
                registerConfig(locationFile, ref blStateTotal, numberLineEnd, numberLineInit, sbSubcidio, sbPopulation, sbConceptsSubsidize, sbCollectionStops, ref sbErrorMessage, ref subsidyId);

                numberLineEnd++;
                numberLineInit = numberLineEnd;                
            }
            file.Close();
            return blStateTotal;
        }

        private static void registerConfig(String locationFile, ref Boolean blStateTotal, Int64 numberLineEnd, Int64 numberLineInit, String sbSubcidio, String sbPopulation, String sbConceptsSubsidize, String sbCollectionStops, ref String sbErrorMessage, ref Int64? subsidyId)
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("ld_bosubsidy.fblinssubsidy"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuCodigoSubsidio", DbType.Int64, subsidyId);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbSubcidio", DbType.String, sbSubcidio);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbPopulation", DbType.String, sbPopulation);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbConceptsSubsidize", DbType.String, sbConceptsSubsidize);

                OpenDataBase.db.AddInParameter(cmdCommand, "isbCollectionStops", DbType.String, sbCollectionStops);

                OpenDataBase.db.AddOutParameter(cmdCommand, "osbErrorMessage", DbType.String, 500);

                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.Int64, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);

                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                sbErrorMessage = Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, "osbErrorMessage"));

                subsidyId = OpenConvert.ToLongNullable(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));

                if (subsidyId.HasValue)
                {
                    OpenDataBase.Transaction.Commit();
                }
                else
                {                    
                    ProReadFile(locationFile, sbErrorMessage, numberLineInit, numberLineEnd);
                    OpenDataBase.Transaction.Rollback();
                    blStateTotal = false;
                }
            }
        }

        static void ProReadFile(String locationFile, String sbErrorMessage, Int64 numberLineInit, Int64 numberLineend)
        {
            String FileLog;
            String NewLine = char.ConvertFromUtf32(13) + char.ConvertFromUtf32(10);
            FileLog = locationFile.Replace(".", "_");
            String textMessage = " Error entre las Lineas # " + numberLineInit.ToString() + " y " + numberLineend.ToString() + " --> Descripción del Error: " + sbErrorMessage + NewLine;
            File.AppendAllText(FileLog + "_Inc.txt", textMessage);
        }

    }
}
