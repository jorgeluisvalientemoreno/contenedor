using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using OpenSystems.Windows.Controls;
using KIOSKO.BL;

namespace KIOSKO.UI
{
    public partial class Telefono : OpenForm
    {
        // caso:234
        public String telefono;
        BLGENERAL general = new BLGENERAL();

        public Telefono()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            TxtBox_telefono.Text += "1";
        }

        private void button2_Click(object sender, EventArgs e)
        {
            TxtBox_telefono.Text += "2";
        }

        private void button3_Click(object sender, EventArgs e)
        {
            TxtBox_telefono.Text += "3";
        }

        private void button4_Click(object sender, EventArgs e)
        {
            TxtBox_telefono.Text += "4";
        }

        private void button5_Click(object sender, EventArgs e)
        {
            TxtBox_telefono.Text += "5";
        }

        private void button6_Click(object sender, EventArgs e)
        {
            TxtBox_telefono.Text += "6";
        }

        private void button7_Click(object sender, EventArgs e)
        {
            TxtBox_telefono.Text += "7";
        }

        private void button8_Click(object sender, EventArgs e)
        {
            TxtBox_telefono.Text += "8";
        }

        private void button9_Click(object sender, EventArgs e)
        {
            TxtBox_telefono.Text += "9";
        }

        private void button0_Click(object sender, EventArgs e)
        {
            TxtBox_telefono.Text += "0";
        }

        private void bttn_borrar_Click(object sender, EventArgs e)
        {
            //TxtBox_telefono.ControlRemoved();
            if (TxtBox_telefono.Text.Length !=0) 
            {
                TxtBox_telefono.Text = TxtBox_telefono.Text.Remove(TxtBox_telefono.Text.Length - 1);
            }
            
        }

        private void bttn_aceptar_Click(object sender, EventArgs e)
        {
            if (TxtBox_telefono.Text.Length == 0)
            {
                general.mensajeOk("Debe digitar un numero telefonico");
            }else 
            {
                
                telefono = TxtBox_telefono.Text;
                this.Close();
            }
            
            
        }

        private void Telefono_Load(object sender, EventArgs e)
        {

        }
    }
}
