using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using OpenSystems.Common;
using OpenSystems.Common.Data;
using System.Data.Common;
using OpenSystems.Common.ExceptionHandler;
using OpenSystems.Common.Util;
using System.Globalization;
using System.Diagnostics;

namespace ORCUO
{
    public partial class ORCUO : OpenForm
    {
        Int64 _nuOperUnitCurrent;
        string filterField = "Nombre unidad";
        DataTable dtUnit = new DataTable();

        struct itemCurrent
        {
            public Int64 id;
            public double quota;
            public double balance;
        } 

        List<itemCurrent> _itemsByUnit = new List<itemCurrent>();

        public ORCUO()
        {
            InitializeComponent();
            LoadData();
            //killProcess();
        }        


        private void LoadData()
        {
            // Se cargan las unidades de trabajo
            DataSet _dsUnitOper = initUnitOper();            

            dtUnit.Columns.Add("Id de Unidad");
            dtUnit.Columns.Add("Nombre unidad");
            dtUnit.Columns.Add("Persona a cargo");

            foreach (DataRow row in _dsUnitOper.Tables[0].Rows)
            {
                DataRow rowdg = dtUnit.NewRow();
                rowdg["Id de Unidad"] = row["OPERATING_UNIT_ID"];
                rowdg["Nombre unidad"] = row["NAME"].ToString();
                rowdg["Persona a cargo"] = row["Persona"].ToString();
               
                dtUnit.Rows.Add(rowdg);
            }

            this.dgvUnidades.DataSource = dtUnit;

            this.dgvUnidades.Columns["Id de Unidad"].ReadOnly = true;
            this.dgvUnidades.Columns["Id de Unidad"].Width = 95;
            this.dgvUnidades.Columns["Nombre unidad"].ReadOnly = true;
            this.dgvUnidades.Columns["Nombre unidad"].Width = 275;
            this.dgvUnidades.Columns["Persona a cargo"].ReadOnly = true;
            this.dgvUnidades.Columns["Persona a cargo"].Width = 275;

            this.dgvUnidades.Sort(this.dgvUnidades.Columns["Id de Unidad"],ListSortDirection.Ascending);
            this.dgvUnidades.Sort(this.dgvUnidades.Columns["Nombre unidad"], ListSortDirection.Ascending);
            this.dgvUnidades.Sort(this.dgvUnidades.Columns["Persona a cargo"], ListSortDirection.Ascending);
                           

            //Se carga el balance de la primera unidad de trabajo
            Int64 nuOperUnit = Convert.ToInt64(this.dgvUnidades.Rows[0].Cells["Id de Unidad"].Value);
            this.loadBalanceByUnit(nuOperUnit);

            _nuOperUnitCurrent = nuOperUnit;

        }

        // Obtiene la lista de valores de los items
        List<string> getArrayItemsLOV(Int64 inuOperUnit, string isbLoadAll)
        {
            List<string> lstItems = new List<string>();
            DataSet _dsLOV = GetItemsLOV(inuOperUnit, isbLoadAll);

            foreach (DataRow row in _dsLOV.Tables[0].Rows)
            {
                lstItems.Add(row["ID"] + " - " + row["DESCRIPTION"]);
            }
            
            return lstItems;
        }

        //Obtiene la posicion de la lista dada la descripcion
        int getPosListByDesc(List<string> ilsItems, string isbDescription)
        {
            int idx = 0;
            idx = ilsItems.FindIndex(x => x == isbDescription);
            return idx;
        }        

        // Obtiene las unidades de trabajo de la pesona conectada
        internal static DataSet initUnitOper()
        {
            DataSet _dsReturn = new DataSet();

            try
            {
                using (DbCommand dbCommand = OpenDataBase.db.GetStoredProcCommand("LDC_Pk_ORCUO.GetUnitOperByPerson"))
                {
                    _dsReturn = OpenDataBase.db.ExecuteDataSet(dbCommand);
                }
            }
            catch (Exception)
            {
                throw;
            }
            return _dsReturn;
        }

