namespace SINCECOMP.FNB.UI
{
    partial class LDRPA
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LDRPA));
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance6 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance7 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance8 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance9 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance10 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance14 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            this.openTitle1 = new OpenSystems.Windows.Controls.OpenTitle();
            this.openHeaderTitles1 = new OpenSystems.Windows.Controls.OpenHeaderTitles();
            this.ultraGroupBox1 = new Infragistics.Win.Misc.UltraGroupBox();
            this.btnProcess = new OpenSystems.Windows.Controls.OpenButton();
            this.btnCancel = new OpenSystems.Windows.Controls.OpenButton();
            this.ultraLabel1 = new Infragistics.Win.Misc.UltraLabel();
            this.tbNumberSecuence = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.flContrat = new OpenSystems.Windows.Controls.OpenFlag();
            this.flClient = new OpenSystems.Windows.Controls.OpenFlag();
            this.flEntity = new OpenSystems.Windows.Controls.OpenFlag();
            this.cbType = new OpenSystems.Windows.Controls.OpenCombo();
            this.ultraLabel2 = new Infragistics.Win.Misc.UltraLabel();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).BeginInit();
            this.ultraGroupBox1.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cbType)).BeginInit();
            this.SuspendLayout();
            // 
            // openTitle1
            // 
            this.openTitle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.openTitle1.Caption = "   Datos";
            this.openTitle1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openTitle1.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.openTitle1.Location = new System.Drawing.Point(0, 50);
            this.openTitle1.Name = "openTitle1";
            this.openTitle1.Size = new System.Drawing.Size(759, 30);
            this.openTitle1.TabIndex = 33;
            this.openTitle1.TabStop = false;
            // 
            // openHeaderTitles1
            // 
            this.openHeaderTitles1.BackColor = System.Drawing.Color.White;
            this.openHeaderTitles1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openHeaderTitles1.HeaderProtectedFields = ((System.Collections.Generic.Dictionary<string, string>)(resources.GetObject("openHeaderTitles1.HeaderProtectedFields")));
            this.openHeaderTitles1.HeaderSubtitle1 = "Reimpresión de pagare";
            this.openHeaderTitles1.HeaderTitle = "Reimpresión de pagare";
            this.openHeaderTitles1.Location = new System.Drawing.Point(0, 0);
            this.openHeaderTitles1.MaxWidth = -1;
            this.openHeaderTitles1.Name = "openHeaderTitles1";
            this.openHeaderTitles1.ParsedHeaderSubtitle2 = "";
            this.openHeaderTitles1.RowInformationHeader = null;
            this.openHeaderTitles1.Size = new System.Drawing.Size(759, 50);
            this.openHeaderTitles1.TabIndex = 32;
            this.openHeaderTitles1.TabStop = false;
            // 
            // ultraGroupBox1
            // 
            this.ultraGroupBox1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.ultraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None;
            this.ultraGroupBox1.Controls.Add(this.btnProcess);
            this.ultraGroupBox1.Controls.Add(this.btnCancel);
            this.ultraGroupBox1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.ultraGroupBox1.Location = new System.Drawing.Point(0, 207);
            this.ultraGroupBox1.Name = "ultraGroupBox1";
            this.ultraGroupBox1.Size = new System.Drawing.Size(759, 28);
            this.ultraGroupBox1.SupportThemes = false;
            this.ultraGroupBox1.TabIndex = 55;
            // 
            // btnProcess
            // 
            this.btnProcess.Location = new System.Drawing.Point(560, 2);
            this.btnProcess.Name = "btnProcess";
            this.btnProcess.Size = new System.Drawing.Size(80, 25);
            this.btnProcess.TabIndex = 1;
            this.btnProcess.Text = "&Procesar";
            this.btnProcess.Click += new System.EventHandler(this.btnProcess_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(646, 2);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(80, 25);
            this.btnCancel.TabIndex = 0;
            this.btnCancel.Text = "&Cancelar";
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // ultraLabel1
            // 
            this.ultraLabel1.Location = new System.Drawing.Point(12, 30);
            this.ultraLabel1.Name = "ultraLabel1";
            this.ultraLabel1.Size = new System.Drawing.Size(146, 23);
            this.ultraLabel1.TabIndex = 56;
            this.ultraLabel1.Text = "Número de consecutivo";
            // 
            // tbNumberSecuence
            // 
            this.tbNumberSecuence.TypeBox = OpenSystems.Windows.Controls.TypesBox.Numeric;
            this.tbNumberSecuence.Caption = "";
            this.tbNumberSecuence.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbNumberSecuence.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbNumberSecuence.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbNumberSecuence.Length = null;
            this.tbNumberSecuence.TextBoxValue = null;
            this.tbNumberSecuence.Location = new System.Drawing.Point(192, 30);
            this.tbNumberSecuence.Name = "tbNumberSecuence";
            this.tbNumberSecuence.Size = new System.Drawing.Size(189, 20);
            this.tbNumberSecuence.TabIndex = 57;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.flContrat);
            this.panel1.Controls.Add(this.flClient);
            this.panel1.Controls.Add(this.flEntity);
            this.panel1.Controls.Add(this.cbType);
            this.panel1.Controls.Add(this.ultraLabel2);
            this.panel1.Controls.Add(this.ultraLabel1);
            this.panel1.Controls.Add(this.tbNumberSecuence);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 80);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(759, 127);
            this.panel1.TabIndex = 59;
            // 
            // flContrat
            // 
            appearance1.FontData.BoldAsString = "False";
            appearance1.FontData.ItalicAsString = "False";
            appearance1.FontData.Name = "Verdana";
            appearance1.FontData.SizeInPoints = 8F;
            appearance1.FontData.StrikeoutAsString = "False";
            appearance1.FontData.UnderlineAsString = "False";
            this.flContrat.Appearance = appearance1;
            this.flContrat.ButtonStyle = Infragistics.Win.UIElementButtonStyle.Office2003ToolbarButton;
            this.flContrat.Caption = "Contratista/Proveedor";
            this.flContrat.CheckAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.flContrat.Checked = true;
            this.flContrat.CheckState = System.Windows.Forms.CheckState.Checked;
            this.flContrat.Location = new System.Drawing.Point(18, 80);
            this.flContrat.Name = "flContrat";
            this.flContrat.Size = new System.Drawing.Size(187, 18);
            this.flContrat.TabIndex = 65;
            this.flContrat.Updatable = 'Y';
            this.flContrat.UseMnemonics = true;
            // 
            // flClient
            // 
            appearance2.FontData.BoldAsString = "False";
            appearance2.FontData.ItalicAsString = "False";
            appearance2.FontData.Name = "Verdana";
            appearance2.FontData.SizeInPoints = 8F;
            appearance2.FontData.StrikeoutAsString = "False";
            appearance2.FontData.UnderlineAsString = "False";
            this.flClient.Appearance = appearance2;
            this.flClient.ButtonStyle = Infragistics.Win.UIElementButtonStyle.Office2003ToolbarButton;
            this.flClient.Caption = "Cliente";
            this.flClient.CheckAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.flClient.Checked = true;
            this.flClient.CheckState = System.Windows.Forms.CheckState.Checked;
            this.flClient.Location = new System.Drawing.Point(105, 56);
            this.flClient.Name = "flClient";
            this.flClient.Size = new System.Drawing.Size(100, 18);
            this.flClient.TabIndex = 64;
            this.flClient.Updatable = 'Y';
            this.flClient.UseMnemonics = true;
            // 
            // flEntity
            // 
            appearance3.FontData.BoldAsString = "False";
            appearance3.FontData.ItalicAsString = "False";
            appearance3.FontData.Name = "Verdana";
            appearance3.FontData.SizeInPoints = 8F;
            appearance3.FontData.StrikeoutAsString = "False";
            appearance3.FontData.UnderlineAsString = "False";
            this.flEntity.Appearance = appearance3;
            this.flEntity.ButtonStyle = Infragistics.Win.UIElementButtonStyle.Office2003ToolbarButton;
            this.flEntity.Caption = "Entidad Financiera";
            this.flEntity.CheckAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.flEntity.Checked = true;
            this.flEntity.CheckState = System.Windows.Forms.CheckState.Checked;
            this.flEntity.Location = new System.Drawing.Point(405, 60);
            this.flEntity.Name = "flEntity";
            this.flEntity.Size = new System.Drawing.Size(166, 18);
            this.flEntity.TabIndex = 63;
            this.flEntity.Updatable = 'Y';
            this.flEntity.UseMnemonics = true;
            // 
            // cbType
            // 
            this.cbType.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cbType.CharacterCasing = System.Windows.Forms.CharacterCasing.Normal;
            appearance4.BackColor = System.Drawing.SystemColors.Window;
            appearance4.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.cbType.DisplayLayout.Appearance = appearance4;
            this.cbType.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ExtendLastColumn;
            this.cbType.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance5.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(123)))), ((int)(((byte)(158)))), ((int)(((byte)(189)))));
            appearance5.Cursor = System.Windows.Forms.Cursors.Arrow;
            appearance5.FontData.BoldAsString = "False";
            appearance5.FontData.ItalicAsString = "False";
            appearance5.FontData.Name = "Verdana";
            appearance5.FontData.SizeInPoints = 8F;
            appearance5.FontData.StrikeoutAsString = "False";
            appearance5.FontData.UnderlineAsString = "False";
            appearance5.ForeColor = System.Drawing.Color.Black;
            appearance5.ForeColorDisabled = System.Drawing.Color.FromArgb(((int)(((byte)(173)))), ((int)(((byte)(170)))), ((int)(((byte)(156)))));
            appearance5.TextHAlign = Infragistics.Win.HAlign.Left;
            appearance5.TextTrimming = Infragistics.Win.TextTrimming.Character;
            appearance5.TextVAlign = Infragistics.Win.VAlign.Middle;
            this.cbType.DisplayLayout.CaptionAppearance = appearance5;
            this.cbType.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance6.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance6.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance6.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance6.BorderColor = System.Drawing.SystemColors.Window;
            this.cbType.DisplayLayout.GroupByBox.Appearance = appearance6;
            appearance7.ForeColor = System.Drawing.SystemColors.GrayText;
            this.cbType.DisplayLayout.GroupByBox.BandLabelAppearance = appearance7;
            this.cbType.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance8.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance8.BackColor2 = System.Drawing.SystemColors.Control;
            appearance8.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance8.ForeColor = System.Drawing.SystemColors.GrayText;
            this.cbType.DisplayLayout.GroupByBox.PromptAppearance = appearance8;
            this.cbType.DisplayLayout.LoadStyle = Infragistics.Win.UltraWinGrid.LoadStyle.LoadOnDemand;
            this.cbType.DisplayLayout.MaxBandDepth = 1;
            this.cbType.DisplayLayout.MaxColScrollRegions = 1;
            this.cbType.DisplayLayout.MaxRowScrollRegions = 1;
            appearance9.BackColor = System.Drawing.SystemColors.Window;
            appearance9.ForeColor = System.Drawing.SystemColors.ControlText;
            this.cbType.DisplayLayout.Override.ActiveCellAppearance = appearance9;
            appearance10.BackColor = System.Drawing.SystemColors.Highlight;
            appearance10.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.cbType.DisplayLayout.Override.ActiveRowAppearance = appearance10;
            this.cbType.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.cbType.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance11.BackColor = System.Drawing.SystemColors.Window;
            this.cbType.DisplayLayout.Override.CardAreaAppearance = appearance11;
            appearance12.BorderColor = System.Drawing.Color.Silver;
            appearance12.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.cbType.DisplayLayout.Override.CellAppearance = appearance12;
            this.cbType.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.cbType.DisplayLayout.Override.CellPadding = 0;
            this.cbType.DisplayLayout.Override.ColumnAutoSizeMode = Infragistics.Win.UltraWinGrid.ColumnAutoSizeMode.AllRowsInBand;
            appearance13.BackColor = System.Drawing.SystemColors.Control;
            appearance13.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance13.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance13.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance13.BorderColor = System.Drawing.SystemColors.Window;
            this.cbType.DisplayLayout.Override.GroupByRowAppearance = appearance13;
            appearance14.TextHAlign = Infragistics.Win.HAlign.Left;
            this.cbType.DisplayLayout.Override.HeaderAppearance = appearance14;
            this.cbType.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.cbType.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            this.cbType.DisplayLayout.Override.MergedCellStyle = Infragistics.Win.UltraWinGrid.MergedCellStyle.Never;
            appearance15.BackColor = System.Drawing.SystemColors.Window;
            appearance15.BorderColor = System.Drawing.Color.Silver;
            this.cbType.DisplayLayout.Override.RowAppearance = appearance15;
            this.cbType.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            this.cbType.DisplayLayout.Override.RowSizing = Infragistics.Win.UltraWinGrid.RowSizing.AutoFree;
            appearance16.BackColor = System.Drawing.SystemColors.ControlLight;
            this.cbType.DisplayLayout.Override.TemplateAddRowAppearance = appearance16;
            this.cbType.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.cbType.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.cbType.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.cbType.DisplayMember = "";
            this.cbType.Font = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cbType.Location = new System.Drawing.Point(558, 31);
            this.cbType.Name = "cbType";
            this.cbType.Size = new System.Drawing.Size(189, 22);
            this.cbType.TabIndex = 60;
            this.cbType.ValueMember = "";
            // 
            // ultraLabel2
            // 
            this.ultraLabel2.Location = new System.Drawing.Point(405, 31);
            this.ultraLabel2.Name = "ultraLabel2";
            this.ultraLabel2.Size = new System.Drawing.Size(115, 23);
            this.ultraLabel2.TabIndex = 59;
            this.ultraLabel2.Text = "Deudor/Codeudor";
            // 
            // LDRPA
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(759, 235);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.ultraGroupBox1);
            this.Controls.Add(this.openTitle1);
            this.Controls.Add(this.openHeaderTitles1);
            this.MaximumSize = new System.Drawing.Size(767, 269);
            this.MinimumSize = new System.Drawing.Size(767, 269);
            this.Name = "LDRPA";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Reimpresión de pagare (LDRPA)";
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).EndInit();
            this.ultraGroupBox1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.cbType)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenTitle openTitle1;
        private OpenSystems.Windows.Controls.OpenHeaderTitles openHeaderTitles1;
        private Infragistics.Win.Misc.UltraGroupBox ultraGroupBox1;
        private OpenSystems.Windows.Controls.OpenButton btnProcess;
        private OpenSystems.Windows.Controls.OpenButton btnCancel;
        private Infragistics.Win.Misc.UltraLabel ultraLabel1;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbNumberSecuence;
        private System.Windows.Forms.Panel panel1;
        private Infragistics.Win.Misc.UltraLabel ultraLabel2;
        private OpenSystems.Windows.Controls.OpenFlag flEntity;
        private OpenSystems.Windows.Controls.OpenCombo cbType;
        private OpenSystems.Windows.Controls.OpenFlag flContrat;
        private OpenSystems.Windows.Controls.OpenFlag flClient;
    }
}