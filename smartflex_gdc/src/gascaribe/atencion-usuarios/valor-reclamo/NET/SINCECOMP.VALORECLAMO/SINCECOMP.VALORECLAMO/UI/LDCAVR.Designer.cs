namespace SINCECOMP.VALORECLAMO.UI
{
    partial class LDCAVR
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
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("LDCAVRReclamos", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn1 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("selection");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn2 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("solicitud");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn3 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("cuenta");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn4 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("factura");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn5 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("cargos", -1, null, 0, Infragistics.Win.UltraWinGrid.SortIndicator.Ascending, false);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn6 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("contrato");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn7 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("causal");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn8 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("tiposolicitud");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn9 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("fecharegitro");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn10 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("puntoatencion");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn11 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("funcionario");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn12 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("valorfactura");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn13 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("valorreclamo");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn14 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("reclamosid");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn15 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("reclamooriginal");
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
            this.PDatosBusqueda = new System.Windows.Forms.Panel();
            this.lblObservacion = new System.Windows.Forms.Label();
            this.txtObservacion = new System.Windows.Forms.TextBox();
            this.lblSolicitud = new System.Windows.Forms.Label();
            this.txtSolicitud = new System.Windows.Forms.TextBox();
            this.lblContrato = new System.Windows.Forms.Label();
            this.TxtContrato = new System.Windows.Forms.TextBox();
            this.PReclamo = new System.Windows.Forms.Panel();
            this.OgReclamos = new Infragistics.Win.UltraWinGrid.UltraGrid();
            this.BdsReclamos = new System.Windows.Forms.BindingSource(this.components);
            this.PControles = new System.Windows.Forms.Panel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.BtnBuscar = new OpenSystems.Windows.Controls.OpenButton();
            this.panel1 = new System.Windows.Forms.Panel();
            this.BtnProcesar = new OpenSystems.Windows.Controls.OpenButton();
            this.PCancelar = new System.Windows.Forms.Panel();
            this.BtnLimpiar = new OpenSystems.Windows.Controls.OpenButton();
            this.PProcesar = new System.Windows.Forms.Panel();
            this.BtnCancelar = new OpenSystems.Windows.Controls.OpenButton();
            this.PDatosBusqueda.SuspendLayout();
            this.PReclamo.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.OgReclamos)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.BdsReclamos)).BeginInit();
            this.PControles.SuspendLayout();
            this.panel2.SuspendLayout();
            this.panel1.SuspendLayout();
            this.PCancelar.SuspendLayout();
            this.PProcesar.SuspendLayout();
            this.SuspendLayout();
            // 
            // PDatosBusqueda
            // 
            this.PDatosBusqueda.AutoScroll = true;
            this.PDatosBusqueda.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.PDatosBusqueda.Controls.Add(this.lblObservacion);
            this.PDatosBusqueda.Controls.Add(this.txtObservacion);
            this.PDatosBusqueda.Controls.Add(this.lblSolicitud);
            this.PDatosBusqueda.Controls.Add(this.txtSolicitud);
            this.PDatosBusqueda.Controls.Add(this.lblContrato);
            this.PDatosBusqueda.Controls.Add(this.TxtContrato);
            this.PDatosBusqueda.Dock = System.Windows.Forms.DockStyle.Top;
            this.PDatosBusqueda.Location = new System.Drawing.Point(0, 0);
            this.PDatosBusqueda.Name = "PDatosBusqueda";
            this.PDatosBusqueda.Size = new System.Drawing.Size(850, 99);
            this.PDatosBusqueda.TabIndex = 3;
            // 
            // lblObservacion
            // 
            this.lblObservacion.AutoSize = true;
            this.lblObservacion.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblObservacion.Location = new System.Drawing.Point(17, 43);
            this.lblObservacion.Name = "lblObservacion";
            this.lblObservacion.Size = new System.Drawing.Size(78, 13);
            this.lblObservacion.TabIndex = 50;
            this.lblObservacion.Text = "Observacion";
            // 
            // txtObservacion
            // 
            this.txtObservacion.Location = new System.Drawing.Point(107, 39);
            this.txtObservacion.Multiline = true;
            this.txtObservacion.Name = "txtObservacion";
            this.txtObservacion.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtObservacion.Size = new System.Drawing.Size(728, 51);
            this.txtObservacion.TabIndex = 49;
            // 
            // lblSolicitud
            // 
            this.lblSolicitud.AutoSize = true;
            this.lblSolicitud.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblSolicitud.Location = new System.Drawing.Point(537, 12);
            this.lblSolicitud.Name = "lblSolicitud";
            this.lblSolicitud.Size = new System.Drawing.Size(56, 13);
            this.lblSolicitud.TabIndex = 48;
            this.lblSolicitud.Text = "Solicitud";
            // 
            // txtSolicitud
            // 
            this.txtSolicitud.Location = new System.Drawing.Point(627, 12);
            this.txtSolicitud.Name = "txtSolicitud";
            this.txtSolicitud.Size = new System.Drawing.Size(208, 21);
            this.txtSolicitud.TabIndex = 1;
            this.txtSolicitud.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // lblContrato
            // 
            this.lblContrato.AutoSize = true;
            this.lblContrato.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblContrato.Location = new System.Drawing.Point(17, 12);
            this.lblContrato.Name = "lblContrato";
            this.lblContrato.Size = new System.Drawing.Size(55, 13);
            this.lblContrato.TabIndex = 46;
            this.lblContrato.Text = "Contrato";
            // 
            // TxtContrato
            // 
            this.TxtContrato.Location = new System.Drawing.Point(107, 12);
            this.TxtContrato.Name = "TxtContrato";
            this.TxtContrato.Size = new System.Drawing.Size(208, 21);
            this.TxtContrato.TabIndex = 0;
            this.TxtContrato.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // PReclamo
            // 
            this.PReclamo.AutoScroll = true;
            this.PReclamo.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.PReclamo.Controls.Add(this.OgReclamos);
            this.PReclamo.Dock = System.Windows.Forms.DockStyle.Top;
            this.PReclamo.Location = new System.Drawing.Point(0, 99);
            this.PReclamo.Name = "PReclamo";
            this.PReclamo.Size = new System.Drawing.Size(850, 159);
            this.PReclamo.TabIndex = 4;
            // 
            // OgReclamos
            // 
            this.OgReclamos.DataSource = this.BdsReclamos;
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            appearance1.BorderColor = System.Drawing.Color.White;
            this.OgReclamos.DisplayLayout.Appearance = appearance1;
            this.OgReclamos.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ExtendLastColumn;
            ultraGridColumn1.Header.VisiblePosition = 0;
            ultraGridColumn2.Header.VisiblePosition = 1;
            ultraGridColumn3.Header.VisiblePosition = 2;
            ultraGridColumn4.Header.VisiblePosition = 3;
            ultraGridColumn5.Header.VisiblePosition = 4;
            ultraGridColumn6.Header.VisiblePosition = 5;
            ultraGridColumn7.Header.VisiblePosition = 6;
            ultraGridColumn8.Header.VisiblePosition = 7;
            ultraGridColumn9.Header.VisiblePosition = 8;
            ultraGridColumn10.Header.VisiblePosition = 9;
            ultraGridColumn11.Header.VisiblePosition = 10;
            ultraGridColumn12.Header.VisiblePosition = 11;
            ultraGridColumn13.Header.VisiblePosition = 12;
            ultraGridColumn14.Header.VisiblePosition = 13;
            ultraGridColumn15.Header.VisiblePosition = 14;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn1,
            ultraGridColumn2,
            ultraGridColumn3,
            ultraGridColumn4,
            ultraGridColumn5,
            ultraGridColumn6,
            ultraGridColumn7,
            ultraGridColumn8,
            ultraGridColumn9,
            ultraGridColumn10,
            ultraGridColumn11,
            ultraGridColumn12,
            ultraGridColumn13,
            ultraGridColumn14,
            ultraGridColumn15});
            this.OgReclamos.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.OgReclamos.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.OgReclamos.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance2.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance2.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance2.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance2.BorderColor = System.Drawing.SystemColors.Window;
            this.OgReclamos.DisplayLayout.GroupByBox.Appearance = appearance2;
            appearance3.ForeColor = System.Drawing.SystemColors.GrayText;
            this.OgReclamos.DisplayLayout.GroupByBox.BandLabelAppearance = appearance3;
            this.OgReclamos.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.OgReclamos.DisplayLayout.GroupByBox.Hidden = true;
            appearance4.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance4.BackColor2 = System.Drawing.SystemColors.Control;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance4.ForeColor = System.Drawing.SystemColors.GrayText;
            this.OgReclamos.DisplayLayout.GroupByBox.PromptAppearance = appearance4;
            this.OgReclamos.DisplayLayout.MaxColScrollRegions = 1;
            this.OgReclamos.DisplayLayout.MaxRowScrollRegions = 1;
            appearance5.BackColor = System.Drawing.SystemColors.Window;
            appearance5.ForeColor = System.Drawing.SystemColors.ControlText;
            this.OgReclamos.DisplayLayout.Override.ActiveCellAppearance = appearance5;
            appearance6.BackColor = System.Drawing.SystemColors.Highlight;
            appearance6.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.OgReclamos.DisplayLayout.Override.ActiveRowAppearance = appearance6;
            this.OgReclamos.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.Yes;
            this.OgReclamos.DisplayLayout.Override.AllowRowFiltering = Infragistics.Win.DefaultableBoolean.True;
            this.OgReclamos.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.OgReclamos.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance7.BackColor = System.Drawing.SystemColors.Window;
            this.OgReclamos.DisplayLayout.Override.CardAreaAppearance = appearance7;
            appearance8.BorderColor = System.Drawing.Color.Silver;
            appearance8.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.OgReclamos.DisplayLayout.Override.CellAppearance = appearance8;
            this.OgReclamos.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.OgReclamos.DisplayLayout.Override.CellPadding = 0;
            appearance9.BackColor = System.Drawing.SystemColors.Control;
            appearance9.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance9.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance9.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance9.BorderColor = System.Drawing.SystemColors.Window;
            this.OgReclamos.DisplayLayout.Override.GroupByRowAppearance = appearance9;
            appearance10.TextHAlign = Infragistics.Win.HAlign.Left;
            this.OgReclamos.DisplayLayout.Override.HeaderAppearance = appearance10;
            this.OgReclamos.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.OgReclamos.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance11.BackColor = System.Drawing.SystemColors.Window;
            appearance11.BorderColor = System.Drawing.Color.Silver;
            this.OgReclamos.DisplayLayout.Override.RowAppearance = appearance11;
            this.OgReclamos.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance12.BackColor = System.Drawing.SystemColors.ControlLight;
            this.OgReclamos.DisplayLayout.Override.TemplateAddRowAppearance = appearance12;
            this.OgReclamos.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.OgReclamos.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.OgReclamos.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.OgReclamos.Dock = System.Windows.Forms.DockStyle.Fill;
            this.OgReclamos.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.OgReclamos.Location = new System.Drawing.Point(0, 0);
            this.OgReclamos.Name = "OgReclamos";
            this.OgReclamos.Size = new System.Drawing.Size(850, 159);
            this.OgReclamos.TabIndex = 71;
            this.OgReclamos.Text = "ultraGrid1";
            this.OgReclamos.AfterCellUpdate += new Infragistics.Win.UltraWinGrid.CellEventHandler(this.OgReclamos_AfterCellUpdate);
            // 
            // BdsReclamos
            // 
            this.BdsReclamos.DataSource = typeof(SINCECOMP.VALORECLAMO.Entities.LDCAVRReclamos);
            // 
            // PControles
            // 
            this.PControles.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.PControles.Controls.Add(this.panel2);
            this.PControles.Controls.Add(this.panel1);
            this.PControles.Controls.Add(this.PCancelar);
            this.PControles.Controls.Add(this.PProcesar);
            this.PControles.Dock = System.Windows.Forms.DockStyle.Fill;
            this.PControles.Location = new System.Drawing.Point(0, 258);
            this.PControles.Name = "PControles";
            this.PControles.Size = new System.Drawing.Size(850, 36);
            this.PControles.TabIndex = 5;
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.BtnBuscar);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Right;
            this.panel2.Location = new System.Drawing.Point(497, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(86, 36);
            this.panel2.TabIndex = 3;
            // 
            // BtnBuscar
            // 
            appearance13.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance13.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.BtnBuscar.Appearance = appearance13;
            this.BtnBuscar.Location = new System.Drawing.Point(5, 6);
            this.BtnBuscar.Name = "BtnBuscar";
            this.BtnBuscar.Size = new System.Drawing.Size(75, 23);
            this.BtnBuscar.TabIndex = 34;
            this.BtnBuscar.Text = "&Buscar";
            this.BtnBuscar.Click += new System.EventHandler(this.BtnBuscar_Click);
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.BtnProcesar);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Right;
            this.panel1.Location = new System.Drawing.Point(583, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(91, 36);
            this.panel1.TabIndex = 2;
            // 
            // BtnProcesar
            // 
            appearance14.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance14.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.BtnProcesar.Appearance = appearance14;
            this.BtnProcesar.Location = new System.Drawing.Point(6, 6);
            this.BtnProcesar.Name = "BtnProcesar";
            this.BtnProcesar.Size = new System.Drawing.Size(75, 23);
            this.BtnProcesar.TabIndex = 34;
            this.BtnProcesar.Text = "&Procesar";
            this.BtnProcesar.Click += new System.EventHandler(this.BtnProcesar_Click);
            // 
            // PCancelar
            // 
            this.PCancelar.Controls.Add(this.BtnLimpiar);
            this.PCancelar.Dock = System.Windows.Forms.DockStyle.Right;
            this.PCancelar.Location = new System.Drawing.Point(674, 0);
            this.PCancelar.Name = "PCancelar";
            this.PCancelar.Size = new System.Drawing.Size(89, 36);
            this.PCancelar.TabIndex = 1;
            // 
            // BtnLimpiar
            // 
            appearance15.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance15.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.BtnLimpiar.Appearance = appearance15;
            this.BtnLimpiar.Location = new System.Drawing.Point(6, 6);
            this.BtnLimpiar.Name = "BtnLimpiar";
            this.BtnLimpiar.Size = new System.Drawing.Size(75, 23);
            this.BtnLimpiar.TabIndex = 34;
            this.BtnLimpiar.Text = "&Limpiar";
            this.BtnLimpiar.Click += new System.EventHandler(this.BtnLimpiar_Click);
            // 
            // PProcesar
            // 
            this.PProcesar.Controls.Add(this.BtnCancelar);
            this.PProcesar.Dock = System.Windows.Forms.DockStyle.Right;
            this.PProcesar.Location = new System.Drawing.Point(763, 0);
            this.PProcesar.Name = "PProcesar";
            this.PProcesar.Size = new System.Drawing.Size(87, 36);
            this.PProcesar.TabIndex = 0;
            // 
            // BtnCancelar
            // 
            appearance16.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance16.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.BtnCancelar.Appearance = appearance16;
            this.BtnCancelar.Location = new System.Drawing.Point(6, 6);
            this.BtnCancelar.Name = "BtnCancelar";
            this.BtnCancelar.Size = new System.Drawing.Size(75, 23);
            this.BtnCancelar.TabIndex = 34;
            this.BtnCancelar.Text = "&Cancelar";
            this.BtnCancelar.Click += new System.EventHandler(this.BtnCancelar_Click);
            // 
            // LDCAVR
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(850, 294);
            this.Controls.Add(this.PControles);
            this.Controls.Add(this.PReclamo);
            this.Controls.Add(this.PDatosBusqueda);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(892, 408);
            this.Name = "LDCAVR";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "LDCAVR - Aplicacion Valor en Reclamo";
            this.Load += new System.EventHandler(this.LDCAVR_Load);
            this.PDatosBusqueda.ResumeLayout(false);
            this.PDatosBusqueda.PerformLayout();
            this.PReclamo.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.OgReclamos)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.BdsReclamos)).EndInit();
            this.PControles.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.PCancelar.ResumeLayout(false);
            this.PProcesar.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel PDatosBusqueda;
        private System.Windows.Forms.Label lblObservacion;
        private System.Windows.Forms.TextBox txtObservacion;
        private System.Windows.Forms.Label lblSolicitud;
        private System.Windows.Forms.TextBox txtSolicitud;
        private System.Windows.Forms.Label lblContrato;
        private System.Windows.Forms.TextBox TxtContrato;
        private System.Windows.Forms.Panel PReclamo;
        private System.Windows.Forms.Panel PControles;
        private System.Windows.Forms.Panel PCancelar;
        private OpenSystems.Windows.Controls.OpenButton BtnLimpiar;
        private System.Windows.Forms.Panel PProcesar;
        private OpenSystems.Windows.Controls.OpenButton BtnCancelar;
        private System.Windows.Forms.BindingSource BdsReclamos;
        private System.Windows.Forms.Panel panel2;
        private OpenSystems.Windows.Controls.OpenButton BtnBuscar;
        private System.Windows.Forms.Panel panel1;
        private OpenSystems.Windows.Controls.OpenButton BtnProcesar;
        private Infragistics.Win.UltraWinGrid.UltraGrid OgReclamos;

    }
}