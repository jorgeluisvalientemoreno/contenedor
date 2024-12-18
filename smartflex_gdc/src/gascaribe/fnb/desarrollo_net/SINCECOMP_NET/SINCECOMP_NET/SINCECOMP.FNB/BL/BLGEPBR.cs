using System;
using System.Collections.Generic;
using System.Text;
//librerias adicionales
using SINCECOMP.FNB.DAL;
using SINCECOMP.FNB.Entities ;
using System.Data;
using System.Data.Common;
using OpenSystems.Common.Data;

namespace SINCECOMP.FNB.BL
{
    class BLGEPBR
    {
        //eliminar propiedades
        //public static void deletePropertbyArticle(Int64 inupropert_by_article_id)
        //{
        //    DALGEPBR.deletePropertbyArticle(inupropert_by_article_id);
        //}

        //modificar propiedades
        public static void modifyPropertbyArticle(Int64 inupropert_by_article_id, Int64 inuarticleid, String inuproperty_id, String inuvalue)
        {
            DALGEPBR.modifyPropertbyArticle(inupropert_by_article_id, inuarticleid, inuproperty_id, inuvalue);
        }

        //guardar propiedades
        public static void savePropertbyArticle(Int64 inupropert_by_article_id, Int64 inuarticleid, String inuproperty_id, String inuvalue)
        {
            DALGEPBR.savePropertbyArticle(inupropert_by_article_id, inuarticleid, inuproperty_id, inuvalue);
        }

        //consecutivo para Propiedades
        //public static Int64 consProperties()
        //{
        //    return DALGEPBR.consProperties();
        //}

        //consecutivo para Articulos
        //public static Int64 consArticle()
        //{
        //    return DALGEPBR.consArticle();
        //}

        //eliminar Articulos
        //public static void deleteArticle(Int64 inuarticle_id)
        //{
        //    DALGEPBR.deleteArticle(inuarticle_id);
        //}

        //modificar Articulos
        public static void modifyArticle(Int64 inuarticle_id, String isbescription, Int64 inuwarranty, String inusubline_id,
            String inufinancier_id, String inuconcept_id, String inusupplier_id, String inubrand_id, String isbreference,
            String isbapproved, String isbavalible, String isbactive, String isbprice_control, String isbobservation,
            Decimal inuvat, String isbinstallation, String isbequivalence)
        {
            DALGEPBR.modifyArticle(inuarticle_id, isbescription, inuwarranty, inusubline_id, inufinancier_id, inuconcept_id, inusupplier_id, inubrand_id, isbreference, isbapproved, isbavalible, isbactive, isbprice_control, isbobservation, inuvat, isbinstallation, isbequivalence);
        }

        //Confirmar acciones
        //public static void Save()
        //{
        //    DALGELPPB.Save();
        //}

        //Guardar Articulos
        public static void saveArticle(Int64 inuarticle_id, String isbescription, Int64 inuwarranty, String inusubline_id,
            String inufinancier_id, String inuconcept_id, String inusupplier_id, String inubrand_id, String isbreference,
            String isbapproved, String isbavalible, String isbactive, String isbprice_control, String isbobservation,
            Decimal inuvat, String isbinstallation, String isbequivalence)
        {
            DALGEPBR.saveArticle(inuarticle_id, isbescription, inuwarranty, inusubline_id, inufinancier_id, inuconcept_id, inusupplier_id, inubrand_id, isbreference, isbapproved, isbavalible, isbactive, isbprice_control, isbobservation, inuvat, isbinstallation, isbequivalence);
        }

        //Propiedades
        public static List<PropArtGEPBR> FcuProperties(Int64 inuarticle_id)
        {
            List<PropArtGEPBR> ListProperty = new List<PropArtGEPBR>();
            DataTable TBProperty = DALGEPBR.getProperties(inuarticle_id);
            //ordenar listado
            DataView VistaDatos = new DataView(TBProperty);
            VistaDatos.Sort = "propert_by_article_id";
            TBProperty = VistaDatos.ToTable();
            if (TBProperty != null)
            {
                foreach (DataRow row in TBProperty.Rows)
                {
                    PropArtGEPBR vProperty = new PropArtGEPBR(row);
                    ListProperty.Add(vProperty);
                }
            }
            return ListProperty;
        }

        public static List<ArticleGEPBR> FcuArticle(String userId, String typeUser)
        {
            List<ArticleGEPBR> ListArticle = new List<ArticleGEPBR>();
            DataTable TBArticle = DALGEPBR.getArticle();
            //ordenar listado
            DataView VistaDatos = new DataView(TBArticle);
            VistaDatos.Sort = "article_id";
            TBArticle = VistaDatos.ToTable();
            String condition = "supplier_id=" + userId;
            if (TBArticle != null)
            {
                if (typeUser == "F")
                {
                    foreach (DataRow row in TBArticle.Rows)
                    {
                        ArticleGEPBR vArticle = new ArticleGEPBR(row);
                        ListArticle.Add(vArticle);
                    }
                }
                else
                {
                    foreach (DataRow row in TBArticle.Select(condition))
                    {
                        ArticleGEPBR vArticle = new ArticleGEPBR(row);
                        ListArticle.Add(vArticle);
                    }
                }
            }
            return ListArticle;
        }

        public static ArticleGEPBR AddRowList()
        {
            DataTable tabla = new DataTable();
            DataRow datos;
            tabla.Columns.Add("article_id");
            tabla.Columns.Add("description");
            tabla.Columns.Add("warranty");
            tabla.Columns.Add("installation");
            tabla.Columns.Add("subline_id");
            tabla.Columns.Add("brand_id");
            tabla.Columns.Add("financier_id");
            tabla.Columns.Add("concept_id");
            tabla.Columns.Add("supplier_id");
            tabla.Columns.Add("vat");
            tabla.Columns.Add("observation");
            tabla.Columns.Add("price_control");
            tabla.Columns.Add("avalible");
            tabla.Columns.Add("active");
            tabla.Columns.Add("approved");
            tabla.Columns.Add("reference");
            tabla.Columns.Add("equivalence");
            tabla.Columns.Add("CheckSave");
            tabla.Columns.Add("CheckModify");
            datos = tabla.NewRow();
            datos[0] = 0;
            datos[1] = "";
            datos[2] = 0;
            datos[3] = "";
            datos[4] = "";
            datos[5] = "";
            datos[6] = "";
            datos[7] = "";
            datos[8] = "";
            datos[9] = 0;
            datos[10] = "";
            datos[11] = "";
            datos[12] = "";
            datos[13] = "";
            datos[14] = "";
            datos[15] = "";
            datos[16] = "";
            datos[17] = 0;
            datos[18] = 0;
            ArticleGEPBR vArticle = new ArticleGEPBR(datos);
            return vArticle;
        }

        public static PropArtGEPBR AddRowListp()
        {
            DataTable tabla = new DataTable();
            DataRow datos;
            tabla.Columns.Add("propert_by_article_id");
            tabla.Columns.Add("article_id");
            tabla.Columns.Add("property_id");
            tabla.Columns.Add("value");
            tabla.Columns.Add("CheckSave");
            tabla.Columns.Add("CheckModify");
            datos = tabla.NewRow();
            datos[0] = 0;
            datos[1] = 0;
            datos[2] = 0;
            datos[3] = "";
            datos[4] = 0;
            datos[5] = 0;
            PropArtGEPBR vProperties = new PropArtGEPBR(datos);
            return vProperties;
        }
    }
}
