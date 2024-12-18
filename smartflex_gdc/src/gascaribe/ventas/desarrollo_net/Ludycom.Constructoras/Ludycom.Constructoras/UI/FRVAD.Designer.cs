using System.Collections.Generic;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;
namespace Ludycom.Constructoras.UI
{
    partial class FRVAD
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
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("CheckConcept", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn1 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Concepto", -1, null, 0, Infragistics.Win.UltraWinGrid.SortIndicator.Ascending, false);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn2 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Costo_adicional");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn3 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Valor_adicional");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn4 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Subtotal");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn5 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Iva");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn6 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Total");
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FRVAD));
            this.btnCancel = new OpenSystems.Windows.Controls.OpenButton();
            this.btnRegisterAdditionalVal = new OpenSystems.Windows.Controls.OpenButton();
            this.tbAdditionalValue = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.otValueData = new OpenSystems.Windows.Controls.OpenTitle();
            this.tbProjectName = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.tbCustomerName = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.tbCustomerId = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.ocIdentificationType = new OpenSystems.Windows.Controls.OpenCombo();
            this.otProjectBasicData = new OpenSystems.Windows.Controls.OpenTitle();
            this.tbCostValue = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.tbComment = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.ugMonthlyFee = new Infragistics.Win.UltraWinGrid.UltraGrid();
            this.bsConceptos = new System.Windows.Forms.BindingSource(this.components);
            this.bnNavegador = new System.Windows.Forms.BindingNavigator(this.components);
            this.bindingNavigatorCountItem = new System.Windows.Forms.ToolStripLabel();
            this.bindingNavigatorMoveFirstItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorMovePreviousItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorSeparator = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorPositionItem = new System.Windows.Forms.ToolStripTextBox();
            this.bindingNavigatorSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorMoveNextItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorMoveLastItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.bnAddNewConcept = new System.Windows.Forms.ToolStripButton();
            this.bnMonthlyFeeDeleteItem = new System.Windows.Forms.ToolStripButton();
            ((System.ComponentModel.ISupportInitialize)(this.ocIdentificationType)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ugMonthlyFee)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bsConceptos)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bnNavegador)).BeginInit();
            this.bnNavegador.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnCancel
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnCancel.Appearance = appearance1;
            this.btnCancel.Location = new System.Drawing.Point(771, 470);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(103, 23);
            this.btnCancel.TabIndex = 181;
            this.btnCancel.Text = "Cancelar";
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnRegisterAdditionalVal
            // 
            appearance2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance2.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnRegisterAdditionalVal.Appearance = appearance2;
            this.btnRegisterAdditionalVal.Enabled = false;
            this.btnRegisterAdditionalVal.Location = new System.Drawing.Point(650, 470);
            this.btnRegisterAdditionalVal.Name = "btnRegisterAdditionalVal";
            this.btnRegisterAdditionalVal.Size = new System.Drawing.Size(104, 23);
            this.btnRegisterAdditionalVal.TabIndex = 180;
            this.btnRegisterAdditionalVal.Text = "Registrar Valor";
            this.btnRegisterAdditionalVal.Click += new System.EventHandler(this.btnRegisterAdditionalVal_Click);
            // 
            // tbAdditionalValue
            // 
            this.tbAdditionalValue.TypeBox = OpenSystems.Windows.Controls.TypesBox.Currency;
            this.tbAdditionalValue.Caption = "Valor adicional";
            this.tbAdditionalValue.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbAdditionalValue.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbAdditionalValue.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Double;
            this.tbAdditionalValue.NumberComposition = new OpenSystems.Windows.Controls.Number(15, 2);
            this.tbAdditionalValue.Required = 'Y';
            this.tbAdditionalValue.Length = null;
            this.tbAdditionalValue.TextBoxObjectValue = 0;
            this.tbAdditionalValue.TextBoxValue = "0";
            this.tbAdditionalValue.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
            this.tbAdditionalValue.Location = new System.Drawing.Point(504, 158);
            this.tbAdditionalValue.Name = "tbAdditionalValue";
            this.tbAdditionalValue.Size = new System.Drawing.Size(158, 20);
            this.tbAdditionalValue.TabIndex = 189;
            this.tbAdditionalValue.Validating += new System.ComponentModel.CancelEventHandler(this.tbAdditionalValue_Validating);
            // 
            // otValueData
            // 
            this.otValueData.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
            this.otValueData.BackColor = System.Drawing.Color.Transparent;
            this.otValueData.Caption = "    Datos del Valor Adicional";
            this.otValueData.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.otValueData.Location = new System.Drawing.Point(3, 119);
            this.otValueData.Name = "otValueData";
            this.otValueData.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.otValueData.Size = new System.Drawing.Size(942, 46);
            this.otValueData.TabIndex = 178;
            // 
            // tbProjectName
            // 
            this.tbProjectName.Caption = "Nombre del Proyecto";
            this.tbProjectName.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbProjectName.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbProjectName.ReadOnly = true;
            this.tbProjectName.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbProjectName.Length = null;
            this.tbProjectName.TextBoxValue = "";
            this.tbProjectName.Location = new System.Drawing.Point(149, 50);
            this.tbProjectName.Name = "tbProjectName";
            this.tbProjectName.Size = new System.Drawing.Size(257, 20);
            this.tbProjectName.TabIndex = 177;
            // 
            // tbCustomerName
            // 
            this.tbCustomerName.Caption = "Cliente";
            this.tbCustomerName.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbCustomerName.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbCustomerName.ReadOnly = true;
            this.tbCustomerName.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbCustomerName.Length = null;
            this.tbCustomerName.TextBoxValue = "";
            this.tbCustomerName.Location = new System.Drawing.Point(504, 93);
            this.tbCustomerName.Name = "tbCustomerName";
            this.tbCustomerName.Size = new System.Drawing.Size(250, 20);
            this.tbCustomerName.TabIndex = 176;
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
            this.tbCustomerId.Location = new System.Drawing.Point(248, 93);
            this.tbCustomerId.Name = "tbCustomerId";
            this.tbCustomerId.Size = new System.Drawing.Size(158, 20);
            this.tbCustomerId.TabIndex = 174;
            // 
            // ocIdentificationType
            // 
            this.ocIdentificationType.Caption = "Id del Cliente";
            this.ocIdentificationType.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocIdentificationType.CharacterCasing = System.Windows.Forms.CharacterCasing.Normal;
            appearance3.BackColor = System.Drawing.SystemColors.Window;
            appearance3.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ocIdentificationType.DisplayLayout.Appearance = appearance3;
            this.ocIdentificationType.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ExtendLastColumn;
            this.ocIdentificationType.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance4.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(123)))), ((int)(((byte)(158)))), ((int)(((byte)(189)))));
            appearance4.Cursor = System.Windows.Forms.Cursors.Arrow;
            appearance4.FontData.BoldAsString = "False";
            appearance4.FontData.ItalicAsString = "False";
            appearance4.FontData.Name = "Verdana";
            appearance4.FontData.SizeInPoints = 8F;
            appearance4.FontData.StrikeoutAsString = "False";
            appearance4.FontData.UnderlineAsString = "False";
            appearance4.ForeColor = System.Drawing.Color.Black;
            appearance4.ForeColorDisabled = System.Drawing.Color.FromArgb(((int)(((byte)(173)))), ((int)(((byte)(170)))), ((int)(((byte)(156)))));
            appearance4.TextHAlign = Infragistics.Win.HAlign.Left;
            appearance4.TextTrimming = Infragistics.Win.TextTrimming.Character;
            appearance4.TextVAlign = Infragistics.Win.VAlign.Middle;
            this.ocIdentificationType.DisplayLayout.CaptionAppearance = appearance4;
            this.ocIdentificationType.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance5.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance5.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance5.BorderColor = System.Drawing.SystemColors.Window;
            this.ocIdentificationType.DisplayLayout.GroupByBox.Appearance = appearance5;
            appearance6.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ocIdentificationType.DisplayLayout.GroupByBox.BandLabelAppearance = appearance6;
            this.ocIdentificationType.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance7.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance7.BackColor2 = System.Drawing.SystemColors.Control;
            appearance7.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance7.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ocIdentificationType.DisplayLayout.GroupByBox.PromptAppearance = appearance7;
            this.ocIdentificationType.DisplayLayout.LoadStyle = Infragistics.Win.UltraWinGrid.LoadStyle.LoadOnDemand;
            this.ocIdentificationType.DisplayLayout.MaxBandDepth = 1;
            this.ocIdentificationType.DisplayLayout.MaxColScrollRegions = 1;
            this.ocIdentificationType.DisplayLayout.MaxRowScrollRegions = 1;
            appearance8.BackColor = System.Drawing.SystemColors.Window;
            appearance8.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ocIdentificationType.DisplayLayout.Override.ActiveCellAppearance = appearance8;
            appearance9.BackColor = System.Drawing.SystemColors.Highlight;
            appearance9.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ocIdentificationType.DisplayLayout.Override.ActiveRowAppearance = appearance9;
            this.ocIdentificationType.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ocIdentificationType.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance10.BackColor = System.Drawing.SystemColors.Window;
            this.ocIdentificationType.DisplayLayout.Override.CardAreaAppearance = appearance10;
            appearance11.BorderColor = System.Drawing.Color.Silver;
            appearance11.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ocIdentificationType.DisplayLayout.Override.CellAppearance = appearance11;
            this.ocIdentificationType.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ocIdentificationType.DisplayLayout.Override.CellPadding = 0;
            this.ocIdentificationType.DisplayLayout.Override.ColumnAutoSizeMode = Infragistics.Win.UltraWinGrid.ColumnAutoSizeMode.AllRowsInBand;
            appearance12.BackColor = System.Drawing.SystemColors.Control;
            appearance12.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance12.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance12.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance12.BorderColor = System.Drawing.SystemColors.Window;
            this.ocIdentificationType.DisplayLayout.Override.GroupByRowAppearance = appearance12;
            appearance13.TextHAlign = Infragistics.Win.HAlign.Left;
            this.ocIdentificationType.DisplayLayout.Override.HeaderAppearance = appearance13;
            this.ocIdentificationType.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ocIdentificationType.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            this.ocIdentificationType.DisplayLayout.Override.MergedCellStyle = Infragistics.Win.UltraWinGrid.MergedCellStyle.Never;
            appearance14.BackColor = System.Drawing.SystemColors.Window;
            appearance14.BorderColor = System.Drawing.Color.Silver;
            this.ocIdentificationType.DisplayLayout.Override.RowAppearance = appearance14;
            this.ocIdentificationType.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            this.ocIdentificationType.DisplayLayout.Override.RowSizing = Infragistics.Win.UltraWinGrid.RowSizing.AutoFree;
            appearance15.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ocIdentificationType.DisplayLayout.Override.TemplateAddRowAppearance = appearance15;
            this.ocIdentificationType.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ocIdentificationType.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ocIdentificationType.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ocIdentificationType.DisplayMember = "";
            this.ocIdentificationType.Font = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ocIdentificationType.Location = new System.Drawing.Point(149, 91);
            this.ocIdentificationType.Name = "ocIdentificationType";
            this.ocIdentificationType.ReadOnly = true;
            this.ocIdentificationType.Size = new System.Drawing.Size(92, 22);
            this.ocIdentificationType.TabIndex = 175;
            this.ocIdentificationType.Updatable = 'N';
            this.ocIdentificationType.ValueMember = "";
            // 
            // otProjectBasicData
            // 
            this.otProjectBasicData.BackColor = System.Drawing.Color.Transparent;
            this.otProjectBasicData.Caption = "    Datos del Proyecto";
            this.otProjectBasicData.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.otProjectBasicData.Location = new System.Drawing.Point(3, 14);
            this.otProjectBasicData.Name = "otProjectBasicData";
            this.otProjectBasicData.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.otProjectBasicData.Size = new System.Drawing.Size(942, 100);
            this.otProjectBasicData.TabIndex = 173;
            // 
            // tbCostValue
            // 
            this.tbCostValue.TypeBox = OpenSystems.Windows.Controls.TypesBox.Currency;
            this.tbCostValue.Caption = "Costo Adicional";
            this.tbCostValue.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbCostValue.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbCostValue.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Double;
            this.tbCostValue.NumberComposition = new OpenSystems.Windows.Controls.Number(15, 2);
            this.tbCostValue.Required = 'Y';
            this.tbCostValue.Length = null;
            this.tbCostValue.TextBoxObjectValue = 0;
            this.tbCostValue.TextBoxValue = "0";
            this.tbCostValue.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
            this.tbCostValue.Location = new System.Drawing.Point(149, 158);
            this.tbCostValue.Name = "tbCostValue";
            this.tbCostValue.Size = new System.Drawing.Size(173, 20);
            this.tbCostValue.TabIndex = 188;
            this.tbCostValue.Validating += new System.ComponentModel.CancelEventHandler(this.tbCostValue_Validating);
            // 
            // tbComment
            // 
            this.tbComment.Caption = "Observación";
            this.tbComment.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbComment.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbComment.Multiline = true;
            this.tbComment.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.tbComment.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbComment.Required = 'Y';
            this.tbComment.Length = null;
            this.tbComment.TextBoxValue = "";
            this.tbComment.Location = new System.Drawing.Point(149, 184);
            this.tbComment.Name = "tbComment";
            this.tbComment.Size = new System.Drawing.Size(513, 43);
            this.tbComment.TabIndex = 190;
            // 
            // ugMonthlyFee
            // 
            this.ugMonthlyFee.DataSource = this.bsConceptos;
            appearance16.BackColor = System.Drawing.SystemColors.Window;
            appearance16.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            appearance16.ThemedElementAlpha = Infragistics.Win.Alpha.Opaque;
            this.ugMonthlyFee.DisplayLayout.Appearance = appearance16;
            ultraGridColumn1.Format = "";
            ultraGridColumn1.Header.VisiblePosition = 0;
            ultraGridColumn2.Format = "C";
            ultraGridColumn2.Header.VisiblePosition = 1;
            ultraGridColumn3.Format = "C";
            ultraGridColumn3.Header.VisiblePosition = 2;
            ultraGridColumn4.Format = "C";
            ultraGridColumn4.Header.VisiblePosition = 3;
            ultraGridColumn5.Format = "C";
            ultraGridColumn5.Header.VisiblePosition = 4;
            ultraGridColumn6.Format = "C";
            ultraGridColumn6.Header.VisiblePosition = 5;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn1,
            ultraGridColumn2,
            ultraGridColumn3,
            ultraGridColumn4,
            ultraGridColumn5,
            ultraGridColumn6});
            this.ugMonthlyFee.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.ugMonthlyFee.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance17.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance17.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance17.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance17.BorderColor = System.Drawing.SystemColors.Window;
            this.ugMonthlyFee.DisplayLayout.GroupByBox.Appearance = appearance17;
            appearance18.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugMonthlyFee.DisplayLayout.GroupByBox.BandLabelAppearance = appearance18;
            this.ugMonthlyFee.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance19.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance19.BackColor2 = System.Drawing.SystemColors.Control;
            appearance19.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance19.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugMonthlyFee.DisplayLayout.GroupByBox.PromptAppearance = appearance19;
            this.ugMonthlyFee.DisplayLayout.MaxColScrollRegions = 1;
            this.ugMonthlyFee.DisplayLayout.MaxRowScrollRegions = 1;
            appearance20.BackColor = System.Drawing.SystemColors.Window;
            appearance20.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ugMonthlyFee.DisplayLayout.Override.ActiveCellAppearance = appearance20;
            appearance21.BackColor = System.Drawing.SystemColors.Highlight;
            appearance21.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ugMonthlyFee.DisplayLayout.Override.ActiveRowAppearance = appearance21;
            this.ugMonthlyFee.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ugMonthlyFee.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance22.BackColor = System.Drawing.SystemColors.Window;
            this.ugMonthlyFee.DisplayLayout.Override.CardAreaAppearance = appearance22;
            appearance23.BorderColor = System.Drawing.Color.Silver;
            appearance23.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ugMonthlyFee.DisplayLayout.Override.CellAppearance = appearance23;
            this.ugMonthlyFee.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ugMonthlyFee.DisplayLayout.Override.CellPadding = 0;
            appearance24.BackColor = System.Drawing.SystemColors.Control;
            appearance24.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance24.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance24.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance24.BorderColor = System.Drawing.SystemColors.Window;
            this.ugMonthlyFee.DisplayLayout.Override.GroupByRowAppearance = appearance24;
            appearance25.TextHAlign = Infragistics.Win.HAlign.Left;
            this.ugMonthlyFee.DisplayLayout.Override.HeaderAppearance = appearance25;
            this.ugMonthlyFee.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ugMonthlyFee.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance26.BackColor = System.Drawing.SystemColors.Window;
            appearance26.BorderColor = System.Drawing.Color.Silver;
            this.ugMonthlyFee.DisplayLayout.Override.RowAppearance = appearance26;
            this.ugMonthlyFee.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance27.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ugMonthlyFee.DisplayLayout.Override.TemplateAddRowAppearance = appearance27;
            this.ugMonthlyFee.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugMonthlyFee.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugMonthlyFee.DisplayLayout.UseFixedHeaders = true;
            this.ugMonthlyFee.Location = new System.Drawing.Point(23, 270);
            this.ugMonthlyFee.Name = "ugMonthlyFee";
            this.ugMonthlyFee.Size = new System.Drawing.Size(821, 194);
            this.ugMonthlyFee.TabIndex = 199;
            this.ugMonthlyFee.AfterCellUpdate += new Infragistics.Win.UltraWinGrid.CellEventHandler(this.dtgTrabAdic_AfterCellUpdate);
            this.ugMonthlyFee.BeforeCellActivate += new Infragistics.Win.UltraWinGrid.CancelableCellEventHandler(this.ugMonthlyFee_BeforeCellActivate);
            // 
            // bsConceptos
            // 
            this.bsConceptos.AllowNew = true;
            this.bsConceptos.DataSource = typeof(Ludycom.Constructoras.ENTITIES.CheckConcept);
            // 
            // bnNavegador
            // 
            this.bnNavegador.AddNewItem = null;
            this.bnNavegador.AutoSize = false;
            this.bnNavegador.BindingSource = this.bsConceptos;
            this.bnNavegador.CountItem = this.bindingNavigatorCountItem;
            this.bnNavegador.DeleteItem = null;
            this.bnNavegador.Dock = System.Windows.Forms.DockStyle.None;
            this.bnNavegador.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.bindingNavigatorMoveFirstItem,
            this.bindingNavigatorMovePreviousItem,
            this.bindingNavigatorSeparator,
            this.bindingNavigatorPositionItem,
            this.bindingNavigatorCountItem,
            this.bindingNavigatorSeparator1,
            this.bindingNavigatorMoveNextItem,
            this.bindingNavigatorMoveLastItem,
            this.bindingNavigatorSeparator2,
            this.bnAddNewConcept,
            this.bnMonthlyFeeDeleteItem});
            this.bnNavegador.Location = new System.Drawing.Point(23, 242);
            this.bnNavegador.MoveFirstItem = this.bindingNavigatorMoveFirstItem;
            this.bnNavegador.MoveLastItem = this.bindingNavigatorMoveLastItem;
            this.bnNavegador.MoveNextItem = this.bindingNavigatorMoveNextItem;
            this.bnNavegador.MovePreviousItem = this.bindingNavigatorMovePreviousItem;
            this.bnNavegador.Name = "bnNavegador";
            this.bnNavegador.PositionItem = this.bindingNavigatorPositionItem;
            this.bnNavegador.Size = new System.Drawing.Size(821, 25);
            this.bnNavegador.Stretch = true;
            this.bnNavegador.TabIndex = 200;
            this.bnNavegador.Text = "bindingNavigator1";
            // 
            // bindingNavigatorCountItem
            // 
            this.bindingNavigatorCountItem.Name = "bindingNavigatorCountItem";
            this.bindingNavigatorCountItem.Size = new System.Drawing.Size(37, 22);
            this.bindingNavigatorCountItem.Text = "de {0}";
            this.bindingNavigatorCountItem.ToolTipText = "Número total de elementos";
            // 
            // bindingNavigatorMoveFirstItem
            // 
            this.bindingNavigatorMoveFirstItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMoveFirstItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveFirstItem.Image")));
            this.bindingNavigatorMoveFirstItem.Name = "bindingNavigatorMoveFirstItem";
            this.bindingNavigatorMoveFirstItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMoveFirstItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMoveFirstItem.Text = "Mover primero";
            // 
            // bindingNavigatorMovePreviousItem
            // 
            this.bindingNavigatorMovePreviousItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMovePreviousItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMovePreviousItem.Image")));
            this.bindingNavigatorMovePreviousItem.Name = "bindingNavigatorMovePreviousItem";
            this.bindingNavigatorMovePreviousItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMovePreviousItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMovePreviousItem.Text = "Mover anterior";
            // 
            // bindingNavigatorSeparator
            // 
            this.bindingNavigatorSeparator.Name = "bindingNavigatorSeparator";
            this.bindingNavigatorSeparator.Size = new System.Drawing.Size(6, 25);
            // 
            // bindingNavigatorPositionItem
            // 
            this.bindingNavigatorPositionItem.AccessibleName = "Posición";
            this.bindingNavigatorPositionItem.AutoSize = false;
            this.bindingNavigatorPositionItem.Name = "bindingNavigatorPositionItem";
            this.bindingNavigatorPositionItem.Size = new System.Drawing.Size(58, 23);
            this.bindingNavigatorPositionItem.Text = "0";
            this.bindingNavigatorPositionItem.ToolTipText = "Posición actual";
            // 
            // bindingNavigatorSeparator1
            // 
            this.bindingNavigatorSeparator1.Name = "bindingNavigatorSeparator1";
            this.bindingNavigatorSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // bindingNavigatorMoveNextItem
            // 
            this.bindingNavigatorMoveNextItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMoveNextItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveNextItem.Image")));
            this.bindingNavigatorMoveNextItem.Name = "bindingNavigatorMoveNextItem";
            this.bindingNavigatorMoveNextItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMoveNextItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMoveNextItem.Text = "Mover siguiente";
            // 
            // bindingNavigatorMoveLastItem
            // 
            this.bindingNavigatorMoveLastItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMoveLastItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveLastItem.Image")));
            this.bindingNavigatorMoveLastItem.Name = "bindingNavigatorMoveLastItem";
            this.bindingNavigatorMoveLastItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMoveLastItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMoveLastItem.Text = "Mover último";
            // 
            // bindingNavigatorSeparator2
            // 
            this.bindingNavigatorSeparator2.Name = "bindingNavigatorSeparator2";
            this.bindingNavigatorSeparator2.Size = new System.Drawing.Size(6, 25);
            // 
            // bnAddNewConcept
            // 
            this.bnAddNewConcept.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bnAddNewConcept.Image = ((System.Drawing.Image)(resources.GetObject("bnAddNewConcept.Image")));
            this.bnAddNewConcept.Name = "bnAddNewConcept";
            this.bnAddNewConcept.RightToLeftAutoMirrorImage = true;
            this.bnAddNewConcept.Size = new System.Drawing.Size(23, 22);
            this.bnAddNewConcept.Text = "Agregar nuevo";
            this.bnAddNewConcept.Click += new System.EventHandler(this.bnAddNewConcept_Click);
            // 
            // bnMonthlyFeeDeleteItem
            // 
            this.bnMonthlyFeeDeleteItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bnMonthlyFeeDeleteItem.Image = ((System.Drawing.Image)(resources.GetObject("bnMonthlyFeeDeleteItem.Image")));
            this.bnMonthlyFeeDeleteItem.Name = "bnMonthlyFeeDeleteItem";
            this.bnMonthlyFeeDeleteItem.RightToLeftAutoMirrorImage = true;
            this.bnMonthlyFeeDeleteItem.Size = new System.Drawing.Size(23, 22);
            this.bnMonthlyFeeDeleteItem.Text = "Eliminar";
            this.bnMonthlyFeeDeleteItem.Click += new System.EventHandler(this.bnConcepkDeleteItem_Click);
            // 
            // FRVAD
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(942, 514);
            this.Controls.Add(this.tbComment);
            this.Controls.Add(this.tbCostValue);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnRegisterAdditionalVal);
            this.Controls.Add(this.tbAdditionalValue);
            this.Controls.Add(this.otValueData);
            this.Controls.Add(this.tbProjectName);
            this.Controls.Add(this.tbCustomerName);
            this.Controls.Add(this.tbCustomerId);
            this.Controls.Add(this.ocIdentificationType);
            this.Controls.Add(this.otProjectBasicData);
            this.Controls.Add(this.ugMonthlyFee);
            this.Controls.Add(this.bnNavegador);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "FRVAD";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FRVAD - Forma de Registro de Valor Adicional";
            this.Load += new System.EventHandler(this.FRVAD_Load);
            ((System.ComponentModel.ISupportInitialize)(this.ocIdentificationType)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ugMonthlyFee)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bsConceptos)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bnNavegador)).EndInit();
            this.bnNavegador.ResumeLayout(false);
            this.bnNavegador.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }



        #endregion

        private OpenSystems.Windows.Controls.OpenButton btnCancel;
        private OpenSystems.Windows.Controls.OpenButton btnRegisterAdditionalVal;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbAdditionalValue;
        private OpenSystems.Windows.Controls.OpenTitle otValueData;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbProjectName;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbCustomerName;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbCustomerId;
        private OpenSystems.Windows.Controls.OpenCombo ocIdentificationType;
        private OpenSystems.Windows.Controls.OpenTitle otProjectBasicData;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbCostValue;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbComment;
        private Infragistics.Win.UltraWinGrid.UltraGrid ugMonthlyFee;
        private System.Windows.Forms.BindingNavigator bnNavegador;
        private System.Windows.Forms.ToolStripLabel bindingNavigatorCountItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveFirstItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMovePreviousItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator;
        private System.Windows.Forms.ToolStripTextBox bindingNavigatorPositionItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator1;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveNextItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveLastItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator2;
        private System.Windows.Forms.ToolStripButton bnAddNewConcept;
        private System.Windows.Forms.ToolStripButton bnMonthlyFeeDeleteItem;
        private System.Windows.Forms.BindingSource bsConceptos;
    }
}