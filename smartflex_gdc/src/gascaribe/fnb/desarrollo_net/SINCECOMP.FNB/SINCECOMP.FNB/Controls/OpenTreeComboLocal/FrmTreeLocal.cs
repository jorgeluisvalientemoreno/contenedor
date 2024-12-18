using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using OpenSystems.Windows.Resources.TreeHierarchicalData;

namespace SINCECOMP.FNB.Controls.OpenTreeComboLocal
{
    public partial class FrmTreeLocal : OpenForm
    {
        private string _KeyField = string.Empty;
        private string _ParentField = string.Empty;
        private string _DescriptionField = string.Empty;
        private string _DBTableName = string.Empty;
        private long _Selected = -1;
        private long auxSelected = -1;
        private SchemaDataOnlyMasterDetail _treedata;
        private DataProviderDataBaseOMD _dataProvider = new OpenSystems.Windows.Resources.TreeHierarchicalData.DataProviderDataBaseOMD();
        
        public FrmTreeLocal()
        {
            InitializeComponent();
        }

        public long Selected
        {
            get{return _Selected;}
            set{_Selected = value;}
        }

        public OpenSystems.Windows.Resources.TreeHierarchicalData.SchemaDataOnlyMasterDetail TreeData
        {
            get{return _treedata;}
            set{_treedata = value;}
        }

        private void FrmTreeLocal_Load(object sender, EventArgs e)
        {
            // Guarda el id seleccionado aal iniciar el formulario
            this.auxSelected = _Selected;
            this.tree.Nodes.Clear();
            // En caso de no haber un orien de datos instanciado
            // se retorna dejando el arbol vacio
            if (this._treedata == null)
            {
                return;
            }

            // Carga los datos estructurados para el Arbol.
            _dataProvider.DataTable = this._treedata.treeview_data;
            this.tree.DataSource = _dataProvider;
            this.tree.Fill();
            this.tree.ExpandAll();

            this._Selected = this.auxSelected;
            if (this._Selected == -1)
            {
                this.tree.SelectedNode = null;
            }
            else
            {
                TreeNodeDatabaseOMD node = _dataProvider.FindNodeById(this.tree.Nodes, Convert.ToInt32(this._Selected));
                this.tree.SelectedNode = node;
                if (this.tree.SelectedNode != null)
                {
                    this.tree.SelectedNode.EnsureVisible();
                    this.tree.SelectedNode.Checked = true;
                }
                this.tree.Select();
            }	
        }

        private void tree_AfterSelect(object sender, TreeViewEventArgs e)
        {
            // Establece el nuevo id seleccionado
            if (((TreeNodeDatabaseOMD)e.Node).Id != Convert.ToInt64(this.Selected))
                this.Selected = Convert.ToInt64(((TreeNodeDatabaseOMD)e.Node).Id);
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            // En caso de cancelar el id seleccionado debe quedar con el 
            // que originalmente se desplego el arbol.
            this.Selected = this.auxSelected;
        }
    }
}