        // Obtiene los saldos de los items, teniendo en cuenta la unidad
        internal static DataSet initBalance(Int64 inuOperUnit)
        {
            DataSet _dsReturn = new DataSet();

            try
            {
                using (DbCommand dbCommand = OpenDataBase.db.GetStoredProcCommand("LDC_Pk_ORCUO.GetBalanceByOper"))
                {
                    OpenDataBase.db.AddInParameter(dbCommand, "inuOperUnit", DbType.Int64, inuOperUnit);
                    OpenDataBase.db.AddParameterRefCursor(dbCommand);
                    _dsReturn = OpenDataBase.db.ExecuteDataSet(dbCommand);
                }
            }
            catch (Exception)
            {
                throw;
            }
            return _dsReturn;
        }

        // Obtiene las unidades de trabajo de la pesona conectada
        internal static DataSet GetItemsLOV(Int64 inuOperUnit, string isbLoadAll)
        {
            DataSet _dsReturn = new DataSet();

            try
            {
                using (DbCommand dbCommand = OpenDataBase.db.GetStoredProcCommand("LDC_Pk_ORCUO.GetItemsLOV"))
                {
                    OpenDataBase.db.AddInParameter(dbCommand, "inuOperUnit", DbType.Int64, inuOperUnit);
                    OpenDataBase.db.AddInParameter(dbCommand, "isbLoadAll", DbType.String, isbLoadAll);
                    _dsReturn = OpenDataBase.db.ExecuteDataSet(dbCommand);
                }
            }
            catch (Exception)
            {
                throw;
            }
            return _dsReturn;
        }

        private void dgvUnidades_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            // Se obtienen los items a modificar
            List<itemCurrent> itemsToSend = this.fsbGetItemsChange();
            Int64 nuOperUnit;

            if (itemsToSend.Count > 0)
            {
                DialogResult dialogResult = MessageBox.Show("Los ítems fueron modificados. ¿Desea guardar los cambios?", "Advertencia", MessageBoxButtons.YesNo);
                if (dialogResult == DialogResult.Yes)
                {
                    // Se envian a la base de datos los nuevos items y los modificados
                    foreach (itemCurrent item in itemsToSend)
                    {
                        this.CreateORUpdateBalance
                        (
                            this._nuOperUnitCurrent,
                            item.id,
                            item.quota,
                            item.balance
                        );
                    }

                    MessageBox.Show("Los datos han sido actualizados correctamente.");                    
                }
                else if (dialogResult == DialogResult.No)
                {
                    nuOperUnit = Convert.ToInt64(this.dgvUnidades.Rows[e.RowIndex].Cells["Id de Unidad"].Value);
                    _nuOperUnitCurrent = nuOperUnit;
                }

                nuOperUnit = Convert.ToInt64(this.dgvUnidades.Rows[e.RowIndex].Cells["Id de Unidad"].Value);
                _nuOperUnitCurrent = nuOperUnit;

                /*Se carga la información de las unidades */
                this.loadBalanceByUnit(nuOperUnit);
            }
            else
            {
                if (e.RowIndex > -1)
                {
                    if (e.RowIndex == (this.dgvUnidades.RowCount - 1))
                    {
                        /*Se carga la información de las unidades */
                        this.loadBalanceByUnit(0);
                    }
                    else
                    {
                        nuOperUnit = Convert.ToInt64(this.dgvUnidades.Rows[e.RowIndex].Cells["Id de Unidad"].Value);
                        _nuOperUnitCurrent = nuOperUnit;

                        /*Se carga la información de las unidades */
                        this.loadBalanceByUnit(nuOperUnit);
                    }                    
                }                
            }
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            /*Inicializar lista de valores del combobox*/
            List<string> lstItems = getArrayItemsLOV(this._nuOperUnitCurrent, "N");

            DataGridViewComboBoxCell cmbItems = new DataGridViewComboBoxCell();
            DataGridViewRow RowBalance = new DataGridViewRow();
            DataGridViewCell cellBalance = new DataGridViewTextBoxCell();
            DataGridViewCell cellQuota = new DataGridViewTextBoxCell();

            // Celda item
            cmbItems.DataSource = lstItems;
            cmbItems.Value = lstItems[0];

            // Celda cupo
            cellQuota.Value = 0;

            // Celda saldo
            cellBalance.Value = 0;

            // Se adicionan las celdas a la fila
            RowBalance.Cells.Add(cmbItems);
            RowBalance.Cells.Add(cellQuota);
            RowBalance.Cells.Add(cellBalance);
            
            // Se adiciona la fila al datagrid
            this.dgvBalance.Rows.Add(RowBalance);

