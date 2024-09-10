namespace CONTROLDESARROLLO.UI
{
    partial class crearfuncion
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
            this.PnlBotones = new System.Windows.Forms.Panel();
            this.BtnProcesar = new System.Windows.Forms.Button();
            this.PnlEsctructura = new System.Windows.Forms.Panel();
            this.LblTipo = new System.Windows.Forms.Label();
            this.CbxTipo = new System.Windows.Forms.ComboBox();
            this.LblNombre = new System.Windows.Forms.Label();
            this.TbxNombre = new System.Windows.Forms.TextBox();
            this.PnlLogica = new System.Windows.Forms.Panel();
            this.DgvVariables = new System.Windows.Forms.DataGridView();
            this.TxbLogica = new System.Windows.Forms.TextBox();
            this.LblEsquema = new System.Windows.Forms.Label();
            this.CbxEsquema = new System.Windows.Forms.ComboBox();
            this.PnlBotones.SuspendLayout();
            this.PnlEsctructura.SuspendLayout();
            this.PnlLogica.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.DgvVariables)).BeginInit();
            this.SuspendLayout();
            // 
            // PnlBotones
            // 
            this.PnlBotones.Controls.Add(this.BtnProcesar);
            this.PnlBotones.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.PnlBotones.Location = new System.Drawing.Point(0, 725);
            this.PnlBotones.Name = "PnlBotones";
            this.PnlBotones.Size = new System.Drawing.Size(1197, 58);
            this.PnlBotones.TabIndex = 4;
            // 
            // BtnProcesar
            // 
            this.BtnProcesar.Location = new System.Drawing.Point(1050, 7);
            this.BtnProcesar.Name = "BtnProcesar";
            this.BtnProcesar.Size = new System.Drawing.Size(141, 43);
            this.BtnProcesar.TabIndex = 0;
            this.BtnProcesar.Text = "Procesar";
            this.BtnProcesar.UseVisualStyleBackColor = true;
            this.BtnProcesar.Click += new System.EventHandler(this.BtnProcesar_Click);
            // 
            // PnlEsctructura
            // 
            this.PnlEsctructura.Controls.Add(this.LblEsquema);
            this.PnlEsctructura.Controls.Add(this.CbxEsquema);
            this.PnlEsctructura.Controls.Add(this.LblTipo);
            this.PnlEsctructura.Controls.Add(this.CbxTipo);
            this.PnlEsctructura.Controls.Add(this.LblNombre);
            this.PnlEsctructura.Controls.Add(this.TbxNombre);
            this.PnlEsctructura.Dock = System.Windows.Forms.DockStyle.Top;
            this.PnlEsctructura.Location = new System.Drawing.Point(0, 0);
            this.PnlEsctructura.Name = "PnlEsctructura";
            this.PnlEsctructura.Size = new System.Drawing.Size(1197, 130);
            this.PnlEsctructura.TabIndex = 7;
            // 
            // LblTipo
            // 
            this.LblTipo.AutoSize = true;
            this.LblTipo.Location = new System.Drawing.Point(11, 81);
            this.LblTipo.Name = "LblTipo";
            this.LblTipo.Size = new System.Drawing.Size(45, 20);
            this.LblTipo.TabIndex = 7;
            this.LblTipo.Text = "Tipo";
            // 
            // CbxTipo
            // 
            this.CbxTipo.FormattingEnabled = true;
            this.CbxTipo.Location = new System.Drawing.Point(106, 81);
            this.CbxTipo.Name = "CbxTipo";
            this.CbxTipo.Size = new System.Drawing.Size(277, 28);
            this.CbxTipo.TabIndex = 6;
            // 
            // LblNombre
            // 
            this.LblNombre.AutoSize = true;
            this.LblNombre.Location = new System.Drawing.Point(11, 51);
            this.LblNombre.Name = "LblNombre";
            this.LblNombre.Size = new System.Drawing.Size(77, 20);
            this.LblNombre.TabIndex = 5;
            this.LblNombre.Text = "Nombre";
            // 
            // TbxNombre
            // 
            this.TbxNombre.Location = new System.Drawing.Point(106, 51);
            this.TbxNombre.Name = "TbxNombre";
            this.TbxNombre.Size = new System.Drawing.Size(529, 28);
            this.TbxNombre.TabIndex = 4;
            // 
            // PnlLogica
            // 
            this.PnlLogica.Controls.Add(this.DgvVariables);
            this.PnlLogica.Controls.Add(this.TxbLogica);
            this.PnlLogica.Dock = System.Windows.Forms.DockStyle.Fill;
            this.PnlLogica.Location = new System.Drawing.Point(0, 130);
            this.PnlLogica.Name = "PnlLogica";
            this.PnlLogica.Size = new System.Drawing.Size(1197, 595);
            this.PnlLogica.TabIndex = 8;
            // 
            // DgvVariables
            // 
            this.DgvVariables.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DgvVariables.Dock = System.Windows.Forms.DockStyle.Fill;
            this.DgvVariables.Location = new System.Drawing.Point(0, 0);
            this.DgvVariables.Name = "DgvVariables";
            this.DgvVariables.RowTemplate.Height = 28;
            this.DgvVariables.Size = new System.Drawing.Size(1197, 179);
            this.DgvVariables.TabIndex = 8;
            // 
            // TxbLogica
            // 
            this.TxbLogica.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.TxbLogica.Location = new System.Drawing.Point(0, 179);
            this.TxbLogica.Multiline = true;
            this.TxbLogica.Name = "TxbLogica";
            this.TxbLogica.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.TxbLogica.Size = new System.Drawing.Size(1197, 416);
            this.TxbLogica.TabIndex = 7;
            // 
            // LblEsquema
            // 
            this.LblEsquema.AutoSize = true;
            this.LblEsquema.Location = new System.Drawing.Point(11, 20);
            this.LblEsquema.Name = "LblEsquema";
            this.LblEsquema.Size = new System.Drawing.Size(88, 20);
            this.LblEsquema.TabIndex = 9;
            this.LblEsquema.Text = "Esquema";
            // 
            // CbxEsquema
            // 
            this.CbxEsquema.FormattingEnabled = true;
            this.CbxEsquema.Location = new System.Drawing.Point(106, 20);
            this.CbxEsquema.Name = "CbxEsquema";
            this.CbxEsquema.Size = new System.Drawing.Size(277, 28);
            this.CbxEsquema.TabIndex = 8;
            // 
            // crearfuncion
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(11F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(1197, 783);
            this.Controls.Add(this.PnlLogica);
            this.Controls.Add(this.PnlEsctructura);
            this.Controls.Add(this.PnlBotones);
            this.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.Name = "crearfuncion";
            this.Text = "Crear funcion";
            this.Load += new System.EventHandler(this.crearfuncion_Load);
            this.PnlBotones.ResumeLayout(false);
            this.PnlEsctructura.ResumeLayout(false);
            this.PnlEsctructura.PerformLayout();
            this.PnlLogica.ResumeLayout(false);
            this.PnlLogica.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.DgvVariables)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel PnlBotones;
        private System.Windows.Forms.Button BtnProcesar;
        private System.Windows.Forms.Panel PnlEsctructura;
        private System.Windows.Forms.Label LblTipo;
        private System.Windows.Forms.ComboBox CbxTipo;
        private System.Windows.Forms.Label LblNombre;
        private System.Windows.Forms.TextBox TbxNombre;
        private System.Windows.Forms.Panel PnlLogica;
        private System.Windows.Forms.DataGridView DgvVariables;
        private System.Windows.Forms.TextBox TxbLogica;
        private System.Windows.Forms.Label LblEsquema;
        private System.Windows.Forms.ComboBox CbxEsquema;
    }
}