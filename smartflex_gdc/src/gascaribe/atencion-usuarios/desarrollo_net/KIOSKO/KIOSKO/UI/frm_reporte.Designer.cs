namespace KIOSKO.UI
{
    partial class frm_reporte
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
            this.cr_viewer = new CrystalDecisions.Windows.Forms.CrystalReportViewer();
            this.SuspendLayout();
            // 
            // cr_viewer
            // 
            this.cr_viewer.ActiveViewIndex = -1;
            this.cr_viewer.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.cr_viewer.Cursor = System.Windows.Forms.Cursors.Default;
            this.cr_viewer.Dock = System.Windows.Forms.DockStyle.Fill;
            this.cr_viewer.Location = new System.Drawing.Point(0, 0);
            this.cr_viewer.Name = "cr_viewer";
            this.cr_viewer.ShowGroupTreeButton = false;
            this.cr_viewer.ShowParameterPanelButton = false;
            this.cr_viewer.ShowRefreshButton = false;
            this.cr_viewer.ShowTextSearchButton = false;
            this.cr_viewer.Size = new System.Drawing.Size(848, 427);
            this.cr_viewer.TabIndex = 0;
            this.cr_viewer.ToolPanelView = CrystalDecisions.Windows.Forms.ToolPanelViewType.None;
            // 
            // frm_reporte
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(848, 427);
            this.Controls.Add(this.cr_viewer);
            this.Name = "frm_reporte";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "REPORTE";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.ResumeLayout(false);

        }

        #endregion

        public CrystalDecisions.Windows.Forms.CrystalReportViewer cr_viewer;

    }
}