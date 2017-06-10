using System;
using FashionAde.Core.Accounts;
using FashionAde.Core.DataInterfaces;

namespace FashionAde.ApplicationServices
{
    public class InvitationCodeGeneratorService : IInvitationCodeGeneratorService
    {
        private readonly IInvitationCodeRepository _invitationCodeRepository;
        private readonly IInvitationValidatorService _invitationValidatorService;

        public InvitationCodeGeneratorService(IInvitationCodeRepository invitationCodeRepository, IInvitationValidatorService invitationValidatorService)
        {
            _invitationCodeRepository = invitationCodeRepository;
            _invitationValidatorService = invitationValidatorService;
        }

        public InvitationCode Generate(string emailAdress)
        {
            _invitationCodeRepository.DbContext.BeginTransaction();
            InvitationCode ic = Generate(emailAdress, null, Guid.NewGuid().ToString());
            _invitationCodeRepository.DbContext.CommitTransaction();
            return ic;
        }

        public InvitationCode Generate(string emailAdress, BasicUser invitedBy, string registrationCode)
        {
            if (_invitationValidatorService.MailExists(emailAdress))
                throw new MailAlreadyExistsException();

            //Create a new RegistrationCode
            InvitationCode ic = new InvitationCode
            {
                EmailAddress = emailAdress.Trim().ToLower(),
                Code = registrationCode.Trim(),
                InvitedBy = invitedBy
            };

            _invitationCodeRepository.SaveOrUpdate(ic);
            return ic;
        }
    }

    public class MailAlreadyExistsException : Exception { }
}
