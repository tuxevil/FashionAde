using System.Collections.Generic;
using FashionAde.Core.Accounts;

namespace FashionAde.Core.DataInterfaces
{
    public interface IContactRetrievalService
    {
        IList<IExchangeContact> Retrieve();
        void RequestAccess();
    }
}