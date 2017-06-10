using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FashionAde.Core.Accounts;
using FashionAde.Core.ThirdParties;

namespace FashionAde.Core.Services
{
    public interface IUserRegistrationService
    {
        string EmailAddress { get; set; }
        string Password { get; set; }
        string SecurityQuestion { get; set; }
        string SecurityAnswer { get; set; }
        string ZipCode { get; set; }
        string UserSize { get; set; }
        PrivacyLevel privacyLevel { get; set; }
        TemporalUser temporalUser { get; set; }
        RegisteredUser invitedBy { get; set; }
 
        /// <summary>
        /// Registers a new public user into the system.
        /// It will create the closet for the user with the corresponding garments and preexisting combinations.
        /// </summary>
        /// <remarks>The service will copy all relevant information at creation from the temporal user.</remarks>
        /// <returns>A valid registered user</returns>
        PublicUser RegisterPublicUser();

        /// <summary>
        /// Register a new partner user into the system.
        /// It will create the closet for the user with the corresponding garments and preexisting combinations.
        /// </summary>
        /// <remarks>The service will copy all relevant information at creation from the temporal user.</remarks>
        /// <param name="thirdParty">The corresponding Partner to use</param>
        /// <returns>A valid registered user</returns>
        PartnerUser RegisterPartnerUser(Partner thirdParty);
    }
}
