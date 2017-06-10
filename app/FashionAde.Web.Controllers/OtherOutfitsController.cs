using System.Web.Mvc;
using System.Web.Security;

namespace FashionAde.Web.Controllers
{
    [HandleError]
    public class OtherOutfitsController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
