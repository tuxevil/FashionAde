using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FashionAde.Core.Services
{
    public interface IPublicClosetService
    {
        IList<PublicCloset> FindPublicClosets(FashionFlavor flavor, string zipCode, string userName);
    }
}