            cmbItems.ReadOnly = false;
            cellQuota.ReadOnly = false;
                                   
        }

        // Obtienes los saldos por unidad de trabajo y los adiciona al datagrid
        private void loadBalanceByUnit(Int64 inuOperUnit)
        {
            //Se limpian los items actuales
            this._itemsByUnit.Clear();
            
            // Se limpia el datagrid
            this.dgvBalance.Rows.Clear();            
            //Se cargan los nevos valores
            DataSet _dsReturnBalan = initBalance(inuOperUnit);            
            /*Inicializar lista de valores del combobox*/
            List<string> lstItems = getArrayItemsLOV(inuOperUnit,"Y");
            int idx = 0;
     
            foreach (DataRow row in _dsReturnBalan.Tables[0].Rows)
            {
                DataGridViewComboBoxCell cmbItems = new DataGridViewComboBoxCell();
                DataGridViewRow RowBalance = new DataGridViewRow();
                DataGridViewCell cellBalance = new DataGridViewTextBoxCell();
                DataGridViewCell cellQuota = new DataGridViewTextBoxCell();

                itemCurrent itemCurr;

                itemCurr.id = Convert.ToInt64(row["ID"].ToString());
                itemCurr.quota = double.Parse(row["QUOTA"].ToString(), CultureInfo.InvariantCulture); 

                itemCurr.balance = double.Parse(row["BALANCE"].ToString(), CultureInfo.InvariantCulture);
                
                this._itemsByUnit.Add(itemCurr);
                
                // Celda item
                idx = getPosListByDesc(lstItems, row["ID"].ToString() + " - " + row["ITEM"].ToString());
                //if(idx >= 0)
                //{
                    cmbItems.DataSource = lstItems;
                    cmbItems.Value = lstItems[idx];
                //}

                // Celda cupo
                cellQuota.Value = row["QUOTA"];

                // Celda saldo
                cellBalance.Value = row["BALANCE"];
                
                // Se adicionan las celdas a la fila
                RowBalance.Cells.Add(cmbItems);
                RowBalance.Cells.Add(cellQuota);
                RowBalance.Cells.Add(cellBalance);                
                // Se adiciona la fila al datagrid
                this.dgvBalance.Rows.Add(RowBalance);                
                                
            }

            this.dgvBalance.Columns[0].ReadOnly = true;
            //this.dgvBalance.Columns[0].Width = 438;
            this.dgvBalance.Columns[1].ReadOnly = false;
            //this.dgvBalance.Columns[1].Width = 100;
            this.dgvBalance.Columns[2].ReadOnly = true;
            //this.dgvBalance.Columns[2].Width = 100;
            this.dgvBalance.Columns[0].Width = dgvBalance.Width / 3;
            this.dgvBalance.Columns[1].Width = dgvBalance.Width / 3;
            this.dgvBalance.Columns[2].Width = dgvBalance.Width / 3;
        }

        // Obtiene el identificador del item
        private Int64 fnuGetItemIdByDesc(string isbDescription)
        {
            string[] sbCad = isbDescription.Split(new[] { " - " }, StringSplitOptions.None);
            return Convert.ToInt64(sbCad[0]);
        }

        private double fnuGetNumber(string isbValue)
        {
            double nuValue;
            try
            {
                nuValue = double.Parse(isbValue, CultureInfo.InvariantCulture);
                return nuValue;
            }
            catch
            {
                ExceptionHandler.EvaluateErrorCode(2741, "Los valor [" + isbValue + "] debe ser numérico.");
                return -1;
            }
        }

