using System.Net.Mail;

namespace FashionAde.WebAdmin.Controllers
{
    public interface ISmtpClient
    {
        void Send(MailMessage mailMessage);
    }
}