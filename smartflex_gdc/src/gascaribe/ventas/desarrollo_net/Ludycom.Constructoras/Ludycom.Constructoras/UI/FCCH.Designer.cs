namespace Ludycom.Constructoras.UI
{
    partial class FCCH
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
            this.btnSave = new OpenSystems.Windows.Controls.OpenButton();
            this.ocBanks = new OpenSystems.Windows.Controls.OpenCombo();
            this.tbAccount = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.tbCheckNumber = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.tbCheckDate = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.tbAlarmDate = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.tbCheckValue = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.otCheckData = new OpenSystems.Windows.Controls.OpenTitle();
            this.tbPrevCheck = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            ((System.ComponentModel.ISupportInitialize)(this.ocBanks)).BeginInit();
            this.SuspendLayout();
            // 
            // btnSave
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnSave.Appearance = appearance1;
            this.btnSave.Location = new System.Drawing.Point(617, 203);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(111, 23);
            this.btnSave.TabIndex = 128;
            this.btnSave.Text = "Guardar";
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // ocBanks
            // 
            this.ocBanks.Caption = "Banco";
            this.ocBanks.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocBanks.CharacterCasing = System.Windows.Forms.CharacterCasing.Normal;
            appearance2.BackColor = System.Drawing.SystemColors.Window;
            appearance2.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ocBanks.DisplayLayout.Appearance = appearance2;
            this.ocBanks.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ExtendLastColumn;
            this.ocBanks.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance3.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(123)))), ((int)(((byte)(158)))), ((int)(((byte)(189)))));
            appearance3.Cursor = System.Windows.Forms.Cursors.Arrow;
            appearance3.FontData.BoldAsString = "False";
            appearance3.FontData.ItalicAsString = "False";
            appearance3.FontData.Name = "Verdana";
            appearance3.FontData.SizeInPoints = 8F;
            appearance3.FontData.StrikeoutAsString = "False";
            appearance3.FontData.UnderlineAsString = "False";
            appearance3.ForeColor = System.Drawing.Color.Black;
            appearance3.ForeColorDisabled = System.Drawing.Color.FromArgb(((int)(((byte)(173)))), ((int)(((byte)(170)))), ((int)(((byte)(156)))));
            appearance3.TextHAlign = Infragistics.Win.HAlign.Left;
            appearance3.TextTrimming = Infragistics.Win.TextTrimming.Character;
            appearance3.TextVAlign = Infragistics.Win.VAlign.Middle;
            this.ocBanks.DisplayLayout.CaptionAppearance = appearance3;
            this.ocBanks.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance4.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance4.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance4.BorderColor = System.Drawing.SystemColors.Window;
            this.ocBanks.DisplayLayout.GroupByBox.Appearance = appearance4;
            appearance5.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ocBanks.DisplayLayout.GroupByBox.BandLabelAppearance = appearance5;
            this.ocBanks.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance6.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance6.BackColor2 = System.Drawing.SystemColors.Control;
            appearance6.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance6.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ocBanks.DisplayLayout.GroupByBox.PromptAppearance = appearance6;
            this.ocBanks.DisplayLayout.LoadStyle = Infragistics.Win.UltraWinGrid.LoadStyle.LoadOnDemand;
            this.ocBanks.DisplayLayout.MaxBandDepth = 1;
            this.ocBanks.DisplayLayout.MaxColScrollRegions = 1;
            this.ocBanks.DisplayLayout.MaxRowScrollRegions = 1;
            appearance7.BackColor = System.Drawing.SystemColors.Window;
            appearance7.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ocBanks.DisplayLayout.Override.ActiveCellAppearance = appearance7;
            appearance8.BackColor = System.Drawing.SystemColors.Highlight;
            appearance8.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ocBanks.DisplayLayout.Override.ActiveRowAppearance = appearance8;
            this.ocBanks.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ocBanks.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance9.BackColor = System.Drawing.SystemColors.Window;
            this.ocBanks.DisplayLayout.Override.CardAreaAppearance = appearance9;
            appearance10.BorderColor = System.Drawing.Color.Silver;
            appearance10.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ocBanks.DisplayLayout.Override.CellAppearance = appearance10;
            this.ocBanks.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ocBanks.DisplayLayout.Override.CellPadding = 0;
            this.ocBanks.DisplayLayout.Override.ColumnAutoSizeMode = Infragistics.Win.UltraWinGrid.ColumnAutoSizeMode.AllRowsInBand;
            appearance11.BackColor = System.Drawing.SystemColors.Control;
            appearance11.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance11.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance11.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance11.BorderColor = System.Drawing.SystemColors.Window;
            this.ocBanks.DisplayLayout.Override.GroupByRowAppearance = appearance11;
            appearance12.TextHAlign = Infragistics.Win.HAlign.Left;
            this.ocBanks.DisplayLayout.Override.HeaderAppearance = appearance12;
            this.ocBanks.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ocBanks.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            this.ocBanks.DisplayLayout.Override.MergedCellStyle = Infragistics.Win.UltraWinGrid.MergedCellStyle.Never;
            appearance13.BackColor = System.Drawing.SystemColors.Window;
            appearance13.BorderColor = System.Drawing.Color.Silver;
            this.ocBanks.DisplayLayout.Override.RowAppearance = appearance13;
            this.ocBanks.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            this.ocBanks.DisplayLayout.Override.RowSizing = Infragistics.Win.UltraWinGrid.RowSizing.AutoFree;
            appearance14.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ocBanks.DisplayLayout.Override.TemplateAddRowAppearance = appearance14;
            this.ocBanks.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ocBanks.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ocBanks.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ocBanks.DisplayMember = "";
            this.ocBanks.Font = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocBanks.Location = new System.Drawing.Point(148, 87);
            this.ocBanks.Name = "ocBanks";
            this.ocBanks.Required = 'Y';
            this.ocBanks.Size = new System.Drawing.Size(202, 22);
            this.ocBanks.TabIndex = 130;
            this.ocBanks.ValueMember = "";
            // 
            // tbAccount
            // 
            this.tbAccount.Caption = "Número de Cuenta";
            this.tbAccount.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbAccount.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbAccount.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbAccount.Required = 'Y';
            this.tbAccount.Length = null;
            this.tbAccount.TextBoxValue = "";
            this.tbAccount.Location = new System.Drawing.Point(526, 87);
            this.tbAccount.Name = "tbAccount";
            this.tbAccount.Size = new System.Drawing.Size(202, 20);
            this.tbAccount.TabIndex = 132;
            // 
            // tbCheckNumber
            // 
            this.tbCheckNumber.Caption = "Número Cheque";
            this.tbCheckNumber.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbCheckNumber.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbCheckNumber.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbCheckNumber.Required = 'Y';
            this.tbCheckNumber.Length = null;
            this.tbCheckNumber.TextBoxValue = "";
            this.tbCheckNumber.Location = new System.Drawing.Point(148, 124);
            this.tbCheckNumber.Name = "tbCheckNumber";
            this.tbCheckNumber.Size = new System.Drawing.Size(202, 20);
            this.tbCheckNumber.TabIndex = 134;
            // 
            // tbCheckDate
            // 
            this.tbCheckDate.TypeBox = OpenSystems.Windows.Controls.TypesBox.DateTime;
            this.tbCheckDate.Caption = "Fecha del Cheque";
            this.tbCheckDate.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbCheckDate.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbCheckDate.Multiline = true;
            this.tbCheckDate.FormatString = "dddd, dd\' de \'MMMM\' de \'yyyy";
            this.tbCheckDate.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbCheckDate.Required = 'Y';
            this.tbCheckDate.Length = null;
            this.tbCheckDate.TextBoxValue = null;
            this.tbCheckDate.Location = new System.Drawing.Point(177, 159);
            this.tbCheckDate.Name = "tbCheckDate";
            this.tbCheckDate.Size = new System.Drawing.Size(173, 22);
            this.tbCheckDate.TabIndex = 136;
            // 
            // tbAlarmDate
            // 
            this.tbAlarmDate.TypeBox = OpenSystems.Windows.Controls.TypesBox.DateTime;
            this.tbAlarmDate.Caption = "Fecha de Alarma";
            this.tbAlarmDate.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbAlarmDate.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbAlarmDate.Multiline = true;
            this.tbAlarmDate.FormatString = "dddd, dd\' de \'MMMM\' de \'yyyy";
            this.tbAlarmDate.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbAlarmDate.Required = 'Y';
            this.tbAlarmDate.Length = null;
            this.tbAlarmDate.TextBoxValue = null;
            this.tbAlarmDate.Location = new System.Drawing.Point(555, 159);
            this.tbAlarmDate.Name = "tbAlarmDate";
            this.tbAlarmDate.Size = new System.Drawing.Size(173, 22);
            this.tbAlarmDate.TabIndex = 138;
            // 
            // tbCheckValue
            // 
            this.tbCheckValue.TypeBox = OpenSystems.Windows.Controls.TypesBox.Currency;
            this.tbCheckValue.Caption = "Valor";
            this.tbCheckValue.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbCheckValue.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbCheckValue.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Double;
            this.tbCheckValue.NumberComposition = new OpenSystems.Windows.Controls.Number(15, 2);
            this.tbCheckValue.Required = 'Y';
            this.tbCheckValue.Length = null;
            this.tbCheckValue.TextBoxObjectValue = 0;
            this.tbCheckValue.TextBoxValue = "0";
            this.tbCheckValue.Location = new System.Drawing.Point(526, 124);
            this.tbCheckValue.Name = "tbCheckValue";
            this.tbCheckValue.Size = new System.Drawing.Size(202, 20);
            this.tbCheckValue.TabIndex = 140;
            // 
            // otCheckData
            // 
            this.otCheckData.BackColor = System.Drawing.Color.Transparent;
            this.otCheckData.Caption = "    Datos del Nuevo Cheque";
            this.otCheckData.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.otCheckData.Location = new System.Drawing.Point(1, 15);
            this.otCheckData.Name = "otCheckData";
            this.otCheckData.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.otCheckData.Size = new System.Drawing.Size(755, 31);
            this.otCheckData.TabIndex = 141;
            // 
            // tbPrevCheck
            // 
            this.tbPrevCheck.Caption = "Cheque a Reemplazar";
            this.tbPrevCheck.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbPrevCheck.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbPrevCheck.ReadOnly = true;
            this.tbPrevCheck.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbPrevCheck.Length = null;
            this.tbPrevCheck.TextBoxValue = "";
            this.tbPrevCheck.Location = new System.Drawing.Point(148, 51);
            this.tbPrevCheck.Name = "tbPrevCheck";
            this.tbPrevCheck.Size = new System.Drawing.Size(202, 20);
            this.tbPrevCheck.TabIndex = 149;
            // 
            // FCCH
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(755, 238);
            this.Controls.Add(this.tbPrevCheck);
            this.Controls.Add(this.otCheckData);
            this.Controls.Add(this.tbCheckValue);
            this.Controls.Add(this.tbAlarmDate);
            this.Controls.Add(this.tbCheckDate);
            this.Controls.Add(this.tbCheckNumber);
            this.Controls.Add(this.tbAccount);
            this.Controls.Add(this.ocBanks);
            this.Controls.Add(this.btnSave);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "FCCH";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FCCH - Forma de Cambio de Cheque";
            ((System.ComponentModel.ISupportInitialize)(this.ocBanks)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenButton btnSave;
        private OpenSystems.Windows.Controls.OpenCombo ocBanks;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbAccount;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbCheckNumber;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbCheckDate;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbAlarmDate;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbCheckValue;
        private OpenSystems.Windows.Controls.OpenTitle otCheckData;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbPrevCheck;
    }
}