namespace CONTROLDESARROLLO.UI
{
    partial class valimpcodigo
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
            this.pnlListaArchivos = new System.Windows.Forms.Panel();
            this.TxtCodigo = new System.Windows.Forms.TextBox();
            this.obValidar = new OpenSystems.Windows.Controls.OpenButton();
            this.panel1 = new System.Windows.Forms.Panel();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tpHomologacion = new System.Windows.Forms.TabPage();
            this.obReemplazarTodo = new System.Windows.Forms.Button();
            this.dgvHomologacion = new System.Windows.Forms.DataGridView();
            this.servicioorigen = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cantidadorigen = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.serviciohomologado = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.reemplazarservicio = new System.Windows.Forms.DataGridViewButtonColumn();
            this.lbxContenidoArchivo = new System.Windows.Forms.ListBox();
            this.tpDependencia = new System.Windows.Forms.TabPage();
            this.dgvDependencia = new System.Windows.Forms.DataGridView();
            this.dataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.pnlListaArchivos.SuspendLayout();
            this.panel1.SuspendLayout();
            this.tabControl1.SuspendLayout();
            this.tpHomologacion.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvHomologacion)).BeginInit();
            this.tpDependencia.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDependencia)).BeginInit();
            this.SuspendLayout();
            // 
            // pnlListaArchivos
            // 
            this.pnlListaArchivos.Controls.Add(this.TxtCodigo);
            this.pnlListaArchivos.Controls.Add(this.obValidar);
            this.pnlListaArchivos.Dock = System.Windows.Forms.DockStyle.Top;
            this.pnlListaArchivos.Location = new System.Drawing.Point(0, 0);
            this.pnlListaArchivos.Margin = new System.Windows.Forms.Padding(5);
            this.pnlListaArchivos.Name = "pnlListaArchivos";
            this.pnlListaArchivos.Size = new System.Drawing.Size(1669, 668);
            this.pnlListaArchivos.TabIndex = 66;
            // 
            // TxtCodigo
            // 
            this.TxtCodigo.Dock = System.Windows.Forms.DockStyle.Fill;
            this.TxtCodigo.Location = new System.Drawing.Point(0, 0);
            this.TxtCodigo.Multiline = true;
            this.TxtCodigo.Name = "TxtCodigo";
            this.TxtCodigo.Size = new System.Drawing.Size(1669, 634);
            this.TxtCodigo.TabIndex = 63;
            // 
            // obValidar
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.obValidar.Appearance = appearance1;
            this.obValidar.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.obValidar.Location = new System.Drawing.Point(0, 634);
            this.obValidar.Margin = new System.Windows.Forms.Padding(5);
            this.obValidar.Name = "obValidar";
            this.obValidar.Size = new System.Drawing.Size(1669, 34);
            this.obValidar.TabIndex = 62;
            this.obValidar.Text = "Validar";
            this.obValidar.Click += new System.EventHandler(this.obValidar_Click);
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.tabControl1);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 668);
            this.panel1.Margin = new System.Windows.Forms.Padding(5);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(1669, 261);
            this.panel1.TabIndex = 67;
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tpHomologacion);
            this.tabControl1.Controls.Add(this.tpDependencia);
            this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl1.Location = new System.Drawing.Point(0, 0);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(1669, 261);
            this.tabControl1.TabIndex = 0;
            // 
            // tpHomologacion
            // 
            this.tpHomologacion.Controls.Add(this.obReemplazarTodo);
            this.tpHomologacion.Controls.Add(this.dgvHomologacion);
            this.tpHomologacion.Controls.Add(this.lbxContenidoArchivo);
            this.tpHomologacion.Location = new System.Drawing.Point(4, 29);
            this.tpHomologacion.Name = "tpHomologacion";
            this.tpHomologacion.Padding = new System.Windows.Forms.Padding(3);
            this.tpHomologacion.Size = new System.Drawing.Size(1661, 228);
            this.tpHomologacion.TabIndex = 0;
            this.tpHomologacion.Text = "Homologacion";
            this.tpHomologacion.UseVisualStyleBackColor = true;
            // 
            // obReemplazarTodo
            // 
            this.obReemplazarTodo.Location = new System.Drawing.Point(464, 72);
            this.obReemplazarTodo.Name = "obReemplazarTodo";
            this.obReemplazarTodo.Size = new System.Drawing.Size(319, 31);
            this.obReemplazarTodo.TabIndex = 6;
            this.obReemplazarTodo.Text = "Reemplazar Todo";
            this.obReemplazarTodo.UseVisualStyleBackColor = true;
            this.obReemplazarTodo.Visible = false;
            // 
            // dgvHomologacion
            // 
            this.dgvHomologacion.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvHomologacion.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.servicioorigen,
            this.cantidadorigen,
            this.serviciohomologado,
            this.reemplazarservicio});
            this.dgvHomologacion.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvHomologacion.Location = new System.Drawing.Point(3, 3);
            this.dgvHomologacion.Name = "dgvHomologacion";
            this.dgvHomologacion.RowHeadersWidth = 62;
            this.dgvHomologacion.RowTemplate.Height = 28;
            this.dgvHomologacion.Size = new System.Drawing.Size(1655, 222);
            this.dgvHomologacion.TabIndex = 5;
            // 
            // servicioorigen
            // 
            this.servicioorigen.HeaderText = "Servicio Origen";
            this.servicioorigen.MinimumWidth = 8;
            this.servicioorigen.Name = "servicioorigen";
            this.servicioorigen.Width = 150;
            // 
            // cantidadorigen
            // 
            this.cantidadorigen.HeaderText = "Cantidad";
            this.cantidadorigen.MinimumWidth = 8;
            this.cantidadorigen.Name = "cantidadorigen";
            this.cantidadorigen.Width = 150;
            // 
            // serviciohomologado
            // 
            this.serviciohomologado.HeaderText = "Servicio Homologado";
            this.serviciohomologado.MinimumWidth = 8;
            this.serviciohomologado.Name = "serviciohomologado";
            this.serviciohomologado.Width = 150;
            // 
            // reemplazarservicio
            // 
            this.reemplazarservicio.HeaderText = "";
            this.reemplazarservicio.MinimumWidth = 8;
            this.reemplazarservicio.Name = "reemplazarservicio";
            this.reemplazarservicio.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.reemplazarservicio.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            this.reemplazarservicio.Text = "Reemplazar";
            this.reemplazarservicio.UseColumnTextForButtonValue = true;
            this.reemplazarservicio.Width = 150;
            // 
            // lbxContenidoArchivo
            // 
            this.lbxContenidoArchivo.FormattingEnabled = true;
            this.lbxContenidoArchivo.ItemHeight = 20;
            this.lbxContenidoArchivo.Location = new System.Drawing.Point(-4, 14);
            this.lbxContenidoArchivo.Name = "lbxContenidoArchivo";
            this.lbxContenidoArchivo.Size = new System.Drawing.Size(885, 184);
            this.lbxContenidoArchivo.TabIndex = 4;
            // 
            // tpDependencia
            // 
            this.tpDependencia.Controls.Add(this.dgvDependencia);
            this.tpDependencia.Location = new System.Drawing.Point(4, 29);
            this.tpDependencia.Name = "tpDependencia";
            this.tpDependencia.Padding = new System.Windows.Forms.Padding(3);
            this.tpDependencia.Size = new System.Drawing.Size(1661, 228);
            this.tpDependencia.TabIndex = 1;
            this.tpDependencia.Text = "Objetos Dependientes";
            this.tpDependencia.UseVisualStyleBackColor = true;
            // 
            // dgvDependencia
            // 
            this.dgvDependencia.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvDependencia.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.dataGridViewTextBoxColumn1,
            this.dataGridViewTextBoxColumn2});
            this.dgvDependencia.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvDependencia.Location = new System.Drawing.Point(3, 3);
            this.dgvDependencia.Name = "dgvDependencia";
            this.dgvDependencia.RowHeadersWidth = 62;
            this.dgvDependencia.RowTemplate.Height = 28;
            this.dgvDependencia.Size = new System.Drawing.Size(1655, 222);
            this.dgvDependencia.TabIndex = 6;
            // 
            // dataGridViewTextBoxColumn1
            // 
            this.dataGridViewTextBoxColumn1.HeaderText = "Propietario";
            this.dataGridViewTextBoxColumn1.MinimumWidth = 8;
            this.dataGridViewTextBoxColumn1.Name = "dataGridViewTextBoxColumn1";
            this.dataGridViewTextBoxColumn1.Width = 150;
            // 
            // dataGridViewTextBoxColumn2
            // 
            this.dataGridViewTextBoxColumn2.HeaderText = "Objeto";
            this.dataGridViewTextBoxColumn2.MinimumWidth = 8;
            this.dataGridViewTextBoxColumn2.Name = "dataGridViewTextBoxColumn2";
            this.dataGridViewTextBoxColumn2.Width = 150;
            // 
            // valimpcodigo
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(11F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1669, 929);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.pnlListaArchivos);
            this.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.Name = "valimpcodigo";
            this.Text = "Validar Codigo";
            this.pnlListaArchivos.ResumeLayout(false);
            this.pnlListaArchivos.PerformLayout();
            this.panel1.ResumeLayout(false);
            this.tabControl1.ResumeLayout(false);
            this.tpHomologacion.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvHomologacion)).EndInit();
            this.tpDependencia.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvDependencia)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Panel pnlListaArchivos;
        private OpenSystems.Windows.Controls.OpenButton obValidar;
        private System.Windows.Forms.TextBox TxtCodigo;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tpHomologacion;
        private System.Windows.Forms.Button obReemplazarTodo;
        private System.Windows.Forms.DataGridView dgvHomologacion;
        private System.Windows.Forms.DataGridViewTextBoxColumn servicioorigen;
        private System.Windows.Forms.DataGridViewTextBoxColumn cantidadorigen;
        private System.Windows.Forms.DataGridViewTextBoxColumn serviciohomologado;
        private System.Windows.Forms.DataGridViewButtonColumn reemplazarservicio;
        private System.Windows.Forms.ListBox lbxContenidoArchivo;
        private System.Windows.Forms.TabPage tpDependencia;
        private System.Windows.Forms.DataGridView dgvDependencia;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn2;
    }
}