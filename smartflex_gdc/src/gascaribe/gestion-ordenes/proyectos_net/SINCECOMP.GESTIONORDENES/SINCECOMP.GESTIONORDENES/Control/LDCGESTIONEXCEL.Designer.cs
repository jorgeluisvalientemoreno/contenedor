namespace SINCECOMP.GESTIONORDENES.Control
{
    partial class LDCGESTIONEXCEL
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

        #region Código generado por el Diseñador de componentes

        /// <summary> 
        /// Método necesario para admitir el Diseñador. No se puede modificar 
        /// el contenido del método con el editor de código.
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
            this.ocbHasta = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.ocbDesde = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.obReporte = new OpenSystems.Windows.Controls.OpenButton();
            this.ocbTipoTrab = new OpenSystems.Windows.Controls.OpenCombo();
            ((System.ComponentModel.ISupportInitialize)(this.ocbTipoTrab)).BeginInit();
            this.SuspendLayout();
            // 
            // ocbHasta
            // 
            this.ocbHasta.TypeBox = OpenSystems.Windows.Controls.TypesBox.DateTime;
            this.ocbHasta.Caption = "Hasta";
            this.ocbHasta.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocbHasta.CaptionLocation = OpenSystems.Windows.Controls.CaptionLocations.Top;
            this.ocbHasta.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.ocbHasta.FormatString = "dddd, dd\' de \'MMMM\' de \'yyyy";
            this.ocbHasta.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.ocbHasta.Length = null;
            this.ocbHasta.TextBoxValue = null;
            this.ocbHasta.Location = new System.Drawing.Point(467, 23);
            this.ocbHasta.Name = "ocbHasta";
            this.ocbHasta.Size = new System.Drawing.Size(173, 22);
            this.ocbHasta.TabIndex = 59;
            // 
            // ocbDesde
            // 
            this.ocbDesde.TypeBox = OpenSystems.Windows.Controls.TypesBox.DateTime;
            this.ocbDesde.Caption = "Desde";
            this.ocbDesde.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocbDesde.CaptionLocation = OpenSystems.Windows.Controls.CaptionLocations.Top;
            this.ocbDesde.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.ocbDesde.FormatString = "dddd, dd\' de \'MMMM\' de \'yyyy";
            this.ocbDesde.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.ocbDesde.Length = null;
            this.ocbDesde.TextBoxValue = null;
            this.ocbDesde.Location = new System.Drawing.Point(270, 23);
            this.ocbDesde.Name = "ocbDesde";
            this.ocbDesde.Size = new System.Drawing.Size(173, 22);
            this.ocbDesde.TabIndex = 58;
            // 
            // obReporte
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.obReporte.Appearance = appearance1;
            this.obReporte.Location = new System.Drawing.Point(686, 23);
            this.obReporte.Name = "obReporte";
            this.obReporte.Size = new System.Drawing.Size(99, 25);
            this.obReporte.TabIndex = 60;
            this.obReporte.Text = "&GENERAR";
            this.obReporte.Click += new System.EventHandler(this.obReporte_Click);
            // 
            // ocbTipoTrab
            // 
            this.ocbTipoTrab.Caption = "Tipo De Trabajo";
            this.ocbTipoTrab.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocbTipoTrab.CaptionLocation = OpenSystems.Windows.Controls.CaptionLocations.Top;
            this.ocbTipoTrab.CharacterCasing = System.Windows.Forms.CharacterCasing.Normal;
            appearance2.BackColor = System.Drawing.SystemColors.Window;
            appearance2.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ocbTipoTrab.DisplayLayout.Appearance = appearance2;
            this.ocbTipoTrab.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ExtendLastColumn;
            this.ocbTipoTrab.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
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
            this.ocbTipoTrab.DisplayLayout.CaptionAppearance = appearance3;
            this.ocbTipoTrab.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance4.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance4.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance4.BorderColor = System.Drawing.SystemColors.Window;
            this.ocbTipoTrab.DisplayLayout.GroupByBox.Appearance = appearance4;
            appearance5.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ocbTipoTrab.DisplayLayout.GroupByBox.BandLabelAppearance = appearance5;
            this.ocbTipoTrab.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance6.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance6.BackColor2 = System.Drawing.SystemColors.Control;
            appearance6.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance6.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ocbTipoTrab.DisplayLayout.GroupByBox.PromptAppearance = appearance6;
            this.ocbTipoTrab.DisplayLayout.LoadStyle = Infragistics.Win.UltraWinGrid.LoadStyle.LoadOnDemand;
            this.ocbTipoTrab.DisplayLayout.MaxBandDepth = 1;
            this.ocbTipoTrab.DisplayLayout.MaxColScrollRegions = 1;
            this.ocbTipoTrab.DisplayLayout.MaxRowScrollRegions = 1;
            appearance7.BackColor = System.Drawing.SystemColors.Window;
            appearance7.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ocbTipoTrab.DisplayLayout.Override.ActiveCellAppearance = appearance7;
            appearance8.BackColor = System.Drawing.SystemColors.Highlight;
            appearance8.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ocbTipoTrab.DisplayLayout.Override.ActiveRowAppearance = appearance8;
            this.ocbTipoTrab.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ocbTipoTrab.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance9.BackColor = System.Drawing.SystemColors.Window;
            this.ocbTipoTrab.DisplayLayout.Override.CardAreaAppearance = appearance9;
            appearance10.BorderColor = System.Drawing.Color.Silver;
            appearance10.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ocbTipoTrab.DisplayLayout.Override.CellAppearance = appearance10;
            this.ocbTipoTrab.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ocbTipoTrab.DisplayLayout.Override.CellPadding = 0;
            this.ocbTipoTrab.DisplayLayout.Override.ColumnAutoSizeMode = Infragistics.Win.UltraWinGrid.ColumnAutoSizeMode.AllRowsInBand;
            appearance11.BackColor = System.Drawing.SystemColors.Control;
            appearance11.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance11.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance11.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance11.BorderColor = System.Drawing.SystemColors.Window;
            this.ocbTipoTrab.DisplayLayout.Override.GroupByRowAppearance = appearance11;
            appearance12.TextHAlign = Infragistics.Win.HAlign.Left;
            this.ocbTipoTrab.DisplayLayout.Override.HeaderAppearance = appearance12;
            this.ocbTipoTrab.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ocbTipoTrab.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            this.ocbTipoTrab.DisplayLayout.Override.MergedCellStyle = Infragistics.Win.UltraWinGrid.MergedCellStyle.Never;
            appearance13.BackColor = System.Drawing.SystemColors.Window;
            appearance13.BorderColor = System.Drawing.Color.Silver;
            this.ocbTipoTrab.DisplayLayout.Override.RowAppearance = appearance13;
            this.ocbTipoTrab.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            this.ocbTipoTrab.DisplayLayout.Override.RowSizing = Infragistics.Win.UltraWinGrid.RowSizing.AutoFree;
            appearance14.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ocbTipoTrab.DisplayLayout.Override.TemplateAddRowAppearance = appearance14;
            this.ocbTipoTrab.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ocbTipoTrab.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ocbTipoTrab.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ocbTipoTrab.DisplayMember = "";
            this.ocbTipoTrab.Font = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocbTipoTrab.Location = new System.Drawing.Point(31, 23);
            this.ocbTipoTrab.Name = "ocbTipoTrab";
            this.ocbTipoTrab.Size = new System.Drawing.Size(207, 22);
            this.ocbTipoTrab.TabIndex = 57;
            this.ocbTipoTrab.ValueMember = "";
            // 
            // LDCGESTIONEXCEL
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.Controls.Add(this.ocbTipoTrab);
            this.Controls.Add(this.obReporte);
            this.Controls.Add(this.ocbHasta);
            this.Controls.Add(this.ocbDesde);
            this.Name = "LDCGESTIONEXCEL";
            this.Size = new System.Drawing.Size(1051, 600);
            ((System.ComponentModel.ISupportInitialize)(this.ocbTipoTrab)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenSimpleTextBox ocbHasta;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox ocbDesde;
        private OpenSystems.Windows.Controls.OpenButton obReporte;
        private OpenSystems.Windows.Controls.OpenCombo ocbTipoTrab;
    }
}
