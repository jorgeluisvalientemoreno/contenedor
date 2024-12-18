using System;
using System.Collections.Generic;
using System.Text;

namespace SINCECOMP.FNB.Controls
{
   interface IOpenEnterQueryLocal
   {
      bool IsEnterQueryModeOn { get; }
      string QueryText { get; }
      void SetEnterQueryMode(bool enable);
      void SetEnterQueryOptions(string[] queryOptions);
   }
}
