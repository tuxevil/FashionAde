using FashionAde.Core;

namespace FashionAde.ApplicationServices.SearchEngine
{
    public interface IIndexCreationService
    {
        void IndexPendingOutfits(Closet closet);
        void CreateIndexes();
        void CreateIndividualIndex(int closetId);
    }
}