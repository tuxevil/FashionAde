using System.Collections.Generic;

namespace FashionAde.Core.FlavorSelection
{
    public interface IEventSelectionService
    {
        /// <summary>
        /// Determines the best matched events given the user selections.
        /// </summary>
        /// <returns>A list of event types</returns>
        IList<EventType> DetermineEvents();
    }
}