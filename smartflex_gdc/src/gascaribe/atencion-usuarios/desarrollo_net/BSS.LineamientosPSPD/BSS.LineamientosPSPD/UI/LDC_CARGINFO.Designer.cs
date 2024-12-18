namespace BSS.LineamientosPSPD
{
    partial class LDC_CARGINFO
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
            this.bCancelar = new System.Windows.Forms.Button();
            this.dataGridView3 = new System.Windows.Forms.DataGridView();
            this.bBuscar = new System.Windows.Forms.Button();
            this.cOrigenCargue = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.cTipoCargue = new System.Windows.Forms.ComboBox();
            this.label6 = new System.Windows.Forms.Label();
            this.cDocSoporte = new System.Windows.Forms.ComboBox();
            this.label7 = new System.Windows.Forms.Label();
            this.tObsCargue = new System.Windows.Forms.TextBox();
            this.chCargueIndiv = new System.Windows.Forms.CheckBox();
            this.tContrato = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.tRuta = new System.Windows.Forms.TextBox();
            this.tNombreArch = new System.Windows.Forms.TextBox();
            this.bProcesar = new System.Windows.Forms.Button();
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.tExaminar = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView3)).BeginInit();
            this.SuspendLayout();
            // 
            // bCancelar
            // 
            this.bCancelar.BackColor = System.Drawing.Color.White;
            this.bCancelar.Location = new System.Drawing.Point(825, 103);
            this.bCancelar.Name = "bCancelar";
            this.bCancelar.Size = new System.Drawing.Size(83, 25);
            this.bCancelar.TabIndex = 10;
            this.bCancelar.Text = "Cancelar";
            this.bCancelar.UseVisualStyleBackColor = false;
            this.bCancelar.Click += new System.EventHandler(this.bCancelar_Click);
            // 
            // dataGridView3
            // 
            this.dataGridView3.AllowUserToAddRows = false;
            this.dataGridView3.AllowUserToDeleteRows = false;
            this.dataGridView3.AllowUserToResizeColumns = false;
            this.dataGridView3.AllowUserToResizeRows = false;
            this.dataGridView3.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.dataGridView3.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dataGridView3.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView3.Location = new System.Drawing.Point(9, 134);
            this.dataGridView3.MultiSelect = false;
            this.dataGridView3.Name = "dataGridView3";
            this.dataGridView3.RowHeadersVisible = false;
            this.dataGridView3.Size = new System.Drawing.Size(899, 323);
            this.dataGridView3.TabIndex = 16;
            this.dataGridView3.ColumnStateChanged += new System.Windows.Forms.DataGridViewColumnStateChangedEventHandler(this.dataGridView3_ColumnStateChanged);
            this.dataGridView3.CausesValidationChanged += new System.EventHandler(this.dataGridView3_CausesValidationChanged);
            // 
            // bBuscar
            // 
            this.bBuscar.BackColor = System.Drawing.Color.White;
            this.bBuscar.Location = new System.Drawing.Point(29, 103);
            this.bBuscar.Name = "bBuscar";
            this.bBuscar.Size = new System.Drawing.Size(83, 25);
            this.bBuscar.TabIndex = 18;
            this.bBuscar.Text = "Buscar";
            this.bBuscar.UseVisualStyleBackColor = false;
            this.bBuscar.Click += new System.EventHandler(this.bBuscar_Click);
            // 
            // cOrigenCargue
            // 
            this.cOrigenCargue.FormattingEnabled = true;
            this.cOrigenCargue.Location = new System.Drawing.Point(166, 28);
            this.cOrigenCargue.Name = "cOrigenCargue";
            this.cOrigenCargue.Size = new System.Drawing.Size(298, 21);
            this.cOrigenCargue.TabIndex = 24;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(12, 9);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(100, 13);
            this.label4.TabIndex = 22;
            this.label4.Text = "Tipo de Cargue:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(12, 31);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(117, 13);
            this.label5.TabIndex = 22;
            this.label5.Text = "Origen del Cargue:";
            // 
            // cTipoCargue
            // 
            this.cTipoCargue.FormattingEnabled = true;
            this.cTipoCargue.Location = new System.Drawing.Point(166, 6);
            this.cTipoCargue.Name = "cTipoCargue";
            this.cTipoCargue.Size = new System.Drawing.Size(298, 21);
            this.cTipoCargue.TabIndex = 24;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(12, 53);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(126, 13);
            this.label6.TabIndex = 22;
            this.label6.Text = "Documento Soporte:";
            // 
            // cDocSoporte
            // 
            this.cDocSoporte.FormattingEnabled = true;
            this.cDocSoporte.Location = new System.Drawing.Point(166, 50);
            this.cDocSoporte.Name = "cDocSoporte";
            this.cDocSoporte.Size = new System.Drawing.Size(298, 21);
            this.cDocSoporte.TabIndex = 24;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(12, 75);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(147, 13);
            this.label7.TabIndex = 22;
            this.label7.Text = "Observación del cargue:";
            // 
            // tObsCargue
            // 
            this.tObsCargue.Location = new System.Drawing.Point(166, 72);
            this.tObsCargue.Name = "tObsCargue";
            this.tObsCargue.Size = new System.Drawing.Size(298, 21);
            this.tObsCargue.TabIndex = 5;
            // 
            // chCargueIndiv
            // 
            this.chCargueIndiv.AutoSize = true;
            this.chCargueIndiv.Location = new System.Drawing.Point(617, 74);
            this.chCargueIndiv.Name = "chCargueIndiv";
            this.chCargueIndiv.Size = new System.Drawing.Size(126, 17);
            this.chCargueIndiv.TabIndex = 12;
            this.chCargueIndiv.Text = "Cargue individual";
            this.chCargueIndiv.UseVisualStyleBackColor = true;
            this.chCargueIndiv.CheckedChanged += new System.EventHandler(this.chCargueIndiv_CheckedChanged);
            // 
            // tContrato
            // 
            this.tContrato.Enabled = false;
            this.tContrato.Location = new System.Drawing.Point(617, 6);
            this.tContrato.Name = "tContrato";
            this.tContrato.Size = new System.Drawing.Size(180, 21);
            this.tContrato.TabIndex = 5;
            this.tContrato.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.tContrato_KeyPress);
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(490, 9);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(62, 13);
            this.label8.TabIndex = 22;
            this.label8.Text = "Contrato:";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(490, 31);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(109, 13);
            this.label9.TabIndex = 22;
            this.label9.Text = "Ruta del  archivo:";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(490, 53);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(124, 13);
            this.label10.TabIndex = 22;
            this.label10.Text = "Nombre del archivo:";
            // 
            // tRuta
            // 
            this.tRuta.Location = new System.Drawing.Point(617, 28);
            this.tRuta.Name = "tRuta";
            this.tRuta.Size = new System.Drawing.Size(261, 21);
            this.tRuta.TabIndex = 25;
            // 
            // tNombreArch
            // 
            this.tNombreArch.Location = new System.Drawing.Point(617, 50);
            this.tNombreArch.Name = "tNombreArch";
            this.tNombreArch.Size = new System.Drawing.Size(291, 21);
            this.tNombreArch.TabIndex = 25;
            // 
            // bProcesar
            // 
            this.bProcesar.BackColor = System.Drawing.Color.White;
            this.bProcesar.Enabled = false;
            this.bProcesar.Location = new System.Drawing.Point(118, 103);
            this.bProcesar.Name = "bProcesar";
            this.bProcesar.Size = new System.Drawing.Size(83, 25);
            this.bProcesar.TabIndex = 1;
            this.bProcesar.Text = "Procesar";
            this.bProcesar.UseVisualStyleBackColor = false;
            this.bProcesar.Click += new System.EventHandler(this.bProcesar_Click);
            // 
            // toolStrip1
            // 
            this.toolStrip1.AutoSize = false;
            this.toolStrip1.Dock = System.Windows.Forms.DockStyle.None;
            this.toolStrip1.Location = new System.Drawing.Point(15, 100);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Size = new System.Drawing.Size(896, 31);
            this.toolStrip1.TabIndex = 26;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // tExaminar
            // 
            this.tExaminar.Location = new System.Drawing.Point(878, 28);
            this.tExaminar.Name = "tExaminar";
            this.tExaminar.Size = new System.Drawing.Size(30, 21);
            this.tExaminar.TabIndex = 27;
            this.tExaminar.Text = "...";
            this.tExaminar.UseVisualStyleBackColor = true;
            this.tExaminar.Click += new System.EventHandler(this.tExaminar_Click);
            // 
            // LDC_CARGINFO
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.LightSteelBlue;
            this.ClientSize = new System.Drawing.Size(923, 469);
            this.Controls.Add(this.tExaminar);
            this.Controls.Add(this.bBuscar);
            this.Controls.Add(this.tNombreArch);
            this.Controls.Add(this.tRuta);
            this.Controls.Add(this.cTipoCargue);
            this.Controls.Add(this.cDocSoporte);
            this.Controls.Add(this.cOrigenCargue);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label10);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.dataGridView3);
            this.Controls.Add(this.chCargueIndiv);
            this.Controls.Add(this.bCancelar);
            this.Controls.Add(this.tObsCargue);
            this.Controls.Add(this.tContrato);
            this.Controls.Add(this.bProcesar);
            this.Controls.Add(this.toolStrip1);
            this.Name = "LDC_CARGINFO";
            this.Text = "Registro de Cargue";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView3)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button bCancelar;
        private System.Windows.Forms.DataGridView dataGridView3;
        private System.Windows.Forms.Button bBuscar;
        private System.Windows.Forms.ComboBox cOrigenCargue;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.ComboBox cTipoCargue;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.ComboBox cDocSoporte;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox tObsCargue;
        private System.Windows.Forms.CheckBox chCargueIndiv;
        private System.Windows.Forms.TextBox tContrato;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox tRuta;
        private System.Windows.Forms.TextBox tNombreArch;
        private System.Windows.Forms.Button bProcesar;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.Button tExaminar;
    }
}

