namespace CONTROLDESARROLLO.UI
{
    partial class valimp
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
            this.pnlRutaArchivos = new System.Windows.Forms.Panel();
            this.lblObjeto = new Infragistics.Win.Misc.UltraLabel();
            this.tbObjeto = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.btnBuscaCarpeta = new OpenSystems.Windows.Controls.OpenButton();
            this.lblRutaDirectorio = new Infragistics.Win.Misc.UltraLabel();
            this.tbRutaArchivos = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.pnlListaArchivos = new System.Windows.Forms.Panel();
            this.obValidar = new OpenSystems.Windows.Controls.OpenButton();
            this.lbxArchivos = new System.Windows.Forms.ListBox();
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
            this.pnlRutaArchivos.SuspendLayout();
            this.pnlListaArchivos.SuspendLayout();
            this.panel1.SuspendLayout();
            this.tabControl1.SuspendLayout();
            this.tpHomologacion.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvHomologacion)).BeginInit();
            this.tpDependencia.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvDependencia)).BeginInit();
            this.SuspendLayout();
            // 
            // pnlRutaArchivos
            // 
            this.pnlRutaArchivos.Controls.Add(this.lblObjeto);
            this.pnlRutaArchivos.Controls.Add(this.tbObjeto);
            this.pnlRutaArchivos.Controls.Add(this.btnBuscaCarpeta);
            this.pnlRutaArchivos.Controls.Add(this.lblRutaDirectorio);
            this.pnlRutaArchivos.Controls.Add(this.tbRutaArchivos);
            this.pnlRutaArchivos.Dock = System.Windows.Forms.DockStyle.Top;
            this.pnlRutaArchivos.Location = new System.Drawing.Point(0, 0);
            this.pnlRutaArchivos.Margin = new System.Windows.Forms.Padding(5);
            this.pnlRutaArchivos.Name = "pnlRutaArchivos";
            this.pnlRutaArchivos.Size = new System.Drawing.Size(909, 107);
            this.pnlRutaArchivos.TabIndex = 59;
            // 
            // lblObjeto
            // 
            appearance1.TextHAlign = Infragistics.Win.HAlign.Left;
            this.lblObjeto.Appearance = appearance1;
            this.lblObjeto.Location = new System.Drawing.Point(8, 59);
            this.lblObjeto.Margin = new System.Windows.Forms.Padding(5);
            this.lblObjeto.Name = "lblObjeto";
            this.lblObjeto.Size = new System.Drawing.Size(134, 20);
            this.lblObjeto.TabIndex = 65;
            this.lblObjeto.Text = "Objeto";
            // 
            // tbObjeto
            // 
            this.tbObjeto.Caption = "";
            this.tbObjeto.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbObjeto.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbObjeto.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbObjeto.Length = null;
            this.tbObjeto.TextBoxValue = "";
            this.tbObjeto.Location = new System.Drawing.Point(148, 59);
            this.tbObjeto.Margin = new System.Windows.Forms.Padding(9);
            this.tbObjeto.Name = "tbObjeto";
            this.tbObjeto.Size = new System.Drawing.Size(650, 20);
            this.tbObjeto.TabIndex = 64;
            this.tbObjeto.Leave += new System.EventHandler(this.tbObjeto_Leave);
            // 
            // btnBuscaCarpeta
            // 
            appearance2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance2.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnBuscaCarpeta.Appearance = appearance2;
            this.btnBuscaCarpeta.Location = new System.Drawing.Point(812, 21);
            this.btnBuscaCarpeta.Margin = new System.Windows.Forms.Padding(5);
            this.btnBuscaCarpeta.Name = "btnBuscaCarpeta";
            this.btnBuscaCarpeta.Size = new System.Drawing.Size(68, 37);
            this.btnBuscaCarpeta.TabIndex = 61;
            this.btnBuscaCarpeta.Text = "Ruta";
            this.btnBuscaCarpeta.Click += new System.EventHandler(this.btnCarpeta_Click);
            // 
            // lblRutaDirectorio
            // 
            appearance3.TextHAlign = Infragistics.Win.HAlign.Left;
            this.lblRutaDirectorio.Appearance = appearance3;
            this.lblRutaDirectorio.Location = new System.Drawing.Point(8, 21);
            this.lblRutaDirectorio.Margin = new System.Windows.Forms.Padding(5);
            this.lblRutaDirectorio.Name = "lblRutaDirectorio";
            this.lblRutaDirectorio.Size = new System.Drawing.Size(134, 20);
            this.lblRutaDirectorio.TabIndex = 60;
            this.lblRutaDirectorio.Text = "Ruta Carpeta";
            // 
            // tbRutaArchivos
            // 
            this.tbRutaArchivos.Caption = "";
            this.tbRutaArchivos.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbRutaArchivos.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbRutaArchivos.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbRutaArchivos.Length = null;
            this.tbRutaArchivos.TextBoxValue = "";
            this.tbRutaArchivos.Location = new System.Drawing.Point(148, 21);
            this.tbRutaArchivos.Margin = new System.Windows.Forms.Padding(9);
            this.tbRutaArchivos.Name = "tbRutaArchivos";
            this.tbRutaArchivos.Size = new System.Drawing.Size(650, 20);
            this.tbRutaArchivos.TabIndex = 59;
            this.tbRutaArchivos.Leave += new System.EventHandler(this.tbRutaArchivos_Leave);
            // 
            // pnlListaArchivos
            // 
            this.pnlListaArchivos.Controls.Add(this.obValidar);
            this.pnlListaArchivos.Controls.Add(this.lbxArchivos);
            this.pnlListaArchivos.Dock = System.Windows.Forms.DockStyle.Top;
            this.pnlListaArchivos.Location = new System.Drawing.Point(0, 107);
            this.pnlListaArchivos.Margin = new System.Windows.Forms.Padding(5);
            this.pnlListaArchivos.Name = "pnlListaArchivos";
            this.pnlListaArchivos.Size = new System.Drawing.Size(909, 477);
            this.pnlListaArchivos.TabIndex = 60;
            // 
            // obValidar
            // 
            appearance4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance4.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.obValidar.Appearance = appearance4;
            this.obValidar.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.obValidar.Location = new System.Drawing.Point(0, 444);
            this.obValidar.Margin = new System.Windows.Forms.Padding(5);
            this.obValidar.Name = "obValidar";
            this.obValidar.Size = new System.Drawing.Size(909, 33);
            this.obValidar.TabIndex = 62;
            this.obValidar.Text = "Validar";
            this.obValidar.Click += new System.EventHandler(this.obValidar_Click);
            // 
            // lbxArchivos
            // 
            this.lbxArchivos.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbxArchivos.FormattingEnabled = true;
            this.lbxArchivos.ItemHeight = 20;
            this.lbxArchivos.Location = new System.Drawing.Point(0, 0);
            this.lbxArchivos.Name = "lbxArchivos";
            this.lbxArchivos.Size = new System.Drawing.Size(909, 477);
            this.lbxArchivos.TabIndex = 0;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.tabControl1);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 584);
            this.panel1.Margin = new System.Windows.Forms.Padding(5);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(909, 220);
            this.panel1.TabIndex = 61;
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tpHomologacion);
            this.tabControl1.Controls.Add(this.tpDependencia);
            this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl1.Location = new System.Drawing.Point(0, 0);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(909, 220);
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
            this.tpHomologacion.Size = new System.Drawing.Size(901, 187);
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
            this.dgvHomologacion.RowTemplate.Height = 28;
            this.dgvHomologacion.Size = new System.Drawing.Size(895, 181);
            this.dgvHomologacion.TabIndex = 5;
            // 
            // servicioorigen
            // 
            this.servicioorigen.HeaderText = "Servicio Origen";
            this.servicioorigen.Name = "servicioorigen";
            // 
            // cantidadorigen
            // 
            this.cantidadorigen.HeaderText = "Cantidad";
            this.cantidadorigen.Name = "cantidadorigen";
            // 
            // serviciohomologado
            // 
            this.serviciohomologado.HeaderText = "Servicio Homologado";
            this.serviciohomologado.Name = "serviciohomologado";
            // 
            // reemplazarservicio
            // 
            this.reemplazarservicio.HeaderText = "";
            this.reemplazarservicio.Name = "reemplazarservicio";
            this.reemplazarservicio.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.reemplazarservicio.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            this.reemplazarservicio.Text = "Reemplazar";
            this.reemplazarservicio.UseColumnTextForButtonValue = true;
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
            this.tpDependencia.Size = new System.Drawing.Size(901, 187);
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
            this.dgvDependencia.RowTemplate.Height = 28;
            this.dgvDependencia.Size = new System.Drawing.Size(895, 181);
            this.dgvDependencia.TabIndex = 6;
            // 
            // dataGridViewTextBoxColumn1
            // 
            this.dataGridViewTextBoxColumn1.HeaderText = "Propietario";
            this.dataGridViewTextBoxColumn1.Name = "dataGridViewTextBoxColumn1";
            // 
            // dataGridViewTextBoxColumn2
            // 
            this.dataGridViewTextBoxColumn2.HeaderText = "Objeto";
            this.dataGridViewTextBoxColumn2.Name = "dataGridViewTextBoxColumn2";
            // 
            // valimp
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(11F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(909, 804);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.pnlListaArchivos);
            this.Controls.Add(this.pnlRutaArchivos);
            this.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.Name = "valimp";
            this.Text = "Validar Implementacion";
            this.Load += new System.EventHandler(this.valimp_Load);
            this.pnlRutaArchivos.ResumeLayout(false);
            this.pnlRutaArchivos.PerformLayout();
            this.pnlListaArchivos.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.tabControl1.ResumeLayout(false);
            this.tpHomologacion.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvHomologacion)).EndInit();
            this.tpDependencia.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvDependencia)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pnlRutaArchivos;
        private OpenSystems.Windows.Controls.OpenButton btnBuscaCarpeta;
        private Infragistics.Win.Misc.UltraLabel lblRutaDirectorio;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbRutaArchivos;        
        private System.Windows.Forms.Panel pnlListaArchivos;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.ListBox lbxArchivos;
        private OpenSystems.Windows.Controls.OpenButton obValidar;
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
        private Infragistics.Win.Misc.UltraLabel lblObjeto;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbObjeto;
    }
}