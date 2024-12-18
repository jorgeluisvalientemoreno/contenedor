namespace SINCECOMP.VALORECLAMO.UI
{
    partial class LDSOLICITANTE
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
            this.BtnProcesar = new OpenSystems.Windows.Controls.OpenButton();
            this.txt_correo = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.txt_telefono = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.txt_apellido = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.cmb_solicitantetipodoc = new OpenSystems.Windows.Controls.OpenCombo();
            this.txt_solicitantedoc = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.txt_nombre = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            ((System.ComponentModel.ISupportInitialize)(this.cmb_solicitantetipodoc)).BeginInit();
            this.SuspendLayout();
            // 
            // BtnProcesar
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.BtnProcesar.Appearance = appearance1;
            this.BtnProcesar.Location = new System.Drawing.Point(695, 70);
            this.BtnProcesar.Name = "BtnProcesar";
            this.BtnProcesar.Size = new System.Drawing.Size(87, 23);
            this.BtnProcesar.TabIndex = 83;
            this.BtnProcesar.Text = "&Procesar";
            this.BtnProcesar.Click += new System.EventHandler(this.BtnProcesar_Click);
            // 
            // txt_correo
            // 
            this.txt_correo.Caption = "Correo";
            this.txt_correo.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_correo.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.txt_correo.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.txt_correo.Required = 'Y';
            this.txt_correo.Length = null;
            this.txt_correo.TextBoxValue = "";
            this.txt_correo.Location = new System.Drawing.Point(128, 67);
            this.txt_correo.Margin = new System.Windows.Forms.Padding(3, 5, 3, 5);
            this.txt_correo.Name = "txt_correo";
            this.txt_correo.Size = new System.Drawing.Size(288, 25);
            this.txt_correo.TabIndex = 82;
            // 
            // txt_telefono
            // 
            this.txt_telefono.Caption = "Telefono";
            this.txt_telefono.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_telefono.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.txt_telefono.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.txt_telefono.Required = 'Y';
            this.txt_telefono.Length = null;
            this.txt_telefono.TextBoxValue = "";
            this.txt_telefono.Location = new System.Drawing.Point(493, 42);
            this.txt_telefono.Margin = new System.Windows.Forms.Padding(3, 5, 3, 5);
            this.txt_telefono.Name = "txt_telefono";
            this.txt_telefono.Size = new System.Drawing.Size(288, 25);
            this.txt_telefono.TabIndex = 81;
            // 
            // txt_apellido
            // 
            this.txt_apellido.Caption = "Apellido";
            this.txt_apellido.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_apellido.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.txt_apellido.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.txt_apellido.Required = 'Y';
            this.txt_apellido.Length = null;
            this.txt_apellido.TextBoxValue = "";
            this.txt_apellido.Location = new System.Drawing.Point(493, 14);
            this.txt_apellido.Margin = new System.Windows.Forms.Padding(3, 5, 3, 5);
            this.txt_apellido.Name = "txt_apellido";
            this.txt_apellido.Size = new System.Drawing.Size(288, 25);
            this.txt_apellido.TabIndex = 80;
            // 
            // cmb_solicitantetipodoc
            // 
            this.cmb_solicitantetipodoc.Caption = "Identificacion";
            this.cmb_solicitantetipodoc.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_solicitantetipodoc.CharacterCasing = System.Windows.Forms.CharacterCasing.Normal;
            appearance2.BackColor = System.Drawing.SystemColors.Window;
            appearance2.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.cmb_solicitantetipodoc.DisplayLayout.Appearance = appearance2;
            this.cmb_solicitantetipodoc.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ExtendLastColumn;
            this.cmb_solicitantetipodoc.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
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
            this.cmb_solicitantetipodoc.DisplayLayout.CaptionAppearance = appearance3;
            this.cmb_solicitantetipodoc.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance4.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance4.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance4.BorderColor = System.Drawing.SystemColors.Window;
            this.cmb_solicitantetipodoc.DisplayLayout.GroupByBox.Appearance = appearance4;
            appearance5.ForeColor = System.Drawing.SystemColors.GrayText;
            this.cmb_solicitantetipodoc.DisplayLayout.GroupByBox.BandLabelAppearance = appearance5;
            this.cmb_solicitantetipodoc.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance6.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance6.BackColor2 = System.Drawing.SystemColors.Control;
            appearance6.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance6.ForeColor = System.Drawing.SystemColors.GrayText;
            this.cmb_solicitantetipodoc.DisplayLayout.GroupByBox.PromptAppearance = appearance6;
            this.cmb_solicitantetipodoc.DisplayLayout.LoadStyle = Infragistics.Win.UltraWinGrid.LoadStyle.LoadOnDemand;
            this.cmb_solicitantetipodoc.DisplayLayout.MaxBandDepth = 1;
            this.cmb_solicitantetipodoc.DisplayLayout.MaxColScrollRegions = 1;
            this.cmb_solicitantetipodoc.DisplayLayout.MaxRowScrollRegions = 1;
            appearance7.BackColor = System.Drawing.SystemColors.Window;
            appearance7.ForeColor = System.Drawing.SystemColors.ControlText;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.ActiveCellAppearance = appearance7;
            appearance8.BackColor = System.Drawing.SystemColors.Highlight;
            appearance8.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.ActiveRowAppearance = appearance8;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance9.BackColor = System.Drawing.SystemColors.Window;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.CardAreaAppearance = appearance9;
            appearance10.BorderColor = System.Drawing.Color.Silver;
            appearance10.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.CellAppearance = appearance10;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.CellPadding = 0;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.ColumnAutoSizeMode = Infragistics.Win.UltraWinGrid.ColumnAutoSizeMode.AllRowsInBand;
            appearance11.BackColor = System.Drawing.SystemColors.Control;
            appearance11.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance11.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance11.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance11.BorderColor = System.Drawing.SystemColors.Window;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.GroupByRowAppearance = appearance11;
            appearance12.TextHAlign = Infragistics.Win.HAlign.Left;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.HeaderAppearance = appearance12;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortSingle;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.MergedCellStyle = Infragistics.Win.UltraWinGrid.MergedCellStyle.Never;
            appearance13.BackColor = System.Drawing.SystemColors.Window;
            appearance13.BorderColor = System.Drawing.Color.Silver;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.RowAppearance = appearance13;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.RowSizing = Infragistics.Win.UltraWinGrid.RowSizing.AutoFree;
            appearance14.BackColor = System.Drawing.SystemColors.ControlLight;
            this.cmb_solicitantetipodoc.DisplayLayout.Override.TemplateAddRowAppearance = appearance14;
            this.cmb_solicitantetipodoc.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.cmb_solicitantetipodoc.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.cmb_solicitantetipodoc.DisplayMember = "";
            this.cmb_solicitantetipodoc.Font = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmb_solicitantetipodoc.Location = new System.Drawing.Point(128, 42);
            this.cmb_solicitantetipodoc.Name = "cmb_solicitantetipodoc";
            this.cmb_solicitantetipodoc.ReadOnly = true;
            this.cmb_solicitantetipodoc.Required = 'Y';
            this.cmb_solicitantetipodoc.Size = new System.Drawing.Size(126, 22);
            this.cmb_solicitantetipodoc.TabIndex = 84;
            this.cmb_solicitantetipodoc.Updatable = 'N';
            this.cmb_solicitantetipodoc.ValueMember = "";
            // 
            // txt_solicitantedoc
            // 
            this.txt_solicitantedoc.Caption = "";
            this.txt_solicitantedoc.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_solicitantedoc.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.txt_solicitantedoc.ReadOnly = true;
            this.txt_solicitantedoc.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.txt_solicitantedoc.Length = null;
            this.txt_solicitantedoc.TextBoxValue = "";
            this.txt_solicitantedoc.Location = new System.Drawing.Point(255, 42);
            this.txt_solicitantedoc.Margin = new System.Windows.Forms.Padding(3, 5, 3, 5);
            this.txt_solicitantedoc.Name = "txt_solicitantedoc";
            this.txt_solicitantedoc.Size = new System.Drawing.Size(161, 22);
            this.txt_solicitantedoc.TabIndex = 85;
            // 
            // txt_nombre
            // 
            this.txt_nombre.Caption = "Nombre";
            this.txt_nombre.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_nombre.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.txt_nombre.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.txt_nombre.Required = 'Y';
            this.txt_nombre.Length = null;
            this.txt_nombre.TextBoxValue = "";
            this.txt_nombre.Location = new System.Drawing.Point(128, 14);
            this.txt_nombre.Margin = new System.Windows.Forms.Padding(3, 5, 3, 5);
            this.txt_nombre.Name = "txt_nombre";
            this.txt_nombre.Size = new System.Drawing.Size(288, 25);
            this.txt_nombre.TabIndex = 79;
            // 
            // LDSOLICITANTE
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(803, 109);
            this.Controls.Add(this.BtnProcesar);
            this.Controls.Add(this.txt_correo);
            this.Controls.Add(this.txt_telefono);
            this.Controls.Add(this.txt_apellido);
            this.Controls.Add(this.cmb_solicitantetipodoc);
            this.Controls.Add(this.txt_solicitantedoc);
            this.Controls.Add(this.txt_nombre);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(819, 148);
            this.MinimumSize = new System.Drawing.Size(819, 148);
            this.Name = "LDSOLICITANTE";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "LDSolicitante - Creacion Cliente";
            this.Load += new System.EventHandler(this.LDSOLICITANTE_Load);
            ((System.ComponentModel.ISupportInitialize)(this.cmb_solicitantetipodoc)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenButton BtnProcesar;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox txt_correo;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox txt_telefono;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox txt_apellido;
        private OpenSystems.Windows.Controls.OpenCombo cmb_solicitantetipodoc;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox txt_solicitantedoc;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox txt_nombre;
    }
}