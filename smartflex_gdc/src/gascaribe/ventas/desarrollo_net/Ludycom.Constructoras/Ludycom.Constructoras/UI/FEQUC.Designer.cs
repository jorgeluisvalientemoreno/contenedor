namespace Ludycom.Constructoras.UI
{
    partial class FEQUC
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
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("PropUnitEquivalence", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn1 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Selected");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn2 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Address");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn3 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("AdressParsed");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn4 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Product", -1, null, 0, Infragistics.Win.UltraWinGrid.SortIndicator.Ascending, false);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn5 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("PropUnitId");
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
            this.otProjectBasicData = new OpenSystems.Windows.Controls.OpenTitle();
            this.tbRequestId = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.tbRequestRegisterDate = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.tbAddress = new OpenSystems.Windows.Controls.OpenAddressBox();
            this.tbCustomerId = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.ocIdentificationType = new OpenSystems.Windows.Controls.OpenCombo();
            this.tbCustomerName = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.ugPropUnits = new Infragistics.Win.UltraWinGrid.UltraGrid();
            this.bsPropUnitEquivalence = new System.Windows.Forms.BindingSource(this.components);
            this.openTitle1 = new OpenSystems.Windows.Controls.OpenTitle();
            this.btnProcess = new OpenSystems.Windows.Controls.OpenButton();
            this.btnSearch = new OpenSystems.Windows.Controls.OpenButton();
            this.chkAll = new System.Windows.Forms.CheckBox();
            ((System.ComponentModel.ISupportInitialize)(this.ocIdentificationType)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ugPropUnits)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bsPropUnitEquivalence)).BeginInit();
            this.SuspendLayout();
            // 
            // otProjectBasicData
            // 
            this.otProjectBasicData.BackColor = System.Drawing.Color.Transparent;
            this.otProjectBasicData.Caption = "    Información de la Solicitud";
            this.otProjectBasicData.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.otProjectBasicData.Location = new System.Drawing.Point(1, 18);
            this.otProjectBasicData.Name = "otProjectBasicData";
            this.otProjectBasicData.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.otProjectBasicData.Size = new System.Drawing.Size(957, 35);
            this.otProjectBasicData.TabIndex = 34;
            // 
            // tbRequestId
            // 
            this.tbRequestId.Caption = "Solicitud";
            this.tbRequestId.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbRequestId.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbRequestId.ReadOnly = true;
            this.tbRequestId.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbRequestId.Length = null;
            this.tbRequestId.TextBoxValue = "";
            this.tbRequestId.Location = new System.Drawing.Point(125, 55);
            this.tbRequestId.Name = "tbRequestId";
            this.tbRequestId.Size = new System.Drawing.Size(112, 20);
            this.tbRequestId.TabIndex = 85;
            // 
            // tbRequestRegisterDate
            // 
            this.tbRequestRegisterDate.TypeBox = OpenSystems.Windows.Controls.TypesBox.DateTime;
            this.tbRequestRegisterDate.Caption = "F. de Registro";
            this.tbRequestRegisterDate.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbRequestRegisterDate.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbRequestRegisterDate.Multiline = true;
            this.tbRequestRegisterDate.FormatString = "dddd, dd\' de \'MMMM\' de \'yyyy";
            this.tbRequestRegisterDate.ReadOnly = true;
            this.tbRequestRegisterDate.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbRequestRegisterDate.Length = null;
            this.tbRequestRegisterDate.TextBoxValue = null;
            this.tbRequestRegisterDate.Location = new System.Drawing.Point(749, 55);
            this.tbRequestRegisterDate.Name = "tbRequestRegisterDate";
            this.tbRequestRegisterDate.Size = new System.Drawing.Size(173, 22);
            this.tbRequestRegisterDate.TabIndex = 86;
            // 
            // tbAddress
            // 
            this.tbAddress.AutonomusTransaction = false;
            this.tbAddress.BackColor = System.Drawing.Color.Transparent;
            this.tbAddress.Caption = "Dirección";
            this.tbAddress.Font = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbAddress.GeograpLocation = "";
            this.tbAddress.Length = null;
            this.tbAddress.location = new System.Drawing.Point(125, 127);
            this.tbAddress.Location = new System.Drawing.Point(125, 127);
            this.tbAddress.Name = "tbAddress";
            this.tbAddress.ReadOnly = false;
            this.tbAddress.Required = 'N';
            this.tbAddress.Size = new System.Drawing.Size(324, 22);
            this.tbAddress.TabIndex = 84;
            this.tbAddress.Tag = "Dirección";
            // 
            // tbCustomerId
            // 
            this.tbCustomerId.Caption = "";
            this.tbCustomerId.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbCustomerId.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbCustomerId.ReadOnly = true;
            this.tbCustomerId.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbCustomerId.Length = null;
            this.tbCustomerId.TextBoxValue = "";
            this.tbCustomerId.Location = new System.Drawing.Point(244, 92);
            this.tbCustomerId.Name = "tbCustomerId";
            this.tbCustomerId.Size = new System.Drawing.Size(155, 20);
            this.tbCustomerId.TabIndex = 89;
            // 
            // ocIdentificationType
            // 
            this.ocIdentificationType.Caption = "Id del Cliente";
            this.ocIdentificationType.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocIdentificationType.CharacterCasing = System.Windows.Forms.CharacterCasing.Normal;
            appearance1.BackColor = System.Drawing.SystemColors.Window;
            appearance1.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ocIdentificationType.DisplayLayout.Appearance = appearance1;
            this.ocIdentificationType.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ExtendLastColumn;
            this.ocIdentificationType.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance2.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(123)))), ((int)(((byte)(158)))), ((int)(((byte)(189)))));
            appearance2.Cursor = System.Windows.Forms.Cursors.Arrow;
            appearance2.FontData.BoldAsString = "False";
            appearance2.FontData.ItalicAsString = "False";
            appearance2.FontData.Name = "Verdana";
            appearance2.FontData.SizeInPoints = 8F;
            appearance2.FontData.StrikeoutAsString = "False";
            appearance2.FontData.UnderlineAsString = "False";
            appearance2.ForeColor = System.Drawing.Color.Black;
            appearance2.ForeColorDisabled = System.Drawing.Color.FromArgb(((int)(((byte)(173)))), ((int)(((byte)(170)))), ((int)(((byte)(156)))));
            appearance2.TextHAlign = Infragistics.Win.HAlign.Left;
            appearance2.TextTrimming = Infragistics.Win.TextTrimming.Character;
            appearance2.TextVAlign = Infragistics.Win.VAlign.Middle;
            this.ocIdentificationType.DisplayLayout.CaptionAppearance = appearance2;
            this.ocIdentificationType.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance3.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance3.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance3.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance3.BorderColor = System.Drawing.SystemColors.Window;
            this.ocIdentificationType.DisplayLayout.GroupByBox.Appearance = appearance3;
            appearance4.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ocIdentificationType.DisplayLayout.GroupByBox.BandLabelAppearance = appearance4;
            this.ocIdentificationType.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance5.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance5.BackColor2 = System.Drawing.SystemColors.Control;
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance5.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ocIdentificationType.DisplayLayout.GroupByBox.PromptAppearance = appearance5;
            this.ocIdentificationType.DisplayLayout.LoadStyle = Infragistics.Win.UltraWinGrid.LoadStyle.LoadOnDemand;
            this.ocIdentificationType.DisplayLayout.MaxBandDepth = 1;
            this.ocIdentificationType.DisplayLayout.MaxColScrollRegions = 1;
            this.ocIdentificationType.DisplayLayout.MaxRowScrollRegions = 1;
            appearance6.BackColor = System.Drawing.SystemColors.Window;
            appearance6.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ocIdentificationType.DisplayLayout.Override.ActiveCellAppearance = appearance6;
            appearance7.BackColor = System.Drawing.SystemColors.Highlight;
            appearance7.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ocIdentificationType.DisplayLayout.Override.ActiveRowAppearance = appearance7;
            this.ocIdentificationType.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ocIdentificationType.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance8.BackColor = System.Drawing.SystemColors.Window;
            this.ocIdentificationType.DisplayLayout.Override.CardAreaAppearance = appearance8;
            appearance9.BorderColor = System.Drawing.Color.Silver;
            appearance9.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ocIdentificationType.DisplayLayout.Override.CellAppearance = appearance9;
            this.ocIdentificationType.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ocIdentificationType.DisplayLayout.Override.CellPadding = 0;
            this.ocIdentificationType.DisplayLayout.Override.ColumnAutoSizeMode = Infragistics.Win.UltraWinGrid.ColumnAutoSizeMode.AllRowsInBand;
            appearance10.BackColor = System.Drawing.SystemColors.Control;
            appearance10.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance10.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance10.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance10.BorderColor = System.Drawing.SystemColors.Window;
            this.ocIdentificationType.DisplayLayout.Override.GroupByRowAppearance = appearance10;
            appearance11.TextHAlign = Infragistics.Win.HAlign.Left;
            this.ocIdentificationType.DisplayLayout.Override.HeaderAppearance = appearance11;
            this.ocIdentificationType.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ocIdentificationType.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            this.ocIdentificationType.DisplayLayout.Override.MergedCellStyle = Infragistics.Win.UltraWinGrid.MergedCellStyle.Never;
            appearance12.BackColor = System.Drawing.SystemColors.Window;
            appearance12.BorderColor = System.Drawing.Color.Silver;
            this.ocIdentificationType.DisplayLayout.Override.RowAppearance = appearance12;
            this.ocIdentificationType.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            this.ocIdentificationType.DisplayLayout.Override.RowSizing = Infragistics.Win.UltraWinGrid.RowSizing.AutoFree;
            appearance13.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ocIdentificationType.DisplayLayout.Override.TemplateAddRowAppearance = appearance13;
            this.ocIdentificationType.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ocIdentificationType.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ocIdentificationType.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ocIdentificationType.DisplayMember = "";
            this.ocIdentificationType.Font = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocIdentificationType.Location = new System.Drawing.Point(125, 90);
            this.ocIdentificationType.Name = "ocIdentificationType";
            this.ocIdentificationType.ReadOnly = true;
            this.ocIdentificationType.Size = new System.Drawing.Size(112, 22);
            this.ocIdentificationType.TabIndex = 90;
            this.ocIdentificationType.Updatable = 'N';
            this.ocIdentificationType.ValueMember = "";
            // 
            // tbCustomerName
            // 
            this.tbCustomerName.Caption = "Nombre del Cliente";
            this.tbCustomerName.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbCustomerName.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbCustomerName.ReadOnly = true;
            this.tbCustomerName.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbCustomerName.Length = null;
            this.tbCustomerName.TextBoxValue = "";
            this.tbCustomerName.Location = new System.Drawing.Point(594, 92);
            this.tbCustomerName.Name = "tbCustomerName";
            this.tbCustomerName.Size = new System.Drawing.Size(328, 20);
            this.tbCustomerName.TabIndex = 92;
            // 
            // ugPropUnits
            // 
            this.ugPropUnits.DataSource = this.bsPropUnitEquivalence;
            appearance14.BackColor = System.Drawing.SystemColors.Window;
            appearance14.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            appearance14.ThemedElementAlpha = Infragistics.Win.Alpha.Opaque;
            this.ugPropUnits.DisplayLayout.Appearance = appearance14;
            ultraGridColumn1.AllowRowFiltering = Infragistics.Win.DefaultableBoolean.False;
            ultraGridColumn1.AllowRowSummaries = Infragistics.Win.UltraWinGrid.AllowRowSummaries.False;
            ultraGridColumn1.Header.Fixed = true;
            ultraGridColumn1.Header.FixedHeaderIndicator = Infragistics.Win.UltraWinGrid.FixedHeaderIndicator.None;
            ultraGridColumn1.Header.VisiblePosition = 0;
            ultraGridColumn2.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            ultraGridColumn2.Header.VisiblePosition = 1;
            ultraGridColumn3.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            ultraGridColumn3.Header.VisiblePosition = 2;
            ultraGridColumn3.Width = 243;
            ultraGridColumn4.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            ultraGridColumn4.Header.VisiblePosition = 3;
            ultraGridColumn4.Width = 140;
            ultraGridColumn5.Header.VisiblePosition = 4;
            ultraGridColumn5.Width = 242;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn1,
            ultraGridColumn2,
            ultraGridColumn3,
            ultraGridColumn4,
            ultraGridColumn5});
            this.ugPropUnits.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.ugPropUnits.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance15.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance15.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance15.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance15.BorderColor = System.Drawing.SystemColors.Window;
            this.ugPropUnits.DisplayLayout.GroupByBox.Appearance = appearance15;
            appearance16.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugPropUnits.DisplayLayout.GroupByBox.BandLabelAppearance = appearance16;
            this.ugPropUnits.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance17.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance17.BackColor2 = System.Drawing.SystemColors.Control;
            appearance17.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance17.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugPropUnits.DisplayLayout.GroupByBox.PromptAppearance = appearance17;
            this.ugPropUnits.DisplayLayout.MaxColScrollRegions = 1;
            this.ugPropUnits.DisplayLayout.MaxRowScrollRegions = 1;
            appearance18.BackColor = System.Drawing.SystemColors.Window;
            appearance18.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ugPropUnits.DisplayLayout.Override.ActiveCellAppearance = appearance18;
            appearance19.BackColor = System.Drawing.SystemColors.Highlight;
            appearance19.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ugPropUnits.DisplayLayout.Override.ActiveRowAppearance = appearance19;
            this.ugPropUnits.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ugPropUnits.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance20.BackColor = System.Drawing.SystemColors.Window;
            this.ugPropUnits.DisplayLayout.Override.CardAreaAppearance = appearance20;
            appearance21.BorderColor = System.Drawing.Color.Silver;
            appearance21.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ugPropUnits.DisplayLayout.Override.CellAppearance = appearance21;
            this.ugPropUnits.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ugPropUnits.DisplayLayout.Override.CellPadding = 0;
            appearance22.BackColor = System.Drawing.SystemColors.Control;
            appearance22.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance22.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance22.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance22.BorderColor = System.Drawing.SystemColors.Window;
            this.ugPropUnits.DisplayLayout.Override.GroupByRowAppearance = appearance22;
            appearance23.TextHAlign = Infragistics.Win.HAlign.Left;
            this.ugPropUnits.DisplayLayout.Override.HeaderAppearance = appearance23;
            this.ugPropUnits.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ugPropUnits.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance24.BackColor = System.Drawing.SystemColors.Window;
            appearance24.BorderColor = System.Drawing.Color.Silver;
            this.ugPropUnits.DisplayLayout.Override.RowAppearance = appearance24;
            this.ugPropUnits.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance25.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ugPropUnits.DisplayLayout.Override.TemplateAddRowAppearance = appearance25;
            this.ugPropUnits.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugPropUnits.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugPropUnits.DisplayLayout.UseFixedHeaders = true;
            this.ugPropUnits.Location = new System.Drawing.Point(45, 201);
            this.ugPropUnits.Name = "ugPropUnits";
            this.ugPropUnits.Size = new System.Drawing.Size(866, 320);
            this.ugPropUnits.TabIndex = 94;
            // 
            // bsPropUnitEquivalence
            // 
            this.bsPropUnitEquivalence.DataSource = typeof(Ludycom.Constructoras.ENTITIES.PropUnitEquivalence);
            // 
            // openTitle1
            // 
            this.openTitle1.BackColor = System.Drawing.Color.Transparent;
            this.openTitle1.Caption = "    Direcciones a Asociar";
            this.openTitle1.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.openTitle1.Location = new System.Drawing.Point(1, 168);
            this.openTitle1.Name = "openTitle1";
            this.openTitle1.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.openTitle1.Size = new System.Drawing.Size(957, 33);
            this.openTitle1.TabIndex = 95;
            // 
            // btnProcess
            // 
            appearance26.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance26.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnProcess.Appearance = appearance26;
            this.btnProcess.Location = new System.Drawing.Point(800, 544);
            this.btnProcess.Name = "btnProcess";
            this.btnProcess.Size = new System.Drawing.Size(111, 23);
            this.btnProcess.TabIndex = 96;
            this.btnProcess.Text = "Procesar";
            this.btnProcess.Click += new System.EventHandler(this.btnProcess_Click);
            // 
            // btnSearch
            // 
            appearance27.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance27.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnSearch.Appearance = appearance27;
            this.btnSearch.Location = new System.Drawing.Point(665, 544);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(111, 23);
            this.btnSearch.TabIndex = 97;
            this.btnSearch.Text = "Buscar";
            this.btnSearch.Visible = false;
            // 
            // chkAll
            // 
            this.chkAll.AutoSize = true;
            this.chkAll.Location = new System.Drawing.Point(56, 206);
            this.chkAll.Name = "chkAll";
            this.chkAll.Size = new System.Drawing.Size(15, 14);
            this.chkAll.TabIndex = 103;
            this.chkAll.UseVisualStyleBackColor = true;
            this.chkAll.CheckedChanged += new System.EventHandler(this.chkAll_CheckedChanged);
            // 
            // FEQUC
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(957, 586);
            this.Controls.Add(this.chkAll);
            this.Controls.Add(this.btnSearch);
            this.Controls.Add(this.btnProcess);
            this.Controls.Add(this.openTitle1);
            this.Controls.Add(this.ugPropUnits);
            this.Controls.Add(this.tbCustomerName);
            this.Controls.Add(this.tbCustomerId);
            this.Controls.Add(this.ocIdentificationType);
            this.Controls.Add(this.tbRequestId);
            this.Controls.Add(this.tbRequestRegisterDate);
            this.Controls.Add(this.tbAddress);
            this.Controls.Add(this.otProjectBasicData);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "FEQUC";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FEQUC - Forma de Gestión de Equivalencia de Unidades Prediales Cotizadas";
            ((System.ComponentModel.ISupportInitialize)(this.ocIdentificationType)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ugPropUnits)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bsPropUnitEquivalence)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenTitle otProjectBasicData;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbRequestId;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbRequestRegisterDate;
        private OpenSystems.Windows.Controls.OpenAddressBox tbAddress;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbCustomerId;
        private OpenSystems.Windows.Controls.OpenCombo ocIdentificationType;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbCustomerName;
        private Infragistics.Win.UltraWinGrid.UltraGrid ugPropUnits;
        private OpenSystems.Windows.Controls.OpenTitle openTitle1;
        private OpenSystems.Windows.Controls.OpenButton btnProcess;
        private OpenSystems.Windows.Controls.OpenButton btnSearch;
        private System.Windows.Forms.BindingSource bsPropUnitEquivalence;
        private System.Windows.Forms.CheckBox chkAll;
    }
}