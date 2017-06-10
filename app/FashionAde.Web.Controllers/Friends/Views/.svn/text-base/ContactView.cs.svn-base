using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ContactProvider;
using System.ComponentModel.DataAnnotations;

namespace FashionAde.Web.Controllers.MVCInteraction
{
    public class ContactView
    {
        public ContactView()
        {
            SelectedAll = false;
        }

        public int TotalCount { get; set; }
        public string Provider { get; set; }
        public string ProviderImg { get; set; }
        public string ProviderName { get; set; }

        public string SelectedIndexes { get; set; }
        public bool SelectedAll { get; set; }

        [StringLength(512)]
        public string Comments { get; set; }
        
        public IList<IContact> Contacts { get; set; }
    }
}
