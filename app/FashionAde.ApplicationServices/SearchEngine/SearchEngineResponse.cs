using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FashionAde.ApplicationServices.SearchEngine
{
    public class SearchEngineResponse
    {
        public IEnumerable<SearchEngineResult> Results { get; set; }
        public int TotalCount { get; set; }
    }
}
