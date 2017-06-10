using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;

namespace FashionAde.Web.Controllers
{
    public sealed class CustomOutputCacheAttribute : OutputCacheAttribute
    {
        public CustomOutputCacheAttribute()
        {
            VaryByParam = "none";
            Duration = 3600;
            VaryByCustom = "user";
        }
    }

}
