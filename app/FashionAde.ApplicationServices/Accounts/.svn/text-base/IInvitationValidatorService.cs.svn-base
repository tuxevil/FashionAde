using FashionAde.Core.Accounts;

namespace FashionAde.ApplicationServices
{
    /// <summary>
    /// Validates an invitation.
    /// </summary>
    public interface IInvitationValidatorService
    {
        bool MailExists(string emailAdress);
        bool IsValidCode(string invitationCode);
        bool IsValidCode(InvitationCode invitationCode);
    }
}
