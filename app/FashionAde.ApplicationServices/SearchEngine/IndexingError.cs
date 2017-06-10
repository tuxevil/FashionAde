using System;

namespace FashionAde.ApplicationServices.SearchEngine
{
    public class IndexingError
    {
        public IndexingError(SearchEngineEntry entry, Exception exception)
        {
            Entry = entry;
            Exception = exception;
        }

        public SearchEngineEntry Entry { get; set; }
        public Exception Exception { get; set; }
    }
}