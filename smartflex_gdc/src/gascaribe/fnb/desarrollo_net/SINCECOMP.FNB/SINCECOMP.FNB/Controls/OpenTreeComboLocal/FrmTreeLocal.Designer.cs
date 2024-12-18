namespace SINCECOMP.FNB.Controls.OpenTreeComboLocal
{
    partial class FrmTreeLocal
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
            this.pnlTree = new System.Windows.Forms.Panel();
            this.btnCancel = new Infragistics.Win.Misc.UltraButton();
            this.btnAccept = new Infragistics.Win.Misc.UltraButton();
            this.tree = new OpenSystems.Windows.Controls.OpenTreeHierarchicalData();
            this.pnlControls = new System.Windows.Forms.Panel();
            this.pnlTree.SuspendLayout();
            this.SuspendLayout();
            // 
            // pnlTree
            // 
            this.pnlTree.Controls.Add(this.btnCancel);
            this.pnlTree.Controls.Add(this.btnAccept);
            this.pnlTree.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.pnlTree.Location = new System.Drawing.Point(0, 384);
            this.pnlTree.Name = "pnlTree";
            this.pnlTree.Size = new System.Drawing.Size(352, 32);
            this.pnlTree.TabIndex = 1;
            // 
            // btnCancel
            // 
            this.btnCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnCancel.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.btnCancel.Location = new System.Drawing.Point(270, 5);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 3;
            this.btnCancel.Text = "&Cancelar";
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnAccept
            // 
            this.btnAccept.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnAccept.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.btnAccept.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.btnAccept.Location = new System.Drawing.Point(194, 5);
            this.btnAccept.Name = "btnAccept";
            this.btnAccept.Size = new System.Drawing.Size(75, 23);
            this.btnAccept.TabIndex = 2;
            this.btnAccept.Text = "&Aceptar";
            // 
            // tree
            // 
            this.tree.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.tree.DataSource = null;
            this.tree.Indent = 19;
            this.tree.ItemHeight = 16;
            this.tree.Location = new System.Drawing.Point(6, 8);
            this.tree.Name = "tree";
            this.tree.Size = new System.Drawing.Size(338, 368);
            this.tree.TabIndex = 2;
            this.tree.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.tree_AfterSelect);
            // 
            // pnlControls
            // 
            this.pnlControls.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlControls.Location = new System.Drawing.Point(0, 0);
            this.pnlControls.Name = "pnlControls";
            this.pnlControls.Size = new System.Drawing.Size(352, 384);
            this.pnlControls.TabIndex = 3;
            // 
            // FrmTreeLocal
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(352, 416);
            this.Controls.Add(this.tree);
            this.Controls.Add(this.pnlControls);
            this.Controls.Add(this.pnlTree);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Name = "FrmTreeLocal";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FrmTreeLocal";
            this.Load += new System.EventHandler(this.FrmTreeLocal_Load);
            this.pnlTree.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pnlTree;
        private Infragistics.Win.Misc.UltraButton btnCancel;
        private Infragistics.Win.Misc.UltraButton btnAccept;
        private OpenSystems.Windows.Controls.OpenTreeHierarchicalData tree;
        private System.Windows.Forms.Panel pnlControls;
    }
}