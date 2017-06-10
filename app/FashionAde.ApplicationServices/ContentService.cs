using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.DataInterfaces;
using FashionAde.Core.ContentManagement;
using FashionAde.Core;

namespace FashionAde.ApplicationServices
{
    public class ContentService : IContentService
    {
        IContentRepository _contentRepository;

        public ContentService(IContentRepository contentRepository)
        {
            _contentRepository = contentRepository;
        }

        public Content Create(string title, string body, string keyWords, string userFriendlyTitle, ContentCategory category, ContentType contentType, Publisher publisher, IList<FashionFlavor> flavors)
        {
            Content c = new Content();            
            c.Title = title;
            c.Body = body;
            c.Type = contentType;
            c.Keywords = keyWords;
            c.Category = category;            
                                               
            foreach (FashionFlavor ff in flavors)
                c.AddFlavor(ff);

            _contentRepository.SaveOrUpdate(c);            
            return c;
        }

        public void Edit(int id, string title, string body, string keyWords, ContentCategory category, ContentType contentType, ContentStatus status, Publisher publisher, IList<FashionFlavor> falvors)
        {
        
        }

        public Content Get(ContentType contentType)
        {
            throw new NotImplementedException();
        }

        public Content GetByCategory(int category)
        {
            throw new NotImplementedException();
        }

        public string GetRandomPromo(Array flavors)
        {
            throw new NotImplementedException();
        }

        public IList<Content> List(int contentCat, ContentType contentType, Array flavors)
        {
            throw new NotImplementedException();
        }

        public Content Approve(int id)
        {
            Content c = _contentRepository.Get(id);
            c.Approve();
            return c;
        }

        public Content Disable(int id)
        {
            Content c = _contentRepository.Get(id);
            c.Disable(); 
            return c;
        }
    }
}
