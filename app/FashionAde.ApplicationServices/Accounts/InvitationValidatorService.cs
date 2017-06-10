using System.Collections.Generic;
using FashionAde.Core.Accounts;
using FashionAde.Core.DataInterfaces;

namespace FashionAde.ApplicationServices
{
    public class InvitationValidatorService : IInvitationValidatorService
    {
        private readonly IInvitationCodeRepository _invitationCodeRepository;

        public InvitationValidatorService(IInvitationCodeRepository invitationCodeRepository)
        {
            _invitationCodeRepository = invitationCodeRepository;
        }

        public bool MailExists(string emailAdress)
        {
            IDictionary<string, object> propertyValues = new Dictionary<string, object> { { "EmailAddress", emailAdress.Trim() } };
            return (_invitationCodeRepository.FindAll(propertyValues).Count != 0);
        }

        public bool IsValidCode(string invitationCode)
        {
            IDictionary<string, object> propertyValues = new Dictionary<string, object> {{"Code", invitationCode}};
            InvitationCode ic = _invitationCodeRepository.FindOne(propertyValues);
            return IsValidCode(ic);
        }

        public bool IsValidCode(InvitationCode invitationCode)
        {
            return
                invitationCode != null
                && _invitationCodeRepository.Get(invitationCode.Id) != null
                && !invitationCode.IsUsed;
        }
    }
}
