namespace SINCECOMP.FNB.UI
{
    partial class FIACM
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FIACM));
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton dateButton1 = new Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton();
            Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton dateButton2 = new Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance6 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance7 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance8 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance9 = new Infragistics.Win.Appearance();
            this.openHeaderTitles1 = new OpenSystems.Windows.Controls.OpenHeaderTitles();
            this.opPanel = new System.Windows.Forms.Panel();
            this.btnCancel = new OpenSystems.Windows.Controls.OpenButton();
            this.btnProcess = new OpenSystems.Windows.Controls.OpenButton();
            this.openTitle1 = new OpenSystems.Windows.Controls.OpenTitle();
            this.panel1 = new System.Windows.Forms.Panel();
            this.btn_filesearch = new OpenSystems.Windows.Controls.OpenButton();
            this.tb_filepath = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.tbQuotaValue = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.dtp_FinalDate = new Infragistics.Win.UltraWinSchedule.UltraCalendarCombo();
            this.dtp_InitialDate = new Infragistics.Win.UltraWinSchedule.UltraCalendarCombo();
            this.ultraLabel6 = new Infragistics.Win.Misc.UltraLabel();
            this.ultraLabel5 = new Infragistics.Win.Misc.UltraLabel();
            this.ultraLabel4 = new Infragistics.Win.Misc.UltraLabel();
            this.ultraLabel3 = new Infragistics.Win.Misc.UltraLabel();
            this.ultraLabel2 = new Infragistics.Win.Misc.UltraLabel();
            this.ultraLabel1 = new Infragistics.Win.Misc.UltraLabel();
            this.chk_printbill = new Infragistics.Win.UltraWinEditors.UltraCheckEditor();
            this.tb_observation = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.tbSubscription = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.ofdFile = new System.Windows.Forms.OpenFileDialog();
            this.opPanel.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dtp_FinalDate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtp_InitialDate)).BeginInit();
            this.SuspendLayout();
            // 
            // openHeaderTitles1
            // 
            this.openHeaderTitles1.BackColor = System.Drawing.Color.White;
            this.openHeaderTitles1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openHeaderTitles1.HeaderProtectedFields = ((System.Collections.Generic.Dictionary<string, string>)(resources.GetObject("openHeaderTitles1.HeaderProtectedFields")));
            this.openHeaderTitles1.HeaderSubtitle1 = "Asignación de Cupo Manual";
            this.openHeaderTitles1.HeaderTitle = "Asignación de Cupo Manual";
            this.openHeaderTitles1.Location = new System.Drawing.Point(0, 0);
            this.openHeaderTitles1.MaxWidth = -1;
            this.openHeaderTitles1.Name = "openHeaderTitles1";
            this.openHeaderTitles1.ParsedHeaderSubtitle2 = "";
            this.openHeaderTitles1.RowInformationHeader = null;
            this.openHeaderTitles1.Size = new System.Drawing.Size(723, 52);
            this.openHeaderTitles1.TabIndex = 0;
            this.openHeaderTitles1.TabStop = false;
            // 
            // opPanel
            // 
            this.opPanel.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.opPanel.Controls.Add(this.btnCancel);
            this.opPanel.Controls.Add(this.btnProcess);
            this.opPanel.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.opPanel.Location = new System.Drawing.Point(0, 216);
            this.opPanel.Name = "opPanel";
            this.opPanel.Size = new System.Drawing.Size(723, 28);
            this.opPanel.TabIndex = 1;
            // 
            // btnCancel
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnCancel.Appearance = appearance1;
            this.btnCancel.Location = new System.Drawing.Point(613, 2);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(80, 25);
            this.btnCancel.TabIndex = 1;
            this.btnCancel.Text = "&Cancelar";
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnProcess
            // 
            appearance2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance2.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnProcess.Appearance = appearance2;
            this.btnProcess.Location = new System.Drawing.Point(530, 2);
            this.btnProcess.Name = "btnProcess";
            this.btnProcess.Size = new System.Drawing.Size(80, 25);
            this.btnProcess.TabIndex = 0;
            this.btnProcess.Text = "&Procesar";
            this.btnProcess.Click += new System.EventHandler(this.btnProcess_Click);
            // 
            // openTitle1
            // 
            this.openTitle1.BackColor = System.Drawing.Color.Transparent;
            this.openTitle1.Caption = "   Datos";
            this.openTitle1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openTitle1.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.openTitle1.Location = new System.Drawing.Point(0, 52);
            this.openTitle1.Name = "openTitle1";
            this.openTitle1.Size = new System.Drawing.Size(723, 38);
            this.openTitle1.TabIndex = 2;
            this.openTitle1.TabStop = false;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.btn_filesearch);
            this.panel1.Controls.Add(this.tb_filepath);
            this.panel1.Controls.Add(this.tbQuotaValue);
            this.panel1.Controls.Add(this.dtp_FinalDate);
            this.panel1.Controls.Add(this.dtp_InitialDate);
            this.panel1.Controls.Add(this.ultraLabel6);
            this.panel1.Controls.Add(this.ultraLabel5);
            this.panel1.Controls.Add(this.ultraLabel4);
            this.panel1.Controls.Add(this.ultraLabel3);
            this.panel1.Controls.Add(this.ultraLabel2);
            this.panel1.Controls.Add(this.ultraLabel1);
            this.panel1.Controls.Add(this.chk_printbill);
            this.panel1.Controls.Add(this.tb_observation);
            this.panel1.Controls.Add(this.tbSubscription);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(0, 90);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(723, 118);
            this.panel1.TabIndex = 30;
            // 
            // btn_filesearch
            // 
            appearance3.Image = global::SINCECOMP.FNB.Resource.search;
            appearance3.ImageHAlign = Infragistics.Win.HAlign.Center;
            appearance3.ImageVAlign = Infragistics.Win.VAlign.Middle;
            this.btn_filesearch.Appearance = appearance3;
            this.btn_filesearch.ImageSize = new System.Drawing.Size(10, 10);
            this.btn_filesearch.Location = new System.Drawing.Point(349, 61);
            this.btn_filesearch.Name = "btn_filesearch";
            this.btn_filesearch.Size = new System.Drawing.Size(23, 22);
            this.btn_filesearch.TabIndex = 4;
            this.btn_filesearch.Click += new System.EventHandler(this.btn_filesearch_Click);
            // 
            // tb_filepath
            // 
            this.tb_filepath.Caption = "";
            this.tb_filepath.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tb_filepath.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tb_filepath.ReadOnly = true;
            this.tb_filepath.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tb_filepath.Length = null;
            this.tb_filepath.TextBoxValue = "";
            this.tb_filepath.Location = new System.Drawing.Point(162, 62);
            this.tb_filepath.Name = "tb_filepath";
            this.tb_filepath.Size = new System.Drawing.Size(187, 20);
            this.tb_filepath.TabIndex = 47;
            this.tb_filepath.TabStop = false;
            // 
            // tbQuotaValue
            // 
            this.tbQuotaValue.TypeBox = OpenSystems.Windows.Controls.TypesBox.Currency;
            this.tbQuotaValue.Caption = "";
            this.tbQuotaValue.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbQuotaValue.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbQuotaValue.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbQuotaValue.NumberComposition = new OpenSystems.Windows.Controls.Number(8, 0);
            this.tbQuotaValue.Required = 'Y';
            this.tbQuotaValue.Length = null;
            this.tbQuotaValue.TextBoxValue = null;
            this.tbQuotaValue.Location = new System.Drawing.Point(496, 8);
            this.tbQuotaValue.Name = "tbQuotaValue";
            this.tbQuotaValue.Size = new System.Drawing.Size(210, 20);
            this.tbQuotaValue.TabIndex = 1;
            this.tbQuotaValue.TextBoxValueChanged += new System.EventHandler(this.tbQuotaValue_TextBoxValueChanged);
            this.tbQuotaValue.Leave += new System.EventHandler(this.tbQuotaValue_Leave);
            // 
            // dtp_FinalDate
            // 
            this.dtp_FinalDate.BackColor = System.Drawing.SystemColors.Window;
            this.dtp_FinalDate.DateButtons.Add(dateButton1);
            this.dtp_FinalDate.Location = new System.Drawing.Point(496, 34);
            this.dtp_FinalDate.Name = "dtp_FinalDate";
            this.dtp_FinalDate.NonAutoSizeHeight = 21;
            this.dtp_FinalDate.NullDateLabel = "";
            this.dtp_FinalDate.Size = new System.Drawing.Size(210, 21);
            this.dtp_FinalDate.TabIndex = 3;
            this.dtp_FinalDate.Value = new System.DateTime(2001, 1, 1, 0, 0, 0, 0);
            this.dtp_FinalDate.ValueChanged += new System.EventHandler(this.dtp_FinalDate_ValueChanged);
            // 
            // dtp_InitialDate
            // 
            this.dtp_InitialDate.BackColor = System.Drawing.SystemColors.Window;
            this.dtp_InitialDate.DateButtons.Add(dateButton2);
            this.dtp_InitialDate.Location = new System.Drawing.Point(162, 35);
            this.dtp_InitialDate.Name = "dtp_InitialDate";
            this.dtp_InitialDate.NonAutoSizeHeight = 21;
            this.dtp_InitialDate.NullDateLabel = "";
            this.dtp_InitialDate.Size = new System.Drawing.Size(210, 21);
            this.dtp_InitialDate.TabIndex = 2;
            this.dtp_InitialDate.Value = new System.DateTime(2001, 1, 1, 0, 0, 0, 0);
            this.dtp_InitialDate.ValueChanged += new System.EventHandler(this.dtp_InitialDate_ValueChanged);
            // 
            // ultraLabel6
            // 
            appearance4.TextHAlign = Infragistics.Win.HAlign.Right;
            this.ultraLabel6.Appearance = appearance4;
            this.ultraLabel6.Location = new System.Drawing.Point(390, 63);
            this.ultraLabel6.Name = "ultraLabel6";
            this.ultraLabel6.Size = new System.Drawing.Size(100, 23);
            this.ultraLabel6.TabIndex = 42;
            this.ultraLabel6.Text = "Observación";
            // 
            // ultraLabel5
            // 
            appearance5.TextHAlign = Infragistics.Win.HAlign.Right;
            this.ultraLabel5.Appearance = appearance5;
            this.ultraLabel5.Location = new System.Drawing.Point(390, 34);
            this.ultraLabel5.Name = "ultraLabel5";
            this.ultraLabel5.Size = new System.Drawing.Size(100, 23);
            this.ultraLabel5.TabIndex = 41;
            this.ultraLabel5.Text = "Fecha Final";
            // 
            // ultraLabel4
            // 
            appearance6.TextHAlign = Infragistics.Win.HAlign.Right;
            this.ultraLabel4.Appearance = appearance6;
            this.ultraLabel4.Location = new System.Drawing.Point(390, 8);
            this.ultraLabel4.Name = "ultraLabel4";
            this.ultraLabel4.Size = new System.Drawing.Size(100, 23);
            this.ultraLabel4.TabIndex = 40;
            this.ultraLabel4.Text = "Valor Cupo";
            // 
            // ultraLabel3
            // 
            appearance7.TextHAlign = Infragistics.Win.HAlign.Right;
            this.ultraLabel3.Appearance = appearance7;
            this.ultraLabel3.Location = new System.Drawing.Point(17, 63);
            this.ultraLabel3.Name = "ultraLabel3";
            this.ultraLabel3.Size = new System.Drawing.Size(139, 23);
            this.ultraLabel3.TabIndex = 39;
            this.ultraLabel3.Text = "Archivo de Soporte";
            // 
            // ultraLabel2
            // 
            appearance8.TextHAlign = Infragistics.Win.HAlign.Right;
            this.ultraLabel2.Appearance = appearance8;
            this.ultraLabel2.Location = new System.Drawing.Point(56, 34);
            this.ultraLabel2.Name = "ultraLabel2";
            this.ultraLabel2.Size = new System.Drawing.Size(100, 23);
            this.ultraLabel2.TabIndex = 38;
            this.ultraLabel2.Text = "Fecha Inicial";
            // 
            // ultraLabel1
            // 
            appearance9.TextHAlign = Infragistics.Win.HAlign.Right;
            this.ultraLabel1.Appearance = appearance9;
            this.ultraLabel1.Location = new System.Drawing.Point(56, 8);
            this.ultraLabel1.Name = "ultraLabel1";
            this.ultraLabel1.Size = new System.Drawing.Size(100, 23);
            this.ultraLabel1.TabIndex = 37;
            this.ultraLabel1.Text = "Contrato";
            // 
            // chk_printbill
            // 
            this.chk_printbill.CheckAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.chk_printbill.Location = new System.Drawing.Point(20, 91);
            this.chk_printbill.Name = "chk_printbill";
            this.chk_printbill.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.chk_printbill.Size = new System.Drawing.Size(155, 20);
            this.chk_printbill.TabIndex = 6;
            this.chk_printbill.Text = "Se imprime en Factura";
            // 
            // tb_observation
            // 
            this.tb_observation.Caption = "";
            this.tb_observation.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tb_observation.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tb_observation.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tb_observation.Required = 'Y';
            this.tb_observation.Length = null;
            this.tb_observation.TextBoxValue = "";
            this.tb_observation.Location = new System.Drawing.Point(496, 62);
            this.tb_observation.Name = "tb_observation";
            this.tb_observation.Size = new System.Drawing.Size(210, 22);
            this.tb_observation.TabIndex = 5;
            // 
            // tbSubscription
            // 
            this.tbSubscription.TypeBox = OpenSystems.Windows.Controls.TypesBox.Numeric;
            this.tbSubscription.Caption = "";
            this.tbSubscription.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbSubscription.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbSubscription.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbSubscription.Required = 'Y';
            this.tbSubscription.Length = null;
            this.tbSubscription.TextBoxValue = null;
            this.tbSubscription.Location = new System.Drawing.Point(162, 7);
            this.tbSubscription.Name = "tbSubscription";
            this.tbSubscription.Size = new System.Drawing.Size(210, 22);
            this.tbSubscription.TabIndex = 0;
            // 
            // ofdFile
            // 
            this.ofdFile.Filter = "Archivos Word 2003 y anteriores|*.doc|Archivos Word 2007 y superiores|*.docx|Arch" +
    "ivos PDF|*.pdf|Archivos XML|*.xml";
            this.ofdFile.InitialDirectory = "%USERPROFILE%";
            this.ofdFile.Title = "Busqueda de Documento";
            // 
            // FIACM
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(723, 244);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.openTitle1);
            this.Controls.Add(this.opPanel);
            this.Controls.Add(this.openHeaderTitles1);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(731, 271);
            this.MinimumSize = new System.Drawing.Size(731, 271);
            this.Name = "FIACM";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Asignación de Cupo Manual (FIACM)";
            this.opPanel.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dtp_FinalDate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtp_InitialDate)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenHeaderTitles openHeaderTitles1;
        private System.Windows.Forms.Panel opPanel;
        private OpenSystems.Windows.Controls.OpenButton btnCancel;
        private OpenSystems.Windows.Controls.OpenButton btnProcess;
        private OpenSystems.Windows.Controls.OpenTitle openTitle1;
        private System.Windows.Forms.Panel panel1;
        private Infragistics.Win.UltraWinSchedule.UltraCalendarCombo dtp_FinalDate;
        private Infragistics.Win.UltraWinSchedule.UltraCalendarCombo dtp_InitialDate;
        private Infragistics.Win.Misc.UltraLabel ultraLabel6;
        private Infragistics.Win.Misc.UltraLabel ultraLabel5;
        private Infragistics.Win.Misc.UltraLabel ultraLabel4;
        private Infragistics.Win.Misc.UltraLabel ultraLabel3;
        private Infragistics.Win.Misc.UltraLabel ultraLabel2;
        private Infragistics.Win.Misc.UltraLabel ultraLabel1;
        private Infragistics.Win.UltraWinEditors.UltraCheckEditor chk_printbill;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tb_observation;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbSubscription;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbQuotaValue;
        private OpenSystems.Windows.Controls.OpenButton btn_filesearch;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tb_filepath;
        private System.Windows.Forms.OpenFileDialog ofdFile;
    }
}