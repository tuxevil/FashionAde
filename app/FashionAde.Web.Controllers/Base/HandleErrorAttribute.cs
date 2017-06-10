using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;

namespace FashionAde.Web.Controllers
{
    public class HandleErrorAttribute : System.Web.Mvc.HandleErrorAttribute
    {
        public override void OnException(ExceptionContext context)
        {
            LogException(context.Exception);
            base.OnException(context);
        }

        private static void LogException(Exception e)
        {
            log4net.LogManager.GetLogger(typeof(HandleErrorAttribute).Namespace).Error(e);
        }
    }
}