        // Obtiene los items que se han agregado o modificado para hacerlo en la base de datos
        List<itemCurrent> fsbGetItemsChange()
        {
            List<itemCurrent> lstItemsChange = new List<itemCurrent>();

            foreach (DataGridViewRow dgvRow in this.dgvBalance.Rows)
            {
                int nuFlag = 0;

                foreach (itemCurrent item in this._itemsByUnit)
                {
                    if (dgvRow.Cells[0].Value != null)
	                {
                        if (item.id == this.fnuGetItemIdByDesc(dgvRow.Cells[0].Value.ToString()))
                        {
                            // Flag que indica que es nuevo
                            nuFlag = 1;
                            if (item.quota != this.fnuGetNumber(dgvRow.Cells[1].Value.ToString()) ||
                                item.balance != this.fnuGetNumber(dgvRow.Cells[2].Value.ToString()))
                            {
                                itemCurrent itemChange;
                                itemChange.id = item.id;
                                itemChange.quota = this.fnuGetNumber(dgvRow.Cells[1].Value.ToString());
                                itemChange.balance = this.fnuGetNumber(dgvRow.Cells[2].Value.ToString());
                                //Se adiciona el item a modificar
                                lstItemsChange.Add(itemChange);
                            }
                        }
	                }                          
                }

                // Se valida que el item que se esta validando no exista
                if (nuFlag == 0 && dgvRow.Cells[0].Value != null)
                {
                    itemCurrent itemChange;
                    itemChange.id = this.fnuGetItemIdByDesc(dgvRow.Cells[0].Value.ToString());
                    itemChange.quota = this.fnuGetNumber(dgvRow.Cells[1].Value.ToString());
                    itemChange.balance = this.fnuGetNumber(dgvRow.Cells[2].Value.ToString());

                    lstItemsChange.Add(itemChange);
                }                                
            }
            return lstItemsChange;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            //Se obtienen los items a modificar
            List<itemCurrent> itemsToSend = this.fsbGetItemsChange();

            // Se envian a la base de datos los nuevos items y los modificados
            foreach (itemCurrent item in itemsToSend)
            {
                this.CreateORUpdateBalance
                (
                    this._nuOperUnitCurrent,
                    item.id,
                    item.quota,
                    item.balance
                );
            }

            MessageBox.Show("Los datos han sido actualizados correctamente.");
        }

        // Actualiza la informacion en la base de datos
        private void CreateORUpdateBalance(Int64 inuOperUnit, Int64 inuItemsId, double inuQuota, double inuBalance)
        {

            try
            {
                using (DbCommand dbCommand = OpenDataBase.db.GetStoredProcCommand("LDC_Pk_ORCUO.CreOrUpdBalance"))
                {
                    OpenDataBase.db.AddInParameter(dbCommand, "inuOperUnit", DbType.Int64, inuOperUnit);
                    OpenDataBase.db.AddInParameter(dbCommand, "inuItemsId", DbType.Int64, inuItemsId);
                    OpenDataBase.db.AddInParameter(dbCommand, "inuQuota", DbType.Int64, inuQuota);
                    OpenDataBase.db.AddInParameter(dbCommand, "inuBalance", DbType.Int64, inuBalance);
                    OpenDataBase.db.ExecuteNonQuery(dbCommand);
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        /*Se elimina proceso ProgressLog debido a que en ocasiones cuando se cargaba la forma
         simulaba que cargaba información cuando no era asi*/
        public void killProcess()
        {
            foreach (Process proceso in Process.GetProcesses())
            {
                if (proceso.ProcessName == "ProgressLog")
                {
                    proceso.Kill();
                }
            }
        }        

        private void textBoxFilterUnit_TextChanged_1(object sender, EventArgs e)
        {
            dtUnit.DefaultView.RowFilter = string.Format("[{0}] LIKE '%{1}%'", filterField, textBoxFilterUnit.Text);
        }

        private void dgvUnidades_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void ORCUO_Resize(object sender, EventArgs e)
        {
            textBoxFilterUnit.Width = this.Width / 3;
            dgvUnidades.Width = this.Width - 30;
            //dgvUnidades.Height = this.Height / 3;
            dgvBalance.Width = this.Width - 30;
            dgvBalance.Height = this.Height - 291;

            dgvUnidades.Columns[0].Width = dgvUnidades.Width / 3;
            dgvUnidades.Columns[1].Width = dgvUnidades.Width / 3;
            dgvUnidades.Columns[2].Width = dgvUnidades.Width / 3;

            dgvBalance.Columns[0].Width = dgvBalance.Width / 3;
            dgvBalance.Columns[1].Width = dgvBalance.Width / 3;
            dgvBalance.Columns[2].Width = dgvBalance.Width / 3;

            //btnAdd.Top = dgvBalance.Top - 10;
            //btnSave.Top = dgvBalance.Top - 10;
            //btnAdd.Top = this.Height - dgvBalance.Height;
            //btnSave.Top = this.Height - dgvBalance.Height;
        }
    }
}
