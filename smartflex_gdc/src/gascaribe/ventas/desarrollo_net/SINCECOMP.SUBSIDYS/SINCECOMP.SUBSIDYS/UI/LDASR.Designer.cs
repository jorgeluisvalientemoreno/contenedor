namespace SINCECOMP.SUBSIDYS.UI
{
    partial class LDASR
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LDASR));
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            this.btnProcess = new OpenSystems.Windows.Controls.OpenButton();
            this.btnImport = new OpenSystems.Windows.Controls.OpenButton();
            this.openHeaderTitles1 = new OpenSystems.Windows.Controls.OpenHeaderTitles();
            this.ofdFile = new System.Windows.Forms.OpenFileDialog();
            this.tbArchiveubication = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.lblImportfile = new Infragistics.Win.Misc.UltraLabel();
            this.ultraGroupBox1 = new Infragistics.Win.Misc.UltraGroupBox();
            this.openTitle1 = new OpenSystems.Windows.Controls.OpenTitle();
            this.panel1 = new System.Windows.Forms.Panel();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).BeginInit();
            this.ultraGroupBox1.SuspendLayout();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnProcess
            // 
            this.btnProcess.Location = new System.Drawing.Point(361, 2);
            this.btnProcess.Name = "btnProcess";
            this.btnProcess.Size = new System.Drawing.Size(80, 25);
            this.btnProcess.TabIndex = 45;
            this.btnProcess.Text = "Procesar";
            this.btnProcess.Click += new System.EventHandler(this.btnProcess_Click);
            // 
            // btnImport
            // 
            this.btnImport.Location = new System.Drawing.Point(278, 2);
            this.btnImport.Name = "btnImport";
            this.btnImport.Size = new System.Drawing.Size(80, 25);
            this.btnImport.TabIndex = 44;
            this.btnImport.Text = "Importar";
            this.btnImport.Click += new System.EventHandler(this.btnImport_Click);
            // 
            // openHeaderTitles1
            // 
            this.openHeaderTitles1.BackColor = System.Drawing.Color.White;
            this.openHeaderTitles1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openHeaderTitles1.HeaderProtectedFields = ((System.Collections.Generic.Dictionary<string, string>)(resources.GetObject("openHeaderTitles1.HeaderProtectedFields")));
            this.openHeaderTitles1.HeaderSubtitle1 = "Aplicación de subsidios retroactivos";
            this.openHeaderTitles1.HeaderTitle = "Aplicación de subsidios retroactivos";
            this.openHeaderTitles1.Location = new System.Drawing.Point(0, 0);
            this.openHeaderTitles1.MaxWidth = -1;
            this.openHeaderTitles1.Name = "openHeaderTitles1";
            this.openHeaderTitles1.ParsedHeaderSubtitle2 = "";
            this.openHeaderTitles1.RowInformationHeader = null;
            this.openHeaderTitles1.Size = new System.Drawing.Size(454, 53);
            this.openHeaderTitles1.TabIndex = 42;
            // 
            // ofdFile
            // 
            this.ofdFile.Filter = "Archivo TXT|*.txt";
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
            this.tbArchiveubication.Location = new System.Drawing.Point(153, 6);
            this.tbArchiveubication.Name = "tbArchiveubication";
            this.tbArchiveubication.Size = new System.Drawing.Size(279, 20);
            this.tbArchiveubication.TabIndex = 47;
            // 
            // lblImportfile
            // 
            appearance1.TextHAlign = Infragistics.Win.HAlign.Right;
            this.lblImportfile.Appearance = appearance1;
            this.lblImportfile.Location = new System.Drawing.Point(23, 6);
            this.lblImportfile.Name = "lblImportfile";
            this.lblImportfile.Size = new System.Drawing.Size(124, 20);
            this.lblImportfile.TabIndex = 48;
            this.lblImportfile.Text = "Importar archivo";
            // 
            // ultraGroupBox1
            // 
            this.ultraGroupBox1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.ultraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None;
            this.ultraGroupBox1.Controls.Add(this.btnProcess);
            this.ultraGroupBox1.Controls.Add(this.btnImport);
            this.ultraGroupBox1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.ultraGroupBox1.Location = new System.Drawing.Point(0, 134);
            this.ultraGroupBox1.Name = "ultraGroupBox1";
            this.ultraGroupBox1.Size = new System.Drawing.Size(454, 28);
            this.ultraGroupBox1.SupportThemes = false;
            this.ultraGroupBox1.TabIndex = 49;
            // 
            // openTitle1
            // 
            this.openTitle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.openTitle1.Caption = "   Archivo Plano";
            this.openTitle1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openTitle1.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.openTitle1.Location = new System.Drawing.Point(0, 53);
            this.openTitle1.Name = "openTitle1";
            this.openTitle1.Size = new System.Drawing.Size(454, 37);
            this.openTitle1.TabIndex = 51;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.lblImportfile);
            this.panel1.Controls.Add(this.tbArchiveubication);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(0, 90);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(454, 33);
            this.panel1.TabIndex = 53;
            // 
            // LDASR
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(454, 162);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.openTitle1);
            this.Controls.Add(this.ultraGroupBox1);
            this.Controls.Add(this.openHeaderTitles1);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(470, 200);
            this.MinimumSize = new System.Drawing.Size(470, 200);
            this.Name = "LDASR";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Aplicación de subsidios retroactivos (LDASR)";
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).EndInit();
            this.ultraGroupBox1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenButton btnProcess;
        private OpenSystems.Windows.Controls.OpenButton btnImport;
        private OpenSystems.Windows.Controls.OpenHeaderTitles openHeaderTitles1;
        private System.Windows.Forms.OpenFileDialog ofdFile;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbArchiveubication;
        private Infragistics.Win.Misc.UltraLabel lblImportfile;
        private Infragistics.Win.Misc.UltraGroupBox ultraGroupBox1;
        private OpenSystems.Windows.Controls.OpenTitle openTitle1;
        private System.Windows.Forms.Panel panel1;
    }
}