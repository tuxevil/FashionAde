using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.ContentManagement;
using FashionAde.Core;

namespace FashionAde.ApplicationServices
{
    public interface IContentService
    {
        Content Approve(int id);
        Content Disable(int id);        
        Content Create(string title, string body, string keyWords, string userFriendlyTitle, ContentCategory category, ContentType contentType, Publisher publisher, IList<FashionFlavor> falvors);
    }
}
