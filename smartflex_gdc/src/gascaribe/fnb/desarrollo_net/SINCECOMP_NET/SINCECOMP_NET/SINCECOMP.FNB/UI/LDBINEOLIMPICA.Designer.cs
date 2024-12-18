namespace SINCECOMP.FNB.UI
{
    partial class LDBINEOLIMPICA
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
            this.components = new System.ComponentModel.Container();
            Microsoft.Reporting.WinForms.ReportDataSource reportDataSource1 = new Microsoft.Reporting.WinForms.ReportDataSource();
            this.ReportBineOlimpicaBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            ((System.ComponentModel.ISupportInitialize)(this.ReportBineOlimpicaBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // ReportBineOlimpicaBindingSource
            // 
            this.ReportBineOlimpicaBindingSource.DataSource = typeof(SINCECOMP.FNB.Entities.ReportBineOlimpica);
            // 
            // reportViewer1
            // 
            this.reportViewer1.Dock = System.Windows.Forms.DockStyle.Fill;
            reportDataSource1.Name = "SINCECOMP_FNB_Entities_ReportBineOlimpica";
            reportDataSource1.Value = this.ReportBineOlimpicaBindingSource;
            this.reportViewer1.LocalReport.DataSources.Add(reportDataSource1);
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "SINCECOMP.FNB.Report.rptBineOlimpica.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.Size = new System.Drawing.Size(730, 577);
            this.reportViewer1.TabIndex = 0;
            
            // 
            // LDBINEOLIMPICA
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(730, 577);
            this.Controls.Add(this.reportViewer1);
            this.Name = "LDBINEOLIMPICA";
            this.Text = "LDBINEOLIMPICA";
            this.Load += new System.EventHandler(this.LDBINEOLIMPICA_Load);
            ((System.ComponentModel.ISupportInitialize)(this.ReportBineOlimpicaBindingSource)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer reportViewer1;
        private System.Windows.Forms.BindingSource ReportBineOlimpicaBindingSource;
    }
}