namespace Ludycom.Constructoras.UI
{
    partial class FRNC
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
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance17 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance18 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance19 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance20 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance21 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance22 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance23 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance24 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance25 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance26 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance27 = new Infragistics.Win.Appearance();
            this.panel15 = new System.Windows.Forms.Panel();
            this.openTitle7 = new OpenSystems.Windows.Controls.OpenTitle();
            this.tbBillCollectAddress = new OpenSystems.Windows.Controls.OpenAddressBox();
            this.btnAccept = new OpenSystems.Windows.Controls.OpenButton();
            this.ocActivities = new OpenSystems.Windows.Controls.OpenCombo();
            this.ocCycle = new OpenSystems.Windows.Controls.OpenCombo();
            this.panel15.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ocActivities)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ocCycle)).BeginInit();
            this.SuspendLayout();
            // 
            // panel15
            // 
            this.panel15.Controls.Add(this.openTitle7);
            this.panel15.Location = new System.Drawing.Point(14, 22);
            this.panel15.Name = "panel15";
            this.panel15.Size = new System.Drawing.Size(681, 32);
            this.panel15.TabIndex = 128;
            // 
            // openTitle7
            // 
            this.openTitle7.BackColor = System.Drawing.Color.Transparent;
            this.openTitle7.Caption = "Datos del Contrato";
            this.openTitle7.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.openTitle7.Location = new System.Drawing.Point(3, 6);
            this.openTitle7.Name = "openTitle7";
            this.openTitle7.Size = new System.Drawing.Size(681, 21);
            this.openTitle7.TabIndex = 92;
            // 
            // tbBillCollectAddress
            // 
            this.tbBillCollectAddress.AutonomusTransaction = false;
            this.tbBillCollectAddress.BackColor = System.Drawing.Color.Transparent;
            this.tbBillCollectAddress.Caption = "Dirección de Cobro";
            this.tbBillCollectAddress.Font = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbBillCollectAddress.GeograpLocation = "";
            this.tbBillCollectAddress.Length = null;
            this.tbBillCollectAddress.location = new System.Drawing.Point(177, 60);
            this.tbBillCollectAddress.Location = new System.Drawing.Point(177, 60);
            this.tbBillCollectAddress.Name = "tbBillCollectAddress";
            this.tbBillCollectAddress.ReadOnly = false;
            this.tbBillCollectAddress.Size = new System.Drawing.Size(363, 22);
            this.tbBillCollectAddress.TabIndex = 129;
            // 
            // btnAccept
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnAccept.Appearance = appearance1;
            this.btnAccept.Location = new System.Drawing.Point(545, 187);
            this.btnAccept.Name = "btnAccept";
            this.btnAccept.Size = new System.Drawing.Size(111, 23);
            this.btnAccept.TabIndex = 179;
            this.btnAccept.Text = "Aceptar";
            this.btnAccept.Click += new System.EventHandler(this.btnAccept_Click);
            // 
            // ocActivities
            // 
            this.ocActivities.Caption = "Actividad";
            this.ocActivities.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocActivities.CharacterCasing = System.Windows.Forms.CharacterCasing.Normal;
            appearance2.BackColor = System.Drawing.SystemColors.Window;
            appearance2.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ocActivities.DisplayLayout.Appearance = appearance2;
            this.ocActivities.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ExtendLastColumn;
            this.ocActivities.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
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
            this.ocActivities.DisplayLayout.CaptionAppearance = appearance3;
            this.ocActivities.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance4.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance4.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance4.BorderColor = System.Drawing.SystemColors.Window;
            this.ocActivities.DisplayLayout.GroupByBox.Appearance = appearance4;
            appearance5.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ocActivities.DisplayLayout.GroupByBox.BandLabelAppearance = appearance5;
            this.ocActivities.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance6.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance6.BackColor2 = System.Drawing.SystemColors.Control;
            appearance6.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance6.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ocActivities.DisplayLayout.GroupByBox.PromptAppearance = appearance6;
            this.ocActivities.DisplayLayout.LoadStyle = Infragistics.Win.UltraWinGrid.LoadStyle.LoadOnDemand;
            this.ocActivities.DisplayLayout.MaxBandDepth = 1;
            this.ocActivities.DisplayLayout.MaxColScrollRegions = 1;
            this.ocActivities.DisplayLayout.MaxRowScrollRegions = 1;
            appearance7.BackColor = System.Drawing.SystemColors.Window;
            appearance7.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ocActivities.DisplayLayout.Override.ActiveCellAppearance = appearance7;
            appearance8.BackColor = System.Drawing.SystemColors.Highlight;
            appearance8.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ocActivities.DisplayLayout.Override.ActiveRowAppearance = appearance8;
            this.ocActivities.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ocActivities.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance9.BackColor = System.Drawing.SystemColors.Window;
            this.ocActivities.DisplayLayout.Override.CardAreaAppearance = appearance9;
            appearance10.BorderColor = System.Drawing.Color.Silver;
            appearance10.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ocActivities.DisplayLayout.Override.CellAppearance = appearance10;
            this.ocActivities.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ocActivities.DisplayLayout.Override.CellPadding = 0;
            this.ocActivities.DisplayLayout.Override.ColumnAutoSizeMode = Infragistics.Win.UltraWinGrid.ColumnAutoSizeMode.AllRowsInBand;
            appearance11.BackColor = System.Drawing.SystemColors.Control;
            appearance11.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance11.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance11.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance11.BorderColor = System.Drawing.SystemColors.Window;
            this.ocActivities.DisplayLayout.Override.GroupByRowAppearance = appearance11;
            appearance12.TextHAlign = Infragistics.Win.HAlign.Left;
            this.ocActivities.DisplayLayout.Override.HeaderAppearance = appearance12;
            this.ocActivities.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ocActivities.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            this.ocActivities.DisplayLayout.Override.MergedCellStyle = Infragistics.Win.UltraWinGrid.MergedCellStyle.Never;
            appearance13.BackColor = System.Drawing.SystemColors.Window;
            appearance13.BorderColor = System.Drawing.Color.Silver;
            this.ocActivities.DisplayLayout.Override.RowAppearance = appearance13;
            this.ocActivities.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            this.ocActivities.DisplayLayout.Override.RowSizing = Infragistics.Win.UltraWinGrid.RowSizing.AutoFree;
            appearance14.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ocActivities.DisplayLayout.Override.TemplateAddRowAppearance = appearance14;
            this.ocActivities.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ocActivities.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ocActivities.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ocActivities.DisplayMember = "";
            this.ocActivities.Font = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocActivities.Location = new System.Drawing.Point(177, 97);
            this.ocActivities.Name = "ocActivities";
            this.ocActivities.Required = 'Y';
            this.ocActivities.Size = new System.Drawing.Size(363, 22);
            this.ocActivities.TabIndex = 181;
            this.ocActivities.ValueMember = "";
            // 
            // ocCycle
            // 
            this.ocCycle.Caption = "Ciclo";
            this.ocCycle.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocCycle.CharacterCasing = System.Windows.Forms.CharacterCasing.Normal;
            appearance15.BackColor = System.Drawing.SystemColors.Window;
            appearance15.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ocCycle.DisplayLayout.Appearance = appearance15;
            this.ocCycle.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ExtendLastColumn;
            this.ocCycle.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance16.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(123)))), ((int)(((byte)(158)))), ((int)(((byte)(189)))));
            appearance16.Cursor = System.Windows.Forms.Cursors.Arrow;
            appearance16.FontData.BoldAsString = "False";
            appearance16.FontData.ItalicAsString = "False";
            appearance16.FontData.Name = "Verdana";
            appearance16.FontData.SizeInPoints = 8F;
            appearance16.FontData.StrikeoutAsString = "False";
            appearance16.FontData.UnderlineAsString = "False";
            appearance16.ForeColor = System.Drawing.Color.Black;
            appearance16.ForeColorDisabled = System.Drawing.Color.FromArgb(((int)(((byte)(173)))), ((int)(((byte)(170)))), ((int)(((byte)(156)))));
            appearance16.TextHAlign = Infragistics.Win.HAlign.Left;
            appearance16.TextTrimming = Infragistics.Win.TextTrimming.Character;
            appearance16.TextVAlign = Infragistics.Win.VAlign.Middle;
            this.ocCycle.DisplayLayout.CaptionAppearance = appearance16;
            this.ocCycle.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance17.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance17.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance17.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance17.BorderColor = System.Drawing.SystemColors.Window;
            this.ocCycle.DisplayLayout.GroupByBox.Appearance = appearance17;
            appearance18.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ocCycle.DisplayLayout.GroupByBox.BandLabelAppearance = appearance18;
            this.ocCycle.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance19.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance19.BackColor2 = System.Drawing.SystemColors.Control;
            appearance19.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance19.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ocCycle.DisplayLayout.GroupByBox.PromptAppearance = appearance19;
            this.ocCycle.DisplayLayout.LoadStyle = Infragistics.Win.UltraWinGrid.LoadStyle.LoadOnDemand;
            this.ocCycle.DisplayLayout.MaxBandDepth = 1;
            this.ocCycle.DisplayLayout.MaxColScrollRegions = 1;
            this.ocCycle.DisplayLayout.MaxRowScrollRegions = 1;
            appearance20.BackColor = System.Drawing.SystemColors.Window;
            appearance20.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ocCycle.DisplayLayout.Override.ActiveCellAppearance = appearance20;
            appearance21.BackColor = System.Drawing.SystemColors.Highlight;
            appearance21.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ocCycle.DisplayLayout.Override.ActiveRowAppearance = appearance21;
            this.ocCycle.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ocCycle.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance22.BackColor = System.Drawing.SystemColors.Window;
            this.ocCycle.DisplayLayout.Override.CardAreaAppearance = appearance22;
            appearance23.BorderColor = System.Drawing.Color.Silver;
            appearance23.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ocCycle.DisplayLayout.Override.CellAppearance = appearance23;
            this.ocCycle.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ocCycle.DisplayLayout.Override.CellPadding = 0;
            this.ocCycle.DisplayLayout.Override.ColumnAutoSizeMode = Infragistics.Win.UltraWinGrid.ColumnAutoSizeMode.AllRowsInBand;
            appearance24.BackColor = System.Drawing.SystemColors.Control;
            appearance24.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance24.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance24.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance24.BorderColor = System.Drawing.SystemColors.Window;
            this.ocCycle.DisplayLayout.Override.GroupByRowAppearance = appearance24;
            appearance25.TextHAlign = Infragistics.Win.HAlign.Left;
            this.ocCycle.DisplayLayout.Override.HeaderAppearance = appearance25;
            this.ocCycle.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ocCycle.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            this.ocCycle.DisplayLayout.Override.MergedCellStyle = Infragistics.Win.UltraWinGrid.MergedCellStyle.Never;
            appearance26.BackColor = System.Drawing.SystemColors.Window;
            appearance26.BorderColor = System.Drawing.Color.Silver;
            this.ocCycle.DisplayLayout.Override.RowAppearance = appearance26;
            this.ocCycle.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            this.ocCycle.DisplayLayout.Override.RowSizing = Infragistics.Win.UltraWinGrid.RowSizing.AutoFree;
            appearance27.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ocCycle.DisplayLayout.Override.TemplateAddRowAppearance = appearance27;
            this.ocCycle.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ocCycle.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ocCycle.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ocCycle.DisplayMember = "";
            this.ocCycle.Font = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocCycle.Location = new System.Drawing.Point(177, 136);
            this.ocCycle.Name = "ocCycle";
            this.ocCycle.Required = 'Y';
            this.ocCycle.Size = new System.Drawing.Size(363, 22);
            this.ocCycle.TabIndex = 183;
            this.ocCycle.ValueMember = "";
            // 
            // FRNC
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(707, 222);
            this.Controls.Add(this.ocCycle);
            this.Controls.Add(this.ocActivities);
            this.Controls.Add(this.btnAccept);
            this.Controls.Add(this.tbBillCollectAddress);
            this.Controls.Add(this.panel15);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "FRNC";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FRNC - Datos Para Registro del Contrato";
            this.panel15.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ocActivities)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ocCycle)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel panel15;
        private OpenSystems.Windows.Controls.OpenTitle openTitle7;
        private OpenSystems.Windows.Controls.OpenAddressBox tbBillCollectAddress;
        private OpenSystems.Windows.Controls.OpenButton btnAccept;
        private OpenSystems.Windows.Controls.OpenCombo ocActivities;
        private OpenSystems.Windows.Controls.OpenCombo ocCycle;
    }
}