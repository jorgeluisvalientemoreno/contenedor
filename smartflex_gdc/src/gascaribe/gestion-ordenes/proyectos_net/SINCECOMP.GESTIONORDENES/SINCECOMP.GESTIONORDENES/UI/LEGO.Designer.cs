namespace SINCECOMP.GESTIONORDENES.UI
{
    partial class LEGO
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.TreeNode treeNode1 = new System.Windows.Forms.TreeNode("Gestion");
            System.Windows.Forms.TreeNode treeNode2 = new System.Windows.Forms.TreeNode("Confirmacion");
            System.Windows.Forms.TreeNode treeNode3 = new System.Windows.Forms.TreeNode("Ordenes de Trabajo", new System.Windows.Forms.TreeNode[] {
            treeNode1,
            treeNode2});
            System.Windows.Forms.TreeNode treeNode4 = new System.Windows.Forms.TreeNode("Ordenes Confirmadas");
            System.Windows.Forms.TreeNode treeNode5 = new System.Windows.Forms.TreeNode("Reportes", new System.Windows.Forms.TreeNode[] {
            treeNode4});
            Infragistics.Win.UltraWinTree.UltraTreeColumnSet ultraTreeColumnSet1 = new Infragistics.Win.UltraWinTree.UltraTreeColumnSet();
            Infragistics.Win.UltraWinTree.UltraTreeNode ultraTreeNode1 = new Infragistics.Win.UltraWinTree.UltraTreeNode();
            Infragistics.Win.UltraWinTree.UltraTreeNode ultraTreeNode2 = new Infragistics.Win.UltraWinTree.UltraTreeNode();
            Infragistics.Win.UltraWinTree.UltraTreeNode ultraTreeNode3 = new Infragistics.Win.UltraWinTree.UltraTreeNode();
            Infragistics.Win.UltraWinTree.UltraTreeNode ultraTreeNode4 = new Infragistics.Win.UltraWinTree.UltraTreeNode();
            Infragistics.Win.UltraWinTree.UltraTreeNode ultraTreeNode5 = new Infragistics.Win.UltraWinTree.UltraTreeNode();
            this.trvprocesos = new System.Windows.Forms.TreeView();
            this.pPrincipal = new System.Windows.Forms.Panel();
            this.tvOptions = new Infragistics.Win.UltraWinTree.UltraTree();
            this.opPpal = new System.Windows.Forms.Panel();
            ((System.ComponentModel.ISupportInitialize)(this.tvOptions)).BeginInit();
            this.SuspendLayout();
            // 
            // trvprocesos
            // 
            this.trvprocesos.Location = new System.Drawing.Point(636, 370);
            this.trvprocesos.Name = "trvprocesos";
            treeNode1.Name = "trvOTGestion";
            treeNode1.Text = "Gestion";
            treeNode2.Name = "trvOTConfirmacion";
            treeNode2.Text = "Confirmacion";
            treeNode3.Name = "trvOT";
            treeNode3.Text = "Ordenes de Trabajo";
            treeNode4.Name = "trvReportesOTConfirmada";
            treeNode4.Text = "Ordenes Confirmadas";
            treeNode5.Name = "trvReportes";
            treeNode5.Text = "Reportes";
            this.trvprocesos.Nodes.AddRange(new System.Windows.Forms.TreeNode[] {
            treeNode3,
            treeNode5});
            this.trvprocesos.Size = new System.Drawing.Size(190, 180);
            this.trvprocesos.TabIndex = 0;
            // 
            // pPrincipal
            // 
            this.pPrincipal.Location = new System.Drawing.Point(832, 380);
            this.pPrincipal.Name = "pPrincipal";
            this.pPrincipal.Size = new System.Drawing.Size(190, 121);
            this.pPrincipal.TabIndex = 1;
            // 
            // tvOptions
            // 
            this.tvOptions.ColumnSettings.RootColumnSet = ultraTreeColumnSet1;
            this.tvOptions.Dock = System.Windows.Forms.DockStyle.Left;
            this.tvOptions.Location = new System.Drawing.Point(0, 0);
            this.tvOptions.Name = "tvOptions";
            ultraTreeNode2.Text = "Gestion";
            ultraTreeNode3.Text = "Confirmacion";
            ultraTreeNode1.Nodes.AddRange(new Infragistics.Win.UltraWinTree.UltraTreeNode[] {
            ultraTreeNode2,
            ultraTreeNode3});
            ultraTreeNode1.Text = "Ordenes de Trabajo";
            ultraTreeNode5.Text = "Ordenes Gestionadas";
            ultraTreeNode4.Nodes.AddRange(new Infragistics.Win.UltraWinTree.UltraTreeNode[] {
            ultraTreeNode5});
            ultraTreeNode4.Text = "Reportes";
            this.tvOptions.Nodes.AddRange(new Infragistics.Win.UltraWinTree.UltraTreeNode[] {
            ultraTreeNode1,
            ultraTreeNode4});
            this.tvOptions.ShowLines = false;
            this.tvOptions.ShowRootLines = false;
            this.tvOptions.Size = new System.Drawing.Size(173, 534);
            this.tvOptions.TabIndex = 3;
            this.tvOptions.AfterSelect += new Infragistics.Win.UltraWinTree.AfterNodeSelectEventHandler(this.tvOptions_AfterSelect);
            // 
            // opPpal
            // 
            this.opPpal.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.opPpal.Dock = System.Windows.Forms.DockStyle.Fill;
            this.opPpal.Location = new System.Drawing.Point(173, 0);
            this.opPpal.Name = "opPpal";
            this.opPpal.Size = new System.Drawing.Size(849, 534);
            this.opPpal.TabIndex = 4;
            // 
            // LEGO
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1022, 534);
            this.Controls.Add(this.opPpal);
            this.Controls.Add(this.tvOptions);
            this.Controls.Add(this.pPrincipal);
            this.Controls.Add(this.trvprocesos);
            this.Name = "LEGO";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "LEGO";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.LEGO_FormClosing);
            this.Load += new System.EventHandler(this.LDCGESORD_Load);
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.LEGO_KeyDown);
            ((System.ComponentModel.ISupportInitialize)(this.tvOptions)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TreeView trvprocesos;
        private System.Windows.Forms.Panel pPrincipal;
        private Infragistics.Win.UltraWinTree.UltraTree tvOptions;
        private System.Windows.Forms.Panel opPpal;
    }
}