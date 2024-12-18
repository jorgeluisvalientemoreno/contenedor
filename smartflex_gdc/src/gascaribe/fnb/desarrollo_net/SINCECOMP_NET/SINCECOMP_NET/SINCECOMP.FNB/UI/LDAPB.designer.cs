namespace SINCECOMP.FNB.UI
{
    partial class LDAPB
    {
        /// <summary>
        /// Variable del diseñador requerida.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén utilizando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben eliminar; false en caso contrario, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido del método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            Infragistics.Win.UltraWinTree.UltraTreeColumnSet ultraTreeColumnSet1 = new Infragistics.Win.UltraWinTree.UltraTreeColumnSet();
            Infragistics.Win.UltraWinTree.UltraTreeNode ultraTreeNode1 = new Infragistics.Win.UltraWinTree.UltraTreeNode();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LDAPB));
            Infragistics.Win.UltraWinTree.UltraTreeNode ultraTreeNode2 = new Infragistics.Win.UltraWinTree.UltraTreeNode();
            Infragistics.Win.UltraWinTree.UltraTreeNode ultraTreeNode3 = new Infragistics.Win.UltraWinTree.UltraTreeNode();
            Infragistics.Win.UltraWinTree.UltraTreeNode ultraTreeNode4 = new Infragistics.Win.UltraWinTree.UltraTreeNode();
            Infragistics.Win.UltraWinTree.UltraTreeNode ultraTreeNode5 = new Infragistics.Win.UltraWinTree.UltraTreeNode();
            Infragistics.Win.UltraWinTree.UltraTreeNode ultraTreeNode6 = new Infragistics.Win.UltraWinTree.UltraTreeNode();
            Infragistics.Win.UltraWinTree.UltraTreeNode ultraTreeNode7 = new Infragistics.Win.UltraWinTree.UltraTreeNode();
            this.tvOptions = new Infragistics.Win.UltraWinTree.UltraTree();
            this.opPpal = new System.Windows.Forms.Panel();
            ((System.ComponentModel.ISupportInitialize)(this.tvOptions)).BeginInit();
            this.SuspendLayout();
            // 
            // tvOptions
            // 
            this.tvOptions.ColumnSettings.RootColumnSet = ultraTreeColumnSet1;
            this.tvOptions.Dock = System.Windows.Forms.DockStyle.Left;
            this.tvOptions.Location = new System.Drawing.Point(0, 0);
            this.tvOptions.Name = "tvOptions";
            ultraTreeNode1.LeftImages.Add(((object)(resources.GetObject("ultraTreeNode1.LeftImages"))));
            ultraTreeNode1.Text = "Definición artículos";
            ultraTreeNode2.LeftImages.Add(((object)(resources.GetObject("ultraTreeNode2.LeftImages"))));
            ultraTreeNode2.Text = "Definición Lista de Precios";
            ultraTreeNode3.LeftImages.Add(((object)(resources.GetObject("ultraTreeNode3.LeftImages"))));
            ultraTreeNode3.Text = "Crear una Lista A partir de una existente";
            ultraTreeNode4.LeftImages.Add(((object)(resources.GetObject("ultraTreeNode4.LeftImages"))));
            ultraTreeNode4.Text = "Impresión de Lista";
            ultraTreeNode5.LeftImages.Add(((object)(resources.GetObject("ultraTreeNode5.LeftImages"))));
            ultraTreeNode5.Text = "Admin. de Propiedades de artículo";
            ultraTreeNode6.LeftImages.Add(((object)(resources.GetObject("ultraTreeNode6.LeftImages"))));
            ultraTreeNode6.Text = "Definición de Comisiones";
            ultraTreeNode7.LeftImages.Add(((object)(resources.GetObject("ultraTreeNode7.LeftImages"))));
            ultraTreeNode7.Text = "Definición de Marcas";
            ultraTreeNode7.Visible = false;
            this.tvOptions.Nodes.AddRange(new Infragistics.Win.UltraWinTree.UltraTreeNode[] {
            ultraTreeNode1,
            ultraTreeNode2,
            ultraTreeNode3,
            ultraTreeNode4,
            ultraTreeNode5,
            ultraTreeNode6,
            ultraTreeNode7});
            this.tvOptions.ShowLines = false;
            this.tvOptions.ShowRootLines = false;
            this.tvOptions.Size = new System.Drawing.Size(260, 427);
            this.tvOptions.TabIndex = 2;
            this.tvOptions.AfterSelect += new Infragistics.Win.UltraWinTree.AfterNodeSelectEventHandler(this.tvOptions_AfterSelect);
            this.tvOptions.BeforeSelect += new Infragistics.Win.UltraWinTree.BeforeNodeSelectEventHandler(this.tvOptions_BeforeSelect);
            // 
            // opPpal
            // 
            this.opPpal.Dock = System.Windows.Forms.DockStyle.Fill;
            this.opPpal.Location = new System.Drawing.Point(260, 0);
            this.opPpal.Name = "opPpal";
            this.opPpal.Size = new System.Drawing.Size(875, 427);
            this.opPpal.TabIndex = 3;
            // 
            // LDAPB
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(1135, 427);
            this.Controls.Add(this.opPpal);
            this.Controls.Add(this.tvOptions);
            this.MinimumSize = new System.Drawing.Size(1143, 454);
            this.Name = "LDAPB";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Administración de Productos Brilla (LDAPB)";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.LDAPB_FormClosing);
            this.Load += new System.EventHandler(this.LDAPB_Load);
            ((System.ComponentModel.ISupportInitialize)(this.tvOptions)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Infragistics.Win.UltraWinTree.UltraTree tvOptions;
        private System.Windows.Forms.Panel opPpal;
    }
}