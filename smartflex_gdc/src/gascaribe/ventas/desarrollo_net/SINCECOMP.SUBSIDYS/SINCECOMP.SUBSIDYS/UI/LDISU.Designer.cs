namespace SINCECOMP.SUBSIDYS.UI
{
    partial class LDISU
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LDISU));
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            this.ofdFile = new System.Windows.Forms.OpenFileDialog();
            this.openHeaderTitles1 = new OpenSystems.Windows.Controls.OpenHeaderTitles();
            this.openTitle1 = new OpenSystems.Windows.Controls.OpenTitle();
            this.ultraGroupBox1 = new Infragistics.Win.Misc.UltraGroupBox();
            this.btnProcess = new OpenSystems.Windows.Controls.OpenButton();
            this.btnImport = new OpenSystems.Windows.Controls.OpenButton();
            this.lblImportfile = new Infragistics.Win.Misc.UltraLabel();
            this.tbArchiveubication = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.panel1 = new System.Windows.Forms.Panel();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).BeginInit();
            this.ultraGroupBox1.SuspendLayout();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // ofdFile
            // 
            this.ofdFile.Filter = "Archivo TXT|*.txt";
            // 
            // openHeaderTitles1
            // 
            this.openHeaderTitles1.BackColor = System.Drawing.Color.White;
            this.openHeaderTitles1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openHeaderTitles1.HeaderProtectedFields = ((System.Collections.Generic.Dictionary<string, string>)(resources.GetObject("openHeaderTitles1.HeaderProtectedFields")));
            this.openHeaderTitles1.HeaderSubtitle1 = "Parametrización por carga de archivo";
            this.openHeaderTitles1.HeaderTitle = "Parametrización por carga de archivo";
            this.openHeaderTitles1.Location = new System.Drawing.Point(0, 0);
            this.openHeaderTitles1.MaxWidth = -1;
            this.openHeaderTitles1.Name = "openHeaderTitles1";
            this.openHeaderTitles1.ParsedHeaderSubtitle2 = "";
            this.openHeaderTitles1.RowInformationHeader = null;
            this.openHeaderTitles1.Size = new System.Drawing.Size(462, 52);
            this.openHeaderTitles1.TabIndex = 45;
            // 
            // openTitle1
            // 
            this.openTitle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.openTitle1.Caption = "   Procesar";
            this.openTitle1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openTitle1.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.openTitle1.Location = new System.Drawing.Point(0, 52);
            this.openTitle1.Name = "openTitle1";
            this.openTitle1.Size = new System.Drawing.Size(462, 39);
            this.openTitle1.TabIndex = 46;
            // 
            // ultraGroupBox1
            // 
            this.ultraGroupBox1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.ultraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None;
            this.ultraGroupBox1.Controls.Add(this.btnProcess);
            this.ultraGroupBox1.Controls.Add(this.btnImport);
            this.ultraGroupBox1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.ultraGroupBox1.Location = new System.Drawing.Point(0, 145);
            this.ultraGroupBox1.Name = "ultraGroupBox1";
            this.ultraGroupBox1.Size = new System.Drawing.Size(462, 28);
            this.ultraGroupBox1.SupportThemes = false;
            this.ultraGroupBox1.TabIndex = 53;
            // 
            // btnProcess
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnProcess.Appearance = appearance1;
            this.btnProcess.Location = new System.Drawing.Point(363, 1);
            this.btnProcess.Name = "btnProcess";
            this.btnProcess.Size = new System.Drawing.Size(80, 25);
            this.btnProcess.TabIndex = 58;
            this.btnProcess.Text = "Procesar";
            this.btnProcess.Click += new System.EventHandler(this.btnProcess_Click);
            // 
            // btnImport
            // 
            this.btnImport.Appearance = appearance1;
            this.btnImport.Location = new System.Drawing.Point(280, 1);
            this.btnImport.Name = "btnImport";
            this.btnImport.Size = new System.Drawing.Size(80, 25);
            this.btnImport.TabIndex = 57;
            this.btnImport.Text = "Importar";
            this.btnImport.Click += new System.EventHandler(this.btnImport_Click);
            // 
            // lblImportfile
            // 
            appearance2.TextHAlign = Infragistics.Win.HAlign.Right;
            this.lblImportfile.Appearance = appearance2;
            this.lblImportfile.Location = new System.Drawing.Point(26, 15);
            this.lblImportfile.Name = "lblImportfile";
            this.lblImportfile.Size = new System.Drawing.Size(118, 23);
            this.lblImportfile.TabIndex = 56;
            this.lblImportfile.Text = "Importar archivo";
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
            this.tbArchiveubication.Location = new System.Drawing.Point(150, 15);
            this.tbArchiveubication.Name = "tbArchiveubication";
            this.tbArchiveubication.Size = new System.Drawing.Size(279, 20);
            this.tbArchiveubication.TabIndex = 55;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.lblImportfile);
            this.panel1.Controls.Add(this.tbArchiveubication);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 91);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(462, 54);
            this.panel1.TabIndex = 58;
            // 
            // LDISU
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(462, 173);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.ultraGroupBox1);
            this.Controls.Add(this.openTitle1);
            this.Controls.Add(this.openHeaderTitles1);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(470, 200);
            this.MinimumSize = new System.Drawing.Size(470, 200);
            this.Name = "LDISU";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Parametrización por carga de archivo (LDISU)";
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).EndInit();
            this.ultraGroupBox1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.OpenFileDialog ofdFile;
        private OpenSystems.Windows.Controls.OpenHeaderTitles openHeaderTitles1;
        private OpenSystems.Windows.Controls.OpenTitle openTitle1;
        private Infragistics.Win.Misc.UltraGroupBox ultraGroupBox1;
        private OpenSystems.Windows.Controls.OpenButton btnProcess;
        private OpenSystems.Windows.Controls.OpenButton btnImport;
        private Infragistics.Win.Misc.UltraLabel lblImportfile;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbArchiveubication;
        private System.Windows.Forms.Panel panel1;
    }
}