using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;

namespace FashionAde.Web.Common
{
    [Serializable]
    public class Pager
    {
        private int totalPages;
        private int totalRecords;
        private int pageSize;
        private List<SelectListItem> pages = new List<SelectListItem>();

        public int TotalPages
        {
            get { return totalPages; }
            set { totalPages = value; }
        }

        public List<SelectListItem> Pages
        {
            get { return pages; }
            set { pages = value; }
        }

        public int TotalRecords
        {
            get { return totalRecords; }
            set { totalRecords = value; }
        }

        public int PageSize
        {
            get { return pageSize; }
            set { pageSize = value; }
        }
    }
}
