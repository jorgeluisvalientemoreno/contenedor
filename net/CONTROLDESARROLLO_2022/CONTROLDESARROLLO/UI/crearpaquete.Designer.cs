namespace CONTROLDESARROLLO.UI
{
    partial class crearpaquete
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
            this.PnlEsctructura = new System.Windows.Forms.Panel();
            this.LblEsquema = new System.Windows.Forms.Label();
            this.CbxEsquema = new System.Windows.Forms.ComboBox();
            this.LblNombre = new System.Windows.Forms.Label();
            this.TbxNombre = new System.Windows.Forms.TextBox();
            this.PnlBotones = new System.Windows.Forms.Panel();
            this.BtnProcesar = new System.Windows.Forms.Button();
            this.TxbLogica = new System.Windows.Forms.TextBox();
            this.TabPaquete = new System.Windows.Forms.TabControl();
            this.TabMetodos = new System.Windows.Forms.TabPage();
            this.DgvMetodos = new System.Windows.Forms.DataGridView();
            this.TabParametros = new System.Windows.Forms.TabControl();
            this.TabParametrosIO = new System.Windows.Forms.TabPage();
            this.DgvVariables = new System.Windows.Forms.DataGridView();
            this.PnlEsctructura.SuspendLayout();
            this.PnlBotones.SuspendLayout();
            this.TabPaquete.SuspendLayout();
            this.TabMetodos.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.DgvMetodos)).BeginInit();
            this.TabParametros.SuspendLayout();
            this.TabParametrosIO.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.DgvVariables)).BeginInit();
            this.SuspendLayout();
            // 
            // PnlEsctructura
            // 
            this.PnlEsctructura.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.PnlEsctructura.Controls.Add(this.LblEsquema);
            this.PnlEsctructura.Controls.Add(this.CbxEsquema);
            this.PnlEsctructura.Controls.Add(this.LblNombre);
            this.PnlEsctructura.Controls.Add(this.TbxNombre);
            this.PnlEsctructura.Dock = System.Windows.Forms.DockStyle.Top;
            this.PnlEsctructura.Location = new System.Drawing.Point(0, 0);
            this.PnlEsctructura.Name = "PnlEsctructura";
            this.PnlEsctructura.Size = new System.Drawing.Size(1208, 103);
            this.PnlEsctructura.TabIndex = 12;
            // 
            // LblEsquema
            // 
            this.LblEsquema.AutoSize = true;
            this.LblEsquema.Location = new System.Drawing.Point(10, 25);
            this.LblEsquema.Name = "LblEsquema";
            this.LblEsquema.Size = new System.Drawing.Size(77, 20);
            this.LblEsquema.TabIndex = 11;
            this.LblEsquema.Text = "Esquema";
            // 
            // CbxEsquema
            // 
            this.CbxEsquema.FormattingEnabled = true;
            this.CbxEsquema.Location = new System.Drawing.Point(94, 18);
            this.CbxEsquema.Name = "CbxEsquema";
            this.CbxEsquema.Size = new System.Drawing.Size(277, 28);
            this.CbxEsquema.TabIndex = 10;
            // 
            // LblNombre
            // 
            this.LblNombre.AutoSize = true;
            this.LblNombre.Location = new System.Drawing.Point(10, 49);
            this.LblNombre.Name = "LblNombre";
            this.LblNombre.Size = new System.Drawing.Size(65, 20);
            this.LblNombre.TabIndex = 5;
            this.LblNombre.Text = "Nombre";
            // 
            // TbxNombre
            // 
            this.TbxNombre.Location = new System.Drawing.Point(94, 49);
            this.TbxNombre.Name = "TbxNombre";
            this.TbxNombre.Size = new System.Drawing.Size(529, 26);
            this.TbxNombre.TabIndex = 4;
            // 
            // PnlBotones
            // 
            this.PnlBotones.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.PnlBotones.Controls.Add(this.BtnProcesar);
            this.PnlBotones.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.PnlBotones.Location = new System.Drawing.Point(0, 1051);
            this.PnlBotones.Name = "PnlBotones";
            this.PnlBotones.Size = new System.Drawing.Size(1208, 57);
            this.PnlBotones.TabIndex = 19;
            // 
            // BtnProcesar
            // 
            this.BtnProcesar.Location = new System.Drawing.Point(1050, 8);
            this.BtnProcesar.Name = "BtnProcesar";
            this.BtnProcesar.Size = new System.Drawing.Size(141, 43);
            this.BtnProcesar.TabIndex = 0;
            this.BtnProcesar.Text = "Procesar";
            this.BtnProcesar.UseVisualStyleBackColor = true;
            this.BtnProcesar.Click += new System.EventHandler(this.BtnProcesar_Click);
            // 
            // TxbLogica
            // 
            this.TxbLogica.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.TxbLogica.Location = new System.Drawing.Point(0, 738);
            this.TxbLogica.Multiline = true;
            this.TxbLogica.Name = "TxbLogica";
            this.TxbLogica.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.TxbLogica.Size = new System.Drawing.Size(1208, 313);
            this.TxbLogica.TabIndex = 18;
            // 
            // TabPaquete
            // 
            this.TabPaquete.Controls.Add(this.TabMetodos);
            this.TabPaquete.Dock = System.Windows.Forms.DockStyle.Top;
            this.TabPaquete.Location = new System.Drawing.Point(0, 103);
            this.TabPaquete.Name = "TabPaquete";
            this.TabPaquete.SelectedIndex = 0;
            this.TabPaquete.Size = new System.Drawing.Size(1208, 294);
            this.TabPaquete.TabIndex = 20;
            // 
            // TabMetodos
            // 
            this.TabMetodos.Controls.Add(this.DgvMetodos);
            this.TabMetodos.Location = new System.Drawing.Point(4, 29);
            this.TabMetodos.Name = "TabMetodos";
            this.TabMetodos.Padding = new System.Windows.Forms.Padding(3);
            this.TabMetodos.Size = new System.Drawing.Size(1200, 261);
            this.TabMetodos.TabIndex = 0;
            this.TabMetodos.Text = "Metodo";
            this.TabMetodos.UseVisualStyleBackColor = true;
            // 
            // DgvMetodos
            // 
            this.DgvMetodos.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DgvMetodos.Dock = System.Windows.Forms.DockStyle.Fill;
            this.DgvMetodos.Location = new System.Drawing.Point(3, 3);
            this.DgvMetodos.Name = "DgvMetodos";
            this.DgvMetodos.RowHeadersWidth = 62;
            this.DgvMetodos.RowTemplate.Height = 28;
            this.DgvMetodos.Size = new System.Drawing.Size(1194, 255);
            this.DgvMetodos.TabIndex = 18;
            this.DgvMetodos.CellValueChanged += new System.Windows.Forms.DataGridViewCellEventHandler(this.DgvMetodos_CellValueChanged);
            this.DgvMetodos.UserAddedRow += new System.Windows.Forms.DataGridViewRowEventHandler(this.DgvMetodos_UserAddedRow);
            // 
            // TabParametros
            // 
            this.TabParametros.Controls.Add(this.TabParametrosIO);
            this.TabParametros.Dock = System.Windows.Forms.DockStyle.Fill;
            this.TabParametros.Location = new System.Drawing.Point(0, 397);
            this.TabParametros.Name = "TabParametros";
            this.TabParametros.SelectedIndex = 0;
            this.TabParametros.Size = new System.Drawing.Size(1208, 341);
            this.TabParametros.TabIndex = 21;
            // 
            // TabParametrosIO
            // 
            this.TabParametrosIO.Controls.Add(this.DgvVariables);
            this.TabParametrosIO.Location = new System.Drawing.Point(4, 29);
            this.TabParametrosIO.Name = "TabParametrosIO";
            this.TabParametrosIO.Padding = new System.Windows.Forms.Padding(3);
            this.TabParametrosIO.Size = new System.Drawing.Size(1200, 308);
            this.TabParametrosIO.TabIndex = 0;
            this.TabParametrosIO.Text = "Parametros";
            this.TabParametrosIO.UseVisualStyleBackColor = true;
            // 
            // DgvVariables
            // 
            this.DgvVariables.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.DgvVariables.Dock = System.Windows.Forms.DockStyle.Fill;
            this.DgvVariables.Location = new System.Drawing.Point(3, 3);
            this.DgvVariables.Name = "DgvVariables";
            this.DgvVariables.RowHeadersWidth = 62;
            this.DgvVariables.RowTemplate.Height = 28;
            this.DgvVariables.Size = new System.Drawing.Size(1194, 302);
            this.DgvVariables.TabIndex = 19;
            this.DgvVariables.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.DgvVariables_CellEndEdit);
            this.DgvVariables.CurrentCellChanged += new System.EventHandler(this.DgvVariables_CurrentCellChanged);
            this.DgvVariables.RowLeave += new System.Windows.Forms.DataGridViewCellEventHandler(this.DgvVariables_RowLeave);
            this.DgvVariables.UserAddedRow += new System.Windows.Forms.DataGridViewRowEventHandler(this.DgvVariables_UserAddedRow);
            this.DgvVariables.Enter += new System.EventHandler(this.DgvVariables_Enter);
            this.DgvVariables.Leave += new System.EventHandler(this.DgvVariables_Leave);
            // 
            // crearpaquete
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1208, 1108);
            this.Controls.Add(this.TabParametros);
            this.Controls.Add(this.TabPaquete);
            this.Controls.Add(this.TxbLogica);
            this.Controls.Add(this.PnlBotones);
            this.Controls.Add(this.PnlEsctructura);
            this.Name = "crearpaquete";
            this.Text = "crearpaquete";
            this.Load += new System.EventHandler(this.crearpaquete_Load);
            this.PnlEsctructura.ResumeLayout(false);
            this.PnlEsctructura.PerformLayout();
            this.PnlBotones.ResumeLayout(false);
            this.TabPaquete.ResumeLayout(false);
            this.TabMetodos.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.DgvMetodos)).EndInit();
            this.TabParametros.ResumeLayout(false);
            this.TabParametrosIO.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.DgvVariables)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel PnlEsctructura;
        private System.Windows.Forms.Label LblEsquema;
        private System.Windows.Forms.ComboBox CbxEsquema;
        private System.Windows.Forms.Label LblNombre;
        private System.Windows.Forms.TextBox TbxNombre;
        private System.Windows.Forms.Panel PnlBotones;
        private System.Windows.Forms.Button BtnProcesar;
        private System.Windows.Forms.TextBox TxbLogica;
        private System.Windows.Forms.TabControl TabPaquete;
        private System.Windows.Forms.TabPage TabMetodos;
        private System.Windows.Forms.TabControl TabParametros;
        private System.Windows.Forms.TabPage TabParametrosIO;
        private System.Windows.Forms.DataGridView DgvMetodos;
        private System.Windows.Forms.DataGridView DgvVariables;
    }
}