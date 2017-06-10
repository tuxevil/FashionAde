using FashionAde.Core.Accounts;

namespace FashionAde.ApplicationServices
{
    /// <summary>
    /// Generates an invitation to use the system.
    /// </summary>
    public interface IInvitationCodeGeneratorService
    {
        /// <summary>
        /// Generates a new InvitationCode.
        /// </summary>
        /// <param name="emailAdress">Emails Adress</param>
        /// <returns>The generated InvitationCode.</returns>
        InvitationCode Generate(string emailAdress);
        
        /// <summary>
        /// Generates a new InvitationCode.
        /// </summary>
        /// <param name="emailAdress">Email Adress.</param>
        /// <param name="invitedBy">BasicUser that invited the user.</param>
        /// <param name="registrationCode">Already generated InvitationCode.</param>
        /// <returns>The generated InvitationCode.</returns>
        InvitationCode Generate(string emailAdress, BasicUser invitedBy, string registrationCode);
    }
}
