namespace SINCECOMP.SUBSIDYS.UI
{
    partial class LDGRC
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LDGRC));
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Microsoft.Reporting.WinForms.ReportDataSource reportDataSource1 = new Microsoft.Reporting.WinForms.ReportDataSource();
            this.actaBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.fbdDirectory = new System.Windows.Forms.FolderBrowserDialog();
            this.openHeaderTitles1 = new OpenSystems.Windows.Controls.OpenHeaderTitles();
            this.ultraGroupBox1 = new Infragistics.Win.Misc.UltraGroupBox();
            this.btnImport = new OpenSystems.Windows.Controls.OpenButton();
            this.btnprocess = new OpenSystems.Windows.Controls.OpenButton();
            this.tbArchiveubication = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.lblDirectory = new Infragistics.Win.Misc.UltraLabel();
            this.openTitle1 = new OpenSystems.Windows.Controls.OpenTitle();
            this.panel1 = new System.Windows.Forms.Panel();
            this.reportViewer1 = new Microsoft.Reporting.WinForms.ReportViewer();
            ((System.ComponentModel.ISupportInitialize)(this.actaBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).BeginInit();
            this.ultraGroupBox1.SuspendLayout();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // actaBindingSource
            // 
            this.actaBindingSource.DataSource = typeof(SINCECOMP.SUBSIDYS.Entities.acta);
            // 
            // openHeaderTitles1
            // 
            this.openHeaderTitles1.BackColor = System.Drawing.Color.White;
            this.openHeaderTitles1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openHeaderTitles1.HeaderProtectedFields = ((System.Collections.Generic.Dictionary<string, string>)(resources.GetObject("openHeaderTitles1.HeaderProtectedFields")));
            this.openHeaderTitles1.HeaderSubtitle1 = "Generación de acta de cobro";
            this.openHeaderTitles1.HeaderTitle = "Generación de acta de cobro";
            this.openHeaderTitles1.Location = new System.Drawing.Point(0, 0);
            this.openHeaderTitles1.MaxWidth = -1;
            this.openHeaderTitles1.Name = "openHeaderTitles1";
            this.openHeaderTitles1.ParsedHeaderSubtitle2 = "";
            this.openHeaderTitles1.RowInformationHeader = null;
            this.openHeaderTitles1.Size = new System.Drawing.Size(462, 53);
            this.openHeaderTitles1.TabIndex = 46;
            // 
            // ultraGroupBox1
            // 
            this.ultraGroupBox1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.ultraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None;
            this.ultraGroupBox1.Controls.Add(this.btnImport);
            this.ultraGroupBox1.Controls.Add(this.btnprocess);
            this.ultraGroupBox1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.ultraGroupBox1.Location = new System.Drawing.Point(0, 138);
            this.ultraGroupBox1.Name = "ultraGroupBox1";
            this.ultraGroupBox1.Size = new System.Drawing.Size(462, 28);
            this.ultraGroupBox1.SupportThemes = false;
            this.ultraGroupBox1.TabIndex = 52;
            // 
            // btnImport
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnImport.Appearance = appearance1;
            this.btnImport.Location = new System.Drawing.Point(277, 1);
            this.btnImport.Name = "btnImport";
            this.btnImport.Size = new System.Drawing.Size(80, 25);
            this.btnImport.TabIndex = 56;
            this.btnImport.Text = "Importar";
            this.btnImport.Click += new System.EventHandler(this.btnImport_Click);
            // 
            // btnprocess
            // 
            this.btnprocess.Appearance = appearance1;
            this.btnprocess.Location = new System.Drawing.Point(358, 1);
            this.btnprocess.Name = "btnprocess";
            this.btnprocess.Size = new System.Drawing.Size(80, 25);
            this.btnprocess.TabIndex = 54;
            this.btnprocess.Text = "Procesar";
            this.btnprocess.Click += new System.EventHandler(this.btnprocess_Click);
            // 
            // tbArchiveubication
            // 
            this.tbArchiveubication.Caption = "";
            this.tbArchiveubication.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbArchiveubication.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbArchiveubication.ReadOnly = true;
            this.tbArchiveubication.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbArchiveubication.Length = null;
            this.tbArchiveubication.TextBoxValue = "";
            this.tbArchiveubication.Location = new System.Drawing.Point(145, 13);
            this.tbArchiveubication.Name = "tbArchiveubication";
            this.tbArchiveubication.Size = new System.Drawing.Size(270, 20);
            this.tbArchiveubication.TabIndex = 57;
            // 
            // lblDirectory
            // 
            appearance2.TextHAlign = Infragistics.Win.HAlign.Right;
            appearance2.TextVAlign = Infragistics.Win.VAlign.Middle;
            this.lblDirectory.Appearance = appearance2;
            this.lblDirectory.Location = new System.Drawing.Point(39, 12);
            this.lblDirectory.Name = "lblDirectory";
            this.lblDirectory.Size = new System.Drawing.Size(100, 21);
            this.lblDirectory.TabIndex = 55;
            this.lblDirectory.Text = "Directorio";
            // 
            // openTitle1
            // 
            this.openTitle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.openTitle1.Caption = "   Datos";
            this.openTitle1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openTitle1.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.openTitle1.Location = new System.Drawing.Point(0, 53);
            this.openTitle1.Name = "openTitle1";
            this.openTitle1.Size = new System.Drawing.Size(462, 33);
            this.openTitle1.TabIndex = 59;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.reportViewer1);
            this.panel1.Controls.Add(this.lblDirectory);
            this.panel1.Controls.Add(this.tbArchiveubication);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(0, 86);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(462, 45);
            this.panel1.TabIndex = 61;
            // 
            // reportViewer1
            // 
            reportDataSource1.Name = "SINCECOMP_SUBSIDYS_Entities_ACTA";
            reportDataSource1.Value = this.actaBindingSource;
            this.reportViewer1.LocalReport.DataSources.Add(reportDataSource1);
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "SINCECOMP.SUBSIDYS.Report.rptActadeCobro.rdlc";
            this.reportViewer1.Location = new System.Drawing.Point(4, 6);
            this.reportViewer1.Name = "reportViewer1";
            this.reportViewer1.Size = new System.Drawing.Size(74, 46);
            this.reportViewer1.TabIndex = 59;
            this.reportViewer1.Visible = false;
            // 
            // LDGRC
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(462, 166);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.openTitle1);
            this.Controls.Add(this.ultraGroupBox1);
            this.Controls.Add(this.openHeaderTitles1);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(470, 200);
            this.MinimumSize = new System.Drawing.Size(470, 200);
            this.Name = "LDGRC";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Generación de acta de cobro (LDGRC)";
            ((System.ComponentModel.ISupportInitialize)(this.actaBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).EndInit();
            this.ultraGroupBox1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.FolderBrowserDialog fbdDirectory;
        //private OpenSystems.Windows.Controls.OpenSimpleTextBox tbArchiveubication;
        private OpenSystems.Windows.Controls.OpenHeaderTitles openHeaderTitles1;
        private Infragistics.Win.Misc.UltraGroupBox ultraGroupBox1;
        private OpenSystems.Windows.Controls.OpenButton btnImport;
        private OpenSystems.Windows.Controls.OpenButton btnprocess;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbArchiveubication;
        private Infragistics.Win.Misc.UltraLabel lblDirectory;
        private OpenSystems.Windows.Controls.OpenTitle openTitle1;
        private System.Windows.Forms.Panel panel1;
        private Microsoft.Reporting.WinForms.ReportViewer reportViewer1;
        private System.Windows.Forms.BindingSource actaBindingSource;
    }
}