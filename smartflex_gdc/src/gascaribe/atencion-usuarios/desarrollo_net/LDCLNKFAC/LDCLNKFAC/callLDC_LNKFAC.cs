using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;
using OpenSystems.Common.Data;
using System.Windows.Forms;
using System.Data;
using System.Data.Common;

namespace LDCLNKFAC
{
    public class callLDC_LNKFAC : IOpenExecutable
    {
        public static string ToPrettyString<TKey, TValue>(IDictionary<TKey, TValue> dict)
        {
            var str = new StringBuilder();
            str.Append("{");
            foreach (var pair in dict)
            {
                str.Append(String.Format(" {0}={1}={2}, ", pair.Key, pair.Value, pair.Value?.GetType()));
            }
            str.Append("}");
            return str.ToString();
        }

        public static string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }

        public string getLinkKey()
        {
            using (DbCommand cmdCommand = OpenDataBase.db.GetStoredProcCommand("dald_parameter.fsbgetvalue_chain"))
            {
                OpenDataBase.db.AddInParameter(cmdCommand, "inuPARAMETER_Id", DbType.String, "CNCRM_LINK_FACTURAS_KEY");
                OpenDataBase.db.AddParameter(cmdCommand, @"RETURN_VALUE", DbType.String, ParameterDirection.ReturnValue, string.Empty, DataRowVersion.Default, null);
                OpenDataBase.db.ExecuteNonQuery(cmdCommand);

                return Convert.ToString(OpenDataBase.db.GetParameterValue(cmdCommand, @"RETURN_VALUE"));
            }
        }

        public void Execute(Dictionary<string, object> parameters)
        {
            try
            {
                var entityName = parameters["ENTITYNAME"] as string;
                var invoiceId = (System.Decimal)parameters["DEFAULTWHERE"];
                if (entityName != "FACTURA")
                {
                    MessageBox.Show("El item seleccionado no es una factura");
                    return;
                }

                var key = getLinkKey();
                var user = OpenDataBase.CurrentUserInfo.Mask;

                var json = "{\"key\": \"" + key + "\", \"user\": \"" + user + "\", \"invoiceId\": \"" + invoiceId + "\"}";

                var url = "https://linkfacturas.cl.innovacion-gascaribe.com/?req=" + Base64Encode(json);

                System.Diagnostics.Process.Start(url);

            } catch (Exception err)
            {
                MessageBox.Show("Error: " + err.Message);
            }
        }
    }
}
