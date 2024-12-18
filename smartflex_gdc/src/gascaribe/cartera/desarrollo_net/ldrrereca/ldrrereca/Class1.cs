using System;
using System.Collections.Generic;
using System.Text;
using OpenSystems.Common.Interfaces;

namespace ldrrereca
{
    public class Class1 : IOpenExecutable
    {
        public void Execute(Dictionary<string, object> parameters)
        {
            using (Form1 form = new Form1())
            {
                form.ShowDialog();
            }
        }
    }
}
