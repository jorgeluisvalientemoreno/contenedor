namespace SINCECOMP.FNB.UI
{
    partial class LDRVOUCHER_GDC
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
            this.components = new System.ComponentModel.Container();
            Microsoft.Reporting.WinForms.ReportDataSource reportDataSource1 = new Microsoft.Reporting.WinForms.ReportDataSource();
            Microsoft.Reporting.WinForms.ReportDataSource reportDataSource2 = new Microsoft.Reporting.WinForms.ReportDataSource();
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            this.datosAdicionalBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.datosComandoBindingSource = new System.Windows.Forms.BindingSource(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.datosAdicionalBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.datosComandoBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // reportViewer1
            // 
            this.reportViewer1.Dock = System.Windows.Forms.DockStyle.Fill;
            reportDataSource1.Name = "Datos_Adicional";
            reportDataSource1.Value = this.datosAdicionalBindingSource;
            reportDataSource2.Name = "Datos_Comando";
            reportDataSource2.Value = this.datosComandoBindingSource;
            this.reportViewer1.LocalReport.DataSources.Add(reportDataSource1);
            this.reportViewer1.LocalReport.DataSources.Add(reportDataSource2);
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "SINCECOMP.FNB.Report.Report.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(0, 0);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.Size = new System.Drawing.Size(654, 447);
            this.reportViewer1.TabIndex = 1;
            // 
            // datosAdicionalBindingSource
            // 
            this.datosAdicionalBindingSource.DataSource = typeof(SINCECOMP.FNB.Entities.Datos_Adicional);
            // 
            // datosComandoBindingSource
            // 
            this.datosComandoBindingSource.DataSource = typeof(SINCECOMP.FNB.Entities.Datos_Comando);
            // 
            // LDRVOUCHER_GDC
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(654, 447);
            this.Controls.Add(this.reportViewer1);
            this.Name = "LDRVOUCHER_GDC";
            this.Text = "LDRVOUCHERGDC";
            this.Load += new System.EventHandler(this.LDRVOUCHER_GDC_Load);
            ((System.ComponentModel.ISupportInitialize)(this.datosAdicionalBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.datosComandoBindingSource)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Microsoft.Reporting.WinForms.ReportViewer reportViewer1;
        private System.Windows.Forms.BindingSource datosAdicionalBindingSource;
        private System.Windows.Forms.BindingSource datosComandoBindingSource;
    }
